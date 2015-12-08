using EVEManager;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using Utils;

namespace CelestialShadows
{
    

    public class ShadowObject : IEVEObject
    {
#pragma warning disable 0649
        [Persistent, GUIHidden]
        private String body;

        ShadowComponent shadow;

        public void LoadConfigNode(ConfigNode node)
        {
            ConfigHelper.LoadObjectFromConfig(this, node);
        }

        public void Apply()
        {
            GameObject go = new GameObject();
            shadow = go.AddComponent<ShadowComponent>();
            shadow.Apply( body );
        }

        public void Remove()
        {
            shadow.Remove();
            GameObject go = shadow.gameObject;
            GameObject.DestroyImmediate(shadow);
            GameObject.DestroyImmediate(go);
        }
    }
}
