using EVEManager;
using ShaderLoader;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Terrain;
using UnityEngine;
using Utils;

namespace CityLights
{
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
                materialPQS = go.AddComponent<MaterialPQS>();
                materialPQS.Apply(celestialBody, cityLightsMaterial, ShaderLoaderClass.FindShader("EVE/TerrainCityLight"), true, false);
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
                    DeferredRenderer.Add(r.gameObject, scaledMat);

                }
            }
            ApplyToMainMenu();

            GameEvents.onGameSceneLoadRequested.Add(SceneLoaded);
            if (HighLogic.LoadedScene == GameScenes.MAINMENU)
            {
                ApplyToMainMenu();
            }
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
                        DeferredRenderer.Add(r.gameObject, scaledMat);

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
                DeferredRenderer.Remove(transform.gameObject, scaledMat);
            }
            if(mainMenuBody != null)
            {
                Renderer r = mainMenuBody.GetComponent<Renderer>();
                if (r != null)
                {
                    List<Material> materials = new List<Material>(r.materials);
                    materials.Remove(materials.Find(mat => mat.name.Contains(materialName)));
                    r.materials = materials.ToArray();
                }
            }
            materialPQS.Remove();

            GameEvents.onGameSceneLoadRequested.Remove(SceneLoaded);
            GameObject.DestroyImmediate(materialPQS);
        }
    }

}
