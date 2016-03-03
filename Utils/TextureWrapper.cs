using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Utils
{
    [Flags]
    public enum TextureTypeEnum
    {
        RGBA = 0x1,
        AlphaMap = 0x2,
        CubeMap = 0x4,
        AlphaCubeMap = 0x8,
        [EnumMask] //This will hide it from the GUI until it is supported.
        RGB2_CubeMap = 0x10,

        [EnumMask]
        CubeMapMask = CubeMap | AlphaCubeMap | RGB2_CubeMap,
        [EnumMask]
        AlphaMapMask = AlphaMap | AlphaCubeMap
    }

    [Flags]
    public enum TextureMasksEnum
    {
    }

    public class TextureType : System.Attribute
    {
        public TextureTypeEnum Type;
        public TextureType(TextureTypeEnum type)
        {
            Type = type;
        }
    }

    public class BumpMap : System.Attribute
    { }

    public class Clamped : System.Attribute
    {
    }

    public class Index : System.Attribute
    {
        public int value;
        public Index(int i)
        {
            value = i;
        }
    }

    public class CubemapWrapper
    {

        private static Dictionary<String,CubemapWrapper> CubemapList = new Dictionary<String,CubemapWrapper>();

        private TextureTypeEnum type;
        public string name;

        Texture2D texPositive;
        Texture2D texNegative;
        Texture2D[] texList;
        Cubemap cubeTex;

        public CubemapWrapper(string value, Texture2D[] textures, TextureTypeEnum cubeType, bool mipmaps, bool readable)
        {
            this.name = value;
            type = cubeType == TextureTypeEnum.RGB2_CubeMap? TextureTypeEnum.RGB2_CubeMap : TextureTypeEnum.CubeMap;
            KSPLog.print("Creating " + name + " Cubemap");

            foreach (Texture2D tex in textures)
            {
                tex.wrapMode = TextureWrapMode.Clamp;
            }

            if (type == TextureTypeEnum.RGB2_CubeMap)
            {
                texPositive = textures[0];
                texNegative = textures[1];
            }
            else
            {
                /*
                cubeTex = new Cubemap(textures[0].width, TextureFormat.RGBA32, mipmaps);
                
                foreach (CubemapFace face in Enum.GetValues(typeof(CubemapFace)))
                {
                    Texture2D tex = textures[(int)face];
                    cubeTex.SetPixels(tex.GetPixels(), face);
                }
                cubeTex.Apply(mipmaps, !readable);
                cubeTex.SmoothEdges();
                */
                texList = textures;
                
            }
        }

        public static void GenerateCubemapWrapper(string value, Texture2D[] textures, TextureTypeEnum cubeType, bool mipmaps, bool readable)
        {
            CubemapList[value] = new CubemapWrapper(value, textures, cubeType, mipmaps, readable);
        }

        internal void ApplyCubeMap(Material mat, string name, int index)
        {
            if (type == TextureTypeEnum.RGB2_CubeMap)
            {
                mat.SetTexture("cube" + name + "POS", texPositive);
                mat.SetTexture("cube" + name + "NEG", texNegative);
                mat.EnableKeyword("MAP_TYPE_CUBE2_" + index.ToString());
                KSPLog.print("Applying " + name + " Cubemap");
            }
            else
            {
                /*
                KSPLog.print("Setting cube" + name);
                mat.SetTexture("cube" + name, cubeTex);
                mat.EnableKeyword("MAP_TYPE_CUBE_" + index.ToString());
                */
                mat.SetTexture("cube" + name + "xn", texList[(int)CubemapFace.NegativeX]);
                mat.SetTexture("cube" + name + "yn", texList[(int)CubemapFace.NegativeY]);
                mat.SetTexture("cube" + name + "zn", texList[(int)CubemapFace.NegativeZ]);
                mat.SetTexture("cube" + name + "xp", texList[(int)CubemapFace.PositiveX]);
                mat.SetTexture("cube" + name + "yp", texList[(int)CubemapFace.PositiveY]);
                mat.SetTexture("cube" + name + "zp", texList[(int)CubemapFace.PositiveZ]);
                mat.EnableKeyword("MAP_TYPE_CUBE6_" + index.ToString());
                
            }
        }

        internal static bool Exists(string value, TextureTypeEnum type)
        {
            //Only the one type supported for now
            return (CubemapList.ContainsKey(value));// && CubemapList[value].type == type);
        }

        public static CubemapWrapper fetchCubeMap(TextureWrapper textureWrapper)
        {
            bool cubemapExists = CubemapList.ContainsKey(textureWrapper.Name);
            if (cubemapExists)
            {
                return CubemapList[textureWrapper.Name];
            }
            else
            {
                return null;
            }
        }
    }

    public enum AlphaMaskEnum
    {
        ALPHAMAP_R,
        ALPHAMAP_G,
        ALPHAMAP_B,
        ALPHAMAP_A
    }



    [ValueNode, ValueFilter("isClamped|format")]
    public class TextureWrapper
    {
        bool isNormal = false;

#pragma warning disable 0649
#pragma warning disable 0414
        [ConfigItem, GUIHidden, NodeValue]
        string value;
        [ConfigItem]
        bool isClamped = false;
        [ConfigItem]
        TextureTypeEnum type = TextureTypeEnum.RGBA;
        [ConfigItem, Conditional("alphaMaskEval")]
        AlphaMaskEnum alphaMask = AlphaMaskEnum.ALPHAMAP_A;

        int index = 0;
        public bool IsNormal { get { return isNormal; } set { isNormal = value; } }
        public bool IsClamped { get { return isClamped; } set { isClamped = value; } }
        public int Index { get { return index; } set { index = value; } }
        public string Name { get { return value; } }
        public TextureTypeEnum Type { get { return type; } }
        public AlphaMaskEnum AlphaMask { get { return alphaMask; } }

        public TextureWrapper()
        {

        }

        public void ApplyTexture(Material mat, string name)
        {
            GameDatabase.TextureInfo texture = null;
            if ((type & TextureTypeEnum.CubeMapMask) > 0)
            {
                CubemapWrapper cubeMap = CubemapWrapper.fetchCubeMap(this);
                if (cubeMap != null)
                {
                    cubeMap.ApplyCubeMap(mat, name, index);
                }
            }
            else
            {
                texture = GameDatabase.Instance.GetTextureInfo(value);
            }
            if (texture != null)
            {
                texture.texture.wrapMode = isClamped ? TextureWrapMode.Clamp : TextureWrapMode.Repeat;
                mat.SetTexture(name, texture.texture);
            }
            if ((type & TextureTypeEnum.AlphaMapMask) > 0)
            {
                mat.EnableKeyword(alphaMask+"_"+ index);
            }
        }

        public bool isValid()
        {
            if (value == null || value == "")
            {
                return true;
            }
            else if ((type & TextureTypeEnum.CubeMapMask) > 0)
            {
                return CubemapWrapper.Exists(value, type);
            }
            else
            {
                return GameDatabase.Instance.ExistsTexture(value);
            }
        }

        public static bool alphaMaskEval(ConfigNode node)
        {
            TextureWrapper test = new TextureWrapper();
            ConfigHelper.LoadObjectFromConfig(test, node);
            
            if ((test.type & TextureTypeEnum.AlphaMapMask) > 0)
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
