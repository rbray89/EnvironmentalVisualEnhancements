using Utils;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using EVEManager;

namespace Terrain
{
    public class something : GameDatabase.TextureInfo
    {
        public new Texture2D  texture { get { return null; } set { } }

        public something(Texture2D texture, bool isNormalMap, bool isReadable, bool isCompressed) : base(texture,isNormalMap, isReadable, isCompressed)
        {

        }
    }
    
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class TerrainManager : GenericEVEManager<TerrainObject>
    {
        protected override ObjectType objectType { get { return ObjectType.PLANET; } }
        protected override String configName { get { return "EVE_TERRAIN"; } }

        private bool camerasInitialized = false;
        private static Shader oceanShader = null;
        private static Shader oceanShaderNear = null;
        private static Shader planetShader = null;
        private static Shader terrainShader = null;
        public static Shader OceanShaderNear
        {
            get
            {
                if (oceanShaderNear == null)
                {
                    Assembly assembly = Assembly.GetExecutingAssembly();
                    oceanShaderNear = Tools.GetShader(assembly, "Terrain.Shaders.Compiled-SphereOceanNear.shader");
                } return oceanShaderNear;
            }
        }
        public static Shader OceanShader
        {
            get
            {
                if (oceanShader == null)
                {
                    Assembly assembly = Assembly.GetExecutingAssembly();
                    oceanShader = Tools.GetShader(assembly, "Terrain.Shaders.Compiled-SphereOcean.shader");
                } return oceanShader;
            }
        }
        public static Shader PlanetShader
        {
            get
            {
                if (planetShader == null)
                {
                    Assembly assembly = Assembly.GetExecutingAssembly();
                    planetShader = Tools.GetShader(assembly, "Terrain.Shaders.Compiled-SpherePlanet.shader");
                } return planetShader;
            }
        }
        public static Shader TerrainShader
        {
            get
            {
                if (terrainShader == null)
                {
                    Assembly assembly = Assembly.GetExecutingAssembly();
                    terrainShader = Tools.GetShader(assembly, "Terrain.Shaders.Compiled-SphereTerrain.shader");
                } return terrainShader;
            }
        }

        protected new void Update()
        {
            if(!camerasInitialized)
            {
                Camera[] cameras = Camera.allCameras;
                foreach (Camera cam in cameras)
                {
                    if (cam.name == "Camera 01" || cam.name == "Camera 00")
                    {
                        cam.depthTextureMode = DepthTextureMode.Depth;
                        camerasInitialized = true;
                    }
                }
            }

            CelestialBody cb = FlightGlobals.currentMainBody;
            if(cb != null && cb.pqsController != null)
            {
                Vector3 sunDir = cb.transform.InverseTransformDirection(Sun.Instance.sunDirection);
                cb.pqsController.surfaceMaterial.SetVector(EVEManagerClass.SUNDIR_PROPERTY, sunDir);
                Vector3 planetOrigin = cb.transform.position;
                cb.pqsController.surfaceMaterial.SetVector(EVEManagerClass.PLANET_ORIGIN_PROPERTY, planetOrigin);
            }
        }

    }
}
