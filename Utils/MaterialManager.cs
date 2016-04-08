using System;
using System.Reflection;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using UnityEngine.Rendering;

namespace Utils
{

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

        bool cached = false;
        float Scale;
        Dictionary<object, object> cache = new Dictionary<object, object>();
        public void ApplyMaterialProperties(Material material, float scale = 1.0f)
        {
            Scale = scale;
            Cache();
            ApplyCache(material, scale);
            //Log();
        }
        
        public void UpdateCommandBuffer(Material mat, CommandBuffer buf)
        {
            Cache();
            CloneToBuffer(mat, buf);
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
                            int index = Attribute.IsDefined(field, typeof(Index)) ? ((Index) Attribute.GetCustomAttribute(field, typeof(Index))).value: 0;
                            texture.IsNormal = isNormal;
                            texture.IsClamped = isClamped;
                            texture.Index = index;
                            cache.Add(name, texture);
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
                        int id = Shader.PropertyToID(name);
                        if (isScaled)
                        {
                            cache.Add(id, new ScaledValue(field.GetValue(this)));
                        }
                        else if (isInvScaled)
                        {
                            cache.Add(id, new InverseScaledValue(field.GetValue(this)));
                        }
                        else
                        {
                            cache.Add(id, field.GetValue(this));
                        }
                    }
                }
                cached = true;
            }
        }

        private void ApplyCache(Material material, float scale = 1.0f)
        {
            foreach (KeyValuePair<object,object> field in cache)
            {
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

                if (obj.GetType() == typeof(TextureWrapper))
                {
                    TextureWrapper value = (TextureWrapper)obj;
                    value.ApplyTexture(material, (String)field.Key);
                }
                //float
                else if (obj.GetType() == typeof(float))
                {
                    float value = (float)obj;
                    material.SetFloat((int)field.Key, value * scaleValue);
                }
                //Color
                else if (obj.GetType() == typeof(Color))
                {
                    Color value = (Color)obj;
                    material.SetColor((int)field.Key, value/256f);
                }
                //Color32
                else if (obj.GetType() == typeof(Color32))
                {
                    Color32 value = (Color32)obj;
                    material.SetColor((int)field.Key, value);
                }//Vector2
                else if (obj.GetType() == typeof(Vector2))
                {
                    Vector2 value = (Vector2)obj;
                    material.SetVector((int)field.Key, value * scaleValue);
                }
                //Vector3
                else if (obj.GetType() == typeof(Vector3))
                {
                    Vector3 value = (Vector3)obj;
                    material.SetVector((int)field.Key, value * scaleValue);
                }
                //Vector4
                else if (obj.GetType() == typeof(Vector4))
                {
                    Vector4 value = (Vector4)obj;
                    material.SetVector((int)field.Key, value * scaleValue);
                }
                //Matrix
                else if (obj.GetType() == typeof(Matrix4x4))
                {
                    Matrix4x4 value = (Matrix4x4)obj;
                    material.SetMatrix((int)field.Key, value);
                }
                //bool
                else if (obj.GetType() == typeof(bool))
                {
                    bool value = (bool)obj;
                    if (value)
                    {
                        material.EnableKeyword((String)field.Key);
                    }
                    else
                    {
                        material.DisableKeyword((String)field.Key);
                    }
                }
                //enum
                else if (obj.GetType().IsEnum)
                {
                    String value = Enum.GetName(obj.GetType(), obj);
                    material.EnableKeyword(value);
                }

            }
        }

        private void CloneToBuffer(Material mat, CommandBuffer buf)
        {
            foreach (KeyValuePair<object, object> field in cache)
            {
                object obj = field.Value;
                //float
                int id = (int)field.Key;
                if (obj.GetType() == typeof(float))
                {
                    float value = mat.GetFloat(id);
                    buf.SetGlobalFloat(id, value);
                }
                //Color
                else if (obj.GetType() == typeof(Color))
                {
                    Color value = mat.GetColor(id);
                    buf.SetGlobalColor(id, value);
                }
                //Color32
                else if (obj.GetType() == typeof(Color32))
                {
                    Color value = mat.GetColor(id);
                    buf.SetGlobalColor(id, value);
                }//Vector2
                else if (obj.GetType() == typeof(Vector2))
                {
                    Vector4 value = mat.GetVector(id);
                    buf.SetGlobalVector(id, value);
                }
                //Vector3
                else if (obj.GetType() == typeof(Vector3))
                {
                    Vector4 value = mat.GetVector(id);
                    buf.SetGlobalVector(id, value);
                }
                //Vector4
                else if (obj.GetType() == typeof(Vector4))
                {
                    Vector4 value = mat.GetVector(id);
                    buf.SetGlobalVector(id, value);
                }
                //Matrix
                else if (obj.GetType() == typeof(Matrix4x4))
                {
                    Matrix4x4 value = mat.GetMatrix(id);
                    buf.SetGlobalMatrix(id, value);
                }

            }
        }


        public void SaveTextures(Material material)
        {
            Cache();
            List<String> keys = cache.Keys.Select(x=>(string)x).ToList();
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
