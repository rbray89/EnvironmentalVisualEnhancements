using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;

namespace Utils
{
    public interface INamed
    {
        String Name { get; }
    }

    public class ConfigWrapper : INamed
    {
        public String Name{get{return name;}}
        public ConfigNode Node { get { return node; } }
        string name;
        ConfigNode node;
        public ConfigWrapper(UrlDir.UrlConfig uc)
        {
            name = uc.parent.url;
            node = uc.config;
        }
    }

    public class GUIHelper
    {

        protected static int selectedBodyIndex = 0; 
        protected static CelestialBody currentBody;
        
        public static float GetFieldCount(ConfigNode node)
        {
            float fieldCount = 1;
            
            fieldCount += node.CountValues;
            foreach(ConfigNode n in node.nodes)
            {
                fieldCount += GetFieldCount(n)+.5f;
            }

            return fieldCount;
        }

        public static Rect GetSplitRect(Rect placementBase, ref Rect placement, ConfigNode node = null)
        {
            if (node != null)
            {
                placement.height = GetFieldCount(node);
            }
            float width = placementBase.width / 2;
            float height = 30;
            if (((placement.y + placement.height) * height) + placementBase.y + 25 > placementBase.height)
            {
                placement.x++;
                placement.y = 0;
            }
            float x = (placement.x * width) + placementBase.x;
            float y = (placement.y * height) + placementBase.y;
            width += placement.width;
            height = height * placement.height;
            if (node == null)
            {
                height -= 5;
            }
            return new Rect(x, y, width - 10, height);
        }

        public static void SplitRect(ref Rect rect1, ref Rect rect2, float ratio)
        {
            float width = rect1.width;
            rect1.width *= ratio;
            if (rect2 != null)
            {
                rect2.width = width * (1 - ratio);
                rect2.x = rect1.x + rect1.width;
            }
        }

