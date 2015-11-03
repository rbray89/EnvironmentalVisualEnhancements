using Utils;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using EVEManager;
using ShaderLoader;

namespace CelestialShadows
{
       
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class ShadowManager : GenericEVEManager<ShadowObject>
    {
        protected override ObjectType objectType { get { return ObjectType.PLANET; } }
        protected override String configName { get { return "EVE_SHADOWS"; } }
       

        
    }
}
