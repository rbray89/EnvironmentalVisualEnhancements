Shader "EVE/Planet" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_SpecColor ("Specular tint", Color) = (1,1,1,1)
		_Shininess ("Shininess", Float) = 0.078125
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_midTex ("Detail (RGB)", 2D) = "white" {}
		_steepTex ("Detail for Vertical Surfaces (RGB)", 2D) = "white" {}
		_DetailScale ("Detail Scale", Range(0,1000)) = 200
		_DetailOffset ("Detail Offset", Vector) = (.5,.5,0,0)
		_DetailVertScale ("Detail Scale", Range(0,1000)) = 200
		_DetailDist ("Detail Distance", Range(0,1)) = 0.00875
		_MinLight ("Minimum Light", Range(0,1)) = .5
		_Albedo ("Albedo Index", Range(0,5)) = 1.2
		_CityOverlayTex ("Overlay (RGB)", 2D) = "white" {}
		_CityOverlayDetailScale ("Overlay Detail Scale", Range(0,1000)) = 80
		_CityDarkOverlayDetailTex ("Overlay Detail (RGB) (A)", 2D) = "white" {}
		_CityLightOverlayDetailTex ("Overlay Detail (RGB) (A)", 2D) = "white" {}
	}
	
SubShader {

Tags { "Queue"="Geometry" "RenderType"="Opaque" }
	Fog { Mode Global}
	ColorMask RGB
	Cull Back Lighting On ZWrite On
	
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
		#pragma multi_compile CITYOVERLAY_OFF CITYOVERLAY_ON
		#pragma multi_compile DETAIL_MAP_OFF DETAIL_MAP_ON
		
	 
		fixed4 _Color;
		float _Shininess;
		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _midTex;
		sampler2D _steepTex;
		float _DetailScale;
		fixed4 _DetailOffset;
		float _DetailVertScale;
		float _DetailDist;
		float _MinLight;
		float _Albedo;
		
		#ifdef CITYOVERLAY_ON
		sampler2D _CityOverlayTex;
		float _CityOverlayDetailScale;
		sampler2D _CityDarkOverlayDetailTex;
		sampler2D _CityLightOverlayDetailTex;
		#endif
		
		struct appdata_t {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
			};

		struct v2f {
			float4 pos : SV_POSITION;
			float  viewDist : TEXCOORD0;
			float3 viewDirT : TEXCOORD1;
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
		   
		   o.worldNormal = normalize(mul( _Object2World, float4( v.normal, 0.0 ) ).xyz);

    		TANGENT_SPACE_ROTATION; 
        	o.lightDirT = normalize(mul(rotation, ObjSpaceLightDir(v.vertex)));
        	o.viewDirT = normalize(mul(rotation, ObjSpaceViewDir(v.vertex)));
    		TRANSFER_VERTEX_TO_FRAGMENT(o);
    
	   	   return o;
	 	}
	 	
	 		
		fixed4 frag (v2f IN) : COLOR
		{
			half4 color;
			float3 sphereNrm = IN.sphereNormal;
		 	half4 main = GetSphereMap(_MainTex, IN.sphereNormal);
		    half3 normT = UnpackNormal(GetSphereMap(_BumpMap, IN.sphereNormal));
		    
		    half4 detail = GetShereDetailMap(_midTex, IN.sphereNormal, _DetailScale); 
			
			#ifdef CITYOVERLAY_ON
			half4 cityoverlay = GetSphereMap(_CityOverlayTex, IN.sphereNormal);
			half4 citydarkoverlaydetail = GetShereDetailMap(_CityDarkOverlayDetailTex, IN.sphereNormal, _CityOverlayDetailScale);
			half4 citylightoverlaydetail = GetShereDetailMap(_CityLightOverlayDetailTex, IN.sphereNormal, _CityOverlayDetailScale); 
			#endif
			
			half detailLevel = saturate(2*_DetailDist*IN.viewDist);
			color = main.rgba * lerp(detail.rgba, 1, detailLevel);
			#ifdef CITYOVERLAY_ON
			cityoverlay.a *= saturate(1-main.a);
			half4 citydarkoverlay = cityoverlay*citydarkoverlaydetail;
			half4 citylightoverlay = cityoverlay*citylightoverlaydetail;
			color.rgb = lerp(color.rgb, citylightoverlay.rgb, citylightoverlay.a);
			#endif
			
            color *= _Color;
            
          	//lighting
          	
            //half4 light = GetLighting( normT, IN.lightDirT, LIGHT_ATTENUATION(IN), 0);
            /*
            float h = normalize(IN.lightDirT+IN.viewDirT);
            float nh = saturate(dot (normT, h));

            float spec = pow(nh, _Shininess * 128.0)*main.a;
            float3 specularReflection = LIGHT_ATTENUATION(IN) * 2 * _LightColor0.rgb
                  * _SpecColor.rgb * spec;
 			
 			half NdotL = dot (IN.worldNormal, normalize(_WorldSpaceLightPos0));
			half termlerp = saturate(10*-NdotL);
			half terminator = lerp(1,saturate(floor(1.01+NdotL)), termlerp);
 			light.rgb *= lerp(terminator, 1, main.a);
            light.rgb += specularReflection;
			
			color.rgb += _Albedo*light.rgb;
			color.rgb *= light.rgb;
			*/
			
			half4 specColor = _SpecColor;
			specColor.a = main.a;
			color = SpecularColorLight( IN.lightDirT, IN.viewDirT, normT, color, specColor, _Shininess * 128, LIGHT_ATTENUATION(IN) );
			color *= lerp(Terminator( normalize(_WorldSpaceLightPos0), IN.worldNormal), 1, main.a);
			
			
			#ifdef CITYOVERLAY_ON
			//half lightIntensity = saturate(_LightColor0.a * (NdotL - 0.01) / 0.99 * 4 * atten);
			citydarkoverlay.a *= 1-saturate(color.a);
			color.rgb = lerp(color.rgb, citydarkoverlay.rgb, citydarkoverlay.a);
			#endif
			
          	return color;
		}
		ENDCG
	
		}
		
	} 
	
	FallBack "VertexLit"
}