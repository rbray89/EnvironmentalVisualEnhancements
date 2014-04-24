using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace EveManager
{
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class EVEManager : MonoBehaviour
    {
        public static List<EVEManager> Managers = new List<EVEManager>();

    }
}
