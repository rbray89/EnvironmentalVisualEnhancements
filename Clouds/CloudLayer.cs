using CommonUtils;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;

namespace Clouds
{
    internal class CloudLayer
    {
        public static Dictionary<String, List<CloudLayer>> BodyDatabase = new Dictionary<string, List<CloudLayer>>();
        private static Shader GlobalCloudShader;
        private static Shader GlobalUndersideCloudShader;
        private Material CloudMaterial;
        private Material UndersideCloudMaterial;
        private float timeDelta = 0;
        private String body;
        private Color color;
        private float radius;
        private TextureSet mainTexture;
        private TextureSet detailTexture;
        private TextureSet bumpTexture;
        private ShaderFloats shaderFloats;
        private ShaderFloats undersideShaderFloats;
        private Overlay CloudOverlay;
        private Overlay UndersideCloudOverlay;

        public TextureSet MainTexture { get { return mainTexture; } }
        public TextureSet DetailTexture { get { return detailTexture; } }
        public TextureSet BumpTexture { get { return bumpTexture; } }
        public Color Color { get { return color; } }
        public float Radius { get { return radius; } }
        public ShaderFloats ShaderFloats { get { return shaderFloats; } }
        public ShaderFloats UndersideShaderFloats { get { return undersideShaderFloats; } }

        internal void ApplyGUIUpdate(CloudGUI cloudGUI)
        {
            mainTexture.Clone(cloudGUI.MainTexture);
            detailTexture.Clone(cloudGUI.DetailTexture);
            bumpTexture.Clone(cloudGUI.BumpTexture);
            shaderFloats.Clone(cloudGUI.ShaderFloats);
            undersideShaderFloats.Clone(cloudGUI.UndersideShaderFloats);
            radius = cloudGUI.Radius.RadiusF;
            CloudOverlay.UpdateRadius(radius);
            UndersideCloudOverlay.UpdateRadius(radius);
            color = cloudGUI.Color.Color;
            UpdateTextures();
            UpdateFloats();
        }

        public CloudLayer(String body, Color color, float radius,
            TextureSet mainTexture,
            TextureSet detailTexture,
            TextureSet bumpTexture,
            ShaderFloats ShaderFloats,
            ShaderFloats UndersideShaderFloats)
        {
            if (!BodyDatabase.ContainsKey(body))
            {
                BodyDatabase.Add(body, new List<CloudLayer>());
            }
            BodyDatabase[body].Add(this);
            this.body = body;
            this.color = color;
            this.radius = radius;
            this.mainTexture = mainTexture;

            this.detailTexture = detailTexture;
            this.bumpTexture = bumpTexture;

            this.shaderFloats = ShaderFloats;
            this.undersideShaderFloats = UndersideShaderFloats;
            Init();
        }

        private void UpdateTextures()
        {
            CloudMaterial.SetTexture("_MainTex", mainTexture.Texture);
            CloudMaterial.SetColor("_Color", color);

            UndersideCloudMaterial.SetTexture("_MainTex", mainTexture.Texture);
            UndersideCloudMaterial.SetColor("_Color", color);

            if (detailTexture.InUse)
            {
                CloudMaterial.SetTexture("_DetailTex", detailTexture.Texture);
                CloudMaterial.SetFloat("_DetailScale", detailTexture.Scale);
                UndersideCloudMaterial.SetTexture("_DetailTex", detailTexture.Texture);
                UndersideCloudMaterial.SetFloat("_DetailScale", detailTexture.Scale);
            }

            if (bumpTexture.InUse)
            {
                CloudMaterial.SetTexture("_BumpMap", bumpTexture.Texture);
                CloudMaterial.SetFloat("_BumpScale", bumpTexture.Scale);
                UndersideCloudMaterial.SetTexture("_BumpMap", bumpTexture.Texture);
                UndersideCloudMaterial.SetFloat("_BumpScale", bumpTexture.Scale);
            }
        }

        public void Init()
        {
            if (GlobalCloudShader == null)
            {
                Utils.Log("Initializing Textures");
                Assembly assembly = Assembly.GetExecutingAssembly();
                StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Clouds.CompiledCloudShader.txt"));
                Utils.Log("reading stream...");
                String shaderTxt = shaderStreamReader.ReadToEnd();
                GlobalCloudShader = new Material(shaderTxt).shader;

                shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Clouds.CompiledUndersideCloudShader.txt"));
                Utils.Log("reading stream...");
                shaderTxt = shaderStreamReader.ReadToEnd();
                GlobalUndersideCloudShader = new Material(shaderTxt).shader;
            }
            CloudMaterial = new Material(GlobalCloudShader);
            UndersideCloudMaterial = new Material(GlobalUndersideCloudShader);

            UpdateFloats();

            Log("Cloud Material initialized");
            UpdateTextures();
            Log("Generating Overlay...");
            CloudOverlay = Overlay.GeneratePlanetOverlay(body, radius, CloudMaterial, this.mainTexture.StartOffset, Utils.OVER_LAYER, true);
            UndersideCloudOverlay = Overlay.GeneratePlanetOverlay(body, radius, UndersideCloudMaterial, this.mainTexture.StartOffset, Utils.UNDER_LAYER, true);
            Log("Textures initialized");
        }

