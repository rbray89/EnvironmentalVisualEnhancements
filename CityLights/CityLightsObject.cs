
using EveManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Utils;

namespace CityLights
{
    public class CityLightsObject : IEVEObject
    {
        private String body;
        private ConfigNode node;
        [Persistent]
        TextureManager mainTexture = null;
        [Persistent]
        TextureManager detailTexture = null;

        public void LoadConfigNode(ConfigNode node)
        {
            this.node = node;
            ConfigNode.LoadObjectFromConfig(this, node);
            body = node.name;
        }
        public ConfigNode GetConfigNode()
        {
            return ConfigNode.CreateConfigFromObject(this, new ConfigNode(body));
        }

        public void Apply()
        {
            CelestialBody celestialBody = EVEManager.GetCelestialBody(body);
            if (celestialBody != null)
            {
                celestialBody.pqsController.surfaceMaterial.EnableKeyword("CITYOVERLAY_ON");
                celestialBody.pqsController.surfaceMaterial.SetTexture("_DarkOverlayTex", mainTexture.GetTexture());
                celestialBody.pqsController.surfaceMaterial.SetTexture("_DarkOverlayDetailTex", detailTexture.GetTexture());
            }
        }

        public void Remove()
        {
            CelestialBody celestialBody = EVEManager.GetCelestialBody(body);
            if (celestialBody != null)
            {
                celestialBody.pqsController.surfaceMaterial.DisableKeyword("CITYOVERLAY_ON");
            }
        }
    }

}
