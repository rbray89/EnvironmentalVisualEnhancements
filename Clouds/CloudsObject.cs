using EveManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Clouds
{
    public class CloudsObject : PQSMod, IEVEObject
    {
        [Persistent] String body = null;
        [Persistent] Clouds2D layer2D = null;
        [Persistent] CloudsVolume layerVolume = null;

        public void LoadConfigNode(ConfigNode node)
        {
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
