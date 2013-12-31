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
        private float timeDelta = 0;
        private String body;
        private Color color;
        private float radius;
        private TextureSet mainTexture;
        private TextureSet detailTexture;
        private TextureSet bumpTexture;
        private ShaderFloats shaderFloats;
        private Overlay CloudOverlay;

        public TextureSet MainTexture { get { return mainTexture; } }
        public TextureSet DetailTexture { get { return detailTexture; } }
        public TextureSet BumpTexture { get { return bumpTexture; } }
        public Color Color { get { return color; } }
        public float Radius { get { return radius; } }
        public ShaderFloats ShaderFloats { get { return shaderFloats; } }

        internal void ApplyGUIUpdate(CloudGUI cloudGUI)
        {
            mainTexture.Clone(cloudGUI.MainTexture);
            detailTexture.Clone(cloudGUI.DetailTexture);
            bumpTexture.Clone(cloudGUI.BumpTexture);
            shaderFloats.Clone(cloudGUI.ShaderFloats);
            radius = cloudGUI.Radius.RadiusF;
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
            Init();
        }

        private void UpdateTextures()
        {
            CloudMaterial.SetTexture("_MainTex", mainTexture.Texture);
            CloudMaterial.SetColor("_Color", color);


            if (detailTexture.InUse)
            {
                CloudMaterial.SetTexture("_DetailTex", detailTexture.Texture);
                CloudMaterial.SetFloat("_DetailScale", detailTexture.Scale);
            }

            if (bumpTexture.InUse)
            {
                CloudMaterial.SetTexture("_BumpMap", bumpTexture.Texture);
                CloudMaterial.SetFloat("_BumpScale", bumpTexture.Scale);
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

            UpdateFloats();

            Log("Cloud Material initialized");
            UpdateTextures();
            Log("Generating Overlay...");
            CloudOverlay = Overlay.GeneratePlanetOverlay(body, radius, CloudMaterial, this.mainTexture.StartOffset);
            Overlay overlay = Overlay.GeneratePlanetOverlay(body, 80*radius, CloudMaterial, this.mainTexture.StartOffset);
            float longitude = -74.559f;
            float latitude = -0.0975f;
            CelestialBody currentBody = null;

            UnityEngine.Object[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody));
            foreach (CelestialBody cb in celestialBodies)
            {
                string name = cb.bodyName;
                if (name == this.body)
                {
                    currentBody = cb;
                }
            }
            placePQS(longitude, latitude, (float)((radius - 1) * currentBody.Radius),overlay.OverlayGameObject);
            overlay.OverlayGameObject.layer = 15;
            Log("Textures initialized");
        }

        private void placePQS(float longitude, float latitude, float altitude, GameObject go)
        {

            UnityEngine.Object[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody));

            CelestialBody currentBody = null;

            foreach (CelestialBody cb in celestialBodies)
            {
                string name = cb.bodyName;
                if (name == this.body)
                {
                    currentBody = cb;
                }
            }

            GameObject blockHolder = new GameObject();
            blockHolder.name = "blockHolder";

            GameObject block = go;
            if (block == null)
            {

            }

            block.transform.parent = blockHolder.transform;

            foreach (Transform aTransform in currentBody.transform)
            {
                if (aTransform.name == currentBody.transform.name)
                    blockHolder.transform.parent = aTransform;
            }
            PQSCity blockScript = blockHolder.AddComponent<PQSCity>();
            blockScript.debugOrientated = false;
            blockScript.frameDelta = 1;
            blockScript.lod = new PQSCity.LODRange[1];
            blockScript.lod[0] = new PQSCity.LODRange();
            blockScript.lod[0].visibleRange = 20000;
            blockScript.lod[0].renderers = new GameObject[1];
            blockScript.lod[0].renderers[0] = block;
            blockScript.lod[0].objects = new GameObject[0];
            blockScript.modEnabled = true;
            blockScript.order = 100;
            blockScript.reorientFinalAngle = -105;
            blockScript.reorientInitialUp = Vector3.up;
            blockScript.reorientToSphere = true;
            //railScript.repositionRadial = (GameObject.Find("Runway").transform.position - currentBody.transform.position) + Vector3.up * 50 + Vector3.right * -350;
            blockScript.repositionRadial = QuaternionD.AngleAxis(longitude, Vector3d.down) * QuaternionD.AngleAxis(latitude, Vector3d.forward) * Vector3d.right;
            blockScript.repositionRadiusOffset = altitude;
            blockScript.repositionToSphere = true;
            blockScript.requirements = PQS.ModiferRequirements.Default;
            blockScript.sphere = currentBody.pqsController;

            blockScript.RebuildSphere();
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
            }

            if (bumpTexture.InUse)
            {
                bumpTexture.UpdateOffset(rateOffset, false);
                CloudMaterial.SetVector("_BumpOffset", bumpTexture.Offset);
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
