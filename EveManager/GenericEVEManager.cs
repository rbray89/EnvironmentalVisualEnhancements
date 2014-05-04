using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;

namespace EveManager
{
    [KSPAddon(KSPAddon.Startup.Instantly, true)]
    public class GenericEVEManager<T> : EVEManagerClass where T : IEVEObject, new()
    {
        protected virtual String configName { get { return ""; } }
        protected static List<T> ObjectList = new List<T>();
        protected static UrlDir.UrlConfig[] configs;

        public virtual void GenerateGUI(){}

        internal void Awake()
        {
            if (HighLogic.LoadedScene >= GameScenes.MAINMENU)
            {
                Setup();
            }
        }

        public virtual void Setup()
        {
            Managers.Add(this);
            Managers.RemoveAll(item => item == null);
            LoadConfig();
        }

        public virtual void LoadConfig()
        {
            Log("Loading...");
            configs = GameDatabase.Instance.GetConfigs(configName);
            Clean();
            foreach (UrlDir.UrlConfig config in configs)
            {
                foreach (ConfigNode node in config.config.nodes)
                {
                    T newObject = new T();
                    newObject.LoadConfigNode(node);
                    ObjectList.Add(newObject);
                    newObject.Apply();
                }
            }
        }

        protected void Clean()
        {
            foreach (T obj in ObjectList)
            {
                obj.Remove();
            }
            ObjectList.Clear();
        }

        public void SaveConfig()
        {
            Log("Saving...");
            foreach (UrlDir.UrlConfig config in configs)
            {
                config.config.ClearNodes();
                foreach (T obj in ObjectList)
                {
                    config.config.AddNode(obj.GetConfigNode());
                }
            }
        }

        private float GetFieldCount(FieldInfo container)
        {
            float fieldCount = 1;
            var objfields = container.FieldType.GetFields(BindingFlags.Instance | BindingFlags.NonPublic).Where(
                f => Attribute.IsDefined(f, typeof(Persistent)));
            foreach (FieldInfo fi in objfields)
            {
                if (fi.FieldType == typeof(String) ||
                    fi.FieldType == typeof(Vector3) ||
                    fi.FieldType == typeof(Color) ||
                    fi.FieldType == typeof(float))
                {
                    fieldCount++;
                }
                else
                {
                    fieldCount += GetFieldCount(fi);
                }
            }
            return fieldCount;
        }

        private Rect GetSplitRect(Rect placementBase, ref Rect placement, FieldInfo container = null)
        {
            if(container != null)
            {
                placement.height = GetFieldCount(container);
            }
            float width = placementBase.width / 2;
            float height = 30;
            if (((placement.y+placement.height) * height) + placementBase.y + 25 > placementBase.height)
            {
                placement.x++;
                placement.y = 0;
            }
            float x = (placement.x * width) + placementBase.x;
            float y = (placement.y * height) + placementBase.y;
            width += placement.width;
            height = height * placement.height;
            if (container == null)
            {
                height -= 5;
            }
            return new Rect(x, y, width - 10, height);
        }

        private void SplitRect(ref Rect rect1, ref Rect rect2, float ratio)
        {
            float width = rect1.width;
            rect1.width *= ratio;
            rect2.width = width * (1 - ratio);
            rect2.x = rect1.x + rect1.width;
        }

