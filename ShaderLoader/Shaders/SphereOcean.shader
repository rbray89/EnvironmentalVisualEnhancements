Shader "EVE/Ocean" {
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

Tags { "Queue"="AlphaTest" "RenderType"="TransparentCutout"}
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Mode Global}
	AlphaTest Greater 0
	ColorMask RGB
	Cull Back Lighting On
		
		//surface
		Pass {
		Lighting On
		ZWrite On
		Tags { "LightMode"="ForwardBase"}
		
		CGPROGRAM
		#include "EVEUtils.cginc"
		#include "UnityCG.cginc"
		#include "AutoLight.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma exclude_renderers d3d11
		#pragma glsl
		#pragma vertex vert
		#pragma fragment frag
		#define MAG_ONE 1.4142135623730950488016887242097
		#pragma fragmentoption ARB_precision_hint_fastest
		#pragma multi_compile_fwdbase
		#pragma multi_compile_fwdadd_fullshadows
		
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
				float4 texcoord : TEXCOORD0;
			    float4 texcoord2 : TEXCOORD1;
			};

		struct v2f {
			float4 pos : SV_POSITION;
			float  viewDist : TEXCOORD0;
			float3 viewDir : TEXCOORD1;
			float3 worldNormal : TEXCOORD2;
			LIGHTING_COORDS(3,4)
			float3 sphereNormal : TEXCOORD5;
		};	
		

		v2f vert (appdata_t v)
		{
			v2f o;
			//half c = .25*_Time.z + frac( v.texcoord.xy ).x;
			//+ (1.5*(1+cos(c))*float4(v.normal,0));
		    float4 vertex = v.vertex;
			
			o.pos = mul(UNITY_MATRIX_MVP, vertex).xyzw;
			
			float3 vertexPos = mul(_Object2World, vertex).xyz;
			o.viewDist = distance(vertexPos,_WorldSpaceCameraPos);

			o.worldNormal = normalize(mul( _Object2World, float4( v.normal, 0.0 ) ).xyz);
			o.sphereNormal = -normalize(half4(v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz;
			o.viewDir = normalize(_WorldSpaceCameraPos.xyz - mul(_Object2World, vertex).xyz);

			TRANSFER_VERTEX_TO_FRAGMENT(o);

			return o;
	 	}
	 		 		
		fixed4 frag (v2f IN) : COLOR
		{
			half4 color;
			float3 sphereNrm = IN.sphereNormal;
		 	
		    half4 main = GetSphereMap(_MainTex, sphereNrm);
			half4 detail = GetShereDetailMap(_DetailTex, sphereNrm, _DetailScale);
			
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

    		float refrac = .67;//.65-(.55*dot(IN.viewDir, IN.worldNormal));
			color.a *= pow(refrac,2);
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
                   	
					o.lightDir = ObjSpaceLightDir(v.vertex).xyz;
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