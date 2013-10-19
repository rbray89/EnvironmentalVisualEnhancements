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
            Texture2D texture = GameDatabase.Instance.GetTexture("BoulderCo/CityLights/Textures/main", false);
            texture.filterMode = FilterMode.Point;
            texture.Apply();
            lightMaterial.mainTexture = texture;
            lightMaterial.mainTextureScale = new Vector2(1f, 1f);
            lightMaterial.mainTextureOffset = new Vector2(-.25f, 0f);
            Log("Textures initialized");
        }

        protected void Awake()
        {
            InitTextures();
            Utils.GeneratePlanetOverlay("Kerbin", 1.005f, gameObject, lightMaterial);
        }

        public static void Log(String message)
        {
            UnityEngine.Debug.Log("CityLights: " + message);
        }

                
    }
}
