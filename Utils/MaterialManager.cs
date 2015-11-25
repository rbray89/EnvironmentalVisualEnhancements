using System;
using System.Reflection;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Utils
{

    public enum TextureTypeEnum
    {
        RGBA,
        AlphaMap
    }

    public class TextureType : System.Attribute
    {
        public TextureTypeEnum Type;
        public TextureType(TextureTypeEnum type)
        {
            Type = type;
        }
    }

    public class UserDefinedType : System.Attribute
    { }

    

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

        public void Log()
        {
            foreach (KeyValuePair<String, object> field in cache)
            {
                String name = field.Key;
                object obj = field.Value;
                float scaleValue = 1f;
                if (obj != null && obj.GetType() == typeof(ScaledValue))
                {
                    obj = ((ScaledValue)obj).obj;
                    scaleValue = 1 / Scale;
                }
                else if (obj != null && obj.GetType() == typeof(InverseScaledValue))
                {
                    obj = ((InverseScaledValue)obj).obj;
                    scaleValue = Scale;
                }

                if (obj == null || obj.GetType() == typeof(Texture2D))
                {
                    Texture2D value = (Texture2D)obj;
                    KSPLog.print(name+": "+ value);
                }
                //float
                else if (obj.GetType() == typeof(float))
                {
                    float value = (float)obj;
                    KSPLog.print(name + ": " + value * scaleValue);
                }
                //Color
                else if (obj.GetType() == typeof(Color))
                {
                    Color value = (Color)obj;
                    KSPLog.print(name + ": " + value);
                }
                //Color
                else if (obj.GetType() == typeof(Color32))
                {
                    Color32 value = (Color32)obj;
                    KSPLog.print(name + ": " + value);
                }
                //Vector3
                else if (obj.GetType() == typeof(Vector3))
                {
                    Vector3 value = (Vector3)obj;
                    KSPLog.print(name + ": " + value * scaleValue);
                }

            }
        }

        bool cached = false;
        float Scale;
        Dictionary<String, object> cache = new Dictionary<string, object>();
        public void ApplyMaterialProperties(Material material, float scale = 1.0f)
        {
            Scale = scale;
            Cache();
            ApplyCache(material, scale);
            Log();
        }

        private void Cache()
        {
            if (!cached)
            {
                FieldInfo[] fields = this.GetType().GetFields(BindingFlags.Instance | BindingFlags.NonPublic);
                foreach (FieldInfo field in fields)
                {
                    String name = field.Name;
                    //texture
                    if (field.FieldType == typeof(TextureWrapper))
                    {
                        TextureWrapper texture = (TextureWrapper)field.GetValue(this);
                        if (texture != null)
                        {
                            bool isNormal = Attribute.IsDefined(field, typeof(BumpMap));
                            bool isClamped = Attribute.IsDefined(field, typeof(Clamped));
                            cache.Add(name, texture.GetTexture(isNormal, isClamped));
                        }
                        else
                        {
                            cache.Add(name, null);
                        }
                    }
                    else
                    {
                        bool isScaled = Attribute.IsDefined(field, typeof(Scaled));
                        bool isInvScaled = Attribute.IsDefined(field, typeof(InverseScaled));
                        if (isScaled)
                        {
                            cache.Add(name, new ScaledValue(field.GetValue(this)));
                        }
                        else if (isInvScaled)
                        {
                            cache.Add(name, new InverseScaledValue(field.GetValue(this)));
                        }
                        else
                        {
                            cache.Add(name, field.GetValue(this));
                        }
                    }
                }
                cached = true;
            }
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
                    scaleValue = 1 / scale;
                }
                else if (obj != null && obj.GetType() == typeof(InverseScaledValue))
                {
                    obj = ((InverseScaledValue)obj).obj;
                    scaleValue = scale;
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
                    material.SetColor(name, value/256f);
                }
                //Color32
                else if (obj.GetType() == typeof(Color32))
                {
                    Color32 value = (Color32)obj;
                    material.SetColor(name, value);
                }//Vector2
                else if (obj.GetType() == typeof(Vector2))
                {
                    Vector2 value = (Vector2)obj;
                    material.SetVector(name, value * scaleValue);
                }
                //Vector3
                else if (obj.GetType() == typeof(Vector3))
                {
                    Vector3 value = (Vector3)obj;
                    material.SetVector(name, value * scaleValue);
                }
                //Vector4
                else if (obj.GetType() == typeof(Vector4))
                {
                    Vector4 value = (Vector4)obj;
                    material.SetVector(name, value * scaleValue);
                }
                //Vector4
                else if (obj.GetType() == typeof(Matrix4x4))
                {
                    Matrix4x4 value = (Matrix4x4)obj;
                    material.SetMatrix(name, value);
                }

            }
        }

        public void SaveTextures(Material material)
        {
            Cache();
            List<String> keys = cache.Keys.ToList();
            foreach (String key in keys)
            {
                String name = key;
                object obj = cache[key];
               
                if ( obj == null )
                {
                    Texture2D value = (Texture2D)material.GetTexture(name);
                    if( value != null )
                    {
                        cache[key] = value;
                    }
                    
                }

            }

        }
    }
}
