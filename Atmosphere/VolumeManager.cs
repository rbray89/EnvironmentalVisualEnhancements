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
        

        float Magnitude;
        VolumeSection[] moveSections;
        VolumeSection[] unchangedSections;

        GameObject translator;
        Transform Center;

        bool enabled;
        public bool Enabled { get { return enabled; } set { enabled = value; foreach (VolumeSection vs in VolumeList) { vs.Enabled = value; } } }

        public VolumeManager(float cloudSphereRadius, Transform transform, float radius, int divisions)
        {
            Magnitude = cloudSphereRadius;
            Vector3 pos = Vector3.up * Magnitude;
            translator = new GameObject();
            Center = translator.transform;
            Center.localScale = Vector3.one;
            Center.parent = transform;
            Recenter(pos, true);

            this.radius = radius;
            this.divisions = divisions;
            halfRad = radius / 2f;
            opp = Mathf.Sqrt(.75f) * radius;
            outCheck = opp * 2f;

            enabled = true;

            moveSections = new VolumeSection[3];
            unchangedSections = new VolumeSection[3];
        }

        public VolumeManager(float cloudSphereRadius, Vector2 size,Material cloudParticleMaterial, Transform transform, float radius, int divisions)
            : this(cloudSphereRadius, transform, radius, divisions)
        {
            VolumeList.Add(new VolumeSection( cloudParticleMaterial, size, transform, Center.localPosition, Magnitude, radius, divisions));
        }

        public void Update(Vector3 pos)
        {
            Vector3 place = pos;

                place *= Magnitude;

            Recenter(place, true);
            VolumeList[0].Reassign(Center.localPosition, Magnitude);

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
