using System;
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
    }

    [KSPAddon(KSPAddon.Startup.Instantly, true)]
    public class GenericEVEManager<T> : EVEManagerClass where T : IEVEObject, new()
    {
        [Flags] protected enum ObjectType
        {
            NONE = 0,
            PLANET = 1,
            GLOBAL = 2,
            MULTIPLE = 4
        }
        protected virtual ObjectType objectType { get { return ObjectType.NONE; } }
        protected virtual String configName { get { return ""; } }
        protected static List<T> ObjectList = new List<T>();
        protected static UrlDir.UrlConfig[] configs;

        protected ConfigNode ConfigNode { get { return configNode; } }
        protected ConfigNode configNode;
        private static List<ConfigWrapper> ConfigFiles = new List<ConfigWrapper>();
        private static int selectedConfigIndex = 0;

        protected static Vector2 objListPos = Vector2.zero;
        protected static int selectedObjIndex = -1;
        protected static String objNameEditString = "";

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

        protected virtual void SingleSetup()
        {

        }

        public virtual void LoadConfig()
        {
            Log("Loading...");
            configs = GameDatabase.Instance.GetConfigs(configName);
            ConfigFiles.Clear();
            foreach(UrlDir.UrlConfig config in configs)
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

        private void HandleGUI(object obj, ConfigNode configNode, Rect placementBase, ref Rect placement)
        {
            /*
            var objfields = obj.GetType().GetFields(BindingFlags.Instance | BindingFlags.NonPublic).Where(
                    field => Attribute.IsDefined(field, typeof(Persistent)));
                    foreach (FieldInfo fi in objfields)
                        */
            /*if(field.FieldType == typeof(String))
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
             */
            
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
                        String value = configNode.GetValue(field.Name);
                        if(value == null)
                        {
                            value = ConfigNode.CreateConfigFromObject(obj, new ConfigNode("TMP")).GetValue(field.Name);
                            configNode.AddValue(field.Name, value);
                        }
                        
                        Rect labelRect = GUIHelper.GetSplitRect(placementBase, ref placement);
                        Rect fieldRect = GUIHelper.GetSplitRect(placementBase, ref placement);
                        GUIHelper.SplitRect(ref labelRect, ref fieldRect, 3f / 7);
                        GUI.Label(labelRect, field.Name);
                        value = GUI.TextField(fieldRect, value);
                        configNode.SetValue(field.Name, value);
                        placement.y++;
                    }
                }
                else
                {
                    bool isOptional = Attribute.IsDefined(field, typeof(Optional));
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

                    GUI.Label(titleRect, field.Name);
                    bool removeable = node == null ? false : true;
                    if (isOptional)
                    {
                        if(removeable != GUI.Toggle(toggleRect, removeable, ""))
                        {
                            if(removeable)
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
                    else if(node == null)
                    {
                        
                        node = configNode.AddNode(new ConfigNode(field.Name));
                    }
                    float height = boxPlacement.y + 1;
                    if(node != null)
                    {
                        height = boxPlacement.y + GUIHelper.GetFieldCount(node) + .25f;
                        boxPlacement.y++;

                        object subObj = field.GetValue(obj);
                        if(subObj == null)
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

        private T DrawNodeManagement(Rect placementBase, ref Rect placement, ConfigNode node, String body)
        {
            Rect applyRect = GUIHelper.GetSplitRect(placementBase, ref placement);

            T obj = default(T);
            if (ObjectList.Count > 0)
            {
                obj = ObjectList.First(o => o.Body == body);
            }
            
            if (obj == null && GUI.Button(applyRect, "Add"))
            {
                obj = new T();
                obj.LoadConfigNode(node.AddNode(new ConfigNode(body)), body);
                ObjectList.Add(obj);
            }
            else if (obj != null && GUI.Button(applyRect, "Remove"))
            {
                node.RemoveNode(body);
            }
            placement.y++;
            return obj;
        }

        public override void DrawGUI(Rect placementBase, Rect placement)
        {
            string body = null;
            T objEdit = default(T);
            
            ConfigWrapper selectedConfig = GUIHelper.DrawSelector<ConfigWrapper>(ConfigFiles, ref selectedConfigIndex, 16, placementBase, ref placement);

            DrawConfigManagement(placementBase, ref placement);

            if ((objectType & ObjectType.PLANET) == ObjectType.PLANET)
            {
                body = GUIHelper.DrawBodySelector(placementBase, ref placement);
                
            }

            if ((objectType & ObjectType.MULTIPLE) == ObjectType.MULTIPLE)
            {
                T removed = default(T);
                ConfigNode bodyNode;
                if(!selectedConfig.Node.HasNode(body))
                {
                    bodyNode = selectedConfig.Node.AddNode(body);
                }
                else
                {
                    bodyNode = selectedConfig.Node.GetNode(body);
                }
                List<T> list = ObjectList.Where(n => bodyNode.HasNodeID(n.ConfigNode.id)).ToList();
                objEdit = GUIHelper.DrawObjectSelector<T>(list, ref removed, ref selectedObjIndex, ref objNameEditString, ref objListPos, placementBase, ref placement);
                foreach(T item in list)
                {
                    if (ObjectList.Contains(item))
                    {
                        ObjectList.Remove(item);
                    }
                    ObjectList.Add(item);
                    if(item.ConfigNode == null)
                    {
                        item.LoadConfigNode(bodyNode.AddNode(objNameEditString), body);
                    }
                }
                if(removed != null)
                {
                    bodyNode.RemoveNode(removed.Name);
                }
            }
            else
            {
                objEdit = DrawNodeManagement(placementBase, ref placement, selectedConfig.Node, body);
            }

            if (this.configNode != null)
            {
                HandleGUI(this, this.configNode, placementBase, ref placement);
            }

            if (objEdit != null)
            {
                HandleGUI(objEdit, objEdit.ConfigNode, placementBase, ref placement);
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
