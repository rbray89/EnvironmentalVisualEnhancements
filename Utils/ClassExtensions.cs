using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Utils
{
    public static class ColorExtensions
    {
        public static uint u(this Color32 color)
        {
            return (uint)(color.r | (color.g << 8) | (color.b << 16) | (color.a << 24));
        }

        public static byte[] component(this Color32 color)
        {
            return new byte[4] { color.b, color.g, color.r, color.a };
        }
    }

    public static class Texture2DExtensions
    {
        public static byte[] bytes(this Texture2D texture, int mipmapLevel, bool hasAlpha = true)
        {
            Color32[] colors = texture.GetPixels32(mipmapLevel);
            byte[] array;
            if (hasAlpha)
            {
                array = new byte[colors.Length * 4];
                for (int i = 0; i < colors.Length; i++)
                {
                    array[(i * 4)] = colors[i].r;
                    array[(i * 4) + 1] = colors[i].g;
                    array[(i * 4) + 2] = colors[i].b;
                    array[(i * 4) + 3] = colors[i].a;
                }
            }
            else
            {
                array = new byte[colors.Length * 3];
                for (int i = 0; i < colors.Length; i++)
                {
                    array[(i * 3)] = colors[i].r;
                    array[(i * 3) + 1] = colors[i].g;
                    array[(i * 3) + 2] = colors[i].b;
                }
            }
            return array;
        }
    }
    
}
