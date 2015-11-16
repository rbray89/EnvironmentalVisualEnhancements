using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using Utils;

namespace EVEManager
{
    public class Optional : System.Attribute
    {
        public String Field;
        public object Value;
        bool nullCheck = false;
        public Optional()
        {
            Field = null;
        }
        public Optional(String field)
        {
            Field = field;
            nullCheck = true;
        }
        public Optional(String field, object value)
        {
            Field = field;
            Value = value;
        }

        public bool isActive(ConfigNode node)
        {
            if(nullCheck)
            {
                return node.HasNode(Field);
            }
            else
            {
                if (Field != null)
                {
                    return node.GetValue(Field) == Value.ToString();
                }
                else
                {
                    return true;
                }
            }
        }
    }
    

    [KSPAddon(KSPAddon.Startup.Instantly, true)]
    public class GenericEVEManager<T> : EVEManagerClass where T : IEVEObject, new()
    {
        [Flags] protected enum ObjectType
        {
            NONE = 0,
            PLANET = 1,
            GLOBAL = 2,
            MULTIPLE = 4,
            STATIC = 8
        }
        protected virtual ObjectType objectType { get { return ObjectType.NONE; } }
        protected virtual String configName { get { return ""; } }
        protected virtual GameScenes SceneLoad { get { return GameScenes.MAINMENU; } }

        protected static List<T> ObjectList = new List<T>();
        protected static UrlDir.UrlConfig[] configs;

        protected static bool spaceCenterReload = true;
        protected virtual bool sceneConfigLoad { get {
            bool load = HighLogic.LoadedScene == GameScenes.MAINMENU;
            if (spaceCenterReload && HighLogic.LoadedScene == SceneLoad)
            {
                spaceCenterReload = false;
                load = true;
            }
            return load; } }
        protected ConfigNode ConfigNode { get { return configNode; } }
        protected ConfigNode configNode;
        private static List<ConfigWrapper> ConfigFiles = new List<ConfigWrapper>();
        private static int selectedConfigIndex = 0;


        protected static Vector2 configListPos = Vector2.zero;
        protected static Vector2 objListPos = Vector2.zero;
        protected static int selectedObjIndex = -1;
        protected static String objNameEditString = "";

        public virtual void GenerateGUI(){}
        private static bool staticInitialized = false;

        internal void Awake()
        {
            KSPLog.print(configName + " " + SceneLoad);
            if (sceneLoad)
            {
                StartCoroutine(SetupDelay());
            }
        }

        IEnumerator SetupDelay()
        {
            yield return new WaitForFixedUpdate();
            Setup();
        }

        public virtual void Setup()
        {
            if ((ObjectType.STATIC & objectType) != ObjectType.STATIC)
            {
                Managers.Add(this);
                Managers.RemoveAll(item => item == null);
                LoadConfig();
            }
            else
            {
                StaticSetup(this);
            }
        }

        public static void StaticSetup(GenericEVEManager<T> instance)
        {
            if (staticInitialized == false)
            {
                Managers.Add(instance);
                Managers.RemoveAll(item => item == null);
                instance.LoadConfig();
                staticInitialized = true;
            }
        }

        protected virtual void SingleSetup()
        {

        }

        public virtual void LoadConfig()
        {
            if (HighLogic.LoadedScene == GameScenes.MAINMENU)
            {
                Log("Loading...");
                configs = GameDatabase.Instance.GetConfigs(configName);
                ConfigFiles.Clear();
                foreach (UrlDir.UrlConfig config in configs)
                {
                    ConfigFiles.Add(new ConfigWrapper(config));
                }
            }
            if (sceneConfigLoad)
            {
                Apply();
            }
        }

        public virtual void Apply()
        {
            Clean();
            SingleSetup();
            foreach (UrlDir.UrlConfig config in configs)
            {
                foreach (ConfigNode node in config.config.nodes)
                {
                    if ((objectType & ObjectType.MULTIPLE) == ObjectType.MULTIPLE)
                    {
                        foreach (ConfigNode bodyNode in node.nodes)
                        {
                            ApplyConfigNode(bodyNode, node.name);
                        }
                    }
                    else
                    {
                        ApplyConfigNode(node, node.name);
                    }
                }
            }
        }

