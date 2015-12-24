using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;

namespace Utils
{
    public class TextureConverter
    {
        private static byte[] placeholder = new byte[] {   0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, 0x00,
                                                    0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x02, 0x08, 0x02, 0x00, 0x00, 0x00, 0xFD, 0xD4, 0x9A, 0x73, 0x00,
                                                    0x00, 0x00, 0x16, 0x49, 0x44, 0x41, 0x54, 0x08, 0xD7, 0x63, 0xFC, 0xFF, 0xFF, 0x3F, 0x03, 0x03, 0x03,
                                                    0x13, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x00, 0x24, 0x06, 0x03, 0x01, 0xBD, 0x1E, 0xE3, 0xBA, 0x00,
                                                    0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82 };

        private static bool texHasAlpha(byte[] colors)
        {
            for (int i = 3; i < colors.Length; i += 4)
            {
                if (colors[i] < byte.MaxValue)
                {
                    return true;
                }
            }
            return false;
        }

        private static Color32[] ResizePixels(Color32[] pixels, int width, int height, int newWidth, int newHeight)
        {
            Color32[] newPixels = new Color32[newWidth * newHeight];
            int index = 0;
            for (int h = 0; h < newHeight; h++)
            {
                for (int w = 0; w < newWidth; w++)
                {
                    newPixels[index++] = GetPixel(pixels, width, height, ((float)w) / newWidth, ((float)h) / newHeight, newWidth, newHeight);
                }
            }
            return newPixels;
        }

        public static void ConvertToUnityNormalMap(Color32[] colors)
        {
            for(int i = 0; i < colors.Length; i++)
            {
                colors[i].a = colors[i].r;
                colors[i].r = colors[i].g;
                colors[i].b = colors[i].g;
            }
        }

        private static Color32 GetPixel(Color32[] pixels, int width, int height, float w, float h, int newWidth, int newHeight)
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

            Color32 cw1 = new Color32(), cw2 = new Color32(), cw3 = new Color32(), cw4 = new Color32(), ch1 = new Color32(), ch2 = new Color32(), ch3 = new Color32(), ch4 = new Color32();
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
                    cw2 = pixels[w2+ (h2*width)];
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
            byte R = (byte)((cwr + chr) / 2.0f);
            byte G = (byte)((cwg + chg) / 2.0f);
            byte B = (byte)((cwb + chb) / 2.0f);
            byte A = (byte)((cwa + cha) / 2.0f);

            Color32 color = new Color32(R, G, B, A);
            return color;
        }

