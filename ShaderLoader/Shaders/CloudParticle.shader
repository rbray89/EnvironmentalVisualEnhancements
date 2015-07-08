Shader "EVE/CloudParticle" {
Properties {
	_TopTex ("Particle Texture", 2D) = "white" {}
	_LeftTex ("Particle Texture", 2D) = "white" {}
	_FrontTex ("Particle Texture", 2D) = "white" {}
	_MainTex ("Main (RGB)", 2D) = "white" {}
	_DetailTex ("Detail (RGB)", 2D) = "white" {}
	_DetailScale ("Detail Scale", Range(0,1000)) = 100
	_DistFade ("Distance Fade Near", Range(0,1)) = 1.0
	_DistFadeVert ("Distance Fade Vertical", Range(0,1)) = 0.00004
	_LightScatter ("Light Scatter", Range(0,1)) = 0.55 
	_MinLight ("Minimum Light", Range(0,1)) = .5
	_Color ("Color Tint", Color) = (1,1,1,1)
	_InvFade ("Soft Particles Factor", Range(0.01,3.0)) = .01
	_Rotation ("Rotation", float) = 0
	_MaxScale ("Max Scale", float) = 1
	_MaxTrans ("Max Translation", Vector) = (0,0,0)
}

Category {
	
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Mode Global}
	AlphaTest Greater 0
	ColorMask RGB
	Cull Off Lighting On ZWrite Off
	
	SubShader {
		Pass {
			
			Lighting On
			Tags { "LightMode"="ForwardBase"}
			
			CGPROGRAM
			#include "EVEUtils.cginc"
			#include "UnityCG.cginc"
			#include "AutoLight.cginc"
			#include "Lighting.cginc"
			
			#pragma target 3.0
			#pragma glsl
			#pragma vertex vert
			#pragma fragment frag
			#define MAG_ONE 1.4142135623730950488016887242097
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma multi_compile_fwdbase
			#pragma multi_compile_fwdadd_fullshadows
			
			
			
			sampler2D _TopTex;
			sampler2D _LeftTex;
			sampler2D _FrontTex;
			sampler2D _MainTex;
			sampler2D _DetailTex;
			float _DetailScale;
			fixed4 _Color;
			float _DistFade;
			float _DistFadeVert;
			float _LightScatter;
			float _MinLight;
			float _InvFade;
			float _Rotation;
			float _MaxScale;
			float3 _MaxTrans;
			
			sampler2D _CameraDepthTexture;
			
			
			
			struct appdata_t {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 pos : SV_POSITION;
				fixed4 color : COLOR;
				float3 viewDir : TEXCOORD0;
				float2 texcoordZY : TEXCOORD1;
				float2 texcoordXZ : TEXCOORD2;
				float2 texcoordXY : TEXCOORD3;
				float3 camPos : TEXCOORD4;
				half3 baseLight : TEXCOORD5;
				LIGHTING_COORDS(6,7)
				float4 projPos : TEXCOORD8;
			};
			
			/*=========================================================================*
		 *  R A N D _ R O T A T I O N      Author: Jim Arvo, 1991                  *
		 *                                                                         *
		 *  This routine maps three values (x[0], x[1], x[2]) in the range [0,1]   *
		 *  into a 3x3 rotation matrix, M.  Uniformly distributed random variables *
		 *  x0, x1, and x2 create uniformly distributed random rotation matrices.  *
		 *  To create small uniformly distributed "perturbations", supply          *
		 *  samples in the following ranges                                        *
		 *                                                                         *
		 *      x[0] in [ 0, d ]                                                   *
		 *      x[1] in [ 0, 1 ]                                                   *
		 *      x[2] in [ 0, d ]                                                   *
		 *                                                                         *
		 * where 0 < d < 1 controls the size of the perturbation.  Any of the      *
		 * random variables may be stratified (or "jittered") for a slightly more  *
		 * even distribution.                                                      *
		 *                                                                         *
		 *=========================================================================*/
		float4x4 rand_rotation( float3 x, float scale, float3 trans)
		    {
		    float theta = x[0] * TWOPI; /* Rotation about the pole (Z).      */
		    float phi   = x[1] * TWOPI; /* For direction of pole deflection. */
		    float z     = x[2] * 2.0;      /* For magnitude of pole deflection. */

		    /* Compute a vector V used for distributing points over the sphere  */
		    /* via the reflection I - V Transpose(V).  This formulation of V    */
		    /* will guarantee that if x[1] and x[2] are uniformly distributed,  */
		    /* the reflected points will be uniform on the sphere.  Note that V */
		    /* has length sqrt(2) to eliminate the 2 in the Householder matrix. */

		    float r  = sqrt( z );
		    float Vx = sin( phi ) * r;
		    float Vy = cos( phi ) * r;
		    float Vz = sqrt( 2.0 - z );    

		    /* Compute the row vector S = Transpose(V) * R, where R is a simple */
		    /* rotation by theta about the z-axis.  No need to compute Sz since */
		    /* it's just Vz.                                                    */

		    float st = sin( theta );
		    float ct = cos( theta );
		    float Sx = Vx * ct - Vy * st;
		    float Sy = Vx * st + Vy * ct;

		    /* Construct the rotation matrix  ( V Transpose(V) - I ) R, which   */
		    /* is equivalent to V S - R.                                        */

		    
		    float4x4 M = float4x4( 
		    	scale*(Vx * Sx - ct), Vy * Sx + st, Vz * Sx,	trans.x,
		    	Vx * Sy - st, scale*(Vy * Sy - ct), Vz * Sy,	trans.y,
		    	Vx * Vz, 	  Vy * Vz,		scale*(1.0 - z),	trans.z,
		    	0,			  0, 			0, 			1);
		    
		    return M;
		    }
			
			v2f vert (appdata_t v)
			{
				
	              
				v2f o;
				
				float4 origin = mul(_Object2World, float4(0,0,0,1));
				
				float4 planet_pos = -mul(_MainRotation, origin);
				float3 hashVect = abs(hash(normalize(floor(planet_pos.xyz))));
				
				float4 localOrigin;
				localOrigin.xyz = (2*hashVect-1)*_MaxTrans;
				localOrigin.w = 1;
				float localScale = (hashVect.x*(_MaxScale-1))+1;
				
				
				origin = mul(_Object2World, localOrigin);
				
				float3 worldNormal = normalize(mul( _Object2World, float4( v.normal, 0.0 ) ).xyz);
				half3 ambientLighting = UNITY_LIGHTMODEL_AMBIENT;
				half3 lightDirection = normalize(_WorldSpaceLightPos0);
 				half NdotL = saturate(dot (worldNormal, lightDirection));
		        half diff = (NdotL - 0.01) / 0.99;
				half lightIntensity = saturate(_LightColor0.a * diff * 4);
				o.baseLight = saturate(ambientLighting + ((_MinLight + _LightColor0.rgb) * lightIntensity));
				
				planet_pos = -mul(_MainRotation, origin);
				float3 detail_pos = mul(_DetailRotation, planet_pos).xyz;
				//o.color = v.color;
				o.color = GetSphereMapNoLOD( _MainTex, planet_pos.xyz); 
				o.color *= GetShereDetailMapNoLOD(_DetailTex, detail_pos, _DetailScale);
				
				o.color.a *= GetDistanceFade(distance(origin,_WorldSpaceCameraPos), _DistFade, _DistFadeVert);
				
				float4x4 M = rand_rotation(
					(float3(frac(_Rotation),0,0))+hashVect,
					localScale,
					localOrigin.xyz);
				float4x4 mvMatrix = mul(mul(UNITY_MATRIX_V, _Object2World), M);
				
				float3 viewDir = normalize(mvMatrix[2].xyz);
				o.viewDir = abs(viewDir);
				
				
				float4 mvCenter = mul(UNITY_MATRIX_MV, localOrigin);
				o.pos = mul(UNITY_MATRIX_P, 
	              mvCenter
	              + float4(v.vertex.xyz*localScale,v.vertex.w));
				
				o.camPos = normalize(_WorldSpaceCameraPos.xyz - mul(_Object2World, localOrigin).xyz);

				float2 texcoodOffsetxy = ((2*v.texcoord)- 1);
				float4 texcoordOffset = float4(texcoodOffsetxy.x, texcoodOffsetxy.y, 0, v.vertex.w);
				
				float4 ZYv = texcoordOffset.zyxw;
				float4 XZv = texcoordOffset.xzyw;
				float4 XYv = texcoordOffset.xyzw;
				
				ZYv.z*=sign(-viewDir.x);
				XZv.x*=sign(-viewDir.y);
				XYv.x*=sign(viewDir.z);
				
				ZYv.x += sign(-viewDir.x)*sign(ZYv.z)*(viewDir.z);
				XZv.y += sign(-viewDir.y)*sign(XZv.x)*(viewDir.x);
				XYv.z += sign(-viewDir.z)*sign(XYv.x)*(viewDir.x);
				
				ZYv.x += sign(-viewDir.x)*sign(ZYv.y)*(viewDir.y);
				XZv.y += sign(-viewDir.y)*sign(XZv.z)*(viewDir.z);
				XYv.z += sign(-viewDir.z)*sign(XYv.y)*(viewDir.y);
				
				float2 ZY = mul(mvMatrix, ZYv).xy - mvCenter.xy;
				float2 XZ = mul(mvMatrix, XZv).xy - mvCenter.xy;
				float2 XY = mul(mvMatrix, XYv).xy - mvCenter.xy;	
																			
				o.texcoordZY = half2(.5 ,.5) + .6*(ZY);
				o.texcoordXZ = half2(.5 ,.5) + .6*(XZ);
				o.texcoordXY = half2(.5 ,.5) + .6*(XY);
				
				o.projPos = ComputeScreenPos (o.pos);
				COMPUTE_EYEDEPTH(o.projPos.z);
				TRANSFER_VERTEX_TO_FRAGMENT(o);
				
				return o;
			}
			
			fixed4 frag (v2f IN) : COLOR
			{
				
				half xval = IN.viewDir.x;
				half4 xtex = tex2D(_LeftTex, IN.texcoordZY);
				half yval = IN.viewDir.y;				
				half4 ytex = tex2D(_TopTex, IN.texcoordXZ);
				half zval = IN.viewDir.z;
				half4 ztex = tex2D(_FrontTex, IN.texcoordXY);
				
				//half4 tex = (xtex*xval)+(ytex*yval)+(ztex*zval);
				half4 tex = lerp(lerp(xtex, ytex, yval), ztex, zval);
				
				half4 prev = .94*_Color * IN.color * tex;
				
//				float3 lightColor = _LightColor0.rgb;
//		        float3 lightDir = normalize(_WorldSpaceLightPos0);
//		        
//		        float  atten = LIGHT_ATTENUATION(i);
//		        float  NL = saturate(.5*(1+dot(IN.camPos, lightDir)));
//				float  lightIntensity = saturate(_LightColor0.a * (NL * atten * 4));
//		 		float  lightScatter = saturate(1-(lightIntensity*_LightScatter*prev.a));
		 		
		        half4 color;
		        color.rgb = prev.rgb * IN.baseLight;
				color.a = prev.a;
				
				float depth = UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(IN.projPos)));
				depth = LinearEyeDepth (depth);
				float partZ = IN.projPos.z;
				float fade = saturate (_InvFade * (depth-partZ));
				color.a *= fade;
				
				return color;
			}
			ENDCG 
		}
		
	} 
	
}
}