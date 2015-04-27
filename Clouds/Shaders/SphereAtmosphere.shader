Shader "Sphere/Atmosphere" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_Visibility ("Visibility", Float) = .0001
		_OceanRadius ("Ocean Radius", Float) = 63000
		_SphereRadius ("Sphere Radius", Float) = 67000
		_PlanetOrigin ("Sphere Center", Vector) = (0,0,0,1)
		_SunsetColor ("Color Sunset", Color) = (1,0,0,.45)
		_DensityRatioX ("Density RatioX", Float) = .22
		_DensityRatioY ("Density RatioY", Float) = 800
		_Scale ("Scale", Float) = 1
		_DensityRatioPow ("Density RatioPow", Float) = 1
	}

Category {
	
	Tags { "Queue"="Transparent-5" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Mode Off}
	ZTest Off
	ColorMask RGB
	Cull Front Lighting On ZWrite Off
	
SubShader {
	Pass {

		Lighting On
		Tags { "LightMode"="ForwardBase"}
		
		CGPROGRAM
		
		#include "UnityCG.cginc"
		#include "AutoLight.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma glsl
		#pragma exclude_renderers gles
		#pragma vertex vert
		#pragma fragment frag
		#pragma multi_compile_fwdbase
	    #pragma multi_compile WORLD_SPACE_OFF WORLD_SPACE_ON
		#define MAG_ONE 1.4142135623730950488016887242097
		#pragma fragmentoption ARB_precision_hint_fastest
		#define PI 3.1415926535897932384626
		#define TWO_INV_PI (2.0/PI)
		#define HALF_INV_PI (0.5/PI)
		#define TWOPI (2.0*PI) 
		#define INV_2PI (1.0/TWOPI)
	    #define FLT_MAX (1e+32)
        #define EULER_N (2.718281828459045235360)

		fixed4 _Color;
		fixed4 _SunsetColor;
		sampler2D _CameraDepthTexture;
		float _Visibility;
		float _OceanRadius;
		float _SphereRadius;
		float3 _PlanetOrigin;
		float _DensityRatioX;
		float _DensityRatioY;
		float _Scale;
		float _DensityRatioPow;
		
		struct appdata_t {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float3 normal : NORMAL;
			};

		struct v2f {
			float4 pos : SV_POSITION;
			float4 scrPos : TEXCOORD0;
			float3 worldVert : TEXCOORD1;
			LIGHTING_COORDS(2,3)
			float3 worldOrigin : TEXCOORD4;
			float3 L : TEXCOORD5;
		};	

		float atmofunc( float l, float d)
		{
		  float e = EULER_N;
		  float a = _DensityRatioX;
		  float b = _DensityRatioY;
		  
		  float l2 = l*_Visibility;
		  l2 *= l2;
		  float d2 = d/_Visibility;
		  d2 *= d2;
          float n = sqrt(l2+d2);
          
		  return -(2*a*b*(n+b)*a*pow(_DensityRatioPow*e,-n/b));
	    }		

		v2f vert (appdata_t v)
		{
			v2f o;
			UNITY_INITIALIZE_OUTPUT(v2f,o);
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			
		   float3 vertexPos = mul(_Object2World, v.vertex).xyz;
	   	   o.worldVert = vertexPos;
	   	   
	   	   
	   	   #ifdef WORLD_SPACE_ON
	   	   o.worldOrigin = _PlanetOrigin;
	   	   #else
	   	   o.worldOrigin = mul(_Object2World, fixed4(0,0,0,1)).xyz;
	   	   #endif
	   	   
	   	   o.L = o.worldOrigin - _WorldSpaceCameraPos.xyz;
	   	   o.L *= _Scale;
	   	   
	//   	   #ifdef WORLD_SPACE_ON
	   	   o.scrPos=ComputeScreenPos(o.pos);
		   COMPUTE_EYEDEPTH(o.scrPos.z);
	//	   #endif
		   
		   TRANSFER_VERTEX_TO_FRAGMENT(o);
	   	   return o;
	 	}
	 		
		fixed4 frag (v2f IN) : COLOR
			{
			half4 color = _Color;
			float depth = FLT_MAX;
	//		#ifdef WORLD_SPACE_ON
			depth = UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(IN.scrPos)));
			depth = LinearEyeDepth(depth);
	//		#else
	//		depth = LinearEyeDepth(1);
	//		#endif
			depth *= _Scale;
			
			half3 worldDir = normalize(IN.worldVert - _WorldSpaceCameraPos.xyz);
			float tc = dot(IN.L, worldDir);
			float d = sqrt(dot(IN.L,IN.L)-(tc*tc));
			float d2 = pow(d,2);
					 
					   	
	        float oceanRadius = _Scale*_OceanRadius;  	
			float oceanSphereDist = depth;
			if (d <= oceanRadius && tc >= 0.0)
			{
			   float tlc = sqrt((oceanRadius*oceanRadius)-d2);
			   oceanSphereDist = tc - tlc;
			}
			depth = min(oceanSphereDist, depth);
		   	
		   	
		   	float alt = length(IN.L);
			float td = sqrt(dot(IN.L,IN.L)-d2);
			float dist = sqrt((depth*depth)-dot(td,td));

		    
			half sphereCheck = saturate(floor(1+tc));
			float depthL = lerp(depth+td, max(0, depth-tc), sphereCheck);
			float camL = sphereCheck*tc;
			float subDepthL = lerp(td, max(0, tc-depth), sphereCheck);
			
			
			depth = atmofunc(depthL, d);
			depth -= atmofunc(0, d);
	   	    depth += atmofunc(camL, d);
	   	    depth -= atmofunc(subDepthL, d);
			
			//depth *= _Visibility;
			
			/*
			//depth = min(depth, sphereDist);
			half3 lightDirection = normalize(_WorldSpaceLightPos0);
			half NdotL = dot (norm, lightDirection);
	        fixed atten = LIGHT_ATTENUATION(IN); 
			half lightIntensity = max(0.0,_LightColor0.a * NdotL * 2 * atten);
			half3 light = max(0.0,((_LightColor0.rgb) * lightIntensity));
			NdotL = abs(NdotL);		
			half VdotL = dot (-worldDir, lightDirection);
			*/
			
			color.a *= saturate(depth);
          	return color;
		}
		ENDCG
	
		}
		
	} 
	


			
}
}
