using System;
using System.Reflection;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Utils
{
    public class MaterialManager
    {
        bool cached = false;
        List<KeyValuePair<String, object>> cache = new List<KeyValuePair<string, object>>();
        public void ApplyMaterialProperties(Material material, bool clampTextures = false)
        {
            if (!cached)
            {
                FieldInfo[] fields = this.GetType().GetFields(BindingFlags.Instance | BindingFlags.NonPublic);
                foreach (FieldInfo field in fields)
                {
                    String name = field.Name;
                    //texture
                    if (field.FieldType == typeof(String))
                    {
                        String textureName = (String)field.GetValue(this);
                        bool isNormal = textureName.Contains("Bump") | textureName.Contains("Bmp") | textureName.Contains("Normal") | textureName.Contains("Nrm");
                        Texture2D texture = GameDatabase.Instance.GetTexture(textureName, isNormal);
                        if (clampTextures)
                        {
                            texture.wrapMode = TextureWrapMode.Clamp;
                        }
                        try
                        {
                            Color32[] pixels = texture.GetPixels32();
                            int width = texture.width;
                            int height = texture.height;
                            texture.Resize(width, height, TextureFormat.ARGB32, true);
                            texture.SetPixels32(pixels);
                            texture.Apply(true);
                        }
                        catch { }

                        cache.Add(new KeyValuePair<string, object>(name, texture));
                    }
                    else
                    {
                        cache.Add(new KeyValuePair<string, object>(name, field.GetValue(this)));
                    }
                }
                cached = true;
            }
            ApplyCache(material);
        }

        private void ApplyCache(Material material)
        {
            foreach (KeyValuePair<String,object> field in cache)
            {
                String name = field.Key;
                object obj = field.Value;
                if (obj == null || obj.GetType() == typeof(Texture2D))
                {
                    Texture2D value = (Texture2D)obj;
                    material.SetTexture(name, value);
                }
                //float
                else if (obj.GetType() == typeof(float))
                {
                    float value = (float)obj;
                    material.SetFloat(name, value);
                }
                //Color
                else if (obj.GetType() == typeof(Color))
                {
                    Color value = (Color)obj;
                    material.SetColor(name, value);
                }
                //Vector3
                else if (obj.GetType() == typeof(Vector3))
                {
                    Vector3 value = (Vector3)obj;
                    material.SetVector(name, value);
                }
            }
        }
    }
}
