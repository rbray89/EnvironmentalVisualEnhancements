using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using Utils;

namespace ShaderLoader
{
    [KSPAddon(KSPAddon.Startup.Instantly, true)]
    public class ShaderLoaderClass : MonoBehaviour
    {
        static Dictionary<String, Shader> shaderDictionary = new Dictionary<String, Shader>();
        private void Awake()
        {
            String shaderFolder = KSPUtil.ApplicationRootPath + "GameData/EnvironmentalVisualEnhancements/Shaders/";
            foreach (string shader in Directory.GetFiles(shaderFolder))
            {
                StreamReader shaderStream = new StreamReader(shader);
                Material shaderMat = new Material(shaderStream.ReadToEnd());
                KSPLog.print("Loading shader " + shaderMat.shader.name);
            }

            Shader[] shaders = (Shader[])Resources.FindObjectsOfTypeAll(typeof(Shader));
            foreach (Shader shader in shaders)
            {
                KSPLog.print("Adding shader " + shader.name);
                shaderDictionary[shader.name] = shader;
            }
        }

        public static Shader FindShader(string name, bool search = true)
        {
            if(shaderDictionary.ContainsKey(name))
            {
                return shaderDictionary[name];
            }
            else if(search)
            {
                Shader[] shaders = (Shader[])Resources.FindObjectsOfTypeAll(typeof(Shader));
                foreach (Shader shader in shaders)
                {
                    KSPLog.print("Adding shader " + shader.name);
                    shaderDictionary[shader.name] = shader;
                }
                return FindShader(name, false);
            }
            else
            {
                KSPLog.print("Could not find shader " + name);
                return null;
            }

        }
    }
}
