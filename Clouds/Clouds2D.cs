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
    public class Clouds2DMaterial : MaterialManager
    {
        [Persistent] 
        Color _Color = new Color(1,1,1,1);
        [Persistent]
        String _MainTex = "";
        [Persistent]
        String _DetailTex = "";
        [Persistent]
        float _FalloffPow = 2f;
        [Persistent]
        float _FalloffScale = 3f;
        [Persistent]
        float _DetailScale = 100f;
        [Persistent]
        Vector3 _DetailOffset = new Vector3(0, 0, 0);
        [Persistent]
        float _DetailDist = 0.000002f;
        [Persistent]
        float _MinLight = .5f;
        [Persistent]
        float _FadeDist = 8f;
        [Persistent]
        float _FadeScale = 0.00375f;
        [Persistent]
        float _RimDist = 0.0001f;
        [Persistent]
        float _RimDistSub = 1.01f;
    }

    class Clouds2D
    {
        GameObject CloudMesh;
        Material CloudMaterial;
        Projector proj;

        [Persistent]
        float detailSpeed;
        [Persistent]
        Vector3 offset = new Vector3(0, 0, 0);
        [Persistent]
        Clouds2DMaterial macroCloudMaterial;
        [Persistent]
        Clouds2DMaterial scaledCloudMaterial;

        public bool Enabled { get{return CloudMesh.activeSelf;} set { CloudMesh.SetActive(value); } }
        public bool Scaled
        {
            get { return CloudMesh.layer == EVEManagerClass.SCALED_LAYER; }
            set
            {
                if (value)
                {
                    scaledCloudMaterial.ApplyMaterialProperties(CloudMaterial);
                    Reassign(EVEManagerClass.SCALED_LAYER, scaledCelestialTransform, (float)(1000f / celestialBody.Radius) * Vector3.one);
                }
                else
                {
                    macroCloudMaterial.ApplyMaterialProperties(CloudMaterial);
                    Reassign(EVEManagerClass.MACRO_LAYER, celestialBody.transform, Vector3.one);
                    proj.material.SetTexture("_ShadowTex", CloudMaterial.mainTexture);
                    proj.ignoreLayers = 1 << EVEManagerClass.SCALED_LAYER;
                }
            }
        }
        CelestialBody celestialBody = null;
        Transform scaledCelestialTransform = null;
        float radius;
        float globalPeriod;
        float mainPeriodOffset;
        private static Shader cloudShader = null;
        private static Shader CloudShader
        {
            get
            {
                if (cloudShader == null)
                {
                    Assembly assembly = Assembly.GetExecutingAssembly();
                    cloudShader = EVEManagerClass.GetShader(assembly, "Atmosphere.Shaders.Compiled-SphereCloud.shader");
                } return cloudShader;
            }
        }

        private static Shader cloudShadowShader = null;
        private static Shader CloudShadowShader
        {
            get
            {
                if (cloudShadowShader == null)
                {
                    Assembly assembly = Assembly.GetExecutingAssembly();
                    cloudShadowShader = EVEManagerClass.GetShader(assembly, "Atmosphere.Shaders.Compiled-CloudShadow.shader");
                } return cloudShadowShader;
            }
        }

        internal void Apply(CelestialBody celestialBody, Transform scaledCelestialTransform, float radius, float speed)
        {
            Remove();
            this.celestialBody = celestialBody;
            this.scaledCelestialTransform = scaledCelestialTransform;
            this.radius = radius;
            CloudMaterial = new Material(CloudShader);
            HalfSphere hp = new HalfSphere(radius, CloudMaterial);
            CloudMesh = hp.GameObject;
            Scaled = true;
            float circumference = 2f * Mathf.PI * radius;
            globalPeriod = (speed+detailSpeed) / circumference;
            mainPeriodOffset = (-detailSpeed) / circumference;
            proj = new GameObject().AddComponent<Projector>();
            proj.farClipPlane = 2*radius;
            proj.nearClipPlane = 100;
            proj.fieldOfView = 60;
            proj.ignoreLayers = 0;
            proj.aspectRatio = 1;
            proj.orthographic = true;
            proj.orthographicSize = 2 * radius;
            proj.transform.parent = celestialBody.transform;
            proj.transform.localPosition = radius * (celestialBody.transform.InverseTransformDirection(-Sun.Instance.sunDirection));
            proj.material = new Material(CloudShadowShader);
            
        }

        public void Reassign(int layer, Transform parent, Vector3 scale)
        {
            if(parent == null)
            {
                AtmosphereManager.Log("parent is Null");
            }
            if (CloudMesh == null)
            {
                AtmosphereManager.Log("CloudMesh is Null");
            }
            if (CloudMesh.transform == null)
            {
                AtmosphereManager.Log("CloudMesh.transform is Null");
            }
            CloudMesh.transform.parent = parent;
            CloudMesh.transform.localPosition = Vector3.zero;
            CloudMesh.transform.localScale = scale;
            CloudMesh.layer = layer;
        }

        public void Remove()
        {
            if (CloudMesh != null)
            {
                CloudMesh.transform.parent = null;
                GameObject.DestroyImmediate(CloudMesh);
                CloudMesh = null;
            }
        }

        internal void UpdateRotation(Quaternion rotation)
        {
            if (rotation != null)
            {
                SetMeshRotation(rotation);
                proj.transform.localPosition = radius * (celestialBody.transform.InverseTransformDirection(-Sun.Instance.sunDirection));
                proj.transform.forward = Sun.Instance.sunDirection;
            }
            SetTextureOffset();
        }

        private void SetMeshRotation(Quaternion rotation)
        {
            CloudMesh.transform.localRotation = rotation;
            double ut = Planetarium.GetUniversalTime();
            double x = (ut * globalPeriod);
            x -= (int)x;

            CloudMesh.transform.Rotate(CloudMesh.transform.parent.TransformDirection(Vector3.up), (float)(360f * x), Space.World);
            Quaternion rotationForMatrix = CloudMesh.transform.localRotation;
            CloudMesh.transform.localRotation = rotation;
            Matrix4x4 mtrx = Matrix4x4.TRS(Vector3.zero, rotationForMatrix, new Vector3(1, 1, 1));
            CloudMaterial.SetMatrix(EVEManagerClass.ROTATION_PROPERTY, mtrx);
        }

        private void SetTextureOffset()
        {
            double ut = Planetarium.GetUniversalTime();
            double x = (ut * mainPeriodOffset);
            x -= (int)x;
            CloudMaterial.SetVector(EVEManagerClass.MAINOFFSET_PROPERTY, new Vector2((float)x + offset.x, offset.y));
        }
    }
}
