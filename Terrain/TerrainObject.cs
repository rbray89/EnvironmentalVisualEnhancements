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
    public class PQSTangentAssigner : PQSMod
    {
        private void assignTangent(PQ quad)
        {
            Vector4[] tangents = quad.mesh.tangents;
            Vector3[] normals = quad.mesh.normals;
            Vector3[] verts = quad.mesh.vertices;
            for (int i = 0; i < tangents.Length; i++)
            {
                Vector3 normal = this.sphere.transform.InverseTransformPoint(quad.transform.TransformPoint(verts[i])).normalized;
                tangents[i] = normal;
            }
            quad.mesh.tangents = tangents;
        }
        public override void OnQuadBuilt(PQ quad)
        {
            assignTangent(quad);
        }
        public override void OnQuadUpdate(PQ quad)
        {
            assignTangent(quad);
        }
    }

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
        float _Albedo = 1.2f;
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
        float _Albedo = 1.2f;
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
            PQS pqs = celestialBody.pqsController;
            if (pqs != null)
            {
                MeshRenderer mr = (MeshRenderer)transform.GetComponent(typeof(MeshRenderer));
                if (mr != null)
                {
                    mainTexture = mr.material.mainTexture;
                    originalPlanetShader = mr.material.shader;
                    if (planetMaterial != null)
                    {
                        mr.material.shader = new Material(TerrainManager.PlanetShader).shader;
                        planetMaterial.ApplyMaterialProperties(mr.material);
                    }
                }
                
                pqsTerrainContainer = new GameObject("PQSTangentAssigner");
                pqsTerrainContainer.AddComponent<PQSTangentAssigner>();
                pqsTerrainContainer.transform.parent = pqs.transform;
                
                originalTerrainShader = pqs.surfaceMaterial.shader;
                String[] keywords = pqs.surfaceMaterial.shaderKeywords;
                pqs.surfaceMaterial.shader = TerrainManager.TerrainShader;
                foreach(String keyword in keywords)
                {
                    pqs.surfaceMaterial.EnableKeyword(keyword);
                }
                //pqs.surfaceMaterial.mainTexture = mainTexture;
                terrainMaterial.ApplyMaterialProperties(pqs.surfaceMaterial);
                
                if (oceanMaterial != null && pqs.ChildSpheres.Length > 0)
                {
                    PQS ocean = pqs.ChildSpheres[0];
                    
                    pqsOceanContainer = new GameObject("PQSTangentAssigner");
                    PQSTangentAssigner tas = pqsOceanContainer.AddComponent<PQSTangentAssigner>();
                    pqsOceanContainer.transform.parent = ocean.transform;
                    
                    keywords = ocean.surfaceMaterial.shaderKeywords;
                    originalOceanShader = ocean.surfaceMaterial.shader;
                    ocean.surfaceMaterial.shader = TerrainManager.OceanShader;
                    foreach (String keyword in keywords)
                    {
                        ocean.surfaceMaterial.EnableKeyword(keyword);
                    }
                    //ocean.surfaceMaterial.mainTexture = mainTexture;
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
