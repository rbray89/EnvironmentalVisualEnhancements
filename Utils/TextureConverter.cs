using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using UnityEngine;

namespace Utils
{
    public class TextureConverter
    {

        private static Color32[] ResizePixels(Color32[] pixels, int width, int height, int newWidth, int newHeight)
        {
            if (width != newWidth || height != newHeight)
            {
                Color32[] newPixels = new Color32[newWidth * newHeight];
                int index = 0;
                for (int h = 0; h < newHeight; h++)
                {
                    for (int w = 0; w < newWidth; w++)
                    {
                        GetPixel(ref newPixels[index++], pixels, width, height, ((float)w) / newWidth, ((float)h) / newHeight, newWidth, newHeight);
                    }
                }
                return newPixels;
            }
            else
            {
                return pixels;
            }
        }


        static Color32 cw1 = new Color32();
        static Color32 cw2 = new Color32();
        static Color32 cw3 = new Color32();
        static Color32 cw4 = new Color32();
        static Color32 ch1 = new Color32();
        static Color32 ch2 = new Color32();
        static Color32 ch3 = new Color32();
        static Color32 ch4 = new Color32();
        private static void GetPixel(ref Color32 newPixel, Color32[] pixels, int width, int height, float w, float h, int newWidth, int newHeight)
        {
            float widthDist = 4.0f - ((4.0f * (float)newWidth) / width);
            float heightDist = 4.0f - ((4.0f * (float)newHeight) / height);
            int[,] posArray = new int[2, 4];
            posArray[0, 0] = (int)Math.Floor((w * width) - widthDist);
            posArray[0, 1] = (int)Math.Floor(w * width);
            posArray[0, 2] = (int)Math.Ceiling((w * width) + widthDist);
            posArray[0, 3] = (int)Math.Ceiling((w * width) + (2.0 * widthDist));
            posArray[1, 0] = (int)Math.Floor((h * height) - heightDist);
            posArray[1, 1] = (int)Math.Floor(h * height);
            posArray[1, 2] = (int)Math.Ceiling((h * height) + heightDist);
            posArray[1, 3] = (int)Math.Ceiling((h * height) + (2.0 * heightDist));


            int w1 = posArray[0, 0];
            int w2 = posArray[0, 1];
            int w3 = posArray[0, 2];
            int w4 = posArray[0, 3];
            int h1 = posArray[1, 0];
            int h2 = posArray[1, 1];
            int h3 = posArray[1, 2];
            int h4 = posArray[1, 3];

            if (h2 >= 0 && h2 < height)
            {
                if (w2 >= 0 && w2 < width)
                {
                    cw2 = pixels[w2 + (h2 * width)];
                }
                if (w1 >= 0 && w1 < width)
                {
                    cw1 = pixels[w1 + (h2 * width)];
                }
                else
                {
                    cw1 = cw2;
                }
                if (w3 >= 0 && w3 < width)
                {
                    cw3 = pixels[w3 + (h2 * width)];
                }
                else
                {
                    cw3 = cw2;
                }
                if (w4 >= 0 && w4 < width)
                {
                    cw4 = pixels[w4 + (h2 * width)];
                }
                else
                {
                    cw4 = cw3;
                }

            }
            if (w2 >= 0 && w2 < width)
            {
                if (h2 >= 0 && h2 < height)
                {
                    ch2 = pixels[w2 + (h2 * width)];
                }
                if (h1 >= 0 && h1 < height)
                {
                    ch1 = pixels[w2 + (h1 * width)];
                }
                else
                {
                    ch1 = ch2;
                }
                if (h3 >= 0 && h3 < height)
                {
                    ch3 = pixels[w2 + (h3 * width)];
                }
                else
                {
                    ch3 = ch2;
                }
                if (h4 >= 0 && h4 < height)
                {
                    ch4 = pixels[w2 + (h4 * width)];
                }
                else
                {
                    ch4 = ch3;
                }
            }
            byte cwr = (byte)(((.25f * cw1.r) + (.75f * cw2.r) + (.75f * cw3.r) + (.25f * cw4.r)) / 2.0f);
            byte cwg = (byte)(((.25f * cw1.g) + (.75f * cw2.g) + (.75f * cw3.g) + (.25f * cw4.g)) / 2.0f);
            byte cwb = (byte)(((.25f * cw1.b) + (.75f * cw2.b) + (.75f * cw3.b) + (.25f * cw4.b)) / 2.0f);
            byte cwa = (byte)(((.25f * cw1.a) + (.75f * cw2.a) + (.75f * cw3.a) + (.25f * cw4.a)) / 2.0f);
            byte chr = (byte)(((.25f * ch1.r) + (.75f * ch2.r) + (.75f * ch3.r) + (.25f * ch4.r)) / 2.0f);
            byte chg = (byte)(((.25f * ch1.g) + (.75f * ch2.g) + (.75f * ch3.g) + (.25f * ch4.g)) / 2.0f);
            byte chb = (byte)(((.25f * ch1.b) + (.75f * ch2.b) + (.75f * ch3.b) + (.25f * ch4.b)) / 2.0f);
            byte cha = (byte)(((.25f * ch1.a) + (.75f * ch2.a) + (.75f * ch3.a) + (.25f * ch4.a)) / 2.0f);
            newPixel.r = (byte)((cwr + chr) / 2.0f);
            newPixel.g = (byte)((cwg + chg) / 2.0f);
            newPixel.b = (byte)((cwb + chb) / 2.0f);
            newPixel.a = (byte)((cwa + cha) / 2.0f);
        }

