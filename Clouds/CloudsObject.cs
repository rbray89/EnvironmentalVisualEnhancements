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
#pragma warning disable 0169
#pragma warning disable 0414
        [Persistent, Tooltip("Color to be applied to clouds.")]
        Color _Color = 256*Color.white;
        [Persistent, ValueNode("isClamped|format|type|alphaMask"), Tooltip("Main texture used with clouds.")]
        TextureWrapper _MainTex;
        [Persistent]
        TextureWrapper _DetailTex;
        [Persistent]
        float _DetailScale = 200f;
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

        
        [Persistent, Tooltip("Altitude above sea level for clouds.")]
        float altitude = 1000f;
        [Persistent, Tooltip("Enabling this will stop the cloud from moving with the celestial body.")]
        bool killBodyRotation = false;
        [Persistent, Tooltip("Speed of rotation (m/s) applied to main texture of"+
                             "\n each axis of rotation." +
                             "\n First value is applied to axis0, etc.")]
        Vector3 speed = new Vector3(0, 30, 0);
        [Persistent, Tooltip("Speed of detail rotation (m/s) applied to XYZ axis of rotation.")]
        Vector3 detailSpeed = new Vector3(0,5,0);
        [Persistent, Tooltip("Offset of texturing in degrees around Axis below")]
        Vector3 offset = new Vector3(0, 0, 0);
        [Persistent, Tooltip("Axis0 [Default is X-Axis]")]
        Vector3 rotationAxis0 = new Vector3(1,0,0);
        [Persistent, Tooltip("Axis1 [Default is Y-Axis]")]
        Vector3 rotationAxis1 = new Vector3(0, 1, 0);
        [Persistent, Tooltip("Axis2 [Default is Z-Axis]")]
        Vector3 rotationAxis2 = new Vector3(0, 0, 1);

        [Persistent, Tooltip("Settings for the cloud rendering")]
        CloudsMaterial settings = null;
        
        [Persistent, Optional]
        CloudsVolume layerVolume = null;
        [Persistent, Optional]
        Clouds2D layer2D = null;

        private CloudsPQS cloudsPQS = null;
        private CelestialBody celestialBody;
        private Transform scaledCelestialTransform;
        public void LoadConfigNode(ConfigNode node, String body)
        {
            ConfigHelper.LoadObjectFromConfig(this, node);
            this.node = node;
            this.body = body;
            name = node.name;
        }

        public void Apply()
        {
            celestialBody = Tools.GetCelestialBody(body);
            scaledCelestialTransform = Tools.GetScaledTransform(body);
            
            GameObject go = new GameObject();
            cloudsPQS = go.AddComponent<CloudsPQS>();
            go.name = this.name;
            Matrix4x4 rotationAxis = new Matrix4x4();
            rotationAxis.SetRow(0, rotationAxis0);
            rotationAxis.SetRow(1, rotationAxis1);
            rotationAxis.SetRow(2, rotationAxis2);
            cloudsPQS.Apply(body, settings, layer2D, layerVolume, altitude, speed, detailSpeed, offset, rotationAxis, killBodyRotation);
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
