using EveManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Atmosphere
{
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class AtmosphereManager : GenericEVEManager<AtmosphereObject>
    {
        protected override String configName { get{return "EVE_ATMOSPHERE";} }
        protected void Awake()
        {
            if (HighLogic.LoadedScene == GameScenes.MAINMENU && !Initialized)
            {
                Setup();
            }
        }

    }
}
