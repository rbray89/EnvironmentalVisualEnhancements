#ifndef EVE_UTILS_CG_INCLUDED
#define EVE_UTILS_CG_INCLUDED

	
	#include "UnityCG.cginc"
	#include "AutoLight.cginc"
	#include "Lighting.cginc"
	#define PI 3.1415926535897932384626
	#define INV_PI (1.0/PI)
	#define TWOPI (2.0*PI) 
	#define INV_2PI (1.0/TWOPI)
	#define SQRT_2 (1.41421356237)
	
	uniform float4x4 _MainRotation;
	uniform float4x4 _DetailRotation;
	
	inline float3 hash( float3 val )
	{
		return frac(sin(val)*123.5453);
	}
	
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
	
	inline half4 GetShereDetailMapNoLOD( sampler2D texSampler, float3 sphereVect, float detailScale)
	{
		float3 sphereVectNorm = normalize(sphereVect);
		sphereVectNorm = abs(sphereVectNorm);
		half zxlerp = step(sphereVectNorm.x,sphereVectNorm.z);
		half nylerp = step(sphereVectNorm.y,lerp(sphereVectNorm.x, sphereVectNorm.z, zxlerp));	
		half3 detailCoords = lerp(sphereVectNorm.xyz, sphereVectNorm.zxy, zxlerp);
		detailCoords = lerp(sphereVectNorm.yxz, detailCoords, nylerp);
		float4 uv;
		uv.xy = (.5*detailCoords.zy)/(abs(detailCoords.x)) *detailScale;
		uv.zw = float2(0,0);
		return tex2Dlod(texSampler, uv);	
	}
	
	inline half4 GetShereDetailMap( sampler2D texSampler, float3 sphereVect, float detailScale)
	{
		float3 sphereVectNorm = normalize(sphereVect);
	    float2 uv = GetSphereUV( sphereVectNorm, float2(0,0) )*4*detailScale;
	 	float4 uvdd = Derivatives(uv.x-.5, uv.y, sphereVectNorm);
	 	
		sphereVectNorm = abs(sphereVectNorm);
		half zxlerp = step(sphereVectNorm.x,sphereVectNorm.z);
		half nylerp = step(sphereVectNorm.y,lerp(sphereVectNorm.x, sphereVectNorm.z, zxlerp));	
		half3 detailCoords = lerp(sphereVectNorm.xyz, sphereVectNorm.zxy, zxlerp);
		detailCoords = lerp(sphereVectNorm.yxz, detailCoords, nylerp);
		return tex2D(texSampler, (.5*detailCoords.zy)/(abs(detailCoords.x)) *detailScale, uvdd.xy, uvdd.zw);	
	
	}
	
	inline float GetDistanceFade( float dist, float fade, float fadeVert )
	{
		float fadeDist = fade*dist;
		float distVert = 1-(fadeVert*dist);
		return saturate(fadeDist) * saturate(distVert);
	}
			
	inline half4 GetLighting(half3 worldNorm, half3 lightDir, fixed atten, fixed ambient)
	{
		half3 ambientLighting = ambient * UNITY_LIGHTMODEL_AMBIENT;
		half NdotL = dot (worldNorm, lightDir);
		half lightIntensity = saturate(_LightColor0.a * NdotL * 2 * atten);
		half4 light;
		light.rgb = max(ambientLighting + (_LightColor0.rgb * lightIntensity), 0);
		light.a = max(ambientLighting + lightIntensity, 0);
		
		return light;
	}
	
	// Calculates Blinn-Phong (specular) lighting model
	inline half4 SpecularColorLight( half3 lightDir, half3 viewDir, half3 normal, half4 color, half4 specColor, float specK, half atten )
	{
	    #ifndef USING_DIRECTIONAL_LIGHT
	    lightDir = normalize(lightDir);
	    #endif
	    viewDir = normalize(viewDir);
	    half3 h = normalize( lightDir + viewDir );
	    
	    half diffuse = dot( normal, lightDir );
	    
	    float nh = saturate( dot( h, normal ) );
	    float spec = pow( nh, specK ) * specColor.a;
	    
	    half4 c;
	    c.rgb = (color.rgb * _LightColor0.rgb * diffuse + _LightColor0.rgb * specColor.rgb * spec) * (atten * 4);
	    c.a = diffuse*(atten * 4);//_LightColor0.a * specColor.a * spec * atten; // specular passes by default put highlights to overbright
	    return c;
	}
	
	inline half Terminator(half3 lightDir, half3 normal)
	{
		half NdotL = dot( normal, lightDir );
		half termlerp = saturate(10*-NdotL);
		half terminator = lerp(1,saturate(floor(1.01+NdotL)), termlerp);
		return terminator;
	}
#endif