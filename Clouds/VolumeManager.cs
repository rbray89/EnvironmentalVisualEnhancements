using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Clouds
{
    class VolumeManager
    {
        private List<VolumeSection> VolumeList = new List<VolumeSection>();
        float radius;
        float halfRad;
        float outCheck;
        float opp;
        Texture2D Texture;
        Material CloudParticleMaterial;
        Transform Transform;

        float Magnitude;
        VolumeSection[] moveSections = new VolumeSection[3];
        VolumeSection[] unchangedSections = new VolumeSection[3];

        GameObject translator;
        Transform Center;

        bool enabled;
        public bool Enabled { get { return enabled; } set { enabled = value; foreach (VolumeSection vs in VolumeList) { vs.Enabled = value; } } }

        public VolumeManager(Vector3 pos, float cloudSphereRadius, Texture2D texture, Material cloudParticleMaterial, Transform transform)
        {
            //translator = GameObject.CreatePrimitive(PrimitiveType.Sphere);
            //translator.renderer.material.color = new Color(1, 0, 0);
            translator = new GameObject();
            Center = translator.transform;
            //Center.localScale = Vector3.one*4000f;
            Center.localScale = Vector3.one;
            Center.parent = transform;
            Center.localPosition = pos * cloudSphereRadius;

            this.Texture = texture;
            this.CloudParticleMaterial = cloudParticleMaterial;
            this.Transform = transform;
            radius = 20000;
            halfRad = radius / 2f;
            opp = Mathf.Sqrt(.75f) * radius;
            outCheck = opp*2f;
            Magnitude = cloudSphereRadius;
            enabled = true;

            VolumeList.Add(new VolumeSection(texture, cloudParticleMaterial, transform, Center.localPosition, new Vector3(-radius, 0, 0), radius));
            VolumeList.Add(new VolumeSection(texture, cloudParticleMaterial, transform, Center.localPosition, new Vector3(halfRad, 0, opp), radius));
            VolumeList.Add(new VolumeSection(texture, cloudParticleMaterial, transform, Center.localPosition, new Vector3(halfRad, 0, -opp), radius));
        }

        public void Update(Vector3 pos)
        {
            Vector3 place = pos * Magnitude;
            int moveCount = 0;
            int unchangedCount = 0;
            

            for (int i = 0; i < VolumeList.Count; i++)
            {
                VolumeSection volumeSection = VolumeList[i];
                float distance = Vector3.Distance(volumeSection.Center, place);

                if (distance > outCheck)
                {
                    moveSections[moveCount++] = volumeSection;
                }
                else
                {
                    unchangedSections[unchangedCount++] = volumeSection;
                }
            }
            if (moveCount > 0)
            {
                Vector3 tmp;
               switch(moveCount)
               {
                   case 1:
                       Recenter(-moveSections[0].Offset);

                       tmp = unchangedSections[0].Offset;
                       unchangedSections[0].Offset = -unchangedSections[1].Offset;
                       unchangedSections[1].Offset = -tmp;
                       moveSections[0].Reassign(Center.localPosition, -moveSections[0].Offset);
                       moveSections[0].UpdateTexture(Texture);
                       break;
                   case 2:
                       Recenter(2f * unchangedSections[0].Offset);
                       
                       unchangedSections[0].Offset *= -1f;
                       tmp = moveSections[0].Offset;
                       moveSections[0].Reassign(Center.localPosition, -moveSections[1].Offset);
                       moveSections[1].Reassign(Center.localPosition, -tmp);
                       moveSections[0].UpdateTexture(Texture);
                       moveSections[1].UpdateTexture(Texture);
                       break;
                   case 3:
                       Center.localPosition = place;
                       moveSections[0].Reassign(Center.localPosition, new Vector3(-radius, 0, 0));
                       moveSections[1].Reassign(Center.localPosition, new Vector3(halfRad, 0, opp));
                       moveSections[2].Reassign(Center.localPosition, new Vector3(halfRad, 0, -opp));
                       moveSections[0].UpdateTexture(Texture);
                       moveSections[1].UpdateTexture(Texture);
                       moveSections[2].UpdateTexture(Texture);
                       break;
               }
               
            }
        }

        private void Recenter(Vector3 vector3)
        {
            Vector3 worldUp = Center.position - Center.parent.localToWorldMatrix.MultiplyPoint3x4(Vector3.zero);
            Center.up = worldUp.normalized;
            Center.Translate(-moveSections[0].Offset);
            Center.localPosition = Magnitude * Center.localPosition.normalized;
            //CloudLayer.Log("LocalCenter: " + Center.localPosition);
        }

        public void UpdateShaderNorm()
        {
            Vector3 worldUp = Center.position - Center.parent.localToWorldMatrix.MultiplyPoint3x4(Vector3.zero);
            CloudParticleMaterial.SetVector("_WorldNorm", worldUp);
            //CloudLayer.Log("PositionCenter: " + Center.position);
        }
    }
}