        private static bool HasAlpha(Color32[] colors)
        {
            foreach (Color32 color in colors)
            {
                if (color.a < byte.MaxValue)
                {
                    return true;
                }
            }
            return false;
        }

        public static void MBMToTexture(GameDatabase.TextureInfo texture, bool inPlace, Vector2 size, string cache = null, bool mipmaps = false)
        {

            FileStream mbmStream = new FileStream(texture.file.fullPath, FileMode.Open, FileAccess.Read);
            mbmStream.Position = 4;

            uint width = 0, height = 0;
            for (int b = 0; b < 4; b++)
            {
                width >>= 8;
                width |= (uint)(mbmStream.ReadByte() << 24);
            }
            for (int b = 0; b < 4; b++)
            {
                height >>= 8;
                height |= (uint)(mbmStream.ReadByte() << 24);
            }
            mbmStream.Position = 12;
            bool convertToNormalFormat = false;
            if (mbmStream.ReadByte() == 1)
            {
                texture.isNormalMap = true;
            }
            else
            {
                convertToNormalFormat = texture.isNormalMap;
            }

            mbmStream.Position = 16;
            int mbmFormat = mbmStream.ReadByte();
            mbmStream.Position += 3;

            int imageSize = (int)(width * height * 3);
            bool alpha = false;
            bool hasAlpha = false;
            if (mbmFormat == 32)
            {
                imageSize += (int)(width * height);
                alpha = true;
            }

            byte[] imageBuffer = new byte[mbmStream.Length];
            mbmStream.Read(imageBuffer, 0, imageBuffer.Length);


            mbmStream.Close();



            Color32[] colors = new Color32[width * height];
            int n = 0;
            for (int i = 0; i < width * height; i++)
            {
                colors[i].r = imageBuffer[n++];
                colors[i].g = imageBuffer[n++];
                colors[i].b = imageBuffer[n++];
                if (alpha)
                {
                    colors[i].a = imageBuffer[n++];
                    if (colors[i].a < Byte.MaxValue)
                    {
                        hasAlpha = true;
                    }
                }
                else
                {
                    colors[i].a = 255;
                }
                if (convertToNormalFormat)
                {
                    colors[i].a = colors[i].r;
                    colors[i].r = colors[i].g;
                    colors[i].b = colors[i].g;
                }
            }

            TextureFormat format = hasAlpha ? TextureFormat.RGBA32 : TextureFormat.RGB24;
            Vector2 newSize = size == default(Vector2) ? new Vector2(width, height) : size;
            if (inPlace)
            {
                //This is a small hack to re-load the texture, even when it isn't readable. Unfortnately,
                //we can't control compression, mipmaps, or anything else really, as the texture is still
                //marked as unreadable. This will update the size and pixel data however.
                colors = ResizePixels(colors, (int)width, (int)height, (int)newSize.x, (int)newSize.y);
                Texture2D tmpTex = new Texture2D((int)newSize.x, (int)newSize.y, TextureFormat.ARGB32, mipmaps);
                tmpTex.SetPixels32(colors);
                tmpTex.Apply(false);
                byte[] file;
                if (hasAlpha)
                {
                    file = tmpTex.EncodeToPNG();
                }
                else
                {
                    file = tmpTex.EncodeToPNG();//file = tmpTex.EncodeToJPG();
                }
                if (cache != null)
                {
                    Directory.GetParent(cache).Create();
                    System.IO.File.WriteAllBytes(cache, file);
                }
                texture.texture.LoadImage(file);
                GameObject.DestroyImmediate(tmpTex);
            }
            else
            {
                colors = ResizePixels(colors, (int)width, (int)height, (int)newSize.x, (int)newSize.y);
                GameObject.DestroyImmediate(texture.texture);
                texture.texture = new Texture2D((int)newSize.x, (int)newSize.y, format, mipmaps);
                texture.texture.SetPixels32(colors);
                if (texture.isCompressed)
                {
                    texture.texture.Compress(true);
                }
                texture.texture.Apply(mipmaps, !texture.isReadable);
            }
        }

