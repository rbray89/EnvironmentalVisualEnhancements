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
    [KSPAddon(KSPAddon.Startup.MainMenu, false)]
    public class KerbinCloud : MonoBehaviour
    {
        Clouds cloud = new Clouds("Kerbin");
        protected void Awake()
        {
            cloud.Init(gameObject, new Color(1, 1, 1));
        }

        void Update()
        {
            cloud.PerformUpdate();
        }
    }

    [KSPAddon(KSPAddon.Startup.MainMenu, false)]
    public class JoolCloud : MonoBehaviour
    {
        Clouds cloud = new Clouds("Jool");
        protected void Awake()
        {
            cloud.Init(gameObject, new Color(.1333f, .6941f, .2980f));
        }

        void Update()
        {
            cloud.PerformUpdate();
        }
    }

    public class Clouds
    {
        public String name;
        public Material CloudMaterial;
        public float timeDelta = 0;

        public Clouds(String name)
        {
            this.name = name;
        }

        public void InitTexture(Material material, String location, Color color)
        {
            material.SetTexture("_MainTex", GameDatabase.Instance.GetTexture(location + "/main", false));
            material.SetTexture("_Mixer", GameDatabase.Instance.GetTexture(location + "/mixer", false));
            material.SetTexture("_Fader", GameDatabase.Instance.GetTexture(location + "/fader", false));
            material.SetTextureScale("_MainTex", new Vector2(1f, 1f));
            material.SetTextureScale("_Mixer", new Vector2(1f, 1f));
            material.SetTextureScale("_Fader", new Vector2(1f, 1f));
            material.SetColor("_Color", color);
        }

        public void Init(GameObject gameObject, Color color)
        {
            Log("Initializing Textures");
            Assembly assembly = Assembly.GetExecutingAssembly();
            StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Clouds.CompiledCloudShader.txt"));
            Log("read stream");
            String shaderTxt = shaderStreamReader.ReadToEnd();
            CloudMaterial = new Material(shaderTxt);

            InitTexture(CloudMaterial, "BoulderCo/Clouds/" + name, color);

            Utils.GeneratePlanetOverlay(name, 1.0055f, gameObject, CloudMaterial);
            Log("Textures initialized");
        }



        public void updateOffset(Material material, float time, float rate)
        {
            float rateOffset = time * rate;
            Vector2 mainOff = material.GetTextureOffset("_MainTex");
            Vector2 mixOff = material.GetTextureOffset("_Mixer");
            Vector2 fadeOff = material.GetTextureOffset("_Fader");

            material.SetTextureOffset("_MainTex", new Vector2(mainOff.x + (rateOffset), 0));
            material.SetTextureOffset("_Mixer", new Vector2(mixOff.x - (rateOffset / 4.0f), mixOff.y + (rateOffset / 3.0f)));
            material.SetTextureOffset("_Fader", new Vector2(fadeOff.x + (rateOffset / 5.0f), fadeOff.y - (rateOffset / 4.0f)));
        }

        public void PerformUpdate()
        {
            if (CloudMaterial != null)
            {
                timeDelta = Time.time - timeDelta;
                float timeOffset = timeDelta * TimeWarp.CurrentRate;

                updateOffset(CloudMaterial, timeOffset, .000025f);

                timeDelta = Time.time;
            }
        }

        public static void Log(String message)
        {
            UnityEngine.Debug.Log("Clouds: " + message);
        }
    }
}
