using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Utils
{
    public class HalfSphere : IsoSphere
    {
        GameObject meshContainer;
        public GameObject GameObject { get { return meshContainer; } }
        public HalfSphere(float radius, Material material)
        {
            meshContainer = new GameObject();

            MeshFilter filter = meshContainer.AddComponent<MeshFilter>();
            Mesh mesh = filter.mesh;
            mesh.Clear();

            List<Vector3> vertList = new List<Vector3>();
            Dictionary<long, int> middlePointIndexCache = new Dictionary<long, int>();

            int recursionLevel = 5;

            // create 12 vertices of a icosahedron
            float t = (1f + Mathf.Sqrt(5f)) / 2f;

            vertList.Add(new Vector3(-1f, t, 0f).normalized * radius);
            vertList.Add(new Vector3(1f, t, 0f).normalized * radius);
            //2//vertList.Add(new Vector3(-1f, -t, 0f).normalized * radius);
            //3//vertList.Add(new Vector3(1f, -t, 0f).normalized * radius);

            //4//vertList.Add(new Vector3(0f, -1f, t).normalized * radius);
            vertList.Add(new Vector3(0f, 1f, t).normalized * radius);
            //6//vertList.Add(new Vector3(0f, -1f, -t).normalized * radius);
            vertList.Add(new Vector3(0f, 1f, -t).normalized * radius);

            vertList.Add(new Vector3(t, 0f, -1f).normalized * radius);
            vertList.Add(new Vector3(t, 0f, 1f).normalized * radius);
            vertList.Add(new Vector3(-t, 0f, -1f).normalized * radius);
            vertList.Add(new Vector3(-t, 0f, 1f).normalized * radius);


            // create 20 triangles of the icosahedron
            List<TriangleIndices> faces = new List<TriangleIndices>();

            // 5 faces around point 0
            faces.Add(new TriangleIndices(0, 7, 2));
            faces.Add(new TriangleIndices(0, 2, 1));
            faces.Add(new TriangleIndices(0, 1, 3));
            faces.Add(new TriangleIndices(0, 3, 6));
            faces.Add(new TriangleIndices(0, 6, 7));

            // 5 adjacent faces 
            faces.Add(new TriangleIndices(1, 2, 5));
            //faces.Add(new TriangleIndices(5, 11, 4));
            //faces.Add(new TriangleIndices(11, 10, 2));
            //faces.Add(new TriangleIndices(10, 7, 6));
            faces.Add(new TriangleIndices(3, 1, 4));

            // 5 faces around point 3
            //faces.Add(new TriangleIndices(3, 9, 4));
            //faces.Add(new TriangleIndices(3, 4, 2));
            //faces.Add(new TriangleIndices(3, 2, 6));
            //faces.Add(new TriangleIndices(3, 6, 8));
            //faces.Add(new TriangleIndices(3, 8, 9));

            // 5 adjacent faces 
            //faces.Add(new TriangleIndices(4, 9, 5));
            //faces.Add(new TriangleIndices(2, 4, 11));
            //faces.Add(new TriangleIndices(6, 2, 10));
            //faces.Add(new TriangleIndices(8, 6, 7));
            faces.Add(new TriangleIndices(5, 4, 1));

            faces.Add(new TriangleIndices(2, 7, 5));
            faces.Add(new TriangleIndices(3, 4, 6));

            // refine triangles
            for (int i = 0; i < recursionLevel; i++)
            {
                List<TriangleIndices> faces2 = new List<TriangleIndices>();
                foreach (var tri in faces)
                {
                    // replace triangle by 4 triangles
                    int a = getMiddlePoint(tri.v1, tri.v2, ref vertList, ref middlePointIndexCache, radius);
                    int b = getMiddlePoint(tri.v2, tri.v3, ref vertList, ref middlePointIndexCache, radius);
                    int c = getMiddlePoint(tri.v3, tri.v1, ref vertList, ref middlePointIndexCache, radius);

                    faces2.Add(new TriangleIndices(tri.v1, a, c));
                    faces2.Add(new TriangleIndices(tri.v2, b, a));
                    faces2.Add(new TriangleIndices(tri.v3, c, b));
                    faces2.Add(new TriangleIndices(a, b, c));
                }
                faces = faces2;
            }

            Vector3[] normals = new Vector3[vertList.Count];
            for (int i = 0; i < normals.Length; i++)
                normals[i] = vertList[i].normalized;

            mesh.vertices = vertList.ToArray();

            List<int> triList = new List<int>();
            for (int i = 0; i < faces.Count; i++)
            {
                triList.Add(faces[i].v1);
                triList.Add(faces[i].v2);
                triList.Add(faces[i].v3);
            }
            mesh.triangles = triList.ToArray();

            float invPi2 = 1 / (2 * Mathf.PI);
            float invPi = 1 / (Mathf.PI);
            List<Vector2> uvList = new List<Vector2>();
            for (int i = 0; i < vertList.Count; i++)
            {
                Vector2 uv = new Vector2();
                Vector3 normal = vertList[i].normalized;
                uv.x = 0.5f + invPi2 * Mathf.Atan2(normal.z, normal.x);
                uv.y = 0.5f - invPi * Mathf.Asin(normal.y);
                uvList.Add(uv);
            }
            mesh.uv = uvList.ToArray();

            mesh.normals = normals;
            Tools.CalculateMeshTangents(mesh);

            mesh.RecalculateBounds();
            mesh.Optimize();

            var mr = meshContainer.AddComponent<MeshRenderer>();
            mr.material = material;
            mr.castShadows = false;
            mr.receiveShadows = false;
            mr.enabled = true;
        }
    }
}