        protected virtual void ApplyConfigNode(ConfigNode node, String body)
        {
            T newObject = new T();
            newObject.LoadConfigNode(node, body);
            ObjectList.Add(newObject);
            newObject.Apply();
        }

        protected virtual void Clean()
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
                config.parent.SaveConfigs();
            }
        }

        private void HandleGUI(object obj, ConfigNode configNode, Rect placementBase, ref Rect placement)
        {

            var objfields = obj.GetType().GetFields(BindingFlags.Instance | BindingFlags.NonPublic).Where(
                    field => Attribute.IsDefined(field, typeof(Persistent)));
            foreach (FieldInfo field in objfields)
            {
                bool isNode = field.FieldType.GetFields(BindingFlags.Instance | BindingFlags.NonPublic).Where(
                    fi => Attribute.IsDefined(fi, typeof(Persistent))).Count() > 0 ? true : false;

                if(!isNode)
                {
                    if (field.Name != "body")
                    {
                        
                        GUIHelper.DrawField(placementBase, ref placement, obj, field, configNode);

                        placement.y++;
                    }
                }
                else
                {
                    bool isOptional = Attribute.IsDefined(field, typeof(Optional));
                    bool show = true;
                    if (isOptional)
                    {
                        Optional op = (Optional)Attribute.GetCustomAttribute(field, typeof(Optional));
                        show = op.isActive(configNode);
                    }
                    if (show)
                    {
                        ConfigNode node = configNode.GetNode(field.Name);
                        GUIStyle gsRight = new GUIStyle(GUI.skin.label);
                        gsRight.alignment = TextAnchor.MiddleCenter;

                        Rect boxRect = GUIHelper.GetSplitRect(placementBase, ref placement, node);
                        GUI.Box(boxRect, "");
                        placement.height = 1;

                        Rect boxPlacementBase = new Rect(placementBase);
                        boxPlacementBase.x += 10;
                        Rect boxPlacement = new Rect(placement);
                        boxPlacement.width -= 20;

                        Rect toggleRect = GUIHelper.GetSplitRect(boxPlacementBase, ref boxPlacement);
                        Rect titleRect = GUIHelper.GetSplitRect(boxPlacementBase, ref boxPlacement);
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
                        if (isOptional)
                        {
                            if (removeable != GUI.Toggle(toggleRect, removeable, ""))
                            {
                                if (removeable)
                                {
                                    configNode.RemoveNode(field.Name);
                                    node = null;
                                }
                                else
                                {
                                    node = configNode.AddNode(new ConfigNode(field.Name));
                                }
                            }
                        }
                        else if (node == null)
                        {

                            node = configNode.AddNode(new ConfigNode(field.Name));
                        }
                        float height = boxPlacement.y + 1;
                        if (node != null)
                        {
                            height = boxPlacement.y + GUIHelper.GetNodeHeightCount(node) + .25f;
                            boxPlacement.y++;

                            object subObj = field.GetValue(obj);
                            if (subObj == null)
                            {
                                ConstructorInfo ctor = field.FieldType.GetConstructor(System.Type.EmptyTypes);
                                subObj = ctor.Invoke(null);
                            }

                            HandleGUI(subObj, node, boxPlacementBase, ref boxPlacement);

                        }

                        placement.y = height;
                        placement.x = boxPlacement.x;
                    }
                }
            }
        }

        private void HandleConfigGUI(ConfigNode objNode, Rect placementBase, ref Rect placement)
        {

            float height = 30;
            placement.height = ((placementBase.height - (placementBase.y)) / height) - placement.y;
            Rect selectBoxOutlineRect = GUIHelper.GetSplitRect(placementBase, ref placement);
            Rect selectBoxRect = selectBoxOutlineRect;
            placement.height = 0;
            Rect selectBoxItemsRect = new Rect();
            if (configNode != null)
            {
                selectBoxItemsRect = GUIHelper.GetSplitRect(placementBase, ref placement, configNode);
            }
            if (objNode != null)
            {
                selectBoxItemsRect = GUIHelper.GetSplitRect(placementBase, ref placement, objNode);
            }

            
            GUI.Box(selectBoxOutlineRect, "");
            selectBoxRect.x += 10;
            selectBoxRect.width -= 20;
            selectBoxRect.y += 10;
            selectBoxRect.height -= 20;

            selectBoxItemsRect.x = 0;
            selectBoxItemsRect.y = 0;
            selectBoxItemsRect.width = selectBoxRect.width - 20;

            configListPos = GUI.BeginScrollView(selectBoxRect, configListPos, selectBoxItemsRect);
            placement.y = 0;
            placement.height = 1;
            if (this.configNode != null)
            {
                HandleGUI(this, this.configNode, selectBoxItemsRect, ref placement);
            }

            if (objNode != null)
            {
                HandleGUI(new T(), objNode, selectBoxItemsRect, ref placement);
            }
            GUI.EndScrollView();

        }

        private void DrawConfigManagement(Rect placementBase, ref Rect placement)
        {
            Rect applyRect = GUIHelper.GetSplitRect(placementBase, ref placement);
            Rect saveRect = GUIHelper.GetSplitRect(placementBase, ref placement);
            GUIHelper.SplitRect(ref applyRect, ref saveRect, 1f / 2);
            if(GUI.Button(applyRect, "Apply"))
            {
                this.Apply();
            }
            if (GUI.Button(saveRect, "Save"))
            {
                this.SaveConfig();
            }
            placement.y++;
        }

        private ConfigNode DrawNodeManagement(Rect placementBase, ref Rect placement, ConfigNode node, String body)
        {
            Rect applyRect = GUIHelper.GetSplitRect(placementBase, ref placement);

            ConfigNode objNode = node.GetNode(body);

            if (objNode == null && GUI.Button(applyRect, "Add"))
            {
                objNode = node.AddNode(body);
            }
            else if (objNode != null && GUI.Button(applyRect, "Remove"))
            {
                node.RemoveNode(body);
                objNode = null;
            }
            placement.y++;
            return objNode;
        }

        public override void DrawGUI(Rect placementBase, Rect placement)
        {
            string body = null;
            ConfigNode objNode = null;
            ConfigWrapper selectedConfig = null;
            if (ConfigFiles.Count > 0)
            {
                selectedConfig = GUIHelper.DrawSelector<ConfigWrapper>(ConfigFiles, ref selectedConfigIndex, 16, placementBase, ref placement);
                DrawConfigManagement(placementBase, ref placement);
                if ((objectType & ObjectType.PLANET) == ObjectType.PLANET)
                {
                    body = GUIHelper.DrawBodySelector(placementBase, ref placement);

                }
            }
            
            if (selectedConfig != null)
            {
                if ((objectType & ObjectType.MULTIPLE) == ObjectType.MULTIPLE)
                {
                    ConfigNode bodyNode;
                    if (!selectedConfig.Node.HasNode(body))
                    {
                        bodyNode = selectedConfig.Node.AddNode(body);
                    }
                    else
                    {
                        bodyNode = selectedConfig.Node.GetNode(body);
                    }

                    objNode = GUIHelper.DrawObjectSelector(bodyNode.nodes, ref selectedObjIndex, ref objNameEditString, ref objListPos, placementBase, ref placement);

                }
                else
                {
                    objNode = DrawNodeManagement(placementBase, ref placement, selectedConfig.Node, body);
                }

                HandleConfigGUI(objNode, placementBase, ref placement);
            }
            else
            {
                placement.height = 4;
                Rect textRect = GUIHelper.GetSplitRect(placementBase, ref placement);
                GUI.TextArea(textRect, "No config! Please add a config with the content of \""+this.configName+"{}\" to populate.");
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