        public void UpdateFloats()
        {
            if (this.shaderFloats != null)
            {
                CloudMaterial.SetFloat("_FalloffPow", shaderFloats.FalloffPower);
                CloudMaterial.SetFloat("_FalloffScale", shaderFloats.FalloffScale);
                CloudMaterial.SetFloat("_DetailDist", shaderFloats.DetailDistance);
                CloudMaterial.SetFloat("_MinLight", shaderFloats.MinimumLight);
            }
            else
            {
                this.shaderFloats = new ShaderFloats(CloudMaterial.GetFloat("_FalloffPow"), CloudMaterial.GetFloat("_FalloffScale"), CloudMaterial.GetFloat("_DetailDist"), CloudMaterial.GetFloat("_MinLight"));
            }
            if (this.undersideShaderFloats != null)
            {
                UndersideCloudMaterial.SetFloat("_FalloffPow", undersideShaderFloats.FalloffPower);
                UndersideCloudMaterial.SetFloat("_FalloffScale", undersideShaderFloats.FalloffScale);
                UndersideCloudMaterial.SetFloat("_DetailDist", undersideShaderFloats.DetailDistance);
                UndersideCloudMaterial.SetFloat("_MinLight", undersideShaderFloats.MinimumLight);
            }
            else
            {
                this.undersideShaderFloats = new ShaderFloats(UndersideCloudMaterial.GetFloat("_FalloffPow"), UndersideCloudMaterial.GetFloat("_FalloffScale"), UndersideCloudMaterial.GetFloat("_DetailDist"), UndersideCloudMaterial.GetFloat("_MinLight"));
            }
        }

        private void updateOffset(float time)
        {
            float rateOffset = time;

            mainTexture.UpdateOffset(rateOffset, true);
            CloudOverlay.UpdateRotation(mainTexture.Offset);
            UndersideCloudOverlay.UpdateRotation(mainTexture.Offset);

            if (detailTexture.InUse)
            {
                detailTexture.UpdateOffset(rateOffset, false);
                CloudMaterial.SetVector("_DetailOffset", detailTexture.Offset);
                UndersideCloudMaterial.SetVector("_DetailOffset", detailTexture.Offset);
            }

            if (bumpTexture.InUse)
            {
                bumpTexture.UpdateOffset(rateOffset, false);
                CloudMaterial.SetVector("_BumpOffset", bumpTexture.Offset);
                UndersideCloudMaterial.SetVector("_BumpOffset", bumpTexture.Offset);
            }

        }

        public void PerformUpdate()
        {
            timeDelta = Time.time - timeDelta;
            float timeOffset = timeDelta * TimeWarp.CurrentRate;

            updateOffset(timeOffset);

            timeDelta = Time.time;
        }

        public static void Log(String message)
        {
            UnityEngine.Debug.Log("Clouds: " + message);
        }

        public static int GetBodyLayerCount(string p)
        {
            if (BodyDatabase.ContainsKey(p))
            {
                return BodyDatabase[p].Count;
            }
            else
            {
                return 0;
            }
        }

        public static String[] GetBodyLayerStringList(string p)
        {
            if (BodyDatabase.ContainsKey(p))
            {
                int count = BodyDatabase[p].Count;
                String[] layerList = new String[count];
                for (int i = 0; i < count; i++)
                {
                    layerList[i] = "Layer " + i;
                }
                return layerList;
            }
            else
            {
                return new String[0];
            }
        }


        internal static void RemoveLayer(string body, int SelectedLayer)
        {
            if (BodyDatabase.ContainsKey(body))
            {
                CloudLayer layer = BodyDatabase[body][SelectedLayer];
                layer.Remove();
            }
        }

        internal static bool IsDefaultShaderFloat(ShaderFloats shaderFloats, bool isUnderside = false)
        {
            Material compareMaterial;
            if (isUnderside)
            {
                compareMaterial = new Material(GlobalUndersideCloudShader);
            }
            else
            {
                compareMaterial = new Material(GlobalCloudShader);
            }
            if (shaderFloats.FalloffPower == compareMaterial.GetFloat("_FalloffPow") &&
                shaderFloats.FalloffScale == compareMaterial.GetFloat("_FalloffScale") &&
                shaderFloats.DetailDistance == compareMaterial.GetFloat("_DetailDist") &&
                shaderFloats.MinimumLight == compareMaterial.GetFloat("_MinLight"))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        internal void Remove()
        {
            this.CloudOverlay.RemoveOverlay();
            this.UndersideCloudOverlay.RemoveOverlay();
            BodyDatabase[body].Remove(this);
        }
    }
}
