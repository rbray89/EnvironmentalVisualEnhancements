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
    //[KSPAddon(KSPAddon.Startup.MainMenu, false)]
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
                UnityEngine.Object[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody));
                foreach (CelestialBody cb in celestialBodies)
                {
                    CelestialBodyList.Add(cb);
                    if (cb.name == "Kerbin")
                    {
                        PQS pqs = cb.pqsController;
                        if(cb == GameObject.Find("localSpace").transform.FindChild("Kerbin"))
                        {
                            Log("CB and localspace are equal!");

                        }
                        Assembly assembly = Assembly.GetExecutingAssembly();
                        StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Terrain.Shaders.Compiled-Vertex.shader"));
                        //StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Terrain.Shaders.Compiled-Normals.shader"));
                        //StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Terrain.Shaders.Compiled-Tangents.shader"));
                        //StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Terrain.Shaders.Compiled-uv1.shader"));
                        //StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Terrain.Shaders.Compiled-uv2.shader"));
                        //StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Terrain.Shaders.Compiled-Terrain.shader"));

                        Log("reading stream...");
                        String shaderTxt = shaderStreamReader.ReadToEnd();
                        pqs.surfaceMaterial.shader = Shader.Find("VertexLit");
                        
                        pqs.ChildSpheres[0].surfaceMaterial.shader = new Material(shaderTxt).shader;

                    }
                }
                setup = true;
            }
        }
    }
}
