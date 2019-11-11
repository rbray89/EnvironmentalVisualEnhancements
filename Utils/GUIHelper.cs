﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;

namespace Utils
{
    public class GUIHidden : Attribute
    {

    }

    public class ConfigName : Attribute
    {
        string name;
        public string Name { get { return name; } }
        public ConfigName(string name)
        {
            this.name = name;
        }
    }

    public static class GUIHelper
    {
        public const float spacingOffset = .25f;
        public const float elementHeight = 22;
        public const float valueRatio = (3f / 7);

        public const string UP_ARROW = "\u2191";//"\u23f6";
        public const string DOWN_ARROW = "\u2193";//"\u23f7";
        public const string LEFT_ARROW = "\u2190";//"\u23f4";
        public const string RIGHT_ARROW = "\u2192";//"\u23f5";
    
        public static float GetNodeHeightCount(ConfigNode node, Type T, FieldInfo parent)
        {
            float fieldCount = 1f+ (2f*spacingOffset);
            var objfields = T.GetFields(BindingFlags.Instance | BindingFlags.NonPublic).Where(
                    f => Attribute.IsDefined(f, typeof(ConfigItem)));
            

            foreach (FieldInfo field in objfields)
            {
                bool isNode = ConfigHelper.IsNode(field, node, false);

                if ( node != null && ConfigHelper.ConditionsMet(field, parent, node))
                {
                    if (isNode)
                    {
                        if (node.HasNode(field.Name))
                        {
                            fieldCount += GetNodeHeightCount(node.GetNode(field.Name), field.FieldType, field);
                        }
                        else
                        {
                            fieldCount += GetNodeHeightCount(null, field.FieldType, field);
                        }
                        fieldCount += spacingOffset;
                    }
                    else if(!Attribute.IsDefined(field, typeof(GUIHidden)))
                    {
                        fieldCount += 1f+ spacingOffset;
                    }
                }
            }

            return fieldCount;
        }
        
        public static Rect GetRect(Rect placementBase, ref Rect placement, ConfigNode node, Type T, FieldInfo field)
        {
            placement.height = GetNodeHeightCount(node, T, field);
            float width = placementBase.width;
            float height;

            float x = (placement.x * width) + placementBase.x;
            float y = (placement.y * elementHeight) + placementBase.y;
            width += placement.width;
            height = (elementHeight * placement.height);
            return new Rect(x, y, width - 10, height);
        }

