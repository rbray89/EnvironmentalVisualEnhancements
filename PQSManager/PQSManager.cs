using EVEManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Utils;

namespace PQSManager
{
    [KSPAddon(KSPAddon.Startup.MainMenu, false)]
    public class PQSManagerClass : GenericEVEManager<PQSWrapper>
    {
        protected override ObjectType objectType { get { return ObjectType.PLANET|ObjectType.STATIC; } }
        protected override String configName { get { return "PQS_MANAGER"; } }

        protected override void ApplyConfigNode(ConfigNode node, String body)
        {
            GameObject go = new GameObject();
            PQSWrapper newObject = go.AddComponent<PQSWrapper>();
            go.transform.parent = Tools.GetCelestialBody(body).bodyTransform;
            go.transform.localPosition = Vector3.zero;
            go.transform.localRotation = Quaternion.identity;
            go.transform.localScale = Vector3.one;
            newObject.LoadConfigNode(node, body);
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
            StaticSetup(new PQSManagerClass());
            return ObjectList.Find(pqs => pqs.Body == body);
        }
    }
}
