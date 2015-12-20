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
#pragma warning disable 0169
#pragma warning disable 0414
        [ConfigItem]
        Color _Color = 256 * Color.white;
        [ConfigItem]
        float _DensityFactorA = 2f;
        [ConfigItem]
        float _DensityFactorB = 1f;
        [ConfigItem]
        float _DensityFactorC = 1f;
        [ConfigItem]
        float _DensityFactorD = 42f;
        [ConfigItem]
        float _DensityFactorE = 0f;
        [InverseScaled]
        float _Scale = 1f;
        [ConfigItem]
        float _Visibility = .5f;
        [ConfigItem]
        float _DensityVisibilityBase = 2.71f;
		[ConfigItem]
        float _DensityVisibilityPow = .001f;
		[ConfigItem]
        float _DensityVisibilityOffset = 1;
		[ConfigItem]
        float _DensityCutoffBase = 2.71f;
		[ConfigItem]
        float _DensityCutoffPow = .001f;
		[ConfigItem]
        float _DensityCutoffOffset = 1;
		[ConfigItem]
        float _DensityCutoffScale = 1;

        [ConfigItem]
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

        AtmosphereVolumeMaterial atmosphereMaterial;

        CelestialBody celestialBody = null;
        Transform scaledCelestialTransform = null;
        float radius;

        public bool Scaled
        {
            get { return AtmosphereMesh.layer == (int)Tools.Layer.Scaled; }
            set
            {
                if (value)
                {
                    float scale = (float)(radius / celestialBody.Radius);
                    atmosphereMaterial.ApplyMaterialProperties(AtmosphereMaterial, ScaledSpace.ScaleFactor);
                    AtmosphereMaterial.DisableKeyword("WORLD_SPACE_OFF");
                    Reassign(Tools.Layer.Scaled, scaledCelestialTransform, scale);
                }
                else
                {
                    atmosphereMaterial.ApplyMaterialProperties(AtmosphereMaterial);
                    AtmosphereMaterial.EnableKeyword("WORLD_SPACE_ON");
                    Reassign(Tools.Layer.Local, FlightCamera.fetch.transform, 1);
                }
                
            }
        }

        private static Shader atmosphereShader = null;

        public AtmosphereVolume(AtmosphereVolumeMaterial atmosphereMat)
        {
            this.atmosphereMaterial = atmosphereMat;
        }

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


        public void Reassign(Tools.Layer layer, Transform parent, float scale)
        {
            AtmosphereMesh.transform.parent = parent;
            AtmosphereMesh.transform.localPosition = Vector3.zero;
            AtmosphereMesh.transform.localScale = scale * Vector3.one;
            AtmosphereMesh.layer = (int)layer;
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
            AtmosphereMaterial.SetVector(ShaderProperties.PLANET_ORIGIN_PROPERTY, planetOrigin);
        }


    }
}
