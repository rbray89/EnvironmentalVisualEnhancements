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
        protected static bool Initialized = false;
        protected static List<T> ObjectList = new List<T>();
        protected static UrlDir.UrlConfig[] configs;

        public virtual void GenerateGUI(){}
        public virtual void Setup()
        {
            if (!Initialized)
            {
                Initialized = true;
                Managers.Add(this);
                LoadConfig();
            }
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

        private void HandleGUI(object obj, FieldInfo field, ref Vector2 guiStart)
        {
            if(field.FieldType == typeof(String))
            {
                GUI.Label(new Rect(guiStart.x, guiStart.y, 50, 25), field.Name);
                GUI.TextField(new Rect(guiStart.x + 55, guiStart.y, 50, 25), field.GetValue(obj).ToString());
                guiStart.y += 30;
            }
            else if (field.FieldType == typeof(Vector3))
            {

            }
            else if (field.FieldType == typeof(Color))
            {

            }
            else if (field.FieldType == typeof(float))
            {
                GUI.Label(new Rect(guiStart.x, guiStart.y, 50, 25), field.Name);
                GUI.TextField(new Rect(guiStart.x+55, guiStart.y, 50, 25), field.GetValue(obj).ToString());
                guiStart.y += 30;
            }
            else
            {
                var objfields = field.FieldType.GetFields(BindingFlags.Instance | BindingFlags.NonPublic).Where(
                f => Attribute.IsDefined(f, typeof(Persistent)));
                foreach (FieldInfo fi in objfields)
                {
                    HandleGUI(field.GetValue(obj), fi, ref guiStart);
                }
            }
        }

        public override void DrawGUI()
        {
            Vector2 place = new Vector2(15, 25);
            var fields = this.GetType().GetFields(BindingFlags.Instance | BindingFlags.NonPublic).Where(
                field => Attribute.IsDefined(field, typeof(Persistent)));
            foreach(FieldInfo fi in fields)
            {
                Log(fi.Name +" = "+ fi.GetValue(this).ToString());
            }
            foreach(T obj in ObjectList)
            {
                var objfields = obj.GetType().GetFields(BindingFlags.Instance | BindingFlags.NonPublic).Where(
                field => Attribute.IsDefined(field, typeof(Persistent)));
                foreach (FieldInfo fi in objfields)
                {
                    HandleGUI(obj, fi, ref place);
                }
            }
        }

        internal void Awake()
        {
        }

        internal void Update()
        {
        }

        public new static void Log(String message)
        {
            UnityEngine.Debug.Log(typeof(T).Name + ": " + message);
        }
    }

}
