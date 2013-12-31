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
        public static int MAP_LAYER = 10;//31;
        
        static Dictionary<String, float> MAP_SWITCH_DISTANCE = new Dictionary<string,float>();
        static List<CelestialBody> CelestialBodyList = new List<CelestialBody>();
        static ConfigNode config;
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
                    String value = cameraLayers.GetValue("MAP_LAYER");
                    if (value != null && value != "")
                    {
                        MAP_LAYER = int.Parse(value);
                    }
                }
                Log("Camera Layers Parsed.");


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
            if (setup && HighLogic.LoadedScene == GameScenes.SPACECENTER)
            {
                CurrentBodyName = "Kerbin";
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



        public void Update()
        {

            if (HighLogic.LoadedScene != GameScenes.FLIGHT || !setup || !FlightGlobals.ready)
            {
                return;
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

        public GameObject OverlayGameObject;
        private string Body;
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
        }

        public void CloneForMainMenu()
        {
            GeneratePlanetOverlay(this.Body, this.radius, this.overlayMaterial, this.Rotation, false, true);
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

        public static Overlay GeneratePlanetOverlay(String planet, float radius, Material overlayMaterial, Vector2 rotation, bool avoidZFighting = false, bool mainMenu = false)
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
            Overlay overlay = new Overlay(planet, radius, overlayMaterial, Rotation, Utils.MAP_LAYER, avoidZFighting, celestialTransform);
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
