using EveManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PQSManager
{
    public class PQSModWrapper : IEVEObject
    {
        public String Name { get { return null; } }
        static List<PQS> fakePQSList = new List<PQS>();
        public ConfigNode ConfigNode { get { return null; } }
        public String Body { get { return null; } }
        public void LoadConfigNode(ConfigNode node, String body) { }
        public ConfigNode GetConfigNode() { return null; }
        public void Apply() { }
        public void Remove() { }
    }
}
