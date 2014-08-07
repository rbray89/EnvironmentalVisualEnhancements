using EVEManager;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using Utils;

namespace Terrain
{
    
    public class TerrainMaterial : MaterialManager
    {
        [Persistent] 
        Color _Color = Color.white;
		[Persistent] 
        String _DetailTex = "";
		[Persistent] 
        String _DetailVertTex = "";
        [Persistent]
        float _DetailScale = 4000f;
        [Persistent]
        float _DetailVertScale = 200f;
        [Persistent]
        float _DetailDist = 0.00875f;
        [Persistent]
        float _MinLight = .5f;
        [Persistent]
        float _Albedo = .02f;


        public bool hasDetail { get { return _DetailTex != ""; } }

        public bool hasDetailVert { get {return _DetailVertTex != "";} }

    }

    public class PlanetMaterial : MaterialManager
    {
        [Persistent]
        Color _Color = Color.white;
        [Persistent]
        Color _SpecColor = Color.white;
        [Persistent]
		float _Shininess = 10;
        [Persistent]
        String _DetailTex = "";
        [Persistent]
        String _DetailVertTex = "";
        [Persistent]
        float _DetailScale = 4000f;
        [Persistent]
        float _DetailVertScale = 200f;
        [Persistent]
        float _DetailDist = 0.00875f;
        [Persistent]
        float _MinLight = .5f;
        [Persistent]
        float _Albedo = .02f;
    }

    public class OceanMaterial : MaterialManager
    {
        [Persistent]
        Color _Color = Color.white;
        [Persistent]
        Color _UnderColor = Color.white;
        [Persistent]
        Color _SpecColor = Color.white;
        [Persistent]
        float _Shininess = 10;
        [Persistent]
        String _DetailTex = "";
        [Persistent]
        float _DetailScale = 4000f;
        [Persistent]
        float _DetailDist = 0.00875f;
        [Persistent]
        float _MinLight = .5f;
        [Persistent]
        float _Clarity = .005f;
        [Persistent]
        float _LightPower = 1.75f;
        [Persistent]
        float _Reflectivity = .08f;
    }

    public class TerrainObject : IEVEObject
    {
        public String Name { get { return body; } set { } }
        public ConfigNode ConfigNode { get { return node; } }
        public String Body { get { return body; } }
        private String body;
        private ConfigNode node;
        [Persistent] 
        TerrainMaterial terrainMaterial = null;
        [Persistent, Optional]
        PlanetMaterial planetMaterial = null;
        [Persistent, Optional]
        OceanMaterial oceanMaterial = null;

        private GameObject pqsTerrainContainer;
        private GameObject pqsOceanContainer;
        private Shader originalTerrainShader;
        private Shader originalPlanetShader;
        private Shader originalOceanShader;

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

            CelestialBody celestialBody = EVEManagerClass.GetCelestialBody(body);
            Transform transform = EVEManagerClass.GetScaledTransform(body);
            Texture mainTexture = null;
            Texture bumpTexture = null;
            Texture steepTexture = null;
            Texture lowTexture = null;
            Texture highTexture = null;

