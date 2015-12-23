using EVEManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Utils;

namespace Atmosphere
{

    public class CloudsManager : GenericEVEManager<CloudsObject>
    {
        public override ObjectType objectType { get { return ObjectType.BODY | ObjectType.MULTIPLE; } }
        public override String configName { get{return "EVE_CLOUDS";} }

        protected override void ApplyConfigNode(ConfigNode node)
        {
            GameObject go = new GameObject();
            CloudsObject newObject = go.AddComponent<CloudsObject>();
            go.transform.parent = Tools.GetCelestialBody(node.GetValue(ConfigHelper.BODY_FIELD)).bodyTransform;
            newObject.LoadConfigNode(node);
            ObjectList.Add(newObject);
            newObject.Apply();
        }

        protected override void Clean()
        {
            CloudsManager.Log("Cleaning Clouds!");
            foreach (CloudsObject obj in ObjectList)
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
