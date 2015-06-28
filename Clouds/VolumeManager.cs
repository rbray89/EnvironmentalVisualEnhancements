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

        public VolumeManager(float cloudSphereRadius, Vector2 size, Texture2D texture, Vector3 texOffset, Material cloudParticleMaterial, Transform transform)
            : this(cloudSphereRadius, transform)
        {
            atmosphere = false;
            VolumeList.Add(new VolumeSection(texture, cloudParticleMaterial, texOffset, size, transform, Center.localPosition, Magnitude, new Vector3(-radius, 0, 0), radius, divisions));
            forceUpdate = true;
        }

        public void Update(Vector3 pos)
        {
            Vector3 place = pos;

                place *= Magnitude;

            Recenter(place, true);
            VolumeList[0].Reassign(Center.localPosition, new Vector3(-0, 0, 0), Magnitude);

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


        }
    }
}
