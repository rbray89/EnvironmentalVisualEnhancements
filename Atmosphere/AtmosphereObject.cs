using EVEManager;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Utils;

namespace Atmosphere
{

    public class AtmosphereObject : MonoBehaviour, IEVEObject
    {
#pragma warning disable 0649
        [ConfigItem]
        private String body;

        [ConfigItem]
        float altitude = 1000f;

        [ConfigItem]
        AtmosphereVolumeMaterial atmosphereMaterial = null;

        AtmosphereVolume atmosphere = null;

        private AtmospherePQS atmospherePQS = null;
        private CelestialBody celestialBody;
        private Transform scaledCelestialTransform;
        public void LoadConfigNode(ConfigNode node)
        {
            ConfigHelper.LoadObjectFromConfig(this, node);
        }

        public void Apply()
        {
            celestialBody = Tools.GetCelestialBody(body);
            scaledCelestialTransform = Tools.GetScaledTransform(body);
            
            GameObject go = new GameObject("AtmosphereObject");
            atmospherePQS = go.AddComponent<AtmospherePQS>();
            atmosphere = new AtmosphereVolume(atmosphereMaterial);
            atmospherePQS.Apply(body, atmosphere, altitude);
        }

        public void Remove()
        {
            atmospherePQS.Remove();
            GameObject go = atmospherePQS.gameObject;
            

            GameObject.DestroyImmediate(atmospherePQS);
            GameObject.DestroyImmediate(go);
            atmosphere = null;
        }
    }
}
