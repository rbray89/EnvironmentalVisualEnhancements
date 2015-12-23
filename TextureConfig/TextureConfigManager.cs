using EVEManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Utils;

namespace TextureConfig
{

    public class TextureConfig : GenericEVEManager<TextureConfigObject>
    {
        public override ObjectType objectType { get { return ObjectType.STATIC | ObjectType.MULTIPLE; } }
        public override String configName { get { return "EVE_TEXTURE_CONFIG"; } }
        public override int LoadOrder { get { return 10; } }

    }
}
