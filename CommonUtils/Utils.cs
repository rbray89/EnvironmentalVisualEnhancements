using Equirectangular2Cubic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace CommonUtils
{
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class Utils : MonoBehaviour
    {
        public static int IGNORE_LAYER = 4;//28;
        public static int OVER_LAYER = 3;//28;
        public static int UNDER_LAYER = 2;//31;
        public static int MAP_LAYER = 10;//31;
        
        static Dictionary<String, float> MAP_SWITCH_DISTANCE = new Dictionary<string,float>();
        static List<CelestialBody> CelestialBodyList = new List<CelestialBody>();
        static ConfigNode config;
        static Camera overlayCamera;
        static Camera underlayCamera;
        static bool setup = false;
        static bool setupCallbacks = false;
        static String CurrentBodyName;
        static bool bodyOverlayEnabled = false;
        static bool mainMenuOverlay = false;
        static bool isCubicMapped = false;
        public static bool MainMenuOverlay
        {
            get{return mainMenuOverlay;}
        }
        public static bool IsCubicMapped
        {
            get { return isCubicMapped; }
        }

        protected void Awake()
        {

            if (HighLogic.LoadedScene == GameScenes.MAINMENU)
            {
                Init();
            }
            else if (HighLogic.LoadedScene == GameScenes.FLIGHT && !setupCallbacks)
            {
                Log("Initializing Callbacks...");
                GameEvents.onDominantBodyChange.Add(OnDominantBodyChangeCallback);
                GameEvents.onFlightReady.Add(OnFlightReadyCallback);
                MapView.OnEnterMapView += new Callback(EnterMapView);
                MapView.OnExitMapView += new Callback(ExitMapView);
                Log("Initialized Callbacks");
                setupCallbacks = true;
            }

        }

        public static void Init()
        {
            if (!setup)
            {
                UnityEngine.Object[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody));
                config = ConfigNode.Load(KSPUtil.ApplicationRootPath + "GameData/BoulderCo/common.cfg");
                ConfigNode cameraSwapConfig = config.GetNode("CAMERA_SWAP_DISTANCES");
                String cubicSetting = config.GetValue("CUBIC_MAPPING");
                if(cubicSetting == "1" || cubicSetting == "true")
                {
                    isCubicMapped = true;
                }
                foreach (CelestialBody cb in celestialBodies)
                {
                    CelestialBodyList.Add(cb);
                    string name = cb.bodyName;
                    string val = cameraSwapConfig.GetValue(name);
                    float dist = 0;
                    if (val != null && val != "")
                    {
                        dist = float.Parse(val);
                    }
                    Log("loading " + name + " distance " + dist);
                    MAP_SWITCH_DISTANCE.Add(name, dist);
                }

                ConfigNode cameraLayers = config.GetNode("CAMERA_LAYERS");
                if (cameraLayers != null)
                {
                    string value = cameraLayers.GetValue("IGNORE_LAYER");
                    if (value != null && value != "")
                    {
                        IGNORE_LAYER = int.Parse(value);
                    }
                    value = cameraLayers.GetValue("OVER_LAYER");
                    if (value != null && value != "")
                    {
                        OVER_LAYER = int.Parse(value);
                    }
                    value = cameraLayers.GetValue("UNDER_LAYER");
                    if (value != null && value != "")
                    {
                        UNDER_LAYER = int.Parse(value);
                    }
                    value = cameraLayers.GetValue("MAP_LAYER");
                    if (value != null && value != "")
                    {
                        MAP_LAYER = int.Parse(value);
                    }
                }
                Log("Camera Layers Parsed.");

                Camera referenceCam = ScaledCamera.Instance.camera;


                GameObject Ogo = new GameObject();
                overlayCamera = Ogo.AddComponent<Camera>();
                overlayCamera.transform.parent = referenceCam.transform;
                overlayCamera.transform.localPosition = new Vector3(0, 0, 0);
                overlayCamera.transform.localRotation = Quaternion.FromToRotation(new Vector3(0, 0, 0), new Vector3(0, 0, 1));
                overlayCamera.depth = referenceCam.depth + 2.5f;
                overlayCamera.fieldOfView = referenceCam.fieldOfView;
                overlayCamera.farClipPlane = referenceCam.farClipPlane;
                overlayCamera.cullingMask = (1 << OVER_LAYER); //-10,-9,-18,-23,-29
                overlayCamera.eventMask = 0;
                overlayCamera.nearClipPlane = .015f;
                overlayCamera.layerCullDistances = new float[32];
                overlayCamera.layerCullSpherical = true;
                overlayCamera.clearFlags = CameraClearFlags.Depth;
                overlayCamera.name = "Camera VE Overlay";
                Log("Initialized Overlay Camera.");

                //for underside of clouds, etc.
                GameObject Ugo = new GameObject();
                underlayCamera = Ugo.AddComponent<Camera>();
                underlayCamera.transform.parent = referenceCam.transform;
                underlayCamera.transform.localPosition = new Vector3(0, 0, 0);
                underlayCamera.transform.localRotation = Quaternion.FromToRotation(new Vector3(0, 0, 0), new Vector3(0, 0, 1));
                underlayCamera.depth = referenceCam.depth + .1f;
                underlayCamera.fieldOfView = referenceCam.fieldOfView;
                underlayCamera.farClipPlane = referenceCam.farClipPlane;
                underlayCamera.cullingMask = (1 << UNDER_LAYER); //-10,-9,-18,-23,-29
                underlayCamera.eventMask = 0;
                underlayCamera.nearClipPlane = .015f;
                underlayCamera.layerCullDistances = new float[32];
                underlayCamera.layerCullSpherical = true;
                underlayCamera.clearFlags = CameraClearFlags.Depth;
                underlayCamera.name = "Camera VE Underlay";
                Log("Initialized Underlay Camera.");

                Sun.Instance.light.cullingMask |= (1 << OVER_LAYER) | (1 << UNDER_LAYER);
                Log("Initialized Light mask.");

                setup = true;
            }
        }

        protected void Start()
        {
            
            if (HighLogic.LoadedScene == GameScenes.MAINMENU)
            {
                EnableMainOverlay();
            }
            else
            {
                 DisableMainOverlay();
            }
            
            if (setup && HighLogic.LoadedScene != GameScenes.FLIGHT && HighLogic.LoadedScene != GameScenes.SPACECENTER)
            {
                disableCamera();
            }
            else if (setup && HighLogic.LoadedScene == GameScenes.SPACECENTER)
            {
               
                disablePlanetOverlay(CurrentBodyName);
                CurrentBodyName = "Kerbin";
                enablePlanetOverlay(CurrentBodyName);
                enableCamera();
            }
            else if (setup)
            {
                enableCamera();
            }
        }

        private void DisableMainOverlay()
        {
            //nothing to do here...
            mainMenuOverlay = false;
        }

        private void EnableMainOverlay()
        {
            if (!mainMenuOverlay)
            {
                var objects = GameObject.FindSceneObjectsOfType(typeof(GameObject));
                if (objects.Any(o => o.name == "LoadingBuffer")) { return; }
                var kerbin = objects.OfType<GameObject>().Where(b => b.name == "Kerbin").LastOrDefault();
                if (kerbin != null)
                {
                    List<Overlay> overlayList = Overlay.OverlayDatabase["Kerbin"];
                    if (overlayList != null)
                    {
                        foreach (Overlay kerbinOverlay in overlayList)
                        {
                            kerbinOverlay.CloneForMainMenu();
                        }
                    }
                }
                mainMenuOverlay = true;
            }
        }

        private void EnterMapView()
        {
            disableCamera();
        }

        private void ExitMapView()
        {
            enableCamera();
        }

        private void OnDominantBodyChangeCallback(GameEvents.FromToAction<CelestialBody, CelestialBody> data)
        {
            disablePlanetOverlay(CurrentBodyName);
            CurrentBodyName = data.to.bodyName;
            enablePlanetOverlay(CurrentBodyName);
        }

        private void OnFlightReadyCallback()
        {
            disablePlanetOverlay(CurrentBodyName);
            CurrentBodyName = FlightGlobals.currentMainBody.bodyName;
            enablePlanetOverlay(CurrentBodyName);
        }


        public void Update()
        {

            if (HighLogic.LoadedScene != GameScenes.FLIGHT || !setup || !FlightGlobals.ready)
            {
                return;
            }
            if (!MapView.MapIsEnabled || MapView.MapCamera == null)
            {
                
                overlayCamera.fov = ScaledCamera.Instance.camera.fov;
                float distanceFromCamera = Vector3.Distance(
                    overlayCamera.transform.position,
                    ScaledSpace.Instance.scaledSpaceTransforms.Single(t => t.name == CurrentBodyName).position);

                if (distanceFromCamera >= MAP_SWITCH_DISTANCE[CurrentBodyName] && bodyOverlayEnabled)
                {
                    disablePlanetOverlay(CurrentBodyName);
                }
                else if (distanceFromCamera < MAP_SWITCH_DISTANCE[CurrentBodyName])
                {
                    //update FOV in case of IVA
                    overlayCamera.fov = ScaledCamera.Instance.camera.fov;
                    underlayCamera.fov = ScaledCamera.Instance.camera.fov;
                    if (!bodyOverlayEnabled)
                    {
                        enablePlanetOverlay(CurrentBodyName);
                    }
                }
            }
            


        }

        private static void disablePlanetOverlay(String body)
        {
            if (body != null && Overlay.OverlayDatabase.ContainsKey(body))
            {
                List<Overlay> overlayList = Overlay.OverlayDatabase[body];
                foreach (Overlay overlay in overlayList)
                {
                    overlay.PushToMapLayer();
                }
                bodyOverlayEnabled = false;
            }
        }

        private static void enablePlanetOverlay(String body)
        {
            if (body != null && Overlay.OverlayDatabase.ContainsKey(body))
            {
                List<Overlay> overlayList = Overlay.OverlayDatabase[body];
                foreach (Overlay overlay in overlayList)
                {
                    overlay.PopLayer();
                }
                bodyOverlayEnabled = true;
            }
        }

        private static void enableCamera()
        {
            ScaledCamera.Instance.camera.cullingMask &= ~((1 << OVER_LAYER) | (1 << UNDER_LAYER));
            overlayCamera.cullingMask = (1 << OVER_LAYER);
            underlayCamera.cullingMask = (1 << UNDER_LAYER);
            foreach (Overlay overlay in Overlay.ZFightList)
            {
                overlay.FixZFighting(false);
            }
        }

        private static void disableCamera()
        {
            ScaledCamera.Instance.camera.cullingMask |= (1 << OVER_LAYER);
            overlayCamera.cullingMask = 0;
            underlayCamera.cullingMask = 0;
            foreach (Overlay overlay in Overlay.ZFightList)
            {
                overlay.FixZFighting(true);
            }
        }
        
        public static void Log(String message)
        {
            UnityEngine.Debug.Log("Utils: " + message);
        }

        public static CelestialBody GetMapBody()
        {
            MapObject target = MapView.MapCamera.target;
            switch (target.type)
            {
                case MapObject.MapObjectType.CELESTIALBODY:
                    return target.celestialBody;
                case MapObject.MapObjectType.MANEUVERNODE:
                    return target.maneuverNode.patch.referenceBody;
                case MapObject.MapObjectType.VESSEL:
                    return target.vessel.mainBody;
            }
            
            return null;
        }

        public static CelestialBody GetNextBody(CelestialBody body)
        {
            int index = CelestialBodyList.FindIndex(a => a.name == body.name);
            if (index == CelestialBodyList.Count - 1)
            {
                index = -1;
            }
            return CelestialBodyList[index + 1];
        }

        public static CelestialBody GetPreviousBody(CelestialBody body)
        {
            int index = CelestialBodyList.FindIndex(a => a.name == body.name);
            if (index == 0)
            {
                index = CelestialBodyList.Count;
            }
            return CelestialBodyList[index - 1];
        }
    }

    public class Overlay
    {
        public static Dictionary<String, List<Overlay>> OverlayDatabase = new Dictionary<string, List<Overlay>>();
        public static List<Overlay> ZFightList = new List<Overlay>();

        private string Body;
        GameObject OverlayGameObject;
        private float radius;
        private Material overlayMaterial;
        private int OriginalLayer;
        private bool AvoidZFighting;
        private Vector2 Rotation;
        private Transform celestialTransform;


        public Overlay(string planet, float radius, Material overlayMaterial,  Vector2 rotation, int layer, bool avoidZFighting, Transform celestialTransform)
        {

            this.OverlayGameObject = new GameObject();
            this.Body = planet;
            this.radius = radius;
            this.Rotation = rotation;
            this.overlayMaterial = overlayMaterial;
            this.OriginalLayer = layer;
            this.AvoidZFighting = avoidZFighting;
            this.celestialTransform = celestialTransform;
        }

        public void PushToMapLayer()
        {
            if (OriginalLayer != Utils.UNDER_LAYER)
            {
                OverlayGameObject.layer = Utils.MAP_LAYER;
            }
            else
            {
                OverlayGameObject.layer = Utils.IGNORE_LAYER;
            }
            FixZFighting(true);
        }

        public void PopLayer()
        {
            OverlayGameObject.layer = OriginalLayer;
            FixZFighting(false);
        }

        public void FixZFighting(bool enable)
        {
            if (AvoidZFighting)
            {
                if (enable)
                {
                    OverlayGameObject.transform.localScale = this.radius*Vector3.one * 1002f;
                }
                else
                {
                    OverlayGameObject.transform.localScale = this.radius * Vector3.one * 1000f;
                }
            }
        }

        public void EnableMainMenu(bool p)
        {
            if (p)
            {
                var objects = GameObject.FindSceneObjectsOfType(typeof(GameObject));
                if (objects.Any(o => o.name == "LoadingBuffer")) { return; }
                var body = objects.OfType<GameObject>().Where(b => b.name == this.Body).LastOrDefault();
                if (body != null)
                {
                    OverlayGameObject.layer = body.layer;
                    OverlayGameObject.transform.parent = body.transform;
                    OverlayGameObject.transform.localScale = this.radius * Vector3.one * 1008f;
                    OverlayGameObject.transform.localPosition = Vector3.zero;
                    OverlayGameObject.transform.localRotation = Quaternion.identity;
                }
            }
            else
            {
                OverlayGameObject.layer = Utils.MAP_LAYER;
                OverlayGameObject.transform.parent = celestialTransform;
                OverlayGameObject.transform.localScale = this.radius * Vector3.one * 1000f;
                OverlayGameObject.transform.localPosition = Vector3.zero;
                OverlayGameObject.transform.localRotation = Quaternion.identity;
            }
            this.UpdateRotation(Rotation);
            FixZFighting(p);
        }

        public void CloneForMainMenu()
        {
            GeneratePlanetOverlay(this.Body, this.radius, this.overlayMaterial, this.Rotation, this.OriginalLayer, false, true);
        }

        public void RemoveOverlay()
        {
            OverlayDatabase[this.Body].Remove(this);
            if (this.AvoidZFighting)
            {
                ZFightList.Remove(this);
            }
            GameObject.Destroy(this.OverlayGameObject);
        }

        public static Overlay GeneratePlanetOverlay(String planet, float radius, Material overlayMaterial, Vector2 rotation, int layer, bool avoidZFighting = false, bool mainMenu = false)
        {
            Vector2 Rotation = new Vector2(rotation.x, rotation.y);
            if (Utils.IsCubicMapped)
            {
                Rotation.y += .50f;
            }
            else
            {
                Rotation.x += .25f;
            }
            Transform celestialTransform = ScaledSpace.Instance.scaledSpaceTransforms.Single(t => t.name == planet);
            Overlay overlay = new Overlay(planet, radius, overlayMaterial, Rotation, layer, avoidZFighting, celestialTransform);
            if (!mainMenu)
            {
                if (!OverlayDatabase.ContainsKey(planet))
                {
                    OverlayDatabase.Add(planet, new List<Overlay>());
                }
                OverlayDatabase[planet].Add(overlay);

                if (avoidZFighting)
                {
                    ZFightList.Add(overlay);
                }
            }
            
            var mr = overlay.OverlayGameObject.AddComponent<MeshRenderer>();

            IsoSphere.Create(overlay.OverlayGameObject);

            mr.renderer.sharedMaterial = overlayMaterial;

            mr.castShadows = false;
            mr.receiveShadows = false;
            mr.enabled = true;

            overlay.OverlayGameObject.renderer.enabled = true;

            overlay.EnableMainMenu(mainMenu);
            return overlay;
        }


        public void UpdateRadius(float radius)
        {
            this.radius = radius;
            if (AvoidZFighting)
            {
                if (MapView.MapIsEnabled)
                {
                    OverlayGameObject.transform.localScale = this.radius * Vector3.one * 1008f;
                }
                else
                {
                    OverlayGameObject.transform.localScale = this.radius * Vector3.one * 1000f;
                }
            }
            else
            {
                OverlayGameObject.transform.localScale = this.radius * Vector3.one * 1000f;
            }
        }

        public void UpdateRotation(Vector3 rotation)
        {
            float tmp = rotation.x;
            rotation.x = rotation.y;
            rotation.y = tmp;
            OverlayGameObject.transform.Rotate(360f*rotation);
        }
    }


}