        private static CelestialBody GetMapBody()
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
            else if (HighLogic.LoadedScene == GameScenes.MAINMENU)
            {
                CelestialBody[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody)) as CelestialBody[];
                return celestialBodies.First<CelestialBody>(cb => cb.bodyName == "Kerbin");
            }
            else
            {
                return currentBody = FlightGlobals.currentMainBody;
            }
            return null;
        }

        public static string DrawBodySelector(Rect placementBase, ref Rect placement)
        {
            CelestialBody[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody)) as CelestialBody[];
            GUIStyle gsCenter = new GUIStyle(GUI.skin.label);
            gsCenter.alignment = TextAnchor.MiddleCenter;

            currentBody = GUIHelper.GetMapBody();

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
            return currentBody.bodyName;
        }

        public static T DrawObjectSelector<T>(List<T> objectList, ref T removed, ref int selectedObjIndex, ref String objString, ref Vector2 objListPos, Rect placementBase, ref Rect placement) where T : INamed, new()
        {
            String[] objList = objectList.Select(i => i.Name).ToArray();
            placement.height = 5;
            Rect selectBoxOutlineRect = GetSplitRect(placementBase, ref placement);
            placement.height = 4;
            Rect selectBoxRect = GetSplitRect(placementBase, ref placement);
            placement.height = objectList.Count;
            Rect selectBoxItemsRect = GetSplitRect(placementBase, ref placement);
            
            placement.height = 1;
            Rect optButtonRect = GetSplitRect(placementBase, ref placement);
            SplitRect(ref selectBoxRect, ref optButtonRect, (15f / 16));

            GUI.Box(selectBoxOutlineRect, "");
            selectBoxRect.x += 10;
            selectBoxRect.width -= 20;
            selectBoxRect.y += 10;
            selectBoxRect.height -= 20;
            
            selectBoxItemsRect.x = 0;
            selectBoxItemsRect.y = 0;
            if (objectList.Count <= 3)
            {
                selectBoxItemsRect.width = selectBoxRect.width;
            }
            else
            {
                selectBoxItemsRect.width = selectBoxRect.width - 20;
            }

            objListPos = GUI.BeginScrollView(selectBoxRect, objListPos, selectBoxItemsRect);
            selectedObjIndex = GUI.SelectionGrid(selectBoxItemsRect, selectedObjIndex, objList, 1);
            GUI.EndScrollView();
            placement.y += 4;

            optButtonRect.x -= 5;
            optButtonRect.y += 10;
            if (GUI.Button(optButtonRect, "^") && selectedObjIndex > 0)
            {
                T item = objectList[selectedObjIndex];
                objectList.Remove(item);
                objectList.Insert(--selectedObjIndex, item);
            }
            optButtonRect.y += 60;
            if (GUI.Button(optButtonRect, "v") && selectedObjIndex < objectList.Count - 1)
            {
                T item = objectList[selectedObjIndex];
                objectList.Remove(item);
                objectList.Insert(++selectedObjIndex, item);
            }

            Rect listEditTextRect = GetSplitRect(placementBase, ref placement);
            listEditTextRect.x += 10;
            listEditTextRect.width -= 20;
            listEditTextRect.y -= 5;

            Rect listEditRect = new Rect(listEditTextRect);
            Rect listAddRect = new Rect(listEditTextRect);
            Rect listRemoveRect = new Rect(listEditTextRect);
            
            SplitRect(ref listEditTextRect, ref listEditRect, (1f / 2));
            SplitRect(ref listEditRect, ref listAddRect, (1f / 3));
            SplitRect(ref listAddRect, ref listRemoveRect, (1f / 2));

            listEditTextRect.width -= 5;
            listEditRect.width -= 5;
            listAddRect.width -= 5;
            listRemoveRect.width -= 5;

            objString = GUI.TextField(listEditTextRect, objString);
            String name = objString;
            if (objString.Length > 0 && !objString.Contains(' ') && objectList.Find(o => o.Name == name) == null)
            {
                if(GUI.Button(listEditRect, "Edit"))
                {

                }
                if(GUI.Button(listAddRect, "Add"))
                {
                    T newObj = new T();
                    objectList.Insert(selectedObjIndex, newObj);
                }
            }
            else
            {
                listEditRect.width += listAddRect.width;
                GUI.Label(listEditRect, "Invalid Name!");
            }
            if(GUI.Button(listRemoveRect, "Remove"))
            {
                T item = objectList[selectedObjIndex];
                objectList.Remove(item);
                if(selectedObjIndex >= objectList.Count && selectedObjIndex > 0)
                {
                    selectedObjIndex--;
                }
                removed = item;
            }
            placement.y++;
            
            if(objectList.Count == 0)
            {
                return default(T);
            }
            return objectList[selectedObjIndex];
        }

        public static T DrawSelector<T>(List<T> objList, ref int selectedIndex, float ratio, Rect placementBase, ref Rect placement) where T : INamed
        {
            Rect leftRect = GUIHelper.GetSplitRect(placementBase, ref placement);
            Rect centerRect = GUIHelper.GetSplitRect(placementBase, ref placement);
            Rect rightRect = GUIHelper.GetSplitRect(placementBase, ref placement);
            GUIHelper.SplitRect(ref leftRect, ref centerRect, 1f / (ratio));
            GUIHelper.SplitRect(ref centerRect, ref rightRect, (ratio - 2) / (ratio-1));

            if (GUI.Button(leftRect, "<"))
            {
                selectedIndex--;
                if (selectedIndex < 0)
                {
                    selectedIndex = objList.Count - 1;
                }
            }
            if (GUI.Button(rightRect, ">"))
            {
                selectedIndex++;
                if (selectedIndex >= objList.Count)
                {
                    selectedIndex = 0;
                }
            }
            T currentObj = objList[selectedIndex];
            if (currentObj != null)
            {
                GUIStyle gsCenter = new GUIStyle(GUI.skin.label);
                gsCenter.alignment = TextAnchor.MiddleCenter;
                GUI.Label(centerRect, currentObj.Name, gsCenter);
            }
            placement.y++;
            return currentObj;
        }
    }
}
