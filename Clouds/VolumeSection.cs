using Geometry;
using OverlaySystem;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Clouds
{
    class VolumeSection
    {
        
        private static System.Random Random = new System.Random();

        HexSeg hexGeometry;
        GameObject segment;

        public static void PlaceParticle(Texture2D tex, Transform parent, Vector3 pos)
        {
            GameObject particle = new GameObject();
            

            particle.transform.parent = parent;
            particle.transform.localPosition = pos;
            float x = 360f * (float)Random.NextDouble();
            float y = 360f * (float)Random.NextDouble();
            float z = 360f * (float)Random.NextDouble();

            particle.transform.localRotation = Quaternion.Euler(x, y, z);
            particle.transform.localScale = Vector3.one;
            particle.layer = OverlayMgr.MACRO_LAYER;

            Vector3 point = parent.parent.worldToLocalMatrix.MultiplyPoint3x4(particle.transform.position).normalized;
            float u = (float)(.5 + (Mathf.Atan2(point.z, point.x) / (2f * Mathf.PI)));
            float v = Mathf.Acos(-point.y) / Mathf.PI;
            Color pix = tex.GetPixelBilinear(u, v);
            Quad.Create(particle, Random.Next(2500, 4500), pix);

            var mr = particle.AddComponent<MeshRenderer>();
            mr.sharedMaterial = new Material(CloudLayer.CloudParticleShader);// Shader.Find("KSP/Diffuse"));

            Texture2D tex1 = GameDatabase.Instance.GetTexture("BoulderCo/Clouds/Textures/particle/3", false);
            Texture2D tex2 = GameDatabase.Instance.GetTexture("BoulderCo/Clouds/Textures/particle/5", false);
            Texture2D tex3 = GameDatabase.Instance.GetTexture("BoulderCo/Clouds/Textures/particle/6", false);

            tex1.wrapMode = TextureWrapMode.Clamp;
            tex2.wrapMode = TextureWrapMode.Clamp;
            tex3.wrapMode = TextureWrapMode.Clamp;

            mr.sharedMaterial.SetTexture("_TopTex", tex1);
            mr.sharedMaterial.SetTexture("_LeftTex", tex2);
            mr.sharedMaterial.SetTexture("_FrontTex", tex3);

            mr.castShadows = false;
            mr.receiveShadows = false;
            //mr.enabled = mainMenu;
            mr.enabled = true;
        }

        public VolumeSection(Texture2D tex, Transform parent, Vector3 pos, float radius)
        {
            hexGeometry = new HexSeg(radius, 4);
            segment = new GameObject();
            segment.transform.parent = parent;
            segment.transform.localPosition = pos;
            Vector3 worldUp = parent.localToWorldMatrix.MultiplyPoint3x4(pos) - parent.localToWorldMatrix.MultiplyPoint3x4(Vector3.zero);
            segment.transform.up = worldUp.normalized;
            segment.transform.localScale = Vector3.one;

            List<Vector3> positions = hexGeometry.GetPoints();
            foreach (Vector3 position in positions)
            {
                CloudLayer.Log("Positions: "+position);
                VolumeSection.PlaceParticle(tex, segment.transform, position);
            }
        }
    }
}
