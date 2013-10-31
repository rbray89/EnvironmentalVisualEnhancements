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
                float radius = float.Parse(node.GetValue("radius"));

                TextureSet mTexture = new TextureSet(node.GetNode("main_texture"));
                TextureSet dTexture = new TextureSet(node.GetNode("detail_texture"));
                TextureSet bTexture = new TextureSet(node.GetNode("bump_texture"));
               
                
                ConfigNode colorNode = node.GetNode("color");
                Color color = new Color(
                    float.Parse(colorNode.GetValue("r")),
                    float.Parse(colorNode.GetValue("g")),
                    float.Parse(colorNode.GetValue("b")));
               
                CloudLayers.Add(
                    new CloudLayer(body, color, radius, 
                    mTexture, dTexture, bTexture));
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

    public class TextureSet
    {
        static Dictionary<String, Texture2D> TextureDictionary = new Dictionary<string, Texture2D>();
        public Vector2 Offset;
        public Vector2 Speed;
        public Vector2 Scale;
        public Texture2D Texture;

        private void initTextures(String textureString)
        {
            if (!TextureDictionary.ContainsKey(textureString))
            {
                TextureDictionary.Add(textureString, GameDatabase.Instance.GetTexture(textureString, false));
            }
        }

        public TextureSet(Texture2D texture, Vector2 offset, Vector2 speed, Vector2 scale)
        {
            Texture = texture;
            Offset = offset;
            Speed = speed;
            Scale = scale;
        }

        public TextureSet(ConfigNode textureNode)
        {
            if (textureNode != null)
            {
                String textureString = textureNode.GetValue("file");
                initTextures(textureString);
                Texture = TextureDictionary[textureString];
                ConfigNode offsetNode = textureNode.GetNode("offset");
                Offset = new Vector2(float.Parse(offsetNode.GetValue("x")), float.Parse(offsetNode.GetValue("y")));
                ConfigNode speedNode = textureNode.GetNode("speed");
                Speed = new Vector2(float.Parse(speedNode.GetValue("x")), float.Parse(speedNode.GetValue("y")));
                ConfigNode scaleNode = textureNode.GetNode("scale");
                Scale = new Vector2(float.Parse(scaleNode.GetValue("x")), float.Parse(scaleNode.GetValue("y")));
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
        private GameObject OverlayGameObject;
        private GameObject UndersideGameObject;

        public CloudLayer(String body, Color color, float radius,
            TextureSet mainTexture,
            TextureSet detailTexture,
            TextureSet bumpTexture)
        {
            this.body = body;
            this.color = color;
            this.radius = radius;
            this.mainTexture = mainTexture;
            this.detailTexture = detailTexture;
            this.bumpTexture = bumpTexture;

            Init();
        }

        private void InitTexture()
        {
            CloudMaterial.SetTexture("_MainTex", mainTexture.Texture);
            CloudMaterial.SetTexture("_DetailTex", detailTexture.Texture);
            CloudMaterial.SetTextureScale("_MainTex", mainTexture.Scale);
            CloudMaterial.SetTextureScale("_DetailTex", detailTexture.Scale);
            CloudMaterial.SetColor("_Color", color);

            UndersideCloudMaterial.SetTexture("_MainTex", mainTexture.Texture);
            UndersideCloudMaterial.SetTexture("_DetailTex", detailTexture.Texture);
            UndersideCloudMaterial.SetTextureScale("_MainTex", mainTexture.Scale);
            UndersideCloudMaterial.SetTextureScale("_DetailTex", detailTexture.Scale);
            UndersideCloudMaterial.SetColor("_Color", color);

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
            OverlayGameObject = new GameObject();
            UndersideGameObject = new GameObject();
            Utils.Overlay.GeneratePlanetOverlay(body, radius, OverlayGameObject, CloudMaterial, Utils.OVER_LAYER, false, 64,64);
            Utils.Overlay.GeneratePlanetOverlay(body, radius, UndersideGameObject, UndersideCloudMaterial, Utils.UNDER_LAYER, false, 64, 64);
            Log("Textures initialized");
        }



        private void updateOffset(float time)
        {
            float rateOffset = time;
            mainTexture.Offset.x += rateOffset * mainTexture.Speed.x;
            mainTexture.Offset.y += rateOffset * mainTexture.Speed.y;
            detailTexture.Offset.x += rateOffset * detailTexture.Speed.x;
            detailTexture.Offset.y += rateOffset * detailTexture.Speed.y;
            bumpTexture.Offset.x += rateOffset * bumpTexture.Speed.x;
            bumpTexture.Offset.y += rateOffset * bumpTexture.Speed.y;

            CloudMaterial.SetTextureOffset("_MainTex", mainTexture.Offset);
            CloudMaterial.SetTextureOffset("_DetailTex", detailTexture.Offset);
            CloudMaterial.SetTextureOffset("_BumpMap", bumpTexture.Offset);
            UndersideCloudMaterial.SetTextureOffset("_MainTex", mainTexture.Offset);
            UndersideCloudMaterial.SetTextureOffset("_DetailTex", detailTexture.Offset);
            UndersideCloudMaterial.SetTextureOffset("_BumpMap", bumpTexture.Offset);
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
