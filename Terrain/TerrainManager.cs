using Geometry;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using UnityEngine;

namespace Terrain
{
    [AddComponentMenu("PQuadSphere/Mods/Terrain/Land Control custom")]
    public class PQSLandControlCustom : PQSMod
    {
        public static void Log(String message)
        {
            UnityEngine.Debug.Log("PQSLandControlCustom: " + message);
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

    [KSPAddon(KSPAddon.Startup.MainMenu, false)]
    public class TerrainManager : MonoBehaviour
    {
        static List<CelestialBody> CelestialBodyList = new List<CelestialBody>();
        static bool setup = false;

        public static void Log(String message)
        {
            UnityEngine.Debug.Log("TerrainManager: " + message);
        }

        protected void Awake()
        {
            if (!setup)
            {
                Assembly assembly = Assembly.GetExecutingAssembly();
                //StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Terrain.Shaders.Compiled-Vertex.shader"));
                //StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Terrain.Shaders.Compiled-uv1.shader"));
                //StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Terrain.Shaders.Compiled-Normals.shader"));
                
                //StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Terrain.Shaders.Compiled-Tangents.shader"));
                //StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Terrain.Shaders.Compiled-uv1.shader"));
                //StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Terrain.Shaders.Compiled-uv2.shader"));
                StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Terrain.Shaders.Compiled-SphereTerrain.shader"));

                String shaderTxt = shaderStreamReader.ReadToEnd();
                //String vertShaderTxt = vertshaderStreamReader.ReadToEnd();

                UnityEngine.Object[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody));
                GameObject[] gameObjects = (GameObject[])Resources.FindObjectsOfTypeAll(typeof(GameObject));
                List<Transform> transforms = ScaledSpace.Instance.scaledSpaceTransforms;
                foreach (CelestialBody cb in celestialBodies)
                {
                        CelestialBodyList.Add(cb);
                        Texture mainTexture = null;
                        PQS pqs = cb.pqsController;
                        if (pqs != null)
                        {
                            
                            Log(cb.name);

                            foreach (Transform t in transforms)
                            {
                                if(t.name == cb.name)
                                {
                                    Log("t: " + t.name);
                                    MeshRenderer mr = (MeshRenderer)t.GetComponent(typeof(MeshRenderer));
                                    if (mr != null)
                                    {
                                        Log("Has MR! " + mr.name);
                                        mainTexture = mr.material.mainTexture;
                                        Log("Texture: "+mr.material.name);
                                       // mr.material.shader = new Material(vertShaderTxt).shader;
                                    }
                                }
                            }

                            PQSLandControl landControl = (PQSLandControl)pqs.transform.GetComponentInChildren(typeof(PQSLandControl));
                            PQSMod_HeightColorMap heightColorMap = (PQSMod_HeightColorMap)pqs.transform.GetComponentInChildren(typeof(PQSMod_HeightColorMap));
                            PQSMod_VertexPlanet vertexPlanet = (PQSMod_VertexPlanet)pqs.transform.GetComponentInChildren(typeof(PQSMod_VertexPlanet));
                            if (landControl)
                            {
                                //PQSLandControl landControl = (PQSLandControl)cb.GetComponent(typeof(PQSLandControl));
                                PQSLandControl.LandClass[] landClasses = landControl.landClasses;
                                foreach (PQSLandControl.LandClass lc in landClasses)
                                {
                                    Log("LandControl Land Class: " + lc.landClassName + " " + lc.color);
                                }
                                GameObject go = new GameObject("PQSLandControlCustom");

                                PQSLandControlCustom lcc = (PQSLandControlCustom)go.AddComponent(typeof(PQSLandControlCustom));
                                go.transform.parent = cb.pqsController.transform;
                            }
                            if (heightColorMap)
                            {
                                PQSMod_HeightColorMap.LandClass[] landClasses = heightColorMap.landClasses;
                                foreach (PQSMod_HeightColorMap.LandClass lc in landClasses)
                                {
                                    Log("HeightColorMap Land Class: " + lc.name + " " + lc.color);
                                }
                            }
                            if (vertexPlanet)
                            {
                                PQSMod_VertexPlanet.LandClass[] landClasses = vertexPlanet.landClasses;
                                foreach (PQSMod_VertexPlanet.LandClass lc in landClasses)
                                {
                                    Log("VertexPlanet Land Class: " + lc.name + " " + lc.baseColor);
                                }
                            }

                            if (pqs.surfaceMaterial.GetTexture("_DetailMap") != null)
                            {
                                Log("map!");
                            }
                            if (pqs.surfaceMaterial.GetTexture("_Detail1") != null)
                            {
                                Log("1");
                            }
                            if (pqs.surfaceMaterial.GetTexture("_detail1") != null)
                            {
                                Log("2");
                            }
                            pqs.surfaceMaterial.shader = new Material(shaderTxt).shader;
                            //pqs.surfaceMaterial.mainTexture = mainTexture;
                            pqs.surfaceMaterial.SetTexture("_DetailTex", GameDatabase.Instance.GetTexture("BoulderCo/Terrain/grass",false));
                            pqs.surfaceMaterial.SetTexture("_DetailVertTex", GameDatabase.Instance.GetTexture("BoulderCo/Terrain/rock", false));
                            pqs.surfaceMaterial.SetFloat("_DetailScale", 4000f);
                            pqs.surfaceMaterial.SetFloat("_DetailDist", .00005f);
                        }
                        
                }
                setup = true;
            }
        }
    }
}
