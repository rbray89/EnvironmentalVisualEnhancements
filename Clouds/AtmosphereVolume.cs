using EVEManager;
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
        [Persistent, InverseScaled]
        float _Visibility = .0001f;
        [Persistent]
        float _DensityRatioY = .5f;
        [Persistent]
        float _DensityRatioX = .5f;
        [Scaled]
        float _SphereRadius;
        [Scaled]
        float _OceanRadius;
        [Persistent]
        Color _SunsetColor = new Color(1, 0, 0, .45f);

        public float SphereRadius { set { _SphereRadius = value; } }
        public float OceanRadius { set { _OceanRadius = value; } }
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
                    float scale = (float)(radius*2 / celestialBody.Radius);
                    atmosphereMaterial.ApplyMaterialProperties(AtmosphereMaterial, Tools.GetWorldToScaledSpace(celestialBody.bodyName));
                    AtmosphereMaterial.DisableKeyword("WORLD_SPACE_ON");
                    Reassign(EVEManagerClass.SCALED_LAYER, scaledCelestialTransform, scale);
                    //Reassign(EVEManagerClass.SCALED_LAYER, FlightCamera.fetch.transform, scale);
                }
                else
                {
                    atmosphereMaterial.ApplyMaterialProperties(AtmosphereMaterial);
                    AtmosphereMaterial.EnableKeyword("WORLD_SPACE_ON");
                    Reassign(EVEManagerClass.MACRO_LAYER, FlightCamera.fetch.transform, 1);
                    
                    //Reassign(EVEManagerClass.MACRO_LAYER, celestialBody.transform, 1);
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
                    Assembly assembly = Assembly.GetExecutingAssembly();
                    atmosphereShader = Tools.GetShader(assembly, "Atmosphere.Shaders.Compiled-SphereAtmosphere.shader");
                } return atmosphereShader;
            }
        }

        internal void Apply(CelestialBody celestialBody, Transform scaledCelestialTransform, float radius)
        {
            Remove();
            this.celestialBody = celestialBody;
            this.scaledCelestialTransform = scaledCelestialTransform;
            AtmosphereMaterial = new Material(AtmosphereShader);
            SimpleCube hp = new SimpleCube(2000, AtmosphereMaterial);
            AtmosphereMesh = hp.GameObject;
            
            this.radius = radius;
            atmosphereMaterial.SphereRadius = radius;
            if (celestialBody.ocean)
            {
                atmosphereMaterial.OceanRadius = (float)celestialBody.Radius;
            }
            else
            {
                atmosphereMaterial.OceanRadius = 0;
            }
            Scaled = true;
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
