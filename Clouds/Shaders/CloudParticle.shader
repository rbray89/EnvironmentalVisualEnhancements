Shader "CloudParticle" {
Properties {
	_TopTex ("Particle Texture", 2D) = "white" {}
	_BotTex ("Particle Texture", 2D) = "white" {}
	_LeftTex ("Particle Texture", 2D) = "white" {}
	_RightTex ("Particle Texture", 2D) = "white" {}
	_FrontTex ("Particle Texture", 2D) = "white" {}
	_BackTex ("Particle Texture", 2D) = "white" {}
	_Color ("Color Tint", Color) = (1,1,1,1)
}

Category {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend One OneMinusSrcColor
	ColorMask RGB
	Cull Off Lighting Off ZWrite Off Fog { Color (0,0,0,0) }

	SubShader {
		Pass {
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_particles

			#include "UnityCG.cginc"
			
			sampler2D _TopTex;
			sampler2D _BotTex;
			sampler2D _LeftTex;
			sampler2D _RightTex;
			sampler2D _FrontTex;
			sampler2D _BackTex;
			fixed4 _Color;
			
			struct appdata_t {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
				float3 viewDir : TEXCOORD1;
			};

			float4 _TopTex_ST;
			
			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_P, 
	              mul(UNITY_MATRIX_MV, float4(0.0, 0.0, 0.0, 1.0))
	              + float4(v.vertex.x, v.vertex.y, v.vertex.z, 0.0));
				
				o.color = v.color;
				o.texcoord = TRANSFORM_TEX(v.texcoord,_TopTex);
				o.viewDir = normalize(_WorldSpaceCameraPos - mul(_Object2World, half4(0,0,0,1)));
				return o;
			}

			sampler2D _CameraDepthTexture;
			float _InvFade;
			
			fixed4 frag (v2f i) : COLOR
			{
				
				half xval = saturate (.5 + (.5*i.viewDir.x));
				half4 xtex = lerp(tex2D(_LeftTex, i.texcoord),tex2D(_RightTex, i.texcoord), xval );
				half yval = saturate (.5 + (.5*i.viewDir.y));
				half4 ytex = lerp(tex2D(_TopTex, i.texcoord),tex2D(_BotTex, i.texcoord), yval );
				half zval = saturate (.5 + (.5*i.viewDir.z));
				half4 ztex = lerp(tex2D(_FrontTex, i.texcoord),tex2D(_BackTex, i.texcoord), zval );
				
				half4 tex = lerp(lerp(ytex,ztex,abs(i.viewDir.z)), xtex, abs(i.viewDir.x));
				half4 prev = _Color * i.color * tex;

				prev.rgb *= prev.a;
				return prev;
			}
			ENDCG 
		}
	} 
}
}