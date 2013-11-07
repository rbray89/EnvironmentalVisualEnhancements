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
        static ConfigNode config;
        static Camera overlayCamera;
        static Camera underlayCamera;
        static bool setup = false;
        static bool setupCallbacks = false;
        static String CurrentBodyName;
        static bool bodyOverlayEnabled = false;
        static bool mainMenuOverlay = false;
        public static bool MainMenuOverlay
        {
            get{return mainMenuOverlay;}
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

                foreach (CelestialBody cb in celestialBodies)
                {
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
                overlayCamera.nearClipPlane = .05f;
                overlayCamera.layerCullDistances = new float[32];
                overlayCamera.layerCullSpherical = true;
                overlayCamera.clearFlags = CameraClearFlags.Depth;

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
                underlayCamera.nearClipPlane = .05f;
                underlayCamera.layerCullDistances = new float[32];
                underlayCamera.layerCullSpherical = true;
                underlayCamera.clearFlags = CameraClearFlags.Depth;
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
                if (kerbin == null)
                {
                    Log("Couldn't find Kerbin!");
                    return;
                }
                List<Overlay> overlayList = Overlay.OverlayDatabase["Kerbin"];
                if (overlayList != null)
                {
                    foreach (Overlay kerbinOverlay in overlayList)
                    {
                        kerbinOverlay.CloneForMainMenu();
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
        /*
        private GUISkin _mySkin;
        private Rect _mainWindowRect = new Rect(20, 20, 200, 200);
        private void OnGUI()
        {

            GUI.skin = _mySkin;

            // Main Window
            _mainWindowRect = GUI.Window(0x8100, _mainWindowRect, DrawMainWindow, "CityGen");


        }

        private void DrawMainWindow(int windowID)
        {

                GUI.Label(new Rect(10, 15, 200, 25), "Body: " + CurrentBodyName);

            GUI.DragWindow(new Rect(0, 0, 10000, 10000));
        }
        */
        public static void Log(String message)
        {
            UnityEngine.Debug.Log("Utils: " + message);
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
        private int nbLong;
        private int nbLat;
        private Transform celestialTransform;


        public Overlay(string planet, float radius, Material overlayMaterial, int layer, bool avoidZFighting, int nbLong, int nbLat, Transform celestialTransform)
        {
            // TODO: Complete member initialization
            this.OverlayGameObject = new GameObject();
            this.Body = planet;
            this.radius = radius;
            this.overlayMaterial = overlayMaterial;
            this.OriginalLayer = layer;
            this.AvoidZFighting = avoidZFighting;
            this.nbLong = nbLong;
            this.nbLat = nbLat;
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
                    OverlayGameObject.transform.localScale = Vector3.one * 1002f;
                }
                else
                {
                    OverlayGameObject.transform.localScale = Vector3.one * 1000f;
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
                if (body == null)
                {
                    Utils.Log("Couldn't find Kerbin!");
                    return;
                }
                OverlayGameObject.layer = body.layer;
                OverlayGameObject.transform.parent = body.transform;
                OverlayGameObject.transform.localScale = Vector3.one * 1008f;
                OverlayGameObject.transform.localPosition = Vector3.zero;
                OverlayGameObject.transform.localRotation = Quaternion.identity;
            }
            else
            {
                OverlayGameObject.layer = Utils.MAP_LAYER;
                OverlayGameObject.transform.parent = celestialTransform;
                OverlayGameObject.transform.localScale = Vector3.one * 1000f;
                OverlayGameObject.transform.localPosition = Vector3.zero;
                OverlayGameObject.transform.localRotation = Quaternion.identity;
            }
            
            FixZFighting(p);
        }

        public void CloneForMainMenu()
        {
            GeneratePlanetOverlay(this.Body, this.radius, this.overlayMaterial, this.OriginalLayer, false, this.nbLong, this.nbLat, true);
        }

        public static void GeneratePlanetOverlay(String planet, float radius, Material overlayMaterial, int layer, bool avoidZFighting = false, int nbLong = 48, int nbLat = 48, bool mainMenu = false)
        {
            
            Transform celestialTransform = ScaledSpace.Instance.scaledSpaceTransforms.Single(t => t.name == planet);
            Overlay overlay = new Overlay(planet, radius, overlayMaterial, layer, avoidZFighting, nbLong, nbLat, celestialTransform);
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
            var mesh = overlay.OverlayGameObject.AddComponent<MeshFilter>().mesh;
            var mr = overlay.OverlayGameObject.AddComponent<MeshRenderer>();

            GameObject generatedMap = overlay.OverlayGameObject;

            #region Vertices
            Vector3[] vertices = new Vector3[(nbLong + 1) * nbLat + 2];
            float _pi = Mathf.PI;
            float _2pi = _pi * 2f;

            vertices[0] = Vector3.up * radius;
            for (int lat = 0; lat < nbLat; lat++)
            {
                float a1 = _pi * (float)(lat + 1) / (nbLat + 1);
                float sin1 = Mathf.Sin(a1);
                float cos1 = Mathf.Cos(a1);

                for (int lon = 0; lon <= nbLong; lon++)
                {
                    float a2 = _2pi * (float)(lon == nbLong ? 0 : lon) / nbLong;
                    float sin2 = Mathf.Sin(a2);
                    float cos2 = Mathf.Cos(a2);

                    vertices[lon + lat * (nbLong + 1) + 1] = new Vector3(sin1 * cos2, cos1, sin1 * sin2) * radius;
                }
            }
            vertices[vertices.Length - 1] = Vector3.up * -radius;
            #endregion

            #region Normales
            Vector3[] normales = new Vector3[vertices.Length];
            for (int n = 0; n < vertices.Length; n++)
                normales[n] = vertices[n].normalized;
            #endregion

            #region UVs
            Vector2[] uvs = new Vector2[vertices.Length];
            uvs[0] = Vector2.up;
            uvs[uvs.Length - 1] = Vector2.zero;
            for (int lat = 0; lat < nbLat; lat++)
                for (int lon = 0; lon <= nbLong; lon++)
                    uvs[lon + lat * (nbLong + 1) + 1] = new Vector2((float)lon / nbLong, 1f - (float)(lat + 1) / (nbLat + 1));
            #endregion

            #region Triangles
            int nbFaces = vertices.Length;
            int nbTriangles = nbFaces * 2;
            int nbIndexes = nbTriangles * 3;
            int[] triangles = new int[nbIndexes];

            //Top Cap
            int i = 0;
            for (int lon = 0; lon < nbLong; lon++)
            {
                triangles[i++] = lon + 2;
                triangles[i++] = lon + 1;
                triangles[i++] = 0;
            }

            //Middle
            for (int lat = 0; lat < nbLat - 1; lat++)
            {
                for (int lon = 0; lon < nbLong; lon++)
                {
                    int current = lon + lat * (nbLong + 1) + 1;
                    int next = current + nbLong + 1;

                    triangles[i++] = current;
                    triangles[i++] = current + 1;
                    triangles[i++] = next + 1;

                    triangles[i++] = current;
                    triangles[i++] = next + 1;
                    triangles[i++] = next;
                }
            }

            //Bottom Cap
            for (int lon = 0; lon < nbLong; lon++)
            {
                triangles[i++] = vertices.Length - 1;
                triangles[i++] = vertices.Length - (lon + 2) - 1;
                triangles[i++] = vertices.Length - (lon + 1) - 1;
            }
            #endregion

            mesh.vertices = vertices;
            mesh.normals = normales;
            mesh.uv = uvs;
            mesh.triangles = triangles;

            mesh.RecalculateBounds();

            mr.renderer.sharedMaterial = overlayMaterial;

            mr.castShadows = false;
            mr.receiveShadows = false;
            mr.enabled = true;

            overlay.OverlayGameObject.renderer.enabled = true;

            overlay.EnableMainMenu(mainMenu);

        }


    }

    public class TextureSet
    {
        static Dictionary<String, Texture2D> TextureDictionary = new Dictionary<string, Texture2D>();
        public Vector2 Offset;
        public Vector2 Speed;
        public Vector2 Scale;
        public Texture2D Texture;

        private void initTextures(String textureString, bool bump)
        {
            if (!TextureDictionary.ContainsKey(textureString))
            {
                Texture2D tex =  GameDatabase.Instance.GetTexture(textureString, false);
                if(bump)
                {
                    tex = GameDatabase.BitmapToUnityNormalMap(tex);
                }
                TextureDictionary.Add(textureString, tex);
            }
        }

        public TextureSet(ConfigNode textureNode, bool bump)
        {
            if (textureNode != null)
            {
                String textureString = textureNode.GetValue("file");
                initTextures(textureString, bump);
                Texture = TextureDictionary[textureString];
                ConfigNode offsetNode = textureNode.GetNode("offset");
                if (offsetNode != null)
                {
                    Offset = new Vector2(float.Parse(offsetNode.GetValue("x")), float.Parse(offsetNode.GetValue("y")));
                }
                ConfigNode speedNode = textureNode.GetNode("speed");
                if (speedNode != null)
                {
                    Speed = new Vector2(float.Parse(speedNode.GetValue("x")), float.Parse(speedNode.GetValue("y")));
                }
                ConfigNode scaleNode = textureNode.GetNode("scale");
                if (scaleNode != null)
                {
                    Scale = new Vector2(float.Parse(scaleNode.GetValue("x")), float.Parse(scaleNode.GetValue("y")));
                }
            }
            else
            {
                Texture = null;
            }
        }
        
        public void SaturateOffset()
        {
            while (this.Offset.x > 1.0f)
            {
                this.Offset.x -= 1.0f;
            }
            while (this.Offset.x < 0.0f)
            {
                this.Offset.x += 1.0f;
            }
            while (this.Offset.y > 1.0f)
            {
                this.Offset.y -= 1.0f;
            }
            while (this.Offset.y < 0.0f)
            {
                this.Offset.y += 1.0f;
            }
        }

        public void UpdateOffset(float rateOffset)
        {
            this.Offset.x += rateOffset * this.Speed.x;
            this.Offset.y += rateOffset * this.Speed.y;
            SaturateOffset();
        }

    }

}
