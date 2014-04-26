using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EveManager
{
    [KSPAddon(KSPAddon.Startup.Instantly, true)]
    public class GenericEVEManager<T> : EVEManager where T : IEVEObject, new()
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

        public static void Log(String message)
        {
            UnityEngine.Debug.Log(typeof(T).Name +": "+ message);
        }

    }

}
