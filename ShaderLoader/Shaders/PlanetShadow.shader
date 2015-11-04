Shader "EVE/PlanetShadow" {
   Properties {
	  _PlanetOrigin ("Sphere Center", Vector) = (0,0,0,1)
	  _SunDir ("Sunlight direction", Vector) = (0,0,0,1)
	  _PlanetRadius ("Planet Radius", Float) = 1
   }
   SubShader {
      Pass {      
        Blend DstColor Zero
        ZWrite Off
        CGPROGRAM
		#include "EVEUtils.cginc"
 		#pragma target 3.0
		#pragma glsl
        #pragma vertex vert  
        #pragma fragment frag 
 		
        uniform sampler2D _MainTex; 
 		float4 _MainOffset;
		uniform sampler2D _DetailTex;
	    fixed4 _DetailOffset;
   	    float _DetailScale;
		float _DetailDist;
		float4 _SunDir;
		float _PlanetRadius;
		
		float3 _PlanetOrigin;
        uniform float4x4 _Projector; 
 
        struct appdata_t {
			float4 vertex : POSITION;
           	float3 normal : NORMAL;
        };
         
        struct v2f {
           	float4 pos : SV_POSITION;
           	float4 posProj : TEXCOORD0;
           	float dotcoeff : TEXCOORD1;
           	float originDist : TEXCOORD2;
			float4 worldPos : TEXCOORD3;
			float3 L : TEXCOORD7;
        };
 
        v2f vert (appdata_t v) 
        {
           	v2f o;
            o.posProj = mul(_Projector, v.vertex);
            o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
            float3 normView = normalize(float3(_Projector[2][0],_Projector[2][1], _Projector[2][2]));
    		
			float4 vertexPos = mul(_Object2World, v.vertex);
	   	   	o.worldPos = vertexPos;

	   	   	float3 worldOrigin = _PlanetOrigin;
	   	   	o.L = worldOrigin - vertexPos;
	   	   	o.originDist = length(o.L);
	   	   	
            return o;
        }
		
		fixed4 frag (v2f IN) : COLOR
		{
			half shadowCheck = step(0, IN.posProj.w);
			shadowCheck *= step(_PlanetRadius, IN.originDist+5);
			
			
	   	    float tc = dot(IN.L,- _SunDir);

			float d = sqrt(dot(IN.L,IN.L)-(tc*tc));
			half sphereCheck = step(d, _PlanetRadius)*step(0.0, tc);

			fixed4 color = half4(1,1,1,sphereCheck);
			
			color.a = 1.2*(1.2-color.a);
			color = saturate(color);
			
		
			return lerp(1, color.a, shadowCheck);
		}
 
         ENDCG
      }
   }  
}