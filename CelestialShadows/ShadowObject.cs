using EVEManager;
using ShaderLoader;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using Utils;

namespace CelestialShadows
{
    
    public class ScaledShadowComponent : MonoBehaviour
    {
        Material shadowMat;
        CelestialBody body;
        List<CelestialBody> shadowList;
        public String GUID { get { return shadowMat.name; } }

        internal void Apply(Material mat, CelestialBody cb, List<CelestialBody> list)
        {
            shadowMat = mat;
            body = cb;
            shadowList = list;
        }

        internal void OnWillRenderObject()
        {
            if (HighLogic.LoadedScene != GameScenes.MAINMENU)
            {
                Matrix4x4 bodies = new Matrix4x4();
                int i = 0;
                foreach (CelestialBody cb in shadowList)
                {
                    bodies.SetRow(i, cb.scaledBody.transform.position);
                    bodies[i, 3] = (float)(ScaledSpace.InverseScaleFactor * cb.Radius);
                    i++;
                }
                if (shadowMat != null)
                {
                    shadowMat.SetVector("_SunPos", Sun.Instance.sun.scaledBody.transform.position);
                    shadowMat.SetMatrix("_ShadowBodies", bodies);
                }

                foreach (Transform child in body.scaledBody.transform)
                {
                    MeshRenderer cmr = child.GetComponent<MeshRenderer>();
                    if (cmr != null)
                    {
                        cmr.material.SetFloat("_SunRadius", (float)(ScaledSpace.InverseScaleFactor * Sun.Instance.sun.Radius));
                        cmr.material.SetVector("_SunPos", Sun.Instance.sun.scaledBody.transform.position);
                        cmr.material.SetMatrix("_ShadowBodies", bodies);
                    }
                }
            }
        }
    }

    public class LocalShadowComponent : MonoBehaviour
    {
        Material shadowMat;
        CelestialBody body;
        List<CelestialBody> shadowList;
        public String GUID { get { return shadowMat.name; } }

        internal void Apply(Material mat, CelestialBody cb, List<CelestialBody> list)
        {
            shadowMat = mat;
            body = cb;
            shadowList = list;
        }

        internal void OnPreCull()
        {
            if (HighLogic.LoadedScene != GameScenes.MAINMENU)
            {
                Matrix4x4 bodies = new Matrix4x4();
                int i = 0;
                foreach (CelestialBody cb in shadowList)
                {
                    bodies.SetRow(i, cb.transform.position);
                    bodies[i, 3] = (float)(cb.Radius);
                    i++;
                    if (i == 4)
                        break;
                }
                if (shadowMat != null)
                {
                    shadowMat.SetVector("_SunPos", Sun.Instance.sun.transform.position);
                    shadowMat.SetMatrix("_ShadowBodies", bodies);
                }

                foreach (Transform child in body.transform)
                {
                    MeshRenderer cmr = child.GetComponent<MeshRenderer>();
                    if (cmr != null)
                    {
                        cmr.material.SetFloat("_SunRadius", (float)(Sun.Instance.sun.Radius));
                        cmr.material.SetVector("_SunPos", Sun.Instance.sun.transform.position);
                        cmr.material.SetMatrix("_ShadowBodies", bodies);
                    }
                }
            }
        }
    }

    internal class ShadowMat : MaterialManager
    {
        float _SunRadius = 0f;
        Vector3 _SunPos = Vector3.zero;
        Matrix4x4 _ShadowBodies = Matrix4x4.zero;
    } 

    public class ShadowObject : IEVEObject
    {
#pragma warning disable 0649
        [ConfigItem, GUIHidden]
        private String body;
        /* [ConfigItem]
         ShadowMaterial shadowMaterial = null;
         */
        [ConfigItem]
        List<String> caster = null;
        [ConfigItem]
        bool hasSurface = true;

        String materialName = Guid.NewGuid().ToString();
        Material shadowMat;
        MaterialPQS materialPQS;
        Material localShadowMat;

        private static Shader shadowShader;
        private static Shader ShadowShader
        {
            get
            {
                if (shadowShader == null)
                {
                    shadowShader = ShaderLoaderClass.FindShader("EVE/PlanetLight");
                }
                return shadowShader;
            }
        }


        public void LoadConfigNode(ConfigNode node)
        {
            ConfigHelper.LoadObjectFromConfig(this, node);
        }

        public void Apply()
        {
            ShadowManager.Log("Applying to " + body);
            CelestialBody celestialBody = Tools.GetCelestialBody(body);
            
            Transform transform = Tools.GetScaledTransform(body);
            if (transform != null )
            {
                Renderer mr = transform.GetComponent<Renderer>();
                if (mr != null && hasSurface)
                {
                    shadowMat = new Material(ShadowShader);
                    GameObject go = new GameObject();
                    materialPQS = go.AddComponent<MaterialPQS>();
                    localShadowMat = materialPQS.Apply(celestialBody, new ShadowMat(), ShadowShader, false, true);

                    //shadowMaterial.ApplyMaterialProperties(shadowMat);
                    shadowMat.SetFloat("_SunRadius", (float)(ScaledSpace.InverseScaleFactor * Sun.Instance.sun.Radius));
                    localShadowMat.SetFloat("_SunRadius", (float)(Sun.Instance.sun.Radius));

                    shadowMat.name = materialName;
                    localShadowMat.name = materialName;
                    DeferredRenderer dr = mr.gameObject.AddComponent<DeferredRenderer>();
                    dr.Material = shadowMat;
                }
                
                ScaledShadowComponent sc = transform.gameObject.AddComponent<ScaledShadowComponent>();
                LocalShadowComponent lsc = FlightCamera.fetch.mainCamera.gameObject.AddComponent<LocalShadowComponent>();

                List<CelestialBody> casters = new List<CelestialBody>();
                if (caster != null)
                {
                    foreach (String b in caster)
                    {
                        casters.Add(Tools.GetCelestialBody(b));
                    }
                }
                sc.Apply(shadowMat, celestialBody, casters);
                lsc.Apply(localShadowMat, celestialBody, casters);
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
            if (HighLogic.LoadedScene == GameScenes.MAINMENU)
            {
                GameObject go = Tools.GetMainMenuObject(body);
                
                if(go != null)
                {
                    foreach (Transform child in go.transform)
                    {
                        MeshRenderer cmr = child.GetComponent<MeshRenderer>();
                        if (cmr != null)
                        {
                            cmr.material.SetMatrix("_ShadowBodies", Matrix4x4.zero);
                        }
                    }
                }
            }
        }


        public void Remove()
        {
            CelestialBody celestialBody = Tools.GetCelestialBody(body);
            ShadowManager.Log("Removing Shadow obj");
            Transform transform = Tools.GetScaledTransform(body);
            if (transform != null)
            {
                GameObject.DestroyImmediate(transform.gameObject.GetComponents<ScaledShadowComponent>().First(sc => sc.GUID == materialName));
                
                LocalShadowComponent lc = FlightCamera.fetch.mainCamera.gameObject.GetComponents<LocalShadowComponent>().FirstOrDefault(sc => sc.GUID == materialName);
                if (lc != null)
                {
                    GameObject.DestroyImmediate(lc);
                }
                
                DeferredRenderer dr = transform.GetComponents<DeferredRenderer>().FirstOrDefault(r => r.Material == shadowMat);
                if(dr != null)
                {
                    GameObject.DestroyImmediate(dr);
                }

            }
            GameEvents.onGameSceneLoadRequested.Remove(SceneLoaded);
        }
    }
}
