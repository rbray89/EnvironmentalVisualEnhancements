using EVEManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Utils;

namespace Atmosphere
{
    public class AtmosphereObject : PQSMod, IEVEObject
    {
        public String Name { get { return name; } set { name = node.name = value; } }
        public ConfigNode ConfigNode { get { return node; } }
        public String Body { get { return body; } }
        private new String name;
        private ConfigNode node;
        private String body;
        [Persistent]
        float altitude = 1000f;
        [Persistent]
        float speed = 30;
        [Persistent, Optional]
        CloudsVolume layerVolume = null;
        [Persistent, Optional]
        Clouds2D layer2D = null;

        bool isActive = true;
        public void LoadConfigNode(ConfigNode node, String body)
        {
            ConfigNode.LoadObjectFromConfig(this, node);
            this.node = node;
            this.body = body;
            name = node.name;
        }
        public ConfigNode GetConfigNode()
        {
            return ConfigNode.CreateConfigFromObject(this, new ConfigNode(body));
        }

        public override void OnSphereActive()
        {
            AtmosphereManager.Log("Active.");
            if (isActive)
            {
                CelestialBody celestialBody = EVEManagerClass.GetCelestialBody(body);
                if (layer2D != null)
                {
                    layer2D.Apply((float)celestialBody.Radius + altitude, speed, celestialBody.transform);
                }
                if (layerVolume != null)
                {
                    layerVolume.Apply((float)celestialBody.Radius + altitude, speed, celestialBody.transform);
                }
            }
        }
        public override void OnSphereInactive()
        {
            AtmosphereManager.Log("Inactive.");
            if (layer2D != null)
            {
                layer2D.Remove();
            }
            if (layerVolume != null)
            {
                layerVolume.Remove();
            }
        }
        protected void Update()
        {
            if (this.sphere != null && sphere.isActive)
            {
                if (layer2D != null)
                {
                    layer2D.UpdateRotation(Quaternion.FromToRotation(Vector3.up, this.sphere.relativeTargetPosition));
                }
                if (layerVolume != null)
                {
                    layerVolume.UpdatePos(this.sphere.target.position);
                }
            }
        }

        public void Apply()
        {
            CelestialBody celestialBody = EVEManagerClass.GetCelestialBody(body);
            if (celestialBody != null && celestialBody.pqsController != null)
            {
                this.transform.parent = celestialBody.pqsController.transform;
                this.sphere = celestialBody.pqsController;
                if (this.sphere.isActive)
                {
                    this.OnSphereActive();
                }
            }            
        }

        public void Remove()
        {
            if (layer2D != null)
            {
                layer2D.Remove();
            }
            if (layerVolume != null)
            {
                layerVolume.Remove();
            }
            //isActive = false;
        }
        /*
        private static Transform GetTargetPos()
        {
            if (HighLogic.LoadedScene == GameScenes.FLIGHT)
            {
                Vector3 COM = FlightGlobals.ActiveVessel.findWorldCenterOfMass();
            }
            else if (HighLogic.LoadedScene == GameScenes.SPACECENTER)
            {
                GameObject ksc = GameObject.Find("KSC");
                ksc.transform.position;
            }
        }*/
    }
}
