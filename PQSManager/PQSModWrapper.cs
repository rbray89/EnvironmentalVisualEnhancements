using EveManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PQSManager
{
    public class PQSModWrapper : IEVEObject
    {
        static List<PQS> fakePQSList = new List<PQS>();

        public void LoadConfigNode(ConfigNode node) { }
        public ConfigNode GetConfigNode() { return null; }
        public void Apply() { }
        public void Remove() { }
    }
}
