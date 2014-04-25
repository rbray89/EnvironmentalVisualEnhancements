using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Atmosphere
{
    class AtmosphereVolume
    {
        public static Dictionary<String, List<AtmosphereVolume>> BodyDatabase = new Dictionary<string, List<AtmosphereVolume>>();
        public static Dictionary<string, Dictionary<string, List<AtmosphereVolume>>> ConfigBodyDatabase = new Dictionary<string, Dictionary<string, List<AtmosphereVolume>>>();
        public static List<AtmosphereVolume> Volumes = new List<AtmosphereVolume>();

        private GameObject VolumeParent;
        private float timeDelta = 0;
        private Vector2 Speed;
        private float BodyRadius;
        private Material CloudParticleMaterial;

        private VolumeManager Volume;

 

        public AtmosphereVolume(string body, Vector2 speed)
        {
            VolumeParent = new GameObject();
            CelestialBody[] celestialBodies = (CelestialBody[])CelestialBody.FindObjectsOfType(typeof(CelestialBody));
            CelestialBody celestialBody = celestialBodies.First(n => n.bodyName == body);
            BodyRadius = (float)celestialBody.Radius;
            VolumeParent.transform.parent = celestialBody.transform;
            VolumeParent.transform.localPosition = Vector3.zero;
            VolumeParent.transform.localScale = Vector3.one;

            Speed = speed;

            CloudParticleMaterial = new Material(CloudLayer.CloudParticleShader);


            Texture2D tex1 = GameDatabase.Instance.GetTexture("BoulderCo/Clouds/Textures/particle/1", false);
            Texture2D tex2 = GameDatabase.Instance.GetTexture("BoulderCo/Clouds/Textures/particle/2", false);
            Texture2D tex3 = GameDatabase.Instance.GetTexture("BoulderCo/Clouds/Textures/particle/3", false);

            tex1.wrapMode = TextureWrapMode.Clamp;
            tex2.wrapMode = TextureWrapMode.Clamp;
            tex3.wrapMode = TextureWrapMode.Clamp;

            CloudParticleMaterial.SetTexture("_TopTex", tex1);
            CloudParticleMaterial.SetTexture("_LeftTex", tex2);
            CloudParticleMaterial.SetTexture("_FrontTex", tex3);
            CloudParticleMaterial.SetFloat("_DistFade", 1f / 2250f);

            Volume = new VolumeManager(BodyRadius, CloudParticleMaterial, VolumeParent.transform);

            Volumes.Add(this);
            if(!BodyDatabase.ContainsKey(body))
            {
                BodyDatabase.Add(body, new List<AtmosphereVolume>());
            }
            BodyDatabase[body].Add(this);
        }

        private void updateOffset(float time)
        {
            float rotx = time * this.Speed.x;
            float roty = time * this.Speed.y;

            Vector2 rotation;
            rotation.x = roty;
            rotation.y = rotx;
            VolumeParent.transform.Rotate(360f * rotation);

        }

        public void PerformUpdate(Vector3 WorldPos)
        {
            timeDelta = Time.time - timeDelta;
            float timeRate = TimeWarp.CurrentRate == 0 ? 1 : TimeWarp.CurrentRate;
            float timeOffset = timeDelta * timeRate;
            updateOffset(timeOffset);
            timeDelta = Time.time;

            Vector3 intendedPoint = VolumeParent.transform.InverseTransformPoint(WorldPos);
            Volume.Update(intendedPoint);

        }
    }
}
