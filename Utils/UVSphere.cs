using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Utils
{
    public class UVSphere
    {
        GameObject meshContainer;
        public GameObject GameObject { get { return meshContainer; } }
        public UVSphere(float radius, float arc, ref Material material, Shader shader)
        {
            meshContainer = new GameObject();
            meshContainer.name = "EVE UVSphere";

            MeshFilter filter = meshContainer.AddComponent<MeshFilter>();
            Mesh mesh = filter.mesh;
            mesh.Clear();
            //mesh.subMeshCount = 1;

            List<Vector3> vertList = new List<Vector3>();

            // Longitude |||
            int nbLong = 24*8;
            // Latitude ---
            int nbLat = (int)(16*8 * arc/360);

            var haveBottomCap = arc == 360;

            #region Vertices
            Vector3[] vertices = new Vector3[(nbLong + 1) * nbLat + (haveBottomCap ? 2 : 1)];
            float _pi = Mathf.PI;
            float _2pi = _pi * 2f;

            vertices[0] = Vector3.up * radius;
            for (int lat = 0; lat < nbLat; lat++) {
                float a1 = arc/360*_pi * (float)(lat + 1) / (nbLat + 1);
                float sin1 = Mathf.Sin(a1);
                float cos1 = Mathf.Cos(a1);

                for (int lon = 0; lon <= nbLong; lon++) {
                    float a2 = _2pi * (float)(lon == nbLong ? 0 : lon) / nbLong;
                    float sin2 = Mathf.Sin(a2);
                    float cos2 = Mathf.Cos(a2);

                    vertices[lon + lat * (nbLong + 1) + 1] = new Vector3(sin1 * cos2, cos1, sin1 * sin2) * radius;
                }
            }
            if (haveBottomCap)
                vertices[vertices.Length - 1] = Vector3.up * -radius;
            #endregion

            #region Normales		
            Vector3[] normales = new Vector3[vertices.Length];
            for (int n = 0; n < vertices.Length; n++)
                normales[n] = vertices[n].normalized;
            #endregion

            #region UVs
            Vector2[] uvs = new Vector2[vertices.Length];
            uvs[0] = Vector2.up;
            uvs[uvs.Length - 1] = Vector2.zero;
            for (int lat = 0; lat < nbLat; lat++)
                for (int lon = 0; lon <= nbLong; lon++)
                    uvs[lon + lat * (nbLong + 1) + 1] = new Vector2((float)lon / nbLong, 1f - (float)(lat + 1) / (nbLat + 1));
            #endregion

            #region Triangles
            int nbFaces = vertices.Length;
            int nbTriangles = nbFaces * 2;
            int nbIndexes = nbTriangles * 3;
            int[] triangles = new int[nbIndexes];

            //Top Cap
            int i = 0;
            for (int lon = 0; lon < nbLong; lon++) {
                triangles[i++] = lon + 2;
                triangles[i++] = lon + 1;
                triangles[i++] = 0;
            }

            //Middle
            for (int lat = 0; lat < nbLat - 1; lat++) {
                for (int lon = 0; lon < nbLong; lon++) {
                    int current = lon + lat * (nbLong + 1) + 1;
                    int next = current + nbLong + 1;

                    triangles[i++] = current;
                    triangles[i++] = current + 1;
                    triangles[i++] = next + 1;

                    triangles[i++] = current;
                    triangles[i++] = next + 1;
                    triangles[i++] = next;
                }
            }

            if (haveBottomCap) {
                //Bottom Cap
                for (int lon = 0; lon < nbLong; lon++) {
                    triangles[i++] = vertices.Length - 1;
                    triangles[i++] = vertices.Length - (lon + 2) - 1;
                    triangles[i++] = vertices.Length - (lon + 1) - 1;
                }
            }

            if (i != triangles.Length) {
                Debug.LogError("Array should be trimmed, or use a List: " + i + "/" + triangles.Length);
            }
            #endregion

            mesh.vertices = vertices;
            mesh.normals = normales;
            mesh.uv = uvs;
            mesh.triangles = triangles;
            Debug.Log(triangles.Length + " triangles in UVsphere");

            Tools.CalculateMeshTangents(mesh);

            mesh.RecalculateBounds();

            MeshRenderer mr = meshContainer.AddComponent<MeshRenderer>();
            material = mr.material;
            material.shader = shader;

            mr.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
            mr.receiveShadows = false;
            mr.enabled = true;
        }
    }
}
