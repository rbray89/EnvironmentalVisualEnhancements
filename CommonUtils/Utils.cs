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

        private GameObject OverlayGameObject;
        private GameObject PQSOverlayGameObject;
        private string Body;
        private float radius;
        private Material overlayMaterial;
        private Material PQSMaterial;
        private int OriginalLayer;
        private bool MainMenu;
        private Vector2 Rotation;
        private Transform celestialTransform;
        private Overlay MainMenuClone;
        private CelestialBody celestialBody;

        public Overlay(string planet, float radius, Material overlayMaterial, Material PQSMaterial, Vector2 rotation, int layer, Transform celestialTransform, bool mainMenu)
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
            IsoSphere.Create(OverlayGameObject, false);
            mr.renderer.sharedMaterial = overlayMaterial;
            mr.castShadows = false;
            mr.receiveShadows = false;
            mr.enabled = true;
            OverlayGameObject.renderer.enabled = true;

            overlayMaterial.SetFloat("_FadeDist", 0.4f);
            overlayMaterial.SetFloat("_FadeScale", 0.1f / 0.4f);
            PQSMaterial.SetFloat("_FadeDist", 8f);
            PQSMaterial.SetFloat("_FadeScale", 0.1f / 8f);

            if (!mainMenu)
            {
                this.PQSOverlayGameObject = new GameObject();
                mr = PQSOverlayGameObject.AddComponent<MeshRenderer>();
                IsoSphere.Create(PQSOverlayGameObject, false);
                mr.renderer.sharedMaterial = PQSMaterial;
                mr.castShadows = false;
                mr.receiveShadows = false;
                mr.enabled = true;
                PQSOverlayGameObject.renderer.enabled = true;
                PQSOverlayGameObject.layer = 15;

                CelestialBody[] celestialBodies = (CelestialBody[])CelestialBody.FindObjectsOfType(typeof(CelestialBody));
                celestialBody = celestialBodies.First(n => n.bodyName == this.Body);

                placePQS();
                
            }
            this.UpdateRadius(radius, mainMenu);
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
            blockScript.lod[0].visibleRange = 300000 + (float)celestialBody.Radius;
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
                OverlayGameObject.layer = Utils.MAP_LAYER;
                OverlayGameObject.transform.parent = celestialTransform;
                OverlayGameObject.transform.localPosition = Vector3.zero;
                OverlayGameObject.transform.localRotation = Quaternion.identity;
            }
            this.UpdateRotation(Rotation);
            this.UpdateRadius(radius, mainMenu);
        }

        public void CloneForMainMenu()
        {
            if (MainMenuClone == null)
            {
                MainMenuClone = GeneratePlanetOverlay(this.Body, (float)(1f + (this.radius / celestialBody.Radius)), this.overlayMaterial, this.PQSMaterial, this.Rotation, true);
            }
        }

        public void RemoveOverlay()
        {
            OverlayDatabase[this.Body].Remove(this);
            GameObject.Destroy(this.OverlayGameObject);
        }

        public static Overlay GeneratePlanetOverlay(String planet, float radius, Material overlayMaterial, Material PQSMaterial, Vector2 rotation, bool mainMenu = false)
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
            Overlay overlay = new Overlay(planet, radius, overlayMaterial, PQSMaterial, Rotation, Utils.MAP_LAYER, celestialTransform, mainMenu);
            if (!mainMenu)
            {
                if (!OverlayDatabase.ContainsKey(planet))
                {
                    OverlayDatabase.Add(planet, new List<Overlay>());
                }
                OverlayDatabase[planet].Add(overlay);
            }
            
            overlay.EnableMainMenu(mainMenu);
            return overlay;
        }


        public void UpdateRadius(float radius, bool mapView = false)
        {
            this.radius = radius;
            if (MainMenu)
            {
                OverlayGameObject.transform.localScale = this.radius * Vector3.one * 1004f;
            }
            else
            {
                OverlayGameObject.transform.localScale = (float)(1f + (this.radius / celestialBody.Radius)) * Vector3.one * 1000f;
                if (PQSOverlayGameObject != null)
                {
                    PQSOverlayGameObject.transform.localScale = Vector3.one * (float)(celestialBody.Radius + this.radius);
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
    }


}
