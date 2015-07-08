using Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using EVEManager;

namespace Atmosphere
{
    class CloudParticle
    {
        private static System.Random Random = new System.Random();

        GameObject particle;
        public CloudParticle(Material cloudParticleMaterial, Vector2 size, Transform parent, Vector3 pos, float magnitude)
        {
            particle = new GameObject();

            particle.transform.parent = parent;

            particle.transform.localPosition = pos;

            Vector3 bodyPoint = parent.parent.InverseTransformPoint(particle.transform.position).normalized*magnitude;
            particle.transform.position = parent.parent.TransformPoint(bodyPoint);

            particle.transform.localPosition += Vector3.zero;

            Vector3 worldUp = particle.transform.position - parent.parent.position;
            particle.transform.up = worldUp.normalized;

            particle.transform.localRotation = Quaternion.Euler(0, 0, 0);

            particle.transform.localScale = Vector3.one;
            particle.layer = EVEManagerClass.MACRO_LAYER;

            Vector3 up = particle.transform.InverseTransformDirection(worldUp);
            Quad.Create(particle, (int)size.x, Color.white, up, size.y);

            var mr = particle.AddComponent<MeshRenderer>();
            mr.sharedMaterial = cloudParticleMaterial;

            mr.castShadows = false;
            mr.receiveShadows = false;
            mr.enabled = true;
        }


        internal void Update(Color color)
        {
            MeshFilter filter = particle.GetComponent<MeshFilter>();
            Mesh mesh = filter.mesh;
            mesh.colors = new Color[4]
            {
                new Color(color.r, color.g, color.b, color.a),
                new Color(color.r, color.g, color.b, color.a),
                new Color(color.r, color.g, color.b, color.a),
                new Color(color.r, color.g, color.b, color.a)
            };
        }

        internal void Destroy()
        {
            GameObject.DestroyImmediate(particle);
        }

        
    }

    class VolumeSection
    {
        
        private static System.Random Random = new System.Random();

        GameObject segment;
        float magnitude;
        float xComp, zComp;
        List<CloudParticle> Particles = new List<CloudParticle>();
        float radius, divisions;

        public Vector3 Center { get { return segment.transform.localPosition; } }
        public bool Enabled { get { return segment.activeSelf; } set { segment.SetActive(value); } }

        public VolumeSection(Material cloudParticleMaterial, Vector2 size, Transform parent, Vector3 pos, float magnitude, float radius, int divisions)
        {
            segment = new GameObject();
            this.radius = radius;
            this.divisions = divisions;
            HexSeg hexGeometry = new HexSeg(radius, divisions);

            xComp = 360f * (radius / (Mathf.Pow(2f, divisions))) / (2f * Mathf.PI * magnitude);
            zComp = 360f * (2*Mathf.Sqrt(.75f) * radius / (Mathf.Pow(2f, divisions))) / (2f * Mathf.PI * magnitude);

            segment.transform.localPosition = pos;
            Reassign(pos, magnitude, parent);

            List<Vector3> positions = hexGeometry.GetPoints();
            foreach (Vector3 position in positions)
            {
                Particles.Add(new CloudParticle(cloudParticleMaterial, size, segment.transform, position, magnitude));
            }
        }

        public void Reassign(Vector3 pos, float magnitude = -1, Transform parent = null)
        {
            if(parent != null)
            {
                segment.transform.parent = parent;
            }
            if (magnitude > 0)
            {
                this.magnitude = magnitude;
            }


            Vector3 worldUp = segment.transform.position - segment.transform.parent.position;
            segment.transform.up = worldUp.normalized;
            Vector3 posWorldDir = Vector3.Normalize(segment.transform.parent.TransformDirection(pos));
            Vector3 xDir = Vector3.Normalize(segment.transform.TransformDirection(Vector3.forward));
            float xDot = Vector3.Dot(posWorldDir, xDir);
            Vector3 xWorldDir = posWorldDir - ( xDot * xDir );
            Vector3 zDir = Vector3.Normalize(segment.transform.TransformDirection(Vector3.right));
            float zDot = Vector3.Dot(posWorldDir, zDir);
            Vector3 zWorldDir = posWorldDir - (zDot * zDir);

            float xAngle = Vector3.Angle(worldUp, xWorldDir);
            float zAngle = Vector3.Angle(worldUp, zWorldDir);

            

            if (xAngle > xComp)
            {
                segment.transform.RotateAround(segment.transform.parent.position, xDir, -Mathf.Sign(zDot) * Mathf.Floor(xAngle / xComp) * xComp);
            }
            if (zAngle > zComp)
            {
                segment.transform.RotateAround(segment.transform.parent.position, zDir, Mathf.Sign(xDot) * Mathf.Floor(zAngle / zComp) * zComp);
            }
            //Rotate Around is in world cords and degrees.
            //if (segment.transform.RotateAround()
            //segment.transform.localPosition = pos;
            //
            //segment.transform.localScale = Vector3.one;
            //segment.transform.Translate(offset);

            worldUp = segment.transform.position - segment.transform.parent.position;
            segment.transform.up = worldUp.normalized;
            segment.transform.localPosition = this.magnitude * segment.transform.localPosition.normalized;

        }

        internal void Destroy()
        {
            foreach (CloudParticle particle in Particles)
            {
                particle.Destroy();
            }
            GameObject.DestroyImmediate(segment);
        }

    }
}
