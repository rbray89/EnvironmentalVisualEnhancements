using EVEManager;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using Utils;

namespace Terrain
{
    
    public class TerrainMaterial : MaterialManager
    {
        [Persistent] 
        Color32 _Color = Color.white;
        [Persistent]
        String _MainTex = "";
		[Persistent]
        String _midTex = "";
		[Persistent] 
        String _steepTex = "";
        [Persistent]
        String _BumpMap = "";
        [Persistent]
        float _DetailScale = 4000f;
        [Persistent]
        float _DetailVertScale = 200f;
        [Persistent]
        float _DetailDist = 0.00875f;
        [Persistent]
        float _MinLight = .5f;
        [Persistent]
        Color32 _SpecColor = Color.grey;
        [Persistent]
        float _Shininess = .4f;
        [Persistent]
        float _Albedo = .02f;
        [Persistent]
        Color32 _OceanColor = Color.blue;
        [Persistent]
        float _OceanDepthFactor = .002f;
    }

    public class OceanMaterial : MaterialManager
    {
        [Persistent]
        Color32 _SurfaceColor = Color.white;
        [Persistent]
        String _DetailTex = "";
        [Persistent]
        float _DetailScale = 4000f;
        [Persistent]
        float _DetailDist = 0.00875f;
        [Persistent]
        float _MinLight = .5f;
        [Persistent]
        float _Clarity = .005f;
        [Persistent]
        float _LightPower = 1.75f;
        [Persistent]
        float _Reflectivity = .08f;
    }

    public class TerrainObject : IEVEObject
    {
        public String Name { get { return body; } set { } }
        public ConfigNode ConfigNode { get { return node; } }
        public String Body { get { return body; } }
        private String body;
        private ConfigNode node;
        [Persistent, Optional] 
        TerrainMaterial terrainMaterial = null;
        [Persistent, Optional]
        OceanMaterial oceanMaterial = null;

        TerrainPQS terrainPQS;

        public void LoadConfigNode(ConfigNode node, String body)
        {
            ConfigNode.LoadObjectFromConfig(this, node);
            this.node = node;
            this.body = body;
        }
        public ConfigNode GetConfigNode()
        {
            return ConfigNode.CreateConfigFromObject(this, new ConfigNode(body));
        }

        public void Apply()
        {
            GameObject go = new GameObject();
            terrainPQS = go.AddComponent<TerrainPQS>();
            terrainPQS.Apply( body, terrainMaterial, oceanMaterial );
        }

        public void Remove()
        {
            terrainPQS.Remove();
            GameObject go = terrainPQS.gameObject;
            GameObject.DestroyImmediate(terrainPQS);
            GameObject.DestroyImmediate(go);
        }
    }
}
