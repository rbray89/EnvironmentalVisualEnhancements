using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using UnityEngine;
using System.IO;
using CommonUtils;

namespace Clouds
{
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class Clouds : MonoBehaviour
    {
        static List<CloudLayer> CloudLayers = new List<CloudLayer>();
        static ConfigNode config;
        static bool Loaded = false;

        static ParticleEmitter cloudParticleEmitter;
        static ParticleAnimator cloudParticleAnimator;
        static ParticleRenderer cloudParticleRenderer;
        static GameObject particleSystemGo;
        static bool spawned = false;

        static bool useEditor = false;
        static Vector2 ScrollPosLayerList = Vector2.zero;
        static int SelectedLayer = 0; 

        private void loadCloudLayers()
        {

            config = ConfigNode.Load(KSPUtil.ApplicationRootPath + "GameData/BoulderCo/Clouds/cloudLayers.cfg");
            ConfigNode[] cloudLayersConfigs = config.GetNodes("CLOUD_LAYER");

            foreach (ConfigNode node in cloudLayersConfigs)
            {
                String body = node.GetValue("body");
                Transform bodyTransform = null;
                try
                {
                    bodyTransform = ScaledSpace.Instance.scaledSpaceTransforms.Single(t => t.name == body);
                }
                catch
                {

                }
                if (bodyTransform != null)
                {
                    float radius = float.Parse(node.GetValue("radius"));

                    TextureSet mTexture = new TextureSet(node.GetNode("main_texture"), false);
                    TextureSet dTexture = new TextureSet(node.GetNode("detail_texture"), false);
                    TextureSet bTexture = new TextureSet(node.GetNode("bump_texture"), true);


                    ConfigNode colorNode = node.GetNode("color");
                    Color color = new Color(
                        float.Parse(colorNode.GetValue("r")),
                        float.Parse(colorNode.GetValue("g")),
                        float.Parse(colorNode.GetValue("b")));

                    CloudLayers.Add(
                        new CloudLayer(body, color, radius,
                        mTexture, dTexture, bTexture));
                }
                else
                {
                    CloudLayer.Log("body "+body+" does not exist!");
                }
            }
        }

        private void placePQS(float longitude, float latitude, GameObject go)
        {

            UnityEngine.Object[] celestialBodies = CelestialBody.FindObjectsOfType(typeof(CelestialBody));

            CelestialBody currentBody = null;

            foreach (CelestialBody cb in celestialBodies)
            {
                string name = cb.bodyName;
                if (name == "Kerbin")
                {
                    currentBody = cb;
                }
            }

            GameObject blockHolder = new GameObject();
            blockHolder.name = "blockHolder";

            //GameObject block = GameDatabase.Instance.GetModel("Hubs/Static/FLG/FloatingLaunchGround");
            //GameObject building = BuildingGenerator.Generate(20,20,20);
            GameObject block = go;
            if (block == null)
            {

            }


            block.transform.parent = blockHolder.transform;

            foreach (Transform aTransform in currentBody.transform)
            {
                if (aTransform.name == currentBody.transform.name)
                    blockHolder.transform.parent = aTransform;
            }
            PQSCity blockScript = blockHolder.AddComponent<PQSCity>();
            blockScript.debugOrientated = false;
            blockScript.frameDelta = 1;
            blockScript.lod = new PQSCity.LODRange[1];
            blockScript.lod[0] = new PQSCity.LODRange();
            blockScript.lod[0].visibleRange = 20000;
            blockScript.lod[0].renderers = new GameObject[1];
            blockScript.lod[0].renderers[0] = block;
            blockScript.lod[0].objects = new GameObject[0];
            blockScript.modEnabled = true;
            blockScript.order = 100;
            blockScript.reorientFinalAngle = -105;
            blockScript.reorientInitialUp = Vector3.up;
            blockScript.reorientToSphere = true;
            //railScript.repositionRadial = (GameObject.Find("Runway").transform.position - currentBody.transform.position) + Vector3.up * 50 + Vector3.right * -350;
            blockScript.repositionRadial = QuaternionD.AngleAxis(longitude, Vector3d.down) * QuaternionD.AngleAxis(latitude, Vector3d.forward) * Vector3d.right;
            blockScript.repositionRadiusOffset = 80f + (currentBody.pqsController.GetSurfaceHeight(QuaternionD.AngleAxis(longitude, Vector3d.down) * QuaternionD.AngleAxis(latitude, Vector3d.forward) * Vector3d.right) - currentBody.pqsController.radius);
            blockScript.repositionToSphere = true;
            blockScript.requirements = PQS.ModiferRequirements.Default;
            blockScript.sphere = currentBody.pqsController;

            blockScript.RebuildSphere();
        }

        protected void spawnVolumeClouds()
        {
            if (!spawned)
            {

                particleSystemGo = GenerateCloudMesh();
                
                particleSystemGo.transform.localScale = Vector3.one * 5;
/*                Material test = new Material(Shader.Find("Transparent/Diffuse"));
                Utils.Log("2");
                test.color = new Color(0, 0, 0, 0f);
                particleSystemGo.renderer.material = test;
*/                //particleSystemGo.layer = 15;
                float longitude = -74.559f;
                float latitude = -0.0975f;
                placePQS(longitude, latitude, particleSystemGo);


                cloudParticleEmitter = (ParticleEmitter)particleSystemGo.AddComponent("MeshParticleEmitter");
                cloudParticleEmitter.minSize = 100;
                cloudParticleEmitter.maxSize = 150;
                cloudParticleEmitter.minEnergy = 25;
                cloudParticleEmitter.maxEnergy = 40;
                cloudParticleEmitter.minEmission = 4;
                cloudParticleEmitter.maxEmission = 6;
                cloudParticleEmitter.localVelocity = new Vector3(.05f, .05f, .05f);
                cloudParticleEmitter.rndVelocity = new Vector3(.5f, .5f, .5f);
                cloudParticleEmitter.rndAngularVelocity = 3f;
                cloudParticleEmitter.rndRotation = true;
                cloudParticleEmitter.useWorldSpace = false;
                cloudParticleEmitter.emit = true;
                cloudParticleEmitter.enabled = true;

                cloudParticleAnimator = (ParticleAnimator)particleSystemGo.AddComponent<ParticleAnimator>();
                cloudParticleAnimator.sizeGrow = -.025f;

                cloudParticleRenderer = particleSystemGo.AddComponent<ParticleRenderer>();
                cloudParticleRenderer.particleRenderMode = ParticleRenderMode.SortedBillboard;
                cloudParticleRenderer.maxParticleSize = 20;
                Material cloudMaterial = new Material(Shader.Find("Particles/Additive (Soft)"));
                cloudMaterial.mainTexture = GameDatabase.Instance.GetTexture("BoulderCo/Clouds/Textures/particle", false);
                //cloudMaterial.color = new Color(1, 1, 1, .80f);
                cloudParticleRenderer.material = cloudMaterial;

                spawned = true;
                CloudLayer.Log("making particles");
            }
            
        }

        private GameObject GenerateCloudMesh()
        {
            GameObject cloudObject = new GameObject();
            Mesh mesh = cloudObject.AddComponent<MeshFilter>().mesh;
            //var mr = cloudObject.AddComponent<MeshRenderer>();

            Utils.Log("setting up verticies");

            List<Vector3> verticiesList = new List<Vector3>();
            for (int v = 0; v < 6; v++)
            {
                Vector3 start = new Vector3(UnityEngine.Random.Range(-25, 25), UnityEngine.Random.Range(-2.5f, 2.5f), UnityEngine.Random.Range(-25, 25));
                for (int i = 0; i < 5; i++)
                {
                    Vector3 place = new Vector3(UnityEngine.Random.Range(-5, 5), UnityEngine.Random.Range(-2.5f, 2.5f), UnityEngine.Random.Range(-5, 5));
                    for (int n = 0; n < 3; n++)
                    {
                        Vector3 dir = new Vector3(UnityEngine.Random.Range(-1, 1), UnityEngine.Random.Range(-.2f, .2f), UnityEngine.Random.Range(-1, 1));
                        verticiesList.Add(start + place + (dir * UnityEngine.Random.Range(5, 10)));
                        Utils.Log("setting up verticies " + i);
                    }

                    for (int l = 0; l < 7; l++)
                    {
                        Vector3 expand = new Vector3(place.x, place.y, place.z);
                        expand.Scale(new Vector3(UnityEngine.Random.Range(2, 5), UnityEngine.Random.Range(1f, 1f), UnityEngine.Random.Range(2, 5)));
                        for (int n = 0; n < 5; n++)
                        {
                            Vector3 dir = new Vector3(UnityEngine.Random.Range(-1, 1), UnityEngine.Random.Range(-.2f, .2f), UnityEngine.Random.Range(-1, 1));
                            verticiesList.Add(start + expand + (dir * UnityEngine.Random.Range(5, 10)));
                            Utils.Log("setting up verticies " + i);
                        }
                    }
                }
            }

            Vector3[] vertices = verticiesList.ToArray();
            int nbFaces = vertices.Length;
            int nbTriangles = (int)Math.Ceiling(nbFaces / 3.0); ;
            int nbIndexes = nbTriangles * 3;

            int[] triangles = new int[nbIndexes];
            Utils.Log("setting up triangles " + nbTriangles);

            for (int i = 0; i < nbIndexes; i+=3)
            {
                triangles[i + 0] = i + 0;
                triangles[i + 1] = i + 1;
                triangles[i + 2] = i + 2;
                Utils.Log("setting up triangle "+i);
            }

            int leftover = nbFaces % 3;
            if (leftover == 2)
            {
                Utils.Log("leftover2 " + nbIndexes);
                triangles[nbIndexes - 2] = nbFaces - 3;
                triangles[nbIndexes - 1] = nbFaces - 2;
            }
            else if (leftover == 1)
            {
                Utils.Log("leftover1 " + nbIndexes);
                triangles[nbIndexes - 1] = nbFaces-3;
            }
            Utils.Log("finished triangle gen.");

            mesh.vertices = vertices;
            mesh.triangles = triangles;

            //mr.renderer.sharedMaterial = overlayMaterial;

            //mr.castShadows = false;
            //mr.receiveShadows = false;
            //mr.enabled = true;
            Utils.Log("generated Mesh");
            return cloudObject;
        }

        protected void Awake()
        {
            if (HighLogic.LoadedScene == GameScenes.MAINMENU && !Loaded)
            {
                Utils.Init();
                loadCloudLayers();
                
                Loaded = true;
            }
            else if (HighLogic.LoadedScene == GameScenes.SPACECENTER)
            {
            //    spawnVolumeClouds();
            }
        }

        protected void Update()
        {

            foreach (CloudLayer layer in CloudLayers)
            {
                layer.PerformUpdate();
            }
            bool alt = (Input.GetKey(KeyCode.LeftAlt) || Input.GetKey(KeyCode.RightAlt));
            if (alt && Input.GetKeyDown(KeyCode.C))
            {
                useEditor = !useEditor; 
            }
        }

        
        private GUISkin _mySkin;
        private Rect _mainWindowRect = new Rect(20, 20, 200, 600);

        private void OnGUI()
        {

            GUI.skin = _mySkin;

            CelestialBody current = null;
            if (MapView.MapIsEnabled)
            {
                current = Utils.GetMapBody();
            }
            else
            {
                current = FlightGlobals.currentMainBody;
            }
            if (useEditor && current != null)
            {
                if (CloudLayer.GetBodyLayerCount(current.name) != 0)
                {
                    _mainWindowRect.height = 600;
                    _mainWindowRect = GUI.Window(0x8100, _mainWindowRect, DrawMainWindow, "Clouds");
                }
                else
                {
                    _mainWindowRect.height = 110;
                    _mainWindowRect = GUI.Window(0x8100, _mainWindowRect, DrawMainWindow, "Clouds");
                }
            }
        }

        private void DrawMainWindow(int windowID)
        {
            
                
                if (GUI.Button(new Rect(10, 20, 180, 25), "Generate Volume Clouds"))
                {
                    spawnVolumeClouds();
                }
                CelestialBody current = null;
                if (MapView.MapIsEnabled)
                {
                    current = Utils.GetMapBody();
                }
                else
                {
                    current = FlightGlobals.currentMainBody;
                }
                if (current != null)
                {
                    GUI.Label(new Rect(50, 50, 170, 25), current.name);
                
                    if (MapView.MapIsEnabled)
                    {
                        if (GUI.Button(new Rect(10, 50, 25, 25), "<"))
                        {
                            MapView.MapCamera.SetTarget(Utils.GetPreviousBody(current).name);
                        }
                        if (GUI.Button(new Rect(165, 50, 25, 25), ">"))
                        {
                            MapView.MapCamera.SetTarget(Utils.GetNextBody(current).name);
                        }
                    }
                    if (GUI.Button(new Rect(10, 80, 85, 25), "Add"))
                    {
                        spawnVolumeClouds();
                    }
                    if (CloudLayer.GetBodyLayerCount(current.name) != 0)
                    {
                        if (GUI.Button(new Rect(100, 80, 85, 25), "Remove"))
                        {
                            spawnVolumeClouds();
                        }
                    
                        String[] layerList = CloudLayer.GetBodyLayers(current.name);
                        ScrollPosLayerList = GUI.BeginScrollView(new Rect(10, 110, 180, 75), ScrollPosLayerList, new Rect(0, 0, 160, 25 * layerList.Length));
                        SelectedLayer = GUI.SelectionGrid(new Rect(25, 0, 130, 25 * layerList.Length), SelectedLayer, layerList, 1);
                        GUI.EndScrollView();
                    }
                }
                else
                {
                    GUI.Label(new Rect(50, 50, 170, 25), "----");
                }
                GUI.DragWindow(new Rect(0, 0, 10000, 10000));
            
        }
        

    }

