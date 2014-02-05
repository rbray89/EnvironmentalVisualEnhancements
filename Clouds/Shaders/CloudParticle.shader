Shader "CloudParticle" {
Properties {
	_TopTex ("Particle Texture", 2D) = "white" {}
	_LeftTex ("Particle Texture", 2D) = "white" {}
	_FrontTex ("Particle Texture", 2D) = "white" {}
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
				float4 mvCenter = mul(UNITY_MATRIX_MV, float4(0, 0, 0, v.vertex.w));
				float4 origin = mul(UNITY_MATRIX_P, 
	              mvCenter
	              + float4(0,0,0,v.vertex.w));
	              
				v2f o;
				
				o.pos = mul(UNITY_MATRIX_P, 
	              mvCenter
	              + float4(v.vertex.x, v.vertex.y, v.vertex.z,v.vertex.w));
				
				float3 viewDir = normalize(ObjSpaceViewDir(half4(0,0,0,v.vertex.w)));
				o.viewDir = pow(viewDir,2);
				
				float2 texcoodOffsetxy = (2*v.texcoord)- 1;
				float4 texcoordOffset = float4(texcoodOffsetxy.x, texcoodOffsetxy.y, 0, v.vertex.w);
				
				//float4 wVert = mul(_Object2World, texcoordOffset);
				//float4 wOrigin = mul(_Object2World, float4(0, 0, 0, 1));
				
				//texcoordOffset = (wVert.xyww - wOrigin);
	            //  + float4(v.vertex.x, v.vertex.y, v.vertex.z,1));
				
				float4 ZYv = texcoordOffset.zyxw;
				float4 XZv = texcoordOffset.xzyw;
				float4 XYv = texcoordOffset.xyzw;
				
				ZYv.x += sign(-viewDir.x)*sign(ZYv.z)*(viewDir.z);
				XZv.y += sign(-viewDir.y)*sign(XYv.x)*(viewDir.x);
				XYv.z += sign(-viewDir.z)*sign(XYv.x)*(viewDir.x);
				
				ZYv.x += sign(-viewDir.x)*sign(ZYv.y)*(viewDir.y);
				//XZv.y += sign(-viewDir.y)*sign(XYv.z)*(viewDir.z);
				XYv.z += sign(-viewDir.z)*sign(XYv.y)*(viewDir.y);
				
				//o.pos = mul(UNITY_MATRIX_P, XYv + mvCenter);
				
				float2 ZY = mul(UNITY_MATRIX_MV, ZYv).xy - mvCenter.xy;
				float2 XZ = mul(UNITY_MATRIX_MV, XZv).xy - mvCenter.xy;
				float2 XY = mul(UNITY_MATRIX_MV, XYv).xy - mvCenter.xy;
	            
	            viewDir.x = o.viewDir.x;
	            viewDir.y = o.viewDir.y;
	            viewDir.z = o.viewDir.z;
	            
				//ZY = float2(ZY.x*viewDir.x, ZY.y*viewDir.x);               					
				//XZ = float2(XZ.x*viewDir.y, XZ.y*viewDir.y);
				//XY = float2(XY.x*viewDir.z, XY.y*viewDir.z);	 	
									
				o.texcoordZY = half2(.5 ,.5) + (ZY);
				o.texcoordXZ = half2(.5 ,.5) + (XZ);
				o.texcoordXY = half2(.5 ,.5) + (XY);
				
//				float3 vertex = mul(UNITY_MATRIX_IT_MV, o.pos).xyz;
//				o.color = float4(vertex.x, vertex.y, vertex.z, 1);//v.color;
				//o.color = float4(o.pos.x, o.pos.y, o.pos.z, 1);

				return o;
			}

			
			fixed4 frag (v2f i) : COLOR
			{
				
				half xval = i.viewDir.x;
				half4 xtex = tex2D(_LeftTex, i.texcoordZY);
				//xtex.a *= abs(xval);
				half yval = i.viewDir.y;				
				half4 ytex = tex2D(_TopTex, i.texcoordXZ);
				//ytex.a *= abs(yval);
				half zval = i.viewDir.z;
				half4 ztex = tex2D(_FrontTex, i.texcoordXY);
				//ztex.a *= abs(zval);
				
				half4 tex = (xtex*xval)+(ytex*yval)+(ztex*zval);
				
				half4 prev = _Color * i.color * tex;

				prev.rgb *= prev.a;
				return prev;
			}
			ENDCG 
		}
	} 
}
}