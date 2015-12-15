using Utils;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;
using EVEManager;
using ShaderLoader;

namespace CelestialShadows
{
       
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class ShadowManager : GenericEVEManager<ShadowObject>
    {
        protected override ObjectType objectType { get { return ObjectType.BODY; } }
        protected override String configName { get { return "EVE_SHADOWS"; } }
        protected static ShadowProjector shadowProjector = null;

        public override void Setup()
        {
            if ((ObjectType.STATIC & objectType) != ObjectType.STATIC)
            {
                Managers.RemoveAll(item => item == null || item.GetType() == this.GetType());
                Managers.Add(this);
                LoadConfig();
                if( configs.Length > 0 && shadowProjector == null)
                {
                    shadowProjector = new ShadowProjector();
                }
            }
            else
            {
                StaticSetup(this);
            }
        }
       /* 
        protected void Update()
        {
            if (shadowProjector != null)
            {
                if (HighLogic.LoadedScene == GameScenes.SPACECENTER || (HighLogic.LoadedScene == GameScenes.FLIGHT && !MapView.MapIsEnabled))
                {
                    if (FlightGlobals.ready && FlightGlobals.activeTarget != null)
                    {
                        shadowProjector.UpdatePos(FlightGlobals.activeTarget.transform.position);
                    }
                    if (FlightCamera.fetch != null)
                    {
                        shadowProjector.UpdatePos(FlightCamera.fetch.mainCamera.transform.position);
                    }
                    else
                    {
                        shadowProjector.UpdatePos(SpaceCenter.Instance.SpaceCenterTransform.position);
                    }
                }
            }
        }
        */
    }
}
