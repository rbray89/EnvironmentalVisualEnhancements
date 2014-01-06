using Equirectangular2Cubic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace CommonUtils
{
    public class AltitudeSetGUI
    {
        public float AltitudeF;
        public String AltitudeS;

        public void Clone(float altitude)
        {
            this.AltitudeF = altitude;
            this.AltitudeS = altitude.ToString("R");
        }

        public void Update(float altitudeF, String altitudeS)
        {
            if (this.AltitudeS != altitudeS)
            {
                this.AltitudeS = altitudeS;
                float.TryParse(altitudeS, out AltitudeF);
            }
            else if (AltitudeF != altitudeF)
            {
                this.AltitudeF = altitudeF;
                this.AltitudeS = altitudeF.ToString("R");
            }
        }

        public bool IsValid()
        {
            float dummy;
            return float.TryParse(AltitudeS, out dummy);
        }
    }

    public class ColorSetGUI
    {
        public Color Color;
        public string Red = "";
        public string Green = "";
        public string Blue = "";
        public string Alpha = "";

        public void Clone(Color color)
        {
            this.Color = color;
            this.Red = color.r.ToString("R");
            this.Green = color.g.ToString("R");
            this.Blue = color.b.ToString("R");
            this.Alpha = color.a.ToString("R");
        }

        public void Update(string SRed, float FRed, string SGreen, float FGreen, string SBlue, float FBlue, String SAlpha, float FAlpha)
        {
            if (this.Red != SRed)
            {
                this.Red = SRed;
                float.TryParse(SRed, out this.Color.r);
            }
            else if (this.Color.r != FRed)
            {
                this.Color.r = FRed;
                this.Red = FRed.ToString("R");
            }
            if (this.Green != SGreen)
            {
                this.Green = SGreen;
                float.TryParse(SGreen, out this.Color.g);
            }
            else if (this.Color.g != FGreen)
            {
                this.Color.g = FGreen;
                this.Green = FGreen.ToString("R");
            }
            if (this.Blue != SBlue)
            {
                this.Blue = SBlue;
                float.TryParse(SBlue, out this.Color.b);
            }
            else if (this.Color.b != FBlue)
            {
                this.Color.b = FBlue;
                this.Blue = FBlue.ToString("R");
            }
            if (this.Alpha != SAlpha)
            {
                this.Alpha = SAlpha;
                float.TryParse(SAlpha, out this.Color.a);
            }
            else if (this.Color.a != FAlpha)
            {
                this.Color.a = FAlpha;
                this.Alpha = FAlpha.ToString("R");
            }
        }

        public bool IsValid()
        {
            float dummy;
            if (float.TryParse(Red, out dummy) &&
                float.TryParse(Green, out dummy) &&
                float.TryParse(Blue, out dummy) &&
                float.TryParse(Alpha, out dummy))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }

    public class TextureSetGUI
    {
        public String StartOffsetX = "";
        public String SpeedX = "";
        public String Scale = "";
        public String StartOffsetY = "";
        public String SpeedY = "";
        public String TextureFile = "";
        public bool InUse;

        public void Clone(TextureSet textureSet)
        {
            this.InUse = textureSet.InUse;
            this.TextureFile = textureSet.TextureFile;
            if (this.TextureFile == null)
            {
                this.TextureFile = "";
            }
            this.StartOffsetX = textureSet.StartOffset.x.ToString("R");
            this.StartOffsetY = textureSet.StartOffset.y.ToString("R");
            this.Scale = textureSet.Scale.ToString("R");
            this.SpeedX = textureSet.Speed.x.ToString("R");
            this.SpeedY = textureSet.Speed.y.ToString("R");
        }

        public bool IsValid()
        {
            float dummy;
            if (float.TryParse(StartOffsetX, out dummy) &&
                float.TryParse(StartOffsetY, out dummy) &&
                float.TryParse(SpeedX, out dummy) &&
                float.TryParse(SpeedY, out dummy) &&
                float.TryParse(Scale, out dummy))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }

    public class TextureSet
    {
        private static Dictionary<String, Texture> TextureDictionary = new Dictionary<string, Texture>();
        public Vector2 Offset;
        public Vector2 StartOffset;
        public Vector2 Speed;
        public float Scale;
        private Texture texture;
        private String textureFile;
        private bool isBump;
        private bool isCubic;

        public bool InUse;
        public Texture Texture { get { return texture; } }
        public String TextureFile { get { return textureFile; } }


        private void initTexture()
        {
            if (isCubic && !TextureDictionary.ContainsKey(textureFile + "_CUBIC"))
            {
                Texture2D tex = GameDatabase.Instance.GetTexture(textureFile, isBump);
                TextureDictionary.Add(textureFile + "_CUBIC", CubicGen.getCubic(tex));
                Texture2D.DestroyImmediate(tex,true);
            }
            else if (isBump && !TextureDictionary.ContainsKey(textureFile + "_BUMP"))
            {
                Texture2D tex = GameDatabase.Instance.GetTexture(textureFile, isBump);
                TextureDictionary.Add(textureFile + "_BUMP", tex);
            }
            else if (!isBump && !isCubic && !TextureDictionary.ContainsKey(textureFile))
            {
                Texture2D tex = GameDatabase.Instance.GetTexture(textureFile, isBump);
                AddMipMaps(tex);
                if (tex.format != TextureFormat.DXT1 && tex.format != TextureFormat.DXT5)
                {
                    tex.Compress(true);
                }
                TextureDictionary.Add(textureFile, tex);
            }
            String textureName = isCubic ? textureFile + "_CUBIC" : textureFile;
            textureName = isBump ? textureName + "_BUMP" : textureName;
            texture = TextureDictionary[textureName];
        }

        private void AddMipMaps(Texture2D tex)
        {
            if (tex.mipmapCount == 1)
            {
                Color32[] pixels = tex.GetPixels32();
                int width = tex.width;
                int height = tex.height;
                tex.Resize(width, height, TextureFormat.RGBA32, true);
                tex.SetPixels32(pixels);
                tex.Apply(true);
            }
        }

        public TextureSet(ConfigNode textureNode, bool bump, bool cubic)
            : base()
        {
            isBump = bump;
            isCubic = cubic;
            if (textureNode != null)
            {
                textureFile = textureNode.GetValue("file");
                if (textureFile != null)
                {
                    initTexture();

                    ConfigNode offsetNode = textureNode.GetNode("offset");
                    if (offsetNode != null)
                    {
                        Offset = new Vector2(float.Parse(offsetNode.GetValue("x")), float.Parse(offsetNode.GetValue("y")));
                        StartOffset = new Vector2(Offset.x, Offset.y);
                    }
                    ConfigNode speedNode = textureNode.GetNode("speed");
                    if (speedNode != null)
                    {
                        Speed = new Vector2(float.Parse(speedNode.GetValue("x")), float.Parse(speedNode.GetValue("y")));
                    }
                    String scale = textureNode.GetValue("scale");
                    if (scale != null)
                    {
                        Scale = float.Parse(scale);
                    }

                    InUse = true;
                }
                else
                {
                    textureFile = "";
                }
            }
        }

        public TextureSet()
        {
            textureFile = "";
            texture = null;
            isBump = false;
            InUse = false;
            Offset = new Vector2(0, 0);
            StartOffset = new Vector2(0, 0);
            Speed = new Vector2(0, 0);
            Scale = 1;
        }

        public void SaturateOffset()
        {
            while (this.Offset.x > 1.0f)
            {
                this.Offset.x -= 1.0f;
            }
            while (this.Offset.x < 0.0f)
            {
                this.Offset.x += 1.0f;
            }
            while (this.Offset.y > 1.0f)
            {
                this.Offset.y -= 1.0f;
            }
            while (this.Offset.y < 0.0f)
            {
                this.Offset.y += 1.0f;
            }
        }

        public void UpdateOffset(float rateOffset, bool rotation)
        {
            if (rotation)
            {
                this.Offset.x = rateOffset * this.Speed.x;
                this.Offset.y = rateOffset * this.Speed.y;
            }
            else
            {
                this.Offset.x += rateOffset * this.Speed.x;
                this.Offset.y += rateOffset * this.Speed.y;
                SaturateOffset();
            }
            
        }

        public void Clone(TextureSetGUI textureSet)
        {
            this.InUse = textureSet.InUse;
            this.textureFile = textureSet.TextureFile;
            initTexture();

            this.StartOffset.x = float.Parse(textureSet.StartOffsetX);
            this.StartOffset.y = float.Parse(textureSet.StartOffsetY);
            this.Offset.x = this.StartOffset.x;
            this.Offset.y = this.StartOffset.y;
            this.Scale = float.Parse(textureSet.Scale);
            this.Speed.x = float.Parse(textureSet.SpeedX);
            this.Speed.y = float.Parse(textureSet.SpeedY);
        }

        public ConfigNode GetNode(string name)
        {
            if (!this.InUse)
            {
                return null;
            }
            ConfigNode newNode = new ConfigNode(name);
            newNode.AddValue("file", this.textureFile);
            ConfigNode offsetNode = newNode.AddNode("offset");
            offsetNode.AddValue("x", this.StartOffset.x);
            offsetNode.AddValue("y", this.StartOffset.y);
            ConfigNode speedNode = newNode.AddNode("speed");
            speedNode.AddValue("x", this.Speed.x);
            speedNode.AddValue("y", this.Speed.y);
            newNode.AddValue("scale", this.Scale);
            return newNode;
        }
    }
}
