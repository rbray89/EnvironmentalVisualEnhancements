using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using Utils;
using KSPAssets.Loaders;

namespace ShaderLoader
{
    [KSPAddon(KSPAddon.Startup.MainMenu, true)]
    public class ShaderLoaderClass : MonoBehaviour
    {
        static Dictionary<string, Shader> shaderDictionary = null;
        public delegate void OnLoaded();
        public static OnLoaded onLoaded;

        private void Start()
        {
            if (shaderDictionary == null)
                StartCoroutine(LoadWhenReady());
        }

        string ShaderBundleName()
        {
            var r = "EnvironmentalVisualEnhancements/eveshaders";

            if (Application.platform == RuntimePlatform.LinuxPlayer)
                r += "-linux";
            else if (Application.platform == RuntimePlatform.OSXPlayer)
                r += "-macosx";
            else
                r += "-windows";
            return r;
        }

        IEnumerator LoadWhenReady()
        {
            while (!AssetLoader.Ready) {
                yield return null;
            }
            var defs = AssetLoader.GetAssetDefinitionsWithType(ShaderBundleName(), "Shader");
            AssetLoader.LoadAssets(AssetLoaded, defs);
        }

        void AssetLoaded(AssetLoader.Loader loader)
        {
            KSPLog.print("[EVE] Loading assets - "+ loader.definitions.Length+" defs of "+ loader.objects .Length+ " objects");

            if (shaderDictionary == null) {
                // Add all other shaders
                shaderDictionary = new Dictionary<string, Shader>();
                Shader[] shaders = Resources.FindObjectsOfTypeAll<Shader>();
                foreach (Shader shader in shaders) {
                    shaderDictionary[shader.name] = shader;
                }
            }

            /* Seems KSP AssetLoader is currently buggy, see http://forum.kerbalspaceprogram.com/index.php?/topic/138973-the-assetbundle-name-cant-be-loaded/
            ** Only the first object is valid currently.
            ** Instead, we load the assets from the bundle directly.
            **
            for (int i = 0; i < loader.definitions.Length; i++) {
                var def = loader.definitions[i];
                UnityEngine.Object o = loader.objects[i];
                Debug.Log("  Object " + i + ": " + def.name + " : " + " " + def.type + " : " + def.ToString() + " : " + def.autoLoad + " o=" + o);
                Shader shader = o as Shader;
                if (shader != null) {
                    KSPLog.print("Loading shader " + shader.name);
                    shaderDictionary[shader.name] = shader;
                }
            }
            */

            for (var i=0; i<AssetLoader.LoadedBundleDefinitions.Count; ++i) {
                if (AssetLoader.LoadedBundleDefinitions[i].name == ShaderBundleName()) {
                    KSPLog.print("[EVE] Loading AssetBundle " + AssetLoader.LoadedBundleDefinitions[i].name);
                    var bundle = AssetLoader.LoadedBundles[i];
                    // No performance benefit from using ASync version of this,
                    // and sometimes it too only returns 1 shader (maybe same bug KSP hits?)
                    var shaders = bundle.LoadAllAssets<Shader>();
                    foreach (var shader in shaders) {
                        KSPLog.print("[EVE] Loading EVE shader " + shader.name);
                        shaderDictionary[shader.name] = shader;
                    }
                    if (onLoaded != null) onLoaded();
                    break;
                }
            }
        }

        public static Shader FindShader(string name)
        {
            if (shaderDictionary == null) {
                KSPLog.print("[EVE] Trying to find shader before assets loaded");
                return null;
            }
            if (shaderDictionary.ContainsKey(name))
            {
                return shaderDictionary[name];
            }
            KSPLog.print("[EVE] Could not find shader " + name);
            return null;
        }
    }
}
