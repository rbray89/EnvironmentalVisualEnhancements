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

    public class CubemapWrapper
    {

        private static Dictionary<String,CubemapWrapper> CubemapList = new Dictionary<String,CubemapWrapper>();

        private TextureTypeEnum type;
        private bool isNormal;
        public string name;

        Texture2D texPositive;
        Texture2D texNegative;
        Cubemap cubeTex;

        public CubemapWrapper(string value, TextureTypeEnum cubeType, bool isNormal, bool isClamped)
        {
            this.name = value;
            this.isNormal = isNormal;
            type = cubeType;
            if (type == TextureTypeEnum.RGB2_CubeMap)
            {
                texPositive = GameDatabase.Instance.GetTexture(value + "+", isNormal);
                texPositive.wrapMode = isClamped ? TextureWrapMode.Clamp : TextureWrapMode.Repeat;
                texNegative = GameDatabase.Instance.GetTexture(value + "-", isNormal);
                texNegative.wrapMode = isClamped ? TextureWrapMode.Clamp : TextureWrapMode.Repeat;

                KSPLog.print("Creating " + name + " Cubemap");
            }
            else if (type == TextureTypeEnum.CubeMap || type == TextureTypeEnum.AlphaCubeMap)
            {
                Texture2D tex = GameDatabase.Instance.GetTexture(value + "_" + Enum.GetName(typeof(CubemapFace), CubemapFace.PositiveX), isNormal);
                if (tex != null)
                {
                    cubeTex = new Cubemap(tex.width, TextureFormat.RGBA32, true);
                    foreach (CubemapFace face in Enum.GetValues(typeof(CubemapFace)))
                    {
                        tex = GameDatabase.Instance.GetTexture(value + "_" + Enum.GetName(typeof(CubemapFace), face), isNormal);
                        cubeTex.SetPixels(tex.GetPixels(), face);
                        GameDatabase.Instance.RemoveTexture(tex.name);
                        GameObject.DestroyImmediate(tex);
                    }
                    cubeTex.Apply(true, true);
                    cubeTex.SmoothEdges();
                }
            }
        }

        internal void ApplyCubeMap(Material mat, string name)
        {
            if (type == TextureTypeEnum.RGB2_CubeMap)
            {
                mat.SetTexture("cube" + name + "POS", texPositive);
                mat.SetTexture("cube" + name + "NEG", texNegative);
                mat.EnableKeyword("CUBE_RGB2" + name);
                KSPLog.print("Applying " + name + " Cubemap");
            }
            else
            {
                //Right now we don't load the cubemaps really... Should consider setting it up.
                mat.SetTexture("cube" + name, cubeTex);
                mat.EnableKeyword("CUBE" + name);
            }
        }

        internal static bool Exists(string value, TextureTypeEnum type)
        {
            if (type == TextureTypeEnum.RGB2_CubeMap)
            {
                return GameDatabase.Instance.ExistsTexture(value + "+") && GameDatabase.Instance.ExistsTexture(value + "-");
            }
            else
            {
                foreach (CubemapFace face in Enum.GetValues(typeof(CubemapFace)))
                {
                    if (!GameDatabase.Instance.ExistsTexture(value + "_" + Enum.GetName(typeof(CubemapFace), face)))
                    { return false; }
                    return true;
                }
                return false;
            }
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
                CubemapWrapper cubemap = new CubemapWrapper(textureWrapper.Name, textureWrapper.Type, textureWrapper.IsNormal, textureWrapper.IsClamped);
                CubemapList[textureWrapper.Name] = cubemap;
                return cubemap;
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

    public enum TextureFormatSimplified
    {
        Default = -1,
        RGBA32 = TextureFormat.RGBA32,
        RGB24 = TextureFormat.RGB24,
        DXT1 = TextureFormat.DXT1,
        DXT5 = TextureFormat.DXT5
    }

    [ValueNode, ValueFilter("isClamped|format")]
    public class TextureWrapper
    {
        bool isNormal = false;

#pragma warning disable 0649
#pragma warning disable 0414
        [Persistent]
        string value;
        [Persistent]
        bool isClamped = false;
        [Persistent]
        TextureFormatSimplified format = TextureFormatSimplified.Default;
        [Persistent]
        TextureTypeEnum type = TextureTypeEnum.RGBA;
        [Persistent, Conditional("alphaMaskEval")]
        AlphaMaskEnum alphaMask = AlphaMaskEnum.ALPHAMAP_A;
        

        public bool IsNormal { get { return isNormal; } set { isNormal = value; } }
        public bool IsClamped { get { return isClamped; } set { isClamped = value; } }
        public string Name { get { return value; } }
        public TextureFormatSimplified Format { get { return format; } }
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
                cubeMap.ApplyCubeMap(mat, name);
            }
            else
            {
                texture = GameDatabase.Instance.GetTextureInfo(value);
            }
            if (texture != null)
            {
                mat.SetTexture(name, texture.texture);
                KSPLog.print("Setting texure "+value);
            }
            if ((type & TextureTypeEnum.AlphaMapMask) > 0)
            {
                mat.EnableKeyword(alphaMask + name);
            }
        }

        public bool isValid()
        {
            if ((type & TextureTypeEnum.CubeMapMask) > 0)
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

            if (node.HasValue("type"))
            {
                TextureTypeEnum type = (TextureTypeEnum)ConfigNode.ParseEnum(typeof(TextureTypeEnum), node.GetValue("type"));
                if ((type & TextureTypeEnum.AlphaMapMask) > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }
    }
}
