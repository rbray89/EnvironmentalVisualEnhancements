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
    }

    public enum AlphaMaskEnum
    {
        [EnumMask]
        ALPHAMAP_NONE,
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

    [ValueNode("isClamped|format")]
    public class TextureWrapper
    {
        private static List<CubemapWrapper> CubemapList = new List<CubemapWrapper>();
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
        AlphaMaskEnum alphaMask = AlphaMaskEnum.ALPHAMAP_NONE;
        

        public bool IsNormal { get { return isNormal; } set { isNormal = value; } }
        public bool IsClamped { get { return isClamped; } set { isClamped = value; } }

        public TextureWrapper()
        {

        } 

        public void ApplyTexture(Material mat, string name)
        {
            Texture texture = null;
            if ((type & TextureTypeEnum.CubeMapMask) > 0)
            {
                CubemapWrapper cubeMap = fetchCubeMap();
                cubeMap.ApplyCubeMap(mat, name);
            }
            else
            {
                texture = GameDatabase.Instance.GetTexture(value, isNormal);
            }
            if (texture != null)
            {
                texture.wrapMode = isClamped ? TextureWrapMode.Clamp : TextureWrapMode.Repeat;
                mat.SetTexture(name, texture);
                KSPLog.print("Setting texure "+value);
            }
            mat.EnableKeyword(alphaMask + name);
        }

        private CubemapWrapper fetchCubeMap()
        {
            bool cubemapExists = CubemapList.Exists(c => c.name == value);
            if(cubemapExists)
            {
                return CubemapList.First(c => c.name == value);
            }
            else
            {
                CubemapWrapper cubemap = new CubemapWrapper(value, type, isNormal, isClamped);
                CubemapList.Add(cubemap);
                return cubemap;
            }
        }
        

        public bool isValid()
        {
            bool cubemapExists = CubemapList.Exists(c => c.name == value);
            if ((type & TextureTypeEnum.CubeMapMask) > 0)
            {
                if(!cubemapExists)
                {
                    cubemapExists = CubemapWrapper.Exists(value, type);
                }
                return cubemapExists;
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
