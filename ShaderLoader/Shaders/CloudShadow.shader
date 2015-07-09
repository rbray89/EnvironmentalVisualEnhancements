Shader "EVE/CloudShadow" {
   Properties {
      _MainTex ("Main (RGB)", 2D) = "white" {}
      _DetailTex ("Detail (RGB)", 2D) = "white" {}
      _DetailScale ("Detail Scale", float) = 100
      _DetailDist ("Detail Distance", Range(0,1)) = 0.00875
	  _PlanetOrigin ("Sphere Center", Vector) = (0,0,0,1)
	  _SunDir ("Sunlight direction", Vector) = (0,0,0,1)
	  _Radius ("Radius", Float) = 1
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
		float _Radius;
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
			float4 mainPos : TEXCOORD4; 
			float4 detailPos : TEXCOORD5;
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
	   	   	float3 L = worldOrigin - vertexPos;
	   	   	o.originDist = length(L);
	   	    float tc = dot(L,- _SunDir);
	   	    o.dotcoeff = tc;
			float d = sqrt(dot(L,L)-(tc*tc));
			float d2 = pow(d,2);
			float td = sqrt(dot(L,L)-d2);		
			float sphereRadius = _Radius;
			half sphereCheck = step(d, sphereRadius)*step(0.0, tc);
			float tlc = sqrt((sphereRadius*sphereRadius)-d2);
			float sphereDist = lerp(0, tc - tlc, sphereCheck);
			o.worldPos = vertexPos + (_SunDir*sphereDist);
			o.mainPos = -mul(_MainRotation, o.worldPos);
			o.detailPos = mul(_DetailRotation, o.mainPos);
            return o;
        }
		
		fixed4 frag (v2f IN) : COLOR
		{
			half shadowCheck = step(0, IN.posProj.w)*step(0,IN.dotcoeff)*step(IN.originDist,_Radius);
			shadowCheck *= step(_PlanetRadius, IN.originDist+5);
			half4 main = GetSphereMap(_MainTex, IN.mainPos);
			half4 detail = GetShereDetailMap(_DetailTex, IN.detailPos, _DetailScale);
			
			float viewDist = distance(IN.worldPos,_WorldSpaceCameraPos);
			half detailLevel = saturate(2*_DetailDist*viewDist);
			fixed4 color = main.rgba * lerp(detail.rgba, 1, detailLevel);
			
			color.a = 1.2*(1.2-color.a);
			color = saturate(color);
			
		
			return lerp(1, color.a, shadowCheck);
		}
 
         ENDCG
      }
   }  
}