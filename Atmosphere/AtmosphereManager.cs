using EVEManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Utils;

namespace Atmosphere
{
    public class AtmosphereManager : GenericEVEManager<AtmosphereObject>
    {
        public override ObjectType objectType { get { return ObjectType.BODY; } }
        public override String configName { get{return "EVE_ATMOSPHERE";} }

        protected override void ApplyConfigNode(ConfigNode node)
        {
            GameObject go = new GameObject("AtmosphereManager");
            AtmosphereObject newObject = go.AddComponent<AtmosphereObject>();
            go.transform.parent = Tools.GetCelestialBody(node.GetValue(ConfigHelper.BODY_FIELD)).bodyTransform;
            newObject.LoadConfigNode(node);
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
