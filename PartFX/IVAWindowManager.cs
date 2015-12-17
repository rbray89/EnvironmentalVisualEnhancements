using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EVEManager;
using Utils;
using UnityEngine;
using System.Collections;
using System.Reflection;

namespace PartFX
{
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class IVAWindowManager : GenericEVEManager<IVAWindowObject>
    {
        protected override ObjectType objectType { get { return ObjectType.STATIC | ObjectType.MULTIPLE; } }
        protected override String configName { get { return "IVA_WINDOW_CONFIG"; } }
        protected override bool DelayedLoad { get { return false; } }
        protected override GameScenes SceneLoad { get { return GameScenes.MAINMENU; } }
        
    }

    
}
