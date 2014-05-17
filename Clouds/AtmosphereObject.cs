using EVEManager;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Utils;

namespace Atmosphere
{
    enum ScaledOverlayEnum
    {
        None,
        Shader,
        Geometry
    }

    public class AtmosphereObject : MonoBehaviour, IEVEObject
    {
        public String Name { get { return name; } set { name = node.name = value; } }
        public ConfigNode ConfigNode { get { return node; } }
        public String Body { get { return body; } }
        private new String name;
        private ConfigNode node;
        private String body;
        [Persistent]
        float altitude = 1000f;
        [Persistent]
        float speed = 30;
        [Persistent]
        ScaledOverlayEnum scaledOverlay = ScaledOverlayEnum.None;
        [Persistent, Optional]
        CloudsVolume layerVolume = null;
        [Persistent, Optional]
        Clouds2D layer2D = null;
        [Persistent, Optional("scaledOverlay", ScaledOverlayEnum.Geometry)]
        Clouds2D scaledLayer2D = null;

        private AtmospherePQS atmospherePQS = null;
        private CelestialBody celestialBody;
        private Transform scaledCelestialBody;
        public void LoadConfigNode(ConfigNode node, String body)
        {
            ConfigNode.LoadObjectFromConfig(this, node);
            this.node = node;
            this.body = body;
            name = node.name;
        }
        public ConfigNode GetConfigNode()
        {
            return ConfigNode.CreateConfigFromObject(this, new ConfigNode(body));
        }

        protected void Update()
        {
            if (scaledLayer2D != null)
            {
                Vector3 pos = scaledCelestialBody.transform.InverseTransformPoint(ScaledCamera.Instance.camera.transform.position);
                scaledLayer2D.UpdateRotation(Quaternion.FromToRotation(Vector3.up, pos));
            }
        }

        public void Apply()
        {
            celestialBody = EVEManagerClass.GetCelestialBody(body);
            scaledCelestialBody = EVEManagerClass.GetScaledTransform(body);
            this.gameObject.transform.parent = celestialBody.transform;
            GameObject go = new GameObject();
            atmospherePQS = go.AddComponent<AtmospherePQS>();
            atmospherePQS.Apply(body, layer2D, layerVolume, altitude, speed);

            if(scaledLayer2D != null)
            {
                scaledLayer2D.Apply((float)(altitude + celestialBody.Radius), speed, scaledCelestialBody, (float)(1000f / celestialBody.Radius) * Vector3.one);
            }
        }

        public void Remove()
        {
            atmospherePQS.Remove();
            GameObject go = atmospherePQS.gameObject;
            go.transform.parent = null;

            GameObject.DestroyImmediate(atmospherePQS);
            GameObject.DestroyImmediate(go);
        }
    }
}
