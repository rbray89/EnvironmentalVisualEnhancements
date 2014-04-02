using OverlaySystem;
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
        static List<Overlay> overlayList = new List<Overlay>();

        protected void Awake()
        {
            if (HighLogic.LoadedScene == GameScenes.FLIGHT && !setup)
            {
                OverlayMgr.Init();
                ConfigNode[] cityLightsConfigs = GameDatabase.Instance.GetConfigNodes("CITY_LIGHTS");
                
                foreach (ConfigNode node in cityLightsConfigs)
                {
                    float altitude = float.Parse(node.GetValue("altitude"));
                    float fadeDistance = float.Parse(node.GetValue("fadeDistance"));
                    float pqsfadeDistance = float.Parse(node.GetValue("pqsFadeDistance"));

                    TextureSet mTexture = new TextureSet(node.GetNode("main_texture"), false);
                    TextureSet dTexture = new TextureSet(node.GetNode("detail_texture"), false);
                    
                    AddOverlay(mTexture, dTexture, altitude, fadeDistance, pqsfadeDistance);
                }
                
                setup = true;
            }
        }

        private void AddOverlay(TextureSet mTexture, TextureSet dTexture, float altitude, float fadeDistance, float pqsfadeDistance)
        {
            Assembly assembly = Assembly.GetExecutingAssembly();
            string[] resources = assembly.GetManifestResourceNames();

            StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("CityLights.Shaders.Compiled-SphereCityLights.shader"));
            
            Log("read stream");
            String shaderString = shaderStreamReader.ReadToEnd();
            Material lightMaterial = new Material(shaderString);
            Material pqsLightMaterial = new Material(shaderString);

            lightMaterial.SetTexture("_MainTex", mTexture.Texture);
            lightMaterial.SetTexture("_DetailTex", dTexture.Texture);
            lightMaterial.SetFloat("_DetailScale", dTexture.Scale);
            lightMaterial.SetVector("_DetailOffset", dTexture.Offset);
            lightMaterial.SetFloat("_FadeDist", fadeDistance);
            lightMaterial.SetFloat("_FadeScale", 1);

            pqsLightMaterial.SetTexture("_MainTex", mTexture.Texture);
            pqsLightMaterial.SetTexture("_DetailTex", dTexture.Texture);
            pqsLightMaterial.SetFloat("_DetailScale", dTexture.Scale);
            pqsLightMaterial.SetVector("_DetailOffset", dTexture.Offset);
            pqsLightMaterial.SetFloat("_FadeDist", pqsfadeDistance);
            pqsLightMaterial.SetFloat("_FadeScale", .02f);

            overlayList.Add(Overlay.GeneratePlanetOverlay("Kerbin", altitude, lightMaterial, pqsLightMaterial, mTexture.StartOffset, false, true));
        }

        public static void Log(String message)
        {
            UnityEngine.Debug.Log("CityLights: " + message);
        }
    }
}
