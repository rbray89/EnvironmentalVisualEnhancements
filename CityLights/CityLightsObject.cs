
using EVEManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Utils;

namespace CityLights
{
    public class CityLightsMaterial : MaterialManager
    {
        [Persistent]
        String _CityOverlayTex = "";
        [Persistent]
        float _CityOverlayDetailScale = 80f;
        [Persistent]
        String _CityDarkOverlayDetailTex = "";
        [Persistent]
        String _CityLightOverlayDetailTex = "";
    }

    public class CityLightsObject : IEVEObject
    {
        public String Name { get { return body; } set { } }
        public ConfigNode ConfigNode { get { return node; } }
        public String Body { get { return body; } }
        private String body;
        private ConfigNode node;
        [Persistent]
        CityLightsMaterial cityLightsMaterial = null;

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
            CelestialBody celestialBody = EVEManagerClass.GetCelestialBody(body);
            if (celestialBody != null)
            {
                celestialBody.pqsController.surfaceMaterial.EnableKeyword("CITYOVERLAY_ON");
                cityLightsMaterial.ApplyMaterialProperties(celestialBody.pqsController.surfaceMaterial);
            }
            Transform transform = EVEManagerClass.GetScaledTransform(body);
            if (transform != null)
            {
                MeshRenderer mr = (MeshRenderer)transform.GetComponent(typeof(MeshRenderer));
                if (mr != null)
                {
                    mr.material.EnableKeyword("CITYOVERLAY_ON");
                    cityLightsMaterial.ApplyMaterialProperties(mr.material);
                }
            }
        }

        public void Remove()
        {
            CelestialBody celestialBody = EVEManagerClass.GetCelestialBody(body);
            if (celestialBody != null)
            {
                celestialBody.pqsController.surfaceMaterial.DisableKeyword("CITYOVERLAY_ON");
            }
            Transform transform = EVEManagerClass.GetScaledTransform(body);
            if (transform != null)
            {
                MeshRenderer mr = (MeshRenderer)transform.GetComponent(typeof(MeshRenderer));
                if (mr != null)
                {
                    mr.material.DisableKeyword("CITYOVERLAY_ON");
                }
            }
        }
    }

}
