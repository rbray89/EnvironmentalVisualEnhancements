using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Geometry
{
    public static class Quad
    {
        public static void Create(GameObject gameObject, float size, Color color)
        {
            MeshFilter filter = gameObject.AddComponent<MeshFilter>();
            Mesh mesh = filter.mesh;
            mesh.Clear();
            
            mesh.vertices = new Vector3[4] 
            {
                new Vector3(-.5f,-.5f,0)*size,
                new Vector3(-.5f,.5f,0)*size,
                new Vector3(.5f,-.5f,0)*size,
                new Vector3(.5f,.5f,0)*size
            };

            mesh.triangles = new int[] { 1, 3, 2, 2, 0, 1 };

            mesh.uv = new Vector2[4] 
            { 
                new Vector2(0,0),
                new Vector2(0,1),
                new Vector2(1,0),
                new Vector2(1,1)
            };

            mesh.normals = new Vector3[4]
            {
                new Vector3(0,0,-1),
                new Vector3(0,0,-1),
                new Vector3(0,0,-1),
                new Vector3(0,0,-1)
            };

            mesh.colors = new Color[4]
            {
                new Color(0, 0, 0, color.a),
                new Color(color.r, color.g, color.b, color.a),
                new Color(color.r, color.g, color.b, color.a),
                new Color(color.r, color.g, color.b, color.a)
            };

            Tools.CalculateMeshTangents(mesh);

            mesh.RecalculateBounds();
            mesh.Optimize();
        }
    }
}
