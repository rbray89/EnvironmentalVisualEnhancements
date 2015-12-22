Shader "EVE/TerrainCityLight" {
	Properties {
	_Color ("Color Tint", Color) = (1,1,1,1)
	_SpecularColor ("Specular tint", Color) = (1,1,1,1)
	_CityOverlayTex ("Overlay (RGBA)", 2D) = "white" {}
	_CityOverlayDetailScale ("Overlay Detail Scale", Range(0,1000)) = 80
	_CityDarkOverlayDetailTex ("Overlay Detail (RGB) (A)", 2D) = "white" {}
	_CityLightOverlayDetailTex ("Overlay Detail (RGB) (A)", 2D) = "white" {}
	_PlanetOpacity ("PlanetOpacity", Float) = 1
	_PlanetOrigin("Sphere Center", Vector) = (0,0,0,1)
	}
	Category {
		Lighting On
		ZWrite Off
		Cull Back
		Offset 0, 0
		Blend SrcAlpha OneMinusSrcAlpha
		Tags {
			"Queue"="Geometry+2"
			"RenderMode"="Transparent"
			"IgnoreProjector"="True"
		}
		SubShader {
			Pass {

				Lighting On
				Tags { "LightMode"="ForwardBase"}

				CGPROGRAM

				#include "EVEUtils.cginc"
				#pragma target 3.0
				#pragma glsl
				#pragma vertex vert
				#pragma fragment frag
				#define MAG_ONE 1.4142135623730950488016887242097
				#pragma fragmentoption ARB_precision_hint_fastest
				#pragma multi_compile_fwdbase
#pragma multi_compile CityOverlayTex CUBE_CityOverlayTex CUBE_RGB2_CityOverlayTex
#pragma multi_compile ALPHAMAP_NONE_CityOverlayTex ALPHAMAP_R_CityOverlayTex ALPHAMAP_G_CityOverlayTex ALPHAMAP_B_CityOverlayTex ALPHAMAP_A_CityOverlayTex

				fixed4 _Color;
				float _SpecularPower;
				half4 _SpecularColor;
				float _DetailDist;

				float _PlanetOpacity;
				float3 _PlanetOrigin;

#ifdef CUBE_CityOverlayTex
				uniform samplerCUBE cube_CityOverlayTex;
#elif defined (CUBE_RGB2_CityOverlayTex)
				sampler2D cube_CityOverlayTexPOS;
				sampler2D cube_CityOverlayTexNEG;
#else
				sampler2D _CityOverlayTex;
#endif

				float _CityOverlayDetailScale;
				sampler2D _CityDarkOverlayDetailTex;
				sampler2D _CityLightOverlayDetailTex;

				struct appdata_t {
					float4 vertex : POSITION;
					fixed4 color : COLOR;
					float3 normal : NORMAL;
					float4 texcoord : TEXCOORD0;
					float4 texcoord2 : TEXCOORD1;
					float3 tangent : TANGENT;
				};

				struct v2f {
					float4 pos : SV_POSITION;
					float4 color : TEXCOORD0;
					float4 objnormal : TEXCOORD1;
					LIGHTING_COORDS(2,3)
					float3 worldNormal : TEXCOORD4;
					float3 sphereNormal : TEXCOORD5;
					float terminator : TEXCOORD6;
					float3 viewDir : TEXCOORD7;
				};

				v2f vert (appdata_t v)
				{
					v2f o;
					o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

					float3 vertexPos = mul(_Object2World, v.vertex).xyz;
					o.objnormal.w = distance(vertexPos,_WorldSpaceCameraPos);
					o.viewDir = normalize(vertexPos - _WorldSpaceCameraPos);
					o.worldNormal = normalize(vertexPos - _PlanetOrigin);
					o.sphereNormal = -(float4(v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz;
					o.color = v.color;
					o.objnormal.xyz = v.normal;

					float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
					half NdotL = dot (o.sphereNormal, lightDirection);
					half termlerp = saturate(10*-NdotL);
					o.terminator = lerp(1,saturate(floor(1.01+NdotL)), termlerp);

					TRANSFER_VERTEX_TO_FRAGMENT(o);

					return o;
				}

				fixed4 frag (v2f IN) : COLOR
				{
					half4 color;


#ifdef CUBE_CityOverlayTex
					half4 cityoverlay = GetSphereMapCube(cube_CityOverlayTex, IN.sphereNormal);
#elif defined (CUBE_RGB2_CityOverlayTex)
					half4 cityoverlay = GetSphereMapCube(cube_CityOverlayTexPOS, cube_CityOverlayTexNEG, IN.sphereNormal);
#else
					half4 cityoverlay = GetSphereMap(_CityOverlayTex, IN.sphereNormal);
#endif


#ifdef ALPHAMAP_R_CityOverlayTex
					cityoverlay = half4(1, 1, 1, cityoverlay.r);
#elif ALPHAMAP_G_CityOverlayTex
					cityoverlay = half4(1, 1, 1, cityoverlay.g);
#elif ALPHAMAP_B_CityOverlayTex
					cityoverlay = half4(1, 1, 1, cityoverlay.b);
#elif ALPHAMAP_A_CityOverlayTex
					cityoverlay = half4(1, 1, 1, cityoverlay.a);
#endif

					half4 citydarkoverlaydetail = GetSphereDetailMap(_CityDarkOverlayDetailTex, IN.sphereNormal, _CityOverlayDetailScale);
					half4 citylightoverlaydetail = GetSphereDetailMap(_CityLightOverlayDetailTex, IN.sphereNormal, _CityOverlayDetailScale);


					cityoverlay.a *= 1-step(IN.color.a, 0);
					//cityoverlay.a = 1-step(cityoverlay.a, 0);
					citydarkoverlaydetail.a *= cityoverlay.a;
					citylightoverlaydetail.a *= cityoverlay.a;
					color.rgb = lerp( half3(0,0,0), citylightoverlaydetail.rgb, citylightoverlaydetail.a);
					color.a = 0;

					half4 specColor = _SpecularColor;

					//world
					color = SpecularColorLight( _WorldSpaceLightPos0, IN.viewDir, IN.worldNormal, color, specColor, _SpecularPower, LIGHT_ATTENUATION(IN) );
					color *= Terminator( normalize(_WorldSpaceLightPos0), IN.worldNormal);


					//lightIntensity = saturate(_LightColor0.a * (SNdotL - 0.01) / 0.99 * 4 * atten);
					citydarkoverlaydetail.a *= 1-saturate(color.a);
					color = lerp(citylightoverlaydetail, citydarkoverlaydetail, citydarkoverlaydetail.a);
					color.a *= _PlanetOpacity;

					return color;
				}
				ENDCG

			}
		}
	}
}