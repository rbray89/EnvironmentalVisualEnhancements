using Geometry;
using OverlaySystem;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Clouds
{
    class CloudParticle
    {
        private static System.Random Random = new System.Random();

        GameObject particle;
        public CloudParticle(Texture2D tex, Material cloudParticleMaterial, Transform parent, Vector3 pos)
        {
            particle = new GameObject();

            particle.transform.parent = parent;

            float x = 500 * ((float)Random.NextDouble() - .5f);
            float y = 500 * ((float)Random.NextDouble() - .5f);
            float z = 500 * ((float)Random.NextDouble() - .5f);
            particle.transform.localPosition = pos + new Vector3(x, y, z);

            x = 360f * (float)Random.NextDouble();
            y = 360f * (float)Random.NextDouble();
            z = 360f * (float)Random.NextDouble();
            //particle.transform.localRotation = Quaternion.Euler(x, y, z);
            particle.transform.up = parent.up;
            particle.transform.localScale = Vector3.one;
            particle.layer = OverlayMgr.MACRO_LAYER;

            Vector3 point = parent.parent.worldToLocalMatrix.MultiplyPoint3x4(particle.transform.position).normalized;
            float u = (float)(.5 + (Mathf.Atan2(point.z, point.x) / (2f * Mathf.PI)));
            float v = Mathf.Acos(-point.y) / Mathf.PI;
            Color pix = tex.GetPixelBilinear(u, v);

            Vector3 up = Vector3.Normalize(-particle.transform.worldToLocalMatrix.MultiplyPoint3x4(parent.parent.position));
            Quad.Create(particle, Random.Next(2500, 4500), pix, up);

            var mr = particle.AddComponent<MeshRenderer>();
            mr.sharedMaterial = cloudParticleMaterial;

            Texture2D tex1 = GameDatabase.Instance.GetTexture("BoulderCo/Clouds/Textures/particle/3", false);
            Texture2D tex2 = GameDatabase.Instance.GetTexture("BoulderCo/Clouds/Textures/particle/5", false);
            Texture2D tex3 = GameDatabase.Instance.GetTexture("BoulderCo/Clouds/Textures/particle/6", false);

            tex1.wrapMode = TextureWrapMode.Clamp;
            tex2.wrapMode = TextureWrapMode.Clamp;
            tex3.wrapMode = TextureWrapMode.Clamp;

            mr.sharedMaterial.SetTexture("_TopTex", tex1);
            mr.sharedMaterial.SetTexture("_LeftTex", tex2);
            mr.sharedMaterial.SetTexture("_FrontTex", tex3);
            mr.sharedMaterial.SetFloat("_DistFade", 1f / 2250f);

            mr.castShadows = false;
            mr.receiveShadows = false;
            mr.enabled = true;
        }
        
        public void Update(Texture2D tex)
        {
            Vector3 point = particle.transform.parent.parent.worldToLocalMatrix.MultiplyPoint3x4(particle.transform.position).normalized;
            float u = (float)(.5 + (Mathf.Atan2(point.z, point.x) / (2f * Mathf.PI)));
            float v = Mathf.Acos(-point.y) / Mathf.PI;
            Color color = tex.GetPixelBilinear(u, v);
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
    }

    class VolumeSection
    {
        
        private static System.Random Random = new System.Random();

        GameObject segment;
        Vector3 center;
        Vector3 offset;
        List<CloudParticle> Particles = new List<CloudParticle>();

        public Vector3 Center { get { return center; } }
        public Vector3 Offset { get { return offset; } set { offset = value; } }
        public bool Enabled { get { return segment.activeSelf; } set { segment.SetActive(value); } }

        public VolumeSection(Texture2D tex, Material cloudParticleMaterial, Transform parent, Vector3 pos, Vector3 offset, float radius)
        {
            segment = new GameObject();
            HexSeg hexGeometry = new HexSeg(radius, 4);

            Reassign(pos, offset, parent);

            List<Vector3> positions = hexGeometry.GetPoints();
            foreach (Vector3 position in positions)
            {
                Particles.Add(new CloudParticle(tex, cloudParticleMaterial, segment.transform, position));
            }
        }

        public void Reassign(Vector3 pos, Vector3 offset, Transform parent = null)
        {
            if(parent != null)
            {
                segment.transform.parent = parent;
            }
            
            segment.transform.localPosition = pos;
            Vector3 worldUp = segment.transform.position - segment.transform.parent.position;
            segment.transform.up = worldUp.normalized;
            segment.transform.localScale = Vector3.one;
            segment.transform.Translate(offset);

            worldUp = segment.transform.position - segment.transform.parent.position;
            segment.transform.up = worldUp.normalized;
            center = segment.transform.localPosition;
            this.offset = offset;
        }

        public void UpdateTexture(Texture2D texture)
        {
            foreach (CloudParticle particle in Particles)
            {
                particle.Update(texture);
            }
        }
    }
}
