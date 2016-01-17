using ShaderLoader;
using System.Collections.Generic;
using UnityEngine;
using System;
using EVEManager;
using Utils;
using System.Reflection;

namespace PartFX
{
    public class IVAWindowMaterial : MaterialManager
    {
#pragma warning disable 0169
#pragma warning disable 0414
        [ConfigItem]
        float _Clarity = .65f;
        [ConfigItem]
        Color _RearWindowColor = new Color(82,107,117,255);
        [ConfigItem]
        bool TRANSPARENT = false;

        public bool Transparent { get { return TRANSPARENT; } }

    }

    [ConfigName("partUrl")]
    public class IVAWindowObject : IEVEObject
    {

#pragma warning disable 0649
#pragma warning disable 0169
        [ConfigItem, GUIHidden]
        String partUrl;
        [ConfigItem]
        List<string> renderers;
        [ConfigItem]
        Vector3 offset = Vector3.zero;
        [ConfigItem]
        IVAWindowMaterial windowMaterial = null;

        ConfigNode moduleNode;

        public void LoadConfigNode(ConfigNode node)
        {
            ConfigHelper.LoadObjectFromConfig(this, node);
            moduleNode = new ConfigNode("MODULE");
            moduleNode.SetValue("name", typeof(ModuleIVAWindow).Name, true);
            node.CopyTo(moduleNode);
        }

        public void Apply()
        {
            Shader[] shaders = (Shader[]) Resources.FindObjectsOfTypeAll(typeof(Shader));
            foreach(Shader shader in shaders)
            {
            //    IVAWindowManager.Log("Shader: " + shader.name);
            }

            foreach (AvailablePart ap in PartLoader.LoadedPartsList)
            {
                if (ap.internalConfig.HasData)
                {
                    if (ap.partUrl == partUrl)
                    {
                        IVAWindowManager.Log("Found: " + ap.partUrl);
                        Part part = ap.partPrefab;
                        ModuleIVAWindow module = (ModuleIVAWindow)part.AddModule(typeof(ModuleIVAWindow).Name);
                        MethodInfo mI = typeof(PartModule).GetMethod("Awake", BindingFlags.NonPublic | BindingFlags.Instance);
                        mI.Invoke(module, null);
                        module.Load(moduleNode);
                        module.LoadConfigNode(moduleNode);
                        module.SetMaterial();
                        foreach (MeshRenderer mr in part.FindModelComponents<MeshRenderer>())
                        {
                            IVAWindowManager.Log("renderer: " + mr.name);
                            IVAWindowManager.Log("shader: " + mr.material.shader);
                        }
                    }
                }
            }
            Part[] parts = GameObject.FindObjectsOfType<Part>();
            foreach(Part part in parts)
            {
                if (part.partInfo.partUrl == partUrl)
                {
                    ModuleIVAWindow module = (ModuleIVAWindow)part.AddModule(typeof(ModuleIVAWindow).Name);
                    MethodInfo mI = typeof(PartModule).GetMethod("Awake", BindingFlags.NonPublic | BindingFlags.Instance);
                    mI.Invoke(module, null);
                    module.Load(moduleNode);
                    module.OnStart(PartModule.StartState.None);
                    module.SetMaterial();
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
                        ModuleIVAWindow module = part.FindModuleImplementing<ModuleIVAWindow>();
                        module.Remove();
                        part.RemoveModule(module);
                    }
                }
            }
            Part[] parts = GameObject.FindObjectsOfType<Part>();
            foreach (Part part in parts)
            {
                if (part.partInfo.partUrl == partUrl)
                {
                    ModuleIVAWindow module = part.FindModuleImplementing<ModuleIVAWindow>();
                    module.Remove();
                    part.RemoveModule(module);
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

        private const string materialName = "IVAWindowOverlay";

#pragma warning disable 0649
#pragma warning disable 0169
        [ConfigItem]
        List<string> renderers;
        [ConfigItem]
        Vector3 offset = Vector3.zero;
        [ConfigItem]
        IVAWindowMaterial windowMaterial = null;

        public override void OnStart(StartState state)
        {
            if (state != StartState.Editor)
            {
                IVAWindowManager.Log("Start Part: " + part.name);
                IVAWindowManager.Log("State: " + state);
                LoadConfigNode();
               // SetMaterial();
            }
        }

        public void LateUpdate()
        {
            if (HighLogic.LoadedSceneIsFlight)
            {
               // IVAWindowManager.Log("Update Part: " + part.name);
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
                    part.internalModel.transform.Translate(offset);
                }
            }
        }

        public void SetMaterial()
        {
            IVAWindowManager.Log("--SetMaterial--");
            IVAWindowManager.Log(part.name);
            foreach (Renderer mr in part.FindModelComponents<Renderer>())
            {
                AddMaterial(mr);
            }
        }

        private void AddMaterial(Renderer mr)
        {
            List<Material> materials = new List<Material>(mr.materials);
            if (renderers.BinarySearch(mr.name) >= 0 && !materials.Exists(mat => mat.name.Contains(materialName)))
            {
                if (windowMaterial.Transparent)
                {
                    mr.material.shader = ShaderLoaderClass.FindShader("KSP/Alpha/Cutoff Bumped");
                }
                
                IVAWindowManager.Log("Adding to: " + mr.name);
                IVAWindowManager.Log("Shader: "+mr.material.shader.name);
                Material windowMat = new Material(WindowShader);
                windowMat.name = materialName;
                windowMat.mainTexture = mr.material.mainTexture;
                windowMat.SetTexture("_IVATex", IVARenderCam.RT);
                windowMaterial.ApplyMaterialProperties(windowMat);
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
            IVAWindowManager.Log("OnDestroy Part: " + part.name);
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
                ConfigStash[partUrl] = node;
            }
            else
            {
                ConfigNode loadNode = ConfigStash[partUrl];
                ConfigHelper.LoadObjectFromConfig(this, loadNode);
            }
        }

        public void Remove()
        {
            foreach (MeshRenderer mr in part.FindModelComponents<MeshRenderer>())
            {
                RemoveMaterial(mr);
            }
        }

        private void RemoveMaterial(MeshRenderer mr)
        {
            if (renderers.BinarySearch(mr.name) >= 0 && mr.materials.Length > 1)
            {
                IVAWindowManager.Log("Removing from: " + mr.name);
                List<Material> materials = new List<Material>(mr.materials);
                materials.Remove(materials.Find(mat => mat.name.Contains(materialName)));
                mr.materials = materials.ToArray();
            }
            }
    }
}
