using EVEManager;
using PQSManager;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Utils;

namespace Atmosphere
{
    public class ScaledAtmospherePQS : PQSMod
    {
        private String body;
        private float altitude;
        private float speed;
        Clouds2D layer2D = null;

        CelestialBody celestialBody = null;
        Transform scaledCelestialTransform = null;

        public override void OnSphereActive()
        {
            CelestialBody celestialBody = EVEManagerClass.GetCelestialBody(body);
            if (layer2D != null)
            {
                layer2D.Enabled = false;
            }
        }
        public override void OnSphereInactive()
        {
            if (layer2D != null)
            {
                layer2D.Enabled = true;
            }
        }

        protected void Update()
        {
            if (this.sphere == null || !sphere.isActive)
            {
                if (layer2D != null)
                {
                    Vector3 pos = scaledCelestialTransform.InverseTransformPoint(ScaledCamera.Instance.camera.transform.position);
                    layer2D.UpdateRotation(Quaternion.FromToRotation(Vector3.up, pos));
                }
            }
        }

        internal void Apply(String body, Clouds2D layer2D, float altitude, float speed)
        {
            this.body = body;
            this.layer2D = layer2D;
            this.altitude = altitude;
            this.speed = speed;
            celestialBody = EVEManagerClass.GetCelestialBody(body);
            scaledCelestialTransform = EVEManagerClass.GetScaledTransform(body);
            PQS pqs = null;
            if (celestialBody != null && celestialBody.pqsController != null)
            {
                pqs = celestialBody.pqsController;
            }
            else
            {
                pqs = PQSManagerClass.GetPQS(body);
            }
            this.sphere = pqs;
            if (pqs != null)
            {
                this.transform.parent = pqs.transform;
                layer2D.Apply(EVEManagerClass.MAP_LAYER, (float)(altitude + celestialBody.Radius), speed, scaledCelestialTransform, (float)(1000f / celestialBody.Radius) * Vector3.one);
                if (!this.sphere.isActive)
                {
                    this.OnSphereInactive();
                }
            }
        }

        public void Remove()
        {
            if (layer2D != null)
            {
                layer2D.Remove();
            }
            this.sphere = null;
        }
    }
}
