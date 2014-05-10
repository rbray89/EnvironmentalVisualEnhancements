using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Utils;

namespace EVEManager
{
    public interface IEVEObject : INamed
    {
        ConfigNode ConfigNode { get; }
        String Body { get; }
        void LoadConfigNode(ConfigNode node, String body);
        ConfigNode GetConfigNode();
        void Apply();
        void Remove();
    }
}
