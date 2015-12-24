using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EVEManager;
using Utils;
using UnityEngine;
using System.Collections;
using System.Reflection;

namespace TextureUnloader
{
    public class TextureUnloaderManager : GenericEVEManager<TextureUnloaderObject>
    {
        public override ObjectType objectType { get { return ObjectType.STATIC | ObjectType.MULTIPLE; } }
        public override String configName { get { return "TEXTURE_ULOADER_CONFIG"; } }
        public override int LoadOrder { get { return 50; } }

        public override void Apply()
        {
            (new TextureUnloaderObject()).Apply();
        }

        protected override void ApplyConfigNode(ConfigNode node)
        {
           
        }

    }

    
}
