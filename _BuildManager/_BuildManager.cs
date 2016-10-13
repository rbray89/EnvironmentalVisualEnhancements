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
