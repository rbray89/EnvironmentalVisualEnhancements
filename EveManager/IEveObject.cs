using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EveManager
{
    public interface IEVEObject
    {
        void LoadConfigNode(ConfigNode node);
        ConfigNode GetConfigNode();
        void Apply();
        void Remove();
    }
}
