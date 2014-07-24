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
    class ShaderReplacer : MonoBehaviour
    {
        static Dictionary<String, Shader> shaderDictionary = new Dictionary<String, Shader>();
        private void Awake()
        {
            if (HighLogic.LoadedScene == GameScenes.SPACECENTER || HighLogic.LoadedScene == GameScenes.FLIGHT)
            {
                GameEvents.onGameSceneLoadRequested.Add(GameSceneLoaded);
            }
        }

        private Shader GetShaderFromName(String name)
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
            }
        }
    }
}
