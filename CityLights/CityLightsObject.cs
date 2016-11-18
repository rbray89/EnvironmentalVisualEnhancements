using EVEManager;
using ShaderLoader;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using Terrain;
using UnityEngine;
using Utils;

namespace CityLights
{

    public class ScaledCityComponent : MonoBehaviour
    {
        Material shadowMat;
        public String GUID { get { return shadowMat.name; } }
        Light sunlight;

        internal void Apply(Material mat, Light light)
        {
            shadowMat = mat;
            sunlight = light;
        }

        internal void OnWillRenderObject()
        {
            shadowMat.SetVector(ShaderProperties.SUNDIR_PROPERTY, -sunlight.transform.forward);
        }
    }

    public class LocalCityComponent : MonoBehaviour
    {
        Material cityMat;
        Light sunLight;
        public String GUID { get { return cityMat.name; } }

        internal void Apply(Material mat, Light light)
        {
            cityMat = mat;
            sunLight = light;
        }

        internal void OnPreCull()
        {
            cityMat.SetVector(ShaderProperties.SUNDIR_PROPERTY, -sunLight.transform.forward);    
        }
    }

    public class CityLightsMaterial : MaterialManager
    {
#pragma warning disable 0169
#pragma warning disable 0414
        [ConfigItem, Index(1), ValueFilter("isClamped|format|type|alphaMask")]
        TextureWrapper _CityOverlayTex;
        [ConfigItem]
        float _CityOverlayDetailScale = 200f;
        [ConfigItem]
        TextureWrapper _CityDarkOverlayDetailTex;
        [ConfigItem]
        TextureWrapper _CityLightOverlayDetailTex;
    }

    

        public class CityLightsObject : IEVEObject
    {
        public override String ToString() { return body; }

#pragma warning disable 0649
        [ConfigItem, GUIHidden]
        string body;

        [ConfigItem]
        CityLightsMaterial cityLightsMaterial = null;
        Material scaledMat;
        Material macroMat;
        String materialName = Guid.NewGuid().ToString();
        GameObject mainMenuBody = null;
        MaterialPQS materialPQS;

        public void LoadConfigNode(ConfigNode node)
        {
            ConfigHelper.LoadObjectFromConfig(this, node);
        }

        public void Apply()
        {
            CelestialBody celestialBody = Tools.GetCelestialBody(body);
            if (celestialBody != null)
            {
                GameObject go = new GameObject();
                go.name = "EVE City Lights";
                materialPQS = go.AddComponent<MaterialPQS>();
                macroMat = materialPQS.Apply(celestialBody, cityLightsMaterial, ShaderLoaderClass.FindShader("EVE/TerrainCityLight"), true, false);
                macroMat.name = materialName;
                macroMat.renderQueue = (int)Tools.Queue.Geometry + 1;
            }
            Transform transform = Tools.GetScaledTransform(body);
            if (transform != null)
            {
                Renderer r = transform.GetComponent<Renderer>();
                if (r != null)
                {
                    scaledMat = new Material(ShaderLoaderClass.FindShader("EVE/PlanetCityLight"));
                   
                    cityLightsMaterial.ApplyMaterialProperties(scaledMat);
                    scaledMat.SetTexture("_MainTex", r.material.GetTexture("_MainTex"));
                    scaledMat.name = materialName;
                    scaledMat.renderQueue = (int)Tools.Queue.Geometry + 1;
                    OverlayRenderer.Add(r.gameObject, scaledMat);

                    ScaledCityComponent sc = transform.gameObject.AddComponent<ScaledCityComponent>();
                    FieldInfo field = typeof(Sun).GetFields(BindingFlags.Instance | BindingFlags.NonPublic).First(
                    f => f.Name == "scaledSunLight");
                    Light slight = (Light)field.GetValue(Sun.Instance);

                    sc.Apply(scaledMat, slight);
                }
            }

            
            LocalCityComponent lsc = FlightCamera.fetch.mainCamera.gameObject.AddComponent<LocalCityComponent>();
            Light light = Sun.Instance.GetComponent<Light>();
            lsc.Apply(macroMat, light);

            ApplyToMainMenu();

            GameEvents.onGameSceneLoadRequested.Add(SceneLoaded);
        }

        private void SceneLoaded(GameScenes scene)
        {
            if (scene == GameScenes.MAINMENU)
            {
                ApplyToMainMenu();
            }
        }

        private void ApplyToMainMenu()
        {
            if (HighLogic.LoadedScene == GameScenes.MAINMENU )
            {
                GameObject go = Tools.GetMainMenuObject(body);

                if (go != mainMenuBody && go != null)
                {
                    mainMenuBody = go;
                    Renderer r = mainMenuBody.GetComponent<Renderer>();
                    if (r != null)
                    {
                        scaledMat.SetTexture("_MainTex", r.material.GetTexture("_MainTex"));
                        Light sunlight = GameObject.FindObjectsOfType<Light>().Last(l => l.isActiveAndEnabled);
                        DeferredRenderer.Add(r.gameObject, scaledMat);

                        if (mainMenuBody.name.EndsWith("(Clone)")) {
                            // There is a race condition with Kopernicus. Sometimes, it
                            // will have cloned a body that already had clouds. Hide old clouds.
                            for (var c = 0; c < mainMenuBody.transform.childCount; ++c) {
                                var child = mainMenuBody.transform.GetChild(c).gameObject;
                                if (child.name.StartsWith("EVE City Lights") && child.name.EndsWith("(Clone)"))
                                    child.SetActive(false);
                            }
                        }

                        ScaledCityComponent sc = r.gameObject.AddComponent<ScaledCityComponent>();
                        sc.Apply(scaledMat, sunlight);

                        CityLightsManager.Log("Applied to main Menu");
                    }
                }
                else if(go == null)
                {
                    CityLightsManager.Log("Cannot Find to apply to main Menu!");
                }
                else if (mainMenuBody == go)
                {
                    CityLightsManager.Log("Already Applied to main Menu!");
                }
            }
        }

        public void Remove()
        {
            CelestialBody celestialBody = Tools.GetCelestialBody(body);
            CityLightsManager.Log("Removing City Lights obj");
            Transform transform = Tools.GetScaledTransform(body);
            if (transform != null)
            {

                CityLightsManager.Log("Removing scaled obj");
                OverlayRenderer.Remove(transform.gameObject, scaledMat);
                
                GameObject.DestroyImmediate(transform.gameObject.GetComponents<ScaledCityComponent>().First(sc => sc.GUID == materialName));

                LocalCityComponent lc = FlightCamera.fetch.mainCamera.gameObject.GetComponents<LocalCityComponent>().FirstOrDefault(sc => sc.GUID == materialName);
                if (lc != null)
                {
                    GameObject.DestroyImmediate(lc);
                }
            }
            if(mainMenuBody != null)
            {
                GameObject.DestroyImmediate(mainMenuBody.GetComponents<ScaledCityComponent>().First(sc => sc.GUID == materialName));
            }
            materialPQS.Remove();

            GameEvents.onGameSceneLoadRequested.Remove(SceneLoaded);
            GameObject.DestroyImmediate(materialPQS);
        }
    }

}
