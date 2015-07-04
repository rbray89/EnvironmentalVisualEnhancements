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
    public class AtmosphereMaterial : MaterialManager
    {
        [Persistent]
        Color _Color = new Color(1, 1, 1, 1);
        [Persistent]
        String _MainTex = "";
        [Persistent]
        String _DetailTex = "";
        [Persistent]
        float _DetailScale = 100f;
        [Persistent, InverseScaled]
        float _DistFade = 1.0f;
        [Persistent, InverseScaled]
        float _DistFadeVert = 0.00004f;
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
        float detailSpeed;
        [Persistent]
        Vector3 offset = new Vector3(0, 0, 0);
        [Persistent]
        AtmosphereMaterial settings;

        [Persistent, Optional]
        AtmosphereVolume atmosphere = null;
        [Persistent, Optional]
        CloudsVolume layerVolume = null;
        [Persistent, Optional]
        Clouds2D layer2D = null;

        private AtmospherePQS atmospherePQS = null;
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
            celestialBody = Tools.GetCelestialBody(body);
            scaledCelestialTransform = Tools.GetScaledTransform(body);
            
            GameObject go = new GameObject();
            atmospherePQS = go.AddComponent<AtmospherePQS>();
            atmospherePQS.Apply(body, settings, layer2D, layerVolume, atmosphere, altitude, speed, detailSpeed, offset);
        }

        public void Remove()
        {
            atmospherePQS.Remove();
            GameObject go = atmospherePQS.gameObject;
            

            GameObject.DestroyImmediate(atmospherePQS);
            GameObject.DestroyImmediate(go);

        }

    }
}