        public static void IMGToTexture(GameDatabase.TextureInfo texture, bool inPlace, Vector2 size, string cache = null, bool mipmaps = false)
        {
            byte[] imageBuffer = System.IO.File.ReadAllBytes(texture.file.fullPath);

            Texture2D tex = new Texture2D(2, 2);
            bool convertToNormalFormat = texture.isNormalMap;

            tex.LoadImage(imageBuffer);

            Color32[] colors = tex.GetPixels32();

            if (convertToNormalFormat)
            {
                for (int i = 0; i < colors.Length; i++)
                {
                    colors[i].a = colors[i].r;
                    colors[i].r = colors[i].g;
                    colors[i].b = colors[i].g;
                }
            }

            bool hasAlpha = HasAlpha(colors);

            TextureFormat format = hasAlpha ? TextureFormat.RGBA32 : TextureFormat.RGB24;
            Vector2 newSize = size == default(Vector2) ? new Vector2(tex.width, tex.height) : size;
            if (inPlace)
            {
                //This is a small hack to re-load the texture, even when it isn't readable. Unfortnately,
                //we can't control compression, mipmaps, or anything else really, as the texture is still
                //marked as unreadable. This will update the size and pixel data however.
                colors = ResizePixels(colors, tex.width, tex.height, (int)newSize.x, (int)newSize.y);
                Texture2D tmpTex = new Texture2D((int)newSize.x, (int)newSize.y, TextureFormat.ARGB32, mipmaps);
                tmpTex.SetPixels32(colors);
                tmpTex.Apply(false);
                //TODO: this could be optimized when not resizing to use the encoding above.
                byte[] file;
                if (hasAlpha)
                {
                    file = tmpTex.EncodeToPNG();
                }
                else
                {
                    file = tmpTex.EncodeToPNG();//file = tmpTex.EncodeToJPG();
                }
                if (cache != null)
                {
                    Directory.GetParent(cache).Create();
                    System.IO.File.WriteAllBytes(cache, file);
                }
                texture.texture.LoadImage(file);
                GameObject.DestroyImmediate(tmpTex);
            }
            else
            {
                colors = ResizePixels(colors, tex.width, tex.height, (int)newSize.x, (int)newSize.y);
                GameObject.DestroyImmediate(texture.texture);
                texture.texture = new Texture2D((int)newSize.x, (int)newSize.y, format, mipmaps);
                texture.texture.SetPixels32(colors);
                if (texture.isCompressed)
                {
                    texture.texture.Compress(true);
                }
                texture.texture.Apply(mipmaps, !texture.isReadable);
            }

            GameObject.DestroyImmediate(tex);
        }

