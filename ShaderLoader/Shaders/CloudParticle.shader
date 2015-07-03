Shader "EVE/CloudParticle" {
Properties {
	_TopTex ("Particle Texture", 2D) = "white" {}
	_LeftTex ("Particle Texture", 2D) = "white" {}
	_FrontTex ("Particle Texture", 2D) = "white" {}
	_MainTex ("Main (RGB)", 2D) = "white" {}
	_DetailTex ("Detail (RGB)", 2D) = "white" {}
	_DetailScale ("Detail Scale", Range(0,1000)) = 100
	_DistFade ("Distance Fade Near", Range(0,1)) = 1.0
	_DistFadeVert ("Distance Fade Vertical", Range(0,1)) = 0.00004
	_LightScatter ("Light Scatter", Range(0,1)) = 0.55 
	_MinLight ("Minimum Light", Range(0,1)) = .5
	_Color ("Color Tint", Color) = (1,1,1,1)
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
			
			
			
			sampler2D _TopTex;
			sampler2D _LeftTex;
			sampler2D _FrontTex;
			sampler2D _MainTex;
			sampler2D _DetailTex;
			float _DetailScale;
			fixed4 _Color;
			float _DistFade;
			float _DistFadeVert;
			float _LightScatter;
			float _MinLight;
			float _InvFade;
			
			sampler2D _CameraDepthTexture;
			
			
			
			struct appdata_t {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 pos : SV_POSITION;
				fixed4 color : COLOR;
				float3 viewDir : TEXCOORD0;
				float2 texcoordZY : TEXCOORD1;
				float2 texcoordXZ : TEXCOORD2;
				float2 texcoordXY : TEXCOORD3;
				float3 camPos : TEXCOORD4;
				half3 baseLight : TEXCOORD5;
				LIGHTING_COORDS(6,7)
				float4 projPos : TEXCOORD8;
			};
			
			
			v2f vert (appdata_t v)
			{
				float4 mvCenter = mul(UNITY_MATRIX_MV, float4(0, 0, 0, v.vertex.w));
	              
				v2f o;
				
				o.pos = mul(UNITY_MATRIX_P, 
	              mvCenter
	              + float4(v.vertex.x, v.vertex.y, v.vertex.z,v.vertex.w));
				
				float3 viewDir = normalize(UNITY_MATRIX_MV[2].xyz);
				o.viewDir = abs(viewDir);
				
				o.camPos = normalize(_WorldSpaceCameraPos.xyz - mul(_Object2World, float4(0, 0, 0, v.vertex.w)).xyz);

				float2 texcoodOffsetxy = ((2*v.texcoord)- 1);
				float4 texcoordOffset = float4(texcoodOffsetxy.x, texcoodOffsetxy.y, 0, v.vertex.w);
				
				float4 ZYv = texcoordOffset.zyxw;
				float4 XZv = texcoordOffset.xzyw;
				float4 XYv = texcoordOffset.xyzw;
				
				ZYv.z*=sign(-viewDir.x);
				XZv.x*=sign(-viewDir.y);
				XYv.x*=sign(viewDir.z);
				
				ZYv.x += sign(-viewDir.x)*sign(ZYv.z)*(viewDir.z);
				XZv.y += sign(-viewDir.y)*sign(XZv.x)*(viewDir.x);
				XYv.z += sign(-viewDir.z)*sign(XYv.x)*(viewDir.x);
				
				ZYv.x += sign(-viewDir.x)*sign(ZYv.y)*(viewDir.y);
				XZv.y += sign(-viewDir.y)*sign(XZv.z)*(viewDir.z);
				XYv.z += sign(-viewDir.z)*sign(XYv.y)*(viewDir.y);
				
				float2 ZY = mul(UNITY_MATRIX_MV, ZYv).xy - mvCenter.xy;
				float2 XZ = mul(UNITY_MATRIX_MV, XZv).xy - mvCenter.xy;
				float2 XY = mul(UNITY_MATRIX_MV, XYv).xy - mvCenter.xy;	
																			
				o.texcoordZY = half2(.5 ,.5) + .6*(ZY);
				o.texcoordXZ = half2(.5 ,.5) + .6*(XZ);
				o.texcoordXY = half2(.5 ,.5) + .6*(XY);
				
				float4 origin = mul(_Object2World, float4(0,0,0,1));
				
				float3 worldNormal = normalize(mul( _Object2World, float4( v.normal, 0.0 ) ).xyz);
				half3 ambientLighting = UNITY_LIGHTMODEL_AMBIENT;
				half3 lightDirection = normalize(_WorldSpaceLightPos0);
 				half NdotL = saturate(dot (worldNormal, lightDirection));
		        half diff = (NdotL - 0.01) / 0.99;
				half lightIntensity = saturate(_LightColor0.a * diff * 4);
				o.baseLight = saturate(ambientLighting + ((_MinLight + _LightColor0.rgb) * lightIntensity));
				
				float4 planet_pos = -mul(_MainRotation, origin);
				float3 detail_pos = mul(_DetailRotation, planet_pos).xyz;
				//o.color = v.color;
				o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz); 
				o.color *= GetShereDetailMapNoLOD(_DetailTex, detail_pos, _DetailScale);
				
				float dist = _DistFade*distance(origin,_WorldSpaceCameraPos);
				float distVert = 1-(_DistFadeVert*distance(origin,_WorldSpaceCameraPos));
				o.color.a *= saturate(dist) * saturate(distVert);
				
				o.projPos = ComputeScreenPos (o.pos);
				COMPUTE_EYEDEPTH(o.projPos.z);
				TRANSFER_VERTEX_TO_FRAGMENT(o);
				
				return o;
			}
			
			fixed4 frag (v2f i) : COLOR
			{
				
				half xval = i.viewDir.x;
				half4 xtex = tex2D(_LeftTex, i.texcoordZY);
				half yval = i.viewDir.y;				
				half4 ytex = tex2D(_TopTex, i.texcoordXZ);
				half zval = i.viewDir.z;
				half4 ztex = tex2D(_FrontTex, i.texcoordXY);
				
				//half4 tex = (xtex*xval)+(ytex*yval)+(ztex*zval);
				half4 tex = lerp(lerp(xtex, ytex, yval), ztex, zval);
				
				half4 prev = .94*_Color * i.color * tex;
				
//				float3 lightColor = _LightColor0.rgb;
//		        float3 lightDir = normalize(_WorldSpaceLightPos0);
//		        
//		        float  atten = LIGHT_ATTENUATION(i);
//		        float  NL = saturate(.5*(1+dot(i.camPos, lightDir)));
//				float  lightIntensity = saturate(_LightColor0.a * (NL * atten * 4));
//		 		float  lightScatter = saturate(1-(lightIntensity*_LightScatter*prev.a));
		 		
		        half4 color;
		        color.rgb = prev.rgb * i.baseLight;
				color.a = prev.a;
				
				float depth = UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)));
				depth = LinearEyeDepth (depth);
				float partZ = i.projPos.z;
				float fade = saturate (_InvFade * (depth-partZ));
				color.a *= fade;
				
				return color;
			}
			ENDCG 
		}
		
	} 
	
}
}