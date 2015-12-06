using EVEManager;
using PQSManager;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using Utils;

namespace Terrain
{
    public class TerrainPQS : PQSMod
    {
        
        CelestialBody celestialBody = null;
        Shader originalTerrainShader = null;
        Shader originalPlanetShader;
        Shader originalOceanShader;

        GameObject OceanBacking = null;
        Material OceanBackingMaterial;
        Material OceanSurfaceMaterial;

        public override void OnSphereActive()
        {
            if (OceanBacking != null)
            {
                OceanBacking.SetActive(true);
            }
        }
        public override void OnSphereInactive()
        {
            if (OceanBacking != null)
            {
                OceanBacking.SetActive(false);
            }
        }
        
        protected void Update()
        {
            if (this.sphere.isActiveAndEnabled && celestialBody != null)
            {
                Vector3 sunDir = this.celestialBody.transform.InverseTransformDirection(Sun.Instance.sunDirection);
                this.celestialBody.pqsController.surfaceMaterial.SetVector(EVEManagerClass.SUNDIR_PROPERTY, sunDir);
                Vector3 planetOrigin = this.celestialBody.transform.position;
                this.celestialBody.pqsController.surfaceMaterial.SetVector(EVEManagerClass.PLANET_ORIGIN_PROPERTY, planetOrigin);
                if (OceanBackingMaterial != null)
                {
                    OceanBackingMaterial.SetVector(EVEManagerClass.PLANET_ORIGIN_PROPERTY, planetOrigin);
                    OceanSurfaceMaterial.SetVector(EVEManagerClass.PLANET_ORIGIN_PROPERTY, planetOrigin);
                }
            }
        }

        

        internal void Apply(string body, TerrainMaterial terrainMaterial, OceanMaterial oceanMaterial)
        {
            celestialBody = Tools.GetCelestialBody(body);
            PQS pqs = null;
            if (celestialBody != null && celestialBody.pqsController != null)
            {
                pqs = celestialBody.pqsController;
            }
            else
            {
                pqs = PQSManagerClass.GetPQS(body);
            }

            Transform transform = Tools.GetScaledTransform(body);

            if (pqs != null)
            {
                this.sphere = pqs;
                this.transform.parent = pqs.transform;
                this.requirements = PQS.ModiferRequirements.Default;
                this.modEnabled = true;
                this.order += 10;

                this.transform.localPosition = Vector3.zero;
                this.transform.localRotation = Quaternion.identity;
                this.transform.localScale = Vector3.one;

                //Scaled space
                MeshRenderer mr = (MeshRenderer)transform.GetComponent(typeof(MeshRenderer));
                if (mr != null)
                {
                    terrainMaterial.SaveTextures(mr.material);
                    originalPlanetShader = mr.material.shader;

                    TerrainManager.Log("planet shader: " + mr.material.shader);
                    mr.material.shader = TerrainManager.PlanetShader;
                    terrainMaterial.ApplyMaterialProperties(mr.material);

                }

                terrainMaterial.SaveTextures(pqs.surfaceMaterial);
                originalTerrainShader = pqs.surfaceMaterial.shader;
                TerrainManager.Log("Terrain Shader Name: " + originalTerrainShader.name);
                String[] keywords = pqs.surfaceMaterial.shaderKeywords;
                pqs.surfaceMaterial.shader = TerrainManager.TerrainShader;
                /*    foreach (String keyword in keywords)
                    {
                        pqs.surfaceMaterial.EnableKeyword(keyword);
                    }
                    */
                terrainMaterial.ApplyMaterialProperties(pqs.surfaceMaterial);

                if (oceanMaterial != null && pqs.ChildSpheres.Length > 0)
                {
                    PQS ocean = pqs.ChildSpheres[0];
                    OceanSurfaceMaterial = ocean.surfaceMaterial;

                    pqs.surfaceMaterial.EnableKeyword("OCEAN_ON");
                    mr.material.EnableKeyword("OCEAN_ON");

                    keywords = OceanSurfaceMaterial.shaderKeywords;
                    originalOceanShader = OceanSurfaceMaterial.shader;
                    TerrainManager.Log("Ocean Shader Name: " + originalOceanShader.name);
                    OceanSurfaceMaterial.shader = TerrainManager.OceanShader;
                  /*  foreach (String keyword in keywords)
                    {
                        OceanSurfaceMaterial.EnableKeyword(keyword);
                    }
                    */
                    terrainMaterial.ApplyMaterialProperties(OceanSurfaceMaterial);
                    oceanMaterial.ApplyMaterialProperties(OceanSurfaceMaterial);

                    PQSLandControl landControl = (PQSLandControl)pqs.transform.GetComponentInChildren(typeof(PQSLandControl));
                    if (landControl != null)
                    {
                        PQSLandControl.LandClass[] landClasses = landControl.landClasses;
                        if (landClasses != null)
                        {
                            PQSLandControl.LandClass lcBeach = landClasses.FirstOrDefault(lc => lc.landClassName == "BaseBeach");
                            PQSLandControl.LandClass lcOcean = landClasses.FirstOrDefault(lc => lc.landClassName == "Ocean Bottom");
                            if (lcBeach != null || lcOcean != null)
                            {
                                lcOcean.color = lcBeach.color;
                            }
                        }

                        /*

                    
                PQS ocean =
                sphere.ChildSpheres[0];
                GameObject go = new GameObject();
                FakeOceanPQS fakeOcean = go.AddComponent<FakeOceanPQS>();
                fakeOcean.Apply(ocean);


                        */



                    }

                    SimpleCube hp = new SimpleCube(2000, ref OceanBackingMaterial, TerrainManager.OceanBackingShader);
                    OceanBacking = hp.GameObject;

                    OceanBacking.transform.parent = FlightCamera.fetch.transform;
                    OceanBacking.transform.localPosition = Vector3.zero;
                    OceanBacking.transform.localScale = Vector3.one;
                    OceanBacking.layer = EVEManagerClass.MACRO_LAYER;
                    OceanBackingMaterial.SetFloat("_OceanRadius", (float)celestialBody.Radius);
                    terrainMaterial.ApplyMaterialProperties(OceanBackingMaterial);
                }
                else
                {
                    pqs.surfaceMaterial.DisableKeyword("OCEAN_ON");
                    mr.material.DisableKeyword("OCEAN_ON");
                }

                PQSMod_CelestialBodyTransform cbt = (PQSMod_CelestialBodyTransform)pqs.transform.GetComponentInChildren(typeof(PQSMod_CelestialBodyTransform));
                if (cbt != null)
                {
                    pqs.surfaceMaterial.SetFloat("_MainTexHandoverDist", (float)(1f / cbt.deactivateAltitude));
                    if (oceanMaterial != null && pqs.ChildSpheres.Length > 0)
                    {
                        PQS ocean = pqs.ChildSpheres[0];
                        OceanSurfaceMaterial.SetFloat("_MainTexHandoverDist", (float)(1f / cbt.deactivateAltitude));
                    }
                    pqs.surfaceMaterial.SetFloat("_OceanRadius", (float)celestialBody.Radius);
                }

            }


            this.OnSetup();
            pqs.EnableSphere();
        }

        internal void Remove()
        {
            this.sphere = null;
            this.enabled = false;
            this.transform.parent = null;
            if (OceanBacking != null)
            {
                GameObject.DestroyImmediate(OceanBacking);
                OceanBacking = null;
            }
        }
    }
}
