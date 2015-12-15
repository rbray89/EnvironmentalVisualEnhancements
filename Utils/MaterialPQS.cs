using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;

namespace Utils
{
    public class MaterialPQS : PQSMod
    {
        Material material;
        Material PQSMaterial;
        String materialName = Guid.NewGuid().ToString();


        public void Update()
        {
            material.SetVector(ShaderProperties.PLANET_ORIGIN_PROPERTY, this.transform.parent.position);
        }

        public void Apply(CelestialBody cb, Material mat)
        {
            KSPLog.print("Applying PQS Material Manager!");
            material = new Material( mat);
            material.name = materialName;

            PQS pqs = null;
            if (cb != null && cb.pqsController != null)
            {
                pqs = cb.pqsController;
                PQSMaterial = pqs.surfaceMaterial;
            }
            else
            {
                KSPLog.print("No PQS!");
            }
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
                
            }

            if (this.sphere != null && this.sphere.quads != null)
                foreach (PQ pq in this.sphere.quads)
                {
                    ApplyToQuadMaterials(pq);
                }
        }

        private void AddMaterial(MeshRenderer meshRenderer)
        {
            if (this.sphere.useSharedMaterial)
            {
                List<Material> materials = new List<Material>(meshRenderer.sharedMaterials);
                if (!materials.Exists(mat => mat.name.Contains(materialName)))
                {
                    materials.Add(material);
                    meshRenderer.sharedMaterials = materials.ToArray();
                }
            }
            else
            {
                List<Material> materials = new List<Material>(meshRenderer.materials);
                if (!materials.Exists(mat => mat.name.Contains(materialName)))
                {
                    materials.Add(material);
                    meshRenderer.materials = materials.ToArray();
                }
            }
        }

        private void RemoveMaterial(MeshRenderer mr)
        {
            if (this.sphere.useSharedMaterial)
            {
                List<Material> materials = new List<Material>(mr.sharedMaterials);
                materials.Remove(materials.Find(mat => mat.name.Contains(materialName)));
                mr.sharedMaterials = materials.ToArray();
            }
            else
            {
                List<Material> materials = new List<Material>(mr.materials);
                materials.Remove(materials.Find(mat => mat.name.Contains(materialName)));
                mr.materials = materials.ToArray();
            }
        }

        private void ApplyToQuadMaterials(PQ pq)
        {
            MeshRenderer[] renderers = pq.GetComponentsInChildren<MeshRenderer>();
            foreach (MeshRenderer mr in renderers)
            {
                AddMaterial(mr);
            }
        }

        public void RemoveFromQuads(PQ quad)
        {
            if (quad != null && this.sphere != null)
            {
                RemoveMaterial(quad.meshRenderer);
                if (quad.subNodes != null)
                {
                    foreach (PQ pq in quad.subNodes)
                    {
                        RemoveFromQuads(pq);
                    }
                }
            }
        }

        public override void OnQuadDestroy(PQ quad)
        {
            RemoveFromQuads(quad);
        }
        

        public override void OnQuadCreate(PQ quad)
        {
            if (quad.sphereRoot == this.sphere)
            {
                AddMaterial(quad.meshRenderer);
            }
        }

        public void Remove()
        {
            KSPLog.print("Removing PQS Material Manager!");
            if(this.sphere != null && this.sphere.quads != null)
                foreach (PQ pq in this.sphere.quads)
                {
                    RemoveFromQuads(pq);
                }
            this.sphere = null;
            this.enabled = false;
            this.transform.parent = null;
        }


        
    }
}
