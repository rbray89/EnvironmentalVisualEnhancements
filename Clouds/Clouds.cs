using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using UnityEngine;
using System.IO;
using OverlaySystem;

namespace Clouds
{
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class Clouds : MonoBehaviour
    {
        static bool Loaded = false;
        static KeyCode GUI_KEYCODE = KeyCode.N;

        static bool useEditor = false;
        static bool AdvancedGUI = false;
        static Vector2 ScrollPosLayerList = Vector2.zero;
        static int SelectedLayer = 0;
        static CloudGUI CloudGUI = new CloudGUI();
        static CelestialBody currentBody = null;
        static CelestialBody oldBody = null;

        private void loadCloudLayers(String configString)
        {
            foreach (CloudLayer cl in CloudLayer.Layers)
            {
                cl.Remove(false);
            }
            CloudLayer.Layers.Clear();
            if (configString == null)
            {
                configString = KSPUtil.ApplicationRootPath + "GameData/BoulderCo/Clouds/userCloudLayers.cfg";
            }
            else
            {
                configString = KSPUtil.ApplicationRootPath + "GameData/BoulderCo/Clouds/" + configString;
            }

            ConfigNode config = ConfigNode.Load(configString);
            if (config == null)
            {
                config = ConfigNode.Load(KSPUtil.ApplicationRootPath + "GameData/BoulderCo/Clouds/cloudLayers.cfg");
            }
            String keycodeString = config.GetValue("GUI_KEYCODE");
            if (keycodeString != null)
            {
                GUI_KEYCODE = (KeyCode)Enum.Parse(typeof(KeyCode), keycodeString);
            }
            else
            {
                GUI_KEYCODE = KeyCode.N;
            }

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
                    float altitude = float.Parse(node.GetValue("altitude"));

                    TextureSet mTexture = new TextureSet(node.GetNode("main_texture"), false);
                    TextureSet dTexture = new TextureSet(node.GetNode("detail_texture"), false);
                    TextureSet bTexture = new TextureSet(node.GetNode("bump_texture"), true);
                    ConfigNode floatsConfig = node.GetNode("shader_floats");
                    ShaderFloats shaderFloats = null;
                    if (floatsConfig != null)
                    {
                        shaderFloats = new ShaderFloats(floatsConfig);
                    }
                    ConfigNode pqsFloatsConfig = node.GetNode("PQS_shader_floats");
                    ShaderFloats pqsShaderFloats = null;
                    if (pqsFloatsConfig != null)
                    {
                        pqsShaderFloats = new ShaderFloats(pqsFloatsConfig);
                    }
                    ConfigNode colorNode = node.GetNode("color");
                    Color color = new Color(
                        float.Parse(colorNode.GetValue("r")),
                        float.Parse(colorNode.GetValue("g")),
                        float.Parse(colorNode.GetValue("b")),
                        float.Parse(colorNode.GetValue("a")));

                    CloudLayer.Layers.Add(
                        new CloudLayer(body, color, altitude,
                        mTexture, dTexture, bTexture, shaderFloats, pqsShaderFloats));
                }
                else
                {
                    CloudLayer.Log("body " + body + " does not exist!");
                }
            }
        }

        private void saveCloudLayers(String configString)
        {
            ConfigNode saveConfig = new ConfigNode();
            if (configString == null)
            {
                configString = KSPUtil.ApplicationRootPath + "GameData/BoulderCo/Clouds/userCloudLayers.cfg";
            }
            else
            {
                configString = KSPUtil.ApplicationRootPath + "GameData/BoulderCo/Clouds/" + configString;
            }
            saveConfig.SetValue("GUI_KEYCODE", GUI_KEYCODE.ToString());

            foreach (KeyValuePair<String, List<CloudLayer>> cloudList in CloudLayer.BodyDatabase.ToArray())
            {
                String body = cloudList.Key;
                List<CloudLayer> list = cloudList.Value;
                foreach (CloudLayer cloudLayer in list)
                {
                    ConfigNode newNode = saveConfig.AddNode("CLOUD_LAYER");
                    newNode.AddValue("body", body);
                    newNode.AddValue("altitude", cloudLayer.Altitude);
                    ConfigNode colorNode = newNode.AddNode("color");
                    colorNode.AddValue("r", cloudLayer.Color.r);
                    colorNode.AddValue("g", cloudLayer.Color.g);
                    colorNode.AddValue("b", cloudLayer.Color.b);
                    colorNode.AddValue("a", cloudLayer.Color.a);
                    newNode.AddNode(cloudLayer.MainTexture.GetNode("main_texture"));
                    ConfigNode detailNode = cloudLayer.DetailTexture.GetNode("detail_texture");
                    if (detailNode != null)
                    {
                        newNode.AddNode(detailNode);
                    }
                    ConfigNode bumpNode = cloudLayer.BumpTexture.GetNode("bump_texture");
                    if (bumpNode != null)
                    {
                        newNode.AddNode(bumpNode);
                    }
                    ConfigNode shaderFloatNode = cloudLayer.ScaledShaderFloats.GetNode("shader_floats");
                    if (!CloudLayer.IsDefaultShaderFloat(cloudLayer.ScaledShaderFloats))
                    {
                        newNode.AddNode(shaderFloatNode);
                    }
                    ConfigNode PQSShaderFloatNode = cloudLayer.ShaderFloats.GetNode("PQS_shader_floats");
                    if (!CloudLayer.IsDefaultShaderFloat(cloudLayer.ShaderFloats))
                    {
                        newNode.AddNode(PQSShaderFloatNode);
                    }
                    
                }
            }
            saveConfig.Save(configString);
        }

        protected void Awake()
        {
            if (HighLogic.LoadedScene == GameScenes.MAINMENU && !Loaded)
            {

                OverlayMgr.Init();
                loadCloudLayers(null);
                
                Loaded = true;
            }
            else if (HighLogic.LoadedScene == GameScenes.SPACECENTER)
            {
            }
        }

        protected void Update()
        {
            if (HighLogic.LoadedScene == GameScenes.FLIGHT || HighLogic.LoadedScene == GameScenes.TRACKSTATION ||
                HighLogic.LoadedScene == GameScenes.MAINMENU || HighLogic.LoadedScene == GameScenes.SPACECENTER)
            {
                foreach (CloudLayer layer in CloudLayer.Layers)
                {
                    layer.PerformUpdate();
                }
                bool alt = (Input.GetKey(KeyCode.LeftAlt) || Input.GetKey(KeyCode.RightAlt));
                if (alt && Input.GetKeyDown(GUI_KEYCODE))
                {
                    useEditor = !useEditor;
                }
            }
            if (HighLogic.LoadedScene == GameScenes.FLIGHT)
            {
                if (FlightGlobals.ActiveVessel != null && CloudLayer.BodyDatabase.ContainsKey(FlightGlobals.currentMainBody.name))
                {
                    Vector3 COM = FlightGlobals.ActiveVessel.findWorldCenterOfMass();
                    foreach (CloudLayer cl in CloudLayer.BodyDatabase[FlightGlobals.currentMainBody.name])
                    {
                        cl.UpdateParticleClouds(COM);
                    }
                }
            }
/*            else if (HighLogic.LoadedScene == GameScenes.SPACECENTER)
            {
                if (CloudLayer.BodyDatabase.ContainsKey(FlightGlobals.currentMainBody.name))
                {
                    foreach (CloudLayer cl in CloudLayer.BodyDatabase[FlightGlobals.currentMainBody.name])
                    {
                        cl.UpdateParticleClouds(((SpaceCenterMain)Resources.FindObjectsOfTypeAll(typeof(SpaceCenterMain))[0]).transform.position);
                    }
                }
            }
 */
        }


        private GUISkin _mySkin;
        private Rect _mainWindowRect = new Rect(20, 20, 260, 600);

        private void OnGUI()
        {

            GUI.skin = _mySkin;

            CelestialBody current = null;
            if (MapView.MapIsEnabled)
            {
                current = OverlayMgr.GetMapBody();
            }
            else
            {
                current = FlightGlobals.currentMainBody;
            }
            if (useEditor && current != null)
            {

                if (AdvancedGUI)
                {
                    _mainWindowRect.width = 520;
                }
                else
                {
                    _mainWindowRect.width = 260;
                }
                if (CloudLayer.GetBodyLayerCount(current.name) != 0)
                {
                    _mainWindowRect.height = 745;
                    _mainWindowRect = GUI.Window(0x8100, _mainWindowRect, DrawMainWindow, "Clouds");
                }
                else
                {
                    _mainWindowRect.height = 115;
                    _mainWindowRect = GUI.Window(0x8100, _mainWindowRect, DrawMainWindow, "Clouds");
                }
            }
            
        }

        private void DrawMainWindow(int windowID)
        {
            oldBody = currentBody;
            currentBody = null;
            if (MapView.MapIsEnabled)
            {
                currentBody = OverlayMgr.GetMapBody();
            }
            else
            {
                currentBody = FlightGlobals.currentMainBody;
            }
            if (currentBody != null)
            {
                GUIStyle gs = new GUIStyle(GUI.skin.label);
                gs.alignment = TextAnchor.MiddleCenter;

                AdvancedGUI = GUI.Toggle(
                        new Rect(10, 50, 125, 25), AdvancedGUI, "Advanced Settings");
                float itemFullWidth = AdvancedGUI ? (_mainWindowRect.width / 2) - 20 : _mainWindowRect.width - 20;

                GUI.Label(new Rect(35, 20, itemFullWidth - 50, 25), currentBody.name, gs);

                if (MapView.MapIsEnabled)
                {
                    if (GUI.Button(new Rect(10, 20, 25, 25), "<"))
                    {
                        MapView.MapCamera.SetTarget(OverlayMgr.GetPreviousBody(currentBody).name);
                    }
                    if (GUI.Button(new Rect(itemFullWidth - 15, 20, 25, 25), ">"))
                    {
                        MapView.MapCamera.SetTarget(OverlayMgr.GetNextBody(currentBody).name);
                    }
                }
                float halfWidth;
                if (AdvancedGUI)
                {
                    halfWidth = (itemFullWidth / 2);
                    if (GUI.Button(new Rect(itemFullWidth + 30, 20, halfWidth, 25), "Reset to Save"))
                    {
                        loadCloudLayers(null);
                        oldBody = null;
                    }
                    if (GUI.Button(new Rect(itemFullWidth + halfWidth + 35, 20, halfWidth-5, 25), "Reset to Default"))
                    {
                        loadCloudLayers("cloudLayers.cfg");
                        oldBody = null;
                    }
                }

                int layerCount = CloudLayer.GetBodyLayerCount(currentBody.name);
                bool hasLayers = layerCount != 0;

                halfWidth = hasLayers ? (itemFullWidth / 2) - 5 : itemFullWidth;
                if (GUI.Button(new Rect(10, 80, halfWidth, 25), "Add"))
                {
                    CloudLayer.Layers.Add(
                    new CloudLayer(currentBody.name, new Color(1, 1, 1, 1), 1000f,
                    new TextureSet(), new TextureSet(), new TextureSet(), null, null));
                }
                if (hasLayers)
                {

                    if (GUI.Button(new Rect(halfWidth + 20, 80, halfWidth, 25), "Remove"))
                    {
                        CloudLayer.RemoveLayer(currentBody.name, SelectedLayer);
                        return;
                    }
                    GUI.Box(new Rect(10, 110, itemFullWidth, 115), "");
                    String[] layerList = CloudLayer.GetBodyLayerStringList(currentBody.name);
                    ScrollPosLayerList = GUI.BeginScrollView(new Rect(15, 115, itemFullWidth - 10, 100), ScrollPosLayerList, new Rect(0, 0, itemFullWidth - 30, 25 * layerList.Length));
                    float layerWidth = layerCount > 4 ? itemFullWidth - 30 : itemFullWidth - 10;
                    SelectedLayer = SelectedLayer >= layerCount ? 0 : SelectedLayer;
                    int OldSelectedLayer = SelectedLayer;
                    SelectedLayer = GUI.SelectionGrid(new Rect(0, 0, layerWidth, 25 * layerList.Length), SelectedLayer, layerList, 1);
                    GUI.EndScrollView();

                    if (SelectedLayer != OldSelectedLayer || currentBody != oldBody)
                    {
                        if (CloudLayer.BodyDatabase.ContainsKey(currentBody.name) && CloudLayer.BodyDatabase[currentBody.name].Count > SelectedLayer)
                        {
                            CloudGUI.MainTexture.Clone(CloudLayer.BodyDatabase[currentBody.name][SelectedLayer].MainTexture);
                            CloudGUI.DetailTexture.Clone(CloudLayer.BodyDatabase[currentBody.name][SelectedLayer].DetailTexture);
                            CloudGUI.BumpTexture.Clone(CloudLayer.BodyDatabase[currentBody.name][SelectedLayer].BumpTexture);
                            CloudGUI.Color.Clone(CloudLayer.BodyDatabase[currentBody.name][SelectedLayer].Color);
                            CloudGUI.Altitude.Clone(CloudLayer.BodyDatabase[currentBody.name][SelectedLayer].Altitude);
                            CloudGUI.ScaledShaderFloats.Clone(CloudLayer.BodyDatabase[currentBody.name][SelectedLayer].ScaledShaderFloats);
                            CloudGUI.ShaderFloats.Clone(CloudLayer.BodyDatabase[currentBody.name][SelectedLayer].ShaderFloats);
                        }
                    }

                    if (CloudGUI.IsValid())
                    {
                        if (GUI.Button(new Rect(145, 50, 50, 25), "Apply"))
                        {
                            CloudLayer.BodyDatabase[currentBody.name][SelectedLayer].ApplyGUIUpdate(CloudGUI);
                        }
                        if (GUI.Button(new Rect(200, 50, 50, 25), "Save"))
                        {
                            CloudLayer.BodyDatabase[currentBody.name][SelectedLayer].ApplyGUIUpdate(CloudGUI);
                            saveCloudLayers(null);
                        }
                    }



                    int nextLine = 230;
                    gs.alignment = TextAnchor.MiddleRight;
                    if (AdvancedGUI)
                    {
                        int advancedNextLine = HandleAdvancedGUI(CloudGUI.ScaledShaderFloats, 50, _mainWindowRect.width / 2);
                        GUI.Label(new Rect((_mainWindowRect.width / 2) + 10, advancedNextLine, itemFullWidth, 25), "PQS Settings:");
                        HandleAdvancedGUI(CloudGUI.ShaderFloats, advancedNextLine + 30, _mainWindowRect.width / 2);
                    }

                    nextLine = HandleAltitudeGUI(CloudGUI.Altitude, nextLine);
                    nextLine = HandleColorGUI(CloudGUI.Color, nextLine);


                    GUI.Label(
                        new Rect(10, nextLine, 80, 25), "MainTex: ", gs);
                    nextLine = HandleTextureGUI(CloudGUI.MainTexture, nextLine);

                    GUI.Label(
                        new Rect(10, nextLine, 80, 25), "DetailTex: ", gs);
                    CloudGUI.DetailTexture.InUse = GUI.Toggle(
                        new Rect(10, nextLine, 25, 25), CloudGUI.DetailTexture.InUse, "");
                    if (CloudGUI.DetailTexture.InUse)
                    {
                        nextLine = HandleTextureGUI(CloudGUI.DetailTexture, nextLine);
                    }
                    else
                    {
                        nextLine += 30;
                    }

                    GUI.Label(
                        new Rect(10, nextLine, 80, 25), "BumpTex: ", gs);
                    CloudGUI.BumpTexture.InUse = GUI.Toggle(
                        new Rect(10, nextLine, 25, 25), CloudGUI.BumpTexture.InUse, "");
                    if (CloudGUI.BumpTexture.InUse)
                    {
                        nextLine = HandleTextureGUI(CloudGUI.BumpTexture, nextLine);
                    }
                    else
                    {
                        nextLine += 30;
                    }

                }
            }
            else
            {
                GUI.Label(new Rect(50, 50, 230, 25), "----");
            }
            GUI.DragWindow(new Rect(0, 0, 10000, 10000));

        }

        private int HandleAdvancedGUI(ShaderFloatsGUI floats, int y, float offset)
        {
            GUIStyle gs = new GUIStyle(GUI.skin.label);
            gs.alignment = TextAnchor.MiddleRight;
            GUIStyle texFieldGS = new GUIStyle(GUI.skin.textField);
            Color errorColor = new Color(1, 0, 0);
            Color normalColor = texFieldGS.normal.textColor;
            float dummyFloat;


            GUI.Label(
                new Rect(offset + 10, y, 65, 25), "RimPower: ", gs);
            if (float.TryParse(floats.FalloffPowerString, out dummyFloat))
            {
                texFieldGS.normal.textColor = normalColor;
                texFieldGS.hover.textColor = normalColor;
                texFieldGS.active.textColor = normalColor;
                texFieldGS.focused.textColor = normalColor;
            }
            else
            {
                texFieldGS.normal.textColor = errorColor;
                texFieldGS.hover.textColor = errorColor;
                texFieldGS.active.textColor = errorColor;
                texFieldGS.focused.textColor = errorColor;
            }
            String SFalloffPower = GUI.TextField(new Rect(offset + 80, y, 50, 25), floats.FalloffPowerString, texFieldGS);
            float FFalloffPower = GUI.HorizontalSlider(new Rect(offset + 135, y + 5, 115, 25), floats.FalloffPower, 0, 3);
            y += 30;
            GUI.Label(
                new Rect(offset + 10, y, 65, 25), "RimScale: ", gs);
            if (float.TryParse(floats.FalloffScaleString, out dummyFloat))
            {
                texFieldGS.normal.textColor = normalColor;
                texFieldGS.hover.textColor = normalColor;
                texFieldGS.active.textColor = normalColor;
                texFieldGS.focused.textColor = normalColor;
            }
            else
            {
                texFieldGS.normal.textColor = errorColor;
                texFieldGS.hover.textColor = errorColor;
                texFieldGS.active.textColor = errorColor;
                texFieldGS.focused.textColor = errorColor;
            }
            string SFalloffScale = GUI.TextField(new Rect(offset + 80, y, 50, 25), floats.FalloffScaleString, texFieldGS);
            float FFalloffScale = GUI.HorizontalSlider(new Rect(offset + 135, y + 5, 115, 25), floats.FalloffScale, 0, 20);
            y += 30;
            GUI.Label(
                new Rect(offset + 10, y, 65, 25), "DetailDist: ", gs);
            if (float.TryParse(floats.DetailDistanceString, out dummyFloat))
            {
                texFieldGS.normal.textColor = normalColor;
                texFieldGS.hover.textColor = normalColor;
                texFieldGS.active.textColor = normalColor;
                texFieldGS.focused.textColor = normalColor;
            }
            else
            {
                texFieldGS.normal.textColor = errorColor;
                texFieldGS.hover.textColor = errorColor;
                texFieldGS.active.textColor = errorColor;
                texFieldGS.focused.textColor = errorColor;
            }
            string SDetailDistance = GUI.TextField(new Rect(offset + 80, y, 50, 25), floats.DetailDistanceString, texFieldGS);
            float FDetailDistance = GUI.HorizontalSlider(new Rect(offset + 135, y + 5, 115, 25), floats.DetailDistance, 0, 1);
            y += 30;
            GUI.Label(
                new Rect(offset + 10, y, 65, 25), "MinLight: ", gs);
            if (float.TryParse(floats.MinimumLightString, out dummyFloat))
            {
                texFieldGS.normal.textColor = normalColor;
                texFieldGS.hover.textColor = normalColor;
                texFieldGS.active.textColor = normalColor;
                texFieldGS.focused.textColor = normalColor;
            }
            else
            {
                texFieldGS.normal.textColor = errorColor;
                texFieldGS.hover.textColor = errorColor;
                texFieldGS.active.textColor = errorColor;
                texFieldGS.focused.textColor = errorColor;
            }
            string SMinimumLight = GUI.TextField(new Rect(offset + 80, y, 50, 25), floats.MinimumLightString, texFieldGS);
            float FMinimumLight = GUI.HorizontalSlider(new Rect(offset + 135, y + 5, 115, 25), floats.MinimumLight, 0, 1);
            y += 30;
            GUI.Label(
                new Rect(offset + 10, y, 65, 25), "FadeDist: ", gs);
            if (float.TryParse(floats.FadeDistanceString, out dummyFloat))
            {
                texFieldGS.normal.textColor = normalColor;
                texFieldGS.hover.textColor = normalColor;
                texFieldGS.active.textColor = normalColor;
                texFieldGS.focused.textColor = normalColor;
            }
            else
            {
                texFieldGS.normal.textColor = errorColor;
                texFieldGS.hover.textColor = errorColor;
                texFieldGS.active.textColor = errorColor;
                texFieldGS.focused.textColor = errorColor;
            }
            string SFadeDist = GUI.TextField(new Rect(offset + 80, y, 50, 25), floats.FadeDistanceString, texFieldGS);
            float FFadeDist = GUI.HorizontalSlider(new Rect(offset + 135, y + 5, 115, 25), floats.FadeDistance, 0, 100);

            floats.Update(SFalloffPower, FFalloffPower, SFalloffScale, FFalloffScale, SDetailDistance, FDetailDistance, SMinimumLight, FMinimumLight, SFadeDist, FFadeDist);

            return y + 30;
        }

        private int HandleAltitudeGUI(AltitudeSetGUI altitude, int y)
        {
            GUIStyle gs = new GUIStyle(GUI.skin.label);
            gs.alignment = TextAnchor.MiddleRight;
            GUIStyle texFieldGS = new GUIStyle(GUI.skin.textField);
            Color errorColor = new Color(1, 0, 0);
            Color normalColor = texFieldGS.normal.textColor;
            float dummyFloat;

            GUI.Label(
                new Rect(10, y, 65, 25), "Altitude: ", gs);
            if (float.TryParse(altitude.AltitudeS, out dummyFloat))
            {
                texFieldGS.normal.textColor = normalColor;
                texFieldGS.hover.textColor = normalColor;
                texFieldGS.active.textColor = normalColor;
                texFieldGS.focused.textColor = normalColor;
            }
            else
            {
                texFieldGS.normal.textColor = errorColor;
                texFieldGS.hover.textColor = errorColor;
                texFieldGS.active.textColor = errorColor;
                texFieldGS.focused.textColor = errorColor;
            }
            String sAltitude = GUI.TextField(new Rect(80, y, 50, 25), altitude.AltitudeS, texFieldGS);
            float fAltitude = GUI.HorizontalSlider(new Rect(135, y + 5, 115, 25), altitude.AltitudeF, 0, 22000);
            altitude.Update(fAltitude, sAltitude);
            return y + 30;
        }

        private int HandleColorGUI(ColorSetGUI color, int y)
        {
            GUIStyle gs = new GUIStyle(GUI.skin.label);
            gs.alignment = TextAnchor.MiddleRight;
            GUIStyle texFieldGS = new GUIStyle(GUI.skin.textField);
            Color errorColor = new Color(1, 0, 0);
            Color normalColor = texFieldGS.normal.textColor;
            float dummyFloat;

            GUI.Label(
                new Rect(10, y, 65, 25), "Color: R: ", gs);
            if (float.TryParse(color.Red, out dummyFloat))
            {
                texFieldGS.normal.textColor = normalColor;
                texFieldGS.hover.textColor = normalColor;
                texFieldGS.active.textColor = normalColor;
                texFieldGS.focused.textColor = normalColor;
            }
            else
            {
                texFieldGS.normal.textColor = errorColor;
                texFieldGS.hover.textColor = errorColor;
                texFieldGS.active.textColor = errorColor;
                texFieldGS.focused.textColor = errorColor;
            }
            string SRed = GUI.TextField(new Rect(80, y, 50, 25), color.Red, texFieldGS);
            float FRed = GUI.HorizontalSlider(new Rect(135, y + 5, 115, 25), color.Color.r, 0, 1);
            y += 30;
            GUI.Label(
                new Rect(10, y, 65, 25), "G: ", gs);
            if (float.TryParse(color.Green, out dummyFloat))
            {
                texFieldGS.normal.textColor = normalColor;
                texFieldGS.hover.textColor = normalColor;
                texFieldGS.active.textColor = normalColor;
                texFieldGS.focused.textColor = normalColor;
            }
            else
            {
                texFieldGS.normal.textColor = errorColor;
                texFieldGS.hover.textColor = errorColor;
                texFieldGS.active.textColor = errorColor;
                texFieldGS.focused.textColor = errorColor;
            }
            string SGreen = GUI.TextField(new Rect(80, y, 50, 25), color.Green, texFieldGS);
            float FGreen = GUI.HorizontalSlider(new Rect(135, y + 5, 115, 25), color.Color.g, 0, 1);
            y += 30;
            GUI.Label(
                new Rect(10, y, 65, 25), "B: ", gs);
            if (float.TryParse(color.Blue, out dummyFloat))
            {
                texFieldGS.normal.textColor = normalColor;
                texFieldGS.hover.textColor = normalColor;
                texFieldGS.active.textColor = normalColor;
                texFieldGS.focused.textColor = normalColor;
            }
            else
            {
                texFieldGS.normal.textColor = errorColor;
                texFieldGS.hover.textColor = errorColor;
                texFieldGS.active.textColor = errorColor;
                texFieldGS.focused.textColor = errorColor;
            }
            string SBlue = GUI.TextField(new Rect(80, y, 50, 25), color.Blue, texFieldGS);
            float FBlue = GUI.HorizontalSlider(new Rect(135, y + 5, 115, 25), color.Color.b, 0, 1);
            y += 30;
            GUI.Label(
                new Rect(10, y, 65, 25), "A: ", gs);
            if (float.TryParse(color.Alpha, out dummyFloat))
            {
                texFieldGS.normal.textColor = normalColor;
                texFieldGS.hover.textColor = normalColor;
                texFieldGS.active.textColor = normalColor;
                texFieldGS.focused.textColor = normalColor;
            }
            else
            {
                texFieldGS.normal.textColor = errorColor;
                texFieldGS.hover.textColor = errorColor;
                texFieldGS.active.textColor = errorColor;
                texFieldGS.focused.textColor = errorColor;
            }
            string SAlpha = GUI.TextField(new Rect(80, y, 50, 25), color.Alpha, texFieldGS);
            float FAlpha = GUI.HorizontalSlider(new Rect(135, y + 5, 115, 25), color.Color.a, 0, 1);
            color.Update(SRed, FRed, SGreen, FGreen, SBlue, FBlue, SAlpha, FAlpha);
            return y += 30;
        }

        private int HandleTextureGUI(TextureSetGUI textureSet, int y)
        {

            GUIStyle labelGS = new GUIStyle(GUI.skin.label);
            labelGS.alignment = TextAnchor.MiddleRight;
            GUIStyle texFieldGS = new GUIStyle(GUI.skin.textField);
            Color errorColor = new Color(1, 0, 0);
            Color normalColor = texFieldGS.normal.textColor;
            float dummyFloat;

            float vectorWidth = (_mainWindowRect.width - 140) / 2;
            float vectorStart = 105 + (_mainWindowRect.width - 140) / 2;

            textureSet.TextureFile = GUI.TextField(
                new Rect(90, y, _mainWindowRect.width - 100, 25), textureSet.TextureFile);
            y += 30;
            GUI.Label(
                new Rect(10, y, 90, 25), "  Scale:", labelGS);
            if (float.TryParse(textureSet.Scale, out dummyFloat))
            {
                texFieldGS.normal.textColor = normalColor;
                texFieldGS.hover.textColor = normalColor;
                texFieldGS.active.textColor = normalColor;
                texFieldGS.focused.textColor = normalColor;
            }
            else
            {
                texFieldGS.normal.textColor = errorColor;
                texFieldGS.hover.textColor = errorColor;
                texFieldGS.active.textColor = errorColor;
                texFieldGS.focused.textColor = errorColor;
            }
            textureSet.Scale = GUI.TextField(
                new Rect(100, y, vectorWidth, 25), textureSet.Scale, texFieldGS);
            y += 30;
            GUI.Label(
                new Rect(10, y, 90, 25), "  Offset: X:", labelGS);
            if (float.TryParse(textureSet.StartOffsetX, out dummyFloat))
            {
                texFieldGS.normal.textColor = normalColor;
                texFieldGS.hover.textColor = normalColor;
                texFieldGS.active.textColor = normalColor;
                texFieldGS.focused.textColor = normalColor;
            }
            else
            {
                texFieldGS.normal.textColor = errorColor;
                texFieldGS.hover.textColor = errorColor;
                texFieldGS.active.textColor = errorColor;
                texFieldGS.focused.textColor = errorColor;
            }
            textureSet.StartOffsetX = GUI.TextField(
                new Rect(100, y, vectorWidth, 25), textureSet.StartOffsetX, texFieldGS);
            GUI.Label(
                new Rect(vectorStart, y, 25, 25), "  Y:", labelGS);
            if (float.TryParse(textureSet.StartOffsetY, out dummyFloat))
            {
                texFieldGS.normal.textColor = normalColor;
                texFieldGS.hover.textColor = normalColor;
                texFieldGS.active.textColor = normalColor;
                texFieldGS.focused.textColor = normalColor;
            }
            else
            {
                texFieldGS.normal.textColor = errorColor;
                texFieldGS.hover.textColor = errorColor;
                texFieldGS.active.textColor = errorColor;
                texFieldGS.focused.textColor = errorColor;
            }
            textureSet.StartOffsetY = GUI.TextField(
                new Rect(vectorStart + 25, y, vectorWidth, 25), textureSet.StartOffsetY, texFieldGS);
            y += 30;
            GUI.Label(
                new Rect(10, y, 90, 25), "  Speed: X:", labelGS);
            if (float.TryParse(textureSet.SpeedX, out dummyFloat))
            {
                texFieldGS.normal.textColor = normalColor;
                texFieldGS.hover.textColor = normalColor;
                texFieldGS.active.textColor = normalColor;
                texFieldGS.focused.textColor = normalColor;
            }
            else
            {
                texFieldGS.normal.textColor = errorColor;
                texFieldGS.hover.textColor = errorColor;
                texFieldGS.active.textColor = errorColor;
                texFieldGS.focused.textColor = errorColor;
            }
            textureSet.SpeedX = GUI.TextField(
                new Rect(100, y, vectorWidth, 25), textureSet.SpeedX, texFieldGS);
            GUI.Label(
                new Rect(vectorStart, y, 25, 25), "  Y:", labelGS);
            if (float.TryParse(textureSet.SpeedY, out dummyFloat))
            {
                texFieldGS.normal.textColor = normalColor;
                texFieldGS.hover.textColor = normalColor;
                texFieldGS.active.textColor = normalColor;
                texFieldGS.focused.textColor = normalColor;
            }
            else
            {
                texFieldGS.normal.textColor = errorColor;
                texFieldGS.hover.textColor = errorColor;
                texFieldGS.active.textColor = errorColor;
                texFieldGS.focused.textColor = errorColor;
            }
            textureSet.SpeedY = GUI.TextField(
                new Rect(vectorStart + 25, y, vectorWidth, 25), textureSet.SpeedY, texFieldGS);
            return y + 30;

        }

    }

    internal class ShaderFloats
    {
        public float FalloffPower;
        public float FalloffScale;
        public float DetailDistance;
        public float MinimumLight;
        public float FadeDistance;

        public ShaderFloats()
        {
            this.FalloffPower = 0;
            this.FalloffScale = 0;
            this.DetailDistance = 0;
            this.MinimumLight = 0;
            this.FadeDistance = 0;
        }

        public ShaderFloats(float FalloffPower, float FalloffScale, float DetailDistance, float MinimumLight, float FadeDistance)
        {
            this.FalloffPower = FalloffPower;
            this.FalloffScale = FalloffScale;
            this.DetailDistance = DetailDistance;
            this.MinimumLight = MinimumLight;
            this.FadeDistance = FadeDistance;
        }

        public ShaderFloats(ConfigNode configNode)
        {
            this.FalloffPower = float.Parse(configNode.GetValue("falloffPower"));
            this.FalloffScale = float.Parse(configNode.GetValue("falloffScale"));
            this.DetailDistance = float.Parse(configNode.GetValue("detailDistance"));
            this.MinimumLight = float.Parse(configNode.GetValue("minimumLight"));
            this.FadeDistance = float.Parse(configNode.GetValue("fadeDistance"));
        }

        public void Clone(ShaderFloatsGUI toClone)
        {
            FalloffPower = toClone.FalloffPower;
            FalloffScale = toClone.FalloffScale;
            DetailDistance = toClone.DetailDistance;
            MinimumLight = toClone.MinimumLight;
            FadeDistance = toClone.FadeDistance;
        }

        internal ConfigNode GetNode(string name)
        {
            ConfigNode newNode = new ConfigNode(name);
            newNode.AddValue("falloffPower", this.FalloffPower);
            newNode.AddValue("falloffScale", this.FalloffScale);
            newNode.AddValue("detailDistance", this.DetailDistance);
            newNode.AddValue("minimumLight", this.MinimumLight);
            newNode.AddValue("fadeDistance", this.FadeDistance);
            return newNode;
        }
    }

    internal class ShaderFloatsGUI
    {
        public float FalloffPower;
        public float FalloffScale;
        public float DetailDistance;
        public float MinimumLight;
        public float FadeDistance;
        public String FalloffPowerString;
        public String FalloffScaleString;
        public String DetailDistanceString;
        public String MinimumLightString;
        public String FadeDistanceString;

        public ShaderFloatsGUI()
        {
            this.FalloffPower = 0;
            this.FalloffScale = 0;
            this.DetailDistance = 0;
            this.MinimumLight = 0;
            this.FadeDistance = 0;
            this.FalloffPowerString = "0";
            this.FalloffScaleString = "0";
            this.DetailDistanceString = "0";
            this.MinimumLightString = "0";
            this.FadeDistanceString = "0";
        }

        public ShaderFloatsGUI(float FalloffPower, float FalloffScale, float DetailDistance, float MinimumLight, float FadeDistance)
        {
            this.FalloffPower = FalloffPower;
            this.FalloffScale = FalloffScale;
            this.DetailDistance = DetailDistance;
            this.MinimumLight = MinimumLight;
            this.FadeDistance = FadeDistance;
            FalloffPowerString = FalloffPower.ToString("R");
            FalloffScaleString = FalloffScale.ToString("R");
            DetailDistanceString = DetailDistance.ToString("R");
            MinimumLightString = MinimumLight.ToString("R");
            FadeDistanceString = FadeDistance.ToString("R");
        }

        public void Clone(ShaderFloats toClone)
        {
            FalloffPower = toClone.FalloffPower;
            FalloffScale = toClone.FalloffScale;
            DetailDistance = toClone.DetailDistance;
            MinimumLight = toClone.MinimumLight;
            FadeDistance = toClone.FadeDistance;
            FalloffPowerString = FalloffPower.ToString("R");
            FalloffScaleString = FalloffScale.ToString("R");
            DetailDistanceString = DetailDistance.ToString("R");
            MinimumLightString = MinimumLight.ToString("R");
            FadeDistanceString = FadeDistance.ToString("R");
        }

        internal void Update(string SFalloffPower, float FFalloffPower, string SFalloffScale, float FFalloffScale, string SDetailDistance, float FDetailDistance, string SMinimumLight, float FMinimumLight, string SFadeDist, float FFadeDist)
        {
            if (this.FalloffPowerString != SFalloffPower)
            {
                this.FalloffPowerString = SFalloffPower;
                float.TryParse(SFalloffPower, out this.FalloffPower);
            }
            else if (this.FalloffPower != FFalloffPower)
            {
                this.FalloffPower = FFalloffPower;
                this.FalloffPowerString = FFalloffPower.ToString("R");
            }
            if (this.FalloffScaleString != SFalloffScale)
            {
                this.FalloffScaleString = SFalloffScale;
                float.TryParse(SFalloffScale, out this.FalloffScale);
            }
            else if (this.FalloffScale != FFalloffScale)
            {
                this.FalloffScale = FFalloffScale;
                this.FalloffScaleString = FFalloffScale.ToString("R");
            }
            if (this.DetailDistanceString != SDetailDistance)
            {
                this.DetailDistanceString = SDetailDistance;
                float.TryParse(SDetailDistance, out this.DetailDistance);
            }
            else if (this.DetailDistance != FDetailDistance)
            {
                this.DetailDistance = FDetailDistance;
                this.DetailDistanceString = FDetailDistance.ToString("R");
            }
            if (this.MinimumLightString != SMinimumLight)
            {
                this.MinimumLightString = SMinimumLight;
                float.TryParse(SMinimumLight, out this.MinimumLight);
            }
            else if (this.MinimumLight != FMinimumLight)
            {
                this.MinimumLight = FMinimumLight;
                this.MinimumLightString = FMinimumLight.ToString("R");
            }
            if (this.FadeDistanceString != SFadeDist)
            {
                this.FadeDistanceString = SFadeDist;
                float.TryParse(SFadeDist, out this.FadeDistance);
            }
            else if (this.FadeDistance != FFadeDist)
            {
                this.FadeDistance = FFadeDist;
                this.FadeDistanceString = FFadeDist.ToString("R");
            }
        }

        internal bool IsValid()
        {

            float dummy;
            if (float.TryParse(FalloffPowerString, out dummy) &&
                float.TryParse(FalloffScaleString, out dummy) &&
                float.TryParse(DetailDistanceString, out dummy) &&
                float.TryParse(MinimumLightString, out dummy) &&
                float.TryParse(FadeDistanceString, out dummy))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }

    internal class CloudGUI
    {
        public TextureSetGUI MainTexture = new TextureSetGUI();
        public TextureSetGUI DetailTexture = new TextureSetGUI();
        public TextureSetGUI BumpTexture = new TextureSetGUI();
        public ColorSetGUI Color = new ColorSetGUI();
        public AltitudeSetGUI Altitude = new AltitudeSetGUI();
        public ShaderFloatsGUI ScaledShaderFloats = new ShaderFloatsGUI();
        public ShaderFloatsGUI ShaderFloats = new ShaderFloatsGUI();

        internal bool IsValid()
        {
            if (MainTexture.IsValid() &&
                DetailTexture.IsValid() &&
                BumpTexture.IsValid() &&
                Color.IsValid() &&
                Altitude.IsValid() &&
                ScaledShaderFloats.IsValid() &&
                ShaderFloats.IsValid())
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }

    
}
