Shader "Sphere/Atmosphere" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_Visibility ("Visibility", Float) = .0001
		_FalloffPow ("Falloff Power", Range(0,3)) = 2
		_FalloffScale ("Falloff Scale", Range(0,20)) = 3
		_FadeDist ("Fade Distance", Range(0,100)) = 10
		_FadeScale ("Fade Scale", Range(0,1)) = .002
		_RimDist ("Rim Distance", Range(0,1)) = 1
		_RimDistSub ("Rim Distance Sub", Range(0,2)) = 1.01
		_OceanRadius ("Ocean Radius", Float) = 63000
		_SphereRadius ("Ocean Radius", Float) = 67000
		_PlanetOrigin ("Sphere Center", Vector) = (0,0,0,1)
	}

Category {
	
	Tags { "Queue"="Overlay" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Mode Off}
	ZTest Off
	ColorMask RGB
	Cull Off Lighting On ZWrite Off
	
SubShader {
	Pass {

		Lighting On
		Tags { "LightMode"="ForwardBase"}
		
		CGPROGRAM
		
		#include "UnityCG.cginc"
		#include "AutoLight.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma glsl
		#pragma vertex vert
		#pragma fragment frag
		#define MAG_ONE 1.4142135623730950488016887242097
		#pragma fragmentoption ARB_precision_hint_fastest
		#define PI 3.1415926535897932384626
		#define INV_PI (1.0/PI)
		#define TWOPI (2.0*PI) 
		#define INV_2PI (1.0/TWOPI)
	    #define FLT_MAX (1e+32)
		fixed4 _Color;
		sampler2D _CameraDepthTexture;
		float _Visibility;
		float _FalloffPow;
		float _FalloffScale;
		float _FadeDist;
		float _FadeScale;
		float _RimDist;
		float _RimDistSub;
		float _OceanRadius;
		float _SphereRadius;
		float3 _PlanetOrigin;
		
		struct appdata_t {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float3 normal : NORMAL;
			};

		struct v2f {
			float4 pos : SV_POSITION;
			float4 scrPos : TEXCOORD0;
			float3 worldVert : TEXCOORD1;
			float3 worldOrigin : TEXCOORD2;
			float3 viewDir : TEXCOORD3;
			float  viewDist : TEXCOORD4;
			float  altitude : TEXCOORD5;
			float3 L : TEXCOORD6;
		};	
		

		v2f vert (appdata_t v)
		{
			v2f o;
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			
		   float3 vertexPos = mul(_Object2World, v.vertex).xyz;
	   	   o.worldVert = vertexPos;
	   	   o.viewDist = distance(vertexPos,_WorldSpaceCameraPos);
	   	   o.viewDir = normalize(WorldSpaceViewDir(v.vertex));
	   	   o.scrPos=ComputeScreenPos(o.pos);
	   	   o.altitude = distance(_PlanetOrigin,_WorldSpaceCameraPos) - _OceanRadius;
	   	   
	   	   o.L = _PlanetOrigin - _WorldSpaceCameraPos;
	   	   
		   COMPUTE_EYEDEPTH(o.scrPos.z);
	   	   return o;
	 	}
	 		
		fixed4 frag (v2f IN) : COLOR
			{
			half4 color = _Color;
			float depth = UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(IN.scrPos)));
			depth = LinearEyeDepth(depth);
			float sphereDist = 0;
			
			half3 worldDir = normalize(IN.worldVert - _WorldSpaceCameraPos);
			float tc = dot(IN.L, worldDir);
			float d = sqrt(dot(IN.L,IN.L)-dot(tc,tc));
		   	float Llength = length(IN.L);
		   	   
			float oceanSphereDist = depth;
		   	   if (d <= _OceanRadius && tc >= 0.0)
		   	   {
			   	   float tlc = sqrt(pow(_OceanRadius,2)-pow(d,2));
			   	   oceanSphereDist = tc - tlc;
		   	   }
			depth = min(oceanSphereDist, depth);
		   	   
		   	   if (Llength <  _SphereRadius && tc < 0.0)
		   	   {
			   	   float tlc = sqrt(pow(_SphereRadius,2)-pow(d,2));
			   	   float td = sqrt(pow(Llength,2)-pow(d,2));
			   	   sphereDist = tlc - td;
			   	   depth = min(depth, sphereDist);
		   	   }
		   	   else if (d <= _SphereRadius && tc >= 0.0)
		   	   {
			   	   float tlc = sqrt(pow(_SphereRadius,2)-pow(d,2));
			   	   half sphereCheck = saturate(_SphereRadius - Llength);
			   	   sphereDist = lerp(tc - tlc, tlc + tc, sphereCheck);
			   	   depth = lerp( min(tc+tlc, depth)-sphereDist, min(depth, sphereDist), sphereCheck);
		   	   }
			depth = lerp(0, depth, saturate(sphereDist));
			//depth = min(depth, sphereDist);
			
			depth *= _Visibility; 
			color.a *= depth;
          	return color;
		}
		ENDCG
	
		}
		
	} 
	
}
}
