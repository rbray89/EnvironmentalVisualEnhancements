
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
        [Persistent, ValueFilter("isClamped|format|type|alphaMask")]
        TextureWrapper _CityOverlayTex;
        [Persistent]
        float _CityOverlayDetailScale = 200f;
        [Persistent]
        TextureWrapper _CityDarkOverlayDetailTex;
        [Persistent]
        TextureWrapper _CityLightOverlayDetailTex;
    }

    

        public class CityLightsObject : IEVEObject
    {
        public override String ToString() { return body; }

#pragma warning disable 0649
        [Persistent, GUIHidden]
        string body;

        [Persistent]
        CityLightsMaterial cityLightsMaterial = null;
        Material scaledMat;
        Material macroMat;
        String materialName = Guid.NewGuid().ToString();
        GameObject mainMenuBody = null;
        MaterialPQS materialPQS;
        SceneChangeEvent onSceneChange;

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
                macroMat = new Material(ShaderLoaderClass.FindShader("EVE/TerrainCityLight"));
                cityLightsMaterial.ApplyMaterialProperties(macroMat);
                materialPQS.Apply(celestialBody, macroMat);
            }
            Transform transform = Tools.GetScaledTransform(body);
            if (transform != null)
            {
                MeshRenderer mr = (MeshRenderer)transform.GetComponent(typeof(MeshRenderer));
                if (mr != null)
                {
                    scaledMat = new Material(ShaderLoaderClass.FindShader("EVE/PlanetCityLight"));
                   
                    cityLightsMaterial.ApplyMaterialProperties(scaledMat);
                    scaledMat.SetTexture("_MainTex", mr.material.GetTexture("_MainTex"));
                    scaledMat.name = materialName;
                    List<Material> materials = new List<Material>(mr.materials);
                    materials.Add(scaledMat);
                    mr.materials = materials.ToArray();
                    
                }
            }
            ApplyToMainMenu();
            onSceneChange = new SceneChangeEvent(SceneLoaded);
            EVEManagerClass.OnSceneChange += onSceneChange;
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
                    MeshRenderer mr = (MeshRenderer)mainMenuBody.GetComponent(typeof(MeshRenderer));
                    if (mr != null)
                    {
                        scaledMat.SetTexture("_MainTex", mr.material.GetTexture("_MainTex"));
                        scaledMat.name = materialName;
                        List<Material> materials = new List<Material>(mr.materials);
                        materials.Add(scaledMat);
                        mr.materials = materials.ToArray();

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
                MeshRenderer mr = (MeshRenderer)transform.GetComponent(typeof(MeshRenderer));
                if (mr != null)
                {
                    List<Material> materials = new List<Material>(mr.materials);
                    materials.Remove(materials.Find(mat => mat.name.Contains(materialName)));
                    mr.materials = materials.ToArray();
                }
            }
            if(mainMenuBody != null)
            {
                MeshRenderer mr = (MeshRenderer)mainMenuBody.GetComponent(typeof(MeshRenderer));
                if (mr != null)
                {
                    List<Material> materials = new List<Material>(mr.materials);
                    materials.Remove(materials.Find(mat => mat.name.Contains(materialName)));
                    mr.materials = materials.ToArray();
                }
            }
            materialPQS.Remove();
            EVEManagerClass.OnSceneChange -= onSceneChange;
            GameObject.DestroyImmediate(materialPQS);
        }
    }

}