    public class CloudLayer
    {
        public static Dictionary<String, List<CloudLayer>> PlanetDatabase = new Dictionary<string, List<CloudLayer>>();
        private static Shader GlobalCloudShader;
        private static Shader GlobalUndersideCloudShader;
        private Material CloudMaterial;
        private Material UndersideCloudMaterial;
        private float timeDelta = 0;
        private String body;
        private Color color;
        private float radius;
        private TextureSet mainTexture;
        private TextureSet detailTexture;
        private TextureSet bumpTexture;

        public CloudLayer(String body, Color color, float radius,
            TextureSet mainTexture,
            TextureSet detailTexture,
            TextureSet bumpTexture)
        {
            if(!PlanetDatabase.ContainsKey(body))
            {
                PlanetDatabase.Add(body, new List<CloudLayer>());
            }
            PlanetDatabase[body].Add(this);
            this.body = body;
            this.color = color;
            this.radius = radius;
            this.mainTexture = mainTexture;
            if (detailTexture.Texture != null)
            {
                this.detailTexture = detailTexture;
            }
            else
            {
                this.detailTexture = null;
            }
            if (bumpTexture.Texture != null)
            {
                this.bumpTexture = bumpTexture;
            }
            else
            {
                this.bumpTexture = null;
            }
            Init();
        }

