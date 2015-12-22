using EVEManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Utils;

namespace TextureConfig
{
    [KSPAddon(KSPAddon.Startup.MainMenu, false)]
    public class TextureConfig : GenericEVEManager<TextureConfigObject>
    {
        protected override ObjectType objectType { get { return ObjectType.STATIC | ObjectType.MULTIPLE; } }
        protected override String configName { get { return "EVE_TEXTURE_CONFIG"; } }
        protected override bool DelayedLoad { get { return false; } }

    }
}