            PQS pqs = celestialBody.pqsController;
            if (pqs != null)
            {
                MeshRenderer mr = (MeshRenderer)transform.GetComponent(typeof(MeshRenderer));
                if (mr != null)
                {
                    mainTexture = mr.material.mainTexture;
                    bumpTexture = mr.material.GetTexture("_BumpMap");
                    originalPlanetShader = mr.material.shader;
                    if (planetMaterial != null)
                    {
                        mr.material.shader = new Material(TerrainManager.PlanetShader).shader;
                        planetMaterial.ApplyMaterialProperties(mr.material);
                    }
                }
                
                

                steepTexture = pqs.surfaceMaterial.GetTexture("_steepTex");
                lowTexture = pqs.surfaceMaterial.GetTexture("_lowTex");
                highTexture = pqs.surfaceMaterial.GetTexture("_highTex ");
                originalTerrainShader = pqs.surfaceMaterial.shader;
                TerrainManager.Log("Terrain Shader Name: " + originalTerrainShader.name);
                String[] keywords = pqs.surfaceMaterial.shaderKeywords;
                pqs.surfaceMaterial.shader = TerrainManager.TerrainShader;
                foreach(String keyword in keywords)
                {
                    pqs.surfaceMaterial.EnableKeyword(keyword);
                }
                pqs.surfaceMaterial.mainTexture = mainTexture;
                pqs.surfaceMaterial.SetTexture("_BumpMap", bumpTexture);
                terrainMaterial.ApplyMaterialProperties(pqs.surfaceMaterial);

                if( !terrainMaterial.hasDetailVert )
                {
                    pqs.surfaceMaterial.SetTexture("_DetailVertTex", steepTexture);
                }
                if ( !terrainMaterial.hasDetail)
                {
                    pqs.surfaceMaterial.SetTexture("_DetailTex", lowTexture);
                }
                if (oceanMaterial != null && pqs.ChildSpheres.Length > 0)
                {
                    PQS ocean = pqs.ChildSpheres[0];
                    
                    pqsOceanContainer = new GameObject("PQSTangentAssigner");
                    pqsOceanContainer.transform.parent = ocean.transform;
                    
                    keywords = ocean.surfaceMaterial.shaderKeywords;
                    originalOceanShader = ocean.surfaceMaterial.shader;
                    TerrainManager.Log("Ocean Shader Name: " + originalOceanShader.name);
                    ocean.surfaceMaterial.shader = TerrainManager.OceanShader;
                    foreach (String keyword in keywords)
                    {
                        ocean.surfaceMaterial.EnableKeyword(keyword);
                    }
                    ocean.surfaceMaterial.mainTexture = mainTexture;
                    oceanMaterial.ApplyMaterialProperties(ocean.surfaceMaterial);
                }
                PQSLandControl landControl = (PQSLandControl)pqs.transform.GetComponentInChildren(typeof(PQSLandControl));
                if (landControl != null)
                {
                    PQSLandControl.LandClass[] landClasses = landControl.landClasses;
                    PQSLandControl.LandClass lcBeach = landControl.landClasses.First(lc => lc.landClassName == "BaseBeach");
                    PQSLandControl.LandClass lcOcean = landControl.landClasses.First(lc => lc.landClassName == "Ocean Bottom");
                    lcOcean.color = lcBeach.color;
                }
                PQSMod_CelestialBodyTransform cbt = (PQSMod_CelestialBodyTransform)pqs.transform.GetComponentInChildren(typeof(PQSMod_CelestialBodyTransform));
                if (cbt != null)
                {
                    pqs.surfaceMaterial.SetFloat("_MainTexHandoverDist", (float)(1f/cbt.deactivateAltitude));
                    if (oceanMaterial != null && pqs.ChildSpheres.Length > 0)
                    {
                        PQS ocean = pqs.ChildSpheres[0];
                        ocean.surfaceMaterial.SetFloat("_MainTexHandoverDist", (float)(1f / cbt.deactivateAltitude));
                    }

                }
                

            }
        }


        public void Remove()
        {
            CelestialBody celestialBody = EVEManagerClass.GetCelestialBody(body);
            PQS pqs = celestialBody.pqsController;
            if (pqs != null)
            {
                if (pqsTerrainContainer != null)
                {
                    pqs.surfaceMaterial.shader = originalTerrainShader;
                    pqsTerrainContainer.transform.parent = null;
                    GameObject.Destroy(pqsTerrainContainer);
                    if (pqsOceanContainer != null)
                    {
                        PQS ocean = pqs.ChildSpheres[0];
                        ocean.surfaceMaterial.shader = originalOceanShader;
                        pqsOceanContainer.transform.parent = null;
                        GameObject.Destroy(pqsOceanContainer);
                        pqsOceanContainer = null;
                    }
                }
            }
            if(planetMaterial != null)
            {
                Transform transform = EVEManagerClass.GetScaledTransform(body);
                MeshRenderer mr = (MeshRenderer)transform.GetComponent(typeof(MeshRenderer));
                if (mr != null)
                {
                    mr.material.shader = originalPlanetShader;
                }
            }
        }
    }
}