        private void InitTexture()
        {
            CloudMaterial.SetTexture("_MainTex", mainTexture.Texture);
            CloudMaterial.SetTextureScale("_MainTex", mainTexture.Scale);
            CloudMaterial.SetColor("_Color", color);

            UndersideCloudMaterial.SetTexture("_MainTex", mainTexture.Texture);
            UndersideCloudMaterial.SetTextureScale("_MainTex", mainTexture.Scale);
            UndersideCloudMaterial.SetColor("_Color", color);

            if (detailTexture != null)
            {
                CloudMaterial.SetTexture("_DetailTex", detailTexture.Texture);
                CloudMaterial.SetTextureScale("_DetailTex", detailTexture.Scale);
                UndersideCloudMaterial.SetTexture("_DetailTex", detailTexture.Texture);
                UndersideCloudMaterial.SetTextureScale("_DetailTex", detailTexture.Scale);
            }

            if (bumpTexture != null)
            {
                CloudMaterial.SetTexture("_BumpMap", bumpTexture.Texture);
                CloudMaterial.SetTextureScale("_BumpMap", bumpTexture.Scale);
                UndersideCloudMaterial.SetTexture("_BumpMap", bumpTexture.Texture);
                UndersideCloudMaterial.SetTextureScale("_BumpMap", bumpTexture.Scale);
            }
        }

