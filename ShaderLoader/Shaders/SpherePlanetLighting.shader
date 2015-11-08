Shader "EVE/PlanetLight" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
	}
	Category {
	   Lighting On
	   ZWrite Off
	   Cull Back
	   Blend SrcColor SrcAlpha, One Zero
	   Tags {
	   "Queue"="Transparent-5"
	   "RenderMode"="Transparent"
	   "IgnoreProjector"="True"
	   }
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
		
	 
		fixed4 _Color;
		float _SpecularPower;
		half4 _SpecularColor;
		sampler2D _MainTex;
		sampler2D _BumpMap;
		float _DetailDist;
		
		sampler2D _CityOverlayTex;
		float _CityOverlayDetailScale;
		sampler2D _CityDarkOverlayDetailTex;
		sampler2D _CityLightOverlayDetailTex;
		
		struct appdata_t {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
			};

		struct v2f {
			float4 pos : SV_POSITION;
			float  viewDist : TEXCOORD0;
			float3 viewDir : TEXCOORD1;
			float3 sphereNormal : TEXCOORD2;
			float3 worldNormal : TEXCOORD3;
    		float3 lightDirT : TEXCOORD5;
    		LIGHTING_COORDS(6,7)
		};	
		

		v2f vert (appdata_t v)
		{
			v2f o;
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			
		   float3 vertexPos = mul(_Object2World, v.vertex).xyz;
	   	   o.viewDist = distance(vertexPos,_WorldSpaceCameraPos);

		   float3 origin = mul(_Object2World, float4(0,0,0,1)).xyz;
	   	   
	   	   o.sphereNormal = -normalize(v.vertex);
		   
		   o.worldNormal = normalize(vertexPos-origin);

        	o.viewDir = normalize(vertexPos - _WorldSpaceCameraPos);
    
	   	   return o;
	 	}
	 	
	 		
		fixed4 frag (v2f IN) : COLOR
		{
			half4 color = _Color;

		    color = SpecularColorLight( _WorldSpaceLightPos0, IN.viewDir, IN.worldNormal, color, 0, 0, LIGHT_ATTENUATION(IN) );
			color *= Terminator( normalize(_WorldSpaceLightPos0), IN.worldNormal);
			
			color.rgb *= color.a;
          	return color;
		}
		ENDCG
	
		}
        }
    }
}