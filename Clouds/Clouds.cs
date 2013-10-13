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
    public class Clouds : MonoBehaviour
    {
        private static Material cloudMaterial;
        private static float timeDelta = 0;

        public static void InitTextures()
        {
            Log("Initializing Textures");
            Assembly assembly = Assembly.GetExecutingAssembly();
            StreamReader shaderStreamReader = new StreamReader(assembly.GetManifestResourceStream("Clouds.CompiledCloudShader.txt"));
            Log("read stream");
            cloudMaterial = new Material(shaderStreamReader.ReadToEnd());
            
            cloudMaterial.SetTexture("_MainTex", GameDatabase.Instance.GetTexture("BoulderCo/Clouds/Textures/main", false));
            cloudMaterial.SetTexture("_Mixer", GameDatabase.Instance.GetTexture("BoulderCo/Clouds/Textures/mixer", false));
            cloudMaterial.SetTexture("_Fader", GameDatabase.Instance.GetTexture("BoulderCo/Clouds/Textures/fader", false));
            cloudMaterial.SetTextureScale("_MainTex", new Vector2(1f, 1f));
            cloudMaterial.SetTextureScale("_Mixer", new Vector2(1f, 1f));
            cloudMaterial.SetTextureScale("_Fader", new Vector2(1f, 1f));
            Log("Textures initialized");
        }

        protected void Awake()
        {
            InitTextures();
            Utils.GeneratePlanetOverlay("Kerbin", 1.0055f, gameObject, cloudMaterial);
        }

        void Update()
        {
            if (cloudMaterial != null)
            {
                timeDelta = Time.time - timeDelta;
                float offset =  timeDelta * TimeWarp.CurrentRate * .00125f;
                Vector2 mainOff = cloudMaterial.GetTextureOffset("_MainTex");
                Vector2 mixOff = cloudMaterial.GetTextureOffset("_Mixer");
                Vector2 fadeOff = cloudMaterial.GetTextureOffset("_Fader");

                cloudMaterial.SetTextureOffset("_MainTex", new Vector2(mainOff.x+(offset), 0));
                cloudMaterial.SetTextureOffset("_Mixer", new Vector2(mixOff.x - (offset / 4.0f), mixOff.y + (offset/3.0f)));
                cloudMaterial.SetTextureOffset("_Fader", new Vector2(fadeOff.x + (offset/5.0f), fadeOff.y - (offset/4.0f)));
                timeDelta = Time.time;
            }
        }
        
        public static void Log(String message)
        {
            UnityEngine.Debug.Log("Clouds: " + message);
        }
    }
}
