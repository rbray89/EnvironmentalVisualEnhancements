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
            bool visible = HighLogic.LoadedScene == GameScenes.TRACKSTATION || HighLogic.LoadedScene == GameScenes.FLIGHT || HighLogic.LoadedScene == GameScenes.SPACECENTER;
            if (this.sphere != null && visible)
            {
                if (layer2D != null && sphere.isActive && HighLogic.LoadedScene != GameScenes.TRACKSTATION)
                {
                    layer2D.UpdateRotation(Quaternion.FromToRotation(Vector3.up, this.sphere.relativeTargetPosition));
                }
                else
                {
                    Transform transform = ScaledCamera.Instance.camera.transform;
                    Vector3 pos = scaledCelestialTransform.InverseTransformPoint(transform.position);
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
            GameEvents.onGameSceneLoadRequested.Add(GameSceneLoaded);
        }

        private void GameSceneLoaded(GameScenes scene)
        {
            if (scene == GameScenes.TRACKSTATION)
            {
                this.OnSphereInactive();
                sphere.isActive = false;
            }
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
            GameEvents.onGameSceneLoadRequested.Remove(GameSceneLoaded);
        }
    }
}
