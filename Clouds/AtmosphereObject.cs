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
        public String Name { get { return name; } set { name = node.name = value; } }
        private new String name;
        private ConfigNode node;
        private String body;

        
        [Persistent]
        float altitude = 1000f;

        [Persistent]
        AtmosphereVolumeMaterial atmosphereMaterial = null;

        AtmosphereVolume atmosphere = null;

        private AtmospherePQS atmospherePQS = null;
        private CelestialBody celestialBody;
        private Transform scaledCelestialTransform;
        public void LoadConfigNode(ConfigNode node, String body)
        {
            ConfigHelper.LoadObjectFromConfig(this, node);
            this.node = node;
            this.body = body;
            name = node.name;
        }

        public void Apply()
        {
            celestialBody = Tools.GetCelestialBody(body);
            scaledCelestialTransform = Tools.GetScaledTransform(body);
            
            GameObject go = new GameObject();
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
