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
    
    public class ShadowManager : GenericEVEManager<ShadowObject>
    {
        public override ObjectType objectType { get { return ObjectType.BODY; } }
        public override String configName { get { return "EVE_SHADOWS"; } }
        public override int LoadOrder { get { return 200; } }
        protected static ShadowProjector shadowProjector = null;

        public override void Setup()
        {
            base.Setup();
            /*
            if ( configs.Length > 0 && shadowProjector == null)
            {
                shadowProjector = new ShadowProjector();
            }
            */
        }
       
        protected void Update()
        {
            /*
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
            */
        }
        
    }
}
