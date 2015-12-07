using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using UnityEngine;

namespace Utils
{
    
    public class Optional : System.Attribute
    {
    }

    public class ValueNode : System.Attribute
    {
    }

    public class ValueFilter : System.Attribute
    {
        private string fieldMask;

        public ValueFilter(string fieldMask)
        {
            this.fieldMask = fieldMask;
        }

        internal bool IsAllowed(string name)
        {
            return Regex.IsMatch(name, fieldMask);
        }
    }
    

    public class EnumMask : System.Attribute
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

    public class ConfigWrapper 
    {
        public override String ToString(){ return name; }
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
        public const string VALUE_FIELD = "value";

        public static bool ConditionsMet(FieldInfo field, FieldInfo parent, ConfigNode node)
        {
            bool isConditional = Attribute.IsDefined(field, typeof(Conditional));
            Conditional conditional = (Conditional)Attribute.GetCustomAttribute(field, typeof(Conditional));
            
            bool conditionsMet = true;

            conditionsMet &= ValueIsAllowed(field, parent);
            
            if (isConditional)
            {
                try
                {
                    conditionsMet &= conditional.CheckConditional(field.DeclaringType, node);
                }
                catch
                {
                    conditionsMet &= false;
                }
            }

            return conditionsMet;
        }

        public static bool ValueIsAllowed(FieldInfo field, FieldInfo parent)
        {
            bool isAllowed = true;
            if (field.Name != VALUE_FIELD)
            {
                ValueFilter filter = null;
                if(parent != null && Attribute.IsDefined(parent, typeof(ValueFilter)))
                {
                    filter = (ValueFilter)Attribute.GetCustomAttribute(parent, typeof(ValueFilter));
                }
                else if(Attribute.IsDefined(field.DeclaringType, typeof(ValueFilter)))
                {
                    filter = (ValueFilter)Attribute.GetCustomAttribute(field.DeclaringType, typeof(ValueFilter));
                }
                if (filter != null)
                {
                    isAllowed = filter.IsAllowed(field.Name);
                }
                
            }
            
            return isAllowed;
        }

        public static bool IsValueNode(FieldInfo field)
        {
            bool isNode = false;
            if (Attribute.IsDefined(field, typeof(ValueNode)))
            {
                isNode = true;
            }
            else if (Attribute.IsDefined(field.FieldType, typeof(ValueNode)))
            {
                isNode |= true;
            }

            return isNode;
        }

        public static bool IsNode(FieldInfo field, ConfigNode node, bool checkConfig = true)
        {
            bool isNode = field.FieldType.GetFields(BindingFlags.Instance | BindingFlags.NonPublic).Where(
               fi => Attribute.IsDefined(fi, typeof(Persistent))).Count() > 0 ? true : false;
             
            if(Attribute.IsDefined(field, typeof(ValueNode)))
            {
                if (checkConfig)
                {
                    isNode &= node.HasNode(field.Name);
                }
            }
            else if(Attribute.IsDefined(field.FieldType, typeof(ValueNode)))
            {
                if (checkConfig)
                {
                    isNode &= node.HasNode(field.Name);
                }
            }

            return isNode;
        }

        public static bool CanParse(FieldInfo field, String value, ConfigNode node = null)
        {
            object test = null;
            return Parse(field, ref test, value, node);
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
                object objValue = null;
                bool canParse = Parse(field, ref objValue, node.GetValue(field.Name), node.GetNode(field.Name));
                if (objValue != null)
                {
                    field.SetValue(obj, objValue);
                }
                if (!canParse)
                {
                    KSPLog.print("unable to parse \"" + field.Name + "\" in \""+node.name+"\"!");
                    return false;
                }
                   
            }
            return true;
        }

        private static bool Parse(FieldInfo field, ref object obj, string value, ConfigNode node = null)
        {
            obj = null;
            if (field.FieldType == typeof(float))
            {
                try
                {
                    if (value != null)
                    {
                        obj = float.Parse(value);
                    }
                    return true;
                }
                catch { }
            }
            else if (field.FieldType == typeof(double))
            {
                try
                {
                    if (value != null)
                    {
                        obj = double.Parse(value);
                    }
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType == typeof(bool))
            {
                try
                {
                    if (value != null)
                    {
                        obj = bool.Parse(value);
                    }
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
                    if (value != null)
                    {
                        obj = (Color)ConfigNode.ParseVector4(value);
                    }
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType.IsEnum)
            {
                try
                {
                    if (value != null)
                    {
                        obj = ConfigNode.ParseEnum(field.FieldType, value);
                    }
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType == typeof(Matrix4x4))
            {
                try
                {
                    if (value != null)
                    {
                        obj = ConfigNode.ParseMatrix4x4(value);
                    }
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType == typeof(Quaternion))
            {
                try
                {
                    if (value != null)
                    {
                        obj = ConfigNode.ParseQuaternion(value);
                    }
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType == typeof(QuaternionD))
            {
                try
                {
                    if (value != null)
                    {
                        obj = ConfigNode.ParseQuaternionD(value);
                    }
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType == typeof(Vector2))
            {
                try
                {
                    if (value != null)
                    {
                        obj = (Vector2)ConfigNode.ParseVector2(value);
                    }
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType == typeof(Vector3))
            {
                try
                {
                    if (value != null)
                    {
                        obj = ConfigNode.ParseVector3(value);
                    }
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType == typeof(Vector3d))
            {
                try
                {
                    if (value != null)
                    {
                        obj = ConfigNode.ParseVector3D(value);
                    }
                    return true;
                }
                catch {  }
            }
            else if (field.FieldType == typeof(Vector4))
            {
                try
                {
                    if (value != null)
                    {
                        obj = ConfigNode.ParseVector4(value);
                    }
                    return true;
                }
                catch { }
            }
            else
            {
                bool isOptional = Attribute.IsDefined(field, typeof(Optional));
                bool valueNode = IsValueNode(field);

                ConstructorInfo ctor = field.FieldType.GetConstructor(System.Type.EmptyTypes);
                obj = ctor.Invoke(null);
                
                if (node != null)
                {
                    if (!LoadObjectFromConfig(obj, node))
                    {
                        return false;
                    }
                }
                else if(valueNode && value != null)
                {
                    obj.GetType().GetField(VALUE_FIELD, BindingFlags.Instance | BindingFlags.NonPublic).SetValue(obj, value);
                }
                else if (!isOptional)
                {
                    KSPLog.print("non-optional field \"" + field.Name + "\" in \"" + node.name + "\" is not set!");
                    return false;
                }
                MethodInfo validate = obj.GetType().GetMethod("isValid");
                if (validate != null && obj != null)
                {
                    return (bool)validate.Invoke(obj, null);
                }
                
                return true;
            }

             return false;
        }

    }
}