        public static void TGAToTexture(GameDatabase.TextureInfo texture, bool inPlace, Vector2 size, string cache = null, bool mipmaps = false)
        {

            byte[] imageBuffer = System.IO.File.ReadAllBytes(texture.file.fullPath);

            byte imgType = imageBuffer[2];
            int width = imageBuffer[12] | (imageBuffer[13] << 8);
            int height = imageBuffer[14] | (imageBuffer[15] << 8);

            int depth = imageBuffer[16];
            bool alpha = depth == 32 ? true : false;
            bool hasAlpha = false;
            bool convertToNormalFormat = texture.isNormalMap;


            Color32[] colors = new Color32[width * height];
            int n = 18;
            if (imgType == 2)
            {
                for (int i = 0; i < width * height; i++)
                {
                    colors[i].b = imageBuffer[n++];
                    colors[i].g = imageBuffer[n++];
                    colors[i].r = imageBuffer[n++];
                    if (alpha)
                    {
                        colors[i].a = imageBuffer[n++];
                        if (colors[i].a < byte.MaxValue)
                        {
                            hasAlpha = false;
                        }
                    }
                    else
                    {
                        colors[i].a = 255;
                    }
                    if (convertToNormalFormat)
                    {
                        colors[i].a = colors[i].r;
                        colors[i].r = colors[i].g;
                        colors[i].b = colors[i].g;
                    }
                }
            }
            else if (imgType == 10)
            {
                int i = 0;
                int run = 0;
                while (i < width * height)
                {
                    run = imageBuffer[n++];
                    if ((run & 0x80) != 0)
                    {
                        run = (run ^ 0x80) + 1;
                        colors[i].b = imageBuffer[n++];
                        colors[i].g = imageBuffer[n++];
                        colors[i].r = imageBuffer[n++];
                        if (alpha)
                        {
                            colors[i].a = imageBuffer[n++];
                        }
                        else
                        {
                            colors[i].a = 255;
                        }
                        if (convertToNormalFormat)
                        {
                            colors[i].a = colors[i].r;
                            colors[i].r = colors[i].g;
                            colors[i].b = colors[i].g;
                        }
                        i++;
                        for (int c = 1; c < run; c++, i++)
                        {
                            colors[i] = colors[i - 1];
                        }
                    }
                    else
                    {
                        run += 1;
                        for (int c = 0; c < run; c++, i++)
                        {
                            colors[i].b = imageBuffer[n++];
                            colors[i].g = imageBuffer[n++];
                            colors[i].r = imageBuffer[n++];
                            if (alpha)
                            {
                                colors[i].a = imageBuffer[n++];
                            }
                            else
                            {
                                colors[i].a = 255;
                            }
                            if (convertToNormalFormat)
                            {
                                colors[i].a = colors[i].r;
                                colors[i].r = colors[i].g;
                                colors[i].b = colors[i].g;
                            }
                        }
                    }
                }
            }
            else
            {
                Debug.Log("TGA format is not supported!");
            }

            TextureFormat format = hasAlpha ? TextureFormat.RGBA32 : TextureFormat.RGB24;
            Vector2 newSize = size == default(Vector2) ? new Vector2(width, height) : size;
            if (inPlace)
            {
                //This is a small hack to re-load the texture, even when it isn't readable. Unfortnately,
                //we can't control compression, mipmaps, or anything else really, as the texture is still
                //marked as unreadable. This will update the size and pixel data however.
                colors = ResizePixels(colors, (int)width, (int)height, (int)newSize.x, (int)newSize.y);
                Texture2D tmpTex = new Texture2D((int)newSize.x, (int)newSize.y, TextureFormat.ARGB32, mipmaps);
                tmpTex.SetPixels32(colors);
                tmpTex.Apply(false);
                byte[] file;
                if (hasAlpha)
                {
                    file = tmpTex.EncodeToPNG();
                }
                else
                {
                    file = tmpTex.EncodeToPNG();//file = tmpTex.EncodeToJPG();
                }
                if (cache != null)
                {
                    Directory.GetParent(cache).Create();
                    System.IO.File.WriteAllBytes(cache, file);
                }
                texture.texture.LoadImage(file);
                GameObject.DestroyImmediate(tmpTex);
            }
            else
            {
                colors = ResizePixels(colors, (int)width, (int)height, (int)newSize.x, (int)newSize.y);
                GameObject.DestroyImmediate(texture.texture);
                texture.texture = new Texture2D((int)newSize.x, (int)newSize.y, format, mipmaps);
                texture.texture.SetPixels32(colors);
                if (texture.isCompressed)
                {
                    texture.texture.Compress(true);
                }
                texture.texture.Apply(mipmaps, !texture.isReadable);
            }
        }

