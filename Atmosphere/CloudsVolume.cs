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
#pragma warning disable 0169
#pragma warning disable 0414
        [ConfigItem, Clamped]
        TextureWrapper _Tex;
        [ConfigItem]
        float _InvFade = .008f;
        [ConfigItem]
        float _MinScatter = 1.05f;
        [ConfigItem]
        float _Opacity = 1.05f;

        float _MaxScale;
        public float MaxScale { set { _MaxScale = value; } }
        Vector3 _MaxTrans;
        public Vector3 MaxTrans { set { _MaxTrans = value; } }
        Vector3 _NoiseScale;
        public Vector3 NoiseScale { set { _NoiseScale = value; } }
        
    }

    class CloudsVolume
    {
        [ConfigItem, Tooltip("[min size of particle],[max scale of particle]")]
        Vector2 size = new Vector2(4000, 1);
        [ConfigItem, Tooltip("max x,y,z translation of particle")]
        Vector3 maxTranslation = new Vector3(0, 0, 0);
        [ConfigItem, Tooltip("[size of cover],[number of divisions (more is denser particles)]")]
        Vector2 area = new Vector2(24000,4);
        [ConfigItem]
        float rotationSpeed = 0.002f;
        [ConfigItem]
        bool followDetail = false;
        [ConfigItem]
        particleVolumeMaterial particleMaterial = null;
        [ConfigItem]
        Vector3 noiseScale = new Vector3(1.5f, 2.5f, 60);

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

        private bool _enabled = true;
        public bool enabled
        {
            get { return _enabled; }
            set
            {
                _enabled = value;
            }
        }

        public void Apply(CloudsMaterial material, float radius, Transform parent)
        {
            Remove();
            particleMaterial.MaxScale = size.y;
            particleMaterial.MaxTrans = maxTranslation;
            particleMaterial.NoiseScale =  new Vector3(noiseScale.x, noiseScale.y, noiseScale.z / radius);
            ParticleMaterial = new Material(ParticleCloudShader);
            particleMaterial.ApplyMaterialProperties(ParticleMaterial);
            material.ApplyMaterialProperties(ParticleMaterial);
            ParticleMaterial.EnableKeyword("SOFT_DEPTH_ON");

            volumeHolder = new GameObject();
            //Add the renderer here so othe rentities (shadows)
            //can easily access it.
            Renderer r = volumeHolder.AddComponent<MeshRenderer>();
            r.material = ParticleMaterial;
            ParticleMaterial.SetMatrix(ShaderProperties._ShadowBodies_PROPERTY, Matrix4x4.zero);
            ParticleMaterial.renderQueue = (int)Tools.Queue.Transparent + 2;

            r.enabled = false;
            volumeHolder.transform.parent = parent;
            volumeHolder.transform.localPosition = Vector3.zero;
            volumeHolder.transform.localScale = Vector3.one;
            volumeHolder.transform.localRotation = Quaternion.identity;
            volumeHolder.layer = (int)Tools.Layer.Local;
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

        internal void UpdatePos(Vector3 WorldPos, Matrix4x4 World2Planet, QuaternionD rotation, QuaternionD detailRotation, Matrix4x4 mainRotationMatrix, Matrix4x4 detailRotationMatrix)
        {
            if (HighLogic.LoadedScene == GameScenes.FLIGHT || HighLogic.LoadedScene == GameScenes.SPACECENTER)
            {
                Matrix4x4 rotationMatrix = mainRotationMatrix * World2Planet;
                ParticleMaterial.SetMatrix(ShaderProperties.MAIN_ROTATION_PROPERTY, rotationMatrix);
                ParticleMaterial.SetMatrix(ShaderProperties.DETAIL_ROTATION_PROPERTY, detailRotationMatrix);

                if (followDetail)
                {
                    rotationMatrix = detailRotationMatrix * mainRotationMatrix * World2Planet;
                    volumeHolder.transform.localRotation = rotation * detailRotation;
                    ParticleMaterial.SetMatrix(ShaderProperties._PosRotation_Property, rotationMatrix);
                }
                else
                {
                    volumeHolder.transform.localRotation = rotation;
                    ParticleMaterial.SetMatrix(ShaderProperties._PosRotation_Property, rotationMatrix);
                }

                Vector3 intendedPoint = volumeHolder.transform.InverseTransformPoint(WorldPos);
                intendedPoint.Normalize();
                volumeManager.Update(intendedPoint);

                double ut = Planetarium.GetUniversalTime();
                double particleRotation = (ut * rotationSpeed);
                particleRotation -= (int)particleRotation;
                ParticleMaterial.SetFloat(ShaderProperties.ROTATION_PROPERTY, (float)particleRotation);
            }
        }

    }
}
