using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Utils
{
    public class SimpleCylinder
    {

        GameObject meshContainer;
        public GameObject GameObject { get { return meshContainer; } }
        public SimpleCylinder(float size, float startY, Material material)
        {
            
            GameObject cylinder = GameObject.CreatePrimitive(PrimitiveType.Cylinder);
            //cylinder.transform.localScale = new Vector3(size, size, size);
            cylinder.transform.localScale = Vector3.one;
            //cylinder.transform.localPosition = Vector3.up * .5f * size;
            //cylinder.transform.parent = meshContainer.transform;
            meshContainer = cylinder;
            
            MeshFilter mf = cylinder.GetComponent<MeshFilter>();
            Vector3[] verts = mf.mesh.vertices;
            for (int i = 0; i < verts.Length; i++)
            {
                if (verts[i].y < 0)
                {
                    verts[i].y = startY;
                }
                else
                {
                    verts[i].y = size;
                }
                verts[i].x *= size;
                verts[i].z *= size;
            }
            mf.mesh.vertices = verts;
            mf.mesh.RecalculateBounds();
            mf.mesh.RecalculateNormals();

            var mr = cylinder.GetComponent<MeshRenderer>();
            mr.material = material;

            mr.castShadows = false;
            mr.receiveShadows = false;
            mr.enabled = true;
        }
    }
}
