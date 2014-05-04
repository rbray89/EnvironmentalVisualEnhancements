using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace EveManager
{
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class EVEManagerClass : MonoBehaviour
    {
        public static List<EVEManagerClass> Managers = new List<EVEManagerClass>();
        public static bool useEditor = false;
        public static int MAP_LAYER = 10;
        public static int MACRO_LAYER = 15;
        public static int ROTATION_PROPERTY;
        public static int MAINOFFSET_PROPERTY;
        
        internal void Awake()
        {
            ROTATION_PROPERTY = Shader.PropertyToID("_Rotation");
            MAINOFFSET_PROPERTY = Shader.PropertyToID("_MainOffset");
        }

        internal void Update()
        {
            if (HighLogic.LoadedScene == GameScenes.FLIGHT || HighLogic.LoadedScene == GameScenes.TRACKSTATION ||
                HighLogic.LoadedScene == GameScenes.MAINMENU || HighLogic.LoadedScene == GameScenes.SPACECENTER)
            {
                bool alt = (Input.GetKey(KeyCode.LeftAlt) || Input.GetKey(KeyCode.RightAlt));
                if (alt && Input.GetKeyDown(KeyCode.E))
                {
                    useEditor = !useEditor;
                }
            }
        }
        public static CelestialBody GetCelestialBody(String body)
        {
            CelestialBody[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody)) as CelestialBody[];
            return celestialBodies.Single(n => n.bodyName == body);
        }

        public static Transform GetScaledTransform(string body)
        {
            List<Transform> transforms = ScaledSpace.Instance.scaledSpaceTransforms;
            return transforms.Single(n => n.name == body);
        }

        private GUISkin _mySkin;
        private Rect _mainWindowRect = new Rect(20, 20, 260, 800);
        
        private static int selectedBodyIndex = 0;
        private static int selectedManagerIndex = 0;
        private static CelestialBody currentBody;

        private void OnGUI()
        {

            GUI.skin = _mySkin;
            if (useEditor)
            {
                _mainWindowRect.width = 840;
                _mainWindowRect.height = 640;
                _mainWindowRect = GUI.Window(0x8100, _mainWindowRect, DrawMainWindow, "EVE Manager");
            }
            
        }

        private void DrawMainWindow(int windowID)
        {
            CelestialBody[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody)) as CelestialBody[];
            EVEManagerClass currentManager;
            if (MapView.MapIsEnabled)
            {
                if(GUI.Button(new Rect(10, 25, 25, 25),"<"))
                {
                    selectedBodyIndex--;
                    if (selectedBodyIndex < 0)
                    {
                        selectedBodyIndex = celestialBodies.Length-1;
                    }
                    currentBody = celestialBodies[selectedBodyIndex];
                    MapView.MapCamera.SetTarget(currentBody.bodyName);
                }
                if (GUI.Button(new Rect(160, 25, 25, 25), ">"))
                {
                    selectedBodyIndex++;
                    if (selectedBodyIndex >= celestialBodies.Length)
                    {
                        selectedBodyIndex = 0;
                    }
                    currentBody = celestialBodies[selectedBodyIndex];
                    MapView.MapCamera.SetTarget(currentBody.bodyName);
                }
            }
            else
            {
                if (FlightGlobals.currentMainBody != null)
                {
                    currentBody = FlightGlobals.currentMainBody;
                    selectedBodyIndex = Array.FindIndex<CelestialBody>(celestialBodies, cb => cb.name == currentBody.name);
                }
            }
            GUIStyle gsCenter = new GUIStyle(GUI.skin.label);
            gsCenter.alignment = TextAnchor.MiddleCenter;
            if (currentBody != null)
            {
                GUI.Label(new Rect(25, 25, 130, 25), currentBody.bodyName, gsCenter);
            }
            
            if(GUI.Button(new Rect(10, 55, 25, 25),"<"))
            {
                selectedManagerIndex--;
                if (selectedManagerIndex < 0)
                {
                    selectedManagerIndex = Managers.Count - 1;
                }
            }
            if (GUI.Button(new Rect(270, 55, 25, 25), ">"))
            {
                selectedManagerIndex++;
                if (selectedManagerIndex >= Managers.Count)
                {
                    selectedManagerIndex = 0;
                }
            }
            currentManager = Managers[selectedManagerIndex];
            if (currentManager != null)
            {
                GUI.Label(new Rect(25, 55, 240, 25), currentManager.GetType().Name, gsCenter);
                float width = _mainWindowRect.width - 30;
                float height = _mainWindowRect.height - 10;
                currentManager.DrawGUI(new Rect(10, 85, width, height));
            }
            
            GUI.DragWindow();
        }

        public virtual void DrawGUI(Rect val)
        {
        }

        public static void Log(String message)
        {
            UnityEngine.Debug.Log("EVEManager: " + message);
        }
    }
}
