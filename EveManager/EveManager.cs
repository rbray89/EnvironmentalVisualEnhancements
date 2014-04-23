using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace EveManager
{
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class EveManagerType : MonoBehaviour
    {
        public static List<EveManagerType> Managers = new List<EveManagerType>();
        public virtual void GenerateGUI()
        { }
        public virtual void SaveConfig()
        { }
        public virtual void LoadConfig()
        { }
        public virtual void LoadConfigDefaults()
        { }
    }

    public class EveManager
    {

    }
}
