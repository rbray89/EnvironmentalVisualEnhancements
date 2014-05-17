using EVEManager;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Utils;

namespace Atmosphere
{
    public class AtmospherePQS : PQSMod
    {
        private String body;
        private float altitude;
        private float speed;
        CloudsVolume layerVolume = null;
        Clouds2D layer2D = null;

        
        Callback onExitMapView;
        private bool applied = false;

        public override void OnSphereActive()
        {
            AtmosphereManager.Log("Active.");
            if (sphere != null && !applied)
            {
                CelestialBody celestialBody = EVEManagerClass.GetCelestialBody(body);
                if (layer2D != null)
                {
                    layer2D.Apply((float)celestialBody.Radius + altitude, speed, celestialBody.transform);
                }
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
            if (!MapView.MapIsEnabled)
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
            }
        }
        protected void OnExitMapView()
        {
            StartCoroutine(CheckForDisable());
        }

        IEnumerator CheckForDisable()
        {
            yield return new WaitForFixedUpdate();
            if (sphere == null || !sphere.isActive)
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
            }
        }

        protected void Update()
        {
            if (this.sphere != null && sphere.isActive)
            {
                if (layer2D != null)
                {
                    layer2D.UpdateRotation(Quaternion.FromToRotation(Vector3.up, this.sphere.relativeTargetPosition));
                }
                if (layerVolume != null)
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
            CelestialBody celestialBody = EVEManagerClass.GetCelestialBody(body);
            if (celestialBody != null && celestialBody.pqsController != null)
            {
                this.transform.parent = celestialBody.pqsController.transform;
                this.sphere = celestialBody.pqsController;
                if (this.sphere.isActive)
                {
                    this.OnSphereActive();
                }
            }
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
