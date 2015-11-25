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
 
}
