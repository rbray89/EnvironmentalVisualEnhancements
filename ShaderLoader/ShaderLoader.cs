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
                shaderDictionary.Add(shaderMat.shader.name, shaderMat.shader);
                KSPLog.print("Loading shader "+shaderMat.shader.name);
            }
        }

        public static Shader FindShader(string name)
        {
            if(shaderDictionary.ContainsKey(name))
            {
                return shaderDictionary[name];
            }
            else
            {
                return null;
            }

        }
    }
}
