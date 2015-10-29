
using EVEManager;
using ShaderLoader;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Terrain;
using UnityEngine;
using Utils;

namespace CityLights
{
    public class CityLightsMaterial : MaterialManager
    {
        [Persistent]
        String _CityOverlayTex = "";
        [Persistent]
        float _CityOverlayDetailScale = 80f;
        [Persistent]
        String _CityDarkOverlayDetailTex = "";
        [Persistent]
        String _CityLightOverlayDetailTex = "";
    }

    public class MaterialPQS : PQSMod
    {
        Material material;
        Material PQSMaterial;
        PQS parent;
        public void Set(CelestialBody cb, Material mat)
        {
            material = mat;

            PQS pqs = null;
            if (cb != null && cb.pqsController != null)
            {
                pqs = cb.pqsController;
                parent = pqs;
                PQSMaterial = pqs.surfaceMaterial;
            }
            else
            {
                CityLightsManager.Log("No PQS!");
            }
            if (pqs != null)
            {
                this.sphere = pqs;
                this.transform.parent = pqs.transform;
                this.transform.localPosition = Vector3.zero;
                this.transform.localRotation = Quaternion.identity;
                this.transform.localScale = Vector3.one;
            }
        }

        public override void OnQuadCreate(PQ quad)
        {
            if (parent.useSharedMaterial)
            {
                quad.meshRenderer.sharedMaterials = new Material[] { PQSMaterial, material };
            }
            else
            {
                quad.meshRenderer.materials = new Material[] { PQSMaterial, material };
            }
        }

      /*  protected void Update()
        {
            Vector3 sunDir = this.transform.InverseTransformDirection(Sun.Instance.sunDirection);
            material.SetVector(EVEManagerClass.SUNDIR_PROPERTY, sunDir);
            //Vector3 planetOrigin = this.transform.position;
            //material.SetVector(EVEManagerClass.PLANET_ORIGIN_PROPERTY, planetOrigin);
        }*/
    }

        public class CityLightsObject : IEVEObject
    {
        public String Name { get { return body; } set { } }
        public ConfigNode ConfigNode { get { return node; } }
        public String Body { get { return body; } }
        private String body;
        private ConfigNode node;
        private MaterialPQS materialPQS;
        [Persistent]
        CityLightsMaterial cityLightsMaterial = null;
        Material scaledMat;
        Material macroMat;

        public void LoadConfigNode(ConfigNode node, String body)
        {
            ConfigNode.LoadObjectFromConfig(this, node);
            this.node = node;
            this.body = body;
        }
        public ConfigNode GetConfigNode()
        {
            return ConfigNode.CreateConfigFromObject(this, new ConfigNode(body));
        }

        public void Apply()
        {
            CelestialBody celestialBody = Tools.GetCelestialBody(body);
            TerrainMaterial test = new TerrainMaterial();
            if (celestialBody != null)
            {
                GameObject go = new GameObject();
                materialPQS = go.AddComponent<MaterialPQS>();
                macroMat = new Material(ShaderLoaderClass.FindShader("EVE/TerrainCityLight"));
                test.ApplyMaterialProperties(macroMat);
                cityLightsMaterial.ApplyMaterialProperties(macroMat);
                materialPQS.Set(celestialBody, macroMat);
            }
            Transform transform = Tools.GetScaledTransform(body);
            if (transform != null)
            {
                MeshRenderer mr = (MeshRenderer)transform.GetComponent(typeof(MeshRenderer));
                if (mr != null)
                {
                    scaledMat = new Material(ShaderLoaderClass.FindShader("EVE/PlanetCityLight"));
                   
                    test.ApplyMaterialProperties(scaledMat);
                    cityLightsMaterial.ApplyMaterialProperties(scaledMat);
                    scaledMat.SetTexture("_MainTex", mr.material.GetTexture("_MainTex"));
                    Material[] materials = new Material[] { mr.material, scaledMat };
                    mr.materials = materials;
                    
                }
            }
        }

        public void Remove()
        {
            CelestialBody celestialBody = Tools.GetCelestialBody(body);
            if (celestialBody != null)
            {
                celestialBody.pqsController.surfaceMaterial.DisableKeyword("CITYOVERLAY_ON");
            }
            Transform transform = Tools.GetScaledTransform(body);
            if (transform != null)
            {
                MeshRenderer mr = (MeshRenderer)transform.GetComponent(typeof(MeshRenderer));
                if (mr != null)
                {
                    mr.material.DisableKeyword("CITYOVERLAY_ON");
                }
            }
        }
    }

}
