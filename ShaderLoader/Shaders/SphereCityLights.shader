Shader "EVE/CityLight" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_OverlayTex ("Main (RGB)", 2D) = "white" {}
		_OverlayDetailTex ("Detail (RGB) (A)", 2D) = "white" {}
		_OverlayDetailScale ("Detail Scale", Range(0,1000)) = 80
		_OverlayDetailOffset ("Detail Offset", Color) = (0,0,0,0)
		_FadeDist ("Fade Distance", Range(0,10000)) = .01
		_FadeScale ("Fade Scale", Range(0,1)) = .002
		_Opacity ("Fade Alpha", Range(0,1)) = 1
	}
	Category {
	   Lighting On
	   ZWrite Off
	   Cull Back
	   Blend SrcAlpha OneMinusSrcAlpha
	   Tags {
	   "Queue"="Transparent"
	   "RenderMode"="Transparent"
	   }
	   SubShader {  	
        
     CGPROGRAM
	 #pragma surface surf None vertex:vert noforwardadd noambient novertexlights nolightmap nodirlightmap 
	 #pragma glsl
	 #pragma target 3.0
	 #define PI 3.1415926535897932384626
	 #define INV_PI (1.0/PI)
	 #define TWOPI (2.0*PI) 
	 #define INV_2PI (1.0/TWOPI)
	 
	 sampler2D _OverlayTex;
	 sampler2D _OverlayDetailTex;
	 float _OverlayDetailScale;
	 fixed4 _OverlayDetailOffset;
	 float _FadeDist;
	 float _FadeScale;
	 float _SwapFadeDist;
	 float _SwapFadeScale;
	 float _Opacity;
	 fixed4 _Color;
	 
	 
	 struct Input {
	 	float viewDist;
	 	float3 nrm;
	 	INTERNAL_DATA
	 };
	
	half4 LightingNone (SurfaceOutput s, half3 lightDir, half atten)
      {
		half NdotL = dot (s.Normal, lightDir);
		half diff = (NdotL - 0.01) / 0.99;
		float lightIntensity = _LightColor0.a * (diff * atten * 4);
		float satLight = saturate(lightIntensity);
		float invlight = 1-satLight;
        
        fixed4 c;
		c.a = s.Alpha * invlight;
        c.rgb = 0;
        return c;
      }
	
	 void vert (inout appdata_full v, out Input o) {
	   UNITY_INITIALIZE_OUTPUT(Input, o);
	   float3 vertexPos = mul(_Object2World, v.vertex).xyz;
	   float3 origin = mul(_Object2World, float4(0,0,0,1)).xyz;
	   float dist = abs(distance(origin, vertexPos) - (distance(origin,_WorldSpaceCameraPos)));
   	   o.viewDist = dist;
	   o.nrm = -normalize(v.vertex.xyz);
	 }
	
	float4 Derivatives( float3 pos )  
		{  
		    float lat = INV_2PI*atan2( pos.y, pos.x );  
		    float lon = INV_PI*acos( pos.z );  
		    float2 latLong = float2( lat, lon );  
		    float latDdx = INV_2PI*length( ddx( pos.xy ) );  
		    float latDdy = INV_2PI*length( ddy( pos.xy ) );  
		    float longDdx = ddx( lon );  
		    float longDdy = ddy( lon );  
		 
		    return float4( latDdx , longDdx , latDdy, longDdy );  
		} 
	
	 void surf (Input IN, inout SurfaceOutput o) {
	 	float3 nrm = IN.nrm;
	 	float2 uv;
	 	uv.x = .5 + (INV_2PI*atan2(nrm.x, nrm.z));
	 	uv.y = INV_PI*acos(nrm.y);
	    float4 uvdd = Derivatives(nrm);
		half4 main = tex2D(_OverlayTex, uv, uvdd.xy, uvdd.zw)*_Color;
		half4 detailX = tex2D (_OverlayDetailTex, nrm.zy*_OverlayDetailScale + _OverlayDetailOffset.xy);
		half4 detailY = tex2D (_OverlayDetailTex, nrm.zx*_OverlayDetailScale + _OverlayDetailOffset.xy);
		half4 detailZ = tex2D (_OverlayDetailTex, nrm.xy*_OverlayDetailScale + _OverlayDetailOffset.xy);
			
		nrm = abs(nrm);
		half4 detail = lerp(detailZ, detailX, nrm.x);
		detail = lerp(detail, detailY, nrm.y);
		main = main*detail;
		float distAlpha = saturate(_FadeScale*(IN.viewDist - _FadeDist));
	    o.Alpha = _Opacity*min(main.a, distAlpha);
	    o.Emission = main.rgb;
	 }
	 	 
	 ENDCG
	 	 
	 } 
    }
}