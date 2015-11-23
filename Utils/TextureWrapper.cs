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

    public class TextureWrapper
    {
        string value;

        
        bool isNormal = false;
        bool isClamped = false;

        TextureTypeEnum type;
        Vector4 alphaMask = new Vector4(0, 0, 0, 1);
        
        public TextureTypeEnum Type { get { return type; } }
        public Vector4 AlphaMask { get { return alphaMask; } set { alphaMask = value; } }

        public TextureWrapper(string tex)
        {
            value = tex;
        }

        public Texture2D GetTexture(bool isNormal, bool isClamped)
        {
            Texture2D texture = GameDatabase.Instance.GetTexture(value, isNormal);
            if (texture != null)
            {
                texture.wrapMode = isClamped ? TextureWrapMode.Clamp : TextureWrapMode.Repeat;
            }
            return texture;
        }

        public Texture2D GetTexture()
        {
            Texture2D texture = GameDatabase.Instance.GetTexture(value, isNormal);
            if (texture != null)
            {
                texture.wrapMode = isClamped ? TextureWrapMode.Clamp : TextureWrapMode.Repeat;
            }
            return texture;
        }

        public bool exists()
        {
            return GameDatabase.Instance.ExistsTexture(value);
        }
    }
}
