Shader "Sphere/Planet" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_SpecColor ("Specular tint", Color) = (1,1,1,1)
		_Shininess ("Shininess", Float) = 10
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		_DetailScale ("Detail Scale", Range(0,1000)) = 200
		_DetailDist ("Detail Distance", Range(0,1)) = 0.00875
		_MinLight ("Minimum Light", Range(0,1)) = .5
		_Clarity ("Clarity", Range(0,1)) = .005
	}
	
SubShader {

Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Mode Global}
	AlphaTest Greater 0
	ColorMask RGB
	Cull Back Lighting On ZWrite Off
	
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
		#define PI 3.1415926535897932384626
		#define INV_PI (1.0/PI)
		#define TWOPI (2.0*PI) 
		#define INV_2PI (1.0/TWOPI)
	 
		fixed4 _Color;
		float _Shininess;
		sampler2D _MainTex;
		sampler2D _DetailTex;
		float _DetailScale;
		float _DetailDist;
		float _MinLight;
		float _Clarity;
		sampler2D _CameraDepthTexture;
		
		struct appdata_t {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 color : COLOR;
				float3 tangent : TANGENT;
			};

		struct v2f {
			float4 pos : SV_POSITION;
			float  viewDist : TEXCOORD0;
			float3 viewDir : TEXCOORD1;
			float3 worldNormal : TEXCOORD2;
			LIGHTING_COORDS(3,4)
			float3 sphereNormal : TEXCOORD5;
			float4 color : TEXCOORD6;
			float3 scrPos : TEXCOORD7;
		};	
		

		v2f vert (appdata_t v)
		{
			v2f o;
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			
		   float3 vertexPos = mul(_Object2World, v.vertex).xyz;
	   	   o.viewDist = distance(vertexPos,_WorldSpaceCameraPos);

	   	   o.worldNormal = normalize(mul( _Object2World, float4( v.normal, 0.0 ) ).xyz);
	   	   o.sphereNormal = -normalize(v.tangent);
		   o.viewDir = normalize(_WorldSpaceCameraPos.xyz - mul(_Object2World, v.vertex).xyz);
    	   o.color = v.color;
    	   o.scrPos=ComputeScreenPos(o.pos);
    	   COMPUTE_EYEDEPTH(o.scrPos.z);
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
		    half2 detailnrmzy = sphereNrm.zy*_DetailScale;
		    half2 detailnrmzx = sphereNrm.zx*_DetailScale;
		    half2 detailnrmxy = sphereNrm.xy*_DetailScale;
			half4 detailX = tex2D (_DetailTex, detailnrmzy);
			half4 detailY = tex2D (_DetailTex, detailnrmzx);
			half4 detailZ = tex2D (_DetailTex, detailnrmxy);
			
			sphereNrm = abs(sphereNrm);
			half4 detail = lerp(detailZ, detailX, sphereNrm.x);
			detail = lerp(detail, detailY, sphereNrm.y);
			half detailLevel = saturate(2*_DetailDist*IN.viewDist);
			color = main.rgba * lerp(detail.rgba, 1, detailLevel);
			
            color *= _Color * IN.color;
            
          	//lighting
            half3 ambientLighting = UNITY_LIGHTMODEL_AMBIENT;
			half3 lightDirection = normalize(_WorldSpaceLightPos0);
			half3 normalDir = IN.worldNormal;
			half NdotL = saturate(dot (normalDir, lightDirection));
	        half diff = (NdotL - 0.01) / 0.99;
	        fixed atten = LIGHT_ATTENUATION(IN); 
			half lightIntensity = saturate(_LightColor0.a * diff * 4 * atten);
			half3 light = saturate(ambientLighting + ((_MinLight + _LightColor0.rgb) * lightIntensity));
			
            float3 specularReflection = saturate(floor(1+NdotL));
            
            specularReflection *= atten * float3(_LightColor0) 
                  * float3(_SpecColor) * pow(saturate( dot(
                  reflect(-lightDirection, normalDir), 
                  IN.viewDir)), _Shininess);
 
            light += main.a*specularReflection;
			
			float depth = LinearEyeDepth(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(IN.scrPos)).r)-IN.scrPos.z;
			
			color.rgb *= light;
			
			color.a = saturate(_Clarity*depth);
			
          	return color;
		}
		ENDCG
	
		}
		
	} 
	
	FallBack "VertexLit"
}