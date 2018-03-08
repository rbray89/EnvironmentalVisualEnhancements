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
        [ConfigItem, Tooltip("Color to be applied to clouds.")]
        Color _Color = 255*Color.white;
        [ConfigItem, Index(1), ValueFilter("isClamped|format|type|alphaMask"), Tooltip("Main texture used with clouds.")]
        TextureWrapper _MainTex;
        [ConfigItem]
        TextureWrapper _DetailTex;
        [ConfigItem]
        TextureWrapper _UVNoiseTex;
        [ConfigItem]
        float _DetailScale = 200f;
        [ConfigItem, InverseScaled]
        float _DetailDist = 0.000002f;
        [ConfigItem, InverseScaled]
        float _DistFade = 1.0f;
        [ConfigItem, InverseScaled]
        float _DistFadeVert = 0.000085f;
        [ConfigItem]
        float _UVNoiseScale = 0.01f;
        [ConfigItem]
        float _UVNoiseStrength = 0.002f;
        [ConfigItem]
        Vector2 _UVNoiseAnimation = new Vector2(0.4f, 0.2f);
    }

    [ConfigName("name")]
    public class CloudsObject : MonoBehaviour, IEVEObject
    {
#pragma warning disable 0649
        [ConfigItem, GUIHidden]
        new String name;
        [ConfigItem, GUIHidden]
        String body;

        
        [ConfigItem, Tooltip("Altitude above sea level for clouds.")]
        float altitude = 1000f;
        [ConfigItem, Tooltip("Enabling this will stop the cloud from moving with the celestial body.")]
        bool killBodyRotation = false;
        [ConfigItem, Tooltip("Speed of rotation (m/s) applied to main texture of"+
                             "\n each axis of rotation." +
                             "\n First value is applied to axis0, etc.")]
        Vector3 speed = new Vector3(0, 30, 0);
        [ConfigItem, Tooltip("Speed of detail rotation (m/s) applied to XYZ axis of rotation.")]
        Vector3 detailSpeed = new Vector3(0,5,0);
        [ConfigItem, Tooltip("Offset of texturing in degrees around Axis below")]
        Vector3 offset = new Vector3(0, 0, 0);
        [ConfigItem, Tooltip("Axis0 [Default is X-Axis]")]
        Vector3 rotationAxis0 = new Vector3(1,0,0);
        [ConfigItem, Tooltip("Axis1 [Default is Y-Axis]")]
        Vector3 rotationAxis1 = new Vector3(0, 1, 0);
        [ConfigItem, Tooltip("Axis2 [Default is Z-Axis]")]
        Vector3 rotationAxis2 = new Vector3(0, 0, 1);
        [ConfigItem, Tooltip("Amount of sphere covered")]
        float arc = 360f;

        [ConfigItem, Tooltip("Settings for the cloud rendering")]
        CloudsMaterial settings = null;
        
        [ConfigItem, Optional]
        CloudsVolume layerVolume = null;
        [ConfigItem, Optional]
        Clouds2D layer2D = null;

        private CloudsPQS cloudsPQS = null;
        private CelestialBody celestialBody;
        private Transform scaledCelestialTransform;
        public void LoadConfigNode(ConfigNode node)
        {
            ConfigHelper.LoadObjectFromConfig(this, node);
        }

        public void Apply()
        {
            celestialBody = Tools.GetCelestialBody(body);
            scaledCelestialTransform = Tools.GetScaledTransform(body);
            
            GameObject go = new GameObject();
            cloudsPQS = go.AddComponent<CloudsPQS>();
            go.name = "EVE Clouds: "+ this.name;
            Matrix4x4 rotationAxis = new Matrix4x4();
            rotationAxis.SetRow(0, rotationAxis0);
            rotationAxis.SetRow(1, rotationAxis1);
            rotationAxis.SetRow(2, rotationAxis2);
            cloudsPQS.Apply(body, settings, layer2D, layerVolume, altitude, arc, speed, detailSpeed, offset, rotationAxis, killBodyRotation);
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
