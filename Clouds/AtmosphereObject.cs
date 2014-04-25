using EveManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Atmosphere
{
    public class AtmosphereObject : PQSMod, IEVEObject
    {
        private new String name;
        private ConfigNode node;
        [Persistent] String body = null;
        [Persistent] Clouds2D layer2D = null;
        [Persistent] CloudsVolume layerVolume = null;

        public void LoadConfigNode(ConfigNode node)
        {
            this.node = node;
            ConfigNode.LoadObjectFromConfig(this, node);
            name = node.name;
        }
        public ConfigNode GetConfigNode()
        {
            return ConfigNode.CreateConfigFromObject(this, new ConfigNode(body));
        }

        public override void OnSphereActive() 
        { }
        public override void OnSphereInactive() 
        { }
        protected void Update()
        {
            if(sphere.isActive)
            {

            }
        }

        public void Apply()
        {
            CelestialBody celestialBody = EVEManager.GetCelestialBody(body);
            if (celestialBody != null)
            {
                if (layer2D != null)
                {
                    layer2D.Apply((float)celestialBody.Radius + 4000f, celestialBody.bodyTransform);
                }
            }
        }

        public void Remove()
        {
            CelestialBody celestialBody = EVEManager.GetCelestialBody(body);
            if (celestialBody != null)
            {
            }
        }
    }
}
