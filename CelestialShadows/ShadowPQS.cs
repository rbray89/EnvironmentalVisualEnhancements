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
    public class ShadowComponent : Component
    {
        
        CelestialBody celestialBody = null;
        Transform scaledCelestialTransform = null;
        
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

        
        protected void Update()
        {/*
            Vector3 worldSunDir = Vector3.Normalize(Sun.Instance.sunDirection);
            Vector3 sunDirection = Vector3.Normalize(ShadowProjector.transform.parent.InverseTransformDirection(worldSunDir));//sunTransform.position));
            ShadowProjector.transform.localPosition = posScale * sunDirection;
               
            ShadowProjector.transform.forward = worldSunDir;

            ShadowProjector.material.SetVector(EVEManagerClass.SUNDIR_PROPERTY, worldSunDir);
            Vector3 planetOrigin = ShadowProjector.transform.parent.transform.position;
            ShadowProjector.material.SetVector(EVEManagerClass.PLANET_ORIGIN_PROPERTY, planetOrigin);*/
        }


        

        internal void Apply(string body)
        {
            celestialBody = Tools.GetCelestialBody(body);
            scaledCelestialTransform = Tools.GetScaledTransform(body);
            
        }

        internal void Remove()
        {
        }

        private void GameSceneLoaded(GameScenes scene)
        {
        }
    }
}
