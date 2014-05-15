using EVEManager;
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
        protected override ObjectType objectType { get { return ObjectType.PLANET | ObjectType.MULTIPLE; } }
        protected override String configName { get{return "EVE_ATMOSPHERE";} }

        protected override void ApplyConfigNode(ConfigNode node, String body)
        {
            GameObject go = new GameObject();
            AtmosphereObject newObject = go.AddComponent<AtmosphereObject>();
            newObject.LoadConfigNode(node, body);
            ObjectList.Add(newObject);
            newObject.Apply();
        }

        protected override void Clean()
        {
            foreach (AtmosphereObject obj in ObjectList)
            {
                obj.Remove();
                GameObject.DestroyImmediate(obj);
            }
            ObjectList.Clear();
        }
    }
}
