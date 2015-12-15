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
        AtmosphereVolume atmosphere = null;
        CelestialBody celestialBody = null;
        Transform scaledCelestialTransform = null;

        Callback onExitMapView;
        private bool applied = false;
        private float radius;
        

        public override void OnSphereActive()
        {

            AtmosphereManager.Log("AtmospherePQS: OnSphereActive");
            if (atmosphere != null)
            {
                atmosphere.Scaled = false;
            }
            if (!applied)
            {
                applied = true;
            }
        }
        public override void OnSphereInactive()
        {
            AtmosphereManager.Log("AtmospherePQS: OnSphereInactive");
            if (atmosphere != null)
            {
                atmosphere.Scaled = true;
            }
            if (!MapView.MapIsEnabled)
            {
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
            

            Quaternion rotation = Quaternion.Euler(0, 0, 0);
            Matrix4x4 mainRotationMatrix = Matrix4x4.TRS(Vector3.zero, rotation, Vector3.one);

            rotation = Quaternion.Euler(0, 0, 0);
            Matrix4x4 detailRotationMatrix = Matrix4x4.TRS(Vector3.zero, rotation, Vector3.one);

            if (this.sphere != null && visible)
            {
                if (atmosphere != null)
                {
                    atmosphere.UpdatePosition();
                }
            }
        }

        internal void Apply(String body, AtmosphereVolume atmosphere, float altitude)
        {
            this.body = body;
            this.atmosphere = atmosphere;
            this.altitude = altitude;

            celestialBody = Tools.GetCelestialBody(body);
            scaledCelestialTransform = Tools.GetScaledTransform(body);
            PQS pqs = null;
            if (celestialBody != null && celestialBody.pqsController != null)
            {
                pqs = celestialBody.pqsController;
            }
            else
            {
                AtmosphereManager.Log("No PQS! Instanciating one.");
                pqs = PQSManagerClass.GetPQS(body);
            }
            AtmosphereManager.Log("PQS Applied");
            if (pqs != null)
            {
                this.sphere = pqs;
                this.transform.parent = pqs.transform;
                this.requirements = PQS.ModiferRequirements.Default;
                this.modEnabled = true;
                this.order += 10;

                this.transform.localPosition = Vector3.zero;
                this.transform.localRotation = Quaternion.identity;
                this.transform.localScale = Vector3.one;
                this.radius = (float)(altitude + celestialBody.Radius);
               
               
                if (atmosphere != null)
                {
                    this.atmosphere.Apply(celestialBody, scaledCelestialTransform, radius);
                }

                if (!pqs.isActive || HighLogic.LoadedScene == GameScenes.TRACKSTATION)
                {
                    this.OnSphereInactive();
                }
                else
                {
                    this.OnSphereActive();
                }
                this.OnSetup();
                pqs.EnableSphere();
            }
            else
            {
                AtmosphereManager.Log("PQS is null somehow!?");
            }
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
            if (atmosphere != null)
            {
                atmosphere.Remove();
            }
            atmosphere = null;
            applied = false;
            this.sphere = null;
            this.enabled = false;
            this.transform.parent = null;
            MapView.OnExitMapView -= onExitMapView;
            GameEvents.onGameSceneLoadRequested.Remove(GameSceneLoaded);
        }
    }
}
