Shader "EVE/Cloud" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		_FalloffPow ("Falloff Power", Range(0,3)) = 2
		_FalloffScale ("Falloff Scale", Range(0,20)) = 3
		_DetailScale ("Detail Scale", Range(0,100)) = 100
		_DetailDist ("Detail Distance", Range(0,1)) = 0.00875
		_MinLight ("Minimum Light", Range(0,1)) = .5
		_FadeDist ("Fade Distance", Range(0,100)) = 10
		_FadeScale ("Fade Scale", Range(0,1)) = .002
		_RimDist ("Rim Distance", Range(0,1)) = 1
		_RimDistSub ("Rim Distance Sub", Range(0,2)) = 1.01
		_InvFade ("Soft Particles Factor", Range(0.01,3.0)) = .01
	}

Category {
	
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Mode Global}
	AlphaTest Greater 0
	ColorMask RGB
	Cull Off Lighting On ZWrite Off
	
SubShader {
	Pass {

		Lighting On
		Tags { "LightMode"="ForwardBase"}
		
		CGPROGRAM
		
		#include "EVEUtils.cginc"
		#include "UnityCG.cginc"
		#include "AutoLight.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma glsl
		#pragma vertex vert
		#pragma fragment frag
		#define MAG_ONE 1.4142135623730950488016887242097
		#pragma fragmentoption ARB_precision_hint_fastest
		#pragma multi_compile_fwdbase
		#pragma multi_compile_fwdadd_fullshadows
		#pragma multi_compile SOFT_DEPTH_OFF SOFT_DEPTH_ON
	 
		sampler2D _MainTex;
		sampler2D _DetailTex;
		fixed4 _Color;
		float _FalloffPow;
		float _FalloffScale;
		float _DetailScale;
		float _DetailDist;
		float _MinLight;
		float _FadeDist;
		float _FadeScale;
		float _RimDist;
		float _RimDistSub;
		
		float _InvFade;
		sampler2D _CameraDepthTexture;
			
		struct appdata_t {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float3 normal : NORMAL;
			};

		struct v2f {
			float4 pos : SV_POSITION;
			float3 worldVert : TEXCOORD0;
			float3 worldOrigin : TEXCOORD1;
			float4 objDetail : TEXCOORD2;
			float4 objMain : TEXCOORD3;
			float3 worldNormal : TEXCOORD4;
			float3 viewDir : TEXCOORD5;
			LIGHTING_COORDS(6,7)
			float4 projPos : TEXCOORD8;
		};	
		

		v2f vert (appdata_t v)
		{
			v2f o;
			
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			
		   float4 vertexPos = mul(_Object2World, v.vertex);
		   float3 origin = mul(_Object2World, float4(0,0,0,1)).xyz;
	   	   o.worldVert = vertexPos;
	   	   o.worldOrigin = origin;
	   	   o.worldNormal = normalize(vertexPos-origin);
	   	   o.objMain = -mul(_MainRotation, v.vertex);
	   	   o.objDetail = mul(_DetailRotation, o.objMain);
	   	   o.viewDir = normalize(WorldSpaceViewDir(v.vertex));
	   	   #ifdef SOFT_DEPTH_ON
	   	   o.projPos = ComputeScreenPos (o.pos);
			COMPUTE_EYEDEPTH(o.projPos.z);
			TRANSFER_VERTEX_TO_FRAGMENT(o);
		   #endif
	   	   return o;
	 	}
	 		
		fixed4 frag (v2f IN) : COLOR
			{
			half4 color;
		    half4 main = GetSphereMap(_MainTex, IN.objMain);
			half4 detail = GetShereDetailMap(_DetailTex, IN.objDetail, _DetailScale);
			
			float viewDist = distance(IN.worldVert,_WorldSpaceCameraPos);
			half detailLevel = saturate(2*_DetailDist*viewDist);
			color = main.rgba * lerp(detail.rgba, 1, detailLevel);

			float rim = saturate(dot(IN.viewDir, IN.worldNormal));
			rim = saturate(pow(_FalloffScale*rim,_FalloffPow));
			float dist = distance(IN.worldVert,_WorldSpaceCameraPos);
			float distLerp = saturate(_RimDist*(distance(IN.worldOrigin,_WorldSpaceCameraPos)-_RimDistSub*distance(IN.worldVert,IN.worldOrigin)));
			float distFade = saturate((_FadeScale*dist)-_FadeDist);
	   	   	float distAlpha = lerp(distFade, rim, distLerp);

			color.a = lerp(0, color.a,  distAlpha);

          	//lighting
			half3 ambientLighting = UNITY_LIGHTMODEL_AMBIENT;
			half3 lightDirection = normalize(_WorldSpaceLightPos0);
			half NdotL = saturate(dot (IN.worldNormal, lightDirection));
	        half diff = (NdotL - 0.01) / 0.99;
			half lightIntensity = saturate(_LightColor0.a * diff * 4);
			color.rgb *= saturate(ambientLighting + ((_MinLight + _LightColor0.rgb) * lightIntensity));
			#ifdef SOFT_DEPTH_ON
			float depth = UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(IN.projPos)));
			depth = LinearEyeDepth (depth);
			float partZ = IN.projPos.z;
			float fade = saturate (_InvFade * (depth-partZ));
			color.a *= fade;
			#endif
          	return color;
		}
		ENDCG
	
		}
		
	} 
	
}
}
