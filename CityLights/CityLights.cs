using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using Utils;
using EveManager;
using Terrain;

namespace CityLights
{
    class CityLightsObj
    {
        private String body;
        [Persistent] TextureManager mainTexture;
        [Persistent] TextureManager detailTexture;

        public CityLightsObj(ConfigNode node)
        {
            ConfigNode.LoadObjectFromConfig(this, node);
            body = node.name;
        }
        public ConfigNode GetConfigNode()
        {
            return ConfigNode.CreateConfigFromObject(this, new ConfigNode(body));
        }

        public void Apply()
        {
            CelestialBody[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody)) as CelestialBody[];
            CelestialBody celestialBody = celestialBodies.Single(n => n.bodyName == body);
            if (celestialBody != null)
            {
                CityLightsManager.Log("Enabling City Lights...");
                celestialBody.pqsController.surfaceMaterial.EnableKeyword("CITYOVERLAY_ON");
                celestialBody.pqsController.surfaceMaterial.SetTexture("_DarkOverlayTex", mainTexture.GetTexture());
                celestialBody.pqsController.surfaceMaterial.SetTexture("_DarkOverlayDetailTex", detailTexture.GetTexture());
            }
        }

        public void Remove()
        {
            CelestialBody[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody)) as CelestialBody[];
            CelestialBody celestialBody = celestialBodies.Single(n => n.bodyName == body);
            if (celestialBody != null)
            {
                celestialBody.pqsController.surfaceMaterial.DisableKeyword("CITYOVERLAY_ON");
            }
        }
    }

    public class CityLightsManager: EveManagerType   
    {
        static bool Initialized = false;
        static List<CityLightsObj> CityLightsList = new List<CityLightsObj>();
        UrlDir.UrlConfig[] configs;

        protected void Awake()
        {
            if (HighLogic.LoadedScene == GameScenes.MAINMENU && !Initialized)
            {
                Setup();
            }
        }

        public void Setup()
        {
            TerrainManager.StaticSetup();
            Initialized = true;
            Managers.Add(this);
            LoadConfig();
        }

        public override void LoadConfig()
        {
            configs = GameDatabase.Instance.GetConfigs("CITY_LIGHTS");
            Clean();
            foreach(UrlDir.UrlConfig config in configs)
            {
                foreach(ConfigNode node in config.config.nodes)
                {
                    CityLightsObj newCityLights = new CityLightsObj(node);
                    CityLightsList.Add(newCityLights);
                    newCityLights.Apply();
                }
            }
        }

        private void Clean()
        {
            foreach(CityLightsObj cityLights in CityLightsList)
            {
                cityLights.Remove();
            }
            CityLightsList.Clear();
        }

        public override void SaveConfig()
        {
            Log("Saving...");
            foreach (UrlDir.UrlConfig config in configs)
            {
                config.config.ClearNodes();
                foreach (CityLightsObj cityLights in CityLightsList)
                {
                    config.config.AddNode(cityLights.GetConfigNode());
                }
            }
        }

        public static void Log(String message)
        {
            UnityEngine.Debug.Log("CityLights: " + message);
        }

    }
}
