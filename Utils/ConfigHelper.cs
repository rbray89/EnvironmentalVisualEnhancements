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
    }

    public class ValueNode : System.Attribute
    {
    }
    public class NodeOptional : System.Attribute
    {
    }

    public class Conditional: System.Attribute
    {
        private string method;
        public string Method { get { return method; } }
        public Conditional(string method)
        {
            this.method = method;
        }
        public bool CheckConditional(Type T, ConfigNode config)
        {
            MethodInfo methodInfo = T.GetMethod(method);
            return (bool)methodInfo.Invoke(null, new object[] { config });
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

        public static bool ConditionsMet(FieldInfo field, ConfigNode node)
        {
            bool isConditional = Attribute.IsDefined(field, typeof(Conditional));
            Conditional conditional = (Conditional)Attribute.GetCustomAttribute(field, typeof(Conditional));
            try
            {
                return (!isConditional || (isConditional && conditional.CheckConditional(field.DeclaringType, node)));
            }
            catch
            {
                return false;
            }
        }

        public static bool IsNode(FieldInfo field, ConfigNode node, bool checkConfig = true)
        {
            bool isNode = field.FieldType.GetFields(BindingFlags.Instance | BindingFlags.NonPublic).Where(
               fi => Attribute.IsDefined(fi, typeof(Persistent))).Count() > 0 ? true : false;
             
            //Field Checks first, they would take precidence.
            if(Attribute.IsDefined(field, typeof(NodeOptional)))
            {
                if (checkConfig)
                {
                    isNode &= node.HasNode(field.Name);
                }
            }
            else if(Attribute.IsDefined(field, typeof(ValueNode)))
            {
                isNode = false;
            }
            else if(Attribute.IsDefined(field.FieldType, typeof(NodeOptional)))
            {
                if (checkConfig)
                {
                    isNode &= node.HasNode(field.Name);
                }
            }
            else if(Attribute.IsDefined(field.FieldType, typeof(ValueNode)))
            {
                isNode = false;
            }

            return isNode;
        }

        public static bool CanParse(FieldInfo field, String value)
        {
            object test = null;
            
            return Parse(field, value, ref test);
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
                bool isNode = IsNode(field, node);

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

        private static bool Parse(FieldInfo field, string value, ref object obj)
        {
            obj = null;
            if (field.FieldType == typeof(TextureWrapper))
            {
                TextureWrapper tex = new TextureWrapper(value);
                obj = tex;
                return tex.exists();
            }
            else if (field.FieldType == typeof(float))
            {
                try
                {
                    obj = float.Parse(value);
                    return true;
                }
                catch { }
            }
            else if (field.FieldType == typeof(double))
            {
                try
                {
                    obj = double.Parse(value);
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType == typeof(bool))
            {
                try
                {
                    obj = bool.Parse(value);
                    return true;
                }
                catch {  }
            }
            else if(field.FieldType == typeof(String))
            {
                obj = value;
                return true;
            }
            else if(field.FieldType == typeof(Color))
            {
                try
                {
                    obj = (Color)ConfigNode.ParseVector4(value);
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType.IsEnum)
            {
                try
                {
                    obj = ConfigNode.ParseEnum(field.FieldType, value);
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType == typeof(Matrix4x4))
            {
                try
                {
                    obj = ConfigNode.ParseMatrix4x4(value);
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType == typeof(Quaternion))
            {
                try
                {
                    obj = ConfigNode.ParseQuaternion(value);
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType == typeof(QuaternionD))
            {
                try
                {
                    obj = ConfigNode.ParseQuaternionD(value);
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType == typeof(Vector2))
            {
                try
                {
                    obj = (Vector2)ConfigNode.ParseVector2(value);
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType == typeof(Vector3))
            {
                try
                {
                    obj = ConfigNode.ParseVector3(value);
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType == typeof(Vector3d))
            {
                try
                {
                    obj = ConfigNode.ParseVector3D(value);
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType == typeof(Vector4))
            {
                try
                {
                    obj = ConfigNode.ParseVector4(value);
                    return true;
                }
                catch { }
            }
            return false;
        }

        private static bool Parse(object obj, FieldInfo field, ConfigNode node)
        {
            if (node.HasValue(field.Name))
            {
                object objValue = null;
                Parse(field, node.GetValue(field.Name), ref objValue);
                if (objValue != null)
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
