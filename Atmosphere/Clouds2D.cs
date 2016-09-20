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
#pragma warning disable 0169
#pragma warning disable 0414
        [ConfigItem]
        float _FalloffPow = 2f;
        [ConfigItem]
        float _FalloffScale = 3f;
        [ConfigItem]
        float _MinLight = 0f;
        [ConfigItem, InverseScaled]
        float _RimDist = 0.0001f;
        [ConfigItem, InverseScaled]
        float _RimDistSub = 1.01f;
        [ConfigItem, InverseScaled]
        float _InvFade = .008f;
        [Scaled]
        float _Radius = 1000f;

        public float Radius { set { _Radius = value; } }
    }

    public class CloudShadowMaterial : MaterialManager
    {
        [ConfigItem]
        float _ShadowFactor = .75f;
    }

    class Clouds2D
    {
        GameObject CloudMesh;
        Material CloudMaterial;
        Projector ShadowProjector = null;
        GameObject ShadowProjectorGO = null;
        CloudsMaterial cloudsMat = null;
        
        [ConfigItem]
        Clouds2DMaterial macroCloudMaterial = null;
        [ConfigItem, Optional]
        CloudShadowMaterial shadowMaterial = null;

        Tools.Layer scaledLayer = Tools.Layer.Scaled;
        Light Sunlight;
        bool isScaled = false;
        public bool Scaled
        {
            get { return isScaled; }
            set
            {
                CloudsManager.Log("Clouds2D is now " + (value ? "SCALED" : "MACRO"));
                if (isScaled != value)
                {
                    if (value)
                    {
                        Reassign(scaledLayer, scaledCelestialTransform, ScaledSpace.InverseScaleFactor);
                    }
                    else
                    {                                                
                        Reassign(Tools.Layer.Local, celestialBody.transform, 1);
                    }
                    isScaled = value;
                }
            }
        }
        CelestialBody celestialBody = null;
        Transform scaledCelestialTransform = null;
        float radius;
        float radiusScaleLocal;
        private bool isMainMenu = false;

        private static Shader cloudShader = null;

        internal Clouds2D CloneForMainMenu(GameObject mainMenuBody)
        {
            Clouds2D mainMenu = new Clouds2D();
            mainMenu.macroCloudMaterial = this.macroCloudMaterial;
            mainMenu.shadowMaterial = this.shadowMaterial;
            mainMenu.isMainMenu = true;
            mainMenu.Apply(this.celestialBody, mainMenuBody.transform, this.cloudsMat, this.radius, (Tools.Layer)mainMenuBody.layer);
            
            return mainMenu;
        }

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

        private bool _enabled = true;

        public bool enabled { get {return _enabled; }
            set
            {
                _enabled = value;
                if (CloudMesh != null)
                {
                    CloudMesh.SetActive(value);
                }
                if (ShadowProjector != null)
                {
                    ShadowProjector.enabled = value;
                }
            } }

        internal void Apply(CelestialBody celestialBody, Transform scaledCelestialTransform, CloudsMaterial cloudsMaterial, float radius, Tools.Layer layer = Tools.Layer.Scaled)
        {
            CloudsManager.Log("Applying 2D clouds...");
            Remove();
            this.celestialBody = celestialBody;
            this.scaledCelestialTransform = scaledCelestialTransform;
            HalfSphere hp = new HalfSphere(radius, ref CloudMaterial, CloudShader);
            CloudMesh = hp.GameObject;
            CloudMaterial.name = "Clouds2D";
            this.radius = radius;
            macroCloudMaterial.Radius = radius;
            this.cloudsMat = cloudsMaterial;
            this.scaledLayer = layer;

            CloudMaterial.SetMatrix(ShaderProperties._ShadowBodies_PROPERTY, Matrix4x4.zero);

            if (shadowMaterial != null)
            {
                ShadowProjectorGO = new GameObject();
                ShadowProjector = ShadowProjectorGO.AddComponent<Projector>();
                ShadowProjector.nearClipPlane = 10;
                ShadowProjector.fieldOfView = 60;
                ShadowProjector.aspectRatio = 1;
                ShadowProjector.orthographic = true;
                ShadowProjector.transform.parent = celestialBody.transform;
                ShadowProjector.material = new Material(CloudShadowShader);
                shadowMaterial.ApplyMaterialProperties(ShadowProjector.material);
            }


            
            Scaled = true;
        }

        public void Reassign(Tools.Layer layer, Transform parent, float worldScale)
        {
            CloudMesh.transform.parent = parent;
            CloudMesh.transform.localPosition = Vector3.zero;

            float localScale;
            if (isMainMenu)
            {
                localScale = worldScale * 10f;
            }
            else
            {
                localScale = (worldScale / parent.lossyScale.x);
            }

            CloudMesh.transform.localScale = (Vector3.one)*localScale;
            CloudMesh.layer = (int)layer;

            float radiusScaleWorld = radius * worldScale;
            radiusScaleLocal = radius * localScale;


            macroCloudMaterial.ApplyMaterialProperties(CloudMaterial, worldScale);
            cloudsMat.ApplyMaterialProperties(CloudMaterial, worldScale);

            if (layer == Tools.Layer.Local)
            {
                Sunlight = Sun.Instance.GetComponent<Light>();
                
                CloudMaterial.SetFloat("_OceanRadius", (float)celestialBody.Radius * worldScale);
                CloudMaterial.EnableKeyword("WORLD_SPACE_ON");
                CloudMaterial.EnableKeyword("SOFT_DEPTH_ON");
                CloudMaterial.renderQueue = (int)Tools.Queue.Transparent + 2;
            }
            else
            {
                //hack to get protected variable
                FieldInfo field = typeof(Sun).GetFields(BindingFlags.Instance | BindingFlags.NonPublic).First(
                    f => f.Name == "scaledSunLight" );
                Sunlight = (Light)field.GetValue(Sun.Instance);
                CloudMaterial.DisableKeyword("WORLD_SPACE_ON");
                CloudMaterial.DisableKeyword("SOFT_DEPTH_ON");
                CloudMaterial.renderQueue = (int)Tools.Queue.Transparent -1;
            }

            if(isMainMenu)
            {
                try
                {
                    Sunlight = GameObject.FindObjectsOfType<Light>().Last(l => l.isActiveAndEnabled);
                }
                catch { }
            }

            if (ShadowProjector != null)
            {

                float dist = (float)(2 * radiusScaleWorld);
                ShadowProjector.farClipPlane = dist;
                ShadowProjector.orthographicSize = radiusScaleWorld;

                macroCloudMaterial.ApplyMaterialProperties(ShadowProjector.material, worldScale);
                cloudsMat.ApplyMaterialProperties(ShadowProjector.material, worldScale);

                ShadowProjector.material.SetFloat("_Radius", (float)radiusScaleLocal);
                ShadowProjector.material.SetFloat("_PlanetRadius", (float)celestialBody.Radius*worldScale);
                ShadowProjector.transform.parent = parent;

                ShadowProjectorGO.layer = (int)layer;
                if (layer == Tools.Layer.Local)
                {
                    ShadowProjector.ignoreLayers = ~(Tools.Layer.Default.Mask() |
                                                     Tools.Layer.TransparentFX.Mask() |
                                                     Tools.Layer.Water.Mask() |
                                                     Tools.Layer.Local.Mask() |
                                                     Tools.Layer.Kerbals.Mask() |
                                                     Tools.Layer.Parts.Mask());
                    ShadowProjector.material.EnableKeyword("WORLD_SPACE_ON");
                }
                else
                {
                    ShadowProjector.ignoreLayers = ~layer.Mask();
                    ShadowProjector.material.DisableKeyword("WORLD_SPACE_ON");
                }
                
            }
        }

        public void Remove()
        {
            if (CloudMesh != null)
            {
                CloudsManager.Log("Removing 2D clouds...");
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

        internal void UpdateRotation(QuaternionD rotation, Matrix4x4 World2Planet, Matrix4x4 mainRotationMatrix, Matrix4x4 detailRotationMatrix)
        {
            if (rotation != null)
            {
                CloudMesh.transform.localRotation = rotation;
                if (ShadowProjector != null && Sunlight != null)
                {
                    Vector3 worldSunDir;
                    Vector3 sunDirection;
                    //AtmosphereManager.Log("light: " + Sunlight.intensity);
                    //AtmosphereManager.Log("light: " + Sunlight.color);

                    worldSunDir = Vector3.Normalize(Sunlight.transform.forward);
                    sunDirection = Vector3.Normalize(ShadowProjector.transform.parent.InverseTransformDirection(worldSunDir));

                    ShadowProjector.transform.localPosition = radiusScaleLocal * -sunDirection;
                    ShadowProjector.transform.forward = worldSunDir;

                    if (Scaled)
                    {
                        ShadowProjector.material.SetVector(ShaderProperties.SUNDIR_PROPERTY, sunDirection); 
                    }
                    else
                    {
                        ShadowProjector.material.SetVector(ShaderProperties.SUNDIR_PROPERTY, worldSunDir);
                    }

                }
            }
            CloudMaterial.SetVector(ShaderProperties.PLANET_ORIGIN_PROPERTY, CloudMesh.transform.position);
            SetRotations(World2Planet, mainRotationMatrix, detailRotationMatrix);
        }

        private void SetRotations(Matrix4x4 World2Planet, Matrix4x4 mainRotation, Matrix4x4 detailRotation)
        {
            Matrix4x4 rotation = (mainRotation*World2Planet) * CloudMesh.transform.localToWorldMatrix;
            CloudMaterial.SetMatrix(ShaderProperties.MAIN_ROTATION_PROPERTY, rotation);
            CloudMaterial.SetMatrix(ShaderProperties.DETAIL_ROTATION_PROPERTY, detailRotation);

            if (ShadowProjector != null)
            {
                if(Scaled)
                {
                    ShadowProjector.material.SetMatrix(ShaderProperties.MAIN_ROTATION_PROPERTY, mainRotation);
                }
                else
                {
                    ShadowProjector.material.SetMatrix(ShaderProperties.MAIN_ROTATION_PROPERTY, mainRotation * ShadowProjector.transform.parent.worldToLocalMatrix);
                    ShadowProjector.material.SetVector(ShaderProperties.PLANET_ORIGIN_PROPERTY, ShadowProjector.transform.parent.position);
                }

                ShadowProjector.material.SetMatrix(ShaderProperties.DETAIL_ROTATION_PROPERTY, detailRotation);
            }
        }

    }
}
