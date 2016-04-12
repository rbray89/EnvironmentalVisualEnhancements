using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Utils
{

    [KSPAddon(KSPAddon.Startup.Instantly, true)]
    public class ShaderProperties : MonoBehaviour
    {

        public static int ROTATION_PROPERTY { get { return _Rotation; } }
        private static int _Rotation;
        public static int INVROTATION_PROPERTY { get { return _InvRotation; } }
        private static int _InvRotation;
        public static int MAIN_ROTATION_PROPERTY { get { return _MainRotation; } }
        private static int _MainRotation;
        public static int DETAIL_ROTATION_PROPERTY { get { return _DetailRotation; } }
        private static int _DetailRotation;
        public static int SHADOWOFFSET_PROPERTY { get { return _ShadowOffset; } }
        private static int _ShadowOffset;
        public static int SUNDIR_PROPERTY { get { return _SunDir; } }
        private static int _SunDir;
        public static int PLANET_ORIGIN_PROPERTY { get { return _PlanetOrigin; } }
        private static int _PlanetOrigin;
        public static int WORLD_2_PLANET_PROPERTY { get { return _World2Planet; } }
        private static int _World2Planet;


        public static int _MainTex_PROPERTY { get { return _MainTex; } }
        private static int _MainTex;
        public static int _BumpMap_PROPERTY { get { return _BumpMap; } }
        private static int _BumpMap;
        public static int _Emissive_PROPERTY { get { return _Emissive; } }
        private static int _Emissive;
        public static int _SunRadius_PROPERTY { get { return _SunRadius; } }
        private static int _SunRadius;
        public static int _SunPos_PROPERTY { get { return _SunPos; } }
        private static int _SunPos;
        public static int _ShadowBodies_PROPERTY { get { return _ShadowBodies; } }
        private static int _ShadowBodies;



        private void Awake()
        {
            _Rotation = Shader.PropertyToID("_Rotation");
            _InvRotation = Shader.PropertyToID("_InvRotation");
            _MainRotation = Shader.PropertyToID("_MainRotation");
            _DetailRotation = Shader.PropertyToID("_DetailRotation");
            _ShadowOffset = Shader.PropertyToID("_ShadowOffset");
            _SunDir = Shader.PropertyToID("_SunDir");
            _PlanetOrigin = Shader.PropertyToID("_PlanetOrigin");
            _World2Planet = Shader.PropertyToID("_World2Planet");

            _MainTex = Shader.PropertyToID("_MainTex");
            _BumpMap = Shader.PropertyToID("_BumpMap");
            _Emissive = Shader.PropertyToID("_Emissive");


            _SunRadius = Shader.PropertyToID("_SunRadius");
            _SunPos = Shader.PropertyToID("_SunPos");
            _ShadowBodies = Shader.PropertyToID("_ShadowBodies");
        }
    }
}
