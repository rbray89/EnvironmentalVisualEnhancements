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
        

        private void initTextures(String mainTexture, String mixerTexture)
        {
            if (!TextureDictionary.ContainsKey(mainTexture))
            {
                TextureDictionary.Add(mainTexture, GameDatabase.Instance.GetTexture(mainTexture, false));
            }

            if (!TextureDictionary.ContainsKey(mixerTexture))
            {
                TextureDictionary.Add(mixerTexture, GameDatabase.Instance.GetTexture(mixerTexture, false));
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
                String mixerTexture = textureNode.GetValue("mixer");
                initTextures(mainTexture, mixerTexture);
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
                CloudLayers.Add(
                    new CloudLayer(body, color, radius, 
                    TextureDictionary[mainTexture], TextureDictionary[mixerTexture],
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
        private Texture2D mixerTexture;
        private Vector2 mainOff;
        private Vector2 mixOff;
        private float speed;
        private GameObject OverlayGameObject;
        private GameObject UndersideGameObject;

        public CloudLayer(String body, Color color, float radius, 
            Texture2D mainTexture, Texture2D mixerTexture,
            Vector2 offset,
            float speed)
        {
            this.body = body;
            this.color = color;
            this.radius = radius;
            this.mainTexture = mainTexture;
            this.mixerTexture = mixerTexture;
            this.speed = speed;

            mainOff = new Vector2(offset.x, offset.y);
            mixOff = new Vector2(offset.x, offset.y);
            Init();
        }

        private void InitTexture()
        {
            CloudMaterial.SetTexture("_MainTex", mainTexture);
            CloudMaterial.SetTexture("_Mixer", mixerTexture);
            CloudMaterial.SetTextureScale("_MainTex", new Vector2(1f, 1f));
            CloudMaterial.SetTextureScale("_Mixer", new Vector2(7f, 7f));
            CloudMaterial.SetColor("_Color", color);
            UndersideCloudMaterial.SetTexture("_MainTex", mainTexture);
            UndersideCloudMaterial.SetTexture("_Mixer", mixerTexture);
            UndersideCloudMaterial.SetTextureScale("_MainTex", new Vector2(1f, 1f));
            UndersideCloudMaterial.SetTextureScale("_Mixer", new Vector2(100f, 100f));
            UndersideCloudMaterial.SetColor("_Color", color);
        }

        public void Init()
        {
            Log("Initializing Textures");
            Assembly assembly = Assembly.GetExecutingAssembly();
            StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Clouds.CompiledCloudShader.txt"));
            Log("reading stream...");
            String shaderTxt = shaderStreamReader.ReadToEnd();
            CloudMaterial = new Material(shaderTxt);
//            CloudMaterial = new Material(Shader.Find("Transparent/VertexLit"));
            shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Clouds.undersideCompiledCloudShader.txt"));
            Log("reading stream...");
            shaderTxt = shaderStreamReader.ReadToEnd();
            UndersideCloudMaterial = new Material(shaderTxt);
            
            Log("Cloud Material initialized");
            InitTexture();
            Log("Generating Overlay...");
            OverlayGameObject = new GameObject();
            UndersideGameObject = new GameObject();
            Utils.GeneratePlanetOverlay(body, radius, OverlayGameObject, CloudMaterial, Utils.OVER_LAYER,64,48);
            Utils.GeneratePlanetOverlay(body, radius, UndersideGameObject, UndersideCloudMaterial, Utils.UNDER_LAYER, 64, 48);
            Log("Textures initialized");
        }



        private void updateOffset(float time)
        {
            float rateOffset = time * speed;
            mainOff.x += rateOffset;
            mixOff.x += rateOffset / 1.1f;
            mixOff.y += rateOffset / 1.2f;

            CloudMaterial.SetTextureOffset("_MainTex", mainOff);
            CloudMaterial.SetTextureOffset("_Mixer", mixOff);
            UndersideCloudMaterial.SetTextureOffset("_MainTex", mainOff);
            UndersideCloudMaterial.SetTextureOffset("_Mixer", mixOff);
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
