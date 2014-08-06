using EVEManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;

namespace ShaderReplacer
{
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class ShaderReplacer : MonoBehaviour
    {
        static Dictionary<String, Shader> shaderDictionary = new Dictionary<String, Shader>();
        private void Awake()
        {
            if (HighLogic.LoadedScene == GameScenes.MAINMENU || HighLogic.LoadedScene == GameScenes.SPACECENTER || HighLogic.LoadedScene == GameScenes.FLIGHT)
            {
                GameEvents.onGameSceneLoadRequested.Add(GameSceneLoaded);
            }
        }

        public static Shader GetShaderFromName(String name)
        {
            if (shaderDictionary.ContainsKey(name))
            {
                return shaderDictionary[name];
            }
            else
            {
                Assembly assembly = Assembly.GetExecutingAssembly();
                Shader shader = EVEManagerClass.GetShader(assembly, "ShaderReplacer.Shaders.Compiled-" + name + ".shader");
                shaderDictionary[name] = shader;
                return shader;
            }
        }

        private void GameSceneLoaded(GameScenes scene)
        {
            if (scene == GameScenes.SPACECENTER || scene == GameScenes.FLIGHT)
            {
                foreach (GameObject go in GameObject.FindObjectsOfType<GameObject>())
                {
                    MeshRenderer mr = go.GetComponent<MeshRenderer>();
                    if (mr != null)
                    {
                        List<Material> materials = mr.materials.ToList();
                        materials.AddRange(mr.sharedMaterials);
                        foreach (Material mat in materials)
                        {
                            ReplaceShader(mat);
                        }
                    }
                }
                CelestialBody[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody)) as CelestialBody[];
                foreach (CelestialBody cb in celestialBodies)
                {
                    if (cb.pqsController != null)
                    {
                        ReplaceShader(cb.pqsController.surfaceMaterial);

                        if (cb.pqsController.ChildSpheres != null)
                        {
                            foreach (PQS pqs in cb.pqsController.ChildSpheres)
                            {
                                ReplaceShader(pqs.surfaceMaterial);
                            }
                        }
                    }
                }
            }
        }

        public static void ReplaceShader(Material mat)
        {
            String name = mat.shader.name;
            Shader replacementShader = null;
            switch (name)
            {
                case "KSP/Diffuse":
                    replacementShader = GetShaderFromName("Diffuse");
                    break;
                case "KSP/Unlit":
                    replacementShader = GetShaderFromName("Unlit");
                    break;
                case "KSP/Specular":
                    replacementShader = GetShaderFromName("Specular");
                    break;
                case "KSP/Bumped":
                    replacementShader = GetShaderFromName("Bumped");
                    break;
                case "KSP/Bumped Specular":
                    replacementShader = GetShaderFromName("BumpedSpecular");
                    break;
                case "KSP/Emissive/Specular":
                    replacementShader = GetShaderFromName("EmissiveSpecular");
                    break;
                case "KSP/Emissive/Bumped Specular":
                    replacementShader = GetShaderFromName("EmissiveBumpedSpecular");
                    break;
                case "Terrain/PQS/PQS Main - Optimised":
                    replacementShader = GetShaderFromName("PQSMainOptimised");
                    UnityEngine.Debug.Log("Shader " + replacementShader.name);
                    break;
                case "Terrain/PQS/PQS Main Shader":
                    replacementShader = GetShaderFromName("PQSMainShader");
                    break;
                case "Terrain/PQS/Ocean Surface Quad":
                    replacementShader = GetShaderFromName("PQSOceanSurfaceQuad");
                    UnityEngine.Debug.Log("Shader " + replacementShader.name);
                    break;
                case "Terrain/PQS/Ocean Surface Quad (Fallback)":
                    replacementShader = GetShaderFromName("PQSOceanSurfaceQuadFallback");
                    UnityEngine.Debug.Log("Shader " + replacementShader.name);
                    break;
                case "Terrain/PQS/Sphere Projection SURFACE QUAD (AP) ":
                    replacementShader = GetShaderFromName("PQSProjectionAerialQuadRelative");
                    break;
                case "Terrain/PQS/Sphere Projection SURFACE QUAD (Fallback) ":
                    replacementShader = GetShaderFromName("PQSProjectionFallback");
                    break;
                case "Terrain/PQS/Sphere Projection SURFACE QUAD":
                    replacementShader = GetShaderFromName("PQSProjectionSurfaceQuad");
                    break;
                default:
                    UnityEngine.Debug.Log("Shader " + name);
                    break;

            }
            if (replacementShader != null)
            {
                mat.shader = replacementShader;
            }
            name = mat.shader.name;
        }
    }
}