        public static void DDSToTexture(GameDatabase.TextureInfo texture, bool inPlace, Vector2 size, string cache = null, bool mipmaps = false)
        {
            /**
             * Kopernicus Planetary System Modifier
             * ====================================
             * Created by: BryceSchroeder and Teknoman117 (aka. Nathaniel R. Lewis)
             * Maintained by: Thomas P., NathanKell and KillAshley
             * Additional Content by: Gravitasi, aftokino, KCreator, Padishar, Kragrathea, OvenProofMars, zengei, MrHappyFace
             * ------------------------------------------------------------- 
             * This library is free software; you can redistribute it and/or
             * modify it under the terms of the GNU Lesser General Public
             * License as published by the Free Software Foundation; either
             * version 3 of the License, or (at your option) any later version.
             *
             * This library is distributed in the hope that it will be useful,
             * but WITHOUT ANY WARRANTY; without even the implied warranty of
             * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
             * Lesser General Public License for more details.
             *
             * You should have received a copy of the GNU Lesser General Public
             * License along with this library; if not, write to the Free Software
             * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
             * MA 02110-1301  USA
             * 
             * This library is intended to be used as a plugin for Kerbal Space Program
             * which is copyright 2011-2015 Squad. Your usage of Kerbal Space Program
             * itself is governed by the terms of its EULA, not the license above.
             * 
             * https://kerbalspaceprogram.com
             */
            // Borrowed from stock KSP 1.0 DDS loader (hi Mike!)
            // Also borrowed the extra bits from Sarbian.
            byte[] buffer = System.IO.File.ReadAllBytes(texture.file.fullPath);
            System.IO.BinaryReader binaryReader = new System.IO.BinaryReader(new System.IO.MemoryStream(buffer));
            uint num = binaryReader.ReadUInt32();
            if (num == DDSHeaders.DDSValues.uintMagic)
            {

                DDSHeaders.DDSHeader dDSHeader = new DDSHeaders.DDSHeader(binaryReader);

                if (dDSHeader.ddspf.dwFourCC == DDSHeaders.DDSValues.uintDX10)
                {
                    new DDSHeaders.DDSHeaderDX10(binaryReader);
                }
                bool alpha = (dDSHeader.dwFlags & 0x00000002) != 0;
                bool fourcc = (dDSHeader.dwFlags & 0x00000004) != 0;
                bool rgb = (dDSHeader.dwFlags & 0x00000040) != 0;
                bool alphapixel = (dDSHeader.dwFlags & 0x00000001) != 0;
                bool luminance = (dDSHeader.dwFlags & 0x00020000) != 0;
                bool rgb888 = dDSHeader.ddspf.dwRBitMask == 0x000000ff && dDSHeader.ddspf.dwGBitMask == 0x0000ff00 && dDSHeader.ddspf.dwBBitMask == 0x00ff0000;
                //bool bgr888 = dDSHeader.ddspf.dwRBitMask == 0x00ff0000 && dDSHeader.ddspf.dwGBitMask == 0x0000ff00 && dDSHeader.ddspf.dwBBitMask == 0x000000ff;
                bool rgb565 = dDSHeader.ddspf.dwRBitMask == 0x0000F800 && dDSHeader.ddspf.dwGBitMask == 0x000007E0 && dDSHeader.ddspf.dwBBitMask == 0x0000001F;
                bool argb4444 = dDSHeader.ddspf.dwABitMask == 0x0000f000 && dDSHeader.ddspf.dwRBitMask == 0x00000f00 && dDSHeader.ddspf.dwGBitMask == 0x000000f0 && dDSHeader.ddspf.dwBBitMask == 0x0000000f;
                bool rbga4444 = dDSHeader.ddspf.dwABitMask == 0x0000000f && dDSHeader.ddspf.dwRBitMask == 0x0000f000 && dDSHeader.ddspf.dwGBitMask == 0x000000f0 && dDSHeader.ddspf.dwBBitMask == 0x00000f00;

                bool mipmap = (dDSHeader.dwCaps & DDSHeaders.DDSPixelFormatCaps.MIPMAP) != (DDSHeaders.DDSPixelFormatCaps)0u;
                bool isNormalMap = ((dDSHeader.ddspf.dwFlags & 524288u) != 0u || (dDSHeader.ddspf.dwFlags & 2147483648u) != 0u);

                Vector2 newSize = size == default(Vector2) ? new Vector2(dDSHeader.dwWidth, dDSHeader.dwHeight) : size;
                if (fourcc)
                {
                    if (dDSHeader.ddspf.dwFourCC == DDSHeaders.DDSValues.uintDXT1)
                    {
                        if (inPlace && !texture.isReadable)
                        {
                            //This is a small hack to re-load the texture, even when it isn't readable. Unfortnately,
                            //we can't control compression, mipmaps, or anything else really, as the texture is still
                            //marked as unreadable. This will update the size and pixel data however.
                            Texture2D tmpTex = new Texture2D((int)newSize.x, (int)newSize.y, TextureFormat.ARGB32, mipmap);
                            Texture2D tmpTexSrc = new Texture2D((int)dDSHeader.dwWidth, (int)dDSHeader.dwHeight, TextureFormat.DXT1, mipmap);
                            tmpTexSrc.LoadRawTextureData(binaryReader.ReadBytes((int)(binaryReader.BaseStream.Length - binaryReader.BaseStream.Position)));
                            Color32[] colors = tmpTexSrc.GetPixels32();
                            colors = ResizePixels(colors, tmpTexSrc.width, tmpTexSrc.height, (int)newSize.x, (int)newSize.y);
                            tmpTex.SetPixels32(colors);
                            tmpTex.Apply(false);
                            //size using JPG to force DXT1

                            byte[] file = tmpTex.EncodeToPNG();//tmpTex.EncodeToJPG();
                            if (cache != null)
                            {
                                Directory.GetParent(cache).Create();
                                System.IO.File.WriteAllBytes(cache, file);
                            }
                            texture.texture.LoadImage(file);

                            GameObject.DestroyImmediate(tmpTex);
                            GameDatabase.DestroyImmediate(tmpTexSrc);
                        }
                        else if (inPlace)
                        {
                            texture.texture.Resize((int)dDSHeader.dwWidth, (int)dDSHeader.dwHeight, TextureFormat.RGB24, mipmap);
                            texture.texture.Compress(false);
                            texture.texture.LoadRawTextureData(binaryReader.ReadBytes((int)(binaryReader.BaseStream.Length - binaryReader.BaseStream.Position)));
                            texture.texture.Apply(false, !texture.isReadable);
                        }
                        else
                        {
                            GameObject.DestroyImmediate(texture.texture);
                            texture.texture = new Texture2D((int)dDSHeader.dwWidth, (int)dDSHeader.dwHeight, TextureFormat.DXT1, mipmap);
                            texture.texture.LoadRawTextureData(binaryReader.ReadBytes((int)(binaryReader.BaseStream.Length - binaryReader.BaseStream.Position)));
                            texture.texture.Apply(false, !texture.isReadable);
                        }
                    }
                    else if (dDSHeader.ddspf.dwFourCC == DDSHeaders.DDSValues.uintDXT3)
                    {
                        if (inPlace && !texture.isReadable)
                        {
                            //This is a small hack to re-load the texture, even when it isn't readable. Unfortnately,
                            //we can't control compression, mipmaps, or anything else really, as the texture is still
                            //marked as unreadable. This will update the size and pixel data however.
                            Texture2D tmpTex = new Texture2D((int)newSize.x, (int)newSize.y, TextureFormat.ARGB32, mipmap);
                            Texture2D tmpTexSrc = new Texture2D((int)dDSHeader.dwWidth, (int)dDSHeader.dwHeight, (TextureFormat)11, mipmap);
                            tmpTexSrc.LoadRawTextureData(binaryReader.ReadBytes((int)(binaryReader.BaseStream.Length - binaryReader.BaseStream.Position)));
                            Color32[] colors = tmpTexSrc.GetPixels32();
                            colors = ResizePixels(colors, tmpTexSrc.width, tmpTexSrc.height, (int)newSize.x, (int)newSize.y);
                            tmpTex.SetPixels32(colors);
                            tmpTex.Apply(false);
                            //size using JPG to force DXT5
                            byte[] file = tmpTex.EncodeToPNG();
                            if (cache != null)
                            {
                                Directory.GetParent(cache).Create();
                                System.IO.File.WriteAllBytes(cache, file);
                            }
                            texture.texture.LoadImage(file);

                            GameObject.DestroyImmediate(tmpTex);
                            GameDatabase.DestroyImmediate(tmpTexSrc);
                        }
                        else if (inPlace)
                        {
                            texture.texture.Resize((int)dDSHeader.dwWidth, (int)dDSHeader.dwHeight, (TextureFormat)11, mipmap);
                            texture.texture.LoadRawTextureData(binaryReader.ReadBytes((int)(binaryReader.BaseStream.Length - binaryReader.BaseStream.Position)));
                            texture.texture.Apply(false, !texture.isReadable);
                        }
                        else
                        {
                            GameObject.DestroyImmediate(texture.texture);
                            texture.texture = new Texture2D((int)dDSHeader.dwWidth, (int)dDSHeader.dwHeight, (TextureFormat)11, mipmap);
                            texture.texture.LoadRawTextureData(binaryReader.ReadBytes((int)(binaryReader.BaseStream.Length - binaryReader.BaseStream.Position)));
                            texture.texture.Apply(false, !texture.isReadable);
                        }
                    }
                    else if (dDSHeader.ddspf.dwFourCC == DDSHeaders.DDSValues.uintDXT5)
                    {
                        if (inPlace && !texture.isReadable)
                        {
                            //This is a small hack to re-load the texture, even when it isn't readable. Unfortnately,
                            //we can't control compression, mipmaps, or anything else really, as the texture is still
                            //marked as unreadable. This will update the size and pixel data however.
                            Texture2D tmpTex = new Texture2D((int)newSize.x, (int)newSize.y, TextureFormat.ARGB32, mipmap);
                            Texture2D tmpTexSrc = new Texture2D((int)dDSHeader.dwWidth, (int)dDSHeader.dwHeight, TextureFormat.DXT5, mipmap);
                            tmpTexSrc.LoadRawTextureData(binaryReader.ReadBytes((int)(binaryReader.BaseStream.Length - binaryReader.BaseStream.Position)));
                            Color32[] colors = tmpTexSrc.GetPixels32();
                            colors = ResizePixels(colors, tmpTexSrc.width, tmpTexSrc.height, (int)newSize.x, (int)newSize.y);
                            tmpTex.SetPixels32(colors);
                            tmpTex.Apply(false);
                            //size using JPG to force DXT5 
                            byte[] file = tmpTex.EncodeToPNG();
                            if (cache != null)
                            {
                                Directory.GetParent(cache).Create();
                                System.IO.File.WriteAllBytes(cache, file);
                            }
                            texture.texture.LoadImage(file);
                            GameObject.DestroyImmediate(tmpTex);
                            GameDatabase.DestroyImmediate(tmpTexSrc);
                        }
                        else if (inPlace)
                        {
                            texture.texture.Resize((int)dDSHeader.dwWidth, (int)dDSHeader.dwHeight, TextureFormat.ARGB32, mipmap);
                            texture.texture.Compress(false);

                            texture.texture.LoadRawTextureData(binaryReader.ReadBytes((int)(binaryReader.BaseStream.Length - binaryReader.BaseStream.Position)));
                            texture.texture.Apply(false, !texture.isReadable);
                        }
                        else
                        {
                            GameObject.DestroyImmediate(texture.texture);
                            texture.texture = new Texture2D((int)dDSHeader.dwWidth, (int)dDSHeader.dwHeight, TextureFormat.DXT5, mipmap);
                            texture.texture.LoadRawTextureData(binaryReader.ReadBytes((int)(binaryReader.BaseStream.Length - binaryReader.BaseStream.Position)));
                            texture.texture.Apply(false, !texture.isReadable);
                        }
                    }
                    else if (dDSHeader.ddspf.dwFourCC == DDSHeaders.DDSValues.uintDXT2)
                    {
                        Debug.Log("DXT2 not supported");
                    }
                    else if (dDSHeader.ddspf.dwFourCC == DDSHeaders.DDSValues.uintDXT4)
                    {
                        Debug.Log("DXT4 not supported: ");
                    }
                    else if (dDSHeader.ddspf.dwFourCC == DDSHeaders.DDSValues.uintDX10)
                    {
                        Debug.Log("DX10 dds not supported: ");
                    }
                    else
                        fourcc = false;
                }
                if (!fourcc)
                {
                    TextureFormat textureFormat = TextureFormat.ARGB32;
                    bool ok = true;
                    if (rgb && (rgb888 /*|| bgr888*/))
                    {
                        // RGB or RGBA format
                        textureFormat = alphapixel
                        ? TextureFormat.RGBA32
                        : TextureFormat.RGB24;
                    }
                    else if (rgb && rgb565)
                    {
                        // Nvidia texconv B5G6R5_UNORM
                        textureFormat = TextureFormat.RGB565;
                    }
                    else if (rgb && alphapixel && argb4444)
                    {
                        // Nvidia texconv B4G4R4A4_UNORM
                        textureFormat = TextureFormat.ARGB4444;
                    }
                    else if (rgb && alphapixel && rbga4444)
                    {
                        textureFormat = TextureFormat.RGBA4444;
                    }
                    else if (!rgb && alpha != luminance)
                    {
                        // A8 format or Luminance 8
                        textureFormat = TextureFormat.Alpha8;
                    }
                    else
                    {
                        ok = false;
                        Debug.Log("Only DXT1, DXT5, A8, RGB24, RGBA32, RGB565, ARGB4444 and RGBA4444 are supported");
                    }
                    if (ok)
                    {
                        if (inPlace && !texture.isReadable)
                        {
                            //This is a small hack to re-load the texture, even when it isn't readable. Unfortnately,
                            //we can't control compression, mipmaps, or anything else really, as the texture is still
                            //marked as unreadable. This will update the size and pixel data however.
                            Texture2D tmpTex = new Texture2D((int)newSize.x, (int)newSize.y, TextureFormat.ARGB32, mipmap);
                            Texture2D tmpTexSrc = new Texture2D((int)dDSHeader.dwWidth, (int)dDSHeader.dwHeight, textureFormat, mipmap);
                            tmpTexSrc.LoadRawTextureData(binaryReader.ReadBytes((int)(binaryReader.BaseStream.Length - binaryReader.BaseStream.Position)));
                            Color32[] colors = tmpTexSrc.GetPixels32();
                            colors = ResizePixels(colors, tmpTexSrc.width, tmpTexSrc.height, (int)newSize.x, (int)newSize.y);
                            tmpTex.SetPixels32(colors);
                            tmpTex.Apply(false);
                            //size using JPG to force alpha-less
                            byte[] file;
                            if (alphapixel)
                            {
                                file = tmpTex.EncodeToPNG();
                            }
                            else
                            {
                                file = tmpTex.EncodeToPNG();//file = tmpTex.EncodeToJPG();
                            }
                            if (cache != null)
                            {
                                Directory.GetParent(cache).Create();
                                System.IO.File.WriteAllBytes(cache, file);
                            }
                            texture.texture.LoadImage(file);
                            GameDatabase.DestroyImmediate(tmpTex);
                            GameDatabase.DestroyImmediate(tmpTexSrc);
                        }
                        else if (inPlace)
                        {
                            texture.texture.Resize((int)dDSHeader.dwWidth, (int)dDSHeader.dwHeight, textureFormat, mipmap);
                            texture.texture.LoadRawTextureData(binaryReader.ReadBytes((int)(binaryReader.BaseStream.Length - binaryReader.BaseStream.Position)));
                            texture.texture.Apply(false, !texture.isReadable);
                        }
                        else
                        {
                            GameDatabase.DestroyImmediate(texture.texture);
                            texture.texture = new Texture2D((int)dDSHeader.dwWidth, (int)dDSHeader.dwHeight, textureFormat, mipmap);
                            texture.texture.LoadRawTextureData(binaryReader.ReadBytes((int)(binaryReader.BaseStream.Length - binaryReader.BaseStream.Position)));
                            texture.texture.Apply(false, !texture.isReadable);
                        }
                    }

                }
            }
            else
                Debug.Log("Bad DDS header.");
        }

        public static bool Reload(GameDatabase.TextureInfo texture, bool inPlace, Vector2 size = default(Vector2), string cache = null, bool mipmaps = true)
        {
            Debug.Log("Getting readable tex from " + texture.file.url + "." + texture.file.fileExtension);

            if (texture.file.fileExtension == "jpg" ||
            texture.file.fileExtension == "jpeg" ||
            texture.file.fileExtension == "png" ||
            texture.file.fileExtension == "truecolor")
            {
                IMGToTexture(texture, inPlace, size, cache, mipmaps);
                return true;
            }
            else if (texture.file.fileExtension == "tga")
            {
                TGAToTexture(texture, inPlace, size, cache, mipmaps);
                return true;
            }
            else if (texture.file.fileExtension == "mbm")
            {
                MBMToTexture(texture, inPlace, size, cache, mipmaps);
                return true;
            }
            else if (texture.file.fileExtension == "dds")
            {
                DDSToTexture(texture, inPlace, size, cache, mipmaps);
                return true;
            }
            return false;
        }




    }
}
