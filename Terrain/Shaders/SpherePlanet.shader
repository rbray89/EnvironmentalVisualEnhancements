Shader "Sphere/Planet" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_SpecColor ("Specular tint", Color) = (1,1,1,1)
		_Shininess ("Shininess", Float) = 10
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		_DetailVertTex ("Detail for Vertical Surfaces (RGB)", 2D) = "white" {}
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
		float _Shininess;
		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _DetailTex;
		sampler2D _DetailVertTex;
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
			float3 viewDir : TEXCOORD1;
			float3 sphereNormal : TEXCOORD2;
    		float3 lightDirection : TEXCOORD5;
    		LIGHTING_COORDS(6,7)
    		float terminator : TEXCOORD8;
		};	
		

		v2f vert (appdata_t v)
		{
			v2f o;
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			
		   float3 vertexPos = mul(_Object2World, v.vertex).xyz;
	   	   o.viewDist = distance(vertexPos,_WorldSpaceCameraPos);

		   float3 origin = mul(_Object2World, float4(0,0,0,1)).xyz;
	   	   
	   	   o.sphereNormal = -normalize(v.vertex);
		   
		   half3 worldNormal = normalize(mul( _Object2World, float4( v.normal, 0.0 ) ).xyz);

    		half NdotL = dot (worldNormal, normalize(_WorldSpaceLightPos0));
		   half termlerp = saturate(10*-NdotL);
    	   o.terminator = lerp(1,saturate(floor(1.01+NdotL)), termlerp);
    		
    		TANGENT_SPACE_ROTATION; 
        	o.lightDirection = normalize(mul(rotation, ObjSpaceLightDir(v.vertex)));
        	o.viewDir = normalize(mul(rotation, ObjSpaceViewDir(v.vertex)));
    		TRANSFER_VERTEX_TO_FRAGMENT(o);
    
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
		    half3 norm = UnpackNormal(tex2D(_BumpMap, uv, uvdd.xy, uvdd.zw));
		    
		    sphereNrm = abs(sphereNrm);
			half zxlerp = saturate(floor(1+sphereNrm.x-sphereNrm.z));
			half3 detailCoords = lerp(sphereNrm.zxy, sphereNrm.xyz, zxlerp);
			half nylerp = saturate(floor(1+sphereNrm.y-(lerp(sphereNrm.z, sphereNrm.x, zxlerp))));		
			detailCoords = lerp(detailCoords, sphereNrm.yxz, nylerp);
			half4 detail = tex2D (_DetailTex, ((.5*detailCoords.zy)/(abs(detailCoords.x)) + _DetailOffset.xy) *_DetailScale, uvdd.xy, uvdd.zw);	
			
			#ifdef CITYOVERLAY_ON
			half4 cityoverlay = tex2D(_CityOverlayTex, uv, uvdd.xy, uvdd.zw);
			half4 citydarkoverlaydetail = tex2D (_CityDarkOverlayDetailTex, ((.5*detailCoords.zy)/(abs(detailCoords.x)) + _DetailOffset.xy) *_CityOverlayDetailScale, uvdd.xy, uvdd.zw);
			half4 citylightoverlaydetail = tex2D (_CityLightOverlayDetailTex, ((.5*detailCoords.zy)/(abs(detailCoords.x)) + _DetailOffset.xy) *_CityOverlayDetailScale, uvdd.xy, uvdd.zw);
			#endif
			
			half detailLevel = saturate(2*_DetailDist*IN.viewDist);
			color = main.rgba * lerp(detail.rgba, 1, detailLevel);
			#ifdef CITYOVERLAY_ON
			cityoverlay.a *= saturate(1-main.a);
			half4 citydarkoverlay = cityoverlay*citydarkoverlaydetail;
			half4 citylightoverlay = cityoverlay*citylightoverlaydetail;
			color = lerp(color, citylightoverlay, citylightoverlay.a);
			#endif
			
            color *= _Color;
            
          	//lighting
          	
            half3 ambientLighting = UNITY_LIGHTMODEL_AMBIENT;
			half NdotL = dot (norm, IN.lightDirection);
	        fixed atten = LIGHT_ATTENUATION(IN); 
			half lightIntensity = saturate(_LightColor0.a * NdotL * 2 * atten);
			half3 light = saturate(ambientLighting + ((_MinLight + _LightColor0.rgb) * lightIntensity));
			
            float3 specularReflection = atten * _LightColor0.rgb
                  * _SpecColor.rgb * pow(max(0.0, dot(
                  reflect(-IN.lightDirection, norm), 
                  IN.viewDir)), _Shininess);
 			
 			light *= lerp(IN.terminator, 1, main.a);
            light += main.a*specularReflection;
			
			color.rgb += _Albedo*light;
			color.rgb *= light;
			
			#ifdef CITYOVERLAY_ON
			lightIntensity = saturate(_LightColor0.a * (NdotL - 0.01) / 0.99 * 4 * atten);
			citydarkoverlay.a *= 1-saturate(lightIntensity);
			color = lerp(color, citydarkoverlay, citydarkoverlay.a);
			#endif
			color.a = 1;
			
          	return color;
		}
		ENDCG
	
		}
		
	} 
	
	FallBack "VertexLit"
}