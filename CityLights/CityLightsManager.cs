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

    public class CityLightsManager: GenericEVEManager<CityLightsObject>   
    {
        public override ObjectType objectType { get { return ObjectType.BODY; } }
        public override String configName { get { return "EVE_CITY_LIGHTS"; } }
        

        public CityLightsManager()
        { }

    }
}
