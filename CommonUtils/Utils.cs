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
        public static float MAP_SWITCH_DISTANCE = 400.0f;

        static Camera overlayCamera;
        static Camera underlayCamera;
        static bool setup = false;
        static String CurrentBodyName;
        static bool isTracking = false;
        static bool bodyOverlayEnabled = false;

        protected void Awake()
        {

            if (HighLogic.LoadedScene == GameScenes.MAINMENU && !setup)
            {
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

                Sun.Instance.light.cullingMask |= (1 << OVER_LAYER) | (1 << UNDER_LAYER);
                setup = true;
            }

            GameEvents.onDominantBodyChange.Add(OnDominantBodyChangeCallback);
            GameEvents.onFlightReady.Add(OnFlightReadyCallback);
            MapView.OnEnterMapView += new Callback(EnterMapView);
            MapView.OnExitMapView += new Callback(ExitMapView);

        }

        protected void Start()
        {
            if (setup && HighLogic.LoadedScene != GameScenes.FLIGHT && HighLogic.LoadedScene != GameScenes.SPACECENTER)
            {
                disableCamera();
            }
            else if (HighLogic.LoadedScene == GameScenes.SPACECENTER)
            {
                disablePlanetOverlay(CurrentBodyName);
                enablePlanetOverlay("Kerbin");
                enableCamera();
            }
            else if (setup)
            {
                enableCamera();
            }
        }

        private void EnterMapView()
        {
            disableCamera();
            isTracking = true;
        }

        private void ExitMapView()
        {
            enableCamera();
            isTracking = false;
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
            if (HighLogic.LoadedScene != GameScenes.FLIGHT)
            {
                return;
            }
            if (!MapView.MapIsEnabled || MapView.MapCamera == null)
            {
                float distanceFromCamera = Vector3.Distance(
                    overlayCamera.transform.position,
                    ScaledSpace.Instance.scaledSpaceTransforms.Single(t => t.name == CurrentBodyName).position);

                if (distanceFromCamera >= MAP_SWITCH_DISTANCE && bodyOverlayEnabled)
                {
                    disablePlanetOverlay(CurrentBodyName);
                }
                else if (distanceFromCamera < MAP_SWITCH_DISTANCE && !bodyOverlayEnabled)
                {
                    enablePlanetOverlay(CurrentBodyName);
                }
            }

        }

        private void disablePlanetOverlay(String body)
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

        private void enablePlanetOverlay(String body)
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

        private void enableCamera()
        {
            ScaledCamera.Instance.camera.cullingMask &= ~((1 << OVER_LAYER) | (1 << UNDER_LAYER));
            overlayCamera.cullingMask = (1 << OVER_LAYER);
            underlayCamera.cullingMask = (1 << UNDER_LAYER);
            foreach (Overlay overlay in Overlay.ZFightList)
            {
                overlay.FixZFighting(false);
            }
        }

        private void disableCamera()
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
        private Rect _mainWindowRect = new Rect(20, 20, 200, 100);
        private void OnGUI()
        {

            GUI.skin = _mySkin;

            // Main Window
            _mainWindowRect = GUI.Window(0x8100, _mainWindowRect, DrawMainWindow, "CityGen");


        }

        private void DrawMainWindow(int windowID)
        {
            if (ScaledSpace.Instance != null && ScaledSpace.Instance.scaledSpaceTransforms.Single(t => t.name == CurrentBodyName) != null && overlayCamera != null)
            {
                float distanceFromCamera = Vector3.Distance(
                        overlayCamera.transform.position,
                        ScaledSpace.Instance.scaledSpaceTransforms.Single(t => t.name == CurrentBodyName).position);
                GUI.Label(new Rect(70, 10, 100, 25), distanceFromCamera.ToString());
            }
            GUI.DragWindow(new Rect(0, 0, 10000, 10000));
        }
        */
        public static void Log(String message)
        {
            UnityEngine.Debug.Log("Utils: " + message);
        }

        public class Overlay
        {
            public static Dictionary<String, List<Overlay>> OverlayDatabase = new Dictionary<string, List<Overlay>>();
            public static List<Overlay> ZFightList = new List<Overlay>();

            string Body;
            GameObject GameObject;
            bool AvoidZFighting;
            int OriginalLayer;

            public Overlay(string body, GameObject gameObject, bool avoidZFighting, int originalLayer)
            {
                Body = body;
                GameObject = gameObject;
                AvoidZFighting = avoidZFighting;
                OriginalLayer = originalLayer;
            }

            internal void PushToMapLayer()
            {
                if (OriginalLayer != UNDER_LAYER)
                {
                    GameObject.layer = MAP_LAYER;
                }
                else
                {
                    GameObject.layer = IGNORE_LAYER;
                }
                if (AvoidZFighting)
                {
                    FixZFighting(true);
                }
            }

            internal void PopLayer()
            {
                GameObject.layer = OriginalLayer;
                if (AvoidZFighting)
                {
                    FixZFighting(false);
                }
            }

            internal void FixZFighting(bool enable)
            {
                if (enable)
                {
                    GameObject.transform.localScale = Vector3.one * 1002f;
                }
                else
                {
                    GameObject.transform.localScale = Vector3.one * 1000f;
                }
            }

            public static void GeneratePlanetOverlay(String planet, float radius, GameObject gameObject, Material overlayMaterial, int layer, bool avoidZFighting = false, int nbLong = 48, int nbLat = 48)
            {
                if (!OverlayDatabase.ContainsKey(planet))
                {
                    OverlayDatabase.Add(planet, new List<Overlay>());
                }
                Overlay overlay = new Overlay(planet, gameObject, avoidZFighting, layer);
                OverlayDatabase[planet].Add(overlay);

                if (avoidZFighting)
                {
                    ZFightList.Add(overlay);
                }

                var mesh = gameObject.AddComponent<MeshFilter>().mesh;
                var mr = gameObject.AddComponent<MeshRenderer>();

                GameObject generatedMap = gameObject;

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

                gameObject.renderer.enabled = true;

                gameObject.layer = MAP_LAYER;
                gameObject.transform.parent = ScaledSpace.Instance.scaledSpaceTransforms.Single(t => t.name == planet);
                gameObject.transform.localScale = Vector3.one * 1000f;
                gameObject.transform.localPosition = Vector3.zero;
                gameObject.transform.localRotation = Quaternion.identity;
                
            }
        }
    }
}
