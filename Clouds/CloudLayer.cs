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
        public static List<CloudLayer> Layers = new List<CloudLayer>();
        private static Shader GlobalCloudShader;
        private Material CloudMaterial;
        private Material PQSCloudMaterial;
        private float timeDelta = 0;
        private String body;
        private Color color;
        private float altitude;
        private TextureSet mainTexture;
        private TextureSet detailTexture;
        private TextureSet bumpTexture;
        private ShaderFloats shaderFloats;
        private ShaderFloats PQSshaderFloats;
        private Overlay CloudOverlay;

        public TextureSet MainTexture { get { return mainTexture; } }
        public TextureSet DetailTexture { get { return detailTexture; } }
        public TextureSet BumpTexture { get { return bumpTexture; } }
        public Color Color { get { return color; } }
        public float Altitude { get { return altitude; } }
        public ShaderFloats ShaderFloats { get { return shaderFloats; } }
        public ShaderFloats PQSShaderFloats { get { return PQSshaderFloats; } }

        internal void ApplyGUIUpdate(CloudGUI cloudGUI)
        {
            mainTexture.Clone(cloudGUI.MainTexture);
            detailTexture.Clone(cloudGUI.DetailTexture);
            bumpTexture.Clone(cloudGUI.BumpTexture);
            shaderFloats.Clone(cloudGUI.ShaderFloats);
            PQSshaderFloats.Clone(cloudGUI.PQSShaderFloats);
            altitude = cloudGUI.Altitude.AltitudeF;
            color = cloudGUI.Color.Color;
            UpdateTextures();
            UpdateFloats();
            CloudOverlay.UpdateAltitude(altitude);
        }

        public CloudLayer(String body, Color color, float altitude,
            TextureSet mainTexture,
            TextureSet detailTexture,
            TextureSet bumpTexture,
            ShaderFloats ShaderFloats,
            ShaderFloats PQSShaderFloats)
        {
            if (!BodyDatabase.ContainsKey(body))
            {
                BodyDatabase.Add(body, new List<CloudLayer>());
            }
            BodyDatabase[body].Add(this);
            this.body = body;
            this.color = color;
            this.altitude = altitude;
            this.mainTexture = mainTexture;

            this.detailTexture = detailTexture;
            this.bumpTexture = bumpTexture;

            this.shaderFloats = ShaderFloats;
            this.PQSshaderFloats = PQSShaderFloats;
            Init();
        }

        private void UpdateTextures()
        {
            CloudMaterial.SetTexture("_MainTex", mainTexture.Texture);
            PQSCloudMaterial.SetTexture("_MainTex", mainTexture.Texture);
            CloudMaterial.SetColor("_Color", color);
            PQSCloudMaterial.SetColor("_Color", color);

            if (detailTexture.InUse)
            {
                CloudMaterial.SetTexture("_DetailTex", detailTexture.Texture);
                PQSCloudMaterial.SetTexture("_DetailTex", detailTexture.Texture);
                CloudMaterial.SetFloat("_DetailScale", detailTexture.Scale);
                PQSCloudMaterial.SetFloat("_DetailScale", detailTexture.Scale);
            }

            if (bumpTexture.InUse)
            {
                CloudMaterial.SetTexture("_BumpMap", bumpTexture.Texture);
                PQSCloudMaterial.SetTexture("_BumpMap", bumpTexture.Texture);
                CloudMaterial.SetFloat("_BumpScale", bumpTexture.Scale);
                PQSCloudMaterial.SetFloat("_BumpScale", bumpTexture.Scale);
            }
        }

        public void Init()
        {
            if (GlobalCloudShader == null)
            {
                Utils.Log("Initializing Textures");
                Assembly assembly = Assembly.GetExecutingAssembly();
                StreamReader shaderStreamReader;
                if(Utils.IsCubicMapped)
                {
                    shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Clouds.Shaders.Compiled-CubicCloud.shader"));
                }
                else
                {
                    shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Clouds.Shaders.Compiled-SphereCloud.shader"));
                }
                Utils.Log("reading stream...");
                String shaderTxt = shaderStreamReader.ReadToEnd();
                GlobalCloudShader = new Material(shaderTxt).shader;
                
            }
            CloudMaterial = new Material(GlobalCloudShader);
            PQSCloudMaterial = new Material(GlobalCloudShader);
            
            Log("Cloud Material initialized");
            UpdateTextures();
            Log("Generating Overlay...");
            CloudOverlay = Overlay.GeneratePlanetOverlay(body, altitude, CloudMaterial, PQSCloudMaterial, this.mainTexture.StartOffset);
            
            UpdateFloats();
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
                CloudMaterial.SetFloat("_FadeDist", shaderFloats.FadeDistance);
                CloudMaterial.SetFloat("_FadeScale", 0.1f/ shaderFloats.FadeDistance);
            }
            else
            {
                this.shaderFloats = new ShaderFloats(CloudMaterial.GetFloat("_FalloffPow"), CloudMaterial.GetFloat("_FalloffScale"), CloudMaterial.GetFloat("_DetailDist"), CloudMaterial.GetFloat("_MinLight"), CloudMaterial.GetFloat("_FadeDist"));
            }
            if (this.PQSshaderFloats != null)
            {
                PQSCloudMaterial.SetFloat("_FalloffPow", PQSshaderFloats.FalloffPower);
                PQSCloudMaterial.SetFloat("_FalloffScale", PQSshaderFloats.FalloffScale);
                PQSCloudMaterial.SetFloat("_DetailDist", PQSshaderFloats.DetailDistance);
                PQSCloudMaterial.SetFloat("_MinLight", PQSshaderFloats.MinimumLight);
                PQSCloudMaterial.SetFloat("_FadeDist", PQSshaderFloats.FadeDistance);
                PQSCloudMaterial.SetFloat("_FadeScale", 0.1f/PQSshaderFloats.FadeDistance);
            }
            else
            {
                this.PQSshaderFloats = new ShaderFloats(PQSCloudMaterial.GetFloat("_FalloffPow"), PQSCloudMaterial.GetFloat("_FalloffScale"), PQSCloudMaterial.GetFloat("_DetailDist"), PQSCloudMaterial.GetFloat("_MinLight"), PQSCloudMaterial.GetFloat("_FadeDist"));
            }
            
        }

        private void updateOffset(float time)
        {
            float rateOffset = time;

            mainTexture.UpdateOffset(rateOffset, true);
            CloudOverlay.UpdateRotation(mainTexture.Offset);

            if (detailTexture.InUse)
            {
                detailTexture.UpdateOffset(rateOffset, false);
                CloudMaterial.SetVector("_DetailOffset", detailTexture.Offset);
                PQSCloudMaterial.SetVector("_DetailOffset", detailTexture.Offset);
            }

            if (bumpTexture.InUse)
            {
                bumpTexture.UpdateOffset(rateOffset, false);
                CloudMaterial.SetVector("_BumpOffset", bumpTexture.Offset);
                PQSCloudMaterial.SetVector("_BumpOffset", bumpTexture.Offset);
            }

        }

        public void PerformUpdate()
        {
            timeDelta = Time.time - timeDelta;
            float timeRate = TimeWarp.CurrentRate == 0 ? 1 : TimeWarp.CurrentRate;
            float timeOffset = timeDelta * timeRate;

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

        internal static bool IsDefaultShaderFloat(ShaderFloats shaderFloats)
        {
            Material compareMaterial;
            
            compareMaterial = new Material(GlobalCloudShader);
            
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

        internal void Remove(bool fromList = true)
        {
            this.CloudOverlay.RemoveOverlay();
            BodyDatabase[body].Remove(this);
            if (fromList)
            {
                Layers.Remove(this);
            }
        }
    }
}
