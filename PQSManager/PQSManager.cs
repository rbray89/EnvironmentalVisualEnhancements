using EveManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace PQSManager
{
    public class PQSManager : GenericEVEManager<PQSModWrapper>
    {
        protected override String configName { get { return ""; } }

        protected new void Update()
        {
            foreach (PQSModWrapper mod in ObjectList)
            {
                
            }
        }

    }
}
