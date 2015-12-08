using EVEManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Utils;

namespace Atmosphere
{
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class AtmosphereManager : GenericEVEManager<AtmosphereObject>
    {
        protected override ObjectType objectType { get { return ObjectType.BODY; } }
        protected override String configName { get{return "EVE_ATMOSPHERE";} }

        protected override void ApplyConfigNode(ConfigNode node, String body)
        {
            GameObject go = new GameObject();
            AtmosphereObject newObject = go.AddComponent<AtmosphereObject>();
            go.transform.parent = Tools.GetCelestialBody(body).bodyTransform;
            newObject.LoadConfigNode(node, body);
            ObjectList.Add(newObject);
            newObject.Apply();
        }

        protected override void Clean()
        {
            AtmosphereManager.Log("Cleaning Atmosphere!");
            foreach (AtmosphereObject obj in ObjectList)
            {
                obj.Remove();
                GameObject go = obj.gameObject;
                go.transform.parent = null;

                GameObject.DestroyImmediate(obj);
                GameObject.DestroyImmediate(go);
            }
            ObjectList.Clear();
        }
    }
}
