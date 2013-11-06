using CommonUtils;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;

namespace CityLights
{
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class CityLights: MonoBehaviour
    {

        static bool setup = false;
        static ConfigNode config;


        protected void Awake()
        {
            if (HighLogic.LoadedScene == GameScenes.MAINMENU && !setup)
            {
                Utils.Init();
                config = ConfigNode.Load(KSPUtil.ApplicationRootPath + "GameData/BoulderCo/CityLights/cityLights.cfg");
                ConfigNode[] cloudLayersConfigs = config.GetNodes("CITY_LIGHTS");

                foreach (ConfigNode node in cloudLayersConfigs)
                {
                    float radius = float.Parse(node.GetValue("radius"));

                    TextureSet mTexture = new TextureSet(node.GetNode("main_texture"), false);
                    TextureSet dTexture = new TextureSet(node.GetNode("detail_texture"), false);

                    AddOverlay(mTexture, dTexture, radius);
                }
                
                setup = true;
            }
        }

        private void AddOverlay(TextureSet mTexture, TextureSet dTexture, float radius)
        {
            Assembly assembly = Assembly.GetExecutingAssembly();
            StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("CityLights.CompiledCityLightsShader.txt"));
            Log("read stream");
            Material lightMaterial = new Material(shaderStreamReader.ReadToEnd());

            lightMaterial.SetTexture("_MainTex", mTexture.Texture);
            lightMaterial.SetTextureScale("_MainTex", mTexture.Scale);
            lightMaterial.SetTextureOffset("_MainTex", mTexture.Offset);
            lightMaterial.SetTexture("_DetailTex", dTexture.Texture);
            lightMaterial.SetTextureScale("_DetailTex", dTexture.Scale);
            lightMaterial.SetTextureOffset("_DetailTex", dTexture.Offset);
            Overlay.GeneratePlanetOverlay("Kerbin", 1.001f, lightMaterial, Utils.OVER_LAYER, true);
        }

        public static void Log(String message)
        {
            UnityEngine.Debug.Log("CityLights: " + message);
        }

    }
}
