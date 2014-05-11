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
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class TerrainManager : GenericEVEManager<TerrainObject>
    {
        protected override ObjectType objectType { get { return ObjectType.PLANET; } }
        protected override String configName { get { return "EVE_TERRAIN"; } }

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
