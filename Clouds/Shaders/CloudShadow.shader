Shader "Projector/CloudShadow" {
   Properties {
      _ShadowTex ("Projected Image", 2D) = "white" {}
      _ShadowOffset ("Shadow Offset", Vector) = (0,0,0,0)
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
 		float4 _ShadowOffset;
        uniform float4x4 _Projector; 
 
        struct appdata_t {
			float4 vertex : POSITION;
           	float3 normal : NORMAL;
        };
         
        struct v2f {
           	float4 pos : SV_POSITION;
           	float4 posProj : TEXCOORD0;
           	float dotcoeff : TEXCOORD1;
        };
 
        v2f vert (appdata_t v) 
        {
           	v2f o;
            o.posProj = mul(_Projector, v.vertex);
            o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
            float3 normView = normalize(float3(_Projector[2][0],_Projector[2][1], _Projector[2][2]));
    		o.dotcoeff = saturate(dot(-v.normal, normView));
            return o;
        }
         
		fixed4 frag (v2f IN) : COLOR
		{
			half dirCheck = saturate(floor(IN.posProj.w + 1))*IN.dotcoeff;
			fixed4 color = tex2D(_ShadowTex, (float2(.5,1)*IN.posProj.xy / IN.posProj.w) + _ShadowOffset.xy);
			color.rgb *= 1.25*(1.25-color.a);
			color = saturate(color);
			return lerp(1, color, dirCheck);
		}
 
         ENDCG
      }
   }  
}