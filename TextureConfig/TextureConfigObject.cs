using EVEManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Utils;

namespace TextureConfig
{
    [ConfigName("name")]
    public class TextureConfigObject : IEVEObject 
    {
        
        public enum TextureFormatSimplified
        {
            Default = -1,
            RGBA32 = TextureFormat.RGBA32,
            RGB24 = TextureFormat.RGB24,
            DXT1 = TextureFormat.DXT1,
            DXT5 = TextureFormat.DXT5
        }

#pragma warning disable 0649
        [ConfigItem, GUIHidden]
        String name;
        [ConfigItem]
        TextureFormatSimplified format = TextureFormatSimplified.Default;
        [ConfigItem]
        bool mipmaps = true;
        [ConfigItem]
        bool isNormalMap = false;
        [ConfigItem]
        bool isReadable = false;
        [ConfigItem, Conditional("formatEval")]
        bool isCubeMap = false;

        [ConfigItem, Conditional("cubeMapEval")]
        String texXn;
        [ConfigItem, Conditional("cubeMapEval")]
        String texXp;
        [ConfigItem, Conditional("cubeMapEval")]
        String texYn;
        [ConfigItem, Conditional("cubeMapEval")]
        String texYp;
        [ConfigItem, Conditional("cubeMapEval")]
        String texZn;
        [ConfigItem, Conditional("cubeMapEval")]
        String texZp;

        public override String ToString() { return name; }

        public void LoadConfigNode(ConfigNode node)
        {
            ConfigHelper.LoadObjectFromConfig(this, node);
        }

        public void Apply() 
        {

            if(isCubeMap)
            {
                ReplaceIfNecessary(texXn, format, isNormalMap, mipmaps, true);
                ReplaceIfNecessary(texYn, format, isNormalMap, mipmaps, true);
                ReplaceIfNecessary(texZn, format, isNormalMap, mipmaps, true);
                ReplaceIfNecessary(texXp, format, isNormalMap, mipmaps, true);
                ReplaceIfNecessary(texYp, format, isNormalMap, mipmaps, true);
                ReplaceIfNecessary(texZp, format, isNormalMap, mipmaps, true);
                Texture2D[] textures = new Texture2D[6];
                textures[(int)CubemapFace.NegativeX] = GameDatabase.Instance.GetTexture(texXn, isNormalMap);
                textures[(int)CubemapFace.NegativeY] = GameDatabase.Instance.GetTexture(texYn, isNormalMap);
                textures[(int)CubemapFace.NegativeZ] = GameDatabase.Instance.GetTexture(texZn, isNormalMap);
                textures[(int)CubemapFace.PositiveX] = GameDatabase.Instance.GetTexture(texXp, isNormalMap);
                textures[(int)CubemapFace.PositiveY] = GameDatabase.Instance.GetTexture(texYp, isNormalMap);
                textures[(int)CubemapFace.PositiveZ] = GameDatabase.Instance.GetTexture(texZp, isNormalMap);
                CubemapWrapper.GenerateCubemapWrapper(name, textures, TextureTypeEnum.CubeMap,(TextureFormat) format, mipmaps, isReadable);
                foreach(Texture2D tex in textures)
                {
                    GameDatabase.Instance.RemoveTexture(tex.name);
                    GameObject.DestroyImmediate(tex);
                }
            }
            else
            {
                ReplaceIfNecessary(name, format, isNormalMap, mipmaps, isReadable);
            }
        }

        private static void ReplaceIfNecessary(string name, TextureFormatSimplified format, bool isNormalMap, bool mipmaps, bool isReadable)
        {
            if (GameDatabase.Instance.ExistsTexture(name))
            {
                GameDatabase.TextureInfo info = GameDatabase.Instance.GetTextureInfo(name);

                
                //Pretty ineficient to not check beforehand, but makes the logic much simpler by simply reloading the textures.
                info.isNormalMap = isNormalMap;
                info.isReadable = true;
                info.isCompressed = false;
                TextureConverter.Reload(info, false, default(Vector2), null, mipmaps);

                bool compress = (format == TextureFormatSimplified.DXT1 || format == TextureFormatSimplified.DXT5);

                if (compress)
                {
                    info.texture.Compress(true);
                    info.isCompressed = true;
                }
                if ( !isReadable)
                {
                    //mipmaps were generated earlier in GetReadable if requested...
                    info.texture.Apply(false, !isReadable);
                    info.isReadable = false;
                }
                info.texture.name = name;
            }
        }

        //Right now we don't really have a good way to "undo" the changes. For now they will have to stay.
        public void Remove() { }

        public static bool cubeMapEval(ConfigNode node)
        {
            TextureConfigObject test = new TextureConfigObject();
            ConfigNode.LoadObjectFromConfig(test, node);

            return test.isCubeMap;
        }

        public static bool formatEval(ConfigNode node)
        {
            TextureConfigObject test = new TextureConfigObject();
            ConfigNode.LoadObjectFromConfig(test, node);

            return test.format == TextureFormatSimplified.RGB24 || test.format == TextureFormatSimplified.RGBA32;
        }
    }
}
