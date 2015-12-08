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
    
    [KSPAddon(KSPAddon.Startup.Instantly, true)]
    public class GenericEVEManager<T> : EVEManagerClass where T : IEVEObject, new()
    {
        [Flags] protected enum ObjectType
        {
            NONE = 0,
            BODY = 1,
            GLOBAL = 2,
            MULTIPLE = 4,
            STATIC = 8
        }
        protected virtual ObjectType objectType { get { return ObjectType.NONE; } }
        protected virtual String configName { get { return ""; } }
        protected virtual GameScenes SceneLoad { get { return GameScenes.MAINMENU; } }
        protected virtual bool DelayedLoad { get { return true; } }

        protected static List<T> ObjectList = new List<T>();
        protected static UrlDir.UrlConfig[] configs;

        protected static bool spaceCenterReload = false;
        protected static bool hasLoaded = false;
        protected virtual bool sceneConfigLoad { get {
            bool load = !hasLoaded && HighLogic.LoadedScene == SceneLoad;
            if (spaceCenterReload && HighLogic.LoadedScene == GameScenes.SPACECENTER)
            {
                spaceCenterReload = false;
                load = true;
            }
            if (load)
            {
                hasLoaded = true;
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
            Managers.RemoveAll(item => item == null || item.GetType() == this.GetType());
            Managers.Add(this);
            if (sceneConfigLoad)
            {
                if (DelayedLoad)
                {
                    StartCoroutine(SetupDelay());
                }
                else
                {
                    Setup();
                }
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
                instance.LoadConfig();
                staticInitialized = true;
            }
        }

        protected virtual void SingleSetup()
        {

        }

        public virtual void LoadConfig()
        {
            
            Log("Loading...");
            configs = GameDatabase.Instance.GetConfigs(configName);
            ConfigFiles.Clear();
            foreach (UrlDir.UrlConfig config in configs)
            {
                ConfigFiles.Add(new ConfigWrapper(config));
            }
            Apply();
            
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
                        if ((objectType & ObjectType.BODY) == ObjectType.BODY)
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
                    else
                    {
                        ApplyConfigNode(node, node.name);
                    }
                }
            }
        }

        protected virtual void ApplyConfigNode(ConfigNode node, String name)
        {
            T newObject = new T();
            newObject.LoadConfigNode(node, name);
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

       
        private void HandleConfigGUI(ConfigNode objNode, Rect placementBase, ref Rect placement)
        {


            placement.height = ((placementBase.height - (placementBase.y)) / GUIHelper.elementHeight) - placement.y;
            Rect selectBoxOutlineRect = GUIHelper.GetRect(placementBase, ref placement);
            Rect selectBoxRect = selectBoxOutlineRect;
            placement.height = 0;
            Rect selectBoxItemsRect = new Rect();
            if (configNode != null)
            {
                selectBoxItemsRect = GUIHelper.GetRect(placementBase, ref placement, configNode, this.GetType(), null);
            }
            if (objNode != null)
            {
                selectBoxItemsRect = GUIHelper.GetRect(placementBase, ref placement, objNode, typeof(T), null);
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
                GUIHelper.HandleGUI(this, null, this.configNode, selectBoxItemsRect, ref placement);
            }

            if (objNode != null)
            {
                GUIHelper.HandleGUI(new T(), null, objNode, selectBoxItemsRect, ref placement);
            }
            GUI.EndScrollView();

        }

        private void DrawConfigManagement(Rect placementBase, ref Rect placement)
        {
            Rect applyRect = GUIHelper.GetRect(placementBase, ref placement);
            Rect saveRect = GUIHelper.GetRect(placementBase, ref placement);
            GUIHelper.SplitRect(ref applyRect, ref saveRect, 1f / 2);
            if(GUI.Button(applyRect, "Apply"))
            {
                this.Apply();
            }
            if (GUI.Button(saveRect, "Save"))
            {
                this.SaveConfig();
            }
            placement.y += 1 + GUIHelper.spacingOffset;
        }

        private ConfigNode DrawNodeManagement(Rect placementBase, ref Rect placement, ConfigNode node, String body)
        {
            Rect applyRect = GUIHelper.GetRect(placementBase, ref placement);

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
            placement.y += 1 + GUIHelper.spacingOffset;
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
                if ((objectType & ObjectType.BODY) == ObjectType.BODY)
                {
                    body = GUIHelper.DrawBodySelector(placementBase, ref placement);
                }
            }
            
            if (selectedConfig != null)
            {
                if ((objectType & ObjectType.MULTIPLE) == ObjectType.MULTIPLE)
                {
                    if ((objectType & ObjectType.BODY) == ObjectType.BODY)
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
                        placement.height = 5;
                        objNode = GUIHelper.DrawObjectSelector(bodyNode.nodes, ref selectedObjIndex, ref objNameEditString, ref objListPos, placementBase, ref placement);
                    }
                    else
                    {
                        placement.height = 5;
                        objNode = GUIHelper.DrawObjectSelector(selectedConfig.Node.nodes, ref selectedObjIndex, ref objNameEditString, ref objListPos, placementBase, ref placement);
                    }
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
                Rect textRect = GUIHelper.GetRect(placementBase, ref placement);
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
