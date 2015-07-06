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

        private GameObject pqsTerrainContainer;
        private GameObject pqsOceanContainer;

        public override void OnSphereActive()
        {

        }
        public override void OnSphereInactive()
        {
            
        }
        
        protected void Update()
        {
            
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

            if (pqs != null)
            {
                this.sphere = pqs;
                this.transform.parent = pqs.transform;
                this.transform.localPosition = Vector3.zero;
                this.transform.localRotation = Quaternion.identity;
                this.transform.localScale = Vector3.one;
            }

            Transform transform = Tools.GetScaledTransform(body);
            Texture mainTexture = null;
            Texture bumpTexture = null;
            Texture steepTexture = null;
            Texture lowTexture = null;
            Texture highTexture = null;

            if (pqs != null)
            {
                MeshRenderer mr = (MeshRenderer)transform.GetComponent(typeof(MeshRenderer));
                if (mr != null)
                {
                    mainTexture = mr.material.mainTexture;
                    bumpTexture = mr.material.GetTexture("_BumpMap");
                    originalPlanetShader = mr.material.shader;

                    TerrainManager.Log("planet shader: " + mr.material.shader);
                    mr.material.shader = TerrainManager.PlanetShader;
                    terrainMaterial.ApplyMaterialProperties(mr.material);

                }

                steepTexture = pqs.surfaceMaterial.GetTexture("_steepTex");
                lowTexture = pqs.surfaceMaterial.GetTexture("_lowTex");
                highTexture = pqs.surfaceMaterial.GetTexture("_highTex ");
                originalTerrainShader = pqs.surfaceMaterial.shader;
                TerrainManager.Log("Terrain Shader Name: " + originalTerrainShader.name);
                String[] keywords = pqs.surfaceMaterial.shaderKeywords;
                pqs.surfaceMaterial.shader = TerrainManager.TerrainShader;
                foreach (String keyword in keywords)
                {
                    pqs.surfaceMaterial.EnableKeyword(keyword);
                }
                pqs.surfaceMaterial.mainTexture = mainTexture;
                pqs.surfaceMaterial.SetTexture("_BumpMap", bumpTexture);

                terrainMaterial.ApplyMaterialProperties(pqs.surfaceMaterial);

                if (!terrainMaterial.hasDetailVert)
                {
                    pqs.surfaceMaterial.SetTexture("_DetailVertTex", steepTexture);
                }
                if (!terrainMaterial.hasDetail)
                {
                    pqs.surfaceMaterial.SetTexture("_DetailTex", lowTexture);
                }
                if (oceanMaterial != null && pqs.ChildSpheres.Length > 0)
                {
                    PQS ocean = pqs.ChildSpheres[0];

                    pqsOceanContainer = new GameObject("PQSTangentAssigner");
                    pqsOceanContainer.transform.parent = ocean.transform;

                    keywords = ocean.surfaceMaterial.shaderKeywords;
                    originalOceanShader = ocean.surfaceMaterial.shader;
                    TerrainManager.Log("Ocean Shader Name: " + originalOceanShader.name);
                    ocean.surfaceMaterial.shader = TerrainManager.OceanShader;
                    foreach (String keyword in keywords)
                    {
                        ocean.surfaceMaterial.EnableKeyword(keyword);
                    }
                    ocean.surfaceMaterial.mainTexture = mainTexture;
                    oceanMaterial.ApplyMaterialProperties(ocean.surfaceMaterial);

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
                    }
                }

                PQSMod_CelestialBodyTransform cbt = (PQSMod_CelestialBodyTransform)pqs.transform.GetComponentInChildren(typeof(PQSMod_CelestialBodyTransform));
                if (cbt != null)
                {
                    pqs.surfaceMaterial.SetFloat("_MainTexHandoverDist", (float)(1f / cbt.deactivateAltitude));
                    if (oceanMaterial != null && pqs.ChildSpheres.Length > 0)
                    {
                        PQS ocean = pqs.ChildSpheres[0];
                        ocean.surfaceMaterial.SetFloat("_MainTexHandoverDist", (float)(1f / cbt.deactivateAltitude));
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
        }
    }
}
