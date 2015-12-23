using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EVEManager;
using Utils;
using UnityEngine;
using System.Collections;
using System.Reflection;

namespace PartFX
{
    public class IVAWindowManager : GenericEVEManager<IVAWindowObject>
    {
        public override ObjectType objectType { get { return ObjectType.STATIC | ObjectType.MULTIPLE; } }
        public override String configName { get { return "IVA_WINDOW_CONFIG"; } }
        
    }

    
}
