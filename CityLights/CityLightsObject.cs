
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
        #pragma warning disable 0414
        String _CityOverlayTex = "";
        [Persistent]
        float _CityOverlayDetailScale = 80f;
        [Persistent]
        String _CityDarkOverlayDetailTex = "";
        [Persistent]
        String _CityLightOverlayDetailTex = "";
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
        String materialName = Guid.NewGuid().ToString();

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
                materialPQS.Apply(celestialBody, macroMat);
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
                    scaledMat.name = materialName;
                    List<Material> materials = new List<Material>(mr.materials);
                    materials.Add(scaledMat);
                    mr.materials = materials.ToArray();
                    
                }
            }
        }

        public void Remove()
        {
            CelestialBody celestialBody = Tools.GetCelestialBody(body);
            CityLightsManager.Log("Removing City Lights obj");
            Transform transform = Tools.GetScaledTransform(body);
            if (transform != null)
            {
                MeshRenderer mr = (MeshRenderer)transform.GetComponent(typeof(MeshRenderer));
                if (mr != null)
                {
                    List<Material> materials = new List<Material>(mr.materials);
                    materials.Remove(materials.Find(mat => mat.name.Contains(materialName)));
                    mr.materials = materials.ToArray();
                }
            }
            materialPQS.Remove();
            GameObject.DestroyImmediate(materialPQS);
        }
    }

}
