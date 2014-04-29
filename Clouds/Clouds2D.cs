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
    public class Clouds2DMaterial : MaterialManager
    {
        [Persistent] 
        Color _Color = new Color(1,1,1,1);
        [Persistent]
        String _MainTex = "";
        [Persistent]
        String _DetailTex = "";
        [Persistent]
        float _FalloffPow = 2f;
        [Persistent]
        float _FalloffScale = 3f;
        [Persistent]
        float _DetailScale = 100f;
        [Persistent]
        Vector3 _DetailOffset = new Vector3(0, 0, 0);
        [Persistent]
        float _DetailDist = 0.00875f;
        [Persistent]
        float _MinLight = .5f;
        [Persistent]
        float _FadeDist = 10f;
        [Persistent]
        float _FadeScale = .002f;
        [Persistent]
        float _RimDist = 1f;
    }

    class Clouds2D
    {
        GameObject CloudMesh;
        Material CloudMaterial;
        [Persistent]
        Clouds2DMaterial cloudMaterial;
        [Persistent]
        Vector3 speed;
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
            CloudMaterial = new Material(CloudShader);
            cloudMaterial.ApplyMaterialProperties(CloudMaterial);
            HalfSphere hp = new HalfSphere(radius, CloudMaterial);
            CloudMesh = hp.GameObject;
            CloudMesh.transform.parent = parent;
            CloudMesh.transform.localPosition = Vector3.zero;
            CloudMesh.transform.localScale = Vector3.one;
            CloudMesh.layer = EVEManager.MACRO_LAYER;
        }

        internal void UpdateRotation(Quaternion rotation)
        {
            if (rotation != null)
            {
                CloudMesh.transform.rotation = rotation;
                Matrix4x4 mtrx = Matrix4x4.TRS(Vector3.zero, rotation, new Vector3(1, 1, 1));
                // Update the rotation matrix.
                //mtrx = Matrix4x4.identity;
                CloudMaterial.SetMatrix("_Rotation", mtrx);
            }
            double ut =  Planetarium.GetUniversalTime();
            double x = (ut * speed.x);
            x -= (int)x;
            double y = (ut * speed.y);
            y -= (int)y;
            Vector2 texOffset = new Vector2((float)x, (float)y);
            AtmosphereManager.Log("Offset: " + texOffset.x);
            CloudMaterial.SetVector("_MainOffset", texOffset);
        }
    }
}
