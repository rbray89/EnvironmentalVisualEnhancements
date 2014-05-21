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
        private ScaledAtmospherePQS scaledAtmospherePQS = null;
        private CelestialBody celestialBody;
        private Transform scaledCelestialTransform;
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

        public void Apply()
        {
            celestialBody = EVEManagerClass.GetCelestialBody(body);
            scaledCelestialTransform = EVEManagerClass.GetScaledTransform(body);
            
            GameObject go = new GameObject();
            atmospherePQS = go.AddComponent<AtmospherePQS>();
            atmospherePQS.Apply(body, layer2D, layerVolume, altitude, speed);

            go = new GameObject();
            scaledAtmospherePQS = go.AddComponent<ScaledAtmospherePQS>();
            scaledAtmospherePQS.Apply(body, scaledLayer2D, altitude, speed);
        }

        public void Remove()
        {
            atmospherePQS.Remove();
            GameObject go = atmospherePQS.gameObject;
            go.transform.parent = null;

            GameObject.DestroyImmediate(atmospherePQS);
            GameObject.DestroyImmediate(go);

            scaledAtmospherePQS.Remove();
            go = scaledAtmospherePQS.gameObject;
            go.transform.parent = null;

            GameObject.DestroyImmediate(scaledAtmospherePQS);
            GameObject.DestroyImmediate(go);
        }
    }
}
