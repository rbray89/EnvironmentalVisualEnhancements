using EVEManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Utils;

namespace PQSManager
{
    public class PQSManagerClass : GenericEVEManager<PQSWrapper>
    {
        public override ObjectType objectType { get { return ObjectType.BODY|ObjectType.STATIC; } }
        public override String configName { get { return "PQS_MANAGER"; } }

        protected override void ApplyConfigNode(ConfigNode node)
        {
            GameObject go = new GameObject();
            PQSWrapper newObject = go.AddComponent<PQSWrapper>();
            go.transform.parent = Tools.GetCelestialBody(node.GetValue(ConfigHelper.BODY_FIELD)).bodyTransform;
            go.transform.localPosition = Vector3.zero;
            go.transform.localRotation = Quaternion.identity;
            go.transform.localScale = Vector3.one;
            newObject.LoadConfigNode(node);
            ObjectList.Add(newObject);
            newObject.Apply();
        }

        protected override void Clean()
        {
            foreach (PQSWrapper obj in ObjectList)
            {
                obj.Remove();
                GameObject go = obj.gameObject;
                go.transform.parent = null;

                GameObject.DestroyImmediate(obj);
                GameObject.DestroyImmediate(go);
            }
            ObjectList.Clear();
        }

        static public PQS GetPQS(String body)
        {
            StaticSetup();
            return ObjectList.Find(pqs => pqs.Body == body);
        }
    }
}
