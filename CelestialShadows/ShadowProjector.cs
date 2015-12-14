using EVEManager;
using ShaderLoader;
using System;
using UnityEngine;
using Utils;

namespace CelestialShadows
{
    public class ShadowProjector
    {

        Projector projector = null;
        GameObject projectorGO = null;

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

        public ShadowProjector()
        {
            projectorGO = new GameObject();
            
            projector = projectorGO.AddComponent<Projector>();
            projector.nearClipPlane = 10;
            projector.fieldOfView = 60;
            projector.aspectRatio = 1;
            projector.orthographic = true;
            projector.farClipPlane = 200000000000;
            projector.orthographicSize = 2 * 10000000;
            
            //ShadowProjector.transform.localScale = scale * Vector3.one;
            projectorGO.layer = (int)Tools.Layer.Local;

            projector.material = new Material(ShadowShader);
        }

        internal void UpdatePos(Vector3 position)
        {
            Vector3 worldSunDir = Vector3.Normalize(Sun.Instance.sunDirection);
           
            projector.transform.position = (1000 * -worldSunDir) + position;

            projector.transform.forward = worldSunDir;

            projector.material.SetVector(ShaderProperties.SUNDIR_PROPERTY, worldSunDir);
            //Vector3 planetOrigin = projector.transform.parent.transform.position;
            //projector.material.SetVector(EVEManagerClass.PLANET_ORIGIN_PROPERTY, planetOrigin);
        }
    }
}