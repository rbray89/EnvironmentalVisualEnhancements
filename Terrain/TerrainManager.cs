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
    public class OceanReplacementShader : MonoBehaviour
    {
        private GameObject shaderReplacementCamera;

        void OnPostRender()
        {
            if(shaderReplacementCamera == null)
            {
                shaderReplacementCamera = new GameObject("shaderReplacementCamera");
                shaderReplacementCamera.AddComponent<Camera>();
                shaderReplacementCamera.camera.enabled = false; 
            }
            Camera cam = shaderReplacementCamera.camera;
            cam.CopyFrom(camera);
            cam.backgroundColor = new Color(0, 0, 0, 0);
            cam.clearFlags = CameraClearFlags.Nothing;

            cam.RenderWithShader(TerrainManager.OceanShaderNear, "OceanReplace");
        }
    }
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class TerrainManager : GenericEVEManager<TerrainObject>
    {
        protected override ObjectType objectType { get { return ObjectType.PLANET; } }
        protected override String configName { get { return "EVE_TERRAIN"; } }

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
                    oceanShaderNear = EVEManagerClass.GetShader(assembly, "Terrain.Shaders.Compiled-SphereOceanNear.shader");
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
                    oceanShader = EVEManagerClass.GetShader(assembly, "Terrain.Shaders.Compiled-SphereOcean.shader");
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
                    planetShader = EVEManagerClass.GetShader(assembly, "Terrain.Shaders.Compiled-SpherePlanet.shader");
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
                    terrainShader = EVEManagerClass.GetShader(assembly, "Terrain.Shaders.Compiled-SphereTerrain.shader");
                } return terrainShader;
            }
        }

        protected override void SingleSetup()
        {
            Log("SingleSetup ");
            Camera[] cameras = Camera.allCameras;
            foreach (Camera cam in cameras)
            {
                Log("updating " + cam.name+" far "+cam.farClipPlane);
                if (cam.name == "Camera 01" || cam.name == "Camera 00")
                {
                    cam.depthTextureMode = DepthTextureMode.Depth;
                }
            }
        }

    }
}
