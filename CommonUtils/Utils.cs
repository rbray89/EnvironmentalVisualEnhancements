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
        private int nbLong;
        private int nbLat;
        private Transform celestialTransform;


        public Overlay(string planet, float radius, Material overlayMaterial, int layer, bool avoidZFighting, int nbLong, int nbLat, Transform celestialTransform)
        {

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
                if (body != null)
                {
                    OverlayGameObject.layer = body.layer;
                    OverlayGameObject.transform.parent = body.transform;
                    OverlayGameObject.transform.localScale = Vector3.one * 1008f;
                    OverlayGameObject.transform.localPosition = Vector3.zero;
                    OverlayGameObject.transform.localRotation = Quaternion.identity;
                }
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

            //Sphere code from http://wiki.unity3d.com/index.php/ProceduralPrimitives

            #region Vertices
            Vector3[] vertices = new Vector3[(nbLong + 1) * nbLat + (2 * nbLong)];
            float _pi = Mathf.PI;
            float _2pi = _pi * 2f;

            for (int lon = 0; lon <= nbLong; lon++)
            {
                vertices[lon] = Vector3.up * radius;
            }
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

                    vertices[lon + lat * (nbLong + 1) +  nbLong] = new Vector3(sin1 * cos2, cos1, sin1 * sin2) * radius;
                }
            }
            for (int lon = 0; lon <= nbLong; lon++)
            {
                vertices[(vertices.Length - 1)-lon ] = Vector3.up * -radius;
            }
            #endregion

            #region Normals
            Vector3[] normals = new Vector3[vertices.Length];
            for (int n = 0; n < vertices.Length; n++)
                normals[n] = vertices[n].normalized;
            #endregion

            #region UVs
            Vector2[] uvs = new Vector2[vertices.Length];
            for (int lon = 0; lon <= nbLong; lon++)
            {
                uvs[lon] = new Vector2((float)lon / nbLong, 1f);
            }
            for (int lon = 0; lon <= nbLong; lon++)
            {
                uvs[(vertices.Length - 1) - lon] = new Vector2(1f-((float)lon / nbLong), 0f);
            }
            for (int lat = 0; lat < nbLat; lat++)
            {
                for (int lon = 0; lon <= nbLong; lon++)
                {
                    float h = 1f - (float)(lat + 1) / (nbLat + 1);
                    float height = (float)((.5 * Math.Cos(Math.PI * (h + 1))) + .5);
                    float sigmoid = (float)(1/(1+Math.Pow(100000,-(h-.5))));
                    float trinomial = (float)((4 * Math.Pow(h - .5, 3)) + .5);
                    float invCos = (float)((Math.Acos(2 * (-h + .5))) / Math.PI);
                    float modinvCos = (float)(((Math.Acos(1.68 * (-h + .5))) / (0.65*Math.PI))-0.269);
                    uvs[lon + lat * (nbLong + 1) + nbLong] = new Vector2((float)lon / nbLong, h);
                }
            }
            #endregion

            #region Triangles
            int nbFaces = vertices.Length;
            int nbTriangles = nbFaces * 2;
            int nbIndexes = nbTriangles * 3;
            int[] triangles = new int[nbIndexes];

            Vector3[] tan1 = new Vector3[nbFaces];
            Vector3[] tan2 = new Vector3[nbFaces];

            //Top Cap
            int i = 0;
            for (int lon = 0; lon < nbLong; lon++)
            {
                triangles[i++] = nbLong + lon + 2;
                triangles[i++] = nbLong + lon + 1;
                triangles[i++] = lon;
                calculateTangent(triangles, i - 3, vertices, uvs, tan1, tan2); 
            }

            //Middle
            for (int lat = 0; lat < nbLat - 1; lat++)
            {
                for (int lon = 0; lon < nbLong; lon++)
                {
                    int current = lon + lat * (nbLong + 1) + nbLong;
                    int next = current + nbLong + 1;

                    triangles[i++] = current;
                    triangles[i++] = current + 1;
                    triangles[i++] = next + 1;
                    calculateTangent(triangles, i - 3, vertices, uvs, tan1, tan2); 

                    triangles[i++] = current;
                    triangles[i++] = next + 1;
                    triangles[i++] = next;
                    calculateTangent(triangles, i - 3, vertices, uvs, tan1, tan2); 
                }
            }

            //Bottom Cap
            for (int lon = 0; lon < nbLong; lon++)
            {
                triangles[i++] = vertices.Length - lon - 1;
                triangles[i++] = vertices.Length - (nbLong + lon + 2) - 1;
                triangles[i++] = vertices.Length - (nbLong + lon + 1) - 1;
                calculateTangent(triangles, i - 3, vertices, uvs, tan1, tan2); 
            }
            #endregion

            mesh.vertices = vertices;
            mesh.uv = uvs;
            mesh.triangles = triangles;
            mesh.normals = normals;

            Vector4[] tangents = new Vector4[nbFaces];

            for (long a = 0; a < nbFaces; ++a)
            {
                Vector3 n = mesh.normals[a];
                Vector3 t = tan1[a];

                Vector3 tmp = (t - n * Vector3.Dot(n, t)).normalized;
                tangents[a] = new Vector4(tmp.x, tmp.y, tmp.z);

                tangents[a].w = (Vector3.Dot(Vector3.Cross(n, t), tan2[a]) < 0.0f) ? -1.0f : 1.0f;
            }
            mesh.tangents = tangents;

            mr.renderer.sharedMaterial = overlayMaterial;

            mr.castShadows = false;
            mr.receiveShadows = false;
            mr.enabled = true;

            overlay.OverlayGameObject.renderer.enabled = true;

            overlay.EnableMainMenu(mainMenu);

        }

        private static void calculateTangent(int[] triangles, int index, Vector3[] vertices, Vector2[] uvs, Vector3[] tan1, Vector3[] tan2)
        {
            long i1 = triangles[index + 0];
            long i2 = triangles[index + 1];
            long i3 = triangles[index + 2];

            Vector3 v1 = vertices[i1];
            Vector3 v2 = vertices[i2];
            Vector3 v3 = vertices[i3];

            Vector2 w1 = uvs[i1];
            Vector2 w2 = uvs[i2];
            Vector2 w3 = uvs[i3];

            float x1 = v2.x - v1.x;
            float x2 = v3.x - v1.x;
            float y1 = v2.y - v1.y;
            float y2 = v3.y - v1.y;
            float z1 = v2.z - v1.z;
            float z2 = v3.z - v1.z;

            float s1 = w2.x - w1.x;
            float s2 = w3.x - w1.x;
            float t1 = w2.y - w1.y;
            float t2 = w3.y - w1.y;

            float r = 1.0f / (s1 * t2 - s2 * t1);

            Vector3 sdir = new Vector3((t2 * x1 - t1 * x2) * r, (t2 * y1 - t1 * y2) * r, (t2 * z1 - t1 * z2) * r);
            Vector3 tdir = new Vector3((s1 * x2 - s2 * x1) * r, (s1 * y2 - s2 * y1) * r, (s1 * z2 - s2 * z1) * r);

            tan1[i1] += sdir;
            tan1[i2] += sdir;
            tan1[i3] += sdir;

            tan2[i1] += tdir;
            tan2[i2] += tdir;
            tan2[i3] += tdir;
        }


    }

    public class RadiusSetGUI
    {
        public float RadiusF;
        public String RadiusS;

        public void Clone(float radius)
        {
            this.RadiusF = radius;
            this.RadiusS = radius.ToString("R");
        }

        public void Update(float radiusF, String radiusS)
        {
            if (this.RadiusS != radiusS)
            {
                this.RadiusS = radiusS;
                float.TryParse(radiusS, out RadiusF);
            }
            else if (RadiusF != radiusF)
            {
                this.RadiusF = radiusF;
                this.RadiusS = radiusF.ToString("R");
            }
        }

        public bool IsValid()
        {
            float dummy;
            return float.TryParse(RadiusS, out dummy);
        }
    }

    public class ColorSetGUI
    {
        public Color Color;
        public string Red = "";
        public string Green = "";
        public string Blue = "";

        public void Clone(Color color)
        {
            this.Color = color;
            this.Red = color.r.ToString("R");
            this.Green = color.g.ToString("R");
            this.Blue = color.b.ToString("R");
        }

        public void Update(string SRed, float FRed, string SGreen, float FGreen, string SBlue, float FBlue)
        {
            if (this.Red != SRed)
            {
                this.Red = SRed;
                float.TryParse(SRed,out this.Color.r);
            }
            else if(this.Color.r != FRed)
            {
                this.Color.r = FRed;
                this.Red = FRed.ToString("R");
            }
            if (this.Green != SGreen)
            {
                this.Green = SGreen;
                float.TryParse(SGreen, out this.Color.g);
            }
            else if (this.Color.g != FGreen)
            {
                this.Color.g = FGreen;
                this.Green = FGreen.ToString("R");
            }
            if (this.Blue != SBlue)
            {
                this.Blue = SBlue;
                float.TryParse(SBlue, out this.Color.b);
            }
            else if (this.Color.b != FBlue)
            {
                this.Color.b = FBlue;
                this.Blue = FBlue.ToString("R");
            }
        }

        public bool IsValid()
        {
            float dummy;
            if(float.TryParse(Red, out dummy) &&
                float.TryParse(Green, out dummy) &&
                float.TryParse(Blue, out dummy))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }

    public class TextureSetGUI
    {
        public String StartOffsetX = "";
        public String SpeedX = "";
        public String ScaleX = "";
        public String StartOffsetY = "";
        public String SpeedY = "";
        public String ScaleY = "";
        public String TextureFile = "";
        public bool InUse;

        public void Clone(TextureSet textureSet)
        {
            this.InUse = textureSet.InUse;
            this.TextureFile = textureSet.TextureFile;
            if (this.TextureFile == null)
            {
                this.TextureFile = "";
            }
            this.StartOffsetX = textureSet.StartOffset.x.ToString("R");
            this.StartOffsetY = textureSet.StartOffset.y.ToString("R");
            this.ScaleX = textureSet.Scale.x.ToString("R");
            this.ScaleY = textureSet.Scale.y.ToString("R");
            this.SpeedX = textureSet.Speed.x.ToString("R");
            this.SpeedY = textureSet.Speed.y.ToString("R");
        }

        public bool IsValid()
        {
            float dummy;
            if (float.TryParse(StartOffsetX, out dummy) &&
                float.TryParse(StartOffsetY, out dummy) &&
                float.TryParse(SpeedX, out dummy) &&
                float.TryParse(SpeedY, out dummy) &&
                float.TryParse(ScaleX, out dummy) &&
                float.TryParse(ScaleY, out dummy))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }

    public class TextureSet
    {
        private static Dictionary<String, Texture2D> TextureDictionary = new Dictionary<string, Texture2D>();
        private static Dictionary<String, Texture2D> BumpTextureDictionary = new Dictionary<string, Texture2D>();
        public Vector2 Offset;
        public Vector2 StartOffset;
        public Vector2 Speed;
        public Vector2 Scale;
        private Texture2D texture;
        private String textureFile;
        private bool isBump;

        public bool InUse;
        public Texture2D Texture { get { return texture; } }
        public String TextureFile { get { return textureFile; }}


        private void initTexture()
        {

            if (isBump && !BumpTextureDictionary.ContainsKey(textureFile))
            {
                Texture2D tex = GameDatabase.Instance.GetTexture(textureFile, isBump);
                BumpTextureDictionary.Add(textureFile, tex);
            }
            else if (!TextureDictionary.ContainsKey(textureFile))
            {
                Texture2D tex = GameDatabase.Instance.GetTexture(textureFile, isBump);
                TextureDictionary.Add(textureFile, tex);
            }
            texture = isBump ? BumpTextureDictionary[textureFile] : TextureDictionary[textureFile];
        }

        public TextureSet(ConfigNode textureNode, bool bump) : base()
        {
            isBump = bump;
            if (textureNode != null)
            {
                textureFile = textureNode.GetValue("file");
                if (textureFile != null)
                {
                    initTexture();

                    ConfigNode offsetNode = textureNode.GetNode("offset");
                    if (offsetNode != null)
                    {
                        Offset = new Vector2(float.Parse(offsetNode.GetValue("x")), float.Parse(offsetNode.GetValue("y")));
                        StartOffset = new Vector2(Offset.x, Offset.y);
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
                    InUse = true;
                }
                else
                {
                    textureFile = "";
                }
            }
        }

        public TextureSet()
        {
                textureFile = "";
                texture = null;
                isBump = false;
                InUse = false;
                Offset = new Vector2(0, 0);
                StartOffset = new Vector2(0, 0);
                Speed = new Vector2(0, 0);
                Scale = new Vector2(0, 0);
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

        public void Clone(TextureSetGUI textureSet)
        {
            this.InUse = textureSet.InUse;
            this.textureFile = textureSet.TextureFile;
            initTexture();
            
            this.StartOffset.x = float.Parse(textureSet.StartOffsetX);
            this.StartOffset.y = float.Parse(textureSet.StartOffsetY);
            this.Scale.x = float.Parse(textureSet.ScaleX);
            this.Scale.y = float.Parse(textureSet.ScaleY);
            this.Speed.x = float.Parse(textureSet.SpeedX);
            this.Speed.y = float.Parse(textureSet.SpeedY);
        }

        public ConfigNode GetNode(string name)
        {
            if (!this.InUse)
            {
                return null;
            }
            ConfigNode newNode = new ConfigNode(name);
            newNode.AddValue("file", this.textureFile);
            ConfigNode offsetNode = newNode.AddNode("offset");
            offsetNode.AddValue("x", this.Offset.x);
            offsetNode.AddValue("y", this.Offset.y);
            ConfigNode speedNode = newNode.AddNode("speed");
            speedNode.AddValue("x", this.Speed.x);
            speedNode.AddValue("y", this.Speed.y);
            ConfigNode scaleNode = newNode.AddNode("scale");
            scaleNode.AddValue("x", this.Scale.x);
            scaleNode.AddValue("y", this.Scale.y);
            return newNode;
        }
    }

}
