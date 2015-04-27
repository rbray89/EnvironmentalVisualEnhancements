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
        [Persistent, InverseScaled]
        float _DetailDist = 0.000002f;
        [Persistent]
        float _MinLight = .5f;
        [Persistent, Scaled]
        float _FadeDist = 8f;
        [Persistent, InverseScaled]
        float _FadeScale = 0.00375f;
        [Persistent, InverseScaled]
        float _RimDist = 0.0001f;
        [Persistent, InverseScaled]
        float _RimDistSub = 1.01f;
        [Persistent, InverseScaled]
        float _InvFade = .008f;
    }

    class Clouds2D
    {
        GameObject CloudMesh;
        Material CloudMaterial;
        Projector ShadowProjector = null;
        GameObject ShadowProjectorGO = null;

        [Persistent]
        float detailSpeed;
        [Persistent]
        Vector3 offset = new Vector3(0, 0, 0);
        [Persistent]
        bool shadow = true;
        [Persistent]
        Vector3 shadowOffset = new Vector3(0, 0, 0);
        [Persistent]
        Clouds2DMaterial macroCloudMaterial;

        bool isScaled = false;
        public bool Scaled
        {
            get { return CloudMesh.layer == EVEManagerClass.SCALED_LAYER; }
            set
            {
                AtmosphereManager.Log("Clouds2D is now " + (value ? "SCALED" : "MACRO"));
                if (isScaled != value)
                {
                    if (value)
                    {
                        macroCloudMaterial.ApplyMaterialProperties(CloudMaterial, ScaledSpace.ScaleFactor);
                        macroCloudMaterial.ApplyMaterialProperties(ShadowProjector.material, ScaledSpace.ScaleFactor);
                        float scale = (float)(1000f / celestialBody.Radius);
                        CloudMaterial.DisableKeyword("SOFT_DEPTH_ON");
                        Reassign(EVEManagerClass.SCALED_LAYER, scaledCelestialTransform, scale);
                    }
                    else
                    {
                        macroCloudMaterial.ApplyMaterialProperties(CloudMaterial);
                        macroCloudMaterial.ApplyMaterialProperties(ShadowProjector.material);
                        CloudMaterial.EnableKeyword("SOFT_DEPTH_ON");
                        Reassign(EVEManagerClass.MACRO_LAYER, celestialBody.transform, 1);
                    }
                    isScaled = value;
                }
            }
        }
        CelestialBody celestialBody = null;
        Transform scaledCelestialTransform = null;
        Transform sunTransform;
        float radius;     
        float radiusScale;
        float globalPeriod;
        float mainPeriodOffset;
        float shadowPeriod;
        private static Shader cloudShader = null;
        private static Shader CloudShader
        {
            get
            {
                if (cloudShader == null)
                {
                    Assembly assembly = Assembly.GetExecutingAssembly();
                    cloudShader = Tools.GetShader(assembly, "Atmosphere.Shaders.Compiled-SphereCloud.shader");
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
                    cloudShadowShader = Tools.GetShader(assembly, "Atmosphere.Shaders.Compiled-CloudShadow.shader");
                } return cloudShadowShader;
            }
        }

        internal void Apply(CelestialBody celestialBody, Transform scaledCelestialTransform, float radius, float speed)
        {
            Remove();
            this.celestialBody = celestialBody;
            this.scaledCelestialTransform = scaledCelestialTransform;
            CloudMaterial = new Material(CloudShader);
            HalfSphere hp = new HalfSphere(radius, CloudMaterial);
            CloudMesh = hp.GameObject;
            this.radius = radius;
            float circumference = 2f * Mathf.PI * radius;
            globalPeriod = (speed+detailSpeed) / circumference;
            mainPeriodOffset = (-detailSpeed) / circumference;
            shadowPeriod = (speed) / circumference;
            if (shadow)
            {
                ShadowProjectorGO = new GameObject();
                ShadowProjector = ShadowProjectorGO.AddComponent<Projector>();
                ShadowProjector.nearClipPlane = 10;
                ShadowProjector.fieldOfView = 60;
                ShadowProjector.aspectRatio = 1;
                ShadowProjector.orthographic = true;
                ShadowProjector.transform.parent = celestialBody.transform;
                ShadowProjector.material = new Material(CloudShadowShader);
            }
            sunTransform = Sun.Instance.sun.transform;

            Scaled = true;
        }

        public void Reassign(int layer, Transform parent, float scale)
        {
            CloudMesh.transform.parent = parent;
            CloudMesh.transform.localPosition = Vector3.zero;
            CloudMesh.transform.localScale = scale * Vector3.one;
            CloudMesh.layer = layer;

            radiusScale = radius * scale;
            float worldRadiusScale = Vector3.Distance(parent.transform.TransformPoint(Vector3.up * radiusScale), parent.transform.TransformPoint(Vector3.zero));
            
            if (ShadowProjector != null)
            {

                float dist = (float)(2 * worldRadiusScale);
                ShadowProjector.farClipPlane = dist;
                ShadowProjector.orthographicSize = worldRadiusScale;

                ShadowProjector.transform.parent = parent;
                //ShadowProjector.transform.localScale = scale * Vector3.one;
                ShadowProjectorGO.layer = layer;
                if (layer == EVEManagerClass.MACRO_LAYER)
                {
                    ShadowProjector.ignoreLayers = ~((1 << 19) | (1 << 15) | 2 | 1);
                    sunTransform = Tools.GetCelestialBody(Sun.Instance.sun.bodyName).transform;
                }
                else
                {
                    ShadowProjectorGO.layer = EVEManagerClass.SCALED_LAYER;
                    ShadowProjector.ignoreLayers = ~((1 << 29) | (1 << 23) | (1 << 18) | (1 << 10));// | (1 << 9));
                    sunTransform = Tools.GetScaledTransform(Sun.Instance.sun.bodyName);
                    AtmosphereManager.Log("Camera mask: "+ScaledCamera.Instance.camera.cullingMask);
                }
            }
        }

        public void Remove()
        {
            if (CloudMesh != null)
            {
                CloudMesh.transform.parent = null;
                GameObject.DestroyImmediate(CloudMesh);
                CloudMesh = null;
            }
            if(ShadowProjector != null)
            {
                ShadowProjector.transform.parent = null;
                GameObject.DestroyImmediate(ShadowProjector);
                ShadowProjector = null;
            }
        }

        internal void UpdateRotation(Quaternion rotation)
        {
            if (rotation != null)
            {
                SetMeshRotation(rotation);
                if (ShadowProjector != null)
                {
                    Vector3 worldSunDir = Vector3.Normalize(Sun.Instance.sunDirection);
                    Vector3 sunDirection = Vector3.Normalize(ShadowProjector.transform.parent.InverseTransformDirection(worldSunDir));//sunTransform.position));
                    ShadowProjector.transform.localPosition = radiusScale * -sunDirection;
                    ShadowProjector.transform.forward = worldSunDir;
                }
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
            Vector2 texOffset = new Vector2((float)x + offset.x, offset.y);
            CloudMaterial.SetVector(EVEManagerClass.MAINOFFSET_PROPERTY, texOffset);

            if (ShadowProjector != null)
            {
                x = (ut * shadowPeriod);
                x -= (int)x;
                Vector4 texVect = ShadowProjector.transform.localPosition.normalized;

                texVect.w = ((float)x + offset.x + .25f);
                ShadowProjector.material.SetVector(EVEManagerClass.MAINOFFSET_PROPERTY, texVect);
            }
        }

    }
}
