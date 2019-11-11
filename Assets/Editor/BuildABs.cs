using UnityEditor;
using UnityEngine;

class BuildABs {
    [MenuItem("Assets/Build Asset Bundles")]
    static void BuildAssetBundles()
    {
        // Put the bundles in a folder called "ABs" within the
        // Assets folder.
        var outDir = "ContentEVE/GameData/EnvironmentalVisualEnhancements";
        var opts = BuildAssetBundleOptions.DeterministicAssetBundle
            | BuildAssetBundleOptions.ForceRebuildAssetBundle;

        /* We've made sure all graphics APIs are present for StandaloneWindows, so no need for separate versions (for now).
         * 
        BuildTarget[] platforms = { BuildTarget.StandaloneWindows, BuildTarget.StandaloneOSXUniversal, BuildTarget.StandaloneLinux };
        string[] platformExts = { "-windows", "-macosx", "-linux" };
        */
        BuildTarget[] platforms = { BuildTarget.StandaloneWindows };
        string[] platformExts = { "" };

        for (var i = 0; i < platforms.Length; ++i) {
            BuildPipeline.BuildAssetBundles(outDir, opts, platforms[i]);
            var outFile = outDir + "/eveshaders"+ platformExts[i]+".bundle";
            FileUtil.ReplaceFile(outDir + "/eveshaders", outFile);
        }
        // Delete unused guff
        FileUtil.DeleteFileOrDirectory(outDir + "/EnvironmentalVisualEnhancements");
        FileUtil.DeleteFileOrDirectory(outDir + "/EnvironmentalVisualEnhancements.manifest");
        FileUtil.DeleteFileOrDirectory(outDir + "/eveshaders");
        FileUtil.DeleteFileOrDirectory(outDir + "/eveshaders.manifest");
    }
}