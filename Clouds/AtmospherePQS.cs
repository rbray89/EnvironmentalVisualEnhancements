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
        AtmosphereVolume atmosphere = null;
        CelestialBody celestialBody = null;
        Transform scaledCelestialTransform = null;

        Callback onExitMapView;
        private bool applied = false;
        private float radius;

        float detailPeriod;
        float mainPeriod;
        Vector2 offset;

        public override void OnSphereActive()
        {

            AtmosphereManager.Log("AtmospherePQS: OnSphereActive");
            if (layer2D != null)
            {
                layer2D.Scaled = false;
            }
            if (atmosphere != null)
            {
                atmosphere.Scaled = false;
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
            AtmosphereManager.Log("AtmospherePQS: OnSphereInactive");
            if (layer2D != null)
            {
                layer2D.Scaled = true;
            }
            if (atmosphere != null)
            {
                atmosphere.Scaled = true;
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

            double ut = Planetarium.GetUniversalTime();
            double detailRotation = (ut * detailPeriod);
            detailRotation -= (int)detailRotation;
            double mainRotation = (ut * mainPeriod);
            mainRotation -= (int)mainRotation;


            Quaternion rotation = Quaternion.Euler(0, (float)(360f * mainRotation), 0);
            Matrix4x4 mainRotationMatrix = Matrix4x4.TRS(Vector3.zero, rotation, Vector3.one);

            rotation = Quaternion.Euler(0, (float)(360f * mainRotation), 0);
            Matrix4x4 detailRotationMatrix = Matrix4x4.TRS(Vector3.zero, rotation, Vector3.one);

            if (this.sphere != null && visible)
            {
                if (sphere.isActive && HighLogic.LoadedScene != GameScenes.TRACKSTATION && !MapView.MapIsEnabled)
                {
                    if (layer2D != null)
                    {
                        layer2D.UpdateRotation(Quaternion.FromToRotation(Vector3.up, this.sphere.relativeTargetPosition), 
                                               this.sphere.transform.worldToLocalMatrix,
                                               mainRotationMatrix,
                                               detailRotationMatrix);
                    }
                }
                else
                {
                    Transform transform = ScaledCamera.Instance.camera.transform;
                    Vector3 pos = scaledCelestialTransform.InverseTransformPoint(transform.position);
                    if (layer2D != null)
                    {
                        layer2D.UpdateRotation(Quaternion.FromToRotation(Vector3.up, pos),
                                               scaledCelestialTransform.transform.worldToLocalMatrix,
                                               mainRotationMatrix,
                                               detailRotationMatrix);
                    }
                }
                if (layerVolume != null && sphere.isActive)
                {
                    if(FlightCamera.fetch != null)
                    {
                        layerVolume.UpdatePos(FlightCamera.fetch.mainCamera.transform.position,
                                               Quaternion.Euler(0, (float)(-360f * mainRotation), 0),
                                               mainRotationMatrix,
                                               detailRotationMatrix);
                    }
                    else
                    {
                        layerVolume.UpdatePos(this.sphere.target.position,
                                               Quaternion.Euler(0, (float)(-360f * mainRotation), 0),
                                               mainRotationMatrix,
                                               detailRotationMatrix);
                    }
                }
                if (atmosphere != null)
                {
                    atmosphere.UpdatePosition();
                }
            }
        }

        internal void Apply(String body, Clouds2D layer2D, CloudsVolume layerVolume, AtmosphereVolume atmosphere, float altitude, float speed, float detailSpeed, Vector2 offset)
        {
            this.body = body;
            this.layer2D = layer2D;
            this.layerVolume = layerVolume;
            this.atmosphere = atmosphere;
            this.altitude = altitude;
            this.speed = speed;
            this.offset = offset;

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
                this.transform.localPosition = Vector3.zero;
                this.transform.localRotation = Quaternion.identity;
                this.transform.localScale = Vector3.one;
                this.radius = (float)(altitude + celestialBody.Radius);
                
                
                float circumference = 2f * Mathf.PI * radius;
                mainPeriod = (speed) / circumference;
                detailPeriod = (speed + detailSpeed) / circumference;
                
                if (layer2D != null)
                {
                    this.layer2D.Apply(celestialBody, scaledCelestialTransform, radius, speed);
                }
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
            if (layer2D != null)
            {
                layer2D.Remove();
            }
            if (layerVolume != null)
            {
                layerVolume.Remove();
            }
            if (atmosphere != null)
            {
                atmosphere.Remove();
            }
            layer2D = null;
            layerVolume = null;
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
