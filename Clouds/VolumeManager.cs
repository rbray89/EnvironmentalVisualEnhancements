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
        bool forceUpdate;
        Texture2D Texture;

        float Magnitude;
        VolumeSection[] moveSections = new VolumeSection[3];
        VolumeSection[] unchangedSections = new VolumeSection[3];

        GameObject translator;
        Transform Center;

        bool enabled;
        public bool Enabled { get { return enabled; } set { enabled = value; foreach (VolumeSection vs in VolumeList) { vs.Enabled = value; } } }

        public VolumeManager(float cloudSphereRadius, Texture2D texture, Material cloudParticleMaterial, Transform transform)
        {
            Magnitude = cloudSphereRadius;
            Vector3 pos = Vector3.up * Magnitude;
            translator = new GameObject();
            Center = translator.transform;
            Center.localScale = Vector3.one;
            Center.parent = transform;
            Recenter(pos, true);

            this.Texture = texture;
            radius = 20000;
            halfRad = radius / 2f;
            opp = Mathf.Sqrt(.75f) * radius;
            outCheck = opp*2f;
            
            enabled = true;
            forceUpdate = true;

            VolumeList.Add(new VolumeSection(texture, cloudParticleMaterial, transform, Center.localPosition, Magnitude, new Vector3(-radius, 0, 0), radius));
            VolumeList.Add(new VolumeSection(texture, cloudParticleMaterial, transform, Center.localPosition, Magnitude, new Vector3(halfRad, 0, opp), radius));
            VolumeList.Add(new VolumeSection(texture, cloudParticleMaterial, transform, Center.localPosition, Magnitude, new Vector3(halfRad, 0, -opp), radius));
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
            if (forceUpdate == true)
            {
                forceUpdate = false;
                for (int i = 0; i < VolumeList.Count; i++)
                {
                    VolumeSection volumeSection = VolumeList[i];
                    moveSections[moveCount++] = volumeSection;
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
                       Recenter(place, true);
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

        private void Recenter(Vector3 vector, bool abs = false)
        {
            if (abs)
            {
                Center.localPosition = vector;
                Vector3 worldUp = Center.position - Center.parent.position;
                Center.up = worldUp.normalized;
            }
            else
            {
                Vector3 worldUp = Center.position - Center.parent.position;
                Center.up = worldUp.normalized;
                Center.Translate(vector);
                worldUp = Center.position - Center.parent.position;
                Center.up = worldUp.normalized;
                Center.localPosition = Magnitude * Center.localPosition.normalized;
            }
            CloudLayer.Log("Recenter: " + Center.localPosition);
        }

        internal void Destroy()
        {
            GameObject.DestroyImmediate(translator);
            foreach (VolumeSection vs in VolumeList)
            {
                vs.Destroy();
            }
        }
    }
}
