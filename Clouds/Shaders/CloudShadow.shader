Shader "Projector/CloudShadow" {
   Properties {
      _ShadowTex ("Projected Image", 2D) = "white" {}
   }
   SubShader {
      Pass {      
        Blend DstColor Zero
        CGPROGRAM
 		#pragma target 3.0
		#pragma glsl
        #pragma vertex vert  
        #pragma fragment frag 
 
        uniform sampler2D _ShadowTex; 
 
        uniform float4x4 _Projector; 
 
        struct appdata_t {
			float4 vertex : POSITION;
           	float3 normal : NORMAL;
        };
         
        struct v2f {
           	float4 pos : SV_POSITION;
           	float4 posProj : TEXCOORD0;
        };
 
        v2f vert (appdata_t v) 
        {
           	v2f o;
            o.posProj = mul(_Projector, v.vertex);
            o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
            return o;
        }
         
		fixed4 frag (v2f IN) : COLOR
		{
			half dirCheck = saturate(floor(IN.posProj.w + 1));
			fixed4 color = tex2D(_ShadowTex, float2(IN.posProj) / IN.posProj.w);
			color.rgb *= 1.25*(1.25-color.a);
			color = saturate(color);
			return lerp(1, color, dirCheck);
		}
 
         ENDCG
      }
   }  
}