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
        static Dictionary<String, Texture2D> TextureDictionary = new Dictionary<string,Texture2D>();
        static ConfigNode config;
        static bool Loaded = false;


        private void initTextures(String mainTexture, String detailTexture, String bumpTexture)
        {
            if (!TextureDictionary.ContainsKey(mainTexture))
            {
                TextureDictionary.Add(mainTexture, GameDatabase.Instance.GetTexture(mainTexture, false));
            }

            if (!TextureDictionary.ContainsKey(detailTexture))
            {
                TextureDictionary.Add(detailTexture, GameDatabase.Instance.GetTexture(detailTexture, false));
            }

            if (bumpTexture != null && bumpTexture != "" && !TextureDictionary.ContainsKey(bumpTexture))
            {
                TextureDictionary.Add(bumpTexture, GameDatabase.Instance.GetTexture(bumpTexture, false));
            }

        }

        private void loadCloudLayers()
        {

            config = ConfigNode.Load(KSPUtil.ApplicationRootPath + "GameData/BoulderCo/Clouds/cloudLayers.cfg");
            ConfigNode[] cloudLayersConfigs = config.GetNodes("CLOUD_LAYER");

            foreach (ConfigNode node in cloudLayersConfigs)
            {
                String body = node.GetValue("body");
                float radius = float.Parse(node.GetValue("radius"));
                ConfigNode textureNode = node.GetNode("textures");
                String mainTexture = textureNode.GetValue("main");
                String detailTexture = textureNode.GetValue("detail");
                String bumpTexture = textureNode.GetValue("bump");
                initTextures(mainTexture, detailTexture, bumpTexture);
                Texture2D mTexture = TextureDictionary[mainTexture];
                Texture2D dTexture = TextureDictionary[detailTexture];
                Texture2D bTexture = null;
                if (bumpTexture != null && bumpTexture == "")
                {
                    bTexture = TextureDictionary[bumpTexture];
                }
                
                ConfigNode offsetNode = textureNode.GetNode("offset");
                Vector2 offset = new Vector2(float.Parse(offsetNode.GetValue("x")), float.Parse(offsetNode.GetValue("y")));
                ConfigNode colorNode = node.GetNode("color");
                Color color = new Color(
                    float.Parse(colorNode.GetValue("r")),
                    float.Parse(colorNode.GetValue("g")),
                    float.Parse(colorNode.GetValue("b")));
                float speed = float.Parse(node.GetValue("speed"));
                CloudLayer.Log("body: " + body);
                CloudLayer.Log("radius: " + radius);
                CloudLayer.Log("speed: " + speed);
                CloudLayer.Log("main: " + mainTexture);
                CloudLayer.Log("detail: " + detailTexture);
                CloudLayer.Log("bump: " + bumpTexture);
                CloudLayers.Add(
                    new CloudLayer(body, color, radius, 
                    mTexture, dTexture, bTexture,
                    offset,
                    speed));
            }
        }

        protected void spawnVolumeClouds()
        {
            
        }

        protected void Awake()
        {
            if (HighLogic.LoadedScene == GameScenes.MAINMENU && !Loaded)
            {
                
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
        private Texture2D mainTexture;
        private Texture2D detailTexture;
        private Texture2D bumpTexture;
        private Vector2 mainOff;
        private Vector2 mixOff;
        private float speed;
        private GameObject OverlayGameObject;
        private GameObject UndersideGameObject;

        public CloudLayer(String body, Color color, float radius, 
            Texture2D mainTexture, 
            Texture2D detailTexture,
            Texture2D bumpTexture,
            Vector2 offset,
            float speed)
        {
            this.body = body;
            this.color = color;
            this.radius = radius;
            this.mainTexture = mainTexture;
            this.detailTexture = detailTexture;
            this.bumpTexture = bumpTexture;
            this.speed = speed;

            mainOff = new Vector2(offset.x, offset.y);
            mixOff = new Vector2(offset.x, offset.y);
            Init();
        }

        private void InitTexture()
        {
            CloudMaterial.SetTexture("_MainTex", mainTexture);
            CloudMaterial.SetTexture("_DetailTex", detailTexture);
            CloudMaterial.SetTextureScale("_MainTex", new Vector2(1f, 1f));
            CloudMaterial.SetTextureScale("_DetailTex", new Vector2(10f, 10f));
            CloudMaterial.SetColor("_Color", color);
           
            UndersideCloudMaterial.SetTexture("_MainTex", mainTexture);
            UndersideCloudMaterial.SetTexture("_DetailTex", detailTexture);
            UndersideCloudMaterial.SetTextureScale("_MainTex", new Vector2(1f, 1f));
            UndersideCloudMaterial.SetTextureScale("_DetailTex", new Vector2(100f, 100f));
            UndersideCloudMaterial.SetColor("_Color", color);

            if (bumpTexture != null)
            {
                CloudMaterial.SetTexture("_BumpMap", bumpTexture);
                CloudMaterial.SetTextureScale("_BumpMap", new Vector2(10f, 10f));
                UndersideCloudMaterial.SetTexture("_BumpMap", bumpTexture);
                UndersideCloudMaterial.SetTextureScale("_BumpMap", new Vector2(100f, 100f));
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
            OverlayGameObject = new GameObject();
            UndersideGameObject = new GameObject();
            Utils.Overlay.GeneratePlanetOverlay(body, radius, OverlayGameObject, CloudMaterial, Utils.OVER_LAYER, false, 64,64);
            Utils.Overlay.GeneratePlanetOverlay(body, radius, UndersideGameObject, UndersideCloudMaterial, Utils.UNDER_LAYER, false, 64, 64);
            Log("Textures initialized");
        }



        private void updateOffset(float time)
        {
            float rateOffset = time * speed;
            mainOff.x += rateOffset;
            mixOff.x += rateOffset * .98f;
            mixOff.y += rateOffset * .97f;

            CloudMaterial.SetTextureOffset("_MainTex", mainOff);
            CloudMaterial.SetTextureOffset("_Detail", mixOff);
            UndersideCloudMaterial.SetTextureOffset("_MainTex", mainOff);
            UndersideCloudMaterial.SetTextureOffset("_Detail", mixOff);
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
