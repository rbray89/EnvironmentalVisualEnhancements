using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using Utils;

namespace Atmosphere
{
    class Clouds2D
    {
        GameObject CloudMesh;
        [Persistent]
        TextureManager mainTexture;
        private static Shader cloudShader = null;
        private static Shader CloudShader
        {
            get
            {
                if (cloudShader == null)
                {
                    Assembly assembly = Assembly.GetExecutingAssembly();
                    StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Atmosphere.Shaders.Compiled-SphereCloud.shader"));
                    String shaderTxt = shaderStreamReader.ReadToEnd();
                    cloudShader = new Material(shaderTxt).shader;
                } return cloudShader;
            }
        }
        public void Apply(float radius, Transform parent)
        {
            CloudMesh = new GameObject();
            IsoSphere.Create(CloudMesh, radius, null);

            var mr = CloudMesh.AddComponent<MeshRenderer>();
            mr.sharedMaterial = new Material(CloudShader);
            mr.castShadows = false;
            mr.receiveShadows = false;
            //mr.enabled = mainMenu;
            mr.enabled = true;

            CloudMesh.transform.parent = parent;
        }
    }
}
