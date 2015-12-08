using EVEManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Utils;

namespace TextureConfig
{
    public class TextureConfigObject : IEVEObject 
    {
#pragma warning disable 0649
        [Persistent]
        String name;
        
        public override String ToString() { return name; }

        public void LoadConfigNode(ConfigNode node)
        {
            ConfigHelper.LoadObjectFromConfig(this, node);
        }

        public void Apply() 
        { 
        }
        public void Remove() { }


    }
}
