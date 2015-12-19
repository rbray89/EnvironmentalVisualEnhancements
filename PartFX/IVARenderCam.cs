using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace PartFX
{
    [KSPAddon(KSPAddon.Startup.Flight, false)]
    class IVARenderCam : MonoBehaviour
    {
        //We do this so that the camera movements are performed AFTER the flight camera has been moved. 
        //For whatever reason, LateUpdate was not sufficient here.
        private class CameraMover : MonoBehaviour
        {

            new Camera camera;
            void Start()
            {
                camera = GetComponent<Camera>();
            }
            public void OnPreCull()
            {
                if (HighLogic.LoadedSceneIsFlight)
                {
                    Transform camTran = camera.transform;
                    camTran.position = InternalSpace.WorldToInternal(FlightCamera.fetch.transform.position);
                    camTran.rotation = InternalSpace.WorldToInternal(FlightCamera.fetch.transform.rotation);
                }
                else
                {
                    camera.enabled = false;
                }
            }
        }

        private static RenderTexture rt = null;
        public static RenderTexture RT
        {
            get
            {
                float scale = .70f;
                if (rt == null)
                {
                    rt = new RenderTexture((int)(scale * Screen.width), (int)(scale * Screen.height), 16, RenderTextureFormat.ARGB32);
                }
                return rt;
            }
        }

        private static Camera ivaCam = null;
        private static Camera IVACam
        {
            get
            {
                if (ivaCam == null)
                {
                    GameObject go = new GameObject("IVA -ext- Cam");
                    ivaCam = go.AddComponent<Camera>();
                    ivaCam.CopyFrom(InternalCamera.Instance.camera);
                    ivaCam.targetTexture = RT;
                    ivaCam.depth = 0;
                    ivaCam.clearFlags = CameraClearFlags.SolidColor;
                    ivaCam.depthTextureMode = DepthTextureMode.None;
                    ivaCam.backgroundColor = Color.clear;
                    go.AddComponent<CameraMover>();
                }
                return ivaCam;
            }
        }


        public void Start()
        {
            IVACam.targetTexture = RT;
        }

        public void Update()
        {
            if (CameraManager.Instance.currentCameraMode != CameraManager.CameraMode.Map)
            {
                IVACam.enabled = true;
            }
            else
            {
                IVACam.enabled = false;
            }

        }
        public void OnDestroy()
        {
            IVACam.enabled = false;
        }

    }
}