        public static void MBMToTexture(GameDatabase.TextureInfo texture, TextureFormat format, bool mipmaps)
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
                convertToNormalFormat = texture.isNormalMap ? true : false;
            }

            mbmStream.Position = 16;
            int mbmFormat = mbmStream.ReadByte();
            mbmStream.Position += 3;

            int imageSize = (int)(width * height * 3);
            bool alpha = false;
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
                }
                else
                {
                    colors[i].a = 255;
                }
                if(convertToNormalFormat)
                {
                    colors[i].a = colors[i].r;
                    colors[i].r = colors[i].g;
                    colors[i].b = colors[i].g;
                }
            }


            texture.texture = new Texture2D((int)width, (int)height, format, mipmaps);
            texture.texture.SetPixels32(colors);
            texture.texture.Apply(mipmaps, false);
        }

        public static void IMGToTexture(GameDatabase.TextureInfo texture, TextureFormat format, bool mipmaps)
        {
            byte[] imageBuffer = System.IO.File.ReadAllBytes(texture.file.fullPath);

            Texture2D tex = new Texture2D(2,2);
            bool convertToNormalFormat = texture.isNormalMap ? true : false;
            bool hasMipmaps = tex.mipmapCount == 1 ? false : true;


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
                
            texture.texture = new Texture2D(tex.width, tex.height, format, mipmaps);
            texture.texture.SetPixels32(colors);
            texture.texture.Apply(mipmaps, false);

        }

        public static void TGAToTexture(GameDatabase.TextureInfo texture, TextureFormat format, bool mipmaps)
        {

            byte[] imageBuffer = System.IO.File.ReadAllBytes(texture.file.fullPath);

            byte imgType = imageBuffer[2];
            int width = imageBuffer[12] | (imageBuffer[13] << 8);
            int height = imageBuffer[14] | (imageBuffer[15] << 8);

            int depth = imageBuffer[16];
            bool alpha = depth == 32 ? true : false;
            
            bool convertToNormalFormat = texture.isNormalMap ? true : false; 
            

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
                KSPLog.print("TGA format is not supported!");
            }

            texture.texture = new Texture2D(width, height, format, mipmaps);
            texture.texture.SetPixels32(colors);
            texture.texture.Apply(mipmaps, false);
        }

        public static void DDSToTexture(GameDatabase.TextureInfo texture, TextureFormat format, bool mipmaps)
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
                if (fourcc)
                {
                    if (dDSHeader.ddspf.dwFourCC == DDSHeaders.DDSValues.uintDXT1)
                    {
                        texture.texture = new Texture2D((int)dDSHeader.dwWidth, (int)dDSHeader.dwHeight, TextureFormat.DXT1, mipmap);
                        texture.texture.LoadRawTextureData(binaryReader.ReadBytes((int)(binaryReader.BaseStream.Length - binaryReader.BaseStream.Position)));
                    }
                    else if (dDSHeader.ddspf.dwFourCC == DDSHeaders.DDSValues.uintDXT3)
                    {
                        texture.texture = new Texture2D((int)dDSHeader.dwWidth, (int)dDSHeader.dwHeight, (TextureFormat)11, mipmap);
                        texture.texture.LoadRawTextureData(binaryReader.ReadBytes((int)(binaryReader.BaseStream.Length - binaryReader.BaseStream.Position)));
                    }
                    else if (dDSHeader.ddspf.dwFourCC == DDSHeaders.DDSValues.uintDXT5)
                    {
                        texture.texture = new Texture2D((int)dDSHeader.dwWidth, (int)dDSHeader.dwHeight, TextureFormat.DXT5, mipmap);
                        texture.texture.LoadRawTextureData(binaryReader.ReadBytes((int)(binaryReader.BaseStream.Length - binaryReader.BaseStream.Position)));
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
                        texture.texture = new Texture2D((int)dDSHeader.dwWidth, (int)dDSHeader.dwHeight, textureFormat, mipmap);
                        texture.texture.LoadRawTextureData(binaryReader.ReadBytes((int)(binaryReader.BaseStream.Length - binaryReader.BaseStream.Position)));
                    }

                }
            }
            else
                Debug.Log("Bad DDS header.");
        }

        public static bool GetReadable(GameDatabase.TextureInfo texture, TextureFormat texFormat = 0, bool mipmaps = true)
        {
            KSPLog.print("Getting readable tex from " + texture.file.url +"."+ texture.file.fileExtension);

            TextureFormat format = texFormat == 0 ? TextureFormat.RGBA32 : texFormat;

            if (texture.file.fileExtension == "png" ||
            texture.file.fileExtension == "truecolor")
            {
                IMGToTexture(texture, format, mipmaps);
                texture.texture.name = texture.name;
                return true;
            }
            else if (texture.file.fileExtension == "jpg" ||
            texture.file.fileExtension == "jpeg")
            {
                IMGToTexture(texture, format, mipmaps);
                texture.texture.name = texture.name;
                return true;
            }
            else if (texture.file.fileExtension == "tga")
            {
                TGAToTexture(texture, format, mipmaps);
                texture.texture.name = texture.name;
                return true;
            }
            else if (texture.file.fileExtension == "dds")
            {
                DDSToTexture(texture, format, mipmaps);
                texture.texture.name = texture.name;
                return true;
            }
            else if (texture.file.fileExtension == "mbm")
            {
                MBMToTexture(texture, format, mipmaps);
                texture.texture.name = texture.name;
                return true;
            }
            return false;
        }

        public static void Reload(GameDatabase.TextureInfo texInfo)
        {
            GameDatabase.TextureInfo tmp = new GameDatabase.TextureInfo(texInfo.file, new Texture2D(2, 2), texInfo.isNormalMap, texInfo.isReadable, texInfo.isCompressed);
            GetReadable(tmp);
            Color32[] orig = tmp.texture.GetPixels32();
            tmp.texture.Resize(tmp.texture.width, tmp.texture.height, TextureFormat.RGBA32, false);
            tmp.texture.SetPixels32(orig);
            texInfo.texture.LoadImage(tmp.texture.EncodeToPNG());
            GameObject.DestroyImmediate(tmp.texture);
        }

        public static void Minimize(GameDatabase.TextureInfo texInfo)
        {
            if (texInfo.texture.width != 32 || texInfo.texture.height != 32)
            {
                texInfo.texture.LoadImage(placeholder);
                System.GC.Collect();
                Debug.Log("Freeing " + texInfo.texture.name);
                
                string scaled = Directory.GetParent(Assembly.GetExecutingAssembly().Location)+ "/texCache/" + texInfo.file.url;

                if (File.Exists(scaled))
                {
                    byte[] png = System.IO.File.ReadAllBytes(scaled);
                    texInfo.texture.LoadImage(png);
                }
                else
                {
                    GameDatabase.TextureInfo tmp = new GameDatabase.TextureInfo(texInfo.file, new Texture2D(2, 2), texInfo.isNormalMap, texInfo.isReadable, texInfo.isCompressed);
                    GetReadable(tmp);
                    Color32[] resized = TextureConverter.ResizePixels(tmp.texture.GetPixels32(), tmp.texture.width, tmp.texture.height, 32, 32);
                    tmp.texture.Resize(32, 32, TextureFormat.RGBA32, false);
                    tmp.texture.SetPixels32(resized);
                    byte[] png = tmp.texture.EncodeToPNG();
                    Directory.GetParent(scaled).Create();
                    System.IO.File.WriteAllBytes(scaled, png);

                    Debug.Log("Caching @" + scaled);
                    texInfo.texture.LoadImage(png);
                    GameObject.DestroyImmediate(tmp.texture);
                }
            }
        }
    }
}
