using EVEManager;
using PQSManager;
using ShaderLoader;
using System;
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


        public override void OnSphereActive()
        {
           
        }
        public override void OnSphereInactive()
        {

        }
        
        protected void Update()
        {
            ShadowManager.Log("Update!");
            if (!this.sphere.isActiveAndEnabled && celestialBody != null)
            {
                ShadowManager.Log("Updating stuff!");
                Vector3 worldSunDir = Vector3.Normalize(Sun.Instance.sunDirection);
                //Vector3 sunDirection = Vector3.Normalize(ShadowProjector.transform.parent.InverseTransformDirection(worldSunDir));//sunTransform.position));
                //ShadowProjector.transform.localPosition = radiusScale * sunDirection;
                CelestialBody kerbin = FlightGlobals.currentMainBody;
                ShadowProjector.transform.parent = kerbin.transform;
                Vector3 sunDirection = Vector3.Normalize(ShadowProjector.transform.parent.InverseTransformDirection(worldSunDir));//sunTransform.position));
                ShadowProjector.transform.localPosition = (float)(kerbin.Radius+10000) * -sunDirection;
                ShadowProjector.transform.forward = worldSunDir;

                ShadowProjector.material.SetVector(EVEManagerClass.SUNDIR_PROPERTY, worldSunDir);
                Vector3 planetOrigin = celestialBody.transform.position;
                ShadowProjector.material.SetVector(EVEManagerClass.PLANET_ORIGIN_PROPERTY, ShadowProjector.transform.position);
            }
        }


        

        internal void Apply(string body)
        {
            celestialBody = Tools.GetCelestialBody(body);
            this.scaledCelestialTransform = scaledCelestialTransform;

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
            ShadowProjector.transform.parent = celestialBody.transform;
            ShadowProjector.material = new Material(ShadowShader);

            this.OnSetup();
            pqs.EnableSphere();

            Scaled = false;
        }

        public void Reassign(int layer, Transform parent, float scale)
        {

            radiusScale = (float)celestialBody.Radius * scale;

            if (ShadowProjector != null)
            {

                ShadowManager.Log("Reassigning!");
                float dist = (float)(20000000);
                ShadowProjector.farClipPlane = dist;
                ShadowProjector.orthographicSize = radiusScale;

                ShadowProjector.material.SetFloat("_PlanetRadius", radiusScale);
                ShadowProjector.transform.parent = parent;
                //ShadowProjector.transform.localScale = scale * Vector3.one;
                ShadowProjectorGO.layer = layer;
                if (layer == EVEManagerClass.MACRO_LAYER)
                {
                    ShadowProjector.ignoreLayers = ~((1 << 19) | (1 << 15) | 2 | 1);
                }
                else
                {
                    ShadowProjector.ignoreLayers = ~((1 << 29) | (1 << 23) | (1 << 18) | (1 << 10));// | (1 << 9));
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
        }
    }
}
