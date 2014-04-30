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
        public Material ApplyMaterialProperties(Material material, bool clampTextures = false)
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
                    material.SetTexture(name, texture);
                }
                //float
                if (field.FieldType == typeof(float))
                {
                    float value = (float)field.GetValue(this);
                    material.SetFloat(name, value);
                }
                //Color
                if (field.FieldType == typeof(Color))
                {
                    Color value = (Color)field.GetValue(this);
                    material.SetColor(name, value);
                }
                //Vector3
                if (field.FieldType == typeof(Vector3))
                {
                    Vector3 value = (Vector3)field.GetValue(this);
                    material.SetVector(name, value);
                }

            }
            return material;
        }
    }
}
