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
        AlphaMap = 0x6,
        CubeMap = 0xc,
        AlphaCubeMap = 0x4,
        RGB2_CubeMap = 0x8,
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

        Texture2D texPlus;
        Texture2D texMinus;
        Cubemap cubTex;

        public CubemapWrapper(string value, TextureTypeEnum cubeType, bool isNormal, bool isClamped)
        {
            this.name = value;
            this.isNormal = isNormal;
            type = cubeType;
            if (type == TextureTypeEnum.RGB2_CubeMap)
            {
                texPlus = GameDatabase.Instance.GetTexture(value + "+", isNormal);
                texPlus.wrapMode = isClamped ? TextureWrapMode.Clamp : TextureWrapMode.Repeat;
                texMinus = GameDatabase.Instance.GetTexture(value + "-", isNormal);
                texMinus.wrapMode = isClamped ? TextureWrapMode.Clamp : TextureWrapMode.Repeat;

                KSPLog.print("Creating " + name + " Cubemap");
            }
            else if(type == TextureTypeEnum.CubeMap || type == TextureTypeEnum.AlphaCubeMap)
            {
                
            }
        }

        internal void ApplyCubeMap(Material mat, string name)
        {
            if (type == TextureTypeEnum.RGB2_CubeMap)
            {
                mat.SetTexture("cube" + name + "POS", texPlus);
                mat.SetTexture("cube" + name + "NEG", texMinus);
                mat.EnableKeyword("CUBE_RGB2" + name);
                KSPLog.print("Applying " + name + " Cubemap");
            }
            else
            {
                //Right now we don't load the cubemaps really... Should consider setting it up.
                mat.SetTexture("cube" + name, null);
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
                return false;
            }
        }
    }

    [ValueNode]
    public class TextureWrapper
    {
        private static List<CubemapWrapper> CubemapList = new List<CubemapWrapper>();
        bool isNormal = false;

        [Persistent]
        string value;
        [Persistent]
        bool isClamped = false;
        [Persistent]
        TextureTypeEnum type;
        [Persistent, Conditional("alphaMaskEval")]
        Vector4 alphaMask = new Vector4(0, 0, 0, 1);

        public TextureTypeEnum Type { get { return type; } }
        public Vector4 AlphaMask { get { return alphaMask; } set { alphaMask = value; } }

        public bool IsNormal { get { return isNormal; } set { isNormal = value; } }
        public bool IsClamped { get { return isClamped; } set { isClamped = value; } }

        public TextureWrapper()
        {
        }

        public TextureWrapper(string tex)
        {
            value = tex;
        }

        public TextureWrapper(ConfigNode node)
        {
            if (node != null)
            {
                try
                {
                    if (node.HasValue("value"))
                        value = node.GetValue("value");
                    if (node.HasValue("isClamped"))
                        isClamped = bool.Parse(node.GetValue("isClamped"));
                    if (node.HasValue("type"))
                        type = (TextureTypeEnum)ConfigNode.ParseEnum(typeof(TextureTypeEnum), node.GetValue("type"));
                    if (node.HasValue("alphaMask"))
                        alphaMask = ConfigNode.ParseVector4(node.GetValue("alphaMask"));
                }
                catch { }
            }
        }

        public void ApplyTexture(Material mat, string name)
        {
            Texture texture = null;
            if ((type & TextureTypeEnum.CubeMap) > 0)
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
        

        public bool exists()
        {
            bool cubemapExists = CubemapList.Exists(c => c.name == value);
            if ((type & TextureTypeEnum.CubeMap) > 0)
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
                if ((type & TextureTypeEnum.AlphaMap) > 0)
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
