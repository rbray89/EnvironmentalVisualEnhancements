using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Utils
{

    public class BumpMap : System.Attribute
    { }

    public class Clamped : System.Attribute
    {
    }

    public class CubemapWrapper
    {
        enum CubeType
        {
            Unity,
            ColorMapped
        }

        private CubeType type;
        private bool isNormal;
        public string name;

        Texture2D texPlus;
        Texture2D texMinus;

        public CubemapWrapper(string value, bool isNormal)
        {
            this.name = value;
            this.isNormal = isNormal;
            texPlus = GameDatabase.Instance.GetTexture(value + "+", isNormal);
            texMinus = GameDatabase.Instance.GetTexture(value + "-", isNormal);
            type = CubeType.ColorMapped;
        }

        internal void ApplyCubeMap(Material mat, string name)
        {
            if (type == CubeType.ColorMapped)
            {
                mat.SetTexture("cube" + name + "POS", texPlus);
                mat.SetTexture("cube" + name + "NEG", texMinus);
                mat.EnableKeyword("CUBE_RGB2" + name);
            }
            else
            {
                //Right now we don't load the cubemaps really... Should consider setting it up.
                mat.SetTexture("cube" + name, null);
                mat.EnableKeyword("CUBE" + name);
            }
        }

        internal static bool Exists(string value)
        {
            return GameDatabase.Instance.ExistsTexture(value + "+") && GameDatabase.Instance.ExistsTexture(value + "-");
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
                if(node.HasValue("value"))
                    value = node.GetValue("value");
                if (node.HasValue("isClamped"))
                    isClamped = bool.Parse(node.GetValue("isClamped"));
                if (node.HasValue("type"))
                    type = (TextureTypeEnum) ConfigNode.ParseEnum(typeof(TextureTypeEnum), node.GetValue("type"));
                if (node.HasValue("alphaMask"))
                    alphaMask = ConfigNode.ParseVector4(node.GetValue("alphaMask"));
            }
        }

        public void ApplyTexture(Material mat, string name)
        {
            Texture texture = null;
            if (type == TextureTypeEnum.AlphaCubeMap || type == TextureTypeEnum.CubeMap)
            {
                bool cubemapExists = CubemapList.Exists(c => c.name == value);
                CubemapWrapper cubeMap = fetchCubeMap(value, isNormal);
                CubemapList.Add(cubeMap);
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

        private CubemapWrapper fetchCubeMap(string value, bool isNormal)
        {
            bool cubemapExists = CubemapList.Exists(c => c.name == value);
            if(cubemapExists)
            {
                return CubemapList.First(c => c.name == value);
            }
            else
            {
                CubemapWrapper cubemap = new CubemapWrapper(value, isNormal);
                CubemapList.Add(cubemap);
                return cubemap;
            }
        }
        

        public bool exists()
        {
            bool cubemapExists = CubemapList.Exists(c => c.name == value);
            if (type == TextureTypeEnum.AlphaCubeMap || type == TextureTypeEnum.CubeMap)
            {
                if(!cubemapExists)
                {
                    cubemapExists = CubemapWrapper.Exists(value);
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
                if (type == TextureTypeEnum.AlphaCubeMap || type == TextureTypeEnum.AlphaMap)
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
