using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using KSP;
using UnityEngine;

namespace VisibleIVA
{
    //We do this so that the camera movements are performed AFTER the flight camera has been moved. 
    //For whatever reason, LateUpdate was not sufficient here.
    public class CameraMover : MonoBehaviour
    {

        new Camera camera;
        void Start()
        {
            camera = GetComponent<Camera>();
        }
        public void OnPreCull()
        {
            Transform camTran = camera.transform;
            camTran.position = InternalSpace.WorldToInternal(FlightCamera.fetch.transform.position);
            camTran.rotation = InternalSpace.WorldToInternal(FlightCamera.fetch.transform.rotation);
        }
    }

    [KSPAddon(KSPAddon.Startup.Flight, false)]
    public class VisibleIVAManager : MonoBehaviour
    {
        static Camera IVACam = null;
        public void Awake()
        {
            if (IVACam == null)
            {
                GameObject go = new GameObject("IVA -ext- Cam");
                IVACam = go.AddComponent<Camera>();
                IVACam.CopyFrom(InternalCamera.Instance.camera);
                IVACam.targetTexture = null;
                go.AddComponent<CameraMover>();
            }
        }

        public void Start()
        {
            VisibleIVA[] ivas = GameObject.FindObjectsOfType<VisibleIVA>();
            foreach (VisibleIVA iva in ivas)
            {
                iva.SetMaterial();
            }
        }

        public void LateUpdate()
        {
            if (CameraManager.Instance.currentCameraMode != CameraManager.CameraMode.IVA &&
                CameraManager.Instance.currentCameraMode != CameraManager.CameraMode.Map)
            {
                IVACam.enabled = true;
                VisibleIVA[] ivas = GameObject.FindObjectsOfType<VisibleIVA>();
                foreach (VisibleIVA iva in ivas)
                {
                    iva.UpdatePos();
                }
            }
            else if (CameraManager.Instance.currentCameraMode == CameraManager.CameraMode.IVA)
            {
                IVACam.enabled = false;
                VisibleIVA[] ivas = GameObject.FindObjectsOfType<VisibleIVA>();
                foreach (VisibleIVA iva in ivas)
                {
                    iva.UpdatePos();
                }
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

    [KSPAddon(KSPAddon.Startup.MainMenu, true)]
    public class VisibleIVALoader : MonoBehaviour
    {
        public void Start()
        {
            foreach (AvailablePart ap in PartLoader.Instance.parts)
            {
                
                Part part = ap.partPrefab;
                
                if ( ap.internalConfig != null && part.Modules.Count > 0)
                {
                    string name = ap.internalConfig.GetValue("name");
                    if (name != null && name != "")
                    {
                        KSPLog.print("part: " + ap.name);
                        KSPLog.print("Adding VisibleIVA Module...");
                        part.AddModule("VisibleIVA");
                    }
                }

            }
        }
    }

    public class VisibleIVA : PartModule
    {
        public void SetMaterial()
        {

            KSPLog.print("--SetMaterial--");
            KSPLog.print(part.name);
            foreach (Renderer mr in part.FindModelComponents<Renderer>())
            {
                KSPLog.print("material: " +mr.name+" "+mr.GetType());
            }
        }

        public override void OnInactive()
        {
            if (part.internalModel != null)
            {
                part.internalModel.enabled = false;
                part.internalModel.SetVisible(false);
            }
        }

        internal void UpdatePos()
        {
            if (part.internalModel == null)
            {
                part.CreateInternalModel();

                KSPLog.print("--update pos--");
                KSPLog.print(part.name);
                foreach (Renderer mr in part.FindModelComponents<Renderer>())
                {
                    KSPLog.print("material: " + mr.name + " " + mr.GetType());
                }
            }
            if (part.internalModel != null)
            {
                part.internalModel.enabled = true;
                part.internalModel.SetVisible(true);
                part.internalModel.transform.position = InternalSpace.WorldToInternal(part.transform.position);
                part.internalModel.transform.rotation = InternalSpace.WorldToInternal(part.transform.rotation);
                part.internalModel.transform.Rotate(90, 0, 180);
            }
        }
    }
}
