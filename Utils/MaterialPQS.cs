using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using UnityEngine.Rendering;

namespace Utils
{
    internal class DeferredCameraBuffer: MonoBehaviour
    {
        SortedDictionary<int, CommandBuffer> buffers = new SortedDictionary<int, CommandBuffer>();

        Camera camera = null;

        void Start()
        {
            if (camera == null)
            {
                camera = GetComponent<Camera>();
            }
        }

        private void OnPreCull()
        {
            Start();
            foreach (KeyValuePair<int, CommandBuffer> k in buffers)
            {
                k.Value.Clear();
                if(FlightGlobals.currentMainBody != null)
                k.Value.SetGlobalVector(ShaderProperties.PLANET_ORIGIN_PROPERTY, FlightGlobals.currentMainBody.bodyTransform.position);
            }
        }

        private void OnPreRender()
        {
            Start();
            foreach (KeyValuePair<int, CommandBuffer> k in buffers)
            {
                if (k.Key > 3000)
                {
                    camera.AddCommandBuffer(CameraEvent.AfterForwardAlpha, k.Value);
                }
                else
                {
                    camera.AddCommandBuffer(CameraEvent.AfterForwardOpaque, k.Value);
                }
            }
        }

        void OnPostRender()
        {
            Start();
            foreach (KeyValuePair<int, CommandBuffer> k in buffers)
            {
                if(k.Key > 3000)
                {
                    camera.RemoveCommandBuffer(CameraEvent.AfterForwardAlpha, k.Value);
                }
                else
                {
                    camera.RemoveCommandBuffer(CameraEvent.AfterForwardOpaque, k.Value);
                }
            }
        }

        internal void AddRenderDraw(Renderer renderer, Material mat, int i, int renderQueue)
        {
            if (!buffers.ContainsKey(renderQueue))
            {
                buffers.Add(renderQueue, new CommandBuffer());
            }
            CommandBuffer cb = buffers[renderQueue];
            cb.DrawRenderer(renderer, mat, i);
        }
    }

    public class DeferredRenderer : MonoBehaviour
    {
        private static Dictionary<Camera, DeferredCameraBuffer> m_Cameras = new Dictionary<Camera, DeferredCameraBuffer>();

        Material mat;
        public Material Material {
            set
            {
                mat = value;
            } get { return mat; } }


        
        public void OnWillRenderObject()
        {
            var act = gameObject.activeInHierarchy;
            if (!act)
            {
                return;
            }
            
            Camera cam = Camera.current;
            DeferredCameraBuffer cb = null;
            if (cam != null)
            {
                if (m_Cameras.ContainsKey(cam))
                {
                    cb = m_Cameras[cam];
                }
                else
                {
                    cb = m_Cameras[cam] = cam.gameObject.AddComponent< DeferredCameraBuffer>();
                }

                Renderer renderer = this.gameObject.GetComponent<Renderer>();
                
                for (int i = 0; i < renderer.materials.Length; i++)
                {
                    cb.AddRenderDraw(renderer, mat, i, mat.renderQueue);
                }
                
            }

        }

        public static void Add(GameObject go, Material material)
        {

            DeferredRenderer dr = go.GetComponents<DeferredRenderer>().FirstOrDefault(r => r.Material == material);
            if (dr == null )
            {
                //Debug.Log("r: " + go.name);
                dr = go.AddComponent<DeferredRenderer>();
                dr.Material = material;
            }
        }

        public static void Remove(GameObject go, Material material )
        {
            DeferredRenderer dr = go.GetComponents<DeferredRenderer>().FirstOrDefault(r => r.Material == material);
            if (dr != null)
            {
                GameObject.DestroyImmediate(dr);
            }
        }
    }

    public class ChildUpdater : MonoBehaviour
    {
        Material mat;
        public Material Material
        {
            set
            {
                mat = value;
            }
            get { return mat; }
        }

        public void OnTransformChildrenChanged()
        {
            foreach(Renderer child in this.transform.gameObject.GetComponentsInChildren<Renderer>())
            {
                DeferredRenderer.Add(child.gameObject, mat);
            }
        }
    }

    public class MaterialPQS : PQSMod
    {
        Material material;
        MaterialManager manager;
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
            if (mat != null)
            {
                mat.ApplyMaterialProperties(material);
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
                ChildPQS.updateOrigin = false;
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
            GameEvents.OnPQSCityLoaded.Add(PQSLoaded);

            return material;
        }

        private void PQSLoaded(CelestialBody body, String s)
        {
            if (this.sphere != null && this.sphere == body.pqsController)
            {
                ApplyToPQSCities();
            }
        }

        private void AddMaterial(Renderer r)
        {
            //DeferredRenderer.Add(r.gameObject, material);
            List<Material> materials = new List<Material>(r.sharedMaterials);
            if (!materials.Exists(mat => mat == material))
            {
                materials.Add(material);
                r.sharedMaterials = materials.ToArray();
            }
        }

        private void RemoveMaterial(Renderer r)
        {
            //DeferredRenderer.Remove(r.gameObject, material);
            List<Material> materials = new List<Material>(r.sharedMaterials);
            if (materials.Exists(mat => mat == material))
            {
                materials.Remove(material);
                r.sharedMaterials = materials.ToArray();
            }
        }

        private void ApplyToQuadMaterials(PQ pq)
        {
            Renderer[] renderers = pq.GetComponentsInChildren<Renderer>();
            foreach (Renderer r in renderers)
            {
                AddMaterial(r);
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

        public override void OnSphereActive()
        {
            base.OnSphereActive();

            if (subPQS)
            {
                PQSLandControl landControl = transform.parent.GetComponentInChildren<PQSLandControl>();
                if (landControl != null)
                {
                    PQSLandControl.LandClassScatter[] scatters = landControl.scatters;
                    if (scatters != null)
                    {
                        foreach (PQSLandControl.LandClassScatter scatter in scatters)
                        {
                            GameObject s = (GameObject)scatter.GetType().GetField("scatterParent", BindingFlags.Instance | BindingFlags.NonPublic).GetValue(scatter);
                            if (s != null)
                            {
                                ChildUpdater cu = s.AddComponent<ChildUpdater>();
                                cu.Material = material;
                                cu.OnTransformChildrenChanged();
                            }
                        }
                    }
                }
            }
        }

        public override void OnQuadUpdate(PQ quad)
        {
            base.OnQuadUpdate(quad);
        }

        public void ApplyToPQSCities()
        {
            if (subPQS)
            {
                PQSCity[] pqsCitys = this.sphere.GetComponentsInChildren<PQSCity>();

                foreach (PQSCity city in pqsCitys)
                {
                    Debug.Log("city: " + city.name);
                    foreach (Renderer r in city.GetComponentsInChildren<Renderer>(true))
                    {
                        DeferredRenderer.Add(r.gameObject, material);
                    }
                }
            }
        }

        public void RemoveFromPQSCities()
        {
            if (subPQS)
            {
                PQSCity[] pqsCitys = this.sphere.GetComponentsInChildren<PQSCity>();

                foreach (PQSCity city in pqsCitys)
                {
                    foreach (Renderer r in city.GetComponentsInChildren<Renderer>(true))
                    {
                        DeferredRenderer.Remove(r.gameObject, material);
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
            RemoveFromPQSCities();
            GameEvents.OnPQSCityLoaded.Remove(PQSLoaded);
        }


        
    }
}
