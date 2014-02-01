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
	
	Lighting On
	ZWrite Off
	Cull Off
	Blend One OneMinusSrcColor
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
				float4 pos : SV_POSITION;
				fixed4 color : COLOR;
				float3 viewDir : TEXCOORD0;
				float2 texcoordZY : TEXCOORD1;
				float2 texcoordXZ : TEXCOORD2;
				float2 texcoordXY : TEXCOORD3;
			};

			float4 _TopTex_ST;
			
			v2f vert (appdata_t v)
			{
				float4 mvCenter = mul(UNITY_MATRIX_MV, float4(0, 0, 0, 1));
				float4 origin = mul(UNITY_MATRIX_P, 
	              mvCenter
	              + float4(0,0,0,1));
	              
				v2f o;
				
				o.pos = mul(UNITY_MATRIX_P, 
	              mvCenter
	              + float4(v.vertex.x, v.vertex.y, v.vertex.z,1));
				
				float2 texcoodOffsetxy = (2*v.texcoord)- 1;
				float4 texcoordOffset = float4(texcoodOffsetxy.x, texcoodOffsetxy.y, 0, 1);
				
				float2 ZY = mul(UNITY_MATRIX_MV, texcoordOffset.zyxw).xy - mvCenter.xy;
				float2 XZ = mul(UNITY_MATRIX_MV, texcoordOffset.xzyw).xy - mvCenter.xy;
				float2 XY = mul(UNITY_MATRIX_MV, texcoordOffset.xyzw).xy - mvCenter.xy;
	                       								
				o.texcoordZY = half2(.5 ,.5) + (.5*ZY*MAG_ONE);
				o.texcoordXZ = half2(.5 ,.5) + (.5*XZ*MAG_ONE);
				o.texcoordXY = half2(.5 ,.5) + (.5*XY*MAG_ONE);
				
				o.viewDir = normalize(ObjSpaceViewDir(half4(0,0,0,1)));
//				float3 vertex = mul(UNITY_MATRIX_IT_MV, o.pos).xyz;
//				o.color = float4(vertex.x, vertex.y, vertex.z, 1);//v.color;
				//o.color = float4(o.pos.x, o.pos.y, o.pos.z, 1);
				
				return o;
			}

			
			fixed4 frag (v2f i) : COLOR
			{
				
				half xval = saturate (.5 + (.5*i.viewDir.x));
				half4 xtex = lerp(tex2D(_LeftTex, i.texcoordZY),tex2D(_RightTex, i.texcoordZY), xval );
				half yval = saturate (.5 + (.5*i.viewDir.y));
				half4 ytex = lerp(tex2D(_TopTex, i.texcoordXZ),tex2D(_BotTex, i.texcoordXZ), yval );
				half zval = saturate (.5 + (.5*i.viewDir.z));
				half4 ztex = lerp(tex2D(_FrontTex, i.texcoordXY),tex2D(_BackTex, i.texcoordXY), zval );
				
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