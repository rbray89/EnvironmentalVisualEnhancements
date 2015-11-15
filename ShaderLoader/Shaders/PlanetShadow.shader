Shader "EVE/PlanetShadow" {
	Properties{
		_PlanetOrigin("Sphere Center", Vector) = (0,0,0,1)
		_SunDir("Sunlight direction", Vector) = (0,0,0,1)
		_PlanetRadius("Planet Radius", Float) = 1
	}
	SubShader{
		Pass {
			Blend SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			CGPROGRAM
			#include "EVEUtils.cginc"
			#pragma target 3.0
			#pragma glsl
			#pragma vertex vert
			#pragma fragment frag

			uniform sampler2D _MainTex;
			float4 _MainOffset;
			uniform sampler2D _DetailTex;
			fixed4 _DetailOffset;
			float _DetailScale;
			float _DetailDist;
			float4 _SunDir;
			float _PlanetRadius;

			float3 _PlanetOrigin;
			uniform float4x4 _Projector;

			struct appdata_t {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f {
				float4 pos : SV_POSITION;
				float4 posProj : TEXCOORD0;
				float nDotL : TEXCOORD1;
			};

			v2f vert(appdata_t v)
			{
				v2f o;
				o.posProj = mul(_Projector, v.vertex);
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

				o.nDotL = -dot(_SunDir, mul(_Object2World, float4(v.normal,0)).xyz);
				return o;
			}

			fixed4 frag(v2f IN) : COLOR
			{
				half shadowCheck = step(0, IN.posProj.w)*step(0, IN.nDotL);
				half4 color;
				color.a = saturate(abs(IN.posProj.x)+abs(IN.posProj.y));
				color.rgb = half3(1, 0, 1);
				color.a = shadowCheck;
				return color;// lerp(1, color, shadowCheck);
			}

			ENDCG
		}
	}
}