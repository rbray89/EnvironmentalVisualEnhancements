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

        public class Scaled : System.Attribute
        {
        }

        public class InverseScaled : System.Attribute
        {
        }

        public class ScaledValue
        {
            public object obj;

            public ScaledValue(object p)
            {
                this.obj = p;
            }
        }

        public class InverseScaledValue
        {
            public object obj;

            public InverseScaledValue(object p)
            {
                this.obj = p;
            }
        }

        bool cached = false;
        List<KeyValuePair<String, object>> cache = new List<KeyValuePair<string, object>>();
        public void ApplyMaterialProperties(Material material, float scale = 1.0f, bool clampTextures = false)
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

                        cache.Add(new KeyValuePair<string, object>(name, texture));
                    }
                    else
                    {
                        bool isScaled = Attribute.IsDefined(field, typeof(Scaled));
                        bool isInvScaled = Attribute.IsDefined(field, typeof(InverseScaled));
                        if (isScaled)
                        {
                            cache.Add(new KeyValuePair<string, object>(name, new ScaledValue(field.GetValue(this))));
                        }
                        else if (isInvScaled)
                        {
                            cache.Add(new KeyValuePair<string, object>(name, new InverseScaledValue(field.GetValue(this))));
                        }
                        else
                        {
                            cache.Add(new KeyValuePair<string, object>(name, field.GetValue(this)));
                        }
                    }
                }
                cached = true;
            }
            ApplyCache(material, scale);
        }

        private void ApplyCache(Material material, float scale = 1.0f)
        {
            foreach (KeyValuePair<String,object> field in cache)
            {
                String name = field.Key;
                object obj = field.Value;
                float scaleValue = 1f;
                if (obj != null && obj.GetType() == typeof(ScaledValue))
                {
                    obj = ((ScaledValue)obj).obj;
                    scaleValue = scale;
                }
                else if (obj != null && obj.GetType() == typeof(InverseScaledValue))
                {
                    obj = ((InverseScaledValue)obj).obj;
                    scaleValue = 1/scale;
                }

                if (obj == null || obj.GetType() == typeof(Texture2D))
                {
                    Texture2D value = (Texture2D)obj;
                    material.SetTexture(name, value);
                }
                //float
                else if (obj.GetType() == typeof(float))
                {
                    float value = (float)obj;
                    material.SetFloat(name, value * scaleValue);
                }
                //Color
                else if (obj.GetType() == typeof(Color))
                {
                    Color value = (Color)obj;
                    material.SetColor(name, value * scaleValue);
                }
                //Vector3
                else if (obj.GetType() == typeof(Vector3))
                {
                    Vector3 value = (Vector3)obj;
                    material.SetVector(name, value * scaleValue);
                }
            }
        }
    }
}
