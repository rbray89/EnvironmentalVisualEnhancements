using EVEManager;
using PQSManager;
using ShaderLoader;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using Utils;

namespace CelestialShadows
{
    public class ShadowPQS : PQSMod
    {
        
        CelestialBody celestialBody = null;
        Transform scaledCelestialTransform = null;

        Projector ShadowProjector = null;
        GameObject ShadowProjectorGO = null;

        Callback onExitMapView;
        Callback onEnterMapView;

        float radiusScale;

        private static Shader shadowShader = null;
        private static Shader ShadowShader
        {
            get
            {
                if (shadowShader == null)
                {
                    shadowShader = ShaderLoaderClass.FindShader("EVE/PlanetShadow");
                }
                return shadowShader;
            }
        }


        bool isScaled = true;
        public bool Scaled
        {
            get { return ShadowProjectorGO.layer == EVEManagerClass.SCALED_LAYER; }
            set
            {
                if (isScaled != value)
                {
                    if (value)
                    {
                        ShadowManager.Log("Scaled!");
                        float scale = (float)(1000f / celestialBody.Radius);
                        Reassign(EVEManagerClass.SCALED_LAYER, scaledCelestialTransform, scale);
                    }
                    else
                    {
                        ShadowManager.Log("Not Scaled!");
                        Reassign(EVEManagerClass.MACRO_LAYER, celestialBody.transform, 1);
                    }
                    isScaled = value;
                }
            }
        }



        
        protected void Update()
        {
            Vector3 worldSunDir = Vector3.Normalize(Sun.Instance.sunDirection);
            Vector3 sunDirection = Vector3.Normalize(ShadowProjector.transform.parent.InverseTransformDirection(worldSunDir));//sunTransform.position));
            ShadowProjector.transform.localPosition = radiusScale * sunDirection;
               
            ShadowProjector.transform.forward = worldSunDir;

            ShadowProjector.material.SetVector(EVEManagerClass.SUNDIR_PROPERTY, worldSunDir);
            Vector3 planetOrigin = ShadowProjector.transform.parent.transform.position;
            ShadowProjector.material.SetVector(EVEManagerClass.PLANET_ORIGIN_PROPERTY, planetOrigin);
        }


        

        internal void Apply(string body)
        {
            celestialBody = Tools.GetCelestialBody(body);
            this.scaledCelestialTransform = Tools.GetScaledTransform(body);

            PQS pqs = null;
            if (celestialBody != null && celestialBody.pqsController != null)
            {
                pqs = celestialBody.pqsController;
            }
            else
            {
                pqs = PQSManagerClass.GetPQS(body);
            }

            Transform transform = Tools.GetScaledTransform(body);


            if (pqs != null)
            {
                ShadowManager.Log("PQS Assignment!");
                this.sphere = pqs;
                this.transform.parent = pqs.transform;
                this.requirements = PQS.ModiferRequirements.Default;
                this.modEnabled = true;
                this.order += 10;

                this.transform.localPosition = Vector3.zero;
                this.transform.localRotation = Quaternion.identity;
                this.transform.localScale = Vector3.one;
            }

            ShadowManager.Log("Shadow Setup!");
            ShadowProjectorGO = new GameObject();
            ShadowProjector = ShadowProjectorGO.AddComponent<Projector>();
            ShadowProjector.nearClipPlane = 10;
            ShadowProjector.fieldOfView = 60;
            ShadowProjector.aspectRatio = 1;
            ShadowProjector.orthographic = true;
            ShadowProjector.material = new Material(ShadowShader);

            onExitMapView = new Callback(OnExitMapView);
            MapView.OnExitMapView += onExitMapView;
            onEnterMapView = new Callback(OnEnterMapView);
            MapView.OnEnterMapView += onEnterMapView;

            GameEvents.onGameSceneLoadRequested.Add(GameSceneLoaded);

            this.OnSetup();
            pqs.EnableSphere();

            Scaled = false;
        }

        public override void OnSphereActive()
        {
            Scaled = true;
        }

        public override void OnSphereInactive()
        {
            if (MapView.MapIsEnabled)
            {
                Scaled = true;
            }
            else
            {
                Scaled = false;
            }
        }

        private void OnEnterMapView()
        {
          Scaled = true;
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
                OnSphereInactive();
            }
            else
            {
                OnSphereActive();
            }
        }

        public void Reassign(int layer, Transform parent, float scale)
        {

            radiusScale =(float) celestialBody.Radius * scale;
            float worldRadiusScale = Vector3.Distance(parent.transform.TransformPoint(Vector3.up * radiusScale), parent.transform.TransformPoint(Vector3.zero));

            if (ShadowProjector != null)
            {

                ShadowManager.Log("Reassigning!");
                float dist = (float)(20000000);
                ShadowProjector.farClipPlane = dist;
                ShadowProjector.orthographicSize = worldRadiusScale;

                ShadowProjector.material.SetFloat("_PlanetRadius", worldRadiusScale);
                ShadowProjector.transform.parent = parent;
                //ShadowProjector.transform.localScale = scale * Vector3.one;
                ShadowProjectorGO.layer = layer;
                if (layer == EVEManagerClass.MACRO_LAYER)
                {
                    ShadowProjector.ignoreLayers = ~((1 << 19) | (1 << 15) | 2 | 1);
                }
                else
                {
                    ShadowProjector.ignoreLayers = ~((1 << 10));// | (1 << 9));
                }
            }
        }

        internal void Remove()
        {
            this.sphere = null;
            this.enabled = false;
            this.transform.parent = null;
            if (ShadowProjector != null)
            {
                ShadowProjector.transform.parent = null;
                GameObject.DestroyImmediate(ShadowProjector);
                ShadowProjector = null;
            }
            MapView.OnExitMapView -= onExitMapView;
            MapView.OnEnterMapView -= onEnterMapView;
            GameEvents.onGameSceneLoadRequested.Remove(GameSceneLoaded);
        }

        private void GameSceneLoaded(GameScenes scene)
        {
            if (scene == GameScenes.TRACKSTATION)
            {
                this.OnSphereInactive();
                sphere.isActive = false;
            }
        }
    }
}
