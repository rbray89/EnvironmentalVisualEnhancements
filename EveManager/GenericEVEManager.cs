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

    
    public abstract class GenericEVEManager<T> : EVEManagerBase where T : IEVEObject, new()
    {

        public override bool DelayedLoad { get { return true; } }
        public override GameScenes SceneLoad { get { return GameScenes.MAINMENU; } }
        public override int LoadOrder { get { return 100; } }
        
        public override String ToString() { return this.GetType().Name; }

        protected static List<T> ObjectList = new List<T>();
        protected static UrlDir.UrlConfig[] configs;
        protected override UrlDir.UrlConfig[] Configs { get { return configs; } set { configs = value; } }
        protected static List<ConfigWrapper> configFiles = new List<ConfigWrapper>();
        protected override List<ConfigWrapper> ConfigFiles { get { return configFiles; } }
        protected static GenericEVEManager<T> instance;
        protected static GenericEVEManager<T> Instance { get { return instance; } }

        protected static bool spaceCenterReload = false;
        protected static bool hasLoaded = false;
        
        protected ConfigNode ManagerConfigNode { get { return configNode; } }
        protected ConfigNode configNode;

        private static int selectedConfigIndex = 0;


        protected static Vector2 configListPos = Vector2.zero;
        protected static Vector2 objListPos = Vector2.zero;
        protected static int selectedObjIndex = -1;
        protected static String objNameEditString = "";

        public virtual void GenerateGUI(){}
        private static bool staticInitialized = false;

        public GenericEVEManager()
        {
            if (instance == null)
            {
                instance = this;
            }
            else
            {
                throw new UnityException("Attempted double instance!");
            }
        }

        public override void Setup()
        {
            
            if ((ObjectType.STATIC & objectType) != ObjectType.STATIC)
            {
                LoadConfig();
            }
            else
            {
                StaticSetup();
            }
        }

        protected static void StaticSetup()
        {
            if (staticInitialized == false)
            {
                instance.LoadConfig();
                staticInitialized = true;
            }
        }
        

        protected override void ApplyConfigNode(ConfigNode node)
        {
            T newObject = new T();
            newObject.LoadConfigNode(node);
            ObjectList.Add(newObject);
            newObject.Apply();
        }

        protected override void Clean()
        {
            foreach (T obj in ObjectList)
            {
                obj.Remove();
            }
            ObjectList.Clear();
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
                T obj = new T();
                GUIHelper.HandleGUI(obj, null, objNode, selectBoxItemsRect, ref placement);
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

            ConfigNode objNode = node.GetNode(ConfigHelper.OBJECT_NODE, ConfigHelper.BODY_FIELD, body);

            if (objNode == null && GUI.Button(applyRect, "Add"))
            {
                objNode = node.AddNode(ConfigHelper.OBJECT_NODE);
                objNode.SetValue(ConfigHelper.BODY_FIELD, body, true);
            }
            else if (objNode != null && GUI.Button(applyRect, "Remove"))
            {
                node.RemoveNode(objNode);
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
            }
            
            if (selectedConfig != null)
            {
                if ((objectType & ObjectType.BODY) == ObjectType.BODY)
                {
                    body = GUIHelper.DrawBodySelector(placementBase, ref placement);
                }
                if ((objectType & ObjectType.MULTIPLE) == ObjectType.MULTIPLE)
                {
                    if ((objectType & ObjectType.BODY) == ObjectType.BODY)
                    {
                        placement.height = 5;
                        objNode = GUIHelper.DrawObjectSelector<T>(selectedConfig.Node, ref selectedObjIndex, ref objNameEditString, ref objListPos, placementBase, ref placement, new ConfigNode.Value(ConfigHelper.BODY_FIELD, body));
                    }
                    else
                    {
                        placement.height = 5;
                        objNode = GUIHelper.DrawObjectSelector<T>(selectedConfig.Node, ref selectedObjIndex, ref objNameEditString, ref objListPos, placementBase, ref placement);
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

        public static void Log(String message)
        {
            Instance.ILog(message);
        }
    }

}
