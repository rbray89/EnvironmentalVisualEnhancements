using EVEManager;
using ShaderLoader;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using Utils;

namespace Atmosphere
{
    public class AtmosphereVolumeMaterial : MaterialManager
    {
        [Persistent]
        Color _Color = new Color(1, 1, 1, 1);
        [Persistent]
        float _DensityFactorA = 2f;
        [Persistent]
        float _DensityFactorB = 1f;
        [Persistent]
        float _DensityFactorC = 1f;
        [Persistent]
        float _DensityFactorD = 42f;
        [Persistent]
        float _DensityFactorE = 0f;
        [InverseScaled]
        float _Scale = 1f;
        [Persistent]
        float _Visibility = .5f;
        [Persistent]
        float _DensityVisibilityBase = 2.71f;
		[Persistent]
        float _DensityVisibilityPow = .001f;
		[Persistent]
        float _DensityVisibilityOffset = 1;
		[Persistent]
        float _DensityCutoffBase = 2.71f;
		[Persistent]
        float _DensityCutoffPow = .001f;
		[Persistent]
        float _DensityCutoffOffset = 1;
		[Persistent]
        float _DensityCutoffScale = 1;

        [Persistent]
        Color _SunsetColor = new Color(1, 0, 0, .45f);
        [Scaled]
        float _OceanRadius;
        [Scaled]
        float _SphereRadius;
 
        public float OceanRadius { set { _OceanRadius = value; } }
        public float SphereRadius { set { _SphereRadius = value; } }
        public float Scale { set { _Scale = value; } }
    }

    class AtmosphereVolume
    {

        GameObject AtmosphereMesh;
        Material AtmosphereMaterial;

        [Persistent]
        AtmosphereVolumeMaterial atmosphereMaterial;

        CelestialBody celestialBody = null;
        Transform scaledCelestialTransform = null;
        float radius;

        public bool Scaled
        {
            get { return AtmosphereMesh.layer == EVEManagerClass.SCALED_LAYER; }
            set
            {
                if (value)
                {
                    float scale = (float)(radius / celestialBody.Radius);
                    atmosphereMaterial.ApplyMaterialProperties(AtmosphereMaterial, ScaledSpace.ScaleFactor);
                    AtmosphereMaterial.EnableKeyword("WORLD_SPACE_OFF");
                    AtmosphereMaterial.DisableKeyword("WORLD_SPACE_ON");
                    Reassign(EVEManagerClass.SCALED_LAYER, scaledCelestialTransform, scale);
                }
                else
                {
                    atmosphereMaterial.ApplyMaterialProperties(AtmosphereMaterial);
                    AtmosphereMaterial.DisableKeyword("WORLD_SPACE_OFF");
                    AtmosphereMaterial.EnableKeyword("WORLD_SPACE_ON");
                    Reassign(EVEManagerClass.MACRO_LAYER, FlightCamera.fetch.transform, 1);
                }
                
            }
        }

        private static Shader atmosphereShader = null;
        private static Shader AtmosphereShader
        {
            get
            {
                if (atmosphereShader == null)
                {
                    atmosphereShader = ShaderLoaderClass.FindShader("EVE/Atmosphere");
                } return atmosphereShader;
            }
        }

        internal void Apply(CelestialBody celestialBody, Transform scaledCelestialTransform, float radius)
        {
            Remove();
            this.celestialBody = celestialBody;
            this.scaledCelestialTransform = scaledCelestialTransform;
            SimpleCube hp = new SimpleCube(2000, ref AtmosphereMaterial, AtmosphereShader);
            AtmosphereMesh = hp.GameObject;

            atmosphereMaterial.Scale = 500f / (float)celestialBody.Radius;

            this.radius = radius;
            if (celestialBody.ocean)
            {
                atmosphereMaterial.OceanRadius = (float)celestialBody.Radius;
            }
            else
            {
                atmosphereMaterial.OceanRadius = 0;
            }

            atmosphereMaterial.SphereRadius = (float)celestialBody.Radius;

            Scaled = false;

        }


        public void Reassign(int layer, Transform parent, float scale)
        {
            AtmosphereMesh.transform.parent = parent;
            AtmosphereMesh.transform.localPosition = Vector3.zero;
            AtmosphereMesh.transform.localScale = scale * Vector3.one;
            AtmosphereMesh.layer = layer;
        }

        public void Remove()
        {
            if (AtmosphereMesh != null)
            {
                AtmosphereMesh.transform.parent = null;
                GameObject.DestroyImmediate(AtmosphereMesh);
                AtmosphereMesh = null;
            }
        }

        internal void UpdatePosition()
        {
            Vector3 planetOrigin = celestialBody.transform.position;
            AtmosphereMaterial.SetVector(EVEManagerClass.PLANET_ORIGIN_PROPERTY, planetOrigin);
        }


    }
}
