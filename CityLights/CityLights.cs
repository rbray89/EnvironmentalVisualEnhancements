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
                    float fadeDistance = float.Parse(node.GetValue("fadeDistance"));
                    float pqsfadeDistance = float.Parse(node.GetValue("pqsFadeDistance"));

                    TextureSet mTexture = new TextureSet(node.GetNode("main_texture"), false, Utils.IsCubicMapped);
                    TextureSet dTexture = new TextureSet(node.GetNode("detail_texture"), false, false);

                    AddOverlay(mTexture, dTexture, radius, fadeDistance, pqsfadeDistance);
                }
                
                setup = true;
            }
        }

        private void AddOverlay(TextureSet mTexture, TextureSet dTexture, float radius, float fadeDistance, float pqsfadeDistance)
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
            String shaderString = shaderStreamReader.ReadToEnd();
            Material lightMaterial = new Material(shaderString);
            Material pqsLightMaterial = new Material(shaderString);

            lightMaterial.SetTexture("_MainTex", mTexture.Texture);
            lightMaterial.SetTexture("_DetailTex", dTexture.Texture);
            lightMaterial.SetFloat("_DetailScale", dTexture.Scale);
            lightMaterial.SetVector("_DetailOffset", dTexture.Offset);
            lightMaterial.SetFloat("_FadeDistance", fadeDistance);
            pqsLightMaterial.SetTexture("_MainTex", mTexture.Texture);
            pqsLightMaterial.SetTexture("_DetailTex", dTexture.Texture);
            pqsLightMaterial.SetFloat("_DetailScale", dTexture.Scale);
            pqsLightMaterial.SetVector("_DetailOffset", dTexture.Offset);
            pqsLightMaterial.SetFloat("_FadeDistance", pqsfadeDistance);
            
            Overlay.GeneratePlanetOverlay("Kerbin", radius, lightMaterial, pqsLightMaterial, mTexture.StartOffset);
        }

        public static void Log(String message)
        {
            UnityEngine.Debug.Log("CityLights: " + message);
        }

    }
}
