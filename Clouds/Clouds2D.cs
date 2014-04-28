using EveManager;
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
            Material newmat = new Material(CloudShader);
            newmat.mainTexture = mainTexture.GetTexture();
            HalfSphere hp = new HalfSphere(radius, newmat);
            CloudMesh = hp.GameObject;
            CloudMesh.transform.parent = parent;
            CloudMesh.transform.localPosition = Vector3.zero;
            CloudMesh.transform.localScale = Vector3.one;
            CloudMesh.layer = EVEManager.MACRO_LAYER;
        }

        internal void UpdateRotation(Quaternion rotation)
        {
            CloudMesh.transform.rotation = rotation;
            Matrix4x4 mtrx = Matrix4x4.TRS(Vector3.zero, rotation, new Vector3(1, 1, 1));
		    // Update the rotation matrix.
            //mtrx = Matrix4x4.identity;
            CloudMesh.GetComponent<MeshRenderer>().material.SetMatrix("_Rotation", mtrx);

        }
    }
}
