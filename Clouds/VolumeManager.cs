using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Atmosphere
{
    class VolumeManager
    {
        private List<VolumeSection> VolumeList = new List<VolumeSection>();
        private List<VolumeSection> VolumeListBottom = new List<VolumeSection>();
        float radius;
        int divisions;
        float halfRad;
        float outCheck;
        float opp;
        bool forceUpdate;

        bool atmosphere = true;

        float Magnitude;
        VolumeSection[] moveSections;
        VolumeSection[] unchangedSections;

        GameObject translator;
        Transform Center;

        bool enabled;
        public bool Enabled { get { return enabled; } set { enabled = value; foreach (VolumeSection vs in VolumeList) { vs.Enabled = value; } } }

        public VolumeManager(float cloudSphereRadius, Transform transform)
        {
            Magnitude = cloudSphereRadius;
            Vector3 pos = Vector3.up * Magnitude;
            translator = new GameObject();
            Center = translator.transform;
            Center.localScale = Vector3.one;
            Center.parent = transform;
            Recenter(pos, true);

            ConfigNode volumeConfig = GameDatabase.Instance.GetConfigNodes("ENVIRONMENTAL_VISUAL_ENHANCEMENTS")[0];
            radius = 12000;
            float.TryParse(volumeConfig.GetValue("volumeHexRadius"), out radius);
            divisions = 3;
            int.TryParse(volumeConfig.GetValue("volumeSegmentDiv"), out divisions);
            halfRad = radius / 2f;
            opp = Mathf.Sqrt(.75f) * radius;
            outCheck = opp * 2f;

            enabled = true;

            moveSections = new VolumeSection[3];
            unchangedSections = new VolumeSection[3];
        }

        public VolumeManager(float cloudSphereRadius, Texture2D texture, Material cloudParticleMaterial, Transform transform)
            : this(cloudSphereRadius, transform)
        {
            atmosphere = false;
            VolumeList.Add(new VolumeSection(texture, cloudParticleMaterial, transform, Center.localPosition, Magnitude, new Vector3(-radius, 0, 0), radius, divisions));
            VolumeList.Add(new VolumeSection(texture, cloudParticleMaterial, transform, Center.localPosition, Magnitude, new Vector3(halfRad, 0, opp), radius, divisions));
            VolumeList.Add(new VolumeSection(texture, cloudParticleMaterial, transform, Center.localPosition, Magnitude, new Vector3(halfRad, 0, -opp), radius, divisions));
            forceUpdate = true;
            CloudLayer.Log("Volume Initialized");
        }

        public VolumeManager(float cloudSphereRadius, Material cloudParticleMaterial, Transform transform)
            : this(cloudSphereRadius, transform)
        {
            atmosphere = true;
            VolumeList.Add(new VolumeSection(cloudParticleMaterial, transform, Center.localPosition, Magnitude, new Vector3(-radius, 0, 0), radius, divisions));
            VolumeList.Add(new VolumeSection(cloudParticleMaterial, transform, Center.localPosition, Magnitude, new Vector3(halfRad, 0, opp), radius, divisions));
            VolumeList.Add(new VolumeSection(cloudParticleMaterial, transform, Center.localPosition, Magnitude, new Vector3(halfRad, 0, -opp), radius, divisions));
            VolumeListBottom.Add(new VolumeSection(cloudParticleMaterial, transform, Center.localPosition, Magnitude, new Vector3(-radius, 0, 0), radius, divisions));
            VolumeListBottom.Add(new VolumeSection(cloudParticleMaterial, transform, Center.localPosition, Magnitude, new Vector3(halfRad, 0, opp), radius, divisions));
            VolumeListBottom.Add(new VolumeSection(cloudParticleMaterial, transform, Center.localPosition, Magnitude, new Vector3(halfRad, 0, -opp), radius, divisions));
            
            forceUpdate = true;
            CloudLayer.Log("Volume Initialized");
        }

        public void Update(Vector3 pos)
        {
            Vector3 place = pos;
            if (atmosphere)
            {
                if(forceUpdate)
                {
                    Recenter(pos, true);
                    Magnitude = pos.magnitude;
                    VolumeList[0].Reassign(Center.localPosition, new Vector3(-radius, 0, 0), Magnitude);
                    VolumeList[1].Reassign(Center.localPosition, new Vector3(halfRad, 0, opp), Magnitude);
                    VolumeList[2].Reassign(Center.localPosition, new Vector3(halfRad, 0, -opp), Magnitude);
                }

                int mag = (int)pos.magnitude;
                int i = mag / 3000;
                mag = 3000 * i;
                Magnitude = mag;
                
                pos.Normalize();
            }
            else
            {
                place *= Magnitude;
            }
            
            int moveCount = 0;
            int unchangedCount = 0;

            for (int i = 0; i < VolumeList.Count; i++)
            {
                VolumeSection volumeSection = VolumeList[i];
                float distance = Vector3.Distance(volumeSection.Center, place);

                if (distance > outCheck || forceUpdate)
                {
                    moveSections[moveCount++] = volumeSection;
                }
                else
                {
                    unchangedSections[unchangedCount++] = volumeSection;
                }
            }
            forceUpdate = false;
            if (moveCount > 0)
            {
                Vector3 tmp;
                switch (moveCount)
                {
                    case 1:
                        Recenter(-moveSections[0].Offset);

                        tmp = unchangedSections[0].Offset;
                        unchangedSections[0].Offset = -unchangedSections[1].Offset;
                        unchangedSections[1].Offset = -tmp;
                        moveSections[0].Reassign(Center.localPosition, -moveSections[0].Offset, Magnitude);
                        if (!atmosphere)
                        {
                            moveSections[0].Update();
                        }
                        break;
                    case 2:
                        Recenter(2f * unchangedSections[0].Offset);

                        unchangedSections[0].Offset *= -1f;
                        tmp = moveSections[0].Offset;
                        moveSections[0].Reassign(Center.localPosition, -moveSections[1].Offset, Magnitude);
                        moveSections[1].Reassign(Center.localPosition, -tmp, Magnitude);
                        if (!atmosphere)
                        {
                            moveSections[0].Update();
                            moveSections[1].Update();
                        }
                        break;
                    case 3:
                        Recenter(place, true);
                        moveSections[0].Reassign(Center.localPosition, new Vector3(-radius, 0, 0), Magnitude);
                        moveSections[1].Reassign(Center.localPosition, new Vector3(halfRad, 0, opp), Magnitude);
                        moveSections[2].Reassign(Center.localPosition, new Vector3(halfRad, 0, -opp), Magnitude);
                        if (!atmosphere)
                        {
                            moveSections[0].Update();
                            moveSections[1].Update();
                            moveSections[2].Update();
                        }
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
        }

        internal void Destroy()
        {
            GameObject.DestroyImmediate(translator);
            foreach (VolumeSection vs in VolumeList)
            {
                vs.Destroy();
            }

            CloudLayer.Log("Volume Destroyed");
        }
    }
}
