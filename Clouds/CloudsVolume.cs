using EVEManager;
using ShaderLoader;
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
        [Persistent, Clamped]
        String _TopTex = "";
        [Persistent, Clamped]
	    String _LeftTex = "";
	    [Persistent, Clamped]
	    String _FrontTex = "";
	    [Persistent]
	    float _LightScatter = 0.55f;
	    [Persistent]
	    float _MinLight = .5f;
        [Persistent]
        float _InvFade = .008f;

        float _MaxScale;
        public float MaxScale { set { _MaxScale = value; } }
        Vector3 _MaxTrans;
        public Vector3 MaxTrans { set { _MaxTrans = value; } }

    }

    class CloudsVolume
    {
        [Persistent]
        Vector3 size = new Vector3(4000, 1, 0);
        [Persistent]
        Vector3 maxTranslation = new Vector3(0, 0, 0);
        [Persistent]
        Vector3 area = new Vector3(24000,4, 0);
        [Persistent]
        float rotationSpeed = .01f;
        [Persistent]
        particleVolumeMaterial particleMaterial;

        Material ParticleMaterial;
        VolumeManager volumeManager;
        GameObject volumeHolder;

        private static Shader particleCloudShader = null;
        private static Shader ParticleCloudShader
        {
            get
            {
                if (particleCloudShader == null)
                {
                    particleCloudShader = ShaderLoaderClass.FindShader("EVE/CloudVolumeParticle");
                } return particleCloudShader;
            }
        }

        public void Apply(CloudsMaterial material, float radius, float speed, Transform parent)
        {
            Remove();
            particleMaterial.MaxScale = size.y;
            particleMaterial.MaxTrans = maxTranslation;

            ParticleMaterial = new Material(ParticleCloudShader);
            particleMaterial.ApplyMaterialProperties(ParticleMaterial);
            material.ApplyMaterialProperties(ParticleMaterial);
            volumeHolder = new GameObject();
            volumeHolder.transform.parent = parent;
            volumeHolder.transform.localPosition = Vector3.zero;
            volumeHolder.transform.localScale = Vector3.one;
            volumeHolder.transform.localRotation = Quaternion.identity;
            volumeHolder.layer = EVEManagerClass.MACRO_LAYER;
            volumeManager = new VolumeManager(radius, size, ParticleMaterial, volumeHolder.transform, area.x, (int)area.y);
            
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

        internal void UpdatePos(Vector3 WorldPos, Quaternion rotation,  Matrix4x4 mainRotationMatrix, Matrix4x4 detailRotationMatrix)
        {
            if (HighLogic.LoadedScene == GameScenes.FLIGHT || HighLogic.LoadedScene == GameScenes.SPACECENTER)
            {
                Vector3 intendedPoint = volumeHolder.transform.InverseTransformPoint(WorldPos);
                intendedPoint.Normalize();
                volumeManager.Update(intendedPoint);

                volumeHolder.transform.localRotation = rotation;

                Matrix4x4 rotationMatrix = mainRotationMatrix* volumeHolder.transform.parent.worldToLocalMatrix;
                ParticleMaterial.SetMatrix(EVEManagerClass.MAIN_ROTATION_PROPERTY, rotationMatrix);
                ParticleMaterial.SetMatrix(EVEManagerClass.DETAIL_ROTATION_PROPERTY, detailRotationMatrix);

                double ut = Planetarium.GetUniversalTime();
                double particleRotation = (ut * rotationSpeed);
                particleRotation -= (int)particleRotation;
                ParticleMaterial.SetFloat(EVEManagerClass.ROTATION_PROPERTY, (float)particleRotation);
            }
        }

    }
}
