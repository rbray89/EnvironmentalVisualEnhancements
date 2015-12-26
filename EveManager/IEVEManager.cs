using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using Utils;

namespace EVEManager
{
    [Flags]
    public enum ObjectType
    {
        NONE = 0,
        BODY = 1,
        GLOBAL = 2,
        MULTIPLE = 4,
        STATIC = 8
    }


    public abstract class EVEManagerBase
    {

        public static List<EVEManagerBase> GetManagers()
        {
            List<EVEManagerBase> objects = new List<EVEManagerBase>();
            foreach (Type type in
                AppDomain.CurrentDomain.GetAssemblies().SelectMany(a => a.GetTypes())
                .Where(m => m.IsClass && !m.IsAbstract && m.IsSubclassOf(typeof(EVEManagerBase))))
            {
                objects.Add((EVEManagerBase)Activator.CreateInstance(type, null));
            }
            return objects;
        }


        public abstract String configName { get; }
        public abstract ObjectType objectType { get; }
        public abstract bool DelayedLoad { get; }
        public abstract GameScenes SceneLoad { get; }
        public abstract int LoadOrder { get; }

        protected abstract UrlDir.UrlConfig[] Configs { get; set; }
        protected abstract List<ConfigWrapper> ConfigFiles { get; }
        public abstract void Setup();
        protected virtual void LoadConfig()
        {
            ILog("Loading...");
            Configs = GameDatabase.Instance.GetConfigs(configName);
            ConfigFiles.Clear();
            foreach (UrlDir.UrlConfig config in Configs)
            {
                ILog(config.url);
                ConfigFiles.Add(new ConfigWrapper(config));
            }
            Apply();

        }
        public virtual void Apply()
        {
            Clean();
            foreach (UrlDir.UrlConfig config in Configs)
            {
                foreach (ConfigNode node in config.config.nodes)
                {
                    try
                    {
                        ApplyConfigNode(node);
                    }
                    catch(Exception e)
                    {
                        ILog("Unable to parse config node:\n" + node.ToString());
                        throw new UnityException("Unable to apply node!", e);
                    }
                }
            }
        }
        public virtual void SaveConfig()
        {
            ILog("Saving...");
            foreach (UrlDir.UrlConfig config in Configs)
            {
                config.parent.SaveConfigs();
            }
        }
        protected abstract void Clean();
        protected abstract void ApplyConfigNode(ConfigNode node);
        public abstract void DrawGUI(Rect placementBase, Rect placement);
        public virtual void ILog(String message)
        {
            UnityEngine.Debug.Log(this.GetType().Name + ": " + message);
        }
    }

}
