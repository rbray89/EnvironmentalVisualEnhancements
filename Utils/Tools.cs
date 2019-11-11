﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;


namespace Utils
{
    public class Tools
    {

        public enum Layer
        {
            Default = 0,
            TransparentFX = 1,
            Water = 4,
            UI = 5,
            Atmosphere = 9,
            Scaled = 10,
            Local = 15,
            Kerbals = 16,
            Sky = 18,
            Parts = 19,
            Internal = 20,
            ScaledSpaceSun = 23
        }

        public enum Queue
        {
            Background = 1000,
            Geometry = 2000,
            AlphaTest = 2450,
            Transparent = 3000,
            Overlay = 4000
        }

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

            for (long a = 0; a < triangleCount; a += 3) {
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


            for (long a = 0; a < vertexCount; ++a) {
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

        public static CelestialBody GetCelestialBody(String body)
        {
            CelestialBody[] celestialBodies = FlightGlobals.Bodies.ToArray();
            return celestialBodies.FirstOrDefault(n => n.bodyName == body);
        }

        public static Transform GetScaledTransform(string body)
        {
            CelestialBody cb = GetCelestialBody(body);
            if (cb == null) {
                return null;
            }
            return cb.scaledBody.transform;
        }

        public static GameObject GetMainMenuObject(string name)
        {
            var all = GameObject.FindObjectsOfType<GameObject>();
            GameObject fallback = null;
            var altName = name + "(Clone)";
            foreach (var b in all) {
                if (b.name == name && b.transform.parent.name.Contains("Scene")) return b;
                if (b.name == altName && b.transform.parent.name.Contains("Scene")) fallback = b;
            }
            return fallback;
        }
    }
}
