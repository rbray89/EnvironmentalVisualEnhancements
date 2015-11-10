using EVEManager;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using ShaderLoader;
using UnityEngine;
using Utils;

namespace Atmosphere
{
    public class Clouds2DMaterial : MaterialManager
    {
        [Persistent]
        float _FalloffPow = 2f;
        [Persistent]
        float _FalloffScale = 3f;
        [Persistent]
        float _MinLight = .5f;
        [Persistent, InverseScaled]
        float _RimDist = 0.0001f;
        [Persistent, InverseScaled]
        float _RimDistSub = 1.01f;
        [Persistent, InverseScaled]
        float _InvFade = .008f;
        [Scaled]
        float _Radius = 1000f;

        public float Radius { set { _Radius = value; } }
    }

    class Clouds2D
    {
        GameObject CloudMesh;
        Material CloudMaterial;
        Projector ShadowProjector = null;
        GameObject ShadowProjectorGO = null;
        CloudsMaterial cloudsMat = null;

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
                CloudsManager.Log("Clouds2D is now " + (value ? "SCALED" : "MACRO"));
                if (isScaled != value)
                {
                    if (value)
                    {
                        macroCloudMaterial.ApplyMaterialProperties(CloudMaterial, ScaledSpace.ScaleFactor);
                        cloudsMat.ApplyMaterialProperties(CloudMaterial, ScaledSpace.ScaleFactor);

                        if (ShadowProjector != null)
                        {
                            macroCloudMaterial.ApplyMaterialProperties(ShadowProjector.material, ScaledSpace.ScaleFactor);
                            cloudsMat.ApplyMaterialProperties(ShadowProjector.material, ScaledSpace.ScaleFactor);
                        }
                        float scale = (float)(1000f / celestialBody.Radius);
                        Reassign(EVEManagerClass.SCALED_LAYER, scaledCelestialTransform, scale);
                    }
                    else
                    {
                        macroCloudMaterial.ApplyMaterialProperties(CloudMaterial);
                        cloudsMat.ApplyMaterialProperties(CloudMaterial);

                        if (ShadowProjector != null)
                        {
                            macroCloudMaterial.ApplyMaterialProperties(ShadowProjector.material);
                            cloudsMat.ApplyMaterialProperties(ShadowProjector.material);
                        }
                                                
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
        
        private static Shader cloudShader = null;
        private static Shader CloudShader
        {
            get
            {
                if (cloudShader == null)
                {
                    cloudShader = ShaderLoaderClass.FindShader("EVE/Cloud");
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
                    cloudShadowShader = ShaderLoaderClass.FindShader("EVE/CloudShadow");
                } return cloudShadowShader;
            }
        }

        internal void Apply(CelestialBody celestialBody, Transform scaledCelestialTransform, CloudsMaterial cloudsMaterial, float radius, float speed)
        {
            CloudsManager.Log("Applying 2D clouds...");
            Remove();
            this.celestialBody = celestialBody;
            this.scaledCelestialTransform = scaledCelestialTransform;
            HalfSphere hp = new HalfSphere(radius, ref CloudMaterial, CloudShader);
            CloudMesh = hp.GameObject;
            this.radius = radius;
            macroCloudMaterial.Radius = radius;
            this.cloudsMat = cloudsMaterial;

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

            if (layer == EVEManagerClass.MACRO_LAYER)
            {
                CloudMaterial.SetFloat("_OceanRadius", (float)celestialBody.Radius * scale);
                CloudMaterial.EnableKeyword("WORLD_SPACE_ON");
                CloudMaterial.EnableKeyword("SOFT_DEPTH_ON");
            }
            else
            {
                CloudMaterial.DisableKeyword("WORLD_SPACE_ON");
                CloudMaterial.DisableKeyword("SOFT_DEPTH_ON");
            }
            if (ShadowProjector != null)
            {

                float dist = (float)(2 * worldRadiusScale);
                ShadowProjector.farClipPlane = dist;
                ShadowProjector.orthographicSize = worldRadiusScale;

                ShadowProjector.material.SetFloat("_Radius", (float)radiusScale);
                ShadowProjector.material.SetFloat("_PlanetRadius", (float)celestialBody.Radius*scale);
                ShadowProjector.transform.parent = parent;
                //ShadowProjector.transform.localScale = scale * Vector3.one;
                ShadowProjectorGO.layer = layer;
                if (layer == EVEManagerClass.MACRO_LAYER)
                {
                    ShadowProjector.ignoreLayers = ~((1 << 19) | (1 << 15) | 2 | 1);
                    sunTransform = Tools.GetCelestialBody(Sun.Instance.sun.bodyName).transform;
                    ShadowProjector.material.EnableKeyword("WORLD_SPACE_ON");
                }
                else
                {
                    ShadowProjector.ignoreLayers = ~((1 << 10));
                    sunTransform = Tools.GetScaledTransform(Sun.Instance.sun.bodyName);
                    CloudsManager.Log("Camera mask: "+ScaledCamera.Instance.camera.cullingMask);
                    ShadowProjector.material.DisableKeyword("WORLD_SPACE_ON");
                }
            }
        }

        public void Remove()
        {
            CloudsManager.Log("Removing 2D clouds...");
            if (CloudMesh != null)
            {
                CloudMesh.transform.parent = null;
                GameObject.DestroyImmediate(CloudMesh);
                CloudMesh = null;
            }
            if(ShadowProjectorGO != null)
            {
                ShadowProjectorGO.transform.parent = null;
                ShadowProjector.transform.parent = null;
                GameObject.DestroyImmediate(ShadowProjector);
                GameObject.DestroyImmediate(ShadowProjectorGO);
                ShadowProjector = null;
                ShadowProjectorGO = null;
            }
        }

        internal void UpdateRotation(Quaternion rotation, Matrix4x4 World2Planet, Matrix4x4 mainRotationMatrix, Matrix4x4 detailRotationMatrix)
        {
            if (rotation != null)
            {
                CloudMesh.transform.localRotation = rotation;
                if (ShadowProjector != null)
                {
                    Vector3 worldSunDir = Vector3.Normalize(Sun.Instance.sunDirection);
                    Vector3 sunDirection = Vector3.Normalize(ShadowProjector.transform.parent.InverseTransformDirection(worldSunDir));//sunTransform.position));
                    ShadowProjector.transform.localPosition = radiusScale * -sunDirection;
                    ShadowProjector.transform.forward = worldSunDir;

                    if (Scaled)
                    {
                        ShadowProjector.material.SetVector(EVEManagerClass.SUNDIR_PROPERTY, sunDirection);
                    }
                    else
                    {
                        ShadowProjector.material.SetVector(EVEManagerClass.SUNDIR_PROPERTY, worldSunDir);
                    }
                    
                }
            }
            CloudMaterial.SetVector(EVEManagerClass.PLANET_ORIGIN_PROPERTY, CloudMesh.transform.position);
            SetRotations(World2Planet, mainRotationMatrix, detailRotationMatrix);
        }

        private void SetRotations(Matrix4x4 World2Planet, Matrix4x4 mainRotation, Matrix4x4 detailRotation)
        {
            Matrix4x4 rotation = mainRotation*(World2Planet * CloudMesh.transform.localToWorldMatrix);
            CloudMaterial.SetMatrix(EVEManagerClass.MAIN_ROTATION_PROPERTY, rotation);
            CloudMaterial.SetMatrix(EVEManagerClass.DETAIL_ROTATION_PROPERTY, detailRotation);

            if (ShadowProjector != null)
            {
                if(Scaled)
                {
                    ShadowProjector.material.SetMatrix(EVEManagerClass.MAIN_ROTATION_PROPERTY, mainRotation);
                }
                else
                {
                    ShadowProjector.material.SetMatrix(EVEManagerClass.MAIN_ROTATION_PROPERTY, mainRotation * ShadowProjector.transform.parent.worldToLocalMatrix);
                    ShadowProjector.material.SetVector(EVEManagerClass.PLANET_ORIGIN_PROPERTY, CloudMesh.transform.position);
                }
                
                ShadowProjector.material.SetMatrix(EVEManagerClass.DETAIL_ROTATION_PROPERTY, detailRotation);
            }
        }

    }
}
