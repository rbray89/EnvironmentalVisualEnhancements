using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Utils
{
    public class TextureManager
    {
        [Persistent] String name = null;
        [Persistent] float scale = 0;
        [Persistent] Vector3 offset = Vector3.zero;
        public String Name { get { return name; } }
        public float Scale { get { return scale; } }
        public Vector3 Offset { get { return offset; } }

        public Texture2D GetTexture(bool normal = false)
        {
            return GameDatabase.Instance.GetTexture(name, normal);
        }
    }
}
