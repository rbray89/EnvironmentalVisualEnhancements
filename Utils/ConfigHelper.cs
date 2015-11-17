using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;

namespace Utils
{

    public class Optional : System.Attribute
    {
        public String Field;
        public object Value;
        bool nullCheck = false;
        public Optional()
        {
            Field = null;
        }
        public Optional(String field)
        {
            Field = field;
            nullCheck = true;
        }
        public Optional(String field, object value)
        {
            Field = field;
            Value = value;
        }

        public bool isActive(ConfigNode node)
        {
            if (nullCheck)
            {
                return node.HasNode(Field);
            }
            else
            {
                if (Field != null)
                {
                    return node.GetValue(Field) == Value.ToString();
                }
                else
                {
                    return true;
                }
            }
        }
    }

    public interface INamed
    {
        String Name { get; set; }
    }

    public class ConfigWrapper : INamed
    {
        public String Name { get { return name; } set { } }
        public ConfigNode Node { get { return node; } }
        string name;
        ConfigNode node;
        public ConfigWrapper(UrlDir.UrlConfig uc)
        {
            name = uc.parent.url;
            node = uc.config;
        }
    }

    public static class ConfigHelper
    {
        public static bool CanParse(FieldInfo field, String value)
        {
            if(Parse(field, value)!=null)
            { return true; }
            else { return false; }
        }

        public static ConfigNode CreateConfigFromObject(object obj, ConfigNode node)
        {
            return ConfigNode.CreateConfigFromObject(obj, node);
        }

        public static bool LoadObjectFromConfig(object obj, ConfigNode node)
        {
            var objfields = obj.GetType().GetFields(BindingFlags.Instance | BindingFlags.NonPublic).Where(
                   field => Attribute.IsDefined(field, typeof(Persistent)));
            foreach (FieldInfo field in objfields)
            {
                bool isNode = field.FieldType.GetFields(BindingFlags.Instance | BindingFlags.NonPublic).Where(
                    fi => Attribute.IsDefined(fi, typeof(Persistent))).Count() > 0 ? true : false;

                if (!isNode)
                {
                    if(!ConfigHelper.Parse(obj, field, node))
                    {
                        KSPLog.print("unable to parse \"" + field.Name + "\" in \""+node.name+"\"!");
                        return false;
                    }
                }
                else
                {
                    bool isOptional = Attribute.IsDefined(field, typeof(Optional));
                    
                    if (node.HasNode(field.Name))
                    {
                        ConfigNode subNode = node.GetNode(field.Name);
                        object subObj = field.GetValue(obj);
                        if (subObj == null)
                        {
                            ConstructorInfo ctor = field.FieldType.GetConstructor(System.Type.EmptyTypes);
                            subObj = ctor.Invoke(null);
                        }
                        if(!LoadObjectFromConfig(subObj, subNode))
                        {
                            return false;
                        }
                        field.SetValue(obj, subObj);
                    } else if(!isOptional)
                    {
                        KSPLog.print("non-optional field \"" + field.Name + "\" in \"" + node.name + "\" is not set!");
                        return false;
                    }
                }
            }
            return true;
        }

        private static object Parse(FieldInfo field, string value)
        {
            if(field.FieldType == typeof(Texture2D))
            {
                if(GameDatabase.Instance.ExistsTexture(value))
                {
                    bool isNormal = value.Contains("Bump") | value.Contains("Bmp") | value.Contains("Normal") | value.Contains("Nrm");
                    return GameDatabase.Instance.GetTexture(value, isNormal);
                }
            }
            else if (field.FieldType == typeof(float))
            {
                try
                {
                    return float.Parse(value);
                }
                catch { return null; }
            }
            else if (field.FieldType == typeof(double))
            {
                try
                {
                    return double.Parse(value);
                }
                catch { return null; }
            }
            else if(field.FieldType == typeof(String))
            {
                return value;
            }
            else if(field.FieldType == typeof(Color))
            {
                try
                {
                    return ConfigNode.ParseColor(value);
                }
                catch { return null; }
            }
            else if (field.FieldType == typeof(Color32))
            {
                try
                {
                    return ConfigNode.ParseColor32(value);
                }
                catch { return null; }
            }
            else if (field.FieldType.IsEnum)
            {
                try
                {
                    return ConfigNode.ParseEnum(field.FieldType, value);
                }
                catch { return null; }
            }
            else if (field.FieldType == typeof(Matrix4x4))
            {
                try
                {
                    return ConfigNode.ParseMatrix4x4(value);
                }
                catch { return null; }
            }
            else if (field.FieldType == typeof(Quaternion))
            {
                try
                {
                    return ConfigNode.ParseQuaternion(value);
                }
                catch { return null; }
            }
            else if (field.FieldType == typeof(QuaternionD))
            {
                try
                {
                    return ConfigNode.ParseQuaternionD(value);
                }
                catch { return null; }
            }
            else if (field.FieldType == typeof(Vector2))
            {
                try
                {
                    return (Vector2)ConfigNode.ParseVector2(value);
                }
                catch { return null; }
            }
            else if (field.FieldType == typeof(Vector3))
            {
                try
                {
                    return ConfigNode.ParseVector3(value);
                }
                catch { return null; }
            }
            else if (field.FieldType == typeof(Vector3d))
            {
                try
                {
                    return ConfigNode.ParseVector3D(value);
                }
                catch { return null; }
            }
            else if (field.FieldType == typeof(Vector4))
            {
                try
                {
                    return ConfigNode.ParseVector4(value);
                }
                catch { return null; }
            }
            return null;
        }

        private static bool Parse(object obj, FieldInfo field, ConfigNode node)
        {
            bool hasValue = node.HasValue(field.Name);
            if (hasValue)
            {
                object objValue = Parse(field, node.GetValue(field.Name));
                if(objValue != null)
                {
                    field.SetValue(obj, objValue);
                }
                else
                {
                    return false;
                }
            }
            
            return true;
        }
    }
}