        public void Init()
        {
            if (GlobalCloudShader == null)
            {
                Utils.Log("Initializing Textures");
                Assembly assembly = Assembly.GetExecutingAssembly();
                StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Clouds.CompiledCloudShader.txt"));
                Utils.Log("reading stream...");
                String shaderTxt = shaderStreamReader.ReadToEnd();
                GlobalCloudShader = new Material(shaderTxt).shader;

                shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Clouds.undersideCompiledCloudShader.txt"));
                Utils.Log("reading stream...");
                shaderTxt = shaderStreamReader.ReadToEnd();
                GlobalUndersideCloudShader = new Material(shaderTxt).shader;
            }
            CloudMaterial = new Material(GlobalCloudShader);
            UndersideCloudMaterial = new Material(GlobalUndersideCloudShader);
           
            
            Log("Cloud Material initialized");
            InitTexture();
            Log("Generating Overlay...");
            Overlay.GeneratePlanetOverlay(body, radius, CloudMaterial, Utils.OVER_LAYER, false, 64,64);
            Overlay.GeneratePlanetOverlay(body, radius, UndersideCloudMaterial, Utils.UNDER_LAYER, false, 64, 64);
            Log("Textures initialized");
        }

        private void updateOffset(float time)
        {
            float rateOffset = time;

            mainTexture.UpdateOffset(rateOffset);
            CloudMaterial.SetTextureOffset("_MainTex", mainTexture.Offset);
            UndersideCloudMaterial.SetTextureOffset("_MainTex", mainTexture.Offset);

            if(detailTexture != null)
            {
                detailTexture.UpdateOffset(rateOffset);
                CloudMaterial.SetTextureOffset("_DetailTex", detailTexture.Offset);
                UndersideCloudMaterial.SetTextureOffset("_DetailTex", detailTexture.Offset);
            }

            if (bumpTexture != null)
            {
                bumpTexture.UpdateOffset(rateOffset);
                CloudMaterial.SetTextureOffset("_BumpMap", bumpTexture.Offset);
                UndersideCloudMaterial.SetTextureOffset("_BumpMap", bumpTexture.Offset);
            }

        }

        public void PerformUpdate()
        {
            timeDelta = Time.time - timeDelta;
            float timeOffset = timeDelta * TimeWarp.CurrentRate;

            updateOffset(timeOffset);

            timeDelta = Time.time;
        }

        public static void Log(String message)
        {
            UnityEngine.Debug.Log("Clouds: " + message);
        }

        public static int GetBodyLayerCount(string p)
        {
            if (PlanetDatabase.ContainsKey(p))
            {
                return PlanetDatabase[p].Count;
            }
            else
            {
                return 0;
            }
        }

        public static String[] GetBodyLayers(string p)
        {
            if (PlanetDatabase.ContainsKey(p))
            {
                int count = PlanetDatabase[p].Count;
                String[] layerList = new String[count];
                for(int i = 0; i < count; i++)
                {
                    layerList[i] = "Layer "+ i;
                }
                return layerList;
            }
            else
            {
                return new String[0];
            }
        }
    }
}
