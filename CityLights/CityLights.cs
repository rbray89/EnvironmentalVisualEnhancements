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
    [KSPAddon(KSPAddon.Startup.MainMenu, false)]
    public class CityLights: MonoBehaviour
    {
        public static Material lightMaterial;

        public static void InitTextures()
        {
            Log("Initializing Textures");
            Assembly assembly = Assembly.GetExecutingAssembly();
            StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("CityLights.CompiledCityLightsShader.txt"));
            Log("read stream");
            lightMaterial = new Material(shaderStreamReader.ReadToEnd());
            Texture2D main = GameDatabase.Instance.GetTexture("BoulderCo/CityLights/Textures/main", false);
            Texture2D detail = GameDatabase.Instance.GetTexture("BoulderCo/CityLights/Textures/detail", false);
//            texture.filterMode = FilterMode.Point;
//            texture.Apply();
            lightMaterial.mainTexture = main;
            lightMaterial.mainTextureScale = new Vector2(1f, 1f);
            lightMaterial.mainTextureOffset = new Vector2(-.25f, 0f);
            lightMaterial.SetTexture("_DetailTex", detail);
            lightMaterial.SetTextureScale("_DetailTex", new Vector2(100f, 100f));
            Log("Textures initialized");
        }

        protected void Awake()
        {
            InitTextures();
            Utils.GeneratePlanetOverlay("Kerbin", 1.0035f, gameObject, lightMaterial);
        }

        public static void Log(String message)
        {
            UnityEngine.Debug.Log("CityLights: " + message);
        }

                
    }
}
