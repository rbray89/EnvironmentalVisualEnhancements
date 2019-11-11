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
#pragma warning disable 0169
#pragma warning disable 0414
        [ConfigItem] 
        Color _Color = 256 * Color.white;
        [ConfigItem]
        TextureWrapper _MainTex;
		[ConfigItem]
        TextureWrapper _midTex;
		[ConfigItem]
        TextureWrapper _steepTex;
        [ConfigItem]
        TextureWrapper _BumpMap;
        [ConfigItem]
        float _DetailScale = 4000f;
        [ConfigItem]
        float _DetailVertScale = 200f;
        [ConfigItem]
        float _DetailDist = 0.00875f;
        [ConfigItem]
        float _MinLight = 0f;
        [ConfigItem]
        Color _SpecularColor = Color.grey;
        [ConfigItem]
        float _SpecularPower = 51.2f;
        [ConfigItem]
        float _Albedo = .02f;
        [ConfigItem]
        Color _OceanColor = Color.blue;
        [ConfigItem]
        float _OceanDepthFactor = .002f;
    }

    public class OceanMaterial : MaterialManager
    {
        [ConfigItem]
        Color _SurfaceColor = 256 * Color.white;
        [ConfigItem]
        TextureWrapper _DetailTex;
        [ConfigItem]
        float _DetailScale = 4000f;
        [ConfigItem]
        float _DetailDist = 0.00875f;
        [ConfigItem]
        float _MinLight = 0f;
        [ConfigItem]
        float _Clarity = .005f;
        [ConfigItem]
        float _LightPower = 1.75f;
        [ConfigItem]
        float _Reflectivity = .08f;
    }

    public class TerrainObject : IEVEObject
    {
#pragma warning disable 0649
        public override String ToString() { return body; }
        [ConfigItem, GUIHidden]
        String body;
        [ConfigItem, Optional] 
        TerrainMaterial terrainMaterial = null;
        [ConfigItem, Optional]
        OceanMaterial oceanMaterial = null;

        TerrainPQS terrainPQS;

        public void LoadConfigNode(ConfigNode node)
        {
            ConfigHelper.LoadObjectFromConfig(this, node);
        }

        public void Apply()
        {
            GameObject go = new GameObject();
            go.name = "EVE Terrain";
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
