Shader "Sphere/Ocean" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_UnderColor ("Color Tint", Color) = (1,1,1,1)
		_SpecColor ("Specular tint", Color) = (1,1,1,1)
		_Shininess ("Shininess", Float) = 10
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_MainTexHandoverDist ("Handover Distance", Float) = 1
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		_DetailScale ("Detail Scale", Range(0,1000)) = 200
		_DetailDist ("Detail Distance", Range(0,1)) = 0.00875
		_MinLight ("Minimum Light", Range(0,1)) = .5
		_Clarity ("Clarity", Range(0,1)) = .005
		_LightPower ("LightPower", Float) = 1.75
		_Reflectivity ("Reflectivity", Float) = .08
	}
	
SubShader {

Tags { "Queue"="AlphaTest" "RenderType"="Transparent"}
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Mode Global}
	AlphaTest Greater 0
	ColorMask RGB
	Cull Back Lighting On ZWrite On
	
	
	//Sub-surface depth
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
	 
		fixed4 _UnderColor;
		float _Shininess;
		sampler2D _MainTex;
		sampler2D _DetailTex;
		float _DetailScale;
		float _DetailDist;
		float _MinLight;
		float _Clarity;
		float _LightPower;
		float _Reflectivity;
		sampler2D _CameraDepthTexture;
		float4x4 _CameraToWorld;

		struct appdata_t {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float3 tangent : TANGENT;
			};

		struct v2f {
			float4 pos : SV_POSITION;
			float  viewDist : TEXCOORD0;
			float3 viewDir : TEXCOORD1;
			float3 worldNormal : TEXCOORD2;
			LIGHTING_COORDS(3,4)
			float3 sphereNormal : TEXCOORD5;
			float4 scrPos : TEXCOORD6;
		};	
		

		v2f vert (appdata_t v)
		{
			v2f o;
			float3 vertexPos = mul(_Object2World, v.vertex).xyz;
			float viewDist = distance(vertexPos,_WorldSpaceCameraPos);
			o.viewDist = viewDist;
			float satDepth = 1-saturate(.002*(viewDist-800));

			float4 vertex = v.vertex - satDepth*(400*float4(v.normal,0));
			o.pos = mul(UNITY_MATRIX_MVP, vertex);

			vertexPos = mul(_Object2World, vertex).xyz;

			o.worldNormal = normalize(mul( _Object2World, float4( v.normal, 0.0 ) ).xyz);
			o.viewDir = normalize(_WorldSpaceCameraPos.xyz - mul(_Object2World, vertex).xyz);
			o.scrPos=ComputeScreenPos(o.pos);
			COMPUTE_EYEDEPTH(o.scrPos.z);
			TRANSFER_VERTEX_TO_FRAGMENT(o);

			return o;
	 	}
	 	
	 		
		fixed4 frag (v2f IN) : COLOR
		{
			half4 color;
            color = _UnderColor;
            
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
 
            light += color.a*specularReflection;
			
			
			color.a = 1;
			//depth opacity
			float depth = UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(IN.scrPos)));
			float satDepth = saturate(.001*(IN.viewDist-1800));
			depth = LinearEyeDepth(depth);
			
			depth -= IN.scrPos.z;
    		depth = saturate(_Clarity*depth);
    		depth = max(.12, depth);
			color.a *= pow(lerp(depth, 0, satDepth),2);
			color.rgb *= saturate((_LightPower*light)-color.a);
			color.rgb += _Reflectivity*light;
			color.rgb *= light;
          	return color;
		}
		ENDCG
	
		}
		
		//surface
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
		float _MainTexHandoverDist;
		sampler2D _DetailTex;
		float _DetailScale;
		float _DetailDist;
		float _MinLight;
		float _Clarity;
		sampler2D _CameraDepthTexture;
		float4x4 _CameraToWorld;
		float _LightPower;
		float _Reflectivity;
		
		struct appdata_t {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float3 tangent : TANGENT;
				float4 texcoord : TEXCOORD0;
			};

		struct v2f {
			float4 pos : SV_POSITION;
			float  viewDist : TEXCOORD0;
			float3 viewDir : TEXCOORD1;
			float3 worldNormal : TEXCOORD2;
			LIGHTING_COORDS(3,4)
			float3 sphereNormal : TEXCOORD5;
			float4 scrPos : TEXCOORD6;
		};	
		

		v2f vert (appdata_t v)
		{
			v2f o;
			half c = .25*_Time.z + frac( v.texcoord.xy ).x;
		    float4 vertex = v.vertex + (1.5*(1+cos(c))*float4(v.normal,0));
			
			o.pos = mul(UNITY_MATRIX_MVP, vertex);
			
			float3 vertexPos = mul(_Object2World, vertex).xyz;
			o.viewDist = distance(vertexPos,_WorldSpaceCameraPos);

			o.worldNormal = normalize(mul( _Object2World, float4( v.normal, 0.0 ) ).xyz);
			o.sphereNormal = -normalize(v.tangent);
			o.viewDir = normalize(_WorldSpaceCameraPos.xyz - mul(_Object2World, vertex).xyz);
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
			color = lerp(detail.rgba, 1, detailLevel);
			color = lerp(color, main, saturate(pow(_MainTexHandoverDist*IN.viewDist,3)));
            color *= _Color;
            
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
			
			
			color.a = 1;
			//depth opacity
			float depth = UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(IN.scrPos)));
			float satDepth = saturate(.002*(IN.viewDist-600));
			depth = LinearEyeDepth(depth);
			
			depth -= IN.scrPos.z;
    		depth = saturate(_Clarity*depth);
    		depth = max(.12, depth);
    		float refrac = .67;//.65-(.55*dot(IN.viewDir, IN.worldNormal));
			color.a *= pow(lerp(refrac, depth, satDepth),2);
			color.a = lerp(color.a, main.a, saturate(pow(_MainTexHandoverDist*IN.viewDist,3)));
			color.rgb *= saturate((_LightPower*light)-color.a);
			color.rgb += _Reflectivity*light;
			color.rgb *= light;
			
          	return color;
		}
		ENDCG
	
		}
		
		// Pass to render object as a shadow collector
		Pass {
			Name "ShadowCollector"
			Tags { "LightMode" = "ShadowCollector" }
			
			Fog {Mode Off}
			ZWrite On ZTest LEqual

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma multi_compile_shadowcollector

			#define SHADOW_COLLECTOR_PASS
			#include "UnityCG.cginc"

			struct v2f {
				V2F_SHADOW_COLLECTOR;
			};


			v2f vert (appdata_base v)
			{
				v2f o;
				TRANSFER_SHADOW_COLLECTOR(o)
				return o;
			}

			uniform fixed4 _Color;

			fixed4 frag (v2f i) : COLOR
			{
				SHADOW_COLLECTOR_FRAGMENT(i)
			}
			ENDCG

		}
		
		Pass {
            Tags {"LightMode" = "ForwardAdd"} 
            Blend One One                                      
            CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #pragma multi_compile_fwdadd 
                
                #include "UnityCG.cginc"
                #include "AutoLight.cginc"
                
                struct appdata_t {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float3 normal : NORMAL;
				float3 tangent : TANGENT;
				};
                
                struct v2f
                {
                    float4  pos         : SV_POSITION;
                    float2  uv          : TEXCOORD0;
                    float3  lightDir    : TEXCOORD2;
                    float3 normal		: TEXCOORD1;
                    LIGHTING_COORDS(3,4)
                    float4 color : TEXCOORD5;
                };
 
                v2f vert (appdata_t v)
                {
                    v2f o;
                    
                    o.pos = mul( UNITY_MATRIX_MVP, v.vertex);
                   	
					o.lightDir = ObjSpaceLightDir(v.vertex);
					o.color = v.color;
					o.normal =  v.normal;
                    TRANSFER_VERTEX_TO_FRAGMENT(o);
                    return o;
                }
 
                fixed4 _Color;
 
                fixed4 _LightColor0;
 
                fixed4 frag(v2f IN) : COLOR
                {
                    IN.lightDir = normalize(IN.lightDir);
                    fixed atten = LIGHT_ATTENUATION(IN);
					fixed3 normal = IN.normal;                    
                    fixed diff = saturate(dot(normal, IN.lightDir));
                    
                    fixed4 c;
                    c.rgb = (IN.color.rgb * _LightColor0.rgb * diff) * (atten * 2);
                    c.a = IN.color.a;
                    return c;
                }
            ENDCG
        }
		
	} 

}