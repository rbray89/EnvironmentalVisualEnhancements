using EveManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

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

        public override void LoadConfig()
        {
            Log("Loading...");
            configs = GameDatabase.Instance.GetConfigs(configName);
            Clean();
            foreach (UrlDir.UrlConfig config in configs)
            {
                foreach (ConfigNode node in config.config.nodes)
                {
                    GameObject go = new GameObject();
                    AtmosphereObject newObject = go.AddComponent<AtmosphereObject>();
                    newObject.LoadConfigNode(node);
                    ObjectList.Add(newObject);
                    newObject.Apply();
                }
            }
        }

    }
}
