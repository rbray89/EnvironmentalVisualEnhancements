Shader "Sphere/Cloud" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		_BumpMap ("Bumpmap", 2D) = "bump" {}
		_FalloffPow ("Falloff Power", Range(0,3)) = 2
		_FalloffScale ("Falloff Scale", Range(0,20)) = 3
		_DetailScale ("Detail Scale", Range(0,1000)) = 100
		_DetailOffset ("Detail Offset", Color) = (0,0,0,0)
		_BumpScale ("Bump Scale", Range(0,1000)) = 50
		_BumpOffset ("Bump offset", Color) = (0,0,0,0)
		_DetailDist ("Detail Distance", Range(0,1)) = 0.00875
		_MinLight ("Minimum Light", Range(0,1)) = .1
		_FadeDist ("Fade Distance", Range(0,1)) = .002
	}

SubShader {
		Tags {  "Queue"="Transparent"
	   			"RenderMode"="Transparent" }
		Lighting On
		Cull Off
	    ZWrite Off
		
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#pragma surface surf SimpleLambert vertex:vert noforwardadd novertexlights nolightmap nodirlightmap
		#pragma glsl
		#pragma target 3.0
		#define PI 3.1415926535897932384626
		#define INV_PI (1.0/PI)
		#define TWOPI (2.0*PI) 
		#define INV_2PI (1.0/TWOPI)
	 
		sampler2D _MainTex;
		sampler2D _DetailTex;
		sampler2D _BumpMap;
		fixed4 _Color;
		fixed4 _DetailOffset;
		fixed4 _BumpOffset;
		float _FalloffPow;
		float _FalloffScale;
		float _DetailScale;
		float _DetailDist;
		float _BumpScale;
		float _MinLight;
		float _FadeDist;
		
		half4 LightingSimpleLambert (SurfaceOutput s, half3 lightDir, half atten) {
          half NdotL = saturate(dot (s.Normal, lightDir));
          half4 c;
          c.rgb = s.Albedo * saturate(_MinLight+ _LightColor0.rgb * (NdotL * atten * 2));
          c.a = s.Alpha;
          return c;
      	}
		
		struct Input {
			float3 worldPos;
	 		float3 nrm;
	 		float rim;
	 		float viewDist;
			INTERNAL_DATA
		};

		void vert (inout appdata_full v, out Input o) {
		   UNITY_INITIALIZE_OUTPUT(Input, o);
		   float3 normalDir = normalize(mul(_Object2World, v.normal.xyzz).xyz);
		   float3 vertexPos = mul(_Object2World, v.vertex).xyz;
		   float3 viewVect = normalize( vertexPos - _WorldSpaceCameraPos);
		   float dist = _DetailDist*distance(vertexPos,_WorldSpaceCameraPos);
	   	   o.viewDist = dist;
	   	   o.rim = saturate(saturate(.0825*distance(vertexPos,_WorldSpaceCameraPos))+ saturate(pow(.8*_FalloffScale*dot(normalDir, -viewVect),_FalloffPow)));
	   	   o.worldPos = vertexPos;
	   	   o.nrm = normalize(v.vertex.xyz);
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
		 	uv.x = .5 + (INV_2PI*atan2(nrm.z, nrm.x));
		 	uv.y = INV_PI*acos(-nrm.y);
		 	float4 uvdd = Derivatives(nrm);
		    half4 main = tex2D(_MainTex, uv, uvdd.xy, uvdd.zw)*_Color;
			half4 detailX = tex2D (_DetailTex, nrm.zy*_DetailScale + _DetailOffset.xy);
			half4 detailY = tex2D (_DetailTex, nrm.zx*_DetailScale + _DetailOffset.xy);
			half4 detailZ = tex2D (_DetailTex, nrm.xy*_DetailScale + _DetailOffset.xy);
			half4 normalX = tex2D (_BumpMap, nrm.zy*_BumpScale + _BumpOffset.xy);
			half4 normalY = tex2D (_BumpMap, nrm.zx*_BumpScale + _BumpOffset.xy);
			half4 normalZ = tex2D (_BumpMap, nrm.xy*_BumpScale + _BumpOffset.xy);
			nrm = abs(nrm);
			half4 detail = lerp(detailZ, detailX, nrm.x);
			detail = lerp(detail, detailY, nrm.y);
			half4 normal = lerp(normalZ, normalX, nrm.x);
			normal = lerp(normal, normalY, nrm.y);
		
			half detailLevel = saturate(2*IN.viewDist);
			half3 albedo = main.rgb * lerp(detail.rgb, 1, detailLevel);
			o.Normal = float3(0,0,1);
			o.Albedo = albedo;
			half avg = main.a * lerp(detail.a, 1, detailLevel);
			float distAlpha = saturate(_FadeDist*distance(IN.worldPos, _WorldSpaceCameraPos));
          	o.Alpha = lerp(0, avg, min(IN.rim, distAlpha));
          	o.Normal = lerp(UnpackNormal (normal),half3(0,0,1),detailLevel);
		}
		ENDCG
	
	}
	
	 
	FallBack "Diffuse"
}
