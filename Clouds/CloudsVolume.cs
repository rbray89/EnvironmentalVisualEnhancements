using EVEManager;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using Utils;

namespace Atmosphere
{
    public class particleVolumeMaterial : MaterialManager
    {
        [Persistent]
        Color _Color = new Color(1, 1, 1, 1);
        [Persistent]
        String _TopTex = "";
        [Persistent]
	    String _LeftTex = "";
	    [Persistent]
	    String _FrontTex = "";
	    [Persistent]
	    float _DistFade = 1.0f;
        [Persistent]
        float _DistFadeVert = 0.00004f;
	    [Persistent]
	    float _LightScatter = 0.55f;
	    [Persistent]
	    float _MinLight = .5f;
        [Persistent]
        float _InvFade = .008f;
    }

    class CloudsVolume
    {
        [Persistent]
        String texture;
        [Persistent]
        Vector3 offset = Vector3.zero;
        [Persistent]
        Vector3 size = new Vector3(2500,4500,0);
        [Persistent]
        particleVolumeMaterial particleMaterial;

        Material ParticleMaterial;
        VolumeManager volumeManager;
        GameObject volumeHolder;
        float globalPeriod;

        private static Shader particleCloudShader = null;
        private static Shader ParticleCloudShader
        {
            get
            {
                if (particleCloudShader == null)
                {
                    Assembly assembly = Assembly.GetExecutingAssembly();
                    particleCloudShader = Tools.GetShader(assembly, "Atmosphere.Shaders.Compiled-CloudParticle.shader");
                } return particleCloudShader;
            }
        }

        public void Apply(float radius, float speed, Transform parent)
        {
            Remove();
            ParticleMaterial = new Material(ParticleCloudShader);
            particleMaterial.ApplyMaterialProperties(ParticleMaterial, 1, true);
            volumeHolder = new GameObject();
            volumeHolder.transform.parent = parent;
            volumeHolder.transform.localPosition = Vector3.zero;
            volumeHolder.transform.localScale = Vector3.one;
            volumeHolder.transform.localRotation = Quaternion.identity;
            volumeHolder.layer = EVEManagerClass.MACRO_LAYER;
            volumeManager = new VolumeManager(radius, size, GameDatabase.Instance.GetTexture(texture, false), offset, ParticleMaterial, volumeHolder.transform);
            
            float circumference = 2f * Mathf.PI * radius;
            globalPeriod = speed / circumference;
        }

        public void Remove()
        {
            if (volumeHolder != null)
            {
                volumeHolder.transform.parent = null;
                volumeManager.Destroy();
                volumeManager = null;
                GameObject.Destroy(volumeHolder);
                volumeHolder = null;
            }
        }

        internal void UpdatePos(Vector3 WorldPos)
        {
            if (HighLogic.LoadedScene == GameScenes.FLIGHT || HighLogic.LoadedScene == GameScenes.SPACECENTER)
            {
                double ut = Planetarium.GetUniversalTime();
                double x = (ut * globalPeriod);
                x -= (int)x;
                Quaternion rotation = new Quaternion();
                rotation.eulerAngles = new Vector3(0, (float)(-360f * x), 0);
                volumeHolder.transform.localRotation = rotation;
                Vector3 intendedPoint = volumeHolder.transform.InverseTransformPoint(WorldPos);
                intendedPoint.Normalize();
                volumeManager.Update(intendedPoint);
            }
        }

    }
}
