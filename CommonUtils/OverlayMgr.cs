using Equirectangular2Cubic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace OverlaySystem
{
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class OverlayMgr : MonoBehaviour
    {
        public static int MAP_LAYER = 10;//31;
        
        static Dictionary<String, float> MAP_SWITCH_DISTANCE = new Dictionary<string,float>();
        static List<CelestialBody> CelestialBodyList = new List<CelestialBody>();
        static ConfigNode config;
        static bool setup = false;
        static bool mainMenuOverlay = false;
        static bool isCubicMapped = false;
        static bool setupCallbacks = false;
        static String CurrentBodyName = "Kerbin";
        static PQS CurrentPQS = null;
        static bool PQSEnabled = true;
        static Transform ScaledBodyTransform;
        static float OverlaySwapDist = 0;
        static float OverlaySwapRatio = 0;

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
            else if (HighLogic.LoadedScene == GameScenes.TRACKSTATION)
            {
                foreach(Overlay overlay in Overlay.OverlayList)
                {
                    overlay.SwitchToOverlay();
                    DisablePQS();
                }
                PQSEnabled = false;
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
                    if(cb.name == "Kerbin")
                    {
                        CurrentPQS = cb.pqsController;
                    }
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
        }

        private void OnDominantBodyChangeCallback(GameEvents.FromToAction<CelestialBody, CelestialBody> data)
        {
            UpdateCurrentBody(data.to.bodyName);
        }

        private void OnFlightReadyCallback()
        {
            UpdateCurrentBody(FlightGlobals.currentMainBody.bodyName);
        }

        private void UpdateCurrentBody(string body)
        {
            if (Overlay.OverlayDatabase.ContainsKey(CurrentBodyName))
            {
                foreach (Overlay overlay in Overlay.OverlayDatabase[CurrentBodyName])
                {
                    overlay.SwitchToOverlay();
                }
            }
            PQSEnabled = false;
            CurrentBodyName = body;

            CelestialBody celestialBody = CelestialBodyList.First(n => n.bodyName == CurrentBodyName);
            CurrentPQS = celestialBody.pqsController;
            ScaledBodyTransform = ScaledSpace.Instance.scaledSpaceTransforms.Single(t => t.name == CurrentBodyName);
            float bodyRadius = ScaledBodyTransform.localScale.x * 1000f;
            OverlaySwapDist = (5f/4f)*bodyRadius;
            OverlaySwapRatio = 8f / bodyRadius;
        }

        private void EnterMapView()
        {
            DisablePQS();
        }

        private void ExitMapView()
        {

        }

        private void DisablePQS()
        {
            foreach(Overlay overlay in Overlay.OverlayList)
            {
                overlay.SwitchToOverlay();
            }
            PQSEnabled = false;
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
            if (HighLogic.LoadedScene == GameScenes.SPACECENTER || HighLogic.LoadedScene == GameScenes.FLIGHT)
            {
                //float dist = Vector3.Distance(
                //    ScaledBodyTransform.position,
                //    ScaledCamera.Instance.transform.position);
                //float alpha = Mathf.Clamp(OverlaySwapRatio * (dist-OverlaySwapDist), 0, 1);
                bool inNeedOfUpdate = CurrentPQS.isActive != PQSEnabled;
                if (inNeedOfUpdate && CurrentPQS.isActive && !MapView.MapIsEnabled)
                {
                    foreach (Overlay overlay in Overlay.OverlayDatabase[CurrentBodyName])
                    {
                        //overlay.SwitchToPQS(alpha);
                        overlay.SwitchToPQS();
                    }
                    PQSEnabled = true;
                }
                else if (inNeedOfUpdate)
                {
                    foreach (Overlay overlay in Overlay.OverlayDatabase[CurrentBodyName])
                    {
                        overlay.SwitchToOverlay();
                    }
                    PQSEnabled = false;
                }
                
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
        public static List<Overlay> OverlayList = new List<Overlay>();

        private GameObject OverlayGameObject;
        private GameObject PQSOverlayGameObject;
        private string Body;
        private float altitude;
        private Material overlayMaterial;
        private Material PQSMaterial;
        private int OriginalLayer;
        private bool MainMenu;
        private Vector2 Rotation;
        private Transform celestialTransform;
        private Overlay MainMenuClone;
        private CelestialBody celestialBody;

        public Overlay(string planet, float altitude, Material overlayMaterial, Material PQSMaterial, Vector2 rotation, int layer, Transform celestialTransform, bool mainMenu, bool matchTerrain)
        {
            this.MainMenu = mainMenu;
            this.OverlayGameObject = new GameObject();
            this.Body = planet;
            this.Rotation = rotation;
            this.overlayMaterial = overlayMaterial;
            this.PQSMaterial = PQSMaterial;
            this.OriginalLayer = layer;
            this.celestialTransform = celestialTransform;

            var mr = OverlayGameObject.AddComponent<MeshRenderer>();
            IsoSphere.Create(OverlayGameObject, null);
            mr.renderer.sharedMaterial = overlayMaterial;
            mr.castShadows = false;
            mr.receiveShadows = false;
            //mr.enabled = mainMenu;
            mr.enabled = true;
            OverlayGameObject.renderer.enabled = true;


            if (!mainMenu)
            {
                CelestialBody[] celestialBodies = (CelestialBody[])CelestialBody.FindObjectsOfType(typeof(CelestialBody));
                celestialBody = celestialBodies.First(n => n.bodyName == this.Body);

                this.PQSOverlayGameObject = new GameObject();
                mr = PQSOverlayGameObject.AddComponent<MeshRenderer>();
                if (matchTerrain)
                {
                    IsoSphere.Create(PQSOverlayGameObject, celestialBody);
                }
                else
                {
                    IsoSphere.Create(PQSOverlayGameObject, null);
                }
                mr.renderer.sharedMaterial = PQSMaterial;
                mr.castShadows = false;
                mr.receiveShadows = false;
                mr.enabled = true;
                PQSOverlayGameObject.renderer.enabled = true;
                PQSOverlayGameObject.layer = 15;

                placePQS();
                
            }
            this.UpdateAltitude(altitude, mainMenu);
        }

        private void placePQS()
        {

            GameObject overlayHolder = new GameObject();
            overlayHolder.name = "blockHolder";

            PQSOverlayGameObject.transform.parent = overlayHolder.transform;

            foreach (Transform aTransform in celestialBody.transform)
            {
                if (aTransform.name == celestialBody.transform.name)
                {
                    overlayHolder.transform.parent = aTransform;
                    break;
                }
            }
            PQSCity blockScript = overlayHolder.AddComponent<PQSCity>();

            blockScript.debugOrientated = false;
            blockScript.frameDelta = 1;
            blockScript.lod = new PQSCity.LODRange[1];
            blockScript.lod[0] = new PQSCity.LODRange();
            blockScript.lod[0].visibleRange = 4f * (float)celestialBody.Radius;
            blockScript.lod[0].renderers = new GameObject[1];
            blockScript.lod[0].renderers[0] = PQSOverlayGameObject;
            blockScript.lod[0].objects = new GameObject[0];
            blockScript.modEnabled = true;
            blockScript.order = 100;
            //blockScript.reorientFinalAngle = -105;
            blockScript.reorientInitialUp = Vector3.up;
            blockScript.reorientToSphere = true;
            blockScript.repositionRadial = Vector3.zero;
            blockScript.repositionRadiusOffset = 0;// altitude;
            blockScript.repositionToSphere = true;
            blockScript.requirements = PQS.ModiferRequirements.Default;
            blockScript.sphere = celestialBody.pqsController;
            blockScript.RebuildSphere();

        }

        public void EnableMainMenu(bool mainMenu)
        {
            if (mainMenu)
            {
                var objects = GameObject.FindSceneObjectsOfType(typeof(GameObject));
                if (objects.Any(o => o.name == "LoadingBuffer")) { return; }
                var body = objects.OfType<GameObject>().Where(b => b.name == this.Body).LastOrDefault();
                if (body != null)
                {
                    OverlayGameObject.layer = body.layer;
                    OverlayGameObject.transform.parent = body.transform;
                    OverlayGameObject.transform.localPosition = Vector3.zero;
                    OverlayGameObject.transform.localRotation = Quaternion.identity;
                }
            }
            else
            {
                OverlayGameObject.layer = OverlayMgr.MAP_LAYER;
                OverlayGameObject.transform.parent = celestialTransform;
                OverlayGameObject.transform.localPosition = Vector3.zero;
                OverlayGameObject.transform.localRotation = Quaternion.identity;

            }
            this.UpdateRotation(Rotation);
            this.UpdateAltitude(altitude, mainMenu);
        }

        public void CloneForMainMenu()
        {
            if (MainMenuClone == null)
            {
                MainMenuClone = GeneratePlanetOverlay(this.Body, (float)(1f + (this.altitude / celestialBody.Radius)), this.overlayMaterial, this.PQSMaterial, this.Rotation, true);
            }
        }

        public void RemoveOverlay()
        {
            OverlayDatabase[this.Body].Remove(this);
            OverlayList.Remove(this);
            GameObject.Destroy(this.OverlayGameObject);

        }

        public static Overlay GeneratePlanetOverlay(String planet, float altitude, Material overlayMaterial, Material PQSMaterial, Vector2 rotation, bool mainMenu = false, bool matchTerrain = false)
        {
            Vector2 Rotation = new Vector2(rotation.x, rotation.y);
            if (OverlayMgr.IsCubicMapped)
            {
                Rotation.y += .50f;
            }
            else
            {
                Rotation.x += .25f;
            }
            Transform celestialTransform = ScaledSpace.Instance.scaledSpaceTransforms.Single(t => t.name == planet);
            Overlay overlay = new Overlay(planet, altitude, overlayMaterial, PQSMaterial, Rotation, OverlayMgr.MAP_LAYER, celestialTransform, mainMenu, matchTerrain);
            if (!mainMenu)
            {
                if (!OverlayDatabase.ContainsKey(planet))
                {
                    OverlayDatabase.Add(planet, new List<Overlay>());
                }
                OverlayDatabase[planet].Add(overlay);
                OverlayList.Add(overlay);
            }
            
            overlay.EnableMainMenu(mainMenu);
            return overlay;
        }


        public void UpdateAltitude(float altitude, bool mapView = false)
        {
            this.altitude = altitude;
            if (MainMenu)
            {
                OverlayGameObject.transform.localScale = this.altitude * Vector3.one * 1001f;
            }
            else
            {
                OverlayGameObject.transform.localScale = (float)(1f + (this.altitude / celestialBody.Radius)) * Vector3.one * 1002f;
                if (PQSOverlayGameObject != null)
                {
                    PQSOverlayGameObject.transform.localScale = Vector3.one * (float)(celestialBody.Radius + this.altitude);
                }
            }
        }

        public void UpdateRotation(Vector3 rotation)
        {
            float tmp = rotation.x;
            rotation.x = rotation.y;
            rotation.y = tmp;
            OverlayGameObject.transform.Rotate(360f*rotation);
            if (PQSOverlayGameObject != null)
            {
                PQSOverlayGameObject.transform.Rotate(360f * rotation);
            }
            if(MainMenuClone != null)
            {
                if (MainMenuClone.OverlayGameObject != null)
                {
                    MainMenuClone.UpdateRotation(rotation);
                }
                else
                {
                    MainMenuClone = null;
                }
            }
        }

        internal void UpdateAlpha(float alpha)
        {
            overlayMaterial.SetFloat("_Opacity", alpha);
            PQSMaterial.SetFloat("_Opacity", 1.0f - alpha);
        }

        internal void SwitchToOverlay()
        {
            OverlayGameObject.renderer.enabled = true;
            PQSOverlayGameObject.renderer.enabled = false;
            //UpdateAlpha(1);
        }

        internal void SwitchToPQS()
        {
            OverlayGameObject.renderer.enabled = false;
            PQSOverlayGameObject.renderer.enabled = true;
            //UpdateAlpha(alpha);
        }
    }


}
