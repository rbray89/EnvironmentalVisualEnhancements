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
		_MinLight ("Minimum Light", Range(0,1)) = .5
		_FadeDist ("Fade Distance", Range(0,100)) = 10
		_FadeScale ("Fade Scale", Range(0,1)) = .002
		_RimDist ("Rim Distance", Range(0,100000)) = 1000
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
		float _FadeScale;
		float _RimDist;
		
		half4 LightingSimpleLambert (SurfaceOutput s, half3 lightDir, half atten) {
          half NdotL = saturate(dot (s.Normal, lightDir));
          half diff = (NdotL - 0.01) / 0.99;
		  float lightIntensity = saturate(_LightColor0.a * (diff * atten * 4));
          half4 c;
          c.rgb = s.Albedo *saturate((_MinLight + _LightColor0.rgb) * lightIntensity);
          c.a = s.Alpha;
          return c;
      	}
		
		struct Input {
	 		float3 nrm;
	 		float3 viewDir;
	 		float3 worldVert;
	 		float3 worldOrigin;
	 		float viewDist;
			INTERNAL_DATA
		};

		void vert (inout appdata_full v, out Input o) {
		   UNITY_INITIALIZE_OUTPUT(Input, o);
		   float3 vertexPos = mul(_Object2World, v.vertex).xyz;
		   float3 origin = mul(_Object2World, float4(0,0,0,1)).xyz;
		   //float4 viewPos = mul(glstate.matrix.modelview[0], v.vertex);
		   //float dist = (-viewPos.z - _ProjectionParams.y);
	   	   o.worldVert = vertexPos;
	   	   o.worldOrigin = origin;
	   	   o.viewDist = distance(vertexPos,_WorldSpaceCameraPos);
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
		
			half detailLevel = saturate(2*_DetailDist*IN.viewDist);
			half3 albedo = main.rgb * lerp(detail.rgb, 1, detailLevel);
			o.Normal = float3(0,0,1);
			o.Albedo = albedo;
			half avg = min(main.a, lerp(detail.a, 1, detailLevel));
			float rim = saturate(abs(dot(normalize(IN.viewDir), o.Normal)));
            rim = saturate(pow(_FalloffScale*rim,_FalloffPow));
            float dist = distance(IN.worldVert,_WorldSpaceCameraPos);
            float distLerp = saturate(distance(IN.worldOrigin,_WorldSpaceCameraPos)-1.2*distance(IN.worldVert,IN.worldOrigin));
            float distFade = saturate((_FadeScale*dist)-_FadeDist);
			float distAlpha = lerp(distFade, rim, distLerp);
          	o.Alpha = lerp(0, avg,  distAlpha);
          	o.Normal = lerp(UnpackNormal (normal),half3(0,0,1),detailLevel);
		}
		ENDCG
	
	}
	
	 
	FallBack "Diffuse"
}
