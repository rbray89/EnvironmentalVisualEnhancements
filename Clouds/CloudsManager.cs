using EveManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Clouds
{
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class CloudsManager : GenericEVEManager<CloudsObject>
    {
        protected override String configName { get{return "EVE_CLOUDS";} }
        protected void Awake()
        {
            if (HighLogic.LoadedScene == GameScenes.MAINMENU && !Initialized)
            {
                Setup();
            }
        }

    }
}
