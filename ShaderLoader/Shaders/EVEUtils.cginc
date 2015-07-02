#ifndef EVE_UTILS_CG_INCLUDED
#define EVE_UTILS_CG_INCLUDED

	
	#include "UnityCG.cginc"
	#define PI 3.1415926535897932384626
	#define INV_PI (1.0/PI)
	#define TWOPI (2.0*PI) 
	#define INV_2PI (1.0/TWOPI)
		
	
	uniform float4x4 _MainRotation;
	uniform float4x4 _DetailRotation;
		
	inline float4 Derivatives( float lat, float lon, float3 pos)  
	{  
	    float2 latLong = float2( lat, lon );  
	    float latDdx = INV_2PI*length( ddx( pos.xz ) );  
	    float latDdy = INV_2PI*length( ddy( pos.xz ) );  
	    float longDdx = ddx( lon );  
	    float longDdy = ddy( lon );  
	 	
	    return float4( latDdx , longDdx , latDdy, longDdy );  
	} 

    inline float2 GetSphereUV( float3 sphereVect, float2 uvOffset )
    {
      float2 uv;
      uv.x = .5 + (INV_2PI*atan2(sphereVect.x, sphereVect.z));
	  uv.y = INV_PI*acos(sphereVect.y);
	  uv += uvOffset;
	  return uv;
    }

	inline half4 GetSphereMapNoLOD( sampler2D texSampler, float3 sphereVect)  
	{  
	    float4 uv;
	    float3 sphereVectNorm = normalize(sphereVect);
	    uv.xy = GetSphereUV( sphereVectNorm, float2(0,0) );
	    uv.zw = float2(0,0);
	    half4 tex = tex2Dlod(texSampler, uv);
	    return tex;
	} 
	
	inline half4 GetSphereMap( sampler2D texSampler, float3 sphereVect)  
	{  
	    float3 sphereVectNorm = normalize(sphereVect);
	    float2 uv = GetSphereUV( sphereVectNorm, float2(0,0) );
	 	
	 	float4 uvdd = Derivatives(uv.x-.5, uv.y, sphereVectNorm);
	    half4 tex = tex2D(texSampler, uv, uvdd.xy, uvdd.zw);
	    return tex;
	} 
			
#endif