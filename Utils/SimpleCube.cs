using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Utils
{
    public class SimpleCube
    {

        GameObject meshContainer;
        public GameObject GameObject { get { return meshContainer; } }
        public SimpleCube(float size, ref Material material, Shader shader)
        {
            
            GameObject cube = GameObject.CreatePrimitive(PrimitiveType.Cube);
            GameObject.Destroy(cube.GetComponent<Collider>());
            cube.transform.localScale = Vector3.one;
            meshContainer = cube;
            
            MeshFilter mf = cube.GetComponent<MeshFilter>();
            Vector3[] verts = mf.mesh.vertices;
            for (int i = 0; i < verts.Length; i++)
            {
                verts[i] *= 2*size;
            }
            mf.mesh.vertices = verts;
            mf.mesh.RecalculateBounds();
            mf.mesh.RecalculateNormals();

            MeshRenderer mr = cube.GetComponent<MeshRenderer>();
            material = mr.material;
            material.shader = shader;

            mr.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
            mr.receiveShadows = false;
            mr.enabled = true;
        }
    }
}
