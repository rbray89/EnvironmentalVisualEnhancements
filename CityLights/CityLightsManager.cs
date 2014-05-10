using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using Utils;
using EVEManager;
using Terrain;

namespace CityLights
{
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class CityLightsManager: GenericEVEManager<CityLightsObject>   
    {
        protected override ObjectType objectType { get { return ObjectType.PLANET; } }
        protected override String configName { get { return "EVE_CITY_LIGHTS"; } }

        public CityLightsManager()
        { }

        public override void Setup()
        {
            TerrainManager.StaticSetup();
            base.Setup();
        }


    }
}
