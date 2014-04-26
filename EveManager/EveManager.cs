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
        public static int MAP_LAYER = 10;
        public static int MACRO_LAYER = 15;

        public static CelestialBody GetCelestialBody(String body)
        {
            CelestialBody[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody)) as CelestialBody[];
            return celestialBodies.Single(n => n.bodyName == body);
        }

        public static Transform GetScaledTransform(string body)
        {
            List<Transform> transforms = ScaledSpace.Instance.scaledSpaceTransforms;
            return transforms.Single(n => n.name == body);
        }

    }
}
