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


    public class TerrainObject : IEVEObject
    {
        private String body;
        [Persistent] TextureManager detailTexture = null;
        [Persistent] TextureManager verticalTexture = null;
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
            ConfigNode.LoadObjectFromConfig(this, node);
            body = node.name;
        }
        public ConfigNode GetConfigNode()
        {
            return ConfigNode.CreateConfigFromObject(this, new ConfigNode(body));
        }

        public void Apply()
        {
            CelestialBody[] celestialBodies = (CelestialBody[])CelestialBody.FindObjectsOfType(typeof(CelestialBody));
            TerrainManager.Log("CB: "+celestialBodies.Length);
            List<Transform> transforms = ScaledSpace.Instance.scaledSpaceTransforms;
            CelestialBody celestialBody = celestialBodies.Single(n => n.bodyName == body);
            Transform transform = transforms.Single(n => n.name == body);
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
                pqs.surfaceMaterial.SetTexture("_DetailTex", detailTexture.GetTexture());
                pqs.surfaceMaterial.SetFloat("_DetailScale", detailTexture.Scale);
                pqs.surfaceMaterial.SetTexture("_DetailVertTex", verticalTexture.GetTexture());
                pqs.surfaceMaterial.SetFloat("_DetailVertScale", verticalTexture.Scale);
                pqs.surfaceMaterial.SetFloat("_DetailDist", .00005f);
            }
        }

        public void Remove()
        {
            CelestialBody[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody)) as CelestialBody[];
            CelestialBody celestialBody = celestialBodies.Single(n => n.bodyName == body);
            PQS pqs = celestialBody.pqsController;
            if (pqs != null)
            {
                pqs.surfaceMaterial.shader = originalShader;
            }
        }
    }
}
