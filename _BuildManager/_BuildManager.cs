using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;

namespace _BuildManager
{
    [KSPAddon(KSPAddon.Startup.Instantly, true)]
    public class _BuildManager : MonoBehaviour
    {
        private void Awake()
        {
            logVersion();

            AddLoadingTips();
        }

        private void AddLoadingTips()
        {
            var loadingScreens = LoadingScreen.Instance.Screens;
            if (loadingScreens.Count > 1) {
                // The tips appear on the "second" loading screen, after the initial "Loading..." screen.
                int tipScreen = 1;
                var tips = loadingScreens[tipScreen].tips;
                string[] newTips = {
                    "Inserting Head Into Clouds...", // How KSP makes us all feel.
                    "Luminously Urbanizing...", // City lights
                    "Searching for the Aurora Borealis...", "Searching for the Aurora Australis..." // You'll find them in SVE!
                };
                Array.Resize(ref tips, tips.Length + newTips.Length);
                newTips.CopyTo(tips, tips.Length - newTips.Length);
                loadingScreens[tipScreen].tips = tips;
            }
        }

        private void logVersion()
        {
            Assembly buildManager = Assembly.GetExecutingAssembly();
            String location = Path.GetDirectoryName(buildManager.Location);
            List<AssemblyName> assemblies = AppDomain.CurrentDomain.GetAssemblies().Where(x => Path.GetDirectoryName(x.Location) == location).Select(x => x.GetName()).ToList();

            String versionInfo = "[EVE] Version Info:\n";
            foreach (AssemblyName assembly in assemblies)
            {
                versionInfo+=assembly.Name + ", " + assembly.Version.ToString() + "\n";
            }

            KSPLog.print(versionInfo);
        }
    }
    
}
