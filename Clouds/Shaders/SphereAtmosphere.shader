Shader "Sphere/Atmosphere" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_Visibility ("Visibility", Float) = .0001
		_OceanRadius ("Ocean Radius", Float) = 63000
		_SphereRadius ("Sphere Radius", Float) = 67000
		_PlanetOrigin ("Sphere Center", Vector) = (0,0,0,1)
		_SunsetColor ("Color Sunset", Color) = (1,0,0,.45)
		_DensityRatioY ("Density Ratio", Float) = 1
		_DensityRatioX ("Density Ratio", Float) = 1
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
		#pragma vertex vert
		#pragma fragment frag
		#pragma multi_compile_fwdbase
	    #pragma multi_compile WORLD_SPACE_OFF WORLD_SPACE_ON
		#define MAG_ONE 1.4142135623730950488016887242097
		#pragma fragmentoption ARB_precision_hint_fastest
		#define PI 3.1415926535897932384626
		#define INV_PI (1.0/PI)
		#define TWOPI (2.0*PI) 
		#define INV_2PI (1.0/TWOPI)
	    #define FLT_MAX (1e+32)
	    #define ONE_THIRD (.3333333333333)

		fixed4 _Color;
		fixed4 _SunsetColor;
		sampler2D _CameraDepthTexture;
		float _Visibility;
		float _OceanRadius;
		float _SphereRadius;
		float3 _PlanetOrigin;
		float _DensityRatioY;
		float _DensityRatioX;
		
		
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
		

		v2f vert (appdata_t v)
		{
			v2f o;
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			
		   float3 vertexPos = mul(_Object2World, v.vertex).xyz;
	   	   o.worldVert = vertexPos;
	   	   
	   	   
	   	   #ifdef WORLD_SPACE_ON
	   	   o.worldOrigin = _PlanetOrigin;
	   	   #else
	   	   o.worldOrigin = mul(_Object2World, fixed4(0,0,0,1)).xyz;;
	   	   #endif
	   	   
	   	   o.L = o.worldOrigin - _WorldSpaceCameraPos.xyz;
	   	   
	   	   #ifdef WORLD_SPACE_ON
	   	   o.scrPos=ComputeScreenPos(o.pos);
		   COMPUTE_EYEDEPTH(o.scrPos.z);
		   #endif
		   
		   TRANSFER_VERTEX_TO_FRAGMENT(o);
	   	   return o;
	 	}
	 		
		fixed4 frag (v2f IN) : COLOR
			{
			half4 color = _Color;
			float depth = FLT_MAX;
			#ifdef WORLD_SPACE_ON
			depth = UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(IN.scrPos)));
			depth = LinearEyeDepth(depth);
			#endif
			
			half3 worldDir = normalize(IN.worldVert - _WorldSpaceCameraPos.xyz);
			float tc = dot(IN.L, worldDir);
			float d = sqrt(dot(IN.L,IN.L)-dot(tc,tc));
			float d2 = pow(d,2);
		   	float Llength = length(IN.L);
		   	   
			float oceanSphereDist = depth;
		   	   if (d <= _OceanRadius && tc >= 0.0)
		   	   {
			   	   float tlc = sqrt((_OceanRadius*_OceanRadius)-d2);
			   	   oceanSphereDist = tc - tlc;
		   	   }
			depth = min(oceanSphereDist, depth);
		   	   
		   	   half3 norm = normalize( _WorldSpaceCameraPos - IN.worldOrigin);
		   	   float r2 = _SphereRadius*_SphereRadius;
		   	   
		   	   if (Llength <  _SphereRadius && tc < 0.0)
		   	   {
			   	   float tlc = sqrt(r2-d2);
			   	   float td = sqrt((Llength*Llength)-d2);
			   	   depth = min(depth, tlc - td);
			   	   //float3 point = _WorldSpaceCameraPos + (depth*worldDir);
			   	   //norm = normalize(point- IN.worldOrigin);
			   	   float l = depth + td;
				   d2 *= _DensityRatioY;
				   float c= _DensityRatioX;
			   	   depth = (td*(d2+((c*td*td)*ONE_THIRD)-(r2)))-(l*(d2+((c*l*l)*ONE_THIRD)-(r2)));
			   	   depth /= r2;
			   	   depth *= _Visibility;
		   	   }
		   	   else if (d <= _SphereRadius && tc >= 0.0)
		   	   {
			   	   float tlc = sqrt(r2-d2);
			   	   half sphereCheck = saturate(floor(1+_SphereRadius - Llength));
			   	   float subDepthL = max(0, tc-depth);
			   	   float depthL = min(tlc, max(0, depth-tc));
			   	   float camL = lerp(tlc, tc, sphereCheck);
			   	   d2 *= _DensityRatioY;
			   	   float c= _DensityRatioX;
			   	   depth = (subDepthL*(d2+((c*subDepthL*subDepthL)*ONE_THIRD)-(r2)));
			   	   depth += -(depthL*(d2+((c*depthL*depthL)*ONE_THIRD)-(r2)));
			   	   depth += -(camL*(d2+((c*camL*camL)*ONE_THIRD)-(r2)));
			   	   depth /= r2;
			   	   depth *= _Visibility;
		   	   }
		   	   else
		   	   {
		   	       depth = 0;
		   	   }
			
			
			//depth = min(depth, sphereDist);
			half3 lightDirection = normalize(_WorldSpaceLightPos0);
			half NdotL = dot (norm, lightDirection);
	        fixed atten = LIGHT_ATTENUATION(IN); 
			half lightIntensity = max(0.0,_LightColor0.a * NdotL * 2 * atten);
			half3 light = max(0.0,((_LightColor0.rgb) * lightIntensity));
			NdotL = abs(NdotL);		
			half VdotL = dot (-worldDir, lightDirection);
			
			color.a *= saturate(depth * max(0.0, light));
			//color.rgb = lerp(color.rgb, _SunsetColor, saturate((1-NdotL)*VdotL));
          	return color;
		}
		ENDCG
	
		}
		
	} 
	
}
}
