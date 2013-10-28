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
        public static int OVER_LAYER = 3;//28;
        public static int UNDER_LAYER = 2;//31;

        static Camera overlayCamera;
        static Camera underlayCamera;
        static bool setup = false;
        static bool enabled = false;
       

        protected void Awake()
        {
            if (HighLogic.LoadedScene == GameScenes.TRACKSTATION)
            {
                UnityEngine.Debug.Log("Cameras");
                var goArray = FindObjectsOfType(typeof(GameObject));
                List<GameObject>[] goLayerArray = new List<GameObject>[32];
                for (int i = 0; i < 32; i++)
                {
                    goLayerArray[i] = new List<GameObject>();
                }

                foreach (GameObject go in goArray)
                {
                    goLayerArray[go.layer].Add(go);
                }

                foreach (Camera cam in Camera.allCameras)
                {
                    UnityEngine.Debug.Log("Camera["+cam.name+"] "+cam.cullingMask);
                    for (int i = 0; i < 32; i++)
                    {
                        if (((1 << i) & cam.cullingMask) == (1 << i))
                        {
                            foreach(GameObject go in goLayerArray[i])
                            {
                                UnityEngine.Debug.Log(i.ToString() + " : " + go.name);
                            }
                        }
                    }
                }
            }
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
                enabled = true;
            }
            
        }

        protected void Start()
        {
            if (setup && HighLogic.LoadedScene != GameScenes.FLIGHT && HighLogic.LoadedScene != GameScenes.SPACECENTER)
            {
                disableCamera();
            }
            else if (setup)
            {
                enableCamera();
            }
        }

         public void Update()
        {
            if (HighLogic.LoadedScene != GameScenes.FLIGHT)
            {
                return;
            }

            updateMapView();
        }

         private void updateMapView()
         {
             if (MapView.MapIsEnabled && MapView.MapCamera != null)
             {
                 disableCamera();
             }
             else
             {
                 enableCamera();
             }
         }


         private void enableCamera()
         {
             if (!enabled)
             {
                 ScaledCamera.Instance.camera.cullingMask &= ~((1 << OVER_LAYER) | (1 << UNDER_LAYER));
                 overlayCamera.cullingMask = (1 << OVER_LAYER);
                 underlayCamera.cullingMask = (1 << UNDER_LAYER);
                 enabled = true;
             }
         }

         private void disableCamera()
         {
             if (enabled)
             {
                 ScaledCamera.Instance.camera.cullingMask |= (1 << OVER_LAYER);// | (1 << UNDER_LAYER);
                 overlayCamera.cullingMask = 0;
                 underlayCamera.cullingMask = 0;
                 enabled = false;
             }
         }

        public static void GeneratePlanetOverlay(String planet, float radius, GameObject gameObject, Material overlayMaterial, int layer, int nbLong = 48, int nbLat = 32)
        {
                        
            var mesh = gameObject.AddComponent<MeshFilter>().mesh;
            var mr = gameObject.AddComponent<MeshRenderer>();
           
            GameObject generatedMap = gameObject;


            //float radius = radi;

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
            //mesh.Optimize();
            //mesh.RecalculateNormals();
            //filter.mesh = mesh;

            mr.renderer.sharedMaterial = overlayMaterial;

            mr.castShadows = false;
            mr.receiveShadows = false;
            mr.enabled = true;

            gameObject.renderer.enabled = true;

            gameObject.layer = layer;
            gameObject.transform.parent = ScaledSpace.Instance.scaledSpaceTransforms.Single(t => t.name == planet);
            gameObject.transform.localScale = Vector3.one * 1000f;
            gameObject.transform.localPosition = Vector3.zero;
            gameObject.transform.localRotation = Quaternion.identity;

        }

        public static void Log(String message)
        {
            UnityEngine.Debug.Log("Utils: " + message);
        }

    }
}
