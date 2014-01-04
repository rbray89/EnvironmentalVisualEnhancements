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

                    TextureSet mTexture = new TextureSet(node.GetNode("main_texture"), false, Utils.IsCubicMapped);
                    TextureSet dTexture = new TextureSet(node.GetNode("detail_texture"), false, false);

                    AddOverlay(mTexture, dTexture, radius);
                }
                
                setup = true;
            }
        }

        private void AddOverlay(TextureSet mTexture, TextureSet dTexture, float radius)
        {
            Assembly assembly = Assembly.GetExecutingAssembly();
            StreamReader shaderStreamReader;
            string[] resources = assembly.GetManifestResourceNames();
            if (Utils.IsCubicMapped)
            {
                shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("CityLights.Shaders.Compiled-CubicCityLights.shader"));
            }
            else
            {
                shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("CityLights.Shaders.Compiled-SphereCityLights.shader"));
            }
            Log("read stream");
            Material lightMaterial = new Material(shaderStreamReader.ReadToEnd());

            lightMaterial.SetTexture("_MainTex", mTexture.Texture);
            lightMaterial.SetTexture("_DetailTex", dTexture.Texture);
            lightMaterial.SetFloat("_DetailScale", dTexture.Scale);
            lightMaterial.SetVector("_DetailOffset", dTexture.Offset);
            
            Overlay.GeneratePlanetOverlay("Kerbin", radius, lightMaterial, lightMaterial, mTexture.StartOffset);
        }

        public static void Log(String message)
        {
            UnityEngine.Debug.Log("CityLights: " + message);
        }

    }
}
