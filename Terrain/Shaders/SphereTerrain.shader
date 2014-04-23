Shader "Sphere/Terrain" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		_DetailVertTex ("Detail for Vertical Surfaces (RGB)", 2D) = "white" {}
		_DetailScale ("Detail Scale", Range(0,1000)) = 200
		_DetailVertScale ("Detail Scale", Range(0,1000)) = 200
		_DetailDist ("Detail Distance", Range(0,1)) = 0.00875
		_MinLight ("Minimum Light", Range(0,1)) = .5
		_DarkOverlayTex ("Overlay (RGB)", 2D) = "white" {}
		_DarkOverlayDetailTex ("Overlay Detail (RGB) (A)", 2D) = "white" {}
		_DarkOverlayDetailScale ("Overlay Detail Scale", Range(0,1000)) = 80)
	}

Category {
	
SubShader {

Tags { "Queue"="Geometry" "RenderType"="Opaque" }
	Fog { Mode Global}
	ColorMask RGB
	Cull Back Lighting On ZWrite On
	
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
		#pragma multi_compile_fwdbase
		#pragma multi_compile_fwdadd_fullshadows
		#pragma multi_compile CITYOVERLAY_OFF CITYOVERLAY_ON
		#pragma multi_compile DETAIL_MAP_OFF DETAIL_MAP_ON
		#define PI 3.1415926535897932384626
		#define INV_PI (1.0/PI)
		#define TWOPI (2.0*PI) 
		#define INV_2PI (1.0/TWOPI)
	 
		fixed4 _Color;
		sampler2D _MainTex;
		sampler2D _DetailTex;
		sampler2D _DetailVertTex;
		float _DetailScale;
		float _DetailVertScale;
		float _DetailDist;
		float _MinLight;
		
		#ifdef CITYOVERLAY_ON
		sampler2D _DarkOverlayTex;
		sampler2D _DarkOverlayDetailTex;
		float _DarkOverlayDetailScale;
		fixed4 _DarkOverlayDetailOffset;
		#endif
		
		struct appdata_t {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float3 normal : NORMAL;
				float3 tangent : TANGENT;
			};

		struct v2f {
			float4 pos : SV_POSITION;
			float  viewDist : TEXCOORD1;
			float3 objNormal : TEXCOORD2;
			float3 worldNormal : TEXCOORD3;
			float3 sphereNormal : TEXCOORD4;
			float4 color : TEXCOORD5;
			LIGHTING_COORDS(6,7)
		};	
		

		v2f vert (appdata_t v)
		{
			v2f o;
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			
		   float3 vertexPos = mul(_Object2World, v.vertex).xyz;
	   	   o.viewDist = distance(vertexPos,_WorldSpaceCameraPos);
	   	   o.objNormal = normalize(v.normal);
	   	   o.worldNormal = mul( _Object2World, float4( v.normal, 0.0 ) ).xyz;
	   	   o.sphereNormal = -normalize(v.tangent);
	   	   o.color = v.color;
	   	   return o;
	 	}
	 	
		float4 Derivatives( float3 pos )  
		{  
		    float lat = INV_2PI*atan2( pos.y, pos.x );  
		    float lon = INV_PI*acos( pos.z );  
		    float2 latLong = float2( lat, lon );  
		    float latDdx = INV_2PI*length( ddx( pos.xy ) );  
		    float latDdy = INV_2PI*length( ddy( pos.xy ) );  
		    float longDdx = ddx( lon );  
		    float longDdy = ddy( lon );  
		 	
		    return float4( latDdx , longDdx , latDdy, longDdy );  
		} 
	 		
		fixed4 frag (v2f IN) : COLOR
			{
			half4 color;
			float3 sphereNrm = IN.sphereNormal;
		 	float2 uv;
		 	uv.x = .5 + (INV_2PI*atan2(sphereNrm.x, sphereNrm.z));
		 	uv.y = INV_PI*acos(sphereNrm.y);
		 	float4 uvdd = Derivatives(sphereNrm);
		    half4 main = tex2D(_MainTex, uv, uvdd.xy, uvdd.zw);
		    half2 detailnrmzy = sphereNrm.zy*_DetailScale;
		    half2 detailnrmzx = sphereNrm.zx*_DetailScale;
		    half2 detailnrmxy = sphereNrm.xy*_DetailScale;
		    half2 detailvertnrmzy = sphereNrm.zy*_DetailVertScale;
		    half2 detailvertnrmzx = sphereNrm.zx*_DetailVertScale;
		    half2 detailvertnrmxy = sphereNrm.xy*_DetailVertScale;
		    half vertLerp = saturate((32*(saturate(dot(IN.objNormal, -IN.sphereNormal))-.95))+.5);
			half4 detailX = lerp(tex2D (_DetailVertTex, detailvertnrmzy), tex2D (_DetailTex, detailnrmzy), vertLerp);
			half4 detailY = lerp(tex2D (_DetailVertTex, detailvertnrmzx), tex2D (_DetailTex, detailnrmzx), vertLerp);
			half4 detailZ = lerp(tex2D (_DetailVertTex, detailvertnrmxy), tex2D (_DetailTex, detailnrmxy), vertLerp);
			
			#ifdef CITYOVERLAY_ON
			half4 darkoverlay = tex2D(_DarkOverlayTex, uv, uvdd.xy, uvdd.zw);
			half4 darkoverlaydetailX = tex2D (_DarkOverlayDetailTex, sphereNrm.zy*_DarkOverlayDetailScale);
			half4 darkoverlaydetailY = tex2D (_DarkOverlayDetailTex, sphereNrm.zx*_DarkOverlayDetailScale);
			half4 darkoverlaydetailZ = tex2D (_DarkOverlayDetailTex, sphereNrm.xy*_DarkOverlayDetailScale);
			#endif
			
			sphereNrm = abs(sphereNrm);
			half4 detail = lerp(detailZ, detailX, sphereNrm.x);
			detail = lerp(detail, detailY, sphereNrm.y);
			half detailLevel = saturate(2*_DetailDist*IN.viewDist);
			color = main.rgba * lerp(detail.rgba, 1, detailLevel)*IN.color*_Color;
			#ifdef CITYOVERLAY_ON
			detail = lerp(darkoverlaydetailZ, darkoverlaydetailX, sphereNrm.x);
			detail = lerp(detail, darkoverlaydetailY, sphereNrm.y);
			darkoverlay = darkoverlay*detail;
			#endif
			
          	//lighting
			half3 ambientLighting = UNITY_LIGHTMODEL_AMBIENT;
			half3 lightDirection = normalize(_WorldSpaceLightPos0);
			half NdotL = saturate(dot (IN.worldNormal, lightDirection));
	        half diff = (NdotL - 0.01) / 0.99;
			half lightIntensity = saturate(_LightColor0.a * diff * 4);
			half3 light = saturate(ambientLighting + ((_MinLight + _LightColor0.rgb) * lightIntensity));
			color.rgb *= light;
			
			#ifdef CITYOVERLAY_ON
			darkoverlay.a *= 1-saturate(lightIntensity*1.5);
			color = lerp(color, darkoverlay, darkoverlay.a);
			#endif
			color.a = 1;
			
          	return color;
		}
		ENDCG
	
		}
		
	} 
	
}
}
