Shader "Projector/CloudShadow" {
   Properties {
      _ShadowTex ("Projected Image", 2D) = "white" {}
      _ShadowOffset ("Shadow Offset", Vector) = (0,0,0,0)
   }
   SubShader {
      Pass {      
        Blend DstColor Zero
        ZWrite Off
        CGPROGRAM
 		#pragma target 3.0
		#pragma glsl
        #pragma vertex vert  
        #pragma fragment frag 
 		#define PI 3.1415926535897932384626
 		#define INV_PI (1.0/PI)
 		#define INV_2PI (0.5/PI)
 		
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
           	half latitude : TEXCOORD2;
			half longitude : TEXCOORD3;
        };
 
        v2f vert (appdata_t v) 
        {
           	v2f o;
            o.posProj = mul(_Projector, v.vertex);
            o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
            float3 normView = normalize(float3(_Projector[2][0],_Projector[2][1], _Projector[2][2]));
    		o.dotcoeff = saturate(dot(-v.normal, normView));
    		o.latitude = -asin(_ShadowOffset.y);
			o.longitude = atan2(_ShadowOffset.x, _ShadowOffset.z);
            return o;
        }
         
		fixed4 frag (v2f IN) : COLOR
		{
			half dirCheck = saturate(floor(IN.posProj.w + 1))*IN.dotcoeff;
			half2 uv = IN.posProj.xy / IN.posProj.w;
			half2 dx = ddx(IN.posProj.xy);
			half2 dy = ddy(IN.posProj.xy);
			half x = -(2*uv.x) + 1;
			half y = (2*uv.y) - 1 ;
			
			float p = sqrt(pow(x,2) + pow(y,2));
			half radCheck = saturate(floor(2-p));
			half c = asin(p);
			half sinC = sin(c);
			half cosC = cos(c);
			half cosLat = cos(IN.latitude);
			half sinLat = sin(IN.latitude);
			
			uv.x = INV_PI*(IN.longitude+atan2(x*sinC, (p*cosLat*cosC)-(y*sinLat*sinC)))+.5;
			uv.y = INV_PI*asin((cosC*sinLat)+(y*sinC*cosLat/p))+.5;
			uv.x += 1;
			uv.x *= .5;
			uv.x += _ShadowOffset.w;
			fixed4 color = tex2D(_ShadowTex, uv, dx, dy);
			color.rgb *= 1.25*(1.25-color.a);
			color = saturate(color);
			return lerp(1, color, dirCheck*radCheck);
		}
 
         ENDCG
      }
   }  
}