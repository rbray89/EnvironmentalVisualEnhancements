Shader "EVE/RealWindows" {
	Properties{
		_MainTex("_MainTex (RGB spec(A))", 2D) = "white" {}
		_Shininess("Shininess", Range(0.03,1)) = 0.078125
		_IVATex("Base (RGB) Gloss (A)", 2D) = "white" {}
	}
		SubShader{
		Tags{ "RenderType" = "Transparent" "IgnoreProjector" = "True" "Queue" = "Transparent" }
		LOD 400
		CGPROGRAM
#pragma surface surf BlinnPhong alpha

		

		sampler2D _MainTex;
		sampler2D _IVATex;
		sampler2D _BumpMap;
		sampler2D _Emissive;
		half _Shininess;

	struct Input {
		float2 uv_MainTex;
		float4 screenPos;
	};

	void surf(Input IN, inout SurfaceOutput o) {
		fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
		float2 screenUV = IN.screenPos.xy / IN.screenPos.w;
		fixed4 IVAtex = tex2D(_IVATex, screenUV);
		fixed4 final = lerp(tex, IVAtex, tex.a);
		o.Albedo = final.rgb;
		o.Gloss = tex.a;
		o.Alpha = final.a;
		o.Specular = _Shininess;
	}
	ENDCG
	}
		FallBack "Self-Illumin/Specular"
}
