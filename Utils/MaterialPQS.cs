using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using UnityEngine.Rendering;

namespace Utils
{
    public class DeferredRenderer : MonoBehaviour
    {
        private Dictionary<Camera, CommandBuffer> m_Cameras = new Dictionary<Camera, CommandBuffer>();
        Material mat;
        public Material Material {
            set
            {
                mat = value;
            } get { return mat; } }

        public void OnDisable()
        {
            foreach (var cam in m_Cameras)
            {
                if (cam.Key)
                {
                    Debug.Log("CB Removed from " + this.gameObject.name);
                    cam.Key.RemoveCommandBuffer(CameraEvent.AfterForwardOpaque, cam.Value);
                }
            }
        }
        
        public void OnWillRenderObject()
        {
            var act = gameObject.activeInHierarchy && enabled;
            if (!act)
            {
                OnDisable();
                return;
            }

            Camera cam = Camera.current;
            if (cam != null)
            {
                CommandBuffer buf = null;
                if (m_Cameras.ContainsKey(cam))
                {
                    buf = m_Cameras[cam];
                    buf.Clear();
                }
                else
                {
                    buf = new CommandBuffer();
                    buf.name = "Deferred Render";
                    m_Cameras[cam] = buf;

                    cam.AddCommandBuffer(CameraEvent.AfterForwardOpaque, buf);
                    
                }

                Renderer renderer = this.gameObject.GetComponent<Renderer>();
                
                for (int i = 0; i < renderer.materials.Length; i++)
                {
                    buf.DrawRenderer(renderer, mat, i);
                }
                
            }

        }
    }

        public class MaterialPQS : PQSMod
    {
        Material material;
        MaterialManager manager;
        String materialName = Guid.NewGuid().ToString();
        bool updateOrigin = false;
        bool subPQS = false;

        public void Update()
        {
            if (updateOrigin)
            {
                material.SetVector(ShaderProperties.PLANET_ORIGIN_PROPERTY, this.transform.parent.position);
            }
        }

        public Material Apply(CelestialBody cb, MaterialManager mat, Shader shader, bool updateOrigin, bool subPQS)
        {
            KSPLog.print("Applying PQS Material Manager!");
            material = new Material( shader);
            material.name = materialName;
            if (mat != null)
            {
                mat.ApplyMaterialProperties(material);
                manager = mat;
            }

            this.updateOrigin = updateOrigin;
            this.subPQS = subPQS;
            PQS pqs = null;
            if (cb != null && cb.pqsController != null)
            {
                pqs = cb.pqsController;
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

            if(subPQS && this.sphere != null && this.sphere.ChildSpheres != null && this.sphere.ChildSpheres.Length > 0)
            {
                GameObject go = new GameObject();
                MaterialPQS ChildPQS = go.AddComponent<MaterialPQS>();
                ChildPQS.updateOrigin = updateOrigin;
                ChildPQS.subPQS = false;
                
                pqs = this.sphere.ChildSpheres[0];
                if (pqs != null)
                {
                    ChildPQS.sphere = pqs;
                    ChildPQS.transform.parent = pqs.transform;
                    ChildPQS.requirements = PQS.ModiferRequirements.Default;
                    ChildPQS.modEnabled = true;
                    ChildPQS.order += 10;

                    ChildPQS.transform.localPosition = Vector3.zero;
                    ChildPQS.transform.localRotation = Quaternion.identity;
                    ChildPQS.transform.localScale = Vector3.one;
                    ChildPQS.material = material;
                }

                if (ChildPQS.sphere != null && ChildPQS.sphere.quads != null)
                    foreach (PQ pq in this.sphere.quads)
                    {
                        ApplyToQuadMaterials(pq);
                    }
            }
            
            return material;
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
        //    FixPQSCities();
        }

        public override void OnSphereActive()
        {
            base.OnSphereActive();
            FixPQSCities();
        }

        public void FixPQSCities()
        {
            if (subPQS)
            {
                PQSCity[] pqsCitys = this.sphere.GetComponentsInChildren<PQSCity>();

                foreach (PQSCity city in pqsCitys)
                {
                    Debug.Log("city: " + city.name);
                    foreach (Renderer r in city.GetComponentsInChildren<Renderer>(true))
                    {
                        DeferredRenderer dr = r.gameObject.GetComponent<DeferredRenderer>();
                        if (dr == null)
                        {
                            Debug.Log("r: " + r.name);
                            dr = r.gameObject.AddComponent<DeferredRenderer>();
                            dr.Material = material;
                        }

                    }

                }
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
