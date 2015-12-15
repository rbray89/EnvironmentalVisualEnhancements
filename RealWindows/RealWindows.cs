using ShaderLoader;
using System.Collections.Generic;
using UnityEngine;
using System;

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
    public class RealWindowsManager : MonoBehaviour
    {
        private static RenderTexture rt = null;
        public static RenderTexture RT
        {
            get
            {
                if (rt == null)
                {
                    rt = new RenderTexture(Screen.width, Screen.height, 16, RenderTextureFormat.ARGB32);
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
            ModuleRealWindows[] ivas = GameObject.FindObjectsOfType<ModuleRealWindows>();
            foreach (ModuleRealWindows iva in ivas)
            {
                iva.SetMaterial();
            }
        }

        public void Update()
        {
            if (CameraManager.Instance.currentCameraMode != CameraManager.CameraMode.IVA &&
                CameraManager.Instance.currentCameraMode != CameraManager.CameraMode.Map)
            {
                IVACam.enabled = true;
                ModuleRealWindows[] ivas = GameObject.FindObjectsOfType<ModuleRealWindows>();
                foreach (ModuleRealWindows iva in ivas)
                {
                    iva.UpdatePos();
                }
            }
            else if (CameraManager.Instance.currentCameraMode == CameraManager.CameraMode.IVA)
            {
                IVACam.enabled = false;
                ModuleRealWindows[] ivas = GameObject.FindObjectsOfType<ModuleRealWindows>();
                foreach (ModuleRealWindows iva in ivas)
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
    public class RealWindowsLoader : MonoBehaviour
    {
        private static Shader windowShader = null;
        public static Shader WindowShader
        {
            get
            {
                if (windowShader == null)
                {
                    windowShader = ShaderLoaderClass.FindShader("EVE/RealWindows");
                }
                return windowShader;
            }
        }
        
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
                        KSPLog.print("Adding ModuleRealWindows...");
                        ConfigNode node = ap.partConfig.AddNode("MODULE");
                        node.AddValue("name", "ModuleRealWindows");
                        part.AddModule("ModuleRealWindows");
                    }
                }

            }
        }
    }

    public class ModuleRealWindows : PartModule
    {
        Dictionary<string, int> partList = new Dictionary<string, int>()
        {
            { "Cockpit_inline", 0 },
            { "cockpit",0 },
            { "COCKPIT", 0 },
            { "cabin", 0 },
            { "obj_base", 0 },
            { "hatch", 0 },
           // { "capsule", 0 },
            { "window", 0 },
            { "Cockpit", 0 },
            { "FrontWindow", 0 },
            { "OuterShell", 0 },
            { "SideWindow", 0 }
        };
        public void SetMaterial()
        {
            KSPLog.print("--SetMaterial--");
            KSPLog.print(part.name);
            foreach (MeshRenderer mr in part.FindModelComponents<MeshRenderer>())
            {
                AddMaterial(mr);
            }
        }

        private void AddMaterial(MeshRenderer mr)
        {
            KSPLog.print("material: " + mr.name);
            KSPLog.print(mr.materials.Length);
            if (partList.ContainsKey(mr.name) && mr.materials.Length == 1)
            {
                KSPLog.print("Adding to: " + mr.name);
                List<Material> materials = new List<Material>(mr.materials);
                Material windowMat = new Material(RealWindowsLoader.WindowShader);
                windowMat.mainTexture = mr.material.mainTexture;
                windowMat.SetTexture("_IVATex", RealWindowsManager.RT);
                materials.Add(windowMat);
                mr.materials = materials.ToArray();
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
                foreach (MeshRenderer mr in part.FindModelComponents<MeshRenderer>())
                {
                    AddMaterial(mr);
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
