Shader "Sphere/Atmosphere" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_Visibility ("Visibility", Float) = .0001
		_OceanRadius ("Ocean Radius", Float) = 63000
		_SphereRadius ("Sphere Radius", Float) = 67000
		_PlanetOrigin ("Sphere Center", Vector) = (0,0,0,1)
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
	    #pragma multi_compile WORLD_SPACE_OFF WORLD_SPACE_ON
		#define MAG_ONE 1.4142135623730950488016887242097
		#pragma fragmentoption ARB_precision_hint_fastest
		#define PI 3.1415926535897932384626
		#define INV_PI (1.0/PI)
		#define TWOPI (2.0*PI) 
		#define INV_2PI (1.0/TWOPI)
	    #define FLT_MAX (1e+32)

		fixed4 _Color;
		sampler2D _CameraDepthTexture;
		float _Visibility;
		float _OceanRadius;
		float _SphereRadius;
		float3 _PlanetOrigin;
		
		struct appdata_t {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float3 normal : NORMAL;
			};

		struct v2f {
			float4 pos : SV_POSITION;
			float4 scrPos : TEXCOORD0;
			float3 worldVert : TEXCOORD1;
			float3 worldOrigin : TEXCOORD2;
			float3 viewDir : TEXCOORD3;
			float  viewDist : TEXCOORD4;
			float  altitude : TEXCOORD5;
			float3 L : TEXCOORD6;
		};	
		

		v2f vert (appdata_t v)
		{
			v2f o;
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			
		   float3 vertexPos = mul(_Object2World, v.vertex).xyz;
	   	   o.worldVert = vertexPos;
	   	   o.viewDist = distance(vertexPos,_WorldSpaceCameraPos);
	   	   o.viewDir = normalize(WorldSpaceViewDir(v.vertex));
	   	   
	   	   
	   	   #ifdef WORLD_SPACE_ON
	   	   o.worldOrigin = _PlanetOrigin;
	   	   #else
	   	   o.worldOrigin = mul(_Object2World, fixed4(0,0,0,1)).xyz;;
	   	   #endif
	   	   
	   	   o.altitude = distance(o.worldOrigin,_WorldSpaceCameraPos) - _OceanRadius;
	   	   o.L = o.worldOrigin - _WorldSpaceCameraPos;
	   	   
	   	   #ifdef WORLD_SPACE_ON
	   	   o.scrPos=ComputeScreenPos(o.pos);
		   COMPUTE_EYEDEPTH(o.scrPos.z);
		   #endif
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
			float sphereDist = 0;
			
			half3 worldDir = normalize(IN.worldVert - _WorldSpaceCameraPos);
			float tc = dot(IN.L, worldDir);
			float d = sqrt(dot(IN.L,IN.L)-dot(tc,tc));
			float d2 = pow(d,2);
		   	float Llength = length(IN.L);
		   	   
			float oceanSphereDist = depth;
		   	   if (d <= _OceanRadius && tc >= 0.0)
		   	   {
			   	   float tlc = sqrt(pow(_OceanRadius,2)-d2);
			   	   oceanSphereDist = tc - tlc;
		   	   }
			depth = min(oceanSphereDist, depth);
		   	   float avgHeight = _SphereRadius; 
		   	   
		   	   if (Llength <  _SphereRadius && tc < 0.0)
		   	   {
			   	   float tlc = sqrt(pow(_SphereRadius,2)-d2);
			   	   float td = sqrt(pow(Llength,2)-d2);
			   	   sphereDist = tlc - td;
			   	   depth = min(depth, sphereDist);
			   	   float height1 = distance(_WorldSpaceCameraPos + (depth*worldDir), IN.worldOrigin);
			   	   float height2 = Llength;
		   	   	   avgHeight = .75*min(height1,height2) + .25*max(height1, height2);
		   	   }
		   	   else if (d <= _SphereRadius && tc >= 0.0)
		   	   {
			   	   float tlc = sqrt(pow(_SphereRadius,2)-d2);
			   	   half sphereCheck = saturate(_SphereRadius - Llength);
			   	   sphereDist = lerp(tc - tlc, tlc + tc, sphereCheck);
			   	   float minFar = min(tc+tlc, depth);
			   	   float oldDepth = depth;
			   	   depth = lerp( minFar - sphereDist, min(depth, sphereDist), sphereCheck);
			   	   
			   	   float height1 = distance(_WorldSpaceCameraPos + (minFar*worldDir), IN.worldOrigin);
			   	   float height2 = lerp(lerp(_SphereRadius, d, minFar-oldDepth), Llength, sphereCheck);
			   	   avgHeight = .75*min(height1,height2) + .25*max(height1, height2);
		   	   }
			depth = lerp(0, depth, saturate(sphereDist));
			
			
			//depth = min(depth, sphereDist);
			
			
			depth *= _Visibility*(1-saturate((avgHeight-_OceanRadius)/(_SphereRadius-_OceanRadius))); 
			color.a *= depth;
          	return color;
		}
		ENDCG
	
		}
		
	} 
	
}
}