        public static Rect GetRect(Rect placementBase, ref Rect placement)
        {
            float width = placementBase.width;
            float height;

            float x = (placement.x * width) + placementBase.x;
            float y = (placement.y * elementHeight) + placementBase.y;
            width += placement.width;
            height = (elementHeight * placement.height);
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
                    case MapObject.ObjectType.CelestialBody:
                        return target.celestialBody;
                    case MapObject.ObjectType.ManeuverNode:
                        return target.maneuverNode.patch.referenceBody;
                    case MapObject.ObjectType.Vessel:
                        return target.vessel.mainBody;
                }
            }
            else if (HighLogic.LoadedScene == GameScenes.MAINMENU)
            {
                CelestialBody[] celestialBodies = FlightGlobals.Bodies.ToArray();
                return celestialBodies.First<CelestialBody>(cb => cb.isHomeWorld);
            }
            else
            {
                return FlightGlobals.currentMainBody;
            }
            return null;
        }

        public static String DrawBodySelector(Rect placementBase, ref Rect placement)
        {
            List<String> celestialBodies = FlightGlobals.Bodies.ConvertAll(x => x.bodyName);
            CelestialBody currentBody = GUIHelper.GetMapBody();
            if (currentBody != null)
            {
                String body = DrawSelector<String>(celestialBodies.ToList(), currentBody.bodyName, 4, placementBase, ref placement);
                if (MapView.MapIsEnabled || HighLogic.LoadedScene == GameScenes.TRACKSTATION)
                {
                    if (body != currentBody.bodyName)
                    {
                        MapView.MapCamera.SetTarget(body);
                    }
                }
            }
            return currentBody.bodyName;
        }

        public static ConfigNode DrawObjectSelector<T>(ConfigNode sourceNode, ref int selectedObjIndex, ref String objString, ref Vector2 objListPos, Rect placementBase, ref Rect placement, ConfigNode.Value filter = null)
        {
            List<ConfigNode> nodeList;
            if (filter != null)
            {
                nodeList = sourceNode.GetNodes(ConfigHelper.OBJECT_NODE, filter.name, filter.value).ToList();
            }
            else
            {
                nodeList = sourceNode.GetNodes().ToList();
            }

            string configName = ((ConfigName)Attribute.GetCustomAttribute(typeof(T), typeof(ConfigName))).Name;

            String[] objList = nodeList.Select(node=>node.GetValue(configName)).ToArray();
            float nodeHeight = placement.height;
            Rect selectBoxOutlineRect = GetRect(placementBase, ref placement);
            placement.height = nodeHeight - 1;
            Rect selectBoxRect = GetRect(placementBase, ref placement);
            placement.height = nodeList.Count;
            Rect selectBoxItemsRect = GetRect(placementBase, ref placement);

            placement.height = 1;
            Rect optButtonRect = GetRect(placementBase, ref placement);
            SplitRect(ref selectBoxRect, ref optButtonRect, (15f / 16));


            GUI.Box(selectBoxOutlineRect, "");
            selectBoxRect.x += 10;
            selectBoxRect.width -= 20;
            selectBoxRect.y += 10;
            selectBoxRect.height -= 20;

            selectBoxItemsRect.x = 0;
            selectBoxItemsRect.y = 0;
            if (nodeList.Count <= 3)
            {
                selectBoxItemsRect.width = selectBoxRect.width;
            }
            else
            {
                selectBoxItemsRect.width = selectBoxRect.width - 20;
            }

            objListPos = GUI.BeginScrollView(selectBoxRect, objListPos, selectBoxItemsRect);
            int oldselectedObjIndex = selectedObjIndex;
            if (selectedObjIndex == -1)
            {
                selectedObjIndex = 0;
            }
            selectedObjIndex = GUI.SelectionGrid(selectBoxItemsRect, selectedObjIndex, objList, 1);
            GUI.EndScrollView();
            placement.y += nodeHeight - 1;

            optButtonRect.x -= 5;
            optButtonRect.y += 10;
            if (nodeList.Count > 0)
            {
                if (GUI.Button(optButtonRect, UP_ARROW) && selectedObjIndex > 0)
                {
                    int moveIndex = selectedObjIndex;
                    ConfigNode item = nodeList[--selectedObjIndex];
                    nodeList.Remove(item);
                    nodeList.Add(item);
                    sourceNode.RemoveNode(item);
                    sourceNode.AddNode(item);
                    for (int i = moveIndex; i < nodeList.Count - 1; i++)
                    {
                        item = nodeList[moveIndex];
                        nodeList.Remove(item);
                        nodeList.Add(item);
                        sourceNode.RemoveNode(item);
                        sourceNode.AddNode(item);
                    }
                }
                optButtonRect.y += optButtonRect.height * (nodeHeight - 3);
                if (GUI.Button(optButtonRect, DOWN_ARROW) && selectedObjIndex < nodeList.Count - 1)
                {

                    ConfigNode item = nodeList[selectedObjIndex];
                    nodeList.Remove(item);
                    nodeList.Add(item);
                    sourceNode.RemoveNode(item);
                    sourceNode.AddNode(item);
                    int moveIndex = ++selectedObjIndex;
                    for (int i = moveIndex; i < nodeList.Count - 1; i++)
                    {
                        item = nodeList[moveIndex];
                        nodeList.Remove(item);
                        nodeList.Add(item);
                        sourceNode.RemoveNode(item);
                        sourceNode.AddNode(item);
                    }
                }
            }
            Rect listEditTextRect = GetRect(placementBase, ref placement);
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

            if (selectedObjIndex != oldselectedObjIndex && nodeList.Count > 0)
            {
                objString = nodeList[selectedObjIndex].GetValue(configName);
            }
            objString = GUI.TextField(listEditTextRect, objString);
            String name = objString;
            if (objString.Length > 0 && !objString.Contains(' ') && !nodeList.Exists(n => n.GetValue(configName) == name))
            {
                if (nodeList.Count > 0 && GUI.Button(listEditRect, "#"))
                {
                    nodeList[selectedObjIndex].SetValue(configName, objString, true);
                }
                if (GUI.Button(listAddRect, "+"))
                {
                    ConfigNode newNode = new ConfigNode(ConfigHelper.OBJECT_NODE);
                    newNode.SetValue(configName, objString, true);
                    if( filter != null)
                    {
                        newNode.SetValue(filter.name, filter.value, true);
                    }
                    nodeList.Add(newNode);
                    sourceNode.AddNode(newNode);
                }
            }
            else
            {
                listEditRect.width += listAddRect.width;
                GUI.Label(listEditRect, "Invalid Name!");
            }
            if (nodeList.Count > 0 && GUI.Button(listRemoveRect, "-"))
            {
                ConfigNode item = nodeList[selectedObjIndex];
                nodeList.Remove(item);
                sourceNode.RemoveNode(item);
                if (selectedObjIndex >= nodeList.Count)
                {
                    selectedObjIndex = nodeList.Count - 1;
                }
            }
            placement.y += 1 + spacingOffset;

            if (nodeList.Count == 0)
            {
                return null;
            }
            return nodeList[selectedObjIndex];
        }

        public static T DrawSelector<T>(List<T> objList, T selectedObj, float ratio, Rect placementBase, ref Rect placement)
        {
            int selectedIndex = objList.IndexOf(selectedObj);
            return DrawSelector<T>(objList, ref selectedIndex, ratio, placementBase, ref placement);
        }

        public static T DrawSelector<T>(List<T> objList, ref int selectedIndex, float ratio, Rect placementBase, ref Rect placement)
        {
            Rect leftRect = GUIHelper.GetRect(placementBase, ref placement);
            Rect centerRect = GUIHelper.GetRect(placementBase, ref placement);
            Rect rightRect = GUIHelper.GetRect(placementBase, ref placement);
            GUIHelper.SplitRect(ref leftRect, ref centerRect, 1f / (ratio));
            GUIHelper.SplitRect(ref centerRect, ref rightRect, (ratio - 2) / (ratio - 1));

            if (objList.Count > 1 && GUI.Button(leftRect, LEFT_ARROW))
            {
                selectedIndex--;
                if (selectedIndex < 0)
                {
                    selectedIndex = objList.Count - 1;
                }
            }
            if (objList.Count > 1 && GUI.Button(rightRect, RIGHT_ARROW))
            {
                selectedIndex++;
                if (selectedIndex >= objList.Count)
                {
                    selectedIndex = 0;
                }
            }
            T currentObj = default(T);
            if (selectedIndex < objList.Count)
            {
                currentObj = objList[selectedIndex];
                if (currentObj != null)
                {
                    GUIStyle gsCenter = new GUIStyle(GUI.skin.label);
                    gsCenter.alignment = TextAnchor.MiddleCenter;
                    GUI.Label(centerRect, currentObj.ToString(), gsCenter);
                }

            }
            placement.y += 1 + spacingOffset;
            return currentObj;
        }

        public static void DrawField(Rect placementBase, ref Rect placement, object obj, FieldInfo field, ConfigNode config)
        {
            if (!Attribute.IsDefined(field, typeof(GUIHidden)))
            {
                placement.y += spacingOffset;
                placement.height = 1;
                String value = config.GetValue(field.Name);
                String defaultValue = ConfigHelper.GetConfigValue(obj, field);
                if (value == null)
                {
                    if (defaultValue == null)
                    {
                        defaultValue = "";
                    }
                    value = defaultValue;
                }

                Rect labelRect = GUIHelper.GetRect(placementBase, ref placement);
                Rect fieldRect = GUIHelper.GetRect(placementBase, ref placement);
                GUIHelper.SplitRect(ref labelRect, ref fieldRect, valueRatio);
                String tooltipText = "";
                if (Attribute.IsDefined(field, typeof(TooltipAttribute)))
                {
                    TooltipAttribute tt = (TooltipAttribute)Attribute.GetCustomAttribute(field, typeof(TooltipAttribute));
                    tooltipText = tt.tooltip;
                }
                GUIStyle style = new GUIStyle(GUI.skin.label);
                GUIContent gc = new GUIContent(field.Name, tooltipText);

                Vector2 labelSize = style.CalcSize(gc);
                labelRect.width = Mathf.Min(labelSize.x, labelRect.width);
                GUI.Label(labelRect, gc);

                string newValue = value;
                if (field.FieldType.IsEnum)
                {
                    newValue = ComboBox(fieldRect, value, field.FieldType.GetFields().Where(
                        m => (m.IsLiteral) && !Attribute.IsDefined(m, typeof(EnumMask))).Select(m => m.Name).ToArray());
                }
                else
                {
                    GUIStyle fieldStyle = new GUIStyle(GUI.skin.textField);
                    if (value != "" && !ConfigHelper.CanParse(field, value))
                    {
                        fieldStyle.normal.textColor = Color.red;
                        fieldStyle.active.textColor = Color.red;
                        fieldStyle.focused.textColor = Color.red;
                        fieldStyle.hover.textColor = Color.red;
                    }
                    newValue = GUI.TextField(fieldRect, value, fieldStyle);
                }

                if (newValue != defaultValue && value != newValue)
                {
                    config.SetValue(field.Name, newValue, true);

                }
                else if (newValue == defaultValue && config.HasValue(field.Name))
                {
                    config.RemoveValue(field.Name);
                }
                placement.y += 1f;
            }
        }

        private static string ComboBox(Rect fieldRect, string value, string[] list)
        {
            GUIStyle gs = new GUIStyle(GUI.skin.textField);
            
            Rect fieldRectUp = new Rect(fieldRect);
            fieldRectUp.x += fieldRect.width - (2 * elementHeight);
            fieldRectUp.width = elementHeight;
            Rect fieldRectDown = new Rect(fieldRectUp);
            fieldRectDown.x += fieldRectDown.width;
            fieldRect.width -= 2 * fieldRectUp.width;
            GUI.Box(fieldRect, value, gs);

            if (GUI.Button(fieldRectUp, LEFT_ARROW, gs))
            {
                int index = Array.IndexOf(list, value);
                index--;
                if(index < 0)
                {
                    index = list.Length-1;
                }
                value = list[index];
            }
            if(GUI.Button(fieldRectDown, RIGHT_ARROW, gs))
            {
                int index = Array.IndexOf(list, value);
                index++;
                if (index >= list.Length)
                {
                    index = 0;
                }
                value = list[index];
            }
            return value;
        }

        
        public static void HandleGUI(object obj, FieldInfo objInfo, ConfigNode configNode, Rect placementBase, ref Rect placement)
        {

            var objfields = obj.GetType().GetFields(BindingFlags.Instance | BindingFlags.NonPublic).Where(
                    field => Attribute.IsDefined(field, typeof(ConfigItem)));
            foreach (FieldInfo field in objfields)
            {
                bool isNode = ConfigHelper.IsNode(field, configNode);
                bool isValueNode = ConfigHelper.IsValueNode(field);

                
                if (isNode || isValueNode)
                {
                    placement.y += spacingOffset;
                    bool isOptional = Attribute.IsDefined(field, typeof(Optional));

                    ConfigNode node = configNode.GetNode(field.Name);
                    GUIStyle gsRight = new GUIStyle(GUI.skin.label);
                    gsRight.alignment = TextAnchor.MiddleCenter;

                    
                    Rect boxRect = GUIHelper.GetRect(placementBase, ref placement, node, field.FieldType, field);
                    GUIStyle gs = new GUIStyle(GUI.skin.textField);
                    GUI.Box(boxRect, "", gs);
                    placement.height = 1;
                    placement.y += spacingOffset;

                    Rect boxPlacementBase = new Rect(placementBase);
                    boxPlacementBase.x += 10;
                    Rect boxPlacement = new Rect(placement);
                    boxPlacement.width -= 20;

                    Rect toggleRect = GUIHelper.GetRect(boxPlacementBase, ref boxPlacement);
                    Rect titleRect = GUIHelper.GetRect(boxPlacementBase, ref boxPlacement);
                    Rect fieldRect = GUIHelper.GetRect(placementBase, ref boxPlacement);
                    if (isValueNode)
                    {
                        GUIHelper.SplitRect(ref titleRect, ref fieldRect, valueRatio);
                    }
                    GUIHelper.SplitRect(ref toggleRect, ref titleRect, (1f / 16));

                    String tooltipText = "";
                    if (Attribute.IsDefined(field, typeof(TooltipAttribute)))
                    {
                        TooltipAttribute tt = (TooltipAttribute)Attribute.GetCustomAttribute(field, typeof(TooltipAttribute));
                        tooltipText = tt.tooltip;
                    }
                    GUIStyle style = new GUIStyle(GUI.skin.label);
                    GUIContent gc = new GUIContent(field.Name, tooltipText);

                    Vector2 labelSize = style.CalcSize(gc);
                    titleRect.width = Mathf.Min(labelSize.x, titleRect.width);
                    GUI.Label(titleRect, gc);

                    bool removeable = node == null ? false : true;
                    bool conditionsMet = ConfigHelper.ConditionsMet(field, objInfo, configNode);
                    if (conditionsMet)
                    {
                        if (isOptional || isValueNode)
                        {
                            String value = null;
                            String defaultValue = ConfigHelper.GetConfigValue(obj, field);
                            String valueField = "";
                            if (isValueNode)
                            {
                                valueField = field.FieldType.GetFields(BindingFlags.Instance | BindingFlags.NonPublic).First(
                                    f => Attribute.IsDefined(f, typeof(NodeValue))).Name;
                            }
                            String newValue = "";
                            if (isValueNode)
                            {
                                if (configNode.HasValue(field.Name))
                                {
                                    value = configNode.GetValue(field.Name);
                                }
                                else if (node != null && node.HasValue(valueField))
                                {
                                    value = node.GetValue(valueField);
                                }

                                if (value == null)
                                {
                                    if (defaultValue == null)
                                    {
                                        defaultValue = "";
                                    }
                                    value = defaultValue;
                                }

                                GUIStyle fieldStyle = new GUIStyle(GUI.skin.textField);
                                if (value != "" && !ConfigHelper.CanParse(field, value, node))
                                {
                                    fieldStyle.normal.textColor = Color.red;
                                    fieldStyle.active.textColor = Color.red;
                                    fieldStyle.focused.textColor = Color.red;
                                    fieldStyle.hover.textColor = Color.red;
                                }
                                newValue = GUI.TextField(fieldRect, value, fieldStyle);

                            }
                            bool toggle = removeable != GUI.Toggle(toggleRect, removeable, "");
                            if (toggle)
                            {
                                if (removeable)
                                {
                                    configNode.RemoveNode(field.Name);
                                    node = null;
                                }
                                else
                                {
                                    node = configNode.AddNode(new ConfigNode(field.Name));
                                    if (configNode.HasValue(field.Name))
                                    {
                                        configNode.RemoveValue(field.Name);
                                    }
                                }
                            }

                            if (isValueNode)
                            {
                                if ((newValue != defaultValue && value != newValue) || toggle)
                                {
                                    if (newValue != defaultValue)
                                    {
                                        if (node != null)
                                        {
                                            node.SetValue(valueField, newValue, true);
                                        }
                                        else
                                        {
                                            configNode.SetValue(field.Name, newValue, true);
                                        }
                                    }
                                    if (newValue == defaultValue)
                                    {
                                        if (node != null)
                                        {
                                            if (node.HasValue(valueField))
                                            {
                                                node.RemoveValue(valueField);
                                            }
                                        }
                                        else
                                        {
                                            if (configNode.HasValue(field.Name))
                                            {
                                                configNode.RemoveValue(field.Name);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else if (node == null)
                        {
                            node = configNode.AddNode(new ConfigNode(field.Name));
                        }
                        boxPlacement.y += 1f;
                        if (node != null)
                        {
                            object subObj = field.GetValue(obj);
                            if (subObj == null)
                            {
                                ConstructorInfo ctor = field.FieldType.GetConstructor(System.Type.EmptyTypes);
                                subObj = ctor.Invoke(null);
                            }

                            HandleGUI(subObj, field, node, boxPlacementBase, ref boxPlacement);

                        }
                        boxPlacement.y += spacingOffset;

                        placement.y = boxPlacement.y;
                        placement.x = boxPlacement.x;
                    }
                    else
                    {
                        if(configNode.HasNode(field.Name))
                        {
                            configNode.RemoveNode(field.Name);
                        }
                        if (configNode.HasValue(field.Name))
                        {
                            configNode.RemoveValue(field.Name);
                        }
                    }
                }
                else
                {
                    if (ConfigHelper.ConditionsMet(field, objInfo, configNode))
                    {
                        GUIHelper.DrawField(placementBase, ref placement, obj, field, configNode);
                    }
                    else if(configNode.HasValue(field.Name))
                    {
                        configNode.RemoveValue(field.Name);
                    }
                }
            }
            
        }

    }
}
