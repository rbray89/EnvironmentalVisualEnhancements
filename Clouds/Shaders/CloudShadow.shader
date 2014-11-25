Shader "Projector/CloudShadow" {
   Properties {
      _MainTex ("Main (RGB)", 2D) = "white" {}
      _MainOffset ("Main Offset", Vector) = (0,0,0,0)
      _DetailTex ("Detail (RGB)", 2D) = "white" {}
      _DetailScale ("Detail Scale", float) = 100
	  _DetailOffset ("Detail Offset", Vector) = (.5,.5,0,0)
	  _DetailDist ("Detail Distance", Range(0,1)) = 0.00875
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
 		#define HALF_PI (0.5*PI)
 		#define INV_2PI (0.5/PI)
 		
        uniform sampler2D _MainTex; 
 		float4 _MainOffset;
		uniform sampler2D _DetailTex;
	    fixed4 _DetailOffset;
   	    float _DetailScale;
		float _DetailDist;
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
			float3 worldPos : TEXCOORD4;
        };
 
        v2f vert (appdata_t v) 
        {
           	v2f o;
            o.posProj = mul(_Projector, v.vertex);
            o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
            float3 normView = normalize(float3(_Projector[2][0],_Projector[2][1], _Projector[2][2]));
    		o.dotcoeff = saturate(dot(-v.normal, normView));
    		o.latitude = asin(_MainOffset.y);
			o.longitude = atan2(_MainOffset.x, _MainOffset.z);
			float3 vertexPos = mul(_Object2World, v.vertex).xyz;
	   	   	o.worldPos = vertexPos;
            return o;
        }
         
        float4 Derivatives( float lat, float lon, float3 pos)  
		{  
		    float2 latLong = float2( lat, lon );  
		    float latDdx = INV_2PI*length( ddx( pos.xz ) );  
		    float latDdy = INV_2PI*length( ddy( pos.xz ) );  
		    float longDdx = ddx( lon );  
		    float longDdy = ddy( lon );  
		 	
		    return float4( latDdx , longDdx , latDdy, longDdy );  
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
			half2 detailuv = uv;
			detailuv.x += _MainOffset.w;
			detailuv.y *= 2;
			detailuv.y -= 1;
			uv.x += 1;
			uv.x *= .5;
			uv.x += _MainOffset.w;
			fixed4 color = tex2D(_MainTex, uv, dx, dy);
		    half3 objNrm;
		    objNrm.y = sin(HALF_PI*detailuv.y);
		    float ymag = (1-(objNrm.y*objNrm.y));
		    objNrm.z = cos(HALF_PI*detailuv.y)*cos(PI*detailuv.x);
		    objNrm.x = cos(HALF_PI*detailuv.y)*sin(PI*detailuv.x);
		    
			float4 uvdd = Derivatives(uv.x-.5, uv.y, objNrm);
			
		    objNrm = abs(objNrm);
			half zxlerp = saturate(floor(1+objNrm.x-objNrm.z));
			half3 detailCoords = lerp(objNrm.zxy, objNrm.xyz, zxlerp);
			half nylerp = saturate(floor(1+objNrm.y-(lerp(objNrm.z, objNrm.x, zxlerp))));		
			detailCoords = lerp(detailCoords, objNrm.yxz, nylerp);
			half4 detail = tex2D (_DetailTex, ((.5*detailCoords.zy)/(abs(detailCoords.x)) + _DetailOffset.xy, uvdd.xy, uvdd.zw) *_DetailScale);	
			
			half detailLevel = saturate(2*_DetailDist*distance(IN.worldPos,_WorldSpaceCameraPos));
			color *= lerp(detail.rgba, 1, detailLevel);
			color.a = 1.2*(1.2-color.a);
			color = saturate(color);

			return lerp(1, color.a, dirCheck*radCheck);
		}
 
         ENDCG
      }
   }  
}