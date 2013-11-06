using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using UnityEngine;
using System.IO;
using CommonUtils;

namespace Clouds
{
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class Clouds : MonoBehaviour
    {
        static List<CloudLayer> CloudLayers = new List<CloudLayer>();
        static ConfigNode config;
        static bool Loaded = false;



        private void loadCloudLayers()
        {

            config = ConfigNode.Load(KSPUtil.ApplicationRootPath + "GameData/BoulderCo/Clouds/cloudLayers.cfg");
            ConfigNode[] cloudLayersConfigs = config.GetNodes("CLOUD_LAYER");

            foreach (ConfigNode node in cloudLayersConfigs)
            {
                String body = node.GetValue("body");
                if (ScaledSpace.Instance.scaledSpaceTransforms.Single(t => t.name == body) != null)
                {
                    float radius = float.Parse(node.GetValue("radius"));

                    TextureSet mTexture = new TextureSet(node.GetNode("main_texture"), false);
                    TextureSet dTexture = new TextureSet(node.GetNode("detail_texture"), false);
                    TextureSet bTexture = new TextureSet(node.GetNode("bump_texture"), true);


                    ConfigNode colorNode = node.GetNode("color");
                    Color color = new Color(
                        float.Parse(colorNode.GetValue("r")),
                        float.Parse(colorNode.GetValue("g")),
                        float.Parse(colorNode.GetValue("b")));

                    CloudLayers.Add(
                        new CloudLayer(body, color, radius,
                        mTexture, dTexture, bTexture));
                }
                else
                {
                    CloudLayer.Log("body "+body+" does not exist!");
                }
            }
        }

        protected void spawnVolumeClouds()
        {
            
        }

        protected void Awake()
        {
            if (HighLogic.LoadedScene == GameScenes.MAINMENU && !Loaded)
            {
                Utils.Init();
                loadCloudLayers();
                spawnVolumeClouds();
                Loaded = true;
            }
        }

        protected void Update()
        {

            foreach (CloudLayer layer in CloudLayers)
            {
                layer.PerformUpdate();
            }
        }
    }

    public class CloudLayer
    {
        public Material CloudMaterial;
        public Material UndersideCloudMaterial;
        private float timeDelta = 0;
        private String body;
        private Color color;
        private float radius;
        private TextureSet mainTexture;
        private TextureSet detailTexture;
        private TextureSet bumpTexture;

        public CloudLayer(String body, Color color, float radius,
            TextureSet mainTexture,
            TextureSet detailTexture,
            TextureSet bumpTexture)
        {
            this.body = body;
            this.color = color;
            this.radius = radius;
            this.mainTexture = mainTexture;
            if (detailTexture.Texture != null)
            {
                this.detailTexture = detailTexture;
            }
            else
            {
                this.detailTexture = null;
            }
            if (bumpTexture.Texture != null)
            {
                this.bumpTexture = bumpTexture;
            }
            else
            {
                this.bumpTexture = null;
            }
            Init();
        }

        private void InitTexture()
        {
            CloudMaterial.SetTexture("_MainTex", mainTexture.Texture);
            CloudMaterial.SetTextureScale("_MainTex", mainTexture.Scale);
            CloudMaterial.SetColor("_Color", color);

            UndersideCloudMaterial.SetTexture("_MainTex", mainTexture.Texture);
            UndersideCloudMaterial.SetTextureScale("_MainTex", mainTexture.Scale);
            UndersideCloudMaterial.SetColor("_Color", color);

            if (detailTexture != null)
            {
                CloudMaterial.SetTexture("_DetailTex", detailTexture.Texture);
                CloudMaterial.SetTextureScale("_DetailTex", detailTexture.Scale);
                UndersideCloudMaterial.SetTexture("_DetailTex", detailTexture.Texture);
                UndersideCloudMaterial.SetTextureScale("_DetailTex", detailTexture.Scale);
            }

            if (bumpTexture != null)
            {
                CloudMaterial.SetTexture("_BumpMap", bumpTexture.Texture);
                CloudMaterial.SetTextureScale("_BumpMap", bumpTexture.Scale);
                UndersideCloudMaterial.SetTexture("_BumpMap", bumpTexture.Texture);
                UndersideCloudMaterial.SetTextureScale("_BumpMap", bumpTexture.Scale);
            }
        }

        public void Init()
        {
            Log("Initializing Textures");
            Assembly assembly = Assembly.GetExecutingAssembly();
            StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Clouds.CompiledCloudShader.txt"));
            Log("reading stream...");
            String shaderTxt = shaderStreamReader.ReadToEnd();
            CloudMaterial = new Material(shaderTxt);
            shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Clouds.undersideCompiledCloudShader.txt"));
            Log("reading stream...");
            shaderTxt = shaderStreamReader.ReadToEnd();
            UndersideCloudMaterial = new Material(shaderTxt);
            
            Log("Cloud Material initialized");
            InitTexture();
            Log("Generating Overlay...");
            Overlay.GeneratePlanetOverlay(body, radius, CloudMaterial, Utils.OVER_LAYER, false, 64,64);
            Overlay.GeneratePlanetOverlay(body, radius, UndersideCloudMaterial, Utils.UNDER_LAYER, false, 64, 64);
            Log("Textures initialized");
        }



        private void updateOffset(float time)
        {
            float rateOffset = time;

            mainTexture.UpdateOffset(rateOffset);
            CloudMaterial.SetTextureOffset("_MainTex", mainTexture.Offset);
            UndersideCloudMaterial.SetTextureOffset("_MainTex", mainTexture.Offset);

            if(detailTexture != null)
            {
                detailTexture.UpdateOffset(rateOffset);
                CloudMaterial.SetTextureOffset("_DetailTex", detailTexture.Offset);
                UndersideCloudMaterial.SetTextureOffset("_DetailTex", detailTexture.Offset);
            }

            if (bumpTexture != null)
            {
                bumpTexture.UpdateOffset(rateOffset);
                CloudMaterial.SetTextureOffset("_BumpMap", bumpTexture.Offset);
                UndersideCloudMaterial.SetTextureOffset("_BumpMap", bumpTexture.Offset);
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
    }
}
