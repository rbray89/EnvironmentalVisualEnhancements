Shader "Sphere/UndersideCloud" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		_BumpMap ("Bumpmap", 2D) = "bump" {}
		_FalloffPow ("Falloff Power", Range(0,3)) = 1.8
		_FalloffScale ("Falloff Scale", Range(0,20)) = 10
		_DetailScale ("Detail Scale", Range(0,1000)) = 100
		_DetailOffset ("Detail Offset", Color) = (0,0,0,0)
		_BumpScale ("Bump Scale", Range(0,1000)) = 50
		_BumpOffset ("Bump offset", Color) = (0,0,0,0)
		_DetailDist ("Detail Distance", Range(0,1)) = 0.025
		_MinLight ("Minimum Light", Range(0,1)) = .18
	}

SubShader {
		Tags {  "Queue"="Transparent"
	   			"RenderMode"="Transparent" }
		Lighting On
		Cull Front
	    ZWrite Off
		
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#pragma surface surf SimpleLambert vertex:vert noforwardadd novertexlights nolightmap nodirlightmap
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
		
		half4 LightingSimpleLambert (SurfaceOutput s, half3 lightDir, half atten) {
          half NdotL = saturate(dot (s.Normal, lightDir));
          half4 c;
          c.rgb = s.Albedo * saturate(_MinLight+ _LightColor0.rgb * (NdotL * atten * 2));
          c.a = s.Alpha;
          return c;
      	}
		
		struct Input {
			float2 viewDist;
			float3 viewDir;
			float3 localPos;
			INTERNAL_DATA
		};

		void vert (inout appdata_full v, out Input o) {
			UNITY_INITIALIZE_OUTPUT(Input, o);
		   float3 normalDir = normalize(mul(_Object2World, v.normal.xyzz).xyz);
		   float3 modelCam = _WorldSpaceCameraPos;	   
		   float3 vertexPos = mul(_Object2World, v.vertex).xyz;
		   float3 viewVect = normalize( vertexPos - modelCam);
		   float3 origin = mul(_Object2World, float4(0,0,0,1)).xyz;
		   float diff = distance(origin, vertexPos) - 1.003*(distance(origin,_WorldSpaceCameraPos));
	   	   o.viewDist.x = saturate(_DetailDist*distance(vertexPos,_WorldSpaceCameraPos));
	   	   o.viewDist.y = saturate(diff) * saturate(saturate(.0825*distance(vertexPos,_WorldSpaceCameraPos))+ saturate(pow(.8*_FalloffScale*dot(normalDir, -viewVect),_FalloffPow)));
	   	   o.localPos = normalize(v.vertex.xyz);
	 	}

		void surf (Input IN, inout SurfaceOutput o) {
			float3 pos = IN.localPos;
		 	float2 uv;
		 	uv.x = .5 + (INV_2PI*atan2(pos.z, pos.x));
		 	uv.y = INV_PI*acos(-pos.y);
		    half4 main = tex2D(_MainTex, uv)*_Color;
			half4 detailX = tex2D (_DetailTex, pos.zy*_DetailScale + _DetailOffset.xy);
			half4 detailY = tex2D (_DetailTex, pos.zx*_DetailScale + _DetailOffset.xy);
			half4 detailZ = tex2D (_DetailTex, pos.xy*_DetailScale + _DetailOffset.xy);
			half4 normalX = tex2D (_BumpMap, pos.zy*_BumpScale + _BumpOffset.xy);
			half4 normalY = tex2D (_BumpMap, pos.zx*_BumpScale + _BumpOffset.xy);
			half4 normalZ = tex2D (_BumpMap, pos.xy*_BumpScale + _BumpOffset.xy);
			pos = abs(pos);
			half4 detail = lerp(detailZ, detailX, pos.x);
			detail = lerp(detail, detailY, pos.y);
			half4 normal = lerp(normalZ, normalX, pos.x);
			normal = lerp(normal, normalY, pos.y);
			
			half detailLevel = IN.viewDist.x;
			half3 albedo = main.rgb * lerp(detail.rgb, 1, detailLevel);
			o.Albedo = albedo * _Color;
			half avg = lerp(detail.a, 1, detailLevel)*main.a;
          	o.Alpha = lerp(0, avg,  IN.viewDist.y);
          	o.Normal = lerp(UnpackNormal (normal),half3(0,0,1),detailLevel);
		}
		ENDCG
	
	}
	
	 
	FallBack "Diffuse"
}
