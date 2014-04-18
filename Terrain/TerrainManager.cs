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
            //LC.OnQuadBuilt(quad);
            Vector4[] tangents = quad.mesh.tangents;
            Vector3[] verts = quad.mesh.vertices;
            //Log("tangents " + tangents.Length + " verts " + verts.Length);
            Log("p " + quad.transform.localPosition);
            Log("planet " + quad.positionPlanet + " " + quad.positionPlanetRelative);
            for (int i = 0; i < tangents.Length; i++)
            {
                //Log("V "+verts[i]);
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
         //   assignTangent(quad);
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
                //StreamReader vertshaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Terrain.Shaders.Compiled-Vertex.shader"));
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
                            if (landControl != null)
                            {
                                //PQSLandControl landControl = (PQSLandControl)cb.GetComponent(typeof(PQSLandControl));
                                PQSLandControl.LandClass[] landClasses = landControl.landClasses;
                                foreach (PQSLandControl.LandClass lc in landClasses)
                                {
                                    Log("Land Class: " + lc.landClassName + " " + lc.color);
                                }
                                GameObject go = new GameObject("PQSLandControlCustom");

                                PQSLandControlCustom lcc = (PQSLandControlCustom)go.AddComponent(typeof(PQSLandControlCustom));
                                go.transform.parent = cb.pqsController.transform;
                            }
                            else if (heightColorMap)
                            {
                                PQSMod_HeightColorMap.LandClass[] landClasses = heightColorMap.landClasses;
                                foreach (PQSMod_HeightColorMap.LandClass lc in landClasses)
                                {
                                    Log("Land Class: " + lc.name + " " + lc.color);
                                }
                            }
                            else if (vertexPlanet)
                            {
                                PQSMod_VertexPlanet.LandClass[] landClasses = vertexPlanet.landClasses;
                                foreach (PQSMod_VertexPlanet.LandClass lc in landClasses)
                                {
                                    Log("Land Class: " + lc.name + " " + lc.baseColor);
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
                            pqs.surfaceMaterial.mainTexture = mainTexture;
                        }
                        
                }
                setup = true;
            }
        }
    }
}
