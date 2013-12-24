Shader "Particles/CloudShader" {
	Properties {
		_Color ("Tint Color", Color) = (1,1,1,1)
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_BumpMap ("Bumpmap", 2D) = "bump" {}
		_MinLight ("Minimum Light", Range(0,1)) = .16
		_NormScale ("Normal Scale", Range(0,1)) = .5
	}

SubShader {
		Tags {  "Queue"="Transparent"
	   			"RenderMode"="Transparent" }
		Lighting On
	    ZWrite Off
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#pragma surface surf SimpleLambert vertex:vert noforwardadd novertexlights nolightmap nodirlightmap

		sampler2D _MainTex;
		sampler2D _BumpMap;
		fixed4 _Color;
		float _MinLight;
		float _NormScale;
		
		struct WorldSurfaceOutput {
			half3 Albedo;
		    half3 Normal;
		    half3 Emission;
		    half3 Specular;
		    half Alpha;
		};
		
		half4 LightingSimpleLambert (WorldSurfaceOutput s, half3 lightDir, half atten) {
			float4 light4 = lightDir.xyzz;
			float3 worldLightDir = mul(UNITY_MATRIX_MVP, light4).xyz;
			half CdotL = lerp(saturate(dot (s.Specular, worldLightDir)),saturate(dot (s.Normal, lightDir)),_NormScale);
	        half4 c;
	        c.rgb = s.Albedo * saturate(_MinLight+ _LightColor0.rgb * (CdotL * atten * 2));
	        c.a = s.Alpha;
	        return c;
      	}
		
		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
			half3  cameraVector;
			half4 color;
		};

		void vert (inout appdata_full v, out Input o) {
		   UNITY_INITIALIZE_OUTPUT(Input, o);
		   float3 vertexPos = mul(UNITY_MATRIX_MVP, v.vertex).xyz;
		   o.cameraVector = normalize(-vertexPos);
		   o.color = v.color;
	 	}

		void surf (Input IN, inout WorldSurfaceOutput o) {
			half4 main = tex2D (_MainTex, IN.uv_MainTex);
			half3 albedo = main.rgb;
			o.Albedo = albedo * _Color.rgb*IN.color.rgb;
			o.Specular = IN.cameraVector;
			o.Normal = tex2D (_BumpMap, IN.uv_BumpMap);
          	o.Alpha = main.a*_Color.a*IN.color.a;
          	o.Emission = 0;//half3(0,0,0);
		}
		ENDCG
	
	}
	
	 
	FallBack "Diffuse"
}

