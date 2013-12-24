Shader "Cubic/CityLight" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Main (RGB)", CUBE) = "" {}
		_DetailTex ("Detail (RGB) (A)", 2D) = "white" {}
		_DetailScale ("Detail Scale", Range(0,1000)) = 100
		_DetailOffset ("Detail Offset", Color) = (0,0,0,0)
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
	 #pragma target 3.0
	 samplerCUBE _MainTex;
	 sampler2D _DetailTex;
	 float _DetailScale;
	 fixed4 _Color;
	 fixed4 _DetailOffset;
	
	 struct Input {
	 	float distAlpha;
	 	float3 localPos;
	 	INTERNAL_DATA
	 };
	
	half4 LightingNone (SurfaceOutput s, half3 lightDir, half atten)
      {
		half NdotL = dot (s.Normal, lightDir);
		half diff = (NdotL - 0.01) / 0.99;
		float lightIntensity = _LightColor0.a * (diff * atten * 16);
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
	   float dist = distance(vertexPos,_WorldSpaceCameraPos.xyz);
	   float alpha = saturate(250 - .00001*pow(dist-5000,2));
	   o.distAlpha = alpha*saturate((distance(origin,_WorldSpaceCameraPos)-1.0015*distance(origin, vertexPos)));
	   o.localPos = normalize(v.vertex.xyz);
	 }
	
	 void surf (Input IN, inout SurfaceOutput o) {
	    half4 main = texCUBE(_MainTex, IN.localPos)*_Color;
		float3 pos = IN.localPos;
		half4 detailX = tex2D (_DetailTex, pos.zy*_DetailScale + _DetailOffset.xy);
		half4 detailY = tex2D (_DetailTex, pos.zx*_DetailScale + _DetailOffset.xy);
		half4 detailZ = tex2D (_DetailTex, pos.xy*_DetailScale + _DetailOffset.xy);
			
		pos = abs(pos);
		half4 detail = lerp(detailZ, detailX, pos.x);
		detail = lerp(detail, detailY, pos.y);
		main = main*detail;
	    o.Alpha = min(main.a, IN.distAlpha);
	    o.Emission = main.rgb;
	 }
	 	 
	 ENDCG
	 	 
	 } 
    }
}