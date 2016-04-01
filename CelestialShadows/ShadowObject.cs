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

    public class ShadowMaterial : MaterialManager
    {
    }

    public class ShadowComponent : MonoBehaviour
    {
        Material shadowMat;
        internal void Apply(Material mat)
        {
            shadowMat = mat;
        }

        internal void OnPreCull()
        {
            shadowMat.SetVector("_SunPos", Sun.Instance.sun.scaledBody.transform.position);
            Matrix4x4 bodies = new Matrix4x4();

            CelestialBody celestialBody = Tools.GetCelestialBody("Mun");
            bodies.SetRow(0, celestialBody.scaledBody.transform.position);
            bodies[0, 3] = (float)(ScaledSpace.InverseScaleFactor * celestialBody.Radius);
            shadowMat.SetMatrix("_ShadowBodies", bodies);
            /*
            ShadowManager.Log("_SunPos: " + Sun.Instance.sun.scaledBody.transform.position);
            ShadowManager.Log("_SunRadius: " + (float)(ScaledSpace.InverseScaleFactor * Sun.Instance.sun.Radius));
            ShadowManager.Log("Mun: " + bodies.ToString());
            */
        }
    }

    public class ShadowObject : IEVEObject
    {
#pragma warning disable 0649
        [ConfigItem, GUIHidden]
        private String body;
       /* [ConfigItem]
        ShadowMaterial shadowMaterial = null;
        */

        String materialName = Guid.NewGuid().ToString();
        Material shadowMat;

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
            if (transform != null)
            {
                MeshRenderer mr = transform.GetComponent<MeshRenderer>();
                if (mr != null)
                {
                    shadowMat = new Material(ShadowShader);

                    //shadowMaterial.ApplyMaterialProperties(shadowMat);
                    shadowMat.SetFloat("_SunRadius", (float)(ScaledSpace.InverseScaleFactor * Sun.Instance.sun.Radius));
                    shadowMat.name = materialName;
                    List<Material> materials = new List<Material>(mr.materials);
                    materials.Add(shadowMat);
                    mr.materials = materials.ToArray();
                }
                ShadowComponent sc = ScaledCamera.Instance.galaxyCamera.gameObject.AddComponent<ShadowComponent>();
                sc.name = materialName;
                sc.Apply(shadowMat);
            }
           
        }

        

        public void Remove()
        {
            CelestialBody celestialBody = Tools.GetCelestialBody(body);
            ShadowManager.Log("Removing Shadow obj");
            Transform transform = Tools.GetScaledTransform(body);
            if (transform != null)
            {
                MeshRenderer mr = transform.GetComponent<MeshRenderer>();
                if (mr != null)
                {
                    List<Material> materials = new List<Material>(mr.materials);
                    materials.Remove(materials.Find(mat => mat.name.Contains(materialName)));
                    mr.materials = materials.ToArray();
                }
                GameObject.DestroyImmediate(ScaledCamera.Instance.galaxyCamera.gameObject.GetComponents<ShadowComponent>().First(sc => sc.name == materialName));
            }
            
        }
    }
}
