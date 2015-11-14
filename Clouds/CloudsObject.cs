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
    public class CloudsMaterial : MaterialManager
    {
        [Persistent]
        Color32 _Color = Color.white;
        [Persistent]
        String _MainTex = "";
        [Persistent]
        String _DetailTex = "";
        [Persistent]
        float _DetailScale = 100f;
        [Persistent, InverseScaled]
        float _DetailDist = 0.000002f;
        [Persistent, InverseScaled]
        float _DistFade = 1.0f;
        [Persistent, InverseScaled]
        float _DistFadeVert = 0.00004f;
    }

    public class CloudsObject : MonoBehaviour, IEVEObject
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
        CloudsMaterial settings;
        
        [Persistent, Optional]
        CloudsVolume layerVolume = null;
        [Persistent, Optional]
        Clouds2D layer2D = null;

        private CloudsPQS cloudsPQS = null;
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
            cloudsPQS = go.AddComponent<CloudsPQS>();
            go.name = this.name;
            cloudsPQS.Apply(body, settings, layer2D, layerVolume, altitude, speed, detailSpeed, offset);
        }

        public void Remove()
        {
            cloudsPQS.Remove();
            GameObject go = cloudsPQS.gameObject;
            

            GameObject.DestroyImmediate(cloudsPQS);
            GameObject.DestroyImmediate(go);

        }

    }
}
