Shader "CloudParticle" {
Properties {
	_TopTex ("Particle Texture", 2D) = "white" {}
	_LeftTex ("Particle Texture", 2D) = "white" {}
	_FrontTex ("Particle Texture", 2D) = "white" {}
	_InvFade ("Soft Particles Factor", Range(0.01,3.0)) = 1.0
	_Color ("Color Tint", Color) = (1,1,1,1)
}

Category {
	
	Lighting On
	ZWrite Off
	Cull Off
	AlphaTest Greater .01
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Color (0,0,0,0) }
	Tags { 
	"Queue"="Transparent" 
	"IgnoreProjector"="True" 
	"RenderType"="Transparent" 
	}

	SubShader {
		Pass {
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#define MAG_ONE 1.4142135623730950488016887242097

			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma multi_compile_particles

			#include "UnityCG.cginc"

			
			sampler2D _TopTex;
			sampler2D _BotTex;
			sampler2D _LeftTex;
			sampler2D _RightTex;
			sampler2D _FrontTex;
			sampler2D _BackTex;
			fixed4 _Color;
			float _InvFade;
			
			struct appdata_t {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 pos : SV_POSITION;
				fixed4 color : COLOR;
				float3 viewDir : TEXCOORD0;
				float2 texcoordZY : TEXCOORD1;
				float2 texcoordXZ : TEXCOORD2;
				float2 texcoordXY : TEXCOORD3;
				#ifdef SOFTPARTICLES_ON
				float4 projPos : TEXCOORD4;
				#endif
			};

			float4 _TopTex_ST;
			
			v2f vert (appdata_t v)
			{
				float4 mvCenter = mul(UNITY_MATRIX_MV, float4(0, 0, 0, v.vertex.w));
	              
				v2f o;
				
				o.pos = mul(UNITY_MATRIX_P, 
	              mvCenter
	              + float4(v.vertex.x, v.vertex.y, v.vertex.z,v.vertex.w));
				
				//float3 viewDir = normalize(ObjSpaceViewDir(half4(0,0,0,v.vertex.w)));
				float3 viewDir = normalize(UNITY_MATRIX_MV[2].xyz);
				
				//o.viewDir = pow(viewDir,2);
				o.viewDir = abs(viewDir);
				
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
				
				//float3 vertex = 3*normalize(mul(UNITY_MATRIX_MV, v.vertex)).xyz;
				o.color = v.color;//float4(vertex.x, vertex.y, vertex.z, 1)*v.color;

				#ifdef SOFTPARTICLES_ON
				o.projPos = ComputeScreenPos (o.pos);
				COMPUTE_EYEDEPTH(o.projPos.z);
				#endif

				return o;
			}

			sampler2D _CameraDepthTexture;
			
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
				
				#ifdef SOFTPARTICLES_ON
				float sceneZ = LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos))));
				float partZ = i.projPos.z;
				float fade = saturate (_InvFade * (sceneZ-partZ));
				i.color.a *= fade;
				#endif
				
				half4 prev = _Color * i.color * tex;
				return prev;
			}
			ENDCG 
		}
	} 
}
}