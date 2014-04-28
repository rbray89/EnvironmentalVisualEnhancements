using EveManager;
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
    }

    public class TerrainObject : IEVEObject
    {
        private String body;
        private ConfigNode node;
        [Persistent] TerrainMaterial terrainMaterial = null;
        private static Shader originalShader;
        private static Shader terrainShader = null;
        private static Shader TerrainShader
        {
            get
            {
                if (terrainShader == null)
                {
            Assembly assembly = Assembly.GetExecutingAssembly();
            StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Terrain.Shaders.Compiled-SphereTerrain.shader"));
            String shaderTxt = shaderStreamReader.ReadToEnd();
            terrainShader = new Material(shaderTxt).shader;
                } return terrainShader;
            }
        }

        public void LoadConfigNode(ConfigNode node)
        {
            this.node = node;
            ConfigNode.LoadObjectFromConfig(this, node);
            body = node.name;
        }
        public ConfigNode GetConfigNode()
        {
            return ConfigNode.CreateConfigFromObject(this, new ConfigNode(body));
        }

        public void Apply()
        {

            CelestialBody celestialBody = EVEManager.GetCelestialBody(body);
            Transform transform = EVEManager.GetScaledTransform(body);
            Texture mainTexture = null;
            PQS pqs = celestialBody.pqsController;
            if (pqs != null)
            {
                MeshRenderer mr = (MeshRenderer)transform.GetComponent(typeof(MeshRenderer));
                if (mr != null)
                {
                    mainTexture = mr.material.mainTexture;
                }
                GameObject go = new GameObject("PQSTangentAssigner");
                go.AddComponent<PQSTangentAssigner>();
                go.transform.parent = pqs.transform;

                originalShader = pqs.surfaceMaterial.shader;
                pqs.surfaceMaterial.shader = TerrainShader;
                //pqs.surfaceMaterial.mainTexture = mainTexture;
                terrainMaterial.ApplyMaterialProperties(pqs.surfaceMaterial);
            }
        }

        public void Remove()
        {
            CelestialBody celestialBody = EVEManager.GetCelestialBody(body);
            PQS pqs = celestialBody.pqsController;
            if (pqs != null)
            {
                pqs.surfaceMaterial.shader = originalShader;
            }
        }
    }
}
