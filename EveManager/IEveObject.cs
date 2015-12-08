using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Utils;

namespace EVEManager
{
    public interface IEVEObject
    {
        void LoadConfigNode(ConfigNode node, String name);
        void Apply();
        void Remove();
    }
}