        private void HandleGUI(object obj, FieldInfo field, Rect placementBase, ref Rect placement)
        {
            Rect labelRect = GetSplitRect(placementBase, ref placement);
            Rect fieldRect = GetSplitRect(placementBase, ref placement);
            SplitRect(ref labelRect, ref fieldRect, 3f / 7);
            if(field.FieldType == typeof(String))
            {
                GUI.Label(labelRect, field.Name);
                GUI.TextField(fieldRect, field.GetValue(obj).ToString());
                placement.y++;
            }
            else if (field.FieldType == typeof(Vector3))
            {
                GUI.Label(labelRect, field.Name);
                GUI.TextField(fieldRect, ((Vector3)field.GetValue(obj)).ToString("F3"));
                placement.y++;
            }
            else if (field.FieldType == typeof(Color))
            {
                GUI.Label(labelRect, field.Name);
                GUI.TextField(fieldRect, ((Color)field.GetValue(obj)).ToString("F3"));
                placement.y++;
            }
            else if (field.FieldType == typeof(float))
            {
                GUI.Label(labelRect, field.Name);
                GUI.TextField(fieldRect, ((float)field.GetValue(obj)).ToString("F3"));
                placement.y++;
            }
            else
            {
                GUIStyle gsCenter = new GUIStyle(GUI.skin.label);
                gsCenter.alignment = TextAnchor.MiddleCenter;
                
                Rect boxRect = GetSplitRect(placementBase, ref placement, field);
                GUI.Box(boxRect, "");
                placement.height = 1;
                Rect titleRect = GetSplitRect(placementBase, ref placement);

                Rect boxPlacementBase = new Rect(placementBase);
                boxPlacementBase.x += 10;
                Rect boxPlacement = new Rect(placement);
                boxPlacement.width -= 20;
                GUI.Label(titleRect, field.Name, gsCenter);
                boxPlacement.y++;

                var objfields = field.FieldType.GetFields(BindingFlags.Instance | BindingFlags.NonPublic).Where(
                f => Attribute.IsDefined(f, typeof(Persistent)));
                foreach (FieldInfo fi in objfields)
                {
                    HandleGUI(field.GetValue(obj), fi, boxPlacementBase, ref boxPlacement);
                }
                placement.y = boxPlacement.y;
                placement.x = boxPlacement.x;
            }
        }

        public void DrawBodySelector(Rect placementBase, ref Rect placement)
        {
            CelestialBody[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody)) as CelestialBody[];
            GUIStyle gsCenter = new GUIStyle(GUI.skin.label);
            gsCenter.alignment = TextAnchor.MiddleCenter;

            currentBody = GetMapBody();
                
            Rect leftRect = GetSplitRect(placementBase, ref placement);
            Rect centerRect = GetSplitRect(placementBase, ref placement);
            Rect rightRect = GetSplitRect(placementBase, ref placement);
            SplitRect(ref leftRect, ref centerRect, 1f / 4);
            SplitRect(ref centerRect, ref rightRect, 2f / 3);
            if (MapView.MapIsEnabled || HighLogic.LoadedScene == GameScenes.TRACKSTATION)
            {
                if (GUI.Button(leftRect, "<"))
                {
                    selectedBodyIndex--;
                    if (selectedBodyIndex < 0)
                    {
                        selectedBodyIndex = celestialBodies.Length - 1;
                    }
                    currentBody = celestialBodies[selectedBodyIndex];
                    MapView.MapCamera.SetTarget(currentBody.bodyName);
                }
                if (GUI.Button(rightRect, ">"))
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
            if (currentBody != null)
            {
                GUI.Label(centerRect, currentBody.bodyName, gsCenter);
            }
            placement.y++;
        }

        private CelestialBody GetMapBody()
        {
            if (MapView.MapIsEnabled)
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
            }
            else
            {
                return currentBody = FlightGlobals.currentMainBody;
            }
            return null;
        }

        public override void DrawGUI(Rect placementBase)
        {
            Rect placement = new Rect(0, 0, 0, 1);
            DrawBodySelector(placementBase, ref placement);

            var fields = this.GetType().GetFields(BindingFlags.Instance | BindingFlags.NonPublic).Where(
                field => Attribute.IsDefined(field, typeof(Persistent)));
            foreach(FieldInfo fi in fields)
            {
                HandleGUI(this, fi, placementBase, ref placement);
            }
            
            foreach(T obj in ObjectList)
            {
                var objfields = obj.GetType().GetFields(BindingFlags.Instance | BindingFlags.NonPublic).Where(
                field => Attribute.IsDefined(field, typeof(Persistent)));
                foreach (FieldInfo fi in objfields)
                {
                    if (fi.Name != "body")
                    {
                        HandleGUI(obj, fi, placementBase, ref placement);
                    }
                }
            }
        }

        protected void OnGUI()
        {
        }

        protected void Update()
        {
        }

        public new static void Log(String message)
        {
            UnityEngine.Debug.Log(typeof(T).Name + ": " + message);
        }
    }

}
