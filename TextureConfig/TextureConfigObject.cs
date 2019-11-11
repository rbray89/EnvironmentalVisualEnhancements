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
        enum TexTypeEnum
        {
            REGULAR,
            TEX_CUBE_6,
            TEX_CUBE_2
        }

#pragma warning disable 0649
        [ConfigItem, GUIHidden]
        String name;
        [ConfigItem]
        bool mipmaps = true;
        [ConfigItem]
        bool isNormalMap = false;
        [ConfigItem]
        bool isReadable = false;
        [ConfigItem]
        bool isCompressed = false;
        [ConfigItem]
        TexTypeEnum type = TexTypeEnum.REGULAR;

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

        [ConfigItem, Conditional("dualMapEval")]
        String texP;
        [ConfigItem, Conditional("dualMapEval")]
        String texN;

        public override String ToString() { return name; }

        public void LoadConfigNode(ConfigNode node)
        {
            ConfigHelper.LoadObjectFromConfig(this, node);
        }

        public void Apply() 
        {
            if(type == TexTypeEnum.TEX_CUBE_6)
            {
                
                ReplaceIfNecessary(texXn, isNormalMap, mipmaps, isReadable, isCompressed);
                ReplaceIfNecessary(texYn, isNormalMap, mipmaps, isReadable, isCompressed);
                ReplaceIfNecessary(texZn, isNormalMap, mipmaps, isReadable, isCompressed);
                ReplaceIfNecessary(texXp, isNormalMap, mipmaps, isReadable, isCompressed);
                ReplaceIfNecessary(texYp, isNormalMap, mipmaps, isReadable, isCompressed);
                ReplaceIfNecessary(texZp, isNormalMap, mipmaps, isReadable, isCompressed);
                
                Texture2D[] textures = new Texture2D[6];
                textures[(int)CubemapFace.NegativeX] = GameDatabase.Instance.GetTexture(texXn, isNormalMap);
                textures[(int)CubemapFace.NegativeY] = GameDatabase.Instance.GetTexture(texYn, isNormalMap);
                textures[(int)CubemapFace.NegativeZ] = GameDatabase.Instance.GetTexture(texZn, isNormalMap);
                textures[(int)CubemapFace.PositiveX] = GameDatabase.Instance.GetTexture(texXp, isNormalMap);
                textures[(int)CubemapFace.PositiveY] = GameDatabase.Instance.GetTexture(texYp, isNormalMap);
                textures[(int)CubemapFace.PositiveZ] = GameDatabase.Instance.GetTexture(texZp, isNormalMap);
                CubemapWrapper.GenerateCubemapWrapper(name, textures, TextureTypeEnum.CubeMap, mipmaps, isReadable);
             /*   foreach(Texture2D tex in textures)
                {
                    GameDatabase.Instance.RemoveTexture(tex.name);
                    GameObject.DestroyImmediate(tex);
                }
                */
            }
            else if(type == TexTypeEnum.TEX_CUBE_2)
            {
                ReplaceIfNecessary(texP, isNormalMap, mipmaps, isReadable, isCompressed);
                ReplaceIfNecessary(texN, isNormalMap, mipmaps, isReadable, isCompressed);

                Texture2D[] textures = new Texture2D[2];
                textures[0] = GameDatabase.Instance.GetTexture(texP, isNormalMap);
                textures[1] = GameDatabase.Instance.GetTexture(texN, isNormalMap);
                CubemapWrapper.GenerateCubemapWrapper(name, textures, TextureTypeEnum.RGB2_CubeMap, mipmaps, isReadable);
            }
            else
            {
                ReplaceIfNecessary(name, isNormalMap, mipmaps, isReadable, isCompressed);
            }
        }

        private static void ReplaceIfNecessary(string name, bool normalMap, bool mipmaps, bool readable, bool compressed)
        {
            if (GameDatabase.Instance.ExistsTexture(name))
            {
                GameDatabase.TextureInfo info = GameDatabase.Instance.GetTextureInfo(name);
                bool isReadable = false;
                try { info.texture.GetPixel(0, 0); isReadable = true; }
                catch { }
                bool hasMipmaps = info.texture.mipmapCount > 0;
                bool isCompressed = (info.texture.format == TextureFormat.DXT1 || info.texture.format == TextureFormat.DXT5);
                bool isNormalMap = info.isNormalMap;

                
                if (!isReadable || ( isCompressed && !compressed) || (isNormalMap != normalMap))
                {
                    //Pretty ineficient to not check beforehand, but makes the logic much simpler by simply reloading the textures.
                    info.isNormalMap = normalMap;
                    info.isReadable = readable;
                    info.isCompressed = compressed;
                    TextureConverter.Reload(info, false, default(Vector2), null, mipmaps);
                    info.texture.name = name;
                }
                else if (isReadable != readable || isCompressed != compressed || hasMipmaps != mipmaps)
                {
                    if(compressed)
                    {
                        info.texture.Compress(true);
                    }
                    info.texture.Apply(mipmaps, !readable);
                }
                
            }
        }

        //Right now we don't really have a good way to "undo" the changes. For now they will have to stay.
        public void Remove() { }

        public static bool cubeMapEval(ConfigNode node)
        {
            TextureConfigObject test = new TextureConfigObject();
            ConfigHelper.LoadObjectFromConfig(test, node);

            return test.type== TexTypeEnum.TEX_CUBE_6;
        }

        public static bool dualMapEval(ConfigNode node)
        {
            TextureConfigObject test = new TextureConfigObject();
            ConfigHelper.LoadObjectFromConfig(test, node);

            return test.type == TexTypeEnum.TEX_CUBE_2;
        }
    }
}
