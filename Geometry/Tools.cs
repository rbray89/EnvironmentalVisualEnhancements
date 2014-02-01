using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;


namespace Geometry
{
    public class Tools
    {
        public static void CalculateMeshTangents(Mesh mesh)
        {
            //speed up math by copying the mesh arrays
            int[] triangles = mesh.triangles;
            Vector3[] vertices = mesh.vertices;
            Vector2[] uv = mesh.uv;
            Vector3[] normals = mesh.normals;

            //variable definitions
            int triangleCount = triangles.Length;
            int vertexCount = vertices.Length;

            Vector3[] tan1 = new Vector3[vertexCount];
            Vector3[] tan2 = new Vector3[vertexCount];

            Vector4[] tangents = new Vector4[vertexCount];

            for (long a = 0; a < triangleCount; a += 3)
            {
                long i1 = triangles[a + 0];
                long i2 = triangles[a + 1];
                long i3 = triangles[a + 2];

                Vector3 v1 = vertices[i1];
                Vector3 v2 = vertices[i2];
                Vector3 v3 = vertices[i3];

                Vector2 w1 = uv[i1];
                Vector2 w2 = uv[i2];
                Vector2 w3 = uv[i3];

                float x1 = v2.x - v1.x;
                float x2 = v3.x - v1.x;
                float y1 = v2.y - v1.y;
                float y2 = v3.y - v1.y;
                float z1 = v2.z - v1.z;
                float z2 = v3.z - v1.z;

                float s1 = w2.x - w1.x;
                float s2 = w3.x - w1.x;
                float t1 = w2.y - w1.y;
                float t2 = w3.y - w1.y;

                float r = 1.0f / (s1 * t2 - s2 * t1);

                Vector3 sdir = new Vector3((t2 * x1 - t1 * x2) * r, (t2 * y1 - t1 * y2) * r, (t2 * z1 - t1 * z2) * r);
                Vector3 tdir = new Vector3((s1 * x2 - s2 * x1) * r, (s1 * y2 - s2 * y1) * r, (s1 * z2 - s2 * z1) * r);

                tan1[i1] += sdir;
                tan1[i2] += sdir;
                tan1[i3] += sdir;

                tan2[i1] += tdir;
                tan2[i2] += tdir;
                tan2[i3] += tdir;
            }


            for (long a = 0; a < vertexCount; ++a)
            {
                Vector3 n = normals[a];
                Vector3 t = tan1[a];

                //Vector3 tmp = (t - n * Vector3.Dot(n, t)).normalized;
                //tangents[a] = new Vector4(tmp.x, tmp.y, tmp.z);
                Vector3.OrthoNormalize(ref n, ref t);
                tangents[a].x = t.x;
                tangents[a].y = t.y;
                tangents[a].z = t.z;

                tangents[a].w = (Vector3.Dot(Vector3.Cross(n, t), tan2[a]) < 0.0f) ? -1.0f : 1.0f;
            }

            mesh.tangents = tangents;
        }

        public static Vector3 RotateY(Vector3d v, double angle)
        {

            double sin = Math.Sin(angle);
            double cos = Math.Cos(angle);

            double x = (cos * v.x) + (sin * v.z);
            double z = (cos * v.z) - (sin * v.x);
            return new Vector3d(x, v.y, z);

        }

        private static Vector3d[] TryGetHeight(PQ quad, Vector3d reference)
        {
            float dot = -2;
            PQ closestQuad = null;
            Vector3d[] verts = null;
            if (quad.subNodes != null && quad.subNodes.Length > 0)
            {
                //OverlayMgr.Log("subquad: " + quad.subNodes.Length);
                foreach (PQ sub in quad.subNodes)
                {
                    if (sub != null && sub.positionPlanet != null)
                    {
                        float testdot = (float)Vector3d.Dot(sub.positionPlanet.normalized, reference);
                        if (testdot > dot)
                        {
                            dot = testdot;
                            closestQuad = sub;
                        }
                    }
                }
                //OverlayMgr.Log("subQuad dot: " + dot);
                if (closestQuad != null)
                {
                    //OverlayMgr.Log("subQuad pos: " + closestQuad.positionPlanet);
                    verts = TryGetHeight(closestQuad, reference);
                    return verts;
                }
                verts = GetClosestVerts(quad, reference);
                return verts;
            }
            return verts;
        }

        private static Vector3d[] GetClosestVerts(PQ centerPQ, Vector3d reference)
        {
            List<Vector3d> fullList = new List<Vector3d>();
            List<PQ> pqlist = new List<PQ>();
            pqlist.Add(centerPQ);
            pqlist.Add(centerPQ.north);
            pqlist.Add(centerPQ.south);
            pqlist.Add(centerPQ.east);
            pqlist.Add(centerPQ.west);
            foreach (PQ quad in pqlist)
            {
                List<Vector3> vertList = new List<Vector3>(quad.verts);
                vertList.Sort(delegate(Vector3 x, Vector3 y)
                {
                    Vector3 xPos = quad.positionPlanet + x;
                    Vector3 yPos = quad.positionPlanet + y;
                    float xdot = Vector3.Dot(xPos.normalized, reference);
                    float ydot = Vector3.Dot(yPos.normalized, reference);
                    return ydot.CompareTo(xdot);
                });

                fullList.Add(quad.positionPlanet + vertList[0]);
                fullList.Add(quad.positionPlanet + vertList[1]);
                fullList.Add(quad.positionPlanet + vertList[2]);
            }

            fullList.Sort(delegate(Vector3d x, Vector3d y)
            {
                float xdot = Vector3.Dot(x.normalized, reference);
                float ydot = Vector3.Dot(y.normalized, reference);
                return ydot.CompareTo(xdot);
            });

            return new Vector3d[3] { fullList[0], fullList[1], fullList[2] };

        }

        public static double TryGetHeight(PQS pqs, Vector3d reference)
        {
            float dot = -2;
            PQ closestQuad = null;
            foreach (PQ quad in pqs.quads)
            {
                float testdot = (float)Vector3d.Dot(quad.positionPlanet.normalized, reference);
                if (testdot > dot)
                {
                    dot = testdot;
                    closestQuad = quad;
                }
            }

            Vector3d[] triangle = TryGetHeight(closestQuad, reference.normalized);

            double dist1 = Vector3d.Distance(reference, triangle[0]);
            double dist2 = Vector3d.Distance(reference, triangle[1]);
            double dist3 = Vector3d.Distance(reference, triangle[2]);
            double mag = (dist1 + dist2 + dist3);
            double mag1 = dist1 / mag;
            double mag2 = dist2 / mag;
            double mag3 = dist3 / mag;
            return (mag1 * triangle[0].magnitude) + (mag2 * triangle[1].magnitude) + (mag3 * triangle[2].magnitude);
        }

    }
}
