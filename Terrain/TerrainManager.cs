using Utils;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using EveManager;

namespace Terrain
{

    public class PQSTangentAssigner : PQSMod
    {
        public static void Log(String message)
        {
            UnityEngine.Debug.Log("PQSTangentAssigner: " + message);
        }
        
        private void assignTangent(PQ quad)
        {
            Vector4[] tangents = quad.mesh.tangents;
            Vector3[] verts = quad.mesh.vertices;
            for (int i = 0; i < tangents.Length; i++)
            {
                //Log("C " + colors[i]);
                Vector3 normal = this.sphere.transform.InverseTransformPoint(quad.transform.TransformPoint(verts[i])).normalized;
                tangents[i] = normal;
            }
            quad.mesh.tangents = tangents;
        }
        public override void OnQuadCreate(PQ quad)
        {
        //    assignTangent(quad);
        }
        public override void OnQuadBuilt(PQ quad)
        {
            assignTangent(quad);
        }
        public override void OnQuadUpdate(PQ quad)
        {
            assignTangent(quad);
        }
        public override void OnQuadPreBuild(PQ quad)
        {
        //    assignTangent(quad);
        }
        public override void OnQuadUpdateNormals(PQ quad)
        {
        //    assignTangent(quad);
        }
    }

    public class TerrainObj
    {
        private String body;
        [Persistent] TextureManager detailTexture;
        [Persistent] TextureManager verticalTexture;
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

        public TerrainObj(ConfigNode node)
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
            CelestialBody[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody)) as CelestialBody[];
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
                TerrainManager.Log("Replacing Terrain: " + TerrainShader);
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

    public class TerrainManager : EveManagerType
    {
        static bool Initialized = false;
        static List<TerrainObj> TerrainList = new List<TerrainObj>();
        static UrlDir.UrlConfig[] configs;

        public static void Log(String message)
        {
            UnityEngine.Debug.Log("TerrainManager: " + message);
        }

        protected void Awake()
        {
            if (HighLogic.LoadedScene == GameScenes.MAINMENU && !Initialized)
            {
                Setup();
            }
        }

        public static void StaticSetup()
        {
            TerrainManager tm = new TerrainManager();
            tm.Setup();
        }

        public void Setup()
        {
            Initialized = true;
            Managers.Add(this);
            LoadConfig();
        }

        public override void LoadConfig()
        {
            configs = GameDatabase.Instance.GetConfigs("EVE_TERRAIN");
            Clean();
            foreach (UrlDir.UrlConfig config in configs)
            {
                foreach (ConfigNode node in config.config.nodes)
                {
                    TerrainObj terrain = new TerrainObj(node);
                    TerrainList.Add(terrain);
                    terrain.Apply();
                }
            }
        }

        private void Clean()
        {
            foreach (TerrainObj terrain in TerrainList)
            {
                terrain.Remove();
            }
            TerrainList.Clear();
        }

        public override void SaveConfig()
        {
            Log("Saving...");
            foreach (UrlDir.UrlConfig config in configs)
            {
                config.config.ClearNodes();
                foreach (TerrainObj terrain in TerrainList)
                {
                    config.config.AddNode(terrain.GetConfigNode());
                }
            }
        }
    }
}
