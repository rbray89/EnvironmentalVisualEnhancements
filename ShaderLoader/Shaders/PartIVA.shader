Shader "EVE/RealWindows" {
	Properties{
		_MainTex("_MainTex (RGB spec(A))", 2D) = "white" {}
		_IVATex("Base (RGB) Gloss (A)", 2D) = "white" {}
		_Clarity("Clarity", Float) = 1.1
		_Shininess("Shininess", Float) = 0
		_RearWindowColor("Sunlight direction", Vector) = (.1,.2,.75,0)
	}

		SubShader{
		Tags{ "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }

		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha

		Pass{
		CGPROGRAM

#include "UnityCG.cginc"
#pragma target 3.0
#pragma glsl
#pragma vertex vert
#pragma fragment frag
#pragma multi_compile TRANSPARENT NOT_TRANSPARENT

	struct appdata_t {
		float4 vertex : POSITION;
		float2 texcoord : TEXCOORD0;
	};

	struct v2f {
		float4 vertex : SV_POSITION;
		half2 texcoord : TEXCOORD0;
		float4 scrPos : TEXCOORD1;
	};

	sampler2D _MainTex;
	sampler2D _IVATex;
	float4 _MainTex_ST;
	float _Clarity;
	float _Shininess;
	half4 _RearWindowColor;

	v2f vert(appdata_t v)
	{
		v2f o;
		o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
		o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
		o.scrPos = ComputeScreenPos(o.vertex);
		return o;
	}

	fixed4 frag(v2f i) : COLOR
	{
		float2 scrPos = i.scrPos.xy / i.scrPos.w;
		fixed4 tex = tex2D(_MainTex, i.texcoord);
		fixed4 iva = tex2D(_IVATex, scrPos);
		half alpha = saturate((1 - tex.a)*_Clarity);
		iva.rgb = lerp(tex.rgb, iva.rgb, alpha);
		
#ifdef TRANSPARENT
		alpha = saturate(iva.a + (1-_Clarity));
		iva.rgb = lerp(_RearWindowColor.rgb, iva.rgb, iva.a);
		iva.a = alpha;
#else
		iva.rgb = lerp(_RearWindowColor.rgb, iva.rgb, iva.a);
		iva.a = 1;
#endif
		iva.a = iva.a*(1-step(.9, tex.a));
	return iva;
	}
		ENDCG
	}
	}
}
