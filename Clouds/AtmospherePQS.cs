using EVEManager;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Utils;
using PQSManager;

namespace Atmosphere
{
    public class AtmospherePQS : PQSMod
    {
        private String body;
        private float altitude;
        private float speed;
        CloudsVolume layerVolume = null;
        Clouds2D layer2D = null;
        CelestialBody celestialBody = null;
        Transform scaledCelestialTransform = null;

        Callback onExitMapView;
        private bool applied = false;

        public override void OnSphereActive()
        {
            AtmosphereManager.Log("Active.");
            
            if (layer2D != null)
            {
                layer2D.Scaled = false;
            }
            if (!applied)
            {
                if (layerVolume != null)
                {
                    layerVolume.Apply((float)celestialBody.Radius + altitude, speed, celestialBody.transform);
                }
                applied = true;
            }
        }
        public override void OnSphereInactive()
        {
            AtmosphereManager.Log("Inactive.");
            
            if (layer2D != null)
            {
                layer2D.Scaled = true;
            }
            if (!MapView.MapIsEnabled)
            {
                if (layerVolume != null)
                {
                    layerVolume.Remove();
                }
                applied = false;
            }
        }
        protected void OnExitMapView()
        {
            StartCoroutine(CheckForDisable());
        }

        IEnumerator CheckForDisable()
        {
            yield return new WaitForFixedUpdate();
            if (!sphere.isActive)
            {
                if (layerVolume != null)
                {
                    layerVolume.Remove();
                }
                applied = false;
            }
            else
            {
                OnSphereActive();
            }
        }

        protected void Update()
        {
            if (this.sphere != null)
            {
                if (layer2D != null && sphere.isActive)
                {
                    layer2D.UpdateRotation(Quaternion.FromToRotation(Vector3.up, this.sphere.relativeTargetPosition));
                }
                else
                {
                    Vector3 pos = scaledCelestialTransform.InverseTransformPoint(ScaledCamera.Instance.camera.transform.position);
                    layer2D.UpdateRotation(Quaternion.FromToRotation(Vector3.up, pos));
                }
                if (layerVolume != null && sphere.isActive)
                {
                    layerVolume.UpdatePos(this.sphere.target.position);
                }
            }
        }

        internal void Apply(String body, Clouds2D layer2D, CloudsVolume layerVolume, float altitude, float speed)
        {
            this.body = body;
            this.layer2D = layer2D;
            this.layerVolume = layerVolume;
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

            if (pqs != null)
            {
                this.transform.parent = pqs.transform;
                this.transform.localPosition = Vector3.zero;
                this.transform.localRotation = Quaternion.identity;
                this.transform.localScale = Vector3.one;
                layer2D.Apply(celestialBody, scaledCelestialTransform, (float)(altitude + celestialBody.Radius), speed);
                if (!pqs.isActive)
                {
                    this.OnSphereInactive();
                }
                else
                {
                    this.OnSphereActive();
                }
            }
            this.sphere = pqs;
            onExitMapView = new Callback(OnExitMapView);
            MapView.OnExitMapView += onExitMapView;
        }

        public void Remove()
        {
            if (layer2D != null)
            {
                layer2D.Remove();
            }
            if (layerVolume != null)
            {
                layerVolume.Remove();
            }
            applied = false;
            this.sphere = null;
            MapView.OnExitMapView -= onExitMapView;
        }
    }
}
