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
        public String Name { get { return body; } set { } }
        public ConfigNode ConfigNode { get { return node; } }
        public String Body { get { return body; } }
        private String body;
        private ConfigNode node;

        ShadowPQS shadowPQS;

        public void LoadConfigNode(ConfigNode node, String body)
        {
            ConfigNode.LoadObjectFromConfig(this, node);
            this.node = node;
            this.body = body;
        }
        public ConfigNode GetConfigNode()
        {
            return ConfigNode.CreateConfigFromObject(this, new ConfigNode(body));
        }

        public void Apply()
        {
            GameObject go = new GameObject();
            shadowPQS = go.AddComponent<ShadowPQS>();
            shadowPQS.Apply( body );
        }

        public void Remove()
        {
            shadowPQS.Remove();
            GameObject go = shadowPQS.gameObject;
            GameObject.DestroyImmediate(shadowPQS);
            GameObject.DestroyImmediate(go);
        }
    }
}
