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
        

#pragma warning disable 0649
        [ConfigItem, GUIHidden]
        String name;
        [ConfigItem]
        bool mipmaps = true;
        [ConfigItem]
        bool isNormalMap = false;
        [ConfigItem]
        bool isReadable = false;
        [ConfigItem, Conditional("formatEval")]
        bool isCompressed = false;
        [ConfigItem]
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
                ReplaceIfNecessary(texXn, isNormalMap, mipmaps, true, false);
                ReplaceIfNecessary(texYn, isNormalMap, mipmaps, true, false);
                ReplaceIfNecessary(texZn, isNormalMap, mipmaps, true, false);
                ReplaceIfNecessary(texXp, isNormalMap, mipmaps, true, false);
                ReplaceIfNecessary(texYp, isNormalMap, mipmaps, true, false);
                ReplaceIfNecessary(texZp, isNormalMap, mipmaps, true, false);
                Texture2D[] textures = new Texture2D[6];
                textures[(int)CubemapFace.NegativeX] = GameDatabase.Instance.GetTexture(texXn, isNormalMap);
                textures[(int)CubemapFace.NegativeY] = GameDatabase.Instance.GetTexture(texYn, isNormalMap);
                textures[(int)CubemapFace.NegativeZ] = GameDatabase.Instance.GetTexture(texZn, isNormalMap);
                textures[(int)CubemapFace.PositiveX] = GameDatabase.Instance.GetTexture(texXp, isNormalMap);
                textures[(int)CubemapFace.PositiveY] = GameDatabase.Instance.GetTexture(texYp, isNormalMap);
                textures[(int)CubemapFace.PositiveZ] = GameDatabase.Instance.GetTexture(texZp, isNormalMap);
                CubemapWrapper.GenerateCubemapWrapper(name, textures, TextureTypeEnum.CubeMap, mipmaps, isReadable);
                foreach(Texture2D tex in textures)
                {
                    GameDatabase.Instance.RemoveTexture(tex.name);
                    GameObject.DestroyImmediate(tex);
                }
            }
            else
            {
                ReplaceIfNecessary(name, isNormalMap, mipmaps, isReadable, isCompressed);
            }
        }

        private static void ReplaceIfNecessary(string name, bool isNormalMap, bool mipmaps, bool isReadable, bool isCompressed)
        {
            if (GameDatabase.Instance.ExistsTexture(name))
            {
                GameDatabase.TextureInfo info = GameDatabase.Instance.GetTextureInfo(name);

                
                //Pretty ineficient to not check beforehand, but makes the logic much simpler by simply reloading the textures.
                info.isNormalMap = isNormalMap;
                info.isReadable = true;
                info.isCompressed = false;
                TextureConverter.Reload(info, false, default(Vector2), null, mipmaps);
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
        
    }
}
