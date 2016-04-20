using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using UnityEngine.Rendering;

namespace Utils
{
    public class OverlayRenderer: MonoBehaviour
    {
        private Material material;
        public Material Material { get { return material; } set {
                material = value;
                Renderer r = this.gameObject.GetComponent<Renderer>();
                if (r != null)
                {
                    if (material != null)
                    {
                        List<Material> materials = new List<Material>(r.sharedMaterials);
                        materials.Add(material);
                        r.sharedMaterials = materials.ToArray();
                    }
                    else
                    {
                        List<Material> materials = new List<Material>(r.sharedMaterials);
                        materials.Remove(material);
                        r.sharedMaterials = materials.ToArray();
                    }
                }
            } }

        public static void Add(GameObject go, Material material)
        {
            OverlayRenderer dr = go.GetComponents<OverlayRenderer>().FirstOrDefault(r => r.Material == material);
            if (dr == null)
            {
                //Debug.Log("r: " + go.name);
                Renderer r = go.GetComponent<Renderer>();
                if (r != null && r.GetType() != typeof(ParticleSystemRenderer))
                {
                    dr = go.AddComponent<OverlayRenderer>();
                    dr.Material = material;
                }
            }
        }

        public static void Remove(GameObject go, Material material)
        {
            OverlayRenderer dr = go.GetComponents<OverlayRenderer>().FirstOrDefault(r => r.Material == material);
            if (dr != null)
            {
                dr.Material = null;
                GameObject.DestroyImmediate(dr);
            }
        }
    }

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
                if (k.Key > (int)Tools.Queue.Transparent)
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
                if(k.Key > (int)Tools.Queue.Transparent)
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


        Renderer renderer;
        Material mat;
        public Material Material {
            set
            {
                mat = value;
                renderer = this.gameObject.GetComponent<Renderer>();
                
            } get { return mat; } }

        bool includeTransparent = false;
        public bool IncludeTransparent
        {
            set { includeTransparent = value; }
        }
        
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

                Material[] mats = renderer.sharedMaterials;
                for (int i = 0; i < mats.Length; i++)
                {
                    if (mats[i] != null && (includeTransparent || mats[i].renderQueue == (int)Tools.Queue.Geometry))
                    {
                        cb.AddRenderDraw(renderer, mat, i, mat.renderQueue);
                    }
                }
            }

        }

        public static void Add(GameObject go, Material material, bool includeTransparent = false)
        {

            DeferredRenderer dr = go.GetComponents<DeferredRenderer>().FirstOrDefault(r => r.Material == material);
            if (dr == null )
            {
                //Debug.Log("r: " + go.name);
                Renderer r = go.GetComponent<Renderer>();
                if (r != null && r.GetType() != typeof(ParticleSystemRenderer))
                {
                    dr = go.AddComponent<DeferredRenderer>();
                    dr.Material = material;
                    dr.IncludeTransparent = includeTransparent;
                }
            }
        }

        public static void Remove(GameObject go, Material material)
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
            foreach(Renderer r in this.gameObject.GetComponentsInChildren<Renderer>(true))
            {
                DeferredRenderer.Add(r.gameObject, mat);
            }
        }
    }

    public class MaterialPQS : PQSMod
    {
        Material material;
        bool updateOrigin = false;
        bool subPQS = false;
        bool isOcean = false;

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
                ChildPQS.isOcean = true;

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
                //ApplyToPQSCities(s);
            }
        }

        private void AddMaterial(Renderer r)
        {
            DeferredRenderer.Add(r.gameObject, material, isOcean);
        }

        private void RemoveMaterial(Renderer r)
        {
            DeferredRenderer.Remove(r.gameObject, material);
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

        public override void OnSphereStarted()
        {
            base.OnSphereStarted();

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

                PQSCity[] cities = sphere.GetComponentsInChildren<PQSCity>(true);
                foreach (PQSCity city in cities)
                {
                    foreach (Transform child in city.transform)
                    {
                        if (child != null)
                        {
                            ChildUpdater cu = child.gameObject.AddComponent<ChildUpdater>();
                            cu.Material = material;
                            cu.OnTransformChildrenChanged();
                        }
                    }
                }
            }
        }

        public override void OnQuadUpdate(PQ quad)
        {
            base.OnQuadUpdate(quad);
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

            RemoveFromPQSCities();
            if (this.sphere != null && this.sphere.quads != null)
            {
                foreach (PQ pq in this.sphere.quads)
                {
                    RemoveFromQuads(pq);
                }
                ChildUpdater[] cuArray = this.sphere.transform.GetComponentsInChildren<ChildUpdater>(true).Where(cu => cu.Material == material).ToArray();
                foreach(ChildUpdater cu in cuArray)
                {
                    GameObject.DestroyImmediate(cu);
                }
                DeferredRenderer[] drArray = (DeferredRenderer[])this.sphere.transform.GetComponentsInChildren<DeferredRenderer>(true).Where(cu => cu.Material == material).ToArray();
                foreach (DeferredRenderer dr in drArray)
                {
                    GameObject.DestroyImmediate(dr);
                }
            }
            this.sphere = null;
            this.enabled = false;
            this.transform.parent = null;
            GameEvents.OnPQSCityLoaded.Remove(PQSLoaded);
        }


        
    }
}
