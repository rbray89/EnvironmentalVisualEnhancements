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
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class CityLightsManager: GenericEVEManager<CityLightsObject>   
    {
        protected override String configName { get { return "EVE_CITY_LIGHTS"; } }

        public CityLightsManager()
        { }

        protected void Awake()
        {
            if (HighLogic.LoadedScene == GameScenes.MAINMENU && !Initialized)
            {
                Setup();
            }
        }

        public override void Setup()
        {
            TerrainManager.StaticSetup();
            base.Setup();
        }


    }
}
