using ShaderLoader;
using System.Collections.Generic;
using UnityEngine;
using System;
using EVEManager;
using Utils;
using System.Reflection;

namespace PartFX
{

    [ConfigName("partUrl")]
    public class IVAWindowObject : IEVEObject
    {

#pragma warning disable 0649
#pragma warning disable 0169
        [ConfigItem, GUIHidden]
        String partUrl;
        [ConfigItem]
        List<string> renderers;

        ConfigNode moduleNode;

        public void LoadConfigNode(ConfigNode node)
        {
            ConfigHelper.LoadObjectFromConfig(this, node);
            moduleNode = new ConfigNode("MODULE");
            moduleNode.SetValue("name", "ModuleIVAWindow", true);
            node.CopyTo(moduleNode);
        }

        public void Apply()
        {
            foreach (AvailablePart ap in PartLoader.LoadedPartsList)
            {
                if (ap.internalConfig.HasData)
                {
                    IVAWindowManager.Log("URL: " + partUrl);
                    if (ap.partUrl == partUrl)
                    {
                        Part part = ap.partPrefab;
                        ModuleIVAWindow module = (ModuleIVAWindow)part.AddModule("ModuleIVAWindow");
                        MethodInfo mI = typeof(PartModule).GetMethod("Awake", BindingFlags.NonPublic | BindingFlags.Instance);
                        mI.Invoke(module, null);
                        module.Load(moduleNode);
                        module.LoadConfigNode(moduleNode);
                    }
                }
            }
        }

        public void Remove()
        {
            foreach (AvailablePart ap in PartLoader.LoadedPartsList)
            {
                if (ap.internalConfig.HasData)
                {
                    if (ap.partUrl == partUrl)
                    {
                        Part part = ap.partPrefab;
                        PartModule module = part.FindModuleImplementing<ModuleIVAWindow>();
                        part.RemoveModule(module);
                    }
                }
            }
        }
    }

    public class ModuleIVAWindow : PartModule
    {
        static Dictionary<String, ConfigNode> ConfigStash = new Dictionary<string, ConfigNode>();
        private static Shader windowShader = null;
        public static Shader WindowShader
        {
            get
            {
                if (windowShader == null)
                {
                    windowShader = ShaderLoaderClass.FindShader("EVE/RealWindows");
                }
                return windowShader;
            }
        }

#pragma warning disable 0649
#pragma warning disable 0169
        [ConfigItem, GUIHidden]
        String partUrl;
        [ConfigItem]
        List<string> renderers;
        
        public override void OnStart(StartState state)
        {
            if (state != StartState.Editor)
            {
                IVAWindowManager.Log("Start Part: " + part.name);
                IVAWindowManager.Log("State: " + state);
                LoadConfigNode();
                SetMaterial();
            }
        }

        public void Update()
        {
            if (HighLogic.LoadedSceneIsFlight)
            {
                IVAWindowManager.Log("Update Part: " + part.name);
                if (part.internalModel == null)
                {
                    part.CreateInternalModel();
                }
                if (part.internalModel != null)
                {
                    part.internalModel.enabled = true;
                    part.internalModel.SetVisible(true);
                    part.internalModel.transform.position = InternalSpace.WorldToInternal(part.transform.position);
                    part.internalModel.transform.rotation = InternalSpace.WorldToInternal(part.transform.rotation);
                    part.internalModel.transform.Rotate(90, 0, 180);
                }
            }
        }

        public void SetMaterial()
        {
            IVAWindowManager.Log("--SetMaterial--");
            IVAWindowManager.Log(part.name);
            foreach (MeshRenderer mr in part.FindModelComponents<MeshRenderer>())
            {
                AddMaterial(mr);
            }
        }

        private void AddMaterial(MeshRenderer mr)
        {
            IVAWindowManager.Log("material: " + mr.name);
            if (renderers.BinarySearch(mr.name) >= 0 && mr.materials.Length == 1)
            {
                IVAWindowManager.Log("Adding to: " + mr.name);
                List<Material> materials = new List<Material>(mr.materials);
                Material windowMat = new Material(WindowShader);
                windowMat.mainTexture = mr.material.mainTexture;
                windowMat.SetTexture("_IVATex", IVARenderCam.RT);
                windowMat.SetFloat("_Clarity", 1f);
                materials.Add(windowMat);
                mr.materials = materials.ToArray();
            }
        }

        public override void OnInactive()
        {
            IVAWindowManager.Log("Inactive Part: "+part.name);
            if (part.internalModel != null)
            {
                part.internalModel.enabled = false;
                part.internalModel.SetVisible(false);
            }
        }

        public void OnDestroy()
        {
            IVAWindowManager.Log("Destroy Part: " + part.name);
            if (part.internalModel != null)
            {
                part.internalModel.enabled = false;
                part.internalModel.SetVisible(false);
            }
        }
        

        public void LoadConfigNode(ConfigNode node = null)
        {
            string partUrl = this.part.partInfo.partUrl;
            if (node != null)
            {
                ConfigHelper.LoadObjectFromConfig(this, node);
                if (!ConfigStash.ContainsKey(partUrl))
                {
                    ConfigStash.Add(partUrl, node);
                }
            }
            else
            {
                ConfigNode loadNode = ConfigStash[partUrl];
                ConfigHelper.LoadObjectFromConfig(this, loadNode);
            }
        }

    }
}
