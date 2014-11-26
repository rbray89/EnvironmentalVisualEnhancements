Shader "Sphere/Atmosphere" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_Visibility ("Visibility", Float) = .0001
		_OceanRadius ("Ocean Radius", Float) = 63000
		_SphereRadius ("Sphere Radius", Float) = 67000
		_PlanetOrigin ("Sphere Center", Vector) = (0,0,0,1)
		_SunsetColor ("Color Sunset", Color) = (1,0,0,.45)
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
		
		Program "vp" {
// Vertex combos: 24
//   d3d9 - ALU: 23 to 33
SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying float xlv_TEXCOORD7;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _OceanRadius;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 norm_1;
  float avgHeight_2;
  float oceanSphereDist_3;
  float sphereDist_4;
  float depth_5;
  vec4 color_6;
  color_6 = _Color;
  depth_5 = 1e+32;
  sphereDist_4 = 0.0;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD8, tmpvar_7);
  float tmpvar_9;
  tmpvar_9 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_8 * tmpvar_8)));
  float tmpvar_10;
  tmpvar_10 = pow (tmpvar_9, 2.0);
  float tmpvar_11;
  tmpvar_11 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_3 = 1e+32;
  if (((tmpvar_9 <= _OceanRadius) && (tmpvar_8 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_8 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_10)));
  };
  float tmpvar_12;
  tmpvar_12 = min (oceanSphereDist_3, 1e+32);
  depth_5 = tmpvar_12;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_11 < _SphereRadius) && (tmpvar_8 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_10)) - sqrt((pow (tmpvar_11, 2.0) - tmpvar_10)));
    sphereDist_4 = tmpvar_13;
    float tmpvar_14;
    tmpvar_14 = min (tmpvar_12, tmpvar_13);
    depth_5 = tmpvar_14;
    vec3 tmpvar_15;
    tmpvar_15 = (_WorldSpaceCameraPos + (tmpvar_14 * tmpvar_7));
    norm_1 = normalize((tmpvar_15 - xlv_TEXCOORD4));
    float tmpvar_16;
    vec3 p_17;
    p_17 = (tmpvar_15 - xlv_TEXCOORD4);
    tmpvar_16 = sqrt(dot (p_17, p_17));
    avgHeight_2 = ((0.75 * min (tmpvar_16, tmpvar_11)) + (0.25 * max (tmpvar_16, tmpvar_11)));
  } else {
    if (((tmpvar_9 <= _SphereRadius) && (tmpvar_8 >= 0.0))) {
      float oldDepth_18;
      float tmpvar_19;
      tmpvar_19 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_10));
      float tmpvar_20;
      tmpvar_20 = clamp ((_SphereRadius - tmpvar_11), 0.0, 1.0);
      float tmpvar_21;
      tmpvar_21 = mix ((tmpvar_8 - tmpvar_19), (tmpvar_19 + tmpvar_8), tmpvar_20);
      sphereDist_4 = tmpvar_21;
      float tmpvar_22;
      tmpvar_22 = min ((tmpvar_8 + tmpvar_19), depth_5);
      oldDepth_18 = depth_5;
      float tmpvar_23;
      tmpvar_23 = min (depth_5, tmpvar_21);
      norm_1 = normalize(((_WorldSpaceCameraPos + (tmpvar_23 * tmpvar_7)) - xlv_TEXCOORD4));
      depth_5 = mix ((tmpvar_22 - tmpvar_21), min (tmpvar_23, tmpvar_21), tmpvar_20);
      float tmpvar_24;
      vec3 p_25;
      p_25 = ((_WorldSpaceCameraPos + (tmpvar_22 * tmpvar_7)) - xlv_TEXCOORD4);
      tmpvar_24 = sqrt(dot (p_25, p_25));
      float tmpvar_26;
      tmpvar_26 = mix (mix (_SphereRadius, tmpvar_9, (tmpvar_22 - oldDepth_18)), tmpvar_11, tmpvar_20);
      avgHeight_2 = ((0.75 * min (tmpvar_24, tmpvar_26)) + (0.25 * max (tmpvar_24, tmpvar_26)));
    };
  };
  float tmpvar_27;
  tmpvar_27 = (mix (0.0, depth_5, clamp (sphereDist_4, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_5 = tmpvar_27;
  color_6.w = (_Color.w * (tmpvar_27 * max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_1, normalize(_WorldSpaceLightPos0).xyz)) * 4.0), 0.0, 1.0)).x))));
  gl_FragData[0] = color_6;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Float 9 [_OceanRadius]
"vs_3_0
; 23 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord4 o2
dcl_texcoord5 o3
dcl_texcoord6 o4
dcl_texcoord7 o5
dcl_texcoord8 o6
dcl_position0 v0
dp4 r1.x, v0, c4
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
add r2.xyz, -r1, c8
dp3 r0.x, r2, r2
rsq r0.w, r0.x
mov r0.x, c4.w
mov r0.z, c6.w
mov r0.y, c5.w
add r3.xyz, -r0, c8
dp3 r1.w, r3, r3
mov o1.xyz, r1
rsq r1.x, r1.w
mov o2.xyz, r0
rcp r0.x, r1.x
mul o3.xyz, r0.w, r2
rcp o4.x, r0.w
add o5.x, r0, -c9
mov o6.xyz, -r3
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0), 0.0, 1.0)).x));
  highp float tmpvar_36;
  tmpvar_36 = (color_9.w * (tmpvar_34 * tmpvar_35));
  color_9.w = tmpvar_36;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0), 0.0, 1.0)).x));
  highp float tmpvar_36;
  tmpvar_36 = (color_9.w * (tmpvar_34 * tmpvar_35));
  color_9.w = tmpvar_36;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 393
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 397
uniform highp vec3 _PlanetOrigin;
#line 417
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 417
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 421
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 425
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    #line 430
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 393
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 397
uniform highp vec3 _PlanetOrigin;
#line 417
#line 432
lowp vec4 frag( in v2f IN ) {
    #line 434
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 438
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 442
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 446
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 450
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 454
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        #line 458
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 465
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 469
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 473
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 478
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = 1.0;
    #line 482
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 486
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying float xlv_TEXCOORD7;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _OceanRadius;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 norm_1;
  float avgHeight_2;
  float oceanSphereDist_3;
  float sphereDist_4;
  float depth_5;
  vec4 color_6;
  color_6 = _Color;
  depth_5 = 1e+32;
  sphereDist_4 = 0.0;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD8, tmpvar_7);
  float tmpvar_9;
  tmpvar_9 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_8 * tmpvar_8)));
  float tmpvar_10;
  tmpvar_10 = pow (tmpvar_9, 2.0);
  float tmpvar_11;
  tmpvar_11 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_3 = 1e+32;
  if (((tmpvar_9 <= _OceanRadius) && (tmpvar_8 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_8 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_10)));
  };
  float tmpvar_12;
  tmpvar_12 = min (oceanSphereDist_3, 1e+32);
  depth_5 = tmpvar_12;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_11 < _SphereRadius) && (tmpvar_8 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_10)) - sqrt((pow (tmpvar_11, 2.0) - tmpvar_10)));
    sphereDist_4 = tmpvar_13;
    float tmpvar_14;
    tmpvar_14 = min (tmpvar_12, tmpvar_13);
    depth_5 = tmpvar_14;
    vec3 tmpvar_15;
    tmpvar_15 = (_WorldSpaceCameraPos + (tmpvar_14 * tmpvar_7));
    norm_1 = normalize((tmpvar_15 - xlv_TEXCOORD4));
    float tmpvar_16;
    vec3 p_17;
    p_17 = (tmpvar_15 - xlv_TEXCOORD4);
    tmpvar_16 = sqrt(dot (p_17, p_17));
    avgHeight_2 = ((0.75 * min (tmpvar_16, tmpvar_11)) + (0.25 * max (tmpvar_16, tmpvar_11)));
  } else {
    if (((tmpvar_9 <= _SphereRadius) && (tmpvar_8 >= 0.0))) {
      float oldDepth_18;
      float tmpvar_19;
      tmpvar_19 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_10));
      float tmpvar_20;
      tmpvar_20 = clamp ((_SphereRadius - tmpvar_11), 0.0, 1.0);
      float tmpvar_21;
      tmpvar_21 = mix ((tmpvar_8 - tmpvar_19), (tmpvar_19 + tmpvar_8), tmpvar_20);
      sphereDist_4 = tmpvar_21;
      float tmpvar_22;
      tmpvar_22 = min ((tmpvar_8 + tmpvar_19), depth_5);
      oldDepth_18 = depth_5;
      float tmpvar_23;
      tmpvar_23 = min (depth_5, tmpvar_21);
      norm_1 = normalize(((_WorldSpaceCameraPos + (tmpvar_23 * tmpvar_7)) - xlv_TEXCOORD4));
      depth_5 = mix ((tmpvar_22 - tmpvar_21), min (tmpvar_23, tmpvar_21), tmpvar_20);
      float tmpvar_24;
      vec3 p_25;
      p_25 = ((_WorldSpaceCameraPos + (tmpvar_22 * tmpvar_7)) - xlv_TEXCOORD4);
      tmpvar_24 = sqrt(dot (p_25, p_25));
      float tmpvar_26;
      tmpvar_26 = mix (mix (_SphereRadius, tmpvar_9, (tmpvar_22 - oldDepth_18)), tmpvar_11, tmpvar_20);
      avgHeight_2 = ((0.75 * min (tmpvar_24, tmpvar_26)) + (0.25 * max (tmpvar_24, tmpvar_26)));
    };
  };
  float tmpvar_27;
  tmpvar_27 = (mix (0.0, depth_5, clamp (sphereDist_4, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_5 = tmpvar_27;
  color_6.w = (_Color.w * (tmpvar_27 * max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_1, normalize(_WorldSpaceLightPos0).xyz)) * 4.0), 0.0, 1.0)).x))));
  gl_FragData[0] = color_6;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Float 9 [_OceanRadius]
"vs_3_0
; 23 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord4 o2
dcl_texcoord5 o3
dcl_texcoord6 o4
dcl_texcoord7 o5
dcl_texcoord8 o6
dcl_position0 v0
dp4 r1.x, v0, c4
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
add r2.xyz, -r1, c8
dp3 r0.x, r2, r2
rsq r0.w, r0.x
mov r0.x, c4.w
mov r0.z, c6.w
mov r0.y, c5.w
add r3.xyz, -r0, c8
dp3 r1.w, r3, r3
mov o1.xyz, r1
rsq r1.x, r1.w
mov o2.xyz, r0
rcp r0.x, r1.x
mul o3.xyz, r0.w, r2
rcp o4.x, r0.w
add o5.x, r0, -c9
mov o6.xyz, -r3
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0), 0.0, 1.0)).x));
  highp float tmpvar_36;
  tmpvar_36 = (color_9.w * (tmpvar_34 * tmpvar_35));
  color_9.w = tmpvar_36;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0), 0.0, 1.0)).x));
  highp float tmpvar_36;
  tmpvar_36 = (color_9.w * (tmpvar_34 * tmpvar_35));
  color_9.w = tmpvar_36;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 393
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 397
uniform highp vec3 _PlanetOrigin;
#line 417
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 417
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 421
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 425
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    #line 430
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 393
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 397
uniform highp vec3 _PlanetOrigin;
#line 417
#line 432
lowp vec4 frag( in v2f IN ) {
    #line 434
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 438
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 442
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 446
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 450
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 454
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        #line 458
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 465
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 469
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 473
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 478
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = 1.0;
    #line 482
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 486
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying float xlv_TEXCOORD7;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _OceanRadius;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 norm_1;
  float avgHeight_2;
  float oceanSphereDist_3;
  float sphereDist_4;
  float depth_5;
  vec4 color_6;
  color_6 = _Color;
  depth_5 = 1e+32;
  sphereDist_4 = 0.0;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD8, tmpvar_7);
  float tmpvar_9;
  tmpvar_9 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_8 * tmpvar_8)));
  float tmpvar_10;
  tmpvar_10 = pow (tmpvar_9, 2.0);
  float tmpvar_11;
  tmpvar_11 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_3 = 1e+32;
  if (((tmpvar_9 <= _OceanRadius) && (tmpvar_8 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_8 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_10)));
  };
  float tmpvar_12;
  tmpvar_12 = min (oceanSphereDist_3, 1e+32);
  depth_5 = tmpvar_12;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_11 < _SphereRadius) && (tmpvar_8 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_10)) - sqrt((pow (tmpvar_11, 2.0) - tmpvar_10)));
    sphereDist_4 = tmpvar_13;
    float tmpvar_14;
    tmpvar_14 = min (tmpvar_12, tmpvar_13);
    depth_5 = tmpvar_14;
    vec3 tmpvar_15;
    tmpvar_15 = (_WorldSpaceCameraPos + (tmpvar_14 * tmpvar_7));
    norm_1 = normalize((tmpvar_15 - xlv_TEXCOORD4));
    float tmpvar_16;
    vec3 p_17;
    p_17 = (tmpvar_15 - xlv_TEXCOORD4);
    tmpvar_16 = sqrt(dot (p_17, p_17));
    avgHeight_2 = ((0.75 * min (tmpvar_16, tmpvar_11)) + (0.25 * max (tmpvar_16, tmpvar_11)));
  } else {
    if (((tmpvar_9 <= _SphereRadius) && (tmpvar_8 >= 0.0))) {
      float oldDepth_18;
      float tmpvar_19;
      tmpvar_19 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_10));
      float tmpvar_20;
      tmpvar_20 = clamp ((_SphereRadius - tmpvar_11), 0.0, 1.0);
      float tmpvar_21;
      tmpvar_21 = mix ((tmpvar_8 - tmpvar_19), (tmpvar_19 + tmpvar_8), tmpvar_20);
      sphereDist_4 = tmpvar_21;
      float tmpvar_22;
      tmpvar_22 = min ((tmpvar_8 + tmpvar_19), depth_5);
      oldDepth_18 = depth_5;
      float tmpvar_23;
      tmpvar_23 = min (depth_5, tmpvar_21);
      norm_1 = normalize(((_WorldSpaceCameraPos + (tmpvar_23 * tmpvar_7)) - xlv_TEXCOORD4));
      depth_5 = mix ((tmpvar_22 - tmpvar_21), min (tmpvar_23, tmpvar_21), tmpvar_20);
      float tmpvar_24;
      vec3 p_25;
      p_25 = ((_WorldSpaceCameraPos + (tmpvar_22 * tmpvar_7)) - xlv_TEXCOORD4);
      tmpvar_24 = sqrt(dot (p_25, p_25));
      float tmpvar_26;
      tmpvar_26 = mix (mix (_SphereRadius, tmpvar_9, (tmpvar_22 - oldDepth_18)), tmpvar_11, tmpvar_20);
      avgHeight_2 = ((0.75 * min (tmpvar_24, tmpvar_26)) + (0.25 * max (tmpvar_24, tmpvar_26)));
    };
  };
  float tmpvar_27;
  tmpvar_27 = (mix (0.0, depth_5, clamp (sphereDist_4, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_5 = tmpvar_27;
  color_6.w = (_Color.w * (tmpvar_27 * max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_1, normalize(_WorldSpaceLightPos0).xyz)) * 4.0), 0.0, 1.0)).x))));
  gl_FragData[0] = color_6;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Float 9 [_OceanRadius]
"vs_3_0
; 23 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord4 o2
dcl_texcoord5 o3
dcl_texcoord6 o4
dcl_texcoord7 o5
dcl_texcoord8 o6
dcl_position0 v0
dp4 r1.x, v0, c4
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
add r2.xyz, -r1, c8
dp3 r0.x, r2, r2
rsq r0.w, r0.x
mov r0.x, c4.w
mov r0.z, c6.w
mov r0.y, c5.w
add r3.xyz, -r0, c8
dp3 r1.w, r3, r3
mov o1.xyz, r1
rsq r1.x, r1.w
mov o2.xyz, r0
rcp r0.x, r1.x
mul o3.xyz, r0.w, r2
rcp o4.x, r0.w
add o5.x, r0, -c9
mov o6.xyz, -r3
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0), 0.0, 1.0)).x));
  highp float tmpvar_36;
  tmpvar_36 = (color_9.w * (tmpvar_34 * tmpvar_35));
  color_9.w = tmpvar_36;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0), 0.0, 1.0)).x));
  highp float tmpvar_36;
  tmpvar_36 = (color_9.w * (tmpvar_34 * tmpvar_35));
  color_9.w = tmpvar_36;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 393
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 397
uniform highp vec3 _PlanetOrigin;
#line 417
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 417
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 421
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 425
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    #line 430
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 393
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 397
uniform highp vec3 _PlanetOrigin;
#line 417
#line 432
lowp vec4 frag( in v2f IN ) {
    #line 434
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 438
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 442
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 446
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 450
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 454
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        #line 458
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 465
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 469
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 473
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 478
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = 1.0;
    #line 482
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 486
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying float xlv_TEXCOORD7;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _OceanRadius;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  vec4 o_7;
  vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_6, p_6)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_5 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 norm_1;
  float avgHeight_2;
  float oceanSphereDist_3;
  float sphereDist_4;
  float depth_5;
  vec4 color_6;
  color_6 = _Color;
  depth_5 = 1e+32;
  sphereDist_4 = 0.0;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD8, tmpvar_7);
  float tmpvar_9;
  tmpvar_9 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_8 * tmpvar_8)));
  float tmpvar_10;
  tmpvar_10 = pow (tmpvar_9, 2.0);
  float tmpvar_11;
  tmpvar_11 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_3 = 1e+32;
  if (((tmpvar_9 <= _OceanRadius) && (tmpvar_8 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_8 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_10)));
  };
  float tmpvar_12;
  tmpvar_12 = min (oceanSphereDist_3, 1e+32);
  depth_5 = tmpvar_12;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_11 < _SphereRadius) && (tmpvar_8 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_10)) - sqrt((pow (tmpvar_11, 2.0) - tmpvar_10)));
    sphereDist_4 = tmpvar_13;
    float tmpvar_14;
    tmpvar_14 = min (tmpvar_12, tmpvar_13);
    depth_5 = tmpvar_14;
    vec3 tmpvar_15;
    tmpvar_15 = (_WorldSpaceCameraPos + (tmpvar_14 * tmpvar_7));
    norm_1 = normalize((tmpvar_15 - xlv_TEXCOORD4));
    float tmpvar_16;
    vec3 p_17;
    p_17 = (tmpvar_15 - xlv_TEXCOORD4);
    tmpvar_16 = sqrt(dot (p_17, p_17));
    avgHeight_2 = ((0.75 * min (tmpvar_16, tmpvar_11)) + (0.25 * max (tmpvar_16, tmpvar_11)));
  } else {
    if (((tmpvar_9 <= _SphereRadius) && (tmpvar_8 >= 0.0))) {
      float oldDepth_18;
      float tmpvar_19;
      tmpvar_19 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_10));
      float tmpvar_20;
      tmpvar_20 = clamp ((_SphereRadius - tmpvar_11), 0.0, 1.0);
      float tmpvar_21;
      tmpvar_21 = mix ((tmpvar_8 - tmpvar_19), (tmpvar_19 + tmpvar_8), tmpvar_20);
      sphereDist_4 = tmpvar_21;
      float tmpvar_22;
      tmpvar_22 = min ((tmpvar_8 + tmpvar_19), depth_5);
      oldDepth_18 = depth_5;
      float tmpvar_23;
      tmpvar_23 = min (depth_5, tmpvar_21);
      norm_1 = normalize(((_WorldSpaceCameraPos + (tmpvar_23 * tmpvar_7)) - xlv_TEXCOORD4));
      depth_5 = mix ((tmpvar_22 - tmpvar_21), min (tmpvar_23, tmpvar_21), tmpvar_20);
      float tmpvar_24;
      vec3 p_25;
      p_25 = ((_WorldSpaceCameraPos + (tmpvar_22 * tmpvar_7)) - xlv_TEXCOORD4);
      tmpvar_24 = sqrt(dot (p_25, p_25));
      float tmpvar_26;
      tmpvar_26 = mix (mix (_SphereRadius, tmpvar_9, (tmpvar_22 - oldDepth_18)), tmpvar_11, tmpvar_20);
      avgHeight_2 = ((0.75 * min (tmpvar_24, tmpvar_26)) + (0.25 * max (tmpvar_24, tmpvar_26)));
    };
  };
  float tmpvar_27;
  tmpvar_27 = (mix (0.0, depth_5, clamp (sphereDist_4, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_5 = tmpvar_27;
  color_6.w = (_Color.w * (tmpvar_27 * max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_1, normalize(_WorldSpaceLightPos0).xyz)) * 4.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x), 0.0, 1.0)).x))));
  gl_FragData[0] = color_6;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Matrix 4 [_Object2World]
Float 11 [_OceanRadius]
"vs_3_0
; 28 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
dcl_texcoord6 o5
dcl_texcoord7 o6
dcl_texcoord8 o7
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c12.x
mov o0, r0
mul r1.y, r1, c9.x
mad o2.xy, r1.z, c10.zwzw, r1
mov o2.zw, r0
dp4 r1.x, v0, c4
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
add r2.xyz, -r1, c8
dp3 r0.x, r2, r2
rsq r0.w, r0.x
mov r0.x, c4.w
mov r0.z, c6.w
mov r0.y, c5.w
add r3.xyz, -r0, c8
dp3 r1.w, r3, r3
mov o1.xyz, r1
rsq r1.x, r1.w
mov o3.xyz, r0
rcp r0.x, r1.x
mul o4.xyz, r0.w, r2
rcp o5.x, r0.w
add o6.x, r0, -c11
mov o7.xyz, -r3
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  lowp float tmpvar_34;
  mediump float lightShadowDataX_35;
  highp float dist_36;
  lowp float tmpvar_37;
  tmpvar_37 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = _LightShadowData.x;
  lightShadowDataX_35 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = max (float((dist_36 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_35);
  tmpvar_34 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * tmpvar_34), 0.0, 1.0)).x));
  highp float tmpvar_42;
  tmpvar_42 = (color_9.w * (tmpvar_40 * tmpvar_41));
  color_9.w = tmpvar_42;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_6, p_6)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_5 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  highp float tmpvar_35;
  tmpvar_35 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * tmpvar_34.x), 0.0, 1.0)).x));
  highp float tmpvar_37;
  tmpvar_37 = (color_9.w * (tmpvar_35 * tmpvar_36));
  color_9.w = tmpvar_37;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 442
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 434
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    #line 438
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 442
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 442
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 446
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    #line 450
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 455
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 459
    highp float avgHeight = _SphereRadius;
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 463
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        #line 467
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        #line 471
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 475
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 479
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 483
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 488
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 492
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 496
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying float xlv_TEXCOORD7;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _OceanRadius;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  vec4 o_7;
  vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_6, p_6)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_5 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 norm_1;
  float avgHeight_2;
  float oceanSphereDist_3;
  float sphereDist_4;
  float depth_5;
  vec4 color_6;
  color_6 = _Color;
  depth_5 = 1e+32;
  sphereDist_4 = 0.0;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD8, tmpvar_7);
  float tmpvar_9;
  tmpvar_9 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_8 * tmpvar_8)));
  float tmpvar_10;
  tmpvar_10 = pow (tmpvar_9, 2.0);
  float tmpvar_11;
  tmpvar_11 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_3 = 1e+32;
  if (((tmpvar_9 <= _OceanRadius) && (tmpvar_8 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_8 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_10)));
  };
  float tmpvar_12;
  tmpvar_12 = min (oceanSphereDist_3, 1e+32);
  depth_5 = tmpvar_12;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_11 < _SphereRadius) && (tmpvar_8 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_10)) - sqrt((pow (tmpvar_11, 2.0) - tmpvar_10)));
    sphereDist_4 = tmpvar_13;
    float tmpvar_14;
    tmpvar_14 = min (tmpvar_12, tmpvar_13);
    depth_5 = tmpvar_14;
    vec3 tmpvar_15;
    tmpvar_15 = (_WorldSpaceCameraPos + (tmpvar_14 * tmpvar_7));
    norm_1 = normalize((tmpvar_15 - xlv_TEXCOORD4));
    float tmpvar_16;
    vec3 p_17;
    p_17 = (tmpvar_15 - xlv_TEXCOORD4);
    tmpvar_16 = sqrt(dot (p_17, p_17));
    avgHeight_2 = ((0.75 * min (tmpvar_16, tmpvar_11)) + (0.25 * max (tmpvar_16, tmpvar_11)));
  } else {
    if (((tmpvar_9 <= _SphereRadius) && (tmpvar_8 >= 0.0))) {
      float oldDepth_18;
      float tmpvar_19;
      tmpvar_19 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_10));
      float tmpvar_20;
      tmpvar_20 = clamp ((_SphereRadius - tmpvar_11), 0.0, 1.0);
      float tmpvar_21;
      tmpvar_21 = mix ((tmpvar_8 - tmpvar_19), (tmpvar_19 + tmpvar_8), tmpvar_20);
      sphereDist_4 = tmpvar_21;
      float tmpvar_22;
      tmpvar_22 = min ((tmpvar_8 + tmpvar_19), depth_5);
      oldDepth_18 = depth_5;
      float tmpvar_23;
      tmpvar_23 = min (depth_5, tmpvar_21);
      norm_1 = normalize(((_WorldSpaceCameraPos + (tmpvar_23 * tmpvar_7)) - xlv_TEXCOORD4));
      depth_5 = mix ((tmpvar_22 - tmpvar_21), min (tmpvar_23, tmpvar_21), tmpvar_20);
      float tmpvar_24;
      vec3 p_25;
      p_25 = ((_WorldSpaceCameraPos + (tmpvar_22 * tmpvar_7)) - xlv_TEXCOORD4);
      tmpvar_24 = sqrt(dot (p_25, p_25));
      float tmpvar_26;
      tmpvar_26 = mix (mix (_SphereRadius, tmpvar_9, (tmpvar_22 - oldDepth_18)), tmpvar_11, tmpvar_20);
      avgHeight_2 = ((0.75 * min (tmpvar_24, tmpvar_26)) + (0.25 * max (tmpvar_24, tmpvar_26)));
    };
  };
  float tmpvar_27;
  tmpvar_27 = (mix (0.0, depth_5, clamp (sphereDist_4, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_5 = tmpvar_27;
  color_6.w = (_Color.w * (tmpvar_27 * max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_1, normalize(_WorldSpaceLightPos0).xyz)) * 4.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x), 0.0, 1.0)).x))));
  gl_FragData[0] = color_6;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Matrix 4 [_Object2World]
Float 11 [_OceanRadius]
"vs_3_0
; 28 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
dcl_texcoord6 o5
dcl_texcoord7 o6
dcl_texcoord8 o7
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c12.x
mov o0, r0
mul r1.y, r1, c9.x
mad o2.xy, r1.z, c10.zwzw, r1
mov o2.zw, r0
dp4 r1.x, v0, c4
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
add r2.xyz, -r1, c8
dp3 r0.x, r2, r2
rsq r0.w, r0.x
mov r0.x, c4.w
mov r0.z, c6.w
mov r0.y, c5.w
add r3.xyz, -r0, c8
dp3 r1.w, r3, r3
mov o1.xyz, r1
rsq r1.x, r1.w
mov o3.xyz, r0
rcp r0.x, r1.x
mul o4.xyz, r0.w, r2
rcp o5.x, r0.w
add o6.x, r0, -c11
mov o7.xyz, -r3
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  lowp float tmpvar_34;
  mediump float lightShadowDataX_35;
  highp float dist_36;
  lowp float tmpvar_37;
  tmpvar_37 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = _LightShadowData.x;
  lightShadowDataX_35 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = max (float((dist_36 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_35);
  tmpvar_34 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * tmpvar_34), 0.0, 1.0)).x));
  highp float tmpvar_42;
  tmpvar_42 = (color_9.w * (tmpvar_40 * tmpvar_41));
  color_9.w = tmpvar_42;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_6, p_6)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_5 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  highp float tmpvar_35;
  tmpvar_35 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * tmpvar_34.x), 0.0, 1.0)).x));
  highp float tmpvar_37;
  tmpvar_37 = (color_9.w * (tmpvar_35 * tmpvar_36));
  color_9.w = tmpvar_37;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 442
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 434
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    #line 438
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 442
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 442
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 446
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    #line 450
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 455
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 459
    highp float avgHeight = _SphereRadius;
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 463
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        #line 467
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        #line 471
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 475
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 479
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 483
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 488
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 492
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 496
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying float xlv_TEXCOORD7;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _OceanRadius;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  vec4 o_7;
  vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_6, p_6)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_5 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 norm_1;
  float avgHeight_2;
  float oceanSphereDist_3;
  float sphereDist_4;
  float depth_5;
  vec4 color_6;
  color_6 = _Color;
  depth_5 = 1e+32;
  sphereDist_4 = 0.0;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD8, tmpvar_7);
  float tmpvar_9;
  tmpvar_9 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_8 * tmpvar_8)));
  float tmpvar_10;
  tmpvar_10 = pow (tmpvar_9, 2.0);
  float tmpvar_11;
  tmpvar_11 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_3 = 1e+32;
  if (((tmpvar_9 <= _OceanRadius) && (tmpvar_8 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_8 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_10)));
  };
  float tmpvar_12;
  tmpvar_12 = min (oceanSphereDist_3, 1e+32);
  depth_5 = tmpvar_12;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_11 < _SphereRadius) && (tmpvar_8 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_10)) - sqrt((pow (tmpvar_11, 2.0) - tmpvar_10)));
    sphereDist_4 = tmpvar_13;
    float tmpvar_14;
    tmpvar_14 = min (tmpvar_12, tmpvar_13);
    depth_5 = tmpvar_14;
    vec3 tmpvar_15;
    tmpvar_15 = (_WorldSpaceCameraPos + (tmpvar_14 * tmpvar_7));
    norm_1 = normalize((tmpvar_15 - xlv_TEXCOORD4));
    float tmpvar_16;
    vec3 p_17;
    p_17 = (tmpvar_15 - xlv_TEXCOORD4);
    tmpvar_16 = sqrt(dot (p_17, p_17));
    avgHeight_2 = ((0.75 * min (tmpvar_16, tmpvar_11)) + (0.25 * max (tmpvar_16, tmpvar_11)));
  } else {
    if (((tmpvar_9 <= _SphereRadius) && (tmpvar_8 >= 0.0))) {
      float oldDepth_18;
      float tmpvar_19;
      tmpvar_19 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_10));
      float tmpvar_20;
      tmpvar_20 = clamp ((_SphereRadius - tmpvar_11), 0.0, 1.0);
      float tmpvar_21;
      tmpvar_21 = mix ((tmpvar_8 - tmpvar_19), (tmpvar_19 + tmpvar_8), tmpvar_20);
      sphereDist_4 = tmpvar_21;
      float tmpvar_22;
      tmpvar_22 = min ((tmpvar_8 + tmpvar_19), depth_5);
      oldDepth_18 = depth_5;
      float tmpvar_23;
      tmpvar_23 = min (depth_5, tmpvar_21);
      norm_1 = normalize(((_WorldSpaceCameraPos + (tmpvar_23 * tmpvar_7)) - xlv_TEXCOORD4));
      depth_5 = mix ((tmpvar_22 - tmpvar_21), min (tmpvar_23, tmpvar_21), tmpvar_20);
      float tmpvar_24;
      vec3 p_25;
      p_25 = ((_WorldSpaceCameraPos + (tmpvar_22 * tmpvar_7)) - xlv_TEXCOORD4);
      tmpvar_24 = sqrt(dot (p_25, p_25));
      float tmpvar_26;
      tmpvar_26 = mix (mix (_SphereRadius, tmpvar_9, (tmpvar_22 - oldDepth_18)), tmpvar_11, tmpvar_20);
      avgHeight_2 = ((0.75 * min (tmpvar_24, tmpvar_26)) + (0.25 * max (tmpvar_24, tmpvar_26)));
    };
  };
  float tmpvar_27;
  tmpvar_27 = (mix (0.0, depth_5, clamp (sphereDist_4, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_5 = tmpvar_27;
  color_6.w = (_Color.w * (tmpvar_27 * max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_1, normalize(_WorldSpaceLightPos0).xyz)) * 4.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x), 0.0, 1.0)).x))));
  gl_FragData[0] = color_6;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Matrix 4 [_Object2World]
Float 11 [_OceanRadius]
"vs_3_0
; 28 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
dcl_texcoord6 o5
dcl_texcoord7 o6
dcl_texcoord8 o7
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c12.x
mov o0, r0
mul r1.y, r1, c9.x
mad o2.xy, r1.z, c10.zwzw, r1
mov o2.zw, r0
dp4 r1.x, v0, c4
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
add r2.xyz, -r1, c8
dp3 r0.x, r2, r2
rsq r0.w, r0.x
mov r0.x, c4.w
mov r0.z, c6.w
mov r0.y, c5.w
add r3.xyz, -r0, c8
dp3 r1.w, r3, r3
mov o1.xyz, r1
rsq r1.x, r1.w
mov o3.xyz, r0
rcp r0.x, r1.x
mul o4.xyz, r0.w, r2
rcp o5.x, r0.w
add o6.x, r0, -c11
mov o7.xyz, -r3
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  lowp float tmpvar_34;
  mediump float lightShadowDataX_35;
  highp float dist_36;
  lowp float tmpvar_37;
  tmpvar_37 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = _LightShadowData.x;
  lightShadowDataX_35 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = max (float((dist_36 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_35);
  tmpvar_34 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * tmpvar_34), 0.0, 1.0)).x));
  highp float tmpvar_42;
  tmpvar_42 = (color_9.w * (tmpvar_40 * tmpvar_41));
  color_9.w = tmpvar_42;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_6, p_6)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_5 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  highp float tmpvar_35;
  tmpvar_35 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * tmpvar_34.x), 0.0, 1.0)).x));
  highp float tmpvar_37;
  tmpvar_37 = (color_9.w * (tmpvar_35 * tmpvar_36));
  color_9.w = tmpvar_37;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 442
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 434
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    #line 438
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 442
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 442
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 446
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    #line 450
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 455
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 459
    highp float avgHeight = _SphereRadius;
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 463
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        #line 467
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        #line 471
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 475
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 479
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 483
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 488
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 492
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 496
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying float xlv_TEXCOORD7;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _OceanRadius;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 norm_1;
  float avgHeight_2;
  float oceanSphereDist_3;
  float sphereDist_4;
  float depth_5;
  vec4 color_6;
  color_6 = _Color;
  depth_5 = 1e+32;
  sphereDist_4 = 0.0;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD8, tmpvar_7);
  float tmpvar_9;
  tmpvar_9 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_8 * tmpvar_8)));
  float tmpvar_10;
  tmpvar_10 = pow (tmpvar_9, 2.0);
  float tmpvar_11;
  tmpvar_11 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_3 = 1e+32;
  if (((tmpvar_9 <= _OceanRadius) && (tmpvar_8 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_8 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_10)));
  };
  float tmpvar_12;
  tmpvar_12 = min (oceanSphereDist_3, 1e+32);
  depth_5 = tmpvar_12;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_11 < _SphereRadius) && (tmpvar_8 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_10)) - sqrt((pow (tmpvar_11, 2.0) - tmpvar_10)));
    sphereDist_4 = tmpvar_13;
    float tmpvar_14;
    tmpvar_14 = min (tmpvar_12, tmpvar_13);
    depth_5 = tmpvar_14;
    vec3 tmpvar_15;
    tmpvar_15 = (_WorldSpaceCameraPos + (tmpvar_14 * tmpvar_7));
    norm_1 = normalize((tmpvar_15 - xlv_TEXCOORD4));
    float tmpvar_16;
    vec3 p_17;
    p_17 = (tmpvar_15 - xlv_TEXCOORD4);
    tmpvar_16 = sqrt(dot (p_17, p_17));
    avgHeight_2 = ((0.75 * min (tmpvar_16, tmpvar_11)) + (0.25 * max (tmpvar_16, tmpvar_11)));
  } else {
    if (((tmpvar_9 <= _SphereRadius) && (tmpvar_8 >= 0.0))) {
      float oldDepth_18;
      float tmpvar_19;
      tmpvar_19 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_10));
      float tmpvar_20;
      tmpvar_20 = clamp ((_SphereRadius - tmpvar_11), 0.0, 1.0);
      float tmpvar_21;
      tmpvar_21 = mix ((tmpvar_8 - tmpvar_19), (tmpvar_19 + tmpvar_8), tmpvar_20);
      sphereDist_4 = tmpvar_21;
      float tmpvar_22;
      tmpvar_22 = min ((tmpvar_8 + tmpvar_19), depth_5);
      oldDepth_18 = depth_5;
      float tmpvar_23;
      tmpvar_23 = min (depth_5, tmpvar_21);
      norm_1 = normalize(((_WorldSpaceCameraPos + (tmpvar_23 * tmpvar_7)) - xlv_TEXCOORD4));
      depth_5 = mix ((tmpvar_22 - tmpvar_21), min (tmpvar_23, tmpvar_21), tmpvar_20);
      float tmpvar_24;
      vec3 p_25;
      p_25 = ((_WorldSpaceCameraPos + (tmpvar_22 * tmpvar_7)) - xlv_TEXCOORD4);
      tmpvar_24 = sqrt(dot (p_25, p_25));
      float tmpvar_26;
      tmpvar_26 = mix (mix (_SphereRadius, tmpvar_9, (tmpvar_22 - oldDepth_18)), tmpvar_11, tmpvar_20);
      avgHeight_2 = ((0.75 * min (tmpvar_24, tmpvar_26)) + (0.25 * max (tmpvar_24, tmpvar_26)));
    };
  };
  float tmpvar_27;
  tmpvar_27 = (mix (0.0, depth_5, clamp (sphereDist_4, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_5 = tmpvar_27;
  color_6.w = (_Color.w * (tmpvar_27 * max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_1, normalize(_WorldSpaceLightPos0).xyz)) * 4.0), 0.0, 1.0)).x))));
  gl_FragData[0] = color_6;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Float 9 [_OceanRadius]
"vs_3_0
; 23 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord4 o2
dcl_texcoord5 o3
dcl_texcoord6 o4
dcl_texcoord7 o5
dcl_texcoord8 o6
dcl_position0 v0
dp4 r1.x, v0, c4
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
add r2.xyz, -r1, c8
dp3 r0.x, r2, r2
rsq r0.w, r0.x
mov r0.x, c4.w
mov r0.z, c6.w
mov r0.y, c5.w
add r3.xyz, -r0, c8
dp3 r1.w, r3, r3
mov o1.xyz, r1
rsq r1.x, r1.w
mov o2.xyz, r0
rcp r0.x, r1.x
mul o3.xyz, r0.w, r2
rcp o4.x, r0.w
add o5.x, r0, -c9
mov o6.xyz, -r3
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0), 0.0, 1.0)).x));
  highp float tmpvar_36;
  tmpvar_36 = (color_9.w * (tmpvar_34 * tmpvar_35));
  color_9.w = tmpvar_36;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0), 0.0, 1.0)).x));
  highp float tmpvar_36;
  tmpvar_36 = (color_9.w * (tmpvar_34 * tmpvar_35));
  color_9.w = tmpvar_36;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 393
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 397
uniform highp vec3 _PlanetOrigin;
#line 417
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 417
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 421
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 425
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    #line 430
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 393
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 397
uniform highp vec3 _PlanetOrigin;
#line 417
#line 432
lowp vec4 frag( in v2f IN ) {
    #line 434
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 438
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 442
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 446
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 450
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 454
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        #line 458
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 465
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 469
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 473
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 478
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = 1.0;
    #line 482
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 486
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying float xlv_TEXCOORD7;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _OceanRadius;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  vec4 o_7;
  vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_6, p_6)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_5 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 norm_1;
  float avgHeight_2;
  float oceanSphereDist_3;
  float sphereDist_4;
  float depth_5;
  vec4 color_6;
  color_6 = _Color;
  depth_5 = 1e+32;
  sphereDist_4 = 0.0;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD8, tmpvar_7);
  float tmpvar_9;
  tmpvar_9 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_8 * tmpvar_8)));
  float tmpvar_10;
  tmpvar_10 = pow (tmpvar_9, 2.0);
  float tmpvar_11;
  tmpvar_11 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_3 = 1e+32;
  if (((tmpvar_9 <= _OceanRadius) && (tmpvar_8 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_8 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_10)));
  };
  float tmpvar_12;
  tmpvar_12 = min (oceanSphereDist_3, 1e+32);
  depth_5 = tmpvar_12;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_11 < _SphereRadius) && (tmpvar_8 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_10)) - sqrt((pow (tmpvar_11, 2.0) - tmpvar_10)));
    sphereDist_4 = tmpvar_13;
    float tmpvar_14;
    tmpvar_14 = min (tmpvar_12, tmpvar_13);
    depth_5 = tmpvar_14;
    vec3 tmpvar_15;
    tmpvar_15 = (_WorldSpaceCameraPos + (tmpvar_14 * tmpvar_7));
    norm_1 = normalize((tmpvar_15 - xlv_TEXCOORD4));
    float tmpvar_16;
    vec3 p_17;
    p_17 = (tmpvar_15 - xlv_TEXCOORD4);
    tmpvar_16 = sqrt(dot (p_17, p_17));
    avgHeight_2 = ((0.75 * min (tmpvar_16, tmpvar_11)) + (0.25 * max (tmpvar_16, tmpvar_11)));
  } else {
    if (((tmpvar_9 <= _SphereRadius) && (tmpvar_8 >= 0.0))) {
      float oldDepth_18;
      float tmpvar_19;
      tmpvar_19 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_10));
      float tmpvar_20;
      tmpvar_20 = clamp ((_SphereRadius - tmpvar_11), 0.0, 1.0);
      float tmpvar_21;
      tmpvar_21 = mix ((tmpvar_8 - tmpvar_19), (tmpvar_19 + tmpvar_8), tmpvar_20);
      sphereDist_4 = tmpvar_21;
      float tmpvar_22;
      tmpvar_22 = min ((tmpvar_8 + tmpvar_19), depth_5);
      oldDepth_18 = depth_5;
      float tmpvar_23;
      tmpvar_23 = min (depth_5, tmpvar_21);
      norm_1 = normalize(((_WorldSpaceCameraPos + (tmpvar_23 * tmpvar_7)) - xlv_TEXCOORD4));
      depth_5 = mix ((tmpvar_22 - tmpvar_21), min (tmpvar_23, tmpvar_21), tmpvar_20);
      float tmpvar_24;
      vec3 p_25;
      p_25 = ((_WorldSpaceCameraPos + (tmpvar_22 * tmpvar_7)) - xlv_TEXCOORD4);
      tmpvar_24 = sqrt(dot (p_25, p_25));
      float tmpvar_26;
      tmpvar_26 = mix (mix (_SphereRadius, tmpvar_9, (tmpvar_22 - oldDepth_18)), tmpvar_11, tmpvar_20);
      avgHeight_2 = ((0.75 * min (tmpvar_24, tmpvar_26)) + (0.25 * max (tmpvar_24, tmpvar_26)));
    };
  };
  float tmpvar_27;
  tmpvar_27 = (mix (0.0, depth_5, clamp (sphereDist_4, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_5 = tmpvar_27;
  color_6.w = (_Color.w * (tmpvar_27 * max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_1, normalize(_WorldSpaceLightPos0).xyz)) * 4.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x), 0.0, 1.0)).x))));
  gl_FragData[0] = color_6;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Matrix 4 [_Object2World]
Float 11 [_OceanRadius]
"vs_3_0
; 28 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
dcl_texcoord6 o5
dcl_texcoord7 o6
dcl_texcoord8 o7
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c12.x
mov o0, r0
mul r1.y, r1, c9.x
mad o2.xy, r1.z, c10.zwzw, r1
mov o2.zw, r0
dp4 r1.x, v0, c4
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
add r2.xyz, -r1, c8
dp3 r0.x, r2, r2
rsq r0.w, r0.x
mov r0.x, c4.w
mov r0.z, c6.w
mov r0.y, c5.w
add r3.xyz, -r0, c8
dp3 r1.w, r3, r3
mov o1.xyz, r1
rsq r1.x, r1.w
mov o3.xyz, r0
rcp r0.x, r1.x
mul o4.xyz, r0.w, r2
rcp o5.x, r0.w
add o6.x, r0, -c11
mov o7.xyz, -r3
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  lowp float tmpvar_34;
  mediump float lightShadowDataX_35;
  highp float dist_36;
  lowp float tmpvar_37;
  tmpvar_37 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = _LightShadowData.x;
  lightShadowDataX_35 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = max (float((dist_36 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_35);
  tmpvar_34 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * tmpvar_34), 0.0, 1.0)).x));
  highp float tmpvar_42;
  tmpvar_42 = (color_9.w * (tmpvar_40 * tmpvar_41));
  color_9.w = tmpvar_42;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_6, p_6)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_5 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  highp float tmpvar_35;
  tmpvar_35 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * tmpvar_34.x), 0.0, 1.0)).x));
  highp float tmpvar_37;
  tmpvar_37 = (color_9.w * (tmpvar_35 * tmpvar_36));
  color_9.w = tmpvar_37;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 442
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 434
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    #line 438
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 442
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 442
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 446
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    #line 450
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 455
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 459
    highp float avgHeight = _SphereRadius;
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 463
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        #line 467
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        #line 471
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 475
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 479
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 483
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 488
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 492
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 496
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  lowp float shadow_34;
  lowp float tmpvar_35;
  tmpvar_35 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_36;
  tmpvar_36 = (_LightShadowData.x + (tmpvar_35 * (1.0 - _LightShadowData.x)));
  shadow_34 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * shadow_34), 0.0, 1.0)).x));
  highp float tmpvar_39;
  tmpvar_39 = (color_9.w * (tmpvar_37 * tmpvar_38));
  color_9.w = tmpvar_39;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 442
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 434
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    #line 438
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 442
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 442
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 446
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    #line 450
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 455
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 459
    highp float avgHeight = _SphereRadius;
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 463
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        #line 467
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        #line 471
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 475
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 479
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 483
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 488
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 492
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 496
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  lowp float shadow_34;
  lowp float tmpvar_35;
  tmpvar_35 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_36;
  tmpvar_36 = (_LightShadowData.x + (tmpvar_35 * (1.0 - _LightShadowData.x)));
  shadow_34 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * shadow_34), 0.0, 1.0)).x));
  highp float tmpvar_39;
  tmpvar_39 = (color_9.w * (tmpvar_37 * tmpvar_38));
  color_9.w = tmpvar_39;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 442
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 434
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    #line 438
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 442
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 442
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 446
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    #line 450
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 455
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 459
    highp float avgHeight = _SphereRadius;
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 463
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        #line 467
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        #line 471
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 475
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 479
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 483
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 488
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 492
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 496
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  lowp float shadow_34;
  lowp float tmpvar_35;
  tmpvar_35 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_36;
  tmpvar_36 = (_LightShadowData.x + (tmpvar_35 * (1.0 - _LightShadowData.x)));
  shadow_34 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * shadow_34), 0.0, 1.0)).x));
  highp float tmpvar_39;
  tmpvar_39 = (color_9.w * (tmpvar_37 * tmpvar_38));
  color_9.w = tmpvar_39;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 442
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 434
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    #line 438
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 442
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 442
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 446
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    #line 450
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 455
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 459
    highp float avgHeight = _SphereRadius;
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 463
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        #line 467
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        #line 471
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 475
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 479
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 483
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 488
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 492
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 496
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_4 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (tmpvar_4 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  depth_8 = 1e+32;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_12;
  tmpvar_12 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_11 * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = pow (tmpvar_12, 2.0);
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = 1e+32;
  if (((tmpvar_12 <= _OceanRadius) && (tmpvar_11 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_11 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_13)));
  };
  highp float tmpvar_15;
  tmpvar_15 = min (oceanSphereDist_5, 1e+32);
  depth_8 = tmpvar_15;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_14 < _SphereRadius) && (tmpvar_11 < 0.0))) {
    highp float tmpvar_16;
    tmpvar_16 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_13)) - sqrt((pow (tmpvar_14, 2.0) - tmpvar_13)));
    sphereDist_7 = tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = min (tmpvar_15, tmpvar_16);
    depth_8 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = (_WorldSpaceCameraPos + (tmpvar_17 * worldDir_6));
    highp vec3 tmpvar_19;
    tmpvar_19 = normalize((tmpvar_18 - xlv_TEXCOORD4));
    norm_3 = tmpvar_19;
    highp float tmpvar_20;
    highp vec3 p_21;
    p_21 = (tmpvar_18 - xlv_TEXCOORD4);
    tmpvar_20 = sqrt(dot (p_21, p_21));
    avgHeight_4 = ((0.75 * min (tmpvar_20, tmpvar_14)) + (0.25 * max (tmpvar_20, tmpvar_14)));
  } else {
    if (((tmpvar_12 <= _SphereRadius) && (tmpvar_11 >= 0.0))) {
      highp float oldDepth_22;
      mediump float sphereCheck_23;
      highp float tmpvar_24;
      tmpvar_24 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_13));
      highp float tmpvar_25;
      tmpvar_25 = clamp ((_SphereRadius - tmpvar_14), 0.0, 1.0);
      sphereCheck_23 = tmpvar_25;
      highp float tmpvar_26;
      tmpvar_26 = mix ((tmpvar_11 - tmpvar_24), (tmpvar_24 + tmpvar_11), sphereCheck_23);
      sphereDist_7 = tmpvar_26;
      highp float tmpvar_27;
      tmpvar_27 = min ((tmpvar_11 + tmpvar_24), depth_8);
      oldDepth_22 = depth_8;
      highp float tmpvar_28;
      tmpvar_28 = min (depth_8, tmpvar_26);
      highp vec3 tmpvar_29;
      tmpvar_29 = normalize(((_WorldSpaceCameraPos + (tmpvar_28 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_29;
      depth_8 = mix ((tmpvar_27 - tmpvar_26), min (tmpvar_28, tmpvar_26), sphereCheck_23);
      highp float tmpvar_30;
      highp vec3 p_31;
      p_31 = ((_WorldSpaceCameraPos + (tmpvar_27 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_30 = sqrt(dot (p_31, p_31));
      highp float tmpvar_32;
      tmpvar_32 = mix (mix (_SphereRadius, tmpvar_12, (tmpvar_27 - oldDepth_22)), tmpvar_14, sphereCheck_23);
      avgHeight_4 = ((0.75 * min (tmpvar_30, tmpvar_32)) + (0.25 * max (tmpvar_30, tmpvar_32)));
    };
  };
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_33;
  lowp float shadow_34;
  lowp float tmpvar_35;
  tmpvar_35 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_36;
  tmpvar_36 = (_LightShadowData.x + (tmpvar_35 * (1.0 - _LightShadowData.x)));
  shadow_34 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * shadow_34), 0.0, 1.0)).x));
  highp float tmpvar_39;
  tmpvar_39 = (color_9.w * (tmpvar_37 * tmpvar_38));
  color_9.w = tmpvar_39;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 442
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 434
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    #line 438
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 442
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 442
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 446
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    #line 450
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 455
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 459
    highp float avgHeight = _SphereRadius;
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 463
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        #line 467
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        #line 471
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 475
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 479
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 483
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 488
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 492
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 496
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying float xlv_TEXCOORD7;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform float _OceanRadius;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 norm_1;
  float avgHeight_2;
  float oceanSphereDist_3;
  float sphereDist_4;
  float depth_5;
  vec4 color_6;
  color_6 = _Color;
  float tmpvar_7;
  tmpvar_7 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_5 = tmpvar_7;
  sphereDist_4 = 0.0;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD8, tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_9 * tmpvar_9)));
  float tmpvar_11;
  tmpvar_11 = pow (tmpvar_10, 2.0);
  float tmpvar_12;
  tmpvar_12 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_3 = tmpvar_7;
  if (((tmpvar_10 <= _OceanRadius) && (tmpvar_9 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_9 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_11)));
  };
  float tmpvar_13;
  tmpvar_13 = min (oceanSphereDist_3, tmpvar_7);
  depth_5 = tmpvar_13;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_12 < _SphereRadius) && (tmpvar_9 < 0.0))) {
    float tmpvar_14;
    tmpvar_14 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_11)) - sqrt((pow (tmpvar_12, 2.0) - tmpvar_11)));
    sphereDist_4 = tmpvar_14;
    float tmpvar_15;
    tmpvar_15 = min (tmpvar_13, tmpvar_14);
    depth_5 = tmpvar_15;
    vec3 tmpvar_16;
    tmpvar_16 = (_WorldSpaceCameraPos + (tmpvar_15 * tmpvar_8));
    norm_1 = normalize((tmpvar_16 - xlv_TEXCOORD4));
    float tmpvar_17;
    vec3 p_18;
    p_18 = (tmpvar_16 - xlv_TEXCOORD4);
    tmpvar_17 = sqrt(dot (p_18, p_18));
    avgHeight_2 = ((0.75 * min (tmpvar_17, tmpvar_12)) + (0.25 * max (tmpvar_17, tmpvar_12)));
  } else {
    if (((tmpvar_10 <= _SphereRadius) && (tmpvar_9 >= 0.0))) {
      float oldDepth_19;
      float tmpvar_20;
      tmpvar_20 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_11));
      float tmpvar_21;
      tmpvar_21 = clamp ((_SphereRadius - tmpvar_12), 0.0, 1.0);
      float tmpvar_22;
      tmpvar_22 = mix ((tmpvar_9 - tmpvar_20), (tmpvar_20 + tmpvar_9), tmpvar_21);
      sphereDist_4 = tmpvar_22;
      float tmpvar_23;
      tmpvar_23 = min ((tmpvar_9 + tmpvar_20), depth_5);
      oldDepth_19 = depth_5;
      float tmpvar_24;
      tmpvar_24 = min (depth_5, tmpvar_22);
      norm_1 = normalize(((_WorldSpaceCameraPos + (tmpvar_24 * tmpvar_8)) - xlv_TEXCOORD4));
      depth_5 = mix ((tmpvar_23 - tmpvar_22), min (tmpvar_24, tmpvar_22), tmpvar_21);
      float tmpvar_25;
      vec3 p_26;
      p_26 = ((_WorldSpaceCameraPos + (tmpvar_23 * tmpvar_8)) - xlv_TEXCOORD4);
      tmpvar_25 = sqrt(dot (p_26, p_26));
      float tmpvar_27;
      tmpvar_27 = mix (mix (_SphereRadius, tmpvar_10, (tmpvar_23 - oldDepth_19)), tmpvar_12, tmpvar_21);
      avgHeight_2 = ((0.75 * min (tmpvar_25, tmpvar_27)) + (0.25 * max (tmpvar_25, tmpvar_27)));
    };
  };
  float tmpvar_28;
  tmpvar_28 = (mix (0.0, depth_5, clamp (sphereDist_4, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_5 = tmpvar_28;
  color_6.w = (_Color.w * (tmpvar_28 * max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_1, normalize(_WorldSpaceLightPos0).xyz)) * 4.0), 0.0, 1.0)).x))));
  gl_FragData[0] = color_6;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_OceanRadius]
Vector 16 [_PlanetOrigin]
"vs_3_0
; 30 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
dcl_texcoord6 o5
dcl_texcoord7 o6
dcl_texcoord8 o7
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
mov r1.w, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
mul r0.y, r0, c13.x
mad o1.xy, r0.z, c14.zwzw, r0
dp4 r1.z, v0, c6
mov o0, r1
mov r1.xyz, c12
add r1.xyz, -c16, r1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c12
dp3 r1.w, r2, r2
rsq r1.w, r1.w
dp3 r1.x, r1, r1
mov o2.xyz, r0
rsq r0.x, r1.x
rcp r0.x, r0.x
add o6.x, r0, -c15
mov r0.xyz, c16
dp4 r1.x, v0, c2
mul o4.xyz, r1.w, r2
mov o3.xyz, c16
rcp o5.x, r1.w
add o7.xyz, -c12, r0
mov o1.z, -r1.x
mov o1.w, r0
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0), 0.0, 1.0)).x));
  highp float tmpvar_38;
  tmpvar_38 = (color_9.w * (tmpvar_36 * tmpvar_37));
  color_9.w = tmpvar_38;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0), 0.0, 1.0)).x));
  highp float tmpvar_38;
  tmpvar_38 = (color_9.w * (tmpvar_36 * tmpvar_37));
  color_9.w = tmpvar_38;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 393
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 397
uniform highp vec3 _PlanetOrigin;
#line 417
#line 433
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 417
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 421
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 425
    o.worldOrigin = _PlanetOrigin;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 429
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 393
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 397
uniform highp vec3 _PlanetOrigin;
#line 417
#line 433
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 433
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 437
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 441
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 445
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 449
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 453
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 457
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        #line 461
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 468
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 472
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 476
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 481
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = 1.0;
    #line 485
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 489
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying float xlv_TEXCOORD7;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform float _OceanRadius;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 norm_1;
  float avgHeight_2;
  float oceanSphereDist_3;
  float sphereDist_4;
  float depth_5;
  vec4 color_6;
  color_6 = _Color;
  float tmpvar_7;
  tmpvar_7 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_5 = tmpvar_7;
  sphereDist_4 = 0.0;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD8, tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_9 * tmpvar_9)));
  float tmpvar_11;
  tmpvar_11 = pow (tmpvar_10, 2.0);
  float tmpvar_12;
  tmpvar_12 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_3 = tmpvar_7;
  if (((tmpvar_10 <= _OceanRadius) && (tmpvar_9 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_9 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_11)));
  };
  float tmpvar_13;
  tmpvar_13 = min (oceanSphereDist_3, tmpvar_7);
  depth_5 = tmpvar_13;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_12 < _SphereRadius) && (tmpvar_9 < 0.0))) {
    float tmpvar_14;
    tmpvar_14 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_11)) - sqrt((pow (tmpvar_12, 2.0) - tmpvar_11)));
    sphereDist_4 = tmpvar_14;
    float tmpvar_15;
    tmpvar_15 = min (tmpvar_13, tmpvar_14);
    depth_5 = tmpvar_15;
    vec3 tmpvar_16;
    tmpvar_16 = (_WorldSpaceCameraPos + (tmpvar_15 * tmpvar_8));
    norm_1 = normalize((tmpvar_16 - xlv_TEXCOORD4));
    float tmpvar_17;
    vec3 p_18;
    p_18 = (tmpvar_16 - xlv_TEXCOORD4);
    tmpvar_17 = sqrt(dot (p_18, p_18));
    avgHeight_2 = ((0.75 * min (tmpvar_17, tmpvar_12)) + (0.25 * max (tmpvar_17, tmpvar_12)));
  } else {
    if (((tmpvar_10 <= _SphereRadius) && (tmpvar_9 >= 0.0))) {
      float oldDepth_19;
      float tmpvar_20;
      tmpvar_20 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_11));
      float tmpvar_21;
      tmpvar_21 = clamp ((_SphereRadius - tmpvar_12), 0.0, 1.0);
      float tmpvar_22;
      tmpvar_22 = mix ((tmpvar_9 - tmpvar_20), (tmpvar_20 + tmpvar_9), tmpvar_21);
      sphereDist_4 = tmpvar_22;
      float tmpvar_23;
      tmpvar_23 = min ((tmpvar_9 + tmpvar_20), depth_5);
      oldDepth_19 = depth_5;
      float tmpvar_24;
      tmpvar_24 = min (depth_5, tmpvar_22);
      norm_1 = normalize(((_WorldSpaceCameraPos + (tmpvar_24 * tmpvar_8)) - xlv_TEXCOORD4));
      depth_5 = mix ((tmpvar_23 - tmpvar_22), min (tmpvar_24, tmpvar_22), tmpvar_21);
      float tmpvar_25;
      vec3 p_26;
      p_26 = ((_WorldSpaceCameraPos + (tmpvar_23 * tmpvar_8)) - xlv_TEXCOORD4);
      tmpvar_25 = sqrt(dot (p_26, p_26));
      float tmpvar_27;
      tmpvar_27 = mix (mix (_SphereRadius, tmpvar_10, (tmpvar_23 - oldDepth_19)), tmpvar_12, tmpvar_21);
      avgHeight_2 = ((0.75 * min (tmpvar_25, tmpvar_27)) + (0.25 * max (tmpvar_25, tmpvar_27)));
    };
  };
  float tmpvar_28;
  tmpvar_28 = (mix (0.0, depth_5, clamp (sphereDist_4, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_5 = tmpvar_28;
  color_6.w = (_Color.w * (tmpvar_28 * max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_1, normalize(_WorldSpaceLightPos0).xyz)) * 4.0), 0.0, 1.0)).x))));
  gl_FragData[0] = color_6;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_OceanRadius]
Vector 16 [_PlanetOrigin]
"vs_3_0
; 30 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
dcl_texcoord6 o5
dcl_texcoord7 o6
dcl_texcoord8 o7
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
mov r1.w, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
mul r0.y, r0, c13.x
mad o1.xy, r0.z, c14.zwzw, r0
dp4 r1.z, v0, c6
mov o0, r1
mov r1.xyz, c12
add r1.xyz, -c16, r1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c12
dp3 r1.w, r2, r2
rsq r1.w, r1.w
dp3 r1.x, r1, r1
mov o2.xyz, r0
rsq r0.x, r1.x
rcp r0.x, r0.x
add o6.x, r0, -c15
mov r0.xyz, c16
dp4 r1.x, v0, c2
mul o4.xyz, r1.w, r2
mov o3.xyz, c16
rcp o5.x, r1.w
add o7.xyz, -c12, r0
mov o1.z, -r1.x
mov o1.w, r0
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0), 0.0, 1.0)).x));
  highp float tmpvar_38;
  tmpvar_38 = (color_9.w * (tmpvar_36 * tmpvar_37));
  color_9.w = tmpvar_38;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0), 0.0, 1.0)).x));
  highp float tmpvar_38;
  tmpvar_38 = (color_9.w * (tmpvar_36 * tmpvar_37));
  color_9.w = tmpvar_38;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 393
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 397
uniform highp vec3 _PlanetOrigin;
#line 417
#line 433
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 417
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 421
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 425
    o.worldOrigin = _PlanetOrigin;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 429
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 393
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 397
uniform highp vec3 _PlanetOrigin;
#line 417
#line 433
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 433
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 437
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 441
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 445
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 449
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 453
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 457
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        #line 461
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 468
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 472
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 476
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 481
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = 1.0;
    #line 485
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 489
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying float xlv_TEXCOORD7;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform float _OceanRadius;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 norm_1;
  float avgHeight_2;
  float oceanSphereDist_3;
  float sphereDist_4;
  float depth_5;
  vec4 color_6;
  color_6 = _Color;
  float tmpvar_7;
  tmpvar_7 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_5 = tmpvar_7;
  sphereDist_4 = 0.0;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD8, tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_9 * tmpvar_9)));
  float tmpvar_11;
  tmpvar_11 = pow (tmpvar_10, 2.0);
  float tmpvar_12;
  tmpvar_12 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_3 = tmpvar_7;
  if (((tmpvar_10 <= _OceanRadius) && (tmpvar_9 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_9 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_11)));
  };
  float tmpvar_13;
  tmpvar_13 = min (oceanSphereDist_3, tmpvar_7);
  depth_5 = tmpvar_13;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_12 < _SphereRadius) && (tmpvar_9 < 0.0))) {
    float tmpvar_14;
    tmpvar_14 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_11)) - sqrt((pow (tmpvar_12, 2.0) - tmpvar_11)));
    sphereDist_4 = tmpvar_14;
    float tmpvar_15;
    tmpvar_15 = min (tmpvar_13, tmpvar_14);
    depth_5 = tmpvar_15;
    vec3 tmpvar_16;
    tmpvar_16 = (_WorldSpaceCameraPos + (tmpvar_15 * tmpvar_8));
    norm_1 = normalize((tmpvar_16 - xlv_TEXCOORD4));
    float tmpvar_17;
    vec3 p_18;
    p_18 = (tmpvar_16 - xlv_TEXCOORD4);
    tmpvar_17 = sqrt(dot (p_18, p_18));
    avgHeight_2 = ((0.75 * min (tmpvar_17, tmpvar_12)) + (0.25 * max (tmpvar_17, tmpvar_12)));
  } else {
    if (((tmpvar_10 <= _SphereRadius) && (tmpvar_9 >= 0.0))) {
      float oldDepth_19;
      float tmpvar_20;
      tmpvar_20 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_11));
      float tmpvar_21;
      tmpvar_21 = clamp ((_SphereRadius - tmpvar_12), 0.0, 1.0);
      float tmpvar_22;
      tmpvar_22 = mix ((tmpvar_9 - tmpvar_20), (tmpvar_20 + tmpvar_9), tmpvar_21);
      sphereDist_4 = tmpvar_22;
      float tmpvar_23;
      tmpvar_23 = min ((tmpvar_9 + tmpvar_20), depth_5);
      oldDepth_19 = depth_5;
      float tmpvar_24;
      tmpvar_24 = min (depth_5, tmpvar_22);
      norm_1 = normalize(((_WorldSpaceCameraPos + (tmpvar_24 * tmpvar_8)) - xlv_TEXCOORD4));
      depth_5 = mix ((tmpvar_23 - tmpvar_22), min (tmpvar_24, tmpvar_22), tmpvar_21);
      float tmpvar_25;
      vec3 p_26;
      p_26 = ((_WorldSpaceCameraPos + (tmpvar_23 * tmpvar_8)) - xlv_TEXCOORD4);
      tmpvar_25 = sqrt(dot (p_26, p_26));
      float tmpvar_27;
      tmpvar_27 = mix (mix (_SphereRadius, tmpvar_10, (tmpvar_23 - oldDepth_19)), tmpvar_12, tmpvar_21);
      avgHeight_2 = ((0.75 * min (tmpvar_25, tmpvar_27)) + (0.25 * max (tmpvar_25, tmpvar_27)));
    };
  };
  float tmpvar_28;
  tmpvar_28 = (mix (0.0, depth_5, clamp (sphereDist_4, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_5 = tmpvar_28;
  color_6.w = (_Color.w * (tmpvar_28 * max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_1, normalize(_WorldSpaceLightPos0).xyz)) * 4.0), 0.0, 1.0)).x))));
  gl_FragData[0] = color_6;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_OceanRadius]
Vector 16 [_PlanetOrigin]
"vs_3_0
; 30 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
dcl_texcoord6 o5
dcl_texcoord7 o6
dcl_texcoord8 o7
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
mov r1.w, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
mul r0.y, r0, c13.x
mad o1.xy, r0.z, c14.zwzw, r0
dp4 r1.z, v0, c6
mov o0, r1
mov r1.xyz, c12
add r1.xyz, -c16, r1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c12
dp3 r1.w, r2, r2
rsq r1.w, r1.w
dp3 r1.x, r1, r1
mov o2.xyz, r0
rsq r0.x, r1.x
rcp r0.x, r0.x
add o6.x, r0, -c15
mov r0.xyz, c16
dp4 r1.x, v0, c2
mul o4.xyz, r1.w, r2
mov o3.xyz, c16
rcp o5.x, r1.w
add o7.xyz, -c12, r0
mov o1.z, -r1.x
mov o1.w, r0
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0), 0.0, 1.0)).x));
  highp float tmpvar_38;
  tmpvar_38 = (color_9.w * (tmpvar_36 * tmpvar_37));
  color_9.w = tmpvar_38;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0), 0.0, 1.0)).x));
  highp float tmpvar_38;
  tmpvar_38 = (color_9.w * (tmpvar_36 * tmpvar_37));
  color_9.w = tmpvar_38;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 393
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 397
uniform highp vec3 _PlanetOrigin;
#line 417
#line 433
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 417
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 421
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 425
    o.worldOrigin = _PlanetOrigin;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 429
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 393
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 397
uniform highp vec3 _PlanetOrigin;
#line 417
#line 433
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 433
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 437
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 441
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 445
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 449
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 453
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 457
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        #line 461
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 468
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 472
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 476
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 481
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = 1.0;
    #line 485
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 489
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying float xlv_TEXCOORD7;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform float _OceanRadius;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_9;
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_2 * 0.5);
  vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 norm_1;
  float avgHeight_2;
  float oceanSphereDist_3;
  float sphereDist_4;
  float depth_5;
  vec4 color_6;
  color_6 = _Color;
  float tmpvar_7;
  tmpvar_7 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_5 = tmpvar_7;
  sphereDist_4 = 0.0;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD8, tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_9 * tmpvar_9)));
  float tmpvar_11;
  tmpvar_11 = pow (tmpvar_10, 2.0);
  float tmpvar_12;
  tmpvar_12 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_3 = tmpvar_7;
  if (((tmpvar_10 <= _OceanRadius) && (tmpvar_9 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_9 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_11)));
  };
  float tmpvar_13;
  tmpvar_13 = min (oceanSphereDist_3, tmpvar_7);
  depth_5 = tmpvar_13;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_12 < _SphereRadius) && (tmpvar_9 < 0.0))) {
    float tmpvar_14;
    tmpvar_14 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_11)) - sqrt((pow (tmpvar_12, 2.0) - tmpvar_11)));
    sphereDist_4 = tmpvar_14;
    float tmpvar_15;
    tmpvar_15 = min (tmpvar_13, tmpvar_14);
    depth_5 = tmpvar_15;
    vec3 tmpvar_16;
    tmpvar_16 = (_WorldSpaceCameraPos + (tmpvar_15 * tmpvar_8));
    norm_1 = normalize((tmpvar_16 - xlv_TEXCOORD4));
    float tmpvar_17;
    vec3 p_18;
    p_18 = (tmpvar_16 - xlv_TEXCOORD4);
    tmpvar_17 = sqrt(dot (p_18, p_18));
    avgHeight_2 = ((0.75 * min (tmpvar_17, tmpvar_12)) + (0.25 * max (tmpvar_17, tmpvar_12)));
  } else {
    if (((tmpvar_10 <= _SphereRadius) && (tmpvar_9 >= 0.0))) {
      float oldDepth_19;
      float tmpvar_20;
      tmpvar_20 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_11));
      float tmpvar_21;
      tmpvar_21 = clamp ((_SphereRadius - tmpvar_12), 0.0, 1.0);
      float tmpvar_22;
      tmpvar_22 = mix ((tmpvar_9 - tmpvar_20), (tmpvar_20 + tmpvar_9), tmpvar_21);
      sphereDist_4 = tmpvar_22;
      float tmpvar_23;
      tmpvar_23 = min ((tmpvar_9 + tmpvar_20), depth_5);
      oldDepth_19 = depth_5;
      float tmpvar_24;
      tmpvar_24 = min (depth_5, tmpvar_22);
      norm_1 = normalize(((_WorldSpaceCameraPos + (tmpvar_24 * tmpvar_8)) - xlv_TEXCOORD4));
      depth_5 = mix ((tmpvar_23 - tmpvar_22), min (tmpvar_24, tmpvar_22), tmpvar_21);
      float tmpvar_25;
      vec3 p_26;
      p_26 = ((_WorldSpaceCameraPos + (tmpvar_23 * tmpvar_8)) - xlv_TEXCOORD4);
      tmpvar_25 = sqrt(dot (p_26, p_26));
      float tmpvar_27;
      tmpvar_27 = mix (mix (_SphereRadius, tmpvar_10, (tmpvar_23 - oldDepth_19)), tmpvar_12, tmpvar_21);
      avgHeight_2 = ((0.75 * min (tmpvar_25, tmpvar_27)) + (0.25 * max (tmpvar_25, tmpvar_27)));
    };
  };
  float tmpvar_28;
  tmpvar_28 = (mix (0.0, depth_5, clamp (sphereDist_4, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_5 = tmpvar_28;
  color_6.w = (_Color.w * (tmpvar_28 * max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_1, normalize(_WorldSpaceLightPos0).xyz)) * 4.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x), 0.0, 1.0)).x))));
  gl_FragData[0] = color_6;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_OceanRadius]
Vector 16 [_PlanetOrigin]
"vs_3_0
; 33 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
dcl_texcoord6 o6
dcl_texcoord7 o7
dcl_texcoord8 o8
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.w, v0, c7
mov r1.w, r2
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
mov o0, r1
mov r1.xyz, c12
add r1.xyz, -c16, r1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c12
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov o2.xyz, r0
dp3 r1.x, r1, r1
rsq r0.x, r1.x
rcp r0.x, r0.x
add o7.x, r0, -c15
mov r0.xyz, c16
mul o5.xyz, r0.w, r2
rcp o6.x, r0.w
dp4 r0.w, v0, c2
mov o4.xyz, c16
add o8.xyz, -c12, r0
mov o1.z, -r0.w
mov o1.w, r2
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  lowp float tmpvar_36;
  mediump float lightShadowDataX_37;
  highp float dist_38;
  lowp float tmpvar_39;
  tmpvar_39 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_38 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = _LightShadowData.x;
  lightShadowDataX_37 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = max (float((dist_38 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_37);
  tmpvar_36 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * tmpvar_36), 0.0, 1.0)).x));
  highp float tmpvar_44;
  tmpvar_44 = (color_9.w * (tmpvar_42 * tmpvar_43));
  color_9.w = tmpvar_44;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  highp float tmpvar_37;
  tmpvar_37 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * tmpvar_36.x), 0.0, 1.0)).x));
  highp float tmpvar_39;
  tmpvar_39 = (color_9.w * (tmpvar_37 * tmpvar_38));
  color_9.w = tmpvar_39;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 443
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 434
    o.worldOrigin = _PlanetOrigin;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 438
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 443
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 443
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 447
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 451
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 455
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 459
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 463
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 467
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        #line 471
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 478
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 482
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 486
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 491
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 495
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 499
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying float xlv_TEXCOORD7;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform float _OceanRadius;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_9;
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_2 * 0.5);
  vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 norm_1;
  float avgHeight_2;
  float oceanSphereDist_3;
  float sphereDist_4;
  float depth_5;
  vec4 color_6;
  color_6 = _Color;
  float tmpvar_7;
  tmpvar_7 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_5 = tmpvar_7;
  sphereDist_4 = 0.0;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD8, tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_9 * tmpvar_9)));
  float tmpvar_11;
  tmpvar_11 = pow (tmpvar_10, 2.0);
  float tmpvar_12;
  tmpvar_12 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_3 = tmpvar_7;
  if (((tmpvar_10 <= _OceanRadius) && (tmpvar_9 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_9 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_11)));
  };
  float tmpvar_13;
  tmpvar_13 = min (oceanSphereDist_3, tmpvar_7);
  depth_5 = tmpvar_13;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_12 < _SphereRadius) && (tmpvar_9 < 0.0))) {
    float tmpvar_14;
    tmpvar_14 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_11)) - sqrt((pow (tmpvar_12, 2.0) - tmpvar_11)));
    sphereDist_4 = tmpvar_14;
    float tmpvar_15;
    tmpvar_15 = min (tmpvar_13, tmpvar_14);
    depth_5 = tmpvar_15;
    vec3 tmpvar_16;
    tmpvar_16 = (_WorldSpaceCameraPos + (tmpvar_15 * tmpvar_8));
    norm_1 = normalize((tmpvar_16 - xlv_TEXCOORD4));
    float tmpvar_17;
    vec3 p_18;
    p_18 = (tmpvar_16 - xlv_TEXCOORD4);
    tmpvar_17 = sqrt(dot (p_18, p_18));
    avgHeight_2 = ((0.75 * min (tmpvar_17, tmpvar_12)) + (0.25 * max (tmpvar_17, tmpvar_12)));
  } else {
    if (((tmpvar_10 <= _SphereRadius) && (tmpvar_9 >= 0.0))) {
      float oldDepth_19;
      float tmpvar_20;
      tmpvar_20 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_11));
      float tmpvar_21;
      tmpvar_21 = clamp ((_SphereRadius - tmpvar_12), 0.0, 1.0);
      float tmpvar_22;
      tmpvar_22 = mix ((tmpvar_9 - tmpvar_20), (tmpvar_20 + tmpvar_9), tmpvar_21);
      sphereDist_4 = tmpvar_22;
      float tmpvar_23;
      tmpvar_23 = min ((tmpvar_9 + tmpvar_20), depth_5);
      oldDepth_19 = depth_5;
      float tmpvar_24;
      tmpvar_24 = min (depth_5, tmpvar_22);
      norm_1 = normalize(((_WorldSpaceCameraPos + (tmpvar_24 * tmpvar_8)) - xlv_TEXCOORD4));
      depth_5 = mix ((tmpvar_23 - tmpvar_22), min (tmpvar_24, tmpvar_22), tmpvar_21);
      float tmpvar_25;
      vec3 p_26;
      p_26 = ((_WorldSpaceCameraPos + (tmpvar_23 * tmpvar_8)) - xlv_TEXCOORD4);
      tmpvar_25 = sqrt(dot (p_26, p_26));
      float tmpvar_27;
      tmpvar_27 = mix (mix (_SphereRadius, tmpvar_10, (tmpvar_23 - oldDepth_19)), tmpvar_12, tmpvar_21);
      avgHeight_2 = ((0.75 * min (tmpvar_25, tmpvar_27)) + (0.25 * max (tmpvar_25, tmpvar_27)));
    };
  };
  float tmpvar_28;
  tmpvar_28 = (mix (0.0, depth_5, clamp (sphereDist_4, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_5 = tmpvar_28;
  color_6.w = (_Color.w * (tmpvar_28 * max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_1, normalize(_WorldSpaceLightPos0).xyz)) * 4.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x), 0.0, 1.0)).x))));
  gl_FragData[0] = color_6;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_OceanRadius]
Vector 16 [_PlanetOrigin]
"vs_3_0
; 33 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
dcl_texcoord6 o6
dcl_texcoord7 o7
dcl_texcoord8 o8
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.w, v0, c7
mov r1.w, r2
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
mov o0, r1
mov r1.xyz, c12
add r1.xyz, -c16, r1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c12
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov o2.xyz, r0
dp3 r1.x, r1, r1
rsq r0.x, r1.x
rcp r0.x, r0.x
add o7.x, r0, -c15
mov r0.xyz, c16
mul o5.xyz, r0.w, r2
rcp o6.x, r0.w
dp4 r0.w, v0, c2
mov o4.xyz, c16
add o8.xyz, -c12, r0
mov o1.z, -r0.w
mov o1.w, r2
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  lowp float tmpvar_36;
  mediump float lightShadowDataX_37;
  highp float dist_38;
  lowp float tmpvar_39;
  tmpvar_39 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_38 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = _LightShadowData.x;
  lightShadowDataX_37 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = max (float((dist_38 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_37);
  tmpvar_36 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * tmpvar_36), 0.0, 1.0)).x));
  highp float tmpvar_44;
  tmpvar_44 = (color_9.w * (tmpvar_42 * tmpvar_43));
  color_9.w = tmpvar_44;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  highp float tmpvar_37;
  tmpvar_37 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * tmpvar_36.x), 0.0, 1.0)).x));
  highp float tmpvar_39;
  tmpvar_39 = (color_9.w * (tmpvar_37 * tmpvar_38));
  color_9.w = tmpvar_39;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 443
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 434
    o.worldOrigin = _PlanetOrigin;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 438
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 443
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 443
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 447
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 451
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 455
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 459
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 463
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 467
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        #line 471
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 478
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 482
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 486
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 491
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 495
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 499
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying float xlv_TEXCOORD7;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform float _OceanRadius;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_9;
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_2 * 0.5);
  vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 norm_1;
  float avgHeight_2;
  float oceanSphereDist_3;
  float sphereDist_4;
  float depth_5;
  vec4 color_6;
  color_6 = _Color;
  float tmpvar_7;
  tmpvar_7 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_5 = tmpvar_7;
  sphereDist_4 = 0.0;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD8, tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_9 * tmpvar_9)));
  float tmpvar_11;
  tmpvar_11 = pow (tmpvar_10, 2.0);
  float tmpvar_12;
  tmpvar_12 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_3 = tmpvar_7;
  if (((tmpvar_10 <= _OceanRadius) && (tmpvar_9 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_9 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_11)));
  };
  float tmpvar_13;
  tmpvar_13 = min (oceanSphereDist_3, tmpvar_7);
  depth_5 = tmpvar_13;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_12 < _SphereRadius) && (tmpvar_9 < 0.0))) {
    float tmpvar_14;
    tmpvar_14 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_11)) - sqrt((pow (tmpvar_12, 2.0) - tmpvar_11)));
    sphereDist_4 = tmpvar_14;
    float tmpvar_15;
    tmpvar_15 = min (tmpvar_13, tmpvar_14);
    depth_5 = tmpvar_15;
    vec3 tmpvar_16;
    tmpvar_16 = (_WorldSpaceCameraPos + (tmpvar_15 * tmpvar_8));
    norm_1 = normalize((tmpvar_16 - xlv_TEXCOORD4));
    float tmpvar_17;
    vec3 p_18;
    p_18 = (tmpvar_16 - xlv_TEXCOORD4);
    tmpvar_17 = sqrt(dot (p_18, p_18));
    avgHeight_2 = ((0.75 * min (tmpvar_17, tmpvar_12)) + (0.25 * max (tmpvar_17, tmpvar_12)));
  } else {
    if (((tmpvar_10 <= _SphereRadius) && (tmpvar_9 >= 0.0))) {
      float oldDepth_19;
      float tmpvar_20;
      tmpvar_20 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_11));
      float tmpvar_21;
      tmpvar_21 = clamp ((_SphereRadius - tmpvar_12), 0.0, 1.0);
      float tmpvar_22;
      tmpvar_22 = mix ((tmpvar_9 - tmpvar_20), (tmpvar_20 + tmpvar_9), tmpvar_21);
      sphereDist_4 = tmpvar_22;
      float tmpvar_23;
      tmpvar_23 = min ((tmpvar_9 + tmpvar_20), depth_5);
      oldDepth_19 = depth_5;
      float tmpvar_24;
      tmpvar_24 = min (depth_5, tmpvar_22);
      norm_1 = normalize(((_WorldSpaceCameraPos + (tmpvar_24 * tmpvar_8)) - xlv_TEXCOORD4));
      depth_5 = mix ((tmpvar_23 - tmpvar_22), min (tmpvar_24, tmpvar_22), tmpvar_21);
      float tmpvar_25;
      vec3 p_26;
      p_26 = ((_WorldSpaceCameraPos + (tmpvar_23 * tmpvar_8)) - xlv_TEXCOORD4);
      tmpvar_25 = sqrt(dot (p_26, p_26));
      float tmpvar_27;
      tmpvar_27 = mix (mix (_SphereRadius, tmpvar_10, (tmpvar_23 - oldDepth_19)), tmpvar_12, tmpvar_21);
      avgHeight_2 = ((0.75 * min (tmpvar_25, tmpvar_27)) + (0.25 * max (tmpvar_25, tmpvar_27)));
    };
  };
  float tmpvar_28;
  tmpvar_28 = (mix (0.0, depth_5, clamp (sphereDist_4, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_5 = tmpvar_28;
  color_6.w = (_Color.w * (tmpvar_28 * max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_1, normalize(_WorldSpaceLightPos0).xyz)) * 4.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x), 0.0, 1.0)).x))));
  gl_FragData[0] = color_6;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_OceanRadius]
Vector 16 [_PlanetOrigin]
"vs_3_0
; 33 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
dcl_texcoord6 o6
dcl_texcoord7 o7
dcl_texcoord8 o8
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.w, v0, c7
mov r1.w, r2
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
mov o0, r1
mov r1.xyz, c12
add r1.xyz, -c16, r1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c12
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov o2.xyz, r0
dp3 r1.x, r1, r1
rsq r0.x, r1.x
rcp r0.x, r0.x
add o7.x, r0, -c15
mov r0.xyz, c16
mul o5.xyz, r0.w, r2
rcp o6.x, r0.w
dp4 r0.w, v0, c2
mov o4.xyz, c16
add o8.xyz, -c12, r0
mov o1.z, -r0.w
mov o1.w, r2
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  lowp float tmpvar_36;
  mediump float lightShadowDataX_37;
  highp float dist_38;
  lowp float tmpvar_39;
  tmpvar_39 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_38 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = _LightShadowData.x;
  lightShadowDataX_37 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = max (float((dist_38 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_37);
  tmpvar_36 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * tmpvar_36), 0.0, 1.0)).x));
  highp float tmpvar_44;
  tmpvar_44 = (color_9.w * (tmpvar_42 * tmpvar_43));
  color_9.w = tmpvar_44;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  highp float tmpvar_37;
  tmpvar_37 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * tmpvar_36.x), 0.0, 1.0)).x));
  highp float tmpvar_39;
  tmpvar_39 = (color_9.w * (tmpvar_37 * tmpvar_38));
  color_9.w = tmpvar_39;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 443
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 434
    o.worldOrigin = _PlanetOrigin;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 438
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 443
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 443
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 447
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 451
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 455
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 459
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 463
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 467
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        #line 471
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 478
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 482
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 486
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 491
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 495
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 499
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying float xlv_TEXCOORD7;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform float _OceanRadius;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 norm_1;
  float avgHeight_2;
  float oceanSphereDist_3;
  float sphereDist_4;
  float depth_5;
  vec4 color_6;
  color_6 = _Color;
  float tmpvar_7;
  tmpvar_7 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_5 = tmpvar_7;
  sphereDist_4 = 0.0;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD8, tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_9 * tmpvar_9)));
  float tmpvar_11;
  tmpvar_11 = pow (tmpvar_10, 2.0);
  float tmpvar_12;
  tmpvar_12 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_3 = tmpvar_7;
  if (((tmpvar_10 <= _OceanRadius) && (tmpvar_9 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_9 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_11)));
  };
  float tmpvar_13;
  tmpvar_13 = min (oceanSphereDist_3, tmpvar_7);
  depth_5 = tmpvar_13;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_12 < _SphereRadius) && (tmpvar_9 < 0.0))) {
    float tmpvar_14;
    tmpvar_14 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_11)) - sqrt((pow (tmpvar_12, 2.0) - tmpvar_11)));
    sphereDist_4 = tmpvar_14;
    float tmpvar_15;
    tmpvar_15 = min (tmpvar_13, tmpvar_14);
    depth_5 = tmpvar_15;
    vec3 tmpvar_16;
    tmpvar_16 = (_WorldSpaceCameraPos + (tmpvar_15 * tmpvar_8));
    norm_1 = normalize((tmpvar_16 - xlv_TEXCOORD4));
    float tmpvar_17;
    vec3 p_18;
    p_18 = (tmpvar_16 - xlv_TEXCOORD4);
    tmpvar_17 = sqrt(dot (p_18, p_18));
    avgHeight_2 = ((0.75 * min (tmpvar_17, tmpvar_12)) + (0.25 * max (tmpvar_17, tmpvar_12)));
  } else {
    if (((tmpvar_10 <= _SphereRadius) && (tmpvar_9 >= 0.0))) {
      float oldDepth_19;
      float tmpvar_20;
      tmpvar_20 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_11));
      float tmpvar_21;
      tmpvar_21 = clamp ((_SphereRadius - tmpvar_12), 0.0, 1.0);
      float tmpvar_22;
      tmpvar_22 = mix ((tmpvar_9 - tmpvar_20), (tmpvar_20 + tmpvar_9), tmpvar_21);
      sphereDist_4 = tmpvar_22;
      float tmpvar_23;
      tmpvar_23 = min ((tmpvar_9 + tmpvar_20), depth_5);
      oldDepth_19 = depth_5;
      float tmpvar_24;
      tmpvar_24 = min (depth_5, tmpvar_22);
      norm_1 = normalize(((_WorldSpaceCameraPos + (tmpvar_24 * tmpvar_8)) - xlv_TEXCOORD4));
      depth_5 = mix ((tmpvar_23 - tmpvar_22), min (tmpvar_24, tmpvar_22), tmpvar_21);
      float tmpvar_25;
      vec3 p_26;
      p_26 = ((_WorldSpaceCameraPos + (tmpvar_23 * tmpvar_8)) - xlv_TEXCOORD4);
      tmpvar_25 = sqrt(dot (p_26, p_26));
      float tmpvar_27;
      tmpvar_27 = mix (mix (_SphereRadius, tmpvar_10, (tmpvar_23 - oldDepth_19)), tmpvar_12, tmpvar_21);
      avgHeight_2 = ((0.75 * min (tmpvar_25, tmpvar_27)) + (0.25 * max (tmpvar_25, tmpvar_27)));
    };
  };
  float tmpvar_28;
  tmpvar_28 = (mix (0.0, depth_5, clamp (sphereDist_4, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_5 = tmpvar_28;
  color_6.w = (_Color.w * (tmpvar_28 * max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_1, normalize(_WorldSpaceLightPos0).xyz)) * 4.0), 0.0, 1.0)).x))));
  gl_FragData[0] = color_6;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_OceanRadius]
Vector 16 [_PlanetOrigin]
"vs_3_0
; 30 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
dcl_texcoord6 o5
dcl_texcoord7 o6
dcl_texcoord8 o7
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
mov r1.w, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
mul r0.y, r0, c13.x
mad o1.xy, r0.z, c14.zwzw, r0
dp4 r1.z, v0, c6
mov o0, r1
mov r1.xyz, c12
add r1.xyz, -c16, r1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c12
dp3 r1.w, r2, r2
rsq r1.w, r1.w
dp3 r1.x, r1, r1
mov o2.xyz, r0
rsq r0.x, r1.x
rcp r0.x, r0.x
add o6.x, r0, -c15
mov r0.xyz, c16
dp4 r1.x, v0, c2
mul o4.xyz, r1.w, r2
mov o3.xyz, c16
rcp o5.x, r1.w
add o7.xyz, -c12, r0
mov o1.z, -r1.x
mov o1.w, r0
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0), 0.0, 1.0)).x));
  highp float tmpvar_38;
  tmpvar_38 = (color_9.w * (tmpvar_36 * tmpvar_37));
  color_9.w = tmpvar_38;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, max (0.0, (_LightColor0.xyz * clamp (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0), 0.0, 1.0)).x));
  highp float tmpvar_38;
  tmpvar_38 = (color_9.w * (tmpvar_36 * tmpvar_37));
  color_9.w = tmpvar_38;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 393
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 397
uniform highp vec3 _PlanetOrigin;
#line 417
#line 433
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 417
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 421
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 425
    o.worldOrigin = _PlanetOrigin;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 429
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 398
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 393
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 397
uniform highp vec3 _PlanetOrigin;
#line 417
#line 433
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 433
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 437
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 441
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 445
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 449
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 453
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 457
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        #line 461
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 468
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 472
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 476
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 481
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = 1.0;
    #line 485
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 489
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying float xlv_TEXCOORD7;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform float _OceanRadius;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_9;
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_2 * 0.5);
  vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 norm_1;
  float avgHeight_2;
  float oceanSphereDist_3;
  float sphereDist_4;
  float depth_5;
  vec4 color_6;
  color_6 = _Color;
  float tmpvar_7;
  tmpvar_7 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_5 = tmpvar_7;
  sphereDist_4 = 0.0;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD8, tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_9 * tmpvar_9)));
  float tmpvar_11;
  tmpvar_11 = pow (tmpvar_10, 2.0);
  float tmpvar_12;
  tmpvar_12 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_3 = tmpvar_7;
  if (((tmpvar_10 <= _OceanRadius) && (tmpvar_9 >= 0.0))) {
    oceanSphereDist_3 = (tmpvar_9 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_11)));
  };
  float tmpvar_13;
  tmpvar_13 = min (oceanSphereDist_3, tmpvar_7);
  depth_5 = tmpvar_13;
  avgHeight_2 = _SphereRadius;
  if (((tmpvar_12 < _SphereRadius) && (tmpvar_9 < 0.0))) {
    float tmpvar_14;
    tmpvar_14 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_11)) - sqrt((pow (tmpvar_12, 2.0) - tmpvar_11)));
    sphereDist_4 = tmpvar_14;
    float tmpvar_15;
    tmpvar_15 = min (tmpvar_13, tmpvar_14);
    depth_5 = tmpvar_15;
    vec3 tmpvar_16;
    tmpvar_16 = (_WorldSpaceCameraPos + (tmpvar_15 * tmpvar_8));
    norm_1 = normalize((tmpvar_16 - xlv_TEXCOORD4));
    float tmpvar_17;
    vec3 p_18;
    p_18 = (tmpvar_16 - xlv_TEXCOORD4);
    tmpvar_17 = sqrt(dot (p_18, p_18));
    avgHeight_2 = ((0.75 * min (tmpvar_17, tmpvar_12)) + (0.25 * max (tmpvar_17, tmpvar_12)));
  } else {
    if (((tmpvar_10 <= _SphereRadius) && (tmpvar_9 >= 0.0))) {
      float oldDepth_19;
      float tmpvar_20;
      tmpvar_20 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_11));
      float tmpvar_21;
      tmpvar_21 = clamp ((_SphereRadius - tmpvar_12), 0.0, 1.0);
      float tmpvar_22;
      tmpvar_22 = mix ((tmpvar_9 - tmpvar_20), (tmpvar_20 + tmpvar_9), tmpvar_21);
      sphereDist_4 = tmpvar_22;
      float tmpvar_23;
      tmpvar_23 = min ((tmpvar_9 + tmpvar_20), depth_5);
      oldDepth_19 = depth_5;
      float tmpvar_24;
      tmpvar_24 = min (depth_5, tmpvar_22);
      norm_1 = normalize(((_WorldSpaceCameraPos + (tmpvar_24 * tmpvar_8)) - xlv_TEXCOORD4));
      depth_5 = mix ((tmpvar_23 - tmpvar_22), min (tmpvar_24, tmpvar_22), tmpvar_21);
      float tmpvar_25;
      vec3 p_26;
      p_26 = ((_WorldSpaceCameraPos + (tmpvar_23 * tmpvar_8)) - xlv_TEXCOORD4);
      tmpvar_25 = sqrt(dot (p_26, p_26));
      float tmpvar_27;
      tmpvar_27 = mix (mix (_SphereRadius, tmpvar_10, (tmpvar_23 - oldDepth_19)), tmpvar_12, tmpvar_21);
      avgHeight_2 = ((0.75 * min (tmpvar_25, tmpvar_27)) + (0.25 * max (tmpvar_25, tmpvar_27)));
    };
  };
  float tmpvar_28;
  tmpvar_28 = (mix (0.0, depth_5, clamp (sphereDist_4, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_2 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_5 = tmpvar_28;
  color_6.w = (_Color.w * (tmpvar_28 * max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_1, normalize(_WorldSpaceLightPos0).xyz)) * 4.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x), 0.0, 1.0)).x))));
  gl_FragData[0] = color_6;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_OceanRadius]
Vector 16 [_PlanetOrigin]
"vs_3_0
; 33 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
dcl_texcoord6 o6
dcl_texcoord7 o7
dcl_texcoord8 o8
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.w, v0, c7
mov r1.w, r2
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
mov o0, r1
mov r1.xyz, c12
add r1.xyz, -c16, r1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r2.xyz, -r0, c12
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov o2.xyz, r0
dp3 r1.x, r1, r1
rsq r0.x, r1.x
rcp r0.x, r0.x
add o7.x, r0, -c15
mov r0.xyz, c16
mul o5.xyz, r0.w, r2
rcp o6.x, r0.w
dp4 r0.w, v0, c2
mov o4.xyz, c16
add o8.xyz, -c12, r0
mov o1.z, -r0.w
mov o1.w, r2
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  lowp float tmpvar_36;
  mediump float lightShadowDataX_37;
  highp float dist_38;
  lowp float tmpvar_39;
  tmpvar_39 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_38 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = _LightShadowData.x;
  lightShadowDataX_37 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = max (float((dist_38 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_37);
  tmpvar_36 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * tmpvar_36), 0.0, 1.0)).x));
  highp float tmpvar_44;
  tmpvar_44 = (color_9.w * (tmpvar_42 * tmpvar_43));
  color_9.w = tmpvar_44;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  highp float tmpvar_37;
  tmpvar_37 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * tmpvar_36.x), 0.0, 1.0)).x));
  highp float tmpvar_39;
  tmpvar_39 = (color_9.w * (tmpvar_37 * tmpvar_38));
  color_9.w = tmpvar_39;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 443
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 434
    o.worldOrigin = _PlanetOrigin;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 438
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 443
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 443
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 447
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 451
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 455
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 459
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 463
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 467
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        #line 471
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 478
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 482
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 486
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 491
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 495
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 499
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  lowp float shadow_36;
  lowp float tmpvar_37;
  tmpvar_37 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_38;
  tmpvar_38 = (_LightShadowData.x + (tmpvar_37 * (1.0 - _LightShadowData.x)));
  shadow_36 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * shadow_36), 0.0, 1.0)).x));
  highp float tmpvar_41;
  tmpvar_41 = (color_9.w * (tmpvar_39 * tmpvar_40));
  color_9.w = tmpvar_41;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 443
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 434
    o.worldOrigin = _PlanetOrigin;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 438
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 443
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 443
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 447
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 451
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 455
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 459
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 463
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 467
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        #line 471
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 478
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 482
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 486
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 491
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 495
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 499
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  lowp float shadow_36;
  lowp float tmpvar_37;
  tmpvar_37 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_38;
  tmpvar_38 = (_LightShadowData.x + (tmpvar_37 * (1.0 - _LightShadowData.x)));
  shadow_36 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * shadow_36), 0.0, 1.0)).x));
  highp float tmpvar_41;
  tmpvar_41 = (color_9.w * (tmpvar_39 * tmpvar_40));
  color_9.w = tmpvar_41;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 443
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 434
    o.worldOrigin = _PlanetOrigin;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 438
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 443
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 443
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 447
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 451
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 455
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 459
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 463
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 467
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        #line 471
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 478
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 482
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 486
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 491
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 495
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 499
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  lowp float shadow_36;
  lowp float tmpvar_37;
  tmpvar_37 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_38;
  tmpvar_38 = (_LightShadowData.x + (tmpvar_37 * (1.0 - _LightShadowData.x)));
  shadow_36 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * shadow_36), 0.0, 1.0)).x));
  highp float tmpvar_41;
  tmpvar_41 = (color_9.w * (tmpvar_39 * tmpvar_40));
  color_9.w = tmpvar_41;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 443
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 434
    o.worldOrigin = _PlanetOrigin;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 438
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 443
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 443
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 447
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 451
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 455
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 459
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 463
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 467
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        #line 471
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 478
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 482
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 486
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 491
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 495
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 499
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD8;
varying highp float xlv_TEXCOORD7;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
uniform highp float _OceanRadius;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (_PlanetOrigin - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD7 = (sqrt(dot (p_5, p_5)) - _OceanRadius);
  xlv_TEXCOORD8 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _SphereRadius;
uniform highp float _OceanRadius;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ZBufferParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 lightDirection_2;
  mediump vec3 norm_3;
  highp float avgHeight_4;
  highp float oceanSphereDist_5;
  mediump vec3 worldDir_6;
  highp float sphereDist_7;
  highp float depth_8;
  mediump vec4 color_9;
  color_9 = _Color;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_8 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * depth_8) + _ZBufferParams.w)));
  depth_8 = tmpvar_11;
  sphereDist_7 = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD8, worldDir_6);
  highp float tmpvar_14;
  tmpvar_14 = sqrt((dot (xlv_TEXCOORD8, xlv_TEXCOORD8) - (tmpvar_13 * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = pow (tmpvar_14, 2.0);
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (xlv_TEXCOORD8, xlv_TEXCOORD8));
  oceanSphereDist_5 = tmpvar_11;
  if (((tmpvar_14 <= _OceanRadius) && (tmpvar_13 >= 0.0))) {
    oceanSphereDist_5 = (tmpvar_13 - sqrt((pow (_OceanRadius, 2.0) - tmpvar_15)));
  };
  highp float tmpvar_17;
  tmpvar_17 = min (oceanSphereDist_5, tmpvar_11);
  depth_8 = tmpvar_17;
  avgHeight_4 = _SphereRadius;
  if (((tmpvar_16 < _SphereRadius) && (tmpvar_13 < 0.0))) {
    highp float tmpvar_18;
    tmpvar_18 = (sqrt((pow (_SphereRadius, 2.0) - tmpvar_15)) - sqrt((pow (tmpvar_16, 2.0) - tmpvar_15)));
    sphereDist_7 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = min (tmpvar_17, tmpvar_18);
    depth_8 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = (_WorldSpaceCameraPos + (tmpvar_19 * worldDir_6));
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((tmpvar_20 - xlv_TEXCOORD4));
    norm_3 = tmpvar_21;
    highp float tmpvar_22;
    highp vec3 p_23;
    p_23 = (tmpvar_20 - xlv_TEXCOORD4);
    tmpvar_22 = sqrt(dot (p_23, p_23));
    avgHeight_4 = ((0.75 * min (tmpvar_22, tmpvar_16)) + (0.25 * max (tmpvar_22, tmpvar_16)));
  } else {
    if (((tmpvar_14 <= _SphereRadius) && (tmpvar_13 >= 0.0))) {
      highp float oldDepth_24;
      mediump float sphereCheck_25;
      highp float tmpvar_26;
      tmpvar_26 = sqrt((pow (_SphereRadius, 2.0) - tmpvar_15));
      highp float tmpvar_27;
      tmpvar_27 = clamp ((_SphereRadius - tmpvar_16), 0.0, 1.0);
      sphereCheck_25 = tmpvar_27;
      highp float tmpvar_28;
      tmpvar_28 = mix ((tmpvar_13 - tmpvar_26), (tmpvar_26 + tmpvar_13), sphereCheck_25);
      sphereDist_7 = tmpvar_28;
      highp float tmpvar_29;
      tmpvar_29 = min ((tmpvar_13 + tmpvar_26), depth_8);
      oldDepth_24 = depth_8;
      highp float tmpvar_30;
      tmpvar_30 = min (depth_8, tmpvar_28);
      highp vec3 tmpvar_31;
      tmpvar_31 = normalize(((_WorldSpaceCameraPos + (tmpvar_30 * worldDir_6)) - xlv_TEXCOORD4));
      norm_3 = tmpvar_31;
      depth_8 = mix ((tmpvar_29 - tmpvar_28), min (tmpvar_30, tmpvar_28), sphereCheck_25);
      highp float tmpvar_32;
      highp vec3 p_33;
      p_33 = ((_WorldSpaceCameraPos + (tmpvar_29 * worldDir_6)) - xlv_TEXCOORD4);
      tmpvar_32 = sqrt(dot (p_33, p_33));
      highp float tmpvar_34;
      tmpvar_34 = mix (mix (_SphereRadius, tmpvar_14, (tmpvar_29 - oldDepth_24)), tmpvar_16, sphereCheck_25);
      avgHeight_4 = ((0.75 * min (tmpvar_32, tmpvar_34)) + (0.25 * max (tmpvar_32, tmpvar_34)));
    };
  };
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_35;
  lowp float shadow_36;
  lowp float tmpvar_37;
  tmpvar_37 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_38;
  tmpvar_38 = (_LightShadowData.x + (tmpvar_37 * (1.0 - _LightShadowData.x)));
  shadow_36 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (mix (0.0, depth_8, clamp (sphereDist_7, 0.0, 1.0)) * (_Visibility * (1.0 - clamp (((avgHeight_4 - _OceanRadius) / (_SphereRadius - _OceanRadius)), 0.0, 1.0))));
  depth_8 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = max (0.0, max (0.0, (_LightColor0.xyz * clamp ((((_LightColor0.w * dot (norm_3, lightDirection_2)) * 4.0) * shadow_36), 0.0, 1.0)).x));
  highp float tmpvar_41;
  tmpvar_41 = (color_9.w * (tmpvar_39 * tmpvar_40));
  color_9.w = tmpvar_41;
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 443
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 426
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 430
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 434
    o.worldOrigin = _PlanetOrigin;
    o.altitude = (distance( o.worldOrigin, _WorldSpaceCameraPos) - _OceanRadius);
    o.L = (o.worldOrigin - _WorldSpaceCameraPos);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 438
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp float xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD4 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = float(xl_retval.viewDist);
    xlv_TEXCOORD7 = float(xl_retval.altitude);
    xlv_TEXCOORD8 = vec3(xl_retval.L);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 L;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform lowp vec4 _Color;
uniform lowp vec4 _SunsetColor;
#line 401
uniform sampler2D _CameraDepthTexture;
uniform highp float _Visibility;
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
#line 405
uniform highp vec3 _PlanetOrigin;
#line 426
#line 443
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 443
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 447
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    highp float sphereDist = 0.0;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos));
    #line 451
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    #line 455
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - d2));
        #line 459
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float avgHeight = _SphereRadius;
    #line 463
    mediump vec3 norm;
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        highp float tlc_1 = sqrt((pow( _SphereRadius, 2.0) - d2));
        #line 467
        highp float td = sqrt((pow( Llength, 2.0) - d2));
        sphereDist = (tlc_1 - td);
        depth = min( depth, sphereDist);
        highp vec3 point = (_WorldSpaceCameraPos + (depth * worldDir));
        #line 471
        norm = normalize((point - IN.worldOrigin));
        highp float height1 = distance( point, IN.worldOrigin);
        highp float height2 = Llength;
        avgHeight = ((0.75 * min( height1, height2)) + (0.25 * max( height1, height2)));
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 478
            highp float tlc_2 = sqrt((pow( _SphereRadius, 2.0) - d2));
            mediump float sphereCheck = xll_saturate_f((_SphereRadius - Llength));
            sphereDist = mix( (tc - tlc_2), (tlc_2 + tc), sphereCheck);
            highp float minFar = min( (tc + tlc_2), depth);
            #line 482
            highp float oldDepth = depth;
            highp float depthMin = min( depth, sphereDist);
            highp vec3 point_1 = (_WorldSpaceCameraPos + (depthMin * worldDir));
            norm = normalize((point_1 - IN.worldOrigin));
            #line 486
            depth = mix( (minFar - sphereDist), min( depthMin, sphereDist), sphereCheck);
            highp float height1_1 = distance( (_WorldSpaceCameraPos + (minFar * worldDir)), IN.worldOrigin);
            highp float height2_1 = mix( mix( _SphereRadius, d, (minFar - oldDepth)), Llength, sphereCheck);
            avgHeight = ((0.75 * min( height1_1, height2_1)) + (0.25 * max( height1_1, height2_1)));
        }
    }
    #line 491
    depth = mix( 0.0, depth, xll_saturate_f(sphereDist));
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 495
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * NdotL) * 4.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    mediump float VdotL = dot( (-worldDir), lightDirection);
    #line 499
    depth *= (_Visibility * (1.0 - xll_saturate_f(((avgHeight - _OceanRadius) / (_SphereRadius - _OceanRadius)))));
    color.w *= (depth * max( 0.0, float( light)));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp float xlv_TEXCOORD6;
in highp float xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDist = float(xlv_TEXCOORD6);
    xlt_IN.altitude = float(xlv_TEXCOORD7);
    xlt_IN.L = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 12
//   d3d9 - ALU: 107 to 110, TEX: 1 to 2, FLOW: 2 to 2
SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_Visibility]
Float 5 [_OceanRadius]
Float 6 [_SphereRadius]
"ps_3_0
; 107 ALU, 2 FLOW
def c7, 1.00000000, 0.00000000, 100000003318135350000000000000000.00000000, 0.25000000
def c8, 0.75000000, 4.00000000, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord4 v1.xyz
dcl_texcoord8 v2.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r2.x, r0, v2
dp3 r0.w, v2, v2
mad r1.w, -r2.x, r2.x, r0
rsq r1.w, r1.w
rcp r1.w, r1.w
mul r2.y, r1.w, r1.w
mad r2.z, c5.x, c5.x, -r2.y
rsq r3.x, r2.z
add r2.z, -r1.w, c5.x
rsq r0.w, r0.w
cmp r2.w, r2.x, c7.x, c7.y
cmp r2.z, r2, c7.x, c7.y
mul_pp r2.z, r2, r2.w
rcp r2.w, r3.x
add r2.w, r2.x, -r2
cmp r2.z, -r2, c7, r2.w
rcp r0.w, r0.w
add r2.w, r0, -c6.x
cmp r2.w, r2, c7.y, c7.x
cmp r3.x, r2, c7.y, c7
mul_pp r3.x, r2.w, r3
min r2.w, r2.z, c7.z
if_gt r3.x, c7.y
mad r1.y, r0.w, r0.w, -r2
mad r1.x, c6, c6, -r2.y
rsq r1.y, r1.y
rsq r1.x, r1.x
rcp r1.y, r1.y
rcp r1.x, r1.x
add r3.x, r1, -r1.y
min r2.w, r3.x, r2
mad r0.xyz, r2.w, r0, c0
add r0.xyz, r0, -v1
dp3 r1.x, r0, r0
rsq r1.x, r1.x
rcp r1.w, r1.x
mul r1.xyz, r1.x, r0
max r2.x, r0.w, r1.w
mul r0.y, r2.x, c7.w
min r0.x, r0.w, r1.w
mad r0.x, r0, c8, r0.y
else
mad r2.y, c6.x, c6.x, -r2
rsq r2.y, r2.y
rcp r2.y, r2.y
add r2.z, r2.x, -r2.y
add r4.x, r2, r2.y
add r2.y, r4.x, -r2.z
add_sat r3.z, -r0.w, c6.x
mad r3.x, r3.z, r2.y, r2.z
min r4.x, r4, r2.w
add r2.y, -r1.w, c6.x
cmp r2.z, r2.x, c7.x, c7.y
cmp r2.x, r2.y, c7, c7.y
mul_pp r3.y, r2.x, r2.z
cmp r3.x, -r3.y, c7.y, r3
min r3.w, r3.x, r2
mad r2.xyz, r3.w, r0, c0
add r2.xyz, r2, -v1
dp3 r4.y, r2, r2
rsq r4.y, r4.y
mul r2.xyz, r4.y, r2
mad r0.xyz, r0, r4.x, c0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
cmp_pp r1.xyz, -r3.y, r1, r2
add r2.x, r1.w, -c6
add r1.w, -r2, r4.x
mad r1.w, r1, r2.x, c6.x
add r0.y, r0.w, -r1.w
mad r0.w, r3.z, r0.y, r1
max r1.w, r0.z, r0
add r0.y, -r3.x, r4.x
min r0.x, r3, r3.w
add r0.x, r0, -r0.y
mad r0.y, r3.z, r0.x, r0
mul r1.w, r1, c7
min r0.z, r0, r0.w
mad r0.z, r0, c8.x, r1.w
cmp r0.x, -r3.y, c6, r0.z
cmp r2.w, -r3.y, r2, r0.y
endif
dp4_pp r0.y, c1, c1
rsq_pp r0.y, r0.y
mul_pp r2.xyz, r0.y, c1
dp3_pp r0.y, r1, r2
mul_pp r0.y, r0, c2.w
mul_pp_sat r0.z, r0.y, c8.y
mov r0.y, c6.x
mul_pp r0.z, r0, c2.x
add r0.y, -c5.x, r0
max r0.z, r0, c7.y
rcp r0.y, r0.y
add r0.x, r0, -c5
mul_sat r0.x, r0, r0.y
add r0.y, -r0.x, c7.x
mov_sat r0.x, r3
max r0.z, r0, c7.y
mul r0.y, r0, c4.x
mul r0.x, r0, r2.w
mul r0.x, r0, r0.y
mul r0.x, r0, r0.z
mul_pp oC0.w, r0.x, c3
mov_pp oC0.xyz, c3
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_Visibility]
Float 5 [_OceanRadius]
Float 6 [_SphereRadius]
"ps_3_0
; 107 ALU, 2 FLOW
def c7, 1.00000000, 0.00000000, 100000003318135350000000000000000.00000000, 0.25000000
def c8, 0.75000000, 4.00000000, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord4 v1.xyz
dcl_texcoord8 v2.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r2.x, r0, v2
dp3 r0.w, v2, v2
mad r1.w, -r2.x, r2.x, r0
rsq r1.w, r1.w
rcp r1.w, r1.w
mul r2.y, r1.w, r1.w
mad r2.z, c5.x, c5.x, -r2.y
rsq r3.x, r2.z
add r2.z, -r1.w, c5.x
rsq r0.w, r0.w
cmp r2.w, r2.x, c7.x, c7.y
cmp r2.z, r2, c7.x, c7.y
mul_pp r2.z, r2, r2.w
rcp r2.w, r3.x
add r2.w, r2.x, -r2
cmp r2.z, -r2, c7, r2.w
rcp r0.w, r0.w
add r2.w, r0, -c6.x
cmp r2.w, r2, c7.y, c7.x
cmp r3.x, r2, c7.y, c7
mul_pp r3.x, r2.w, r3
min r2.w, r2.z, c7.z
if_gt r3.x, c7.y
mad r1.y, r0.w, r0.w, -r2
mad r1.x, c6, c6, -r2.y
rsq r1.y, r1.y
rsq r1.x, r1.x
rcp r1.y, r1.y
rcp r1.x, r1.x
add r3.x, r1, -r1.y
min r2.w, r3.x, r2
mad r0.xyz, r2.w, r0, c0
add r0.xyz, r0, -v1
dp3 r1.x, r0, r0
rsq r1.x, r1.x
rcp r1.w, r1.x
mul r1.xyz, r1.x, r0
max r2.x, r0.w, r1.w
mul r0.y, r2.x, c7.w
min r0.x, r0.w, r1.w
mad r0.x, r0, c8, r0.y
else
mad r2.y, c6.x, c6.x, -r2
rsq r2.y, r2.y
rcp r2.y, r2.y
add r2.z, r2.x, -r2.y
add r4.x, r2, r2.y
add r2.y, r4.x, -r2.z
add_sat r3.z, -r0.w, c6.x
mad r3.x, r3.z, r2.y, r2.z
min r4.x, r4, r2.w
add r2.y, -r1.w, c6.x
cmp r2.z, r2.x, c7.x, c7.y
cmp r2.x, r2.y, c7, c7.y
mul_pp r3.y, r2.x, r2.z
cmp r3.x, -r3.y, c7.y, r3
min r3.w, r3.x, r2
mad r2.xyz, r3.w, r0, c0
add r2.xyz, r2, -v1
dp3 r4.y, r2, r2
rsq r4.y, r4.y
mul r2.xyz, r4.y, r2
mad r0.xyz, r0, r4.x, c0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
cmp_pp r1.xyz, -r3.y, r1, r2
add r2.x, r1.w, -c6
add r1.w, -r2, r4.x
mad r1.w, r1, r2.x, c6.x
add r0.y, r0.w, -r1.w
mad r0.w, r3.z, r0.y, r1
max r1.w, r0.z, r0
add r0.y, -r3.x, r4.x
min r0.x, r3, r3.w
add r0.x, r0, -r0.y
mad r0.y, r3.z, r0.x, r0
mul r1.w, r1, c7
min r0.z, r0, r0.w
mad r0.z, r0, c8.x, r1.w
cmp r0.x, -r3.y, c6, r0.z
cmp r2.w, -r3.y, r2, r0.y
endif
dp4_pp r0.y, c1, c1
rsq_pp r0.y, r0.y
mul_pp r2.xyz, r0.y, c1
dp3_pp r0.y, r1, r2
mul_pp r0.y, r0, c2.w
mul_pp_sat r0.z, r0.y, c8.y
mov r0.y, c6.x
mul_pp r0.z, r0, c2.x
add r0.y, -c5.x, r0
max r0.z, r0, c7.y
rcp r0.y, r0.y
add r0.x, r0, -c5
mul_sat r0.x, r0, r0.y
add r0.y, -r0.x, c7.x
mov_sat r0.x, r3
max r0.z, r0, c7.y
mul r0.y, r0, c4.x
mul r0.x, r0, r2.w
mul r0.x, r0, r0.y
mul r0.x, r0, r0.z
mul_pp oC0.w, r0.x, c3
mov_pp oC0.xyz, c3
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_Visibility]
Float 5 [_OceanRadius]
Float 6 [_SphereRadius]
"ps_3_0
; 107 ALU, 2 FLOW
def c7, 1.00000000, 0.00000000, 100000003318135350000000000000000.00000000, 0.25000000
def c8, 0.75000000, 4.00000000, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord4 v1.xyz
dcl_texcoord8 v2.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r2.x, r0, v2
dp3 r0.w, v2, v2
mad r1.w, -r2.x, r2.x, r0
rsq r1.w, r1.w
rcp r1.w, r1.w
mul r2.y, r1.w, r1.w
mad r2.z, c5.x, c5.x, -r2.y
rsq r3.x, r2.z
add r2.z, -r1.w, c5.x
rsq r0.w, r0.w
cmp r2.w, r2.x, c7.x, c7.y
cmp r2.z, r2, c7.x, c7.y
mul_pp r2.z, r2, r2.w
rcp r2.w, r3.x
add r2.w, r2.x, -r2
cmp r2.z, -r2, c7, r2.w
rcp r0.w, r0.w
add r2.w, r0, -c6.x
cmp r2.w, r2, c7.y, c7.x
cmp r3.x, r2, c7.y, c7
mul_pp r3.x, r2.w, r3
min r2.w, r2.z, c7.z
if_gt r3.x, c7.y
mad r1.y, r0.w, r0.w, -r2
mad r1.x, c6, c6, -r2.y
rsq r1.y, r1.y
rsq r1.x, r1.x
rcp r1.y, r1.y
rcp r1.x, r1.x
add r3.x, r1, -r1.y
min r2.w, r3.x, r2
mad r0.xyz, r2.w, r0, c0
add r0.xyz, r0, -v1
dp3 r1.x, r0, r0
rsq r1.x, r1.x
rcp r1.w, r1.x
mul r1.xyz, r1.x, r0
max r2.x, r0.w, r1.w
mul r0.y, r2.x, c7.w
min r0.x, r0.w, r1.w
mad r0.x, r0, c8, r0.y
else
mad r2.y, c6.x, c6.x, -r2
rsq r2.y, r2.y
rcp r2.y, r2.y
add r2.z, r2.x, -r2.y
add r4.x, r2, r2.y
add r2.y, r4.x, -r2.z
add_sat r3.z, -r0.w, c6.x
mad r3.x, r3.z, r2.y, r2.z
min r4.x, r4, r2.w
add r2.y, -r1.w, c6.x
cmp r2.z, r2.x, c7.x, c7.y
cmp r2.x, r2.y, c7, c7.y
mul_pp r3.y, r2.x, r2.z
cmp r3.x, -r3.y, c7.y, r3
min r3.w, r3.x, r2
mad r2.xyz, r3.w, r0, c0
add r2.xyz, r2, -v1
dp3 r4.y, r2, r2
rsq r4.y, r4.y
mul r2.xyz, r4.y, r2
mad r0.xyz, r0, r4.x, c0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
cmp_pp r1.xyz, -r3.y, r1, r2
add r2.x, r1.w, -c6
add r1.w, -r2, r4.x
mad r1.w, r1, r2.x, c6.x
add r0.y, r0.w, -r1.w
mad r0.w, r3.z, r0.y, r1
max r1.w, r0.z, r0
add r0.y, -r3.x, r4.x
min r0.x, r3, r3.w
add r0.x, r0, -r0.y
mad r0.y, r3.z, r0.x, r0
mul r1.w, r1, c7
min r0.z, r0, r0.w
mad r0.z, r0, c8.x, r1.w
cmp r0.x, -r3.y, c6, r0.z
cmp r2.w, -r3.y, r2, r0.y
endif
dp4_pp r0.y, c1, c1
rsq_pp r0.y, r0.y
mul_pp r2.xyz, r0.y, c1
dp3_pp r0.y, r1, r2
mul_pp r0.y, r0, c2.w
mul_pp_sat r0.z, r0.y, c8.y
mov r0.y, c6.x
mul_pp r0.z, r0, c2.x
add r0.y, -c5.x, r0
max r0.z, r0, c7.y
rcp r0.y, r0.y
add r0.x, r0, -c5
mul_sat r0.x, r0, r0.y
add r0.y, -r0.x, c7.x
mov_sat r0.x, r3
max r0.z, r0, c7.y
mul r0.y, r0, c4.x
mul r0.x, r0, r2.w
mul r0.x, r0, r0.y
mul r0.x, r0, r0.z
mul_pp oC0.w, r0.x, c3
mov_pp oC0.xyz, c3
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_Visibility]
Float 5 [_OceanRadius]
Float 6 [_SphereRadius]
SetTexture 0 [_ShadowMapTexture] 2D
"ps_3_0
; 108 ALU, 1 TEX, 2 FLOW
dcl_2d s0
def c7, 1.00000000, 0.00000000, 100000003318135350000000000000000.00000000, 0.25000000
def c8, 0.75000000, 4.00000000, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord2 v1
dcl_texcoord4 v2.xyz
dcl_texcoord8 v3.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r2.x, r0, v3
dp3 r0.w, v3, v3
mad r1.w, -r2.x, r2.x, r0
rsq r1.w, r1.w
rcp r1.w, r1.w
mul r2.y, r1.w, r1.w
mad r2.z, c5.x, c5.x, -r2.y
rsq r3.x, r2.z
add r2.z, -r1.w, c5.x
rsq r0.w, r0.w
cmp r2.w, r2.x, c7.x, c7.y
cmp r2.z, r2, c7.x, c7.y
mul_pp r2.z, r2, r2.w
rcp r2.w, r3.x
add r2.w, r2.x, -r2
cmp r2.z, -r2, c7, r2.w
rcp r0.w, r0.w
add r2.w, r0, -c6.x
cmp r2.w, r2, c7.y, c7.x
cmp r3.x, r2, c7.y, c7
mul_pp r3.x, r2.w, r3
min r2.w, r2.z, c7.z
if_gt r3.x, c7.y
mad r1.y, r0.w, r0.w, -r2
mad r1.x, c6, c6, -r2.y
rsq r1.y, r1.y
rsq r1.x, r1.x
rcp r1.y, r1.y
rcp r1.x, r1.x
add r3.x, r1, -r1.y
min r2.w, r3.x, r2
mad r0.xyz, r2.w, r0, c0
add r0.xyz, r0, -v2
dp3 r1.x, r0, r0
rsq r1.x, r1.x
rcp r1.w, r1.x
mul r1.xyz, r1.x, r0
max r2.x, r0.w, r1.w
mul r0.y, r2.x, c7.w
min r0.x, r0.w, r1.w
mad r0.y, r0.x, c8.x, r0
else
mad r2.y, c6.x, c6.x, -r2
rsq r2.y, r2.y
rcp r2.y, r2.y
add r2.z, r2.x, -r2.y
add r4.x, r2, r2.y
add r2.y, r4.x, -r2.z
add_sat r3.z, -r0.w, c6.x
mad r3.x, r3.z, r2.y, r2.z
min r4.x, r4, r2.w
add r2.y, -r1.w, c6.x
cmp r2.z, r2.x, c7.x, c7.y
cmp r2.x, r2.y, c7, c7.y
mul_pp r3.y, r2.x, r2.z
cmp r3.x, -r3.y, c7.y, r3
min r3.w, r3.x, r2
mad r2.xyz, r3.w, r0, c0
add r2.xyz, r2, -v2
dp3 r4.y, r2, r2
rsq r4.y, r4.y
mul r2.xyz, r4.y, r2
mad r0.xyz, r0, r4.x, c0
add r0.xyz, v2, -r0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
cmp_pp r1.xyz, -r3.y, r1, r2
add r2.x, r1.w, -c6
add r1.w, -r2, r4.x
mad r1.w, r1, r2.x, c6.x
add r0.y, r0.w, -r1.w
mad r0.w, r3.z, r0.y, r1
max r1.w, r0.z, r0
add r0.y, -r3.x, r4.x
min r0.x, r3, r3.w
add r0.x, r0, -r0.y
mad r0.x, r3.z, r0, r0.y
mul r1.w, r1, c7
min r0.z, r0, r0.w
mad r0.z, r0, c8.x, r1.w
cmp r0.y, -r3, c6.x, r0.z
cmp r2.w, -r3.y, r2, r0.x
endif
dp4_pp r0.x, c1, c1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, c1
dp3_pp r0.z, r1, r2
mul_pp r0.z, r0, c2.w
texldp r0.x, v1, s0
mul_pp r0.x, r0.z, r0
mul_pp_sat r0.z, r0.x, c8.y
mul_pp r0.z, r0, c2.x
mov r0.x, c6
add r0.x, -c5, r0
max r0.w, r0.z, c7.y
rcp r0.z, r0.x
add r0.x, r0.y, -c5
mul_sat r0.x, r0, r0.z
add r0.y, -r0.x, c7.x
mov_sat r0.x, r3
max r0.z, r0.w, c7.y
mul r0.y, r0, c4.x
mul r0.x, r0, r2.w
mul r0.x, r0, r0.y
mul r0.x, r0, r0.z
mul_pp oC0.w, r0.x, c3
mov_pp oC0.xyz, c3
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_Visibility]
Float 5 [_OceanRadius]
Float 6 [_SphereRadius]
SetTexture 0 [_ShadowMapTexture] 2D
"ps_3_0
; 108 ALU, 1 TEX, 2 FLOW
dcl_2d s0
def c7, 1.00000000, 0.00000000, 100000003318135350000000000000000.00000000, 0.25000000
def c8, 0.75000000, 4.00000000, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord2 v1
dcl_texcoord4 v2.xyz
dcl_texcoord8 v3.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r2.x, r0, v3
dp3 r0.w, v3, v3
mad r1.w, -r2.x, r2.x, r0
rsq r1.w, r1.w
rcp r1.w, r1.w
mul r2.y, r1.w, r1.w
mad r2.z, c5.x, c5.x, -r2.y
rsq r3.x, r2.z
add r2.z, -r1.w, c5.x
rsq r0.w, r0.w
cmp r2.w, r2.x, c7.x, c7.y
cmp r2.z, r2, c7.x, c7.y
mul_pp r2.z, r2, r2.w
rcp r2.w, r3.x
add r2.w, r2.x, -r2
cmp r2.z, -r2, c7, r2.w
rcp r0.w, r0.w
add r2.w, r0, -c6.x
cmp r2.w, r2, c7.y, c7.x
cmp r3.x, r2, c7.y, c7
mul_pp r3.x, r2.w, r3
min r2.w, r2.z, c7.z
if_gt r3.x, c7.y
mad r1.y, r0.w, r0.w, -r2
mad r1.x, c6, c6, -r2.y
rsq r1.y, r1.y
rsq r1.x, r1.x
rcp r1.y, r1.y
rcp r1.x, r1.x
add r3.x, r1, -r1.y
min r2.w, r3.x, r2
mad r0.xyz, r2.w, r0, c0
add r0.xyz, r0, -v2
dp3 r1.x, r0, r0
rsq r1.x, r1.x
rcp r1.w, r1.x
mul r1.xyz, r1.x, r0
max r2.x, r0.w, r1.w
mul r0.y, r2.x, c7.w
min r0.x, r0.w, r1.w
mad r0.y, r0.x, c8.x, r0
else
mad r2.y, c6.x, c6.x, -r2
rsq r2.y, r2.y
rcp r2.y, r2.y
add r2.z, r2.x, -r2.y
add r4.x, r2, r2.y
add r2.y, r4.x, -r2.z
add_sat r3.z, -r0.w, c6.x
mad r3.x, r3.z, r2.y, r2.z
min r4.x, r4, r2.w
add r2.y, -r1.w, c6.x
cmp r2.z, r2.x, c7.x, c7.y
cmp r2.x, r2.y, c7, c7.y
mul_pp r3.y, r2.x, r2.z
cmp r3.x, -r3.y, c7.y, r3
min r3.w, r3.x, r2
mad r2.xyz, r3.w, r0, c0
add r2.xyz, r2, -v2
dp3 r4.y, r2, r2
rsq r4.y, r4.y
mul r2.xyz, r4.y, r2
mad r0.xyz, r0, r4.x, c0
add r0.xyz, v2, -r0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
cmp_pp r1.xyz, -r3.y, r1, r2
add r2.x, r1.w, -c6
add r1.w, -r2, r4.x
mad r1.w, r1, r2.x, c6.x
add r0.y, r0.w, -r1.w
mad r0.w, r3.z, r0.y, r1
max r1.w, r0.z, r0
add r0.y, -r3.x, r4.x
min r0.x, r3, r3.w
add r0.x, r0, -r0.y
mad r0.x, r3.z, r0, r0.y
mul r1.w, r1, c7
min r0.z, r0, r0.w
mad r0.z, r0, c8.x, r1.w
cmp r0.y, -r3, c6.x, r0.z
cmp r2.w, -r3.y, r2, r0.x
endif
dp4_pp r0.x, c1, c1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, c1
dp3_pp r0.z, r1, r2
mul_pp r0.z, r0, c2.w
texldp r0.x, v1, s0
mul_pp r0.x, r0.z, r0
mul_pp_sat r0.z, r0.x, c8.y
mul_pp r0.z, r0, c2.x
mov r0.x, c6
add r0.x, -c5, r0
max r0.w, r0.z, c7.y
rcp r0.z, r0.x
add r0.x, r0.y, -c5
mul_sat r0.x, r0, r0.z
add r0.y, -r0.x, c7.x
mov_sat r0.x, r3
max r0.z, r0.w, c7.y
mul r0.y, r0, c4.x
mul r0.x, r0, r2.w
mul r0.x, r0, r0.y
mul r0.x, r0, r0.z
mul_pp oC0.w, r0.x, c3
mov_pp oC0.xyz, c3
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Float 4 [_Visibility]
Float 5 [_OceanRadius]
Float 6 [_SphereRadius]
SetTexture 0 [_ShadowMapTexture] 2D
"ps_3_0
; 108 ALU, 1 TEX, 2 FLOW
dcl_2d s0
def c7, 1.00000000, 0.00000000, 100000003318135350000000000000000.00000000, 0.25000000
def c8, 0.75000000, 4.00000000, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord2 v1
dcl_texcoord4 v2.xyz
dcl_texcoord8 v3.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r2.x, r0, v3
dp3 r0.w, v3, v3
mad r1.w, -r2.x, r2.x, r0
rsq r1.w, r1.w
rcp r1.w, r1.w
mul r2.y, r1.w, r1.w
mad r2.z, c5.x, c5.x, -r2.y
rsq r3.x, r2.z
add r2.z, -r1.w, c5.x
rsq r0.w, r0.w
cmp r2.w, r2.x, c7.x, c7.y
cmp r2.z, r2, c7.x, c7.y
mul_pp r2.z, r2, r2.w
rcp r2.w, r3.x
add r2.w, r2.x, -r2
cmp r2.z, -r2, c7, r2.w
rcp r0.w, r0.w
add r2.w, r0, -c6.x
cmp r2.w, r2, c7.y, c7.x
cmp r3.x, r2, c7.y, c7
mul_pp r3.x, r2.w, r3
min r2.w, r2.z, c7.z
if_gt r3.x, c7.y
mad r1.y, r0.w, r0.w, -r2
mad r1.x, c6, c6, -r2.y
rsq r1.y, r1.y
rsq r1.x, r1.x
rcp r1.y, r1.y
rcp r1.x, r1.x
add r3.x, r1, -r1.y
min r2.w, r3.x, r2
mad r0.xyz, r2.w, r0, c0
add r0.xyz, r0, -v2
dp3 r1.x, r0, r0
rsq r1.x, r1.x
rcp r1.w, r1.x
mul r1.xyz, r1.x, r0
max r2.x, r0.w, r1.w
mul r0.y, r2.x, c7.w
min r0.x, r0.w, r1.w
mad r0.y, r0.x, c8.x, r0
else
mad r2.y, c6.x, c6.x, -r2
rsq r2.y, r2.y
rcp r2.y, r2.y
add r2.z, r2.x, -r2.y
add r4.x, r2, r2.y
add r2.y, r4.x, -r2.z
add_sat r3.z, -r0.w, c6.x
mad r3.x, r3.z, r2.y, r2.z
min r4.x, r4, r2.w
add r2.y, -r1.w, c6.x
cmp r2.z, r2.x, c7.x, c7.y
cmp r2.x, r2.y, c7, c7.y
mul_pp r3.y, r2.x, r2.z
cmp r3.x, -r3.y, c7.y, r3
min r3.w, r3.x, r2
mad r2.xyz, r3.w, r0, c0
add r2.xyz, r2, -v2
dp3 r4.y, r2, r2
rsq r4.y, r4.y
mul r2.xyz, r4.y, r2
mad r0.xyz, r0, r4.x, c0
add r0.xyz, v2, -r0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
cmp_pp r1.xyz, -r3.y, r1, r2
add r2.x, r1.w, -c6
add r1.w, -r2, r4.x
mad r1.w, r1, r2.x, c6.x
add r0.y, r0.w, -r1.w
mad r0.w, r3.z, r0.y, r1
max r1.w, r0.z, r0
add r0.y, -r3.x, r4.x
min r0.x, r3, r3.w
add r0.x, r0, -r0.y
mad r0.x, r3.z, r0, r0.y
mul r1.w, r1, c7
min r0.z, r0, r0.w
mad r0.z, r0, c8.x, r1.w
cmp r0.y, -r3, c6.x, r0.z
cmp r2.w, -r3.y, r2, r0.x
endif
dp4_pp r0.x, c1, c1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, c1
dp3_pp r0.z, r1, r2
mul_pp r0.z, r0, c2.w
texldp r0.x, v1, s0
mul_pp r0.x, r0.z, r0
mul_pp_sat r0.z, r0.x, c8.y
mul_pp r0.z, r0, c2.x
mov r0.x, c6
add r0.x, -c5, r0
max r0.w, r0.z, c7.y
rcp r0.z, r0.x
add r0.x, r0.y, -c5
mul_sat r0.x, r0, r0.z
add r0.y, -r0.x, c7.x
mov_sat r0.x, r3
max r0.z, r0.w, c7.y
mul r0.y, r0, c4.x
mul r0.x, r0, r2.w
mul r0.x, r0, r0.y
mul r0.x, r0, r0.z
mul_pp oC0.w, r0.x, c3
mov_pp oC0.xyz, c3
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Float 5 [_Visibility]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 109 ALU, 1 TEX, 2 FLOW
dcl_2d s0
def c8, 1.00000000, 0.00000000, 0.25000000, 0.75000000
def c9, 4.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord8 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r2.y, v3, r0
dp3 r0.w, v3, v3
mad r1.w, -r2.y, r2.y, r0
rsq r1.w, r1.w
rcp r1.w, r1.w
mul r2.z, r1.w, r1.w
mad r2.x, c6, c6, -r2.z
rsq r2.x, r2.x
rcp r3.y, r2.x
add r2.x, -r1.w, c6
cmp r2.w, r2.y, c8.x, c8.y
cmp r2.x, r2, c8, c8.y
mul_pp r3.x, r2, r2.w
rsq r2.w, r0.w
texldp r2.x, v0, s0
mad r0.w, r2.x, c1.z, c1
add r3.y, r2, -r3
rcp r0.w, r0.w
cmp r2.x, -r3, r0.w, r3.y
rcp r2.w, r2.w
add r3.x, r2.w, -c7
cmp r3.y, r2, c8, c8.x
cmp r3.x, r3, c8.y, c8
mul_pp r3.x, r3, r3.y
min r0.w, r2.x, r0
if_gt r3.x, c8.y
mad r1.y, r2.w, r2.w, -r2.z
mad r1.x, c7, c7, -r2.z
rsq r1.y, r1.y
rsq r1.x, r1.x
rcp r1.y, r1.y
rcp r1.x, r1.x
add r3.x, r1, -r1.y
min r0.w, r3.x, r0
mad r0.xyz, r0.w, r0, c0
add r0.xyz, r0, -v2
dp3 r1.x, r0, r0
rsq r1.x, r1.x
rcp r1.w, r1.x
mul r1.xyz, r1.x, r0
max r2.x, r2.w, r1.w
mul r0.y, r2.x, c8.z
min r0.x, r2.w, r1.w
mad r0.x, r0, c8.w, r0.y
else
mad r2.x, c7, c7, -r2.z
rsq r2.x, r2.x
rcp r2.x, r2.x
add r2.z, r2.y, -r2.x
add r4.x, r2.y, r2
add r2.x, r4, -r2.z
add_sat r3.z, -r2.w, c7.x
mad r2.z, r3, r2.x, r2
add r2.x, -r1.w, c7
min r4.x, r4, r0.w
cmp r2.y, r2, c8.x, c8
cmp r2.x, r2, c8, c8.y
mul_pp r3.y, r2.x, r2
cmp r3.x, -r3.y, c8.y, r2.z
min r3.w, r3.x, r0
mad r2.xyz, r3.w, r0, c0
add r2.xyz, r2, -v2
dp3 r4.y, r2, r2
rsq r4.y, r4.y
mul r2.xyz, r4.y, r2
mad r0.xyz, r0, r4.x, c0
add r0.xyz, v2, -r0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
cmp_pp r1.xyz, -r3.y, r1, r2
add r2.x, r1.w, -c7
add r1.w, -r0, r4.x
mad r1.w, r1, r2.x, c7.x
add r0.y, r2.w, -r1.w
mad r1.w, r3.z, r0.y, r1
max r2.x, r0.z, r1.w
add r0.y, -r3.x, r4.x
min r0.x, r3, r3.w
add r0.x, r0, -r0.y
mad r0.y, r3.z, r0.x, r0
mul r2.x, r2, c8.z
min r0.z, r0, r1.w
mad r0.z, r0, c8.w, r2.x
cmp r0.x, -r3.y, c7, r0.z
cmp r0.w, -r3.y, r0, r0.y
endif
dp4_pp r0.y, c2, c2
rsq_pp r0.y, r0.y
mul_pp r2.xyz, r0.y, c2
dp3_pp r0.y, r1, r2
mul_pp r0.y, r0, c3.w
mul_pp_sat r0.z, r0.y, c9.x
mov r0.y, c7.x
mul_pp r0.z, r0, c3.x
add r0.y, -c6.x, r0
max r0.z, r0, c8.y
rcp r0.y, r0.y
add r0.x, r0, -c6
mul_sat r0.x, r0, r0.y
add r0.y, -r0.x, c8.x
mov_sat r0.x, r3
max r0.z, r0, c8.y
mul r0.y, r0, c5.x
mul r0.x, r0, r0.w
mul r0.x, r0, r0.y
mul r0.x, r0, r0.z
mul_pp oC0.w, r0.x, c4
mov_pp oC0.xyz, c4
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Float 5 [_Visibility]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 109 ALU, 1 TEX, 2 FLOW
dcl_2d s0
def c8, 1.00000000, 0.00000000, 0.25000000, 0.75000000
def c9, 4.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord8 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r2.y, v3, r0
dp3 r0.w, v3, v3
mad r1.w, -r2.y, r2.y, r0
rsq r1.w, r1.w
rcp r1.w, r1.w
mul r2.z, r1.w, r1.w
mad r2.x, c6, c6, -r2.z
rsq r2.x, r2.x
rcp r3.y, r2.x
add r2.x, -r1.w, c6
cmp r2.w, r2.y, c8.x, c8.y
cmp r2.x, r2, c8, c8.y
mul_pp r3.x, r2, r2.w
rsq r2.w, r0.w
texldp r2.x, v0, s0
mad r0.w, r2.x, c1.z, c1
add r3.y, r2, -r3
rcp r0.w, r0.w
cmp r2.x, -r3, r0.w, r3.y
rcp r2.w, r2.w
add r3.x, r2.w, -c7
cmp r3.y, r2, c8, c8.x
cmp r3.x, r3, c8.y, c8
mul_pp r3.x, r3, r3.y
min r0.w, r2.x, r0
if_gt r3.x, c8.y
mad r1.y, r2.w, r2.w, -r2.z
mad r1.x, c7, c7, -r2.z
rsq r1.y, r1.y
rsq r1.x, r1.x
rcp r1.y, r1.y
rcp r1.x, r1.x
add r3.x, r1, -r1.y
min r0.w, r3.x, r0
mad r0.xyz, r0.w, r0, c0
add r0.xyz, r0, -v2
dp3 r1.x, r0, r0
rsq r1.x, r1.x
rcp r1.w, r1.x
mul r1.xyz, r1.x, r0
max r2.x, r2.w, r1.w
mul r0.y, r2.x, c8.z
min r0.x, r2.w, r1.w
mad r0.x, r0, c8.w, r0.y
else
mad r2.x, c7, c7, -r2.z
rsq r2.x, r2.x
rcp r2.x, r2.x
add r2.z, r2.y, -r2.x
add r4.x, r2.y, r2
add r2.x, r4, -r2.z
add_sat r3.z, -r2.w, c7.x
mad r2.z, r3, r2.x, r2
add r2.x, -r1.w, c7
min r4.x, r4, r0.w
cmp r2.y, r2, c8.x, c8
cmp r2.x, r2, c8, c8.y
mul_pp r3.y, r2.x, r2
cmp r3.x, -r3.y, c8.y, r2.z
min r3.w, r3.x, r0
mad r2.xyz, r3.w, r0, c0
add r2.xyz, r2, -v2
dp3 r4.y, r2, r2
rsq r4.y, r4.y
mul r2.xyz, r4.y, r2
mad r0.xyz, r0, r4.x, c0
add r0.xyz, v2, -r0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
cmp_pp r1.xyz, -r3.y, r1, r2
add r2.x, r1.w, -c7
add r1.w, -r0, r4.x
mad r1.w, r1, r2.x, c7.x
add r0.y, r2.w, -r1.w
mad r1.w, r3.z, r0.y, r1
max r2.x, r0.z, r1.w
add r0.y, -r3.x, r4.x
min r0.x, r3, r3.w
add r0.x, r0, -r0.y
mad r0.y, r3.z, r0.x, r0
mul r2.x, r2, c8.z
min r0.z, r0, r1.w
mad r0.z, r0, c8.w, r2.x
cmp r0.x, -r3.y, c7, r0.z
cmp r0.w, -r3.y, r0, r0.y
endif
dp4_pp r0.y, c2, c2
rsq_pp r0.y, r0.y
mul_pp r2.xyz, r0.y, c2
dp3_pp r0.y, r1, r2
mul_pp r0.y, r0, c3.w
mul_pp_sat r0.z, r0.y, c9.x
mov r0.y, c7.x
mul_pp r0.z, r0, c3.x
add r0.y, -c6.x, r0
max r0.z, r0, c8.y
rcp r0.y, r0.y
add r0.x, r0, -c6
mul_sat r0.x, r0, r0.y
add r0.y, -r0.x, c8.x
mov_sat r0.x, r3
max r0.z, r0, c8.y
mul r0.y, r0, c5.x
mul r0.x, r0, r0.w
mul r0.x, r0, r0.y
mul r0.x, r0, r0.z
mul_pp oC0.w, r0.x, c4
mov_pp oC0.xyz, c4
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Float 5 [_Visibility]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 109 ALU, 1 TEX, 2 FLOW
dcl_2d s0
def c8, 1.00000000, 0.00000000, 0.25000000, 0.75000000
def c9, 4.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord8 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r2.y, v3, r0
dp3 r0.w, v3, v3
mad r1.w, -r2.y, r2.y, r0
rsq r1.w, r1.w
rcp r1.w, r1.w
mul r2.z, r1.w, r1.w
mad r2.x, c6, c6, -r2.z
rsq r2.x, r2.x
rcp r3.y, r2.x
add r2.x, -r1.w, c6
cmp r2.w, r2.y, c8.x, c8.y
cmp r2.x, r2, c8, c8.y
mul_pp r3.x, r2, r2.w
rsq r2.w, r0.w
texldp r2.x, v0, s0
mad r0.w, r2.x, c1.z, c1
add r3.y, r2, -r3
rcp r0.w, r0.w
cmp r2.x, -r3, r0.w, r3.y
rcp r2.w, r2.w
add r3.x, r2.w, -c7
cmp r3.y, r2, c8, c8.x
cmp r3.x, r3, c8.y, c8
mul_pp r3.x, r3, r3.y
min r0.w, r2.x, r0
if_gt r3.x, c8.y
mad r1.y, r2.w, r2.w, -r2.z
mad r1.x, c7, c7, -r2.z
rsq r1.y, r1.y
rsq r1.x, r1.x
rcp r1.y, r1.y
rcp r1.x, r1.x
add r3.x, r1, -r1.y
min r0.w, r3.x, r0
mad r0.xyz, r0.w, r0, c0
add r0.xyz, r0, -v2
dp3 r1.x, r0, r0
rsq r1.x, r1.x
rcp r1.w, r1.x
mul r1.xyz, r1.x, r0
max r2.x, r2.w, r1.w
mul r0.y, r2.x, c8.z
min r0.x, r2.w, r1.w
mad r0.x, r0, c8.w, r0.y
else
mad r2.x, c7, c7, -r2.z
rsq r2.x, r2.x
rcp r2.x, r2.x
add r2.z, r2.y, -r2.x
add r4.x, r2.y, r2
add r2.x, r4, -r2.z
add_sat r3.z, -r2.w, c7.x
mad r2.z, r3, r2.x, r2
add r2.x, -r1.w, c7
min r4.x, r4, r0.w
cmp r2.y, r2, c8.x, c8
cmp r2.x, r2, c8, c8.y
mul_pp r3.y, r2.x, r2
cmp r3.x, -r3.y, c8.y, r2.z
min r3.w, r3.x, r0
mad r2.xyz, r3.w, r0, c0
add r2.xyz, r2, -v2
dp3 r4.y, r2, r2
rsq r4.y, r4.y
mul r2.xyz, r4.y, r2
mad r0.xyz, r0, r4.x, c0
add r0.xyz, v2, -r0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
cmp_pp r1.xyz, -r3.y, r1, r2
add r2.x, r1.w, -c7
add r1.w, -r0, r4.x
mad r1.w, r1, r2.x, c7.x
add r0.y, r2.w, -r1.w
mad r1.w, r3.z, r0.y, r1
max r2.x, r0.z, r1.w
add r0.y, -r3.x, r4.x
min r0.x, r3, r3.w
add r0.x, r0, -r0.y
mad r0.y, r3.z, r0.x, r0
mul r2.x, r2, c8.z
min r0.z, r0, r1.w
mad r0.z, r0, c8.w, r2.x
cmp r0.x, -r3.y, c7, r0.z
cmp r0.w, -r3.y, r0, r0.y
endif
dp4_pp r0.y, c2, c2
rsq_pp r0.y, r0.y
mul_pp r2.xyz, r0.y, c2
dp3_pp r0.y, r1, r2
mul_pp r0.y, r0, c3.w
mul_pp_sat r0.z, r0.y, c9.x
mov r0.y, c7.x
mul_pp r0.z, r0, c3.x
add r0.y, -c6.x, r0
max r0.z, r0, c8.y
rcp r0.y, r0.y
add r0.x, r0, -c6
mul_sat r0.x, r0, r0.y
add r0.y, -r0.x, c8.x
mov_sat r0.x, r3
max r0.z, r0, c8.y
mul r0.y, r0, c5.x
mul r0.x, r0, r0.w
mul r0.x, r0, r0.y
mul r0.x, r0, r0.z
mul_pp oC0.w, r0.x, c4
mov_pp oC0.xyz, c4
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Float 5 [_Visibility]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
SetTexture 0 [_CameraDepthTexture] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_3_0
; 110 ALU, 2 TEX, 2 FLOW
dcl_2d s0
dcl_2d s1
def c8, 1.00000000, 0.00000000, 0.25000000, 0.75000000
def c9, 4.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord4 v3.xyz
dcl_texcoord8 v4.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r2.xyz, r0.w, r0
dp3 r0.y, v4, r2
dp3 r1.w, v4, v4
mad r0.x, -r0.y, r0.y, r1.w
rsq r0.x, r0.x
rcp r0.w, r0.x
mul r0.z, r0.w, r0.w
mad r0.x, c6, c6, -r0.z
rsq r0.x, r0.x
rcp r3.y, r0.x
add r0.x, -r0.w, c6
cmp r2.w, r0.y, c8.x, c8.y
cmp r0.x, r0, c8, c8.y
mul_pp r3.x, r0, r2.w
rsq r1.w, r1.w
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rcp r0.x, r0.x
add r3.y, r0, -r3
rcp r2.w, r1.w
cmp r1.w, -r3.x, r0.x, r3.y
add r3.x, r2.w, -c7
cmp r3.y, r0, c8, c8.x
cmp r3.x, r3, c8.y, c8
mul_pp r3.x, r3, r3.y
min r1.w, r1, r0.x
if_gt r3.x, c8.y
mad r0.y, r2.w, r2.w, -r0.z
mad r0.x, c7, c7, -r0.z
rsq r0.y, r0.y
rsq r0.x, r0.x
rcp r0.y, r0.y
rcp r0.x, r0.x
add r3.x, r0, -r0.y
min r1.w, r3.x, r1
mad r0.xyz, r1.w, r2, c0
add r0.xyz, r0, -v3
dp3 r0.w, r0, r0
rsq r0.w, r0.w
rcp r2.x, r0.w
mul r1.xyz, r0.w, r0
max r2.y, r2.w, r2.x
mul r0.y, r2, c8.z
min r0.x, r2.w, r2
mad r0.y, r0.x, c8.w, r0
else
mad r0.x, c7, c7, -r0.z
rsq r0.x, r0.x
rcp r0.x, r0.x
add r0.z, r0.y, -r0.x
add r4.x, r0.y, r0
add r0.x, r4, -r0.z
add_sat r3.z, -r2.w, c7.x
mad r0.z, r3, r0.x, r0
add r0.x, -r0.w, c7
min r4.x, r4, r1.w
cmp r0.y, r0, c8.x, c8
cmp r0.x, r0, c8, c8.y
mul_pp r3.y, r0.x, r0
cmp r3.x, -r3.y, c8.y, r0.z
min r3.w, r3.x, r1
mad r0.xyz, r3.w, r2, c0
add r0.xyz, r0, -v3
dp3 r4.y, r0, r0
rsq r4.y, r4.y
mul r0.xyz, r4.y, r0
mad r2.xyz, r2, r4.x, c0
cmp_pp r1.xyz, -r3.y, r1, r0
add r0.xyz, v3, -r2
dp3 r0.x, r0, r0
add r2.x, r0.w, -c7
add r0.w, -r1, r4.x
mad r0.w, r0, r2.x, c7.x
add r0.y, r2.w, -r0.w
mad r0.w, r3.z, r0.y, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
max r2.x, r0.z, r0.w
add r0.y, -r3.x, r4.x
min r0.x, r3, r3.w
add r0.x, r0, -r0.y
mad r0.x, r3.z, r0, r0.y
mul r2.x, r2, c8.z
min r0.z, r0, r0.w
mad r0.z, r0, c8.w, r2.x
cmp r0.y, -r3, c7.x, r0.z
cmp r1.w, -r3.y, r1, r0.x
endif
dp4_pp r0.x, c2, c2
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, c2
dp3_pp r0.z, r1, r2
mul_pp r0.z, r0, c3.w
texldp r0.x, v2, s1
mul_pp r0.x, r0.z, r0
mul_pp_sat r0.z, r0.x, c9.x
mul_pp r0.z, r0, c3.x
mov r0.x, c7
add r0.x, -c6, r0
max r0.w, r0.z, c8.y
rcp r0.z, r0.x
add r0.x, r0.y, -c6
mul_sat r0.x, r0, r0.z
add r0.y, -r0.x, c8.x
mov_sat r0.x, r3
max r0.z, r0.w, c8.y
mul r0.y, r0, c5.x
mul r0.x, r0, r1.w
mul r0.x, r0, r0.y
mul r0.x, r0, r0.z
mul_pp oC0.w, r0.x, c4
mov_pp oC0.xyz, c4
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Float 5 [_Visibility]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
SetTexture 0 [_CameraDepthTexture] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_3_0
; 110 ALU, 2 TEX, 2 FLOW
dcl_2d s0
dcl_2d s1
def c8, 1.00000000, 0.00000000, 0.25000000, 0.75000000
def c9, 4.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord4 v3.xyz
dcl_texcoord8 v4.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r2.xyz, r0.w, r0
dp3 r0.y, v4, r2
dp3 r1.w, v4, v4
mad r0.x, -r0.y, r0.y, r1.w
rsq r0.x, r0.x
rcp r0.w, r0.x
mul r0.z, r0.w, r0.w
mad r0.x, c6, c6, -r0.z
rsq r0.x, r0.x
rcp r3.y, r0.x
add r0.x, -r0.w, c6
cmp r2.w, r0.y, c8.x, c8.y
cmp r0.x, r0, c8, c8.y
mul_pp r3.x, r0, r2.w
rsq r1.w, r1.w
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rcp r0.x, r0.x
add r3.y, r0, -r3
rcp r2.w, r1.w
cmp r1.w, -r3.x, r0.x, r3.y
add r3.x, r2.w, -c7
cmp r3.y, r0, c8, c8.x
cmp r3.x, r3, c8.y, c8
mul_pp r3.x, r3, r3.y
min r1.w, r1, r0.x
if_gt r3.x, c8.y
mad r0.y, r2.w, r2.w, -r0.z
mad r0.x, c7, c7, -r0.z
rsq r0.y, r0.y
rsq r0.x, r0.x
rcp r0.y, r0.y
rcp r0.x, r0.x
add r3.x, r0, -r0.y
min r1.w, r3.x, r1
mad r0.xyz, r1.w, r2, c0
add r0.xyz, r0, -v3
dp3 r0.w, r0, r0
rsq r0.w, r0.w
rcp r2.x, r0.w
mul r1.xyz, r0.w, r0
max r2.y, r2.w, r2.x
mul r0.y, r2, c8.z
min r0.x, r2.w, r2
mad r0.y, r0.x, c8.w, r0
else
mad r0.x, c7, c7, -r0.z
rsq r0.x, r0.x
rcp r0.x, r0.x
add r0.z, r0.y, -r0.x
add r4.x, r0.y, r0
add r0.x, r4, -r0.z
add_sat r3.z, -r2.w, c7.x
mad r0.z, r3, r0.x, r0
add r0.x, -r0.w, c7
min r4.x, r4, r1.w
cmp r0.y, r0, c8.x, c8
cmp r0.x, r0, c8, c8.y
mul_pp r3.y, r0.x, r0
cmp r3.x, -r3.y, c8.y, r0.z
min r3.w, r3.x, r1
mad r0.xyz, r3.w, r2, c0
add r0.xyz, r0, -v3
dp3 r4.y, r0, r0
rsq r4.y, r4.y
mul r0.xyz, r4.y, r0
mad r2.xyz, r2, r4.x, c0
cmp_pp r1.xyz, -r3.y, r1, r0
add r0.xyz, v3, -r2
dp3 r0.x, r0, r0
add r2.x, r0.w, -c7
add r0.w, -r1, r4.x
mad r0.w, r0, r2.x, c7.x
add r0.y, r2.w, -r0.w
mad r0.w, r3.z, r0.y, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
max r2.x, r0.z, r0.w
add r0.y, -r3.x, r4.x
min r0.x, r3, r3.w
add r0.x, r0, -r0.y
mad r0.x, r3.z, r0, r0.y
mul r2.x, r2, c8.z
min r0.z, r0, r0.w
mad r0.z, r0, c8.w, r2.x
cmp r0.y, -r3, c7.x, r0.z
cmp r1.w, -r3.y, r1, r0.x
endif
dp4_pp r0.x, c2, c2
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, c2
dp3_pp r0.z, r1, r2
mul_pp r0.z, r0, c3.w
texldp r0.x, v2, s1
mul_pp r0.x, r0.z, r0
mul_pp_sat r0.z, r0.x, c9.x
mul_pp r0.z, r0, c3.x
mov r0.x, c7
add r0.x, -c6, r0
max r0.w, r0.z, c8.y
rcp r0.z, r0.x
add r0.x, r0.y, -c6
mul_sat r0.x, r0, r0.z
add r0.y, -r0.x, c8.x
mov_sat r0.x, r3
max r0.z, r0.w, c8.y
mul r0.y, r0, c5.x
mul r0.x, r0, r1.w
mul r0.x, r0, r0.y
mul r0.x, r0, r0.z
mul_pp oC0.w, r0.x, c4
mov_pp oC0.xyz, c4
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Float 5 [_Visibility]
Float 6 [_OceanRadius]
Float 7 [_SphereRadius]
SetTexture 0 [_CameraDepthTexture] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_3_0
; 110 ALU, 2 TEX, 2 FLOW
dcl_2d s0
dcl_2d s1
def c8, 1.00000000, 0.00000000, 0.25000000, 0.75000000
def c9, 4.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord4 v3.xyz
dcl_texcoord8 v4.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r2.xyz, r0.w, r0
dp3 r0.y, v4, r2
dp3 r1.w, v4, v4
mad r0.x, -r0.y, r0.y, r1.w
rsq r0.x, r0.x
rcp r0.w, r0.x
mul r0.z, r0.w, r0.w
mad r0.x, c6, c6, -r0.z
rsq r0.x, r0.x
rcp r3.y, r0.x
add r0.x, -r0.w, c6
cmp r2.w, r0.y, c8.x, c8.y
cmp r0.x, r0, c8, c8.y
mul_pp r3.x, r0, r2.w
rsq r1.w, r1.w
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rcp r0.x, r0.x
add r3.y, r0, -r3
rcp r2.w, r1.w
cmp r1.w, -r3.x, r0.x, r3.y
add r3.x, r2.w, -c7
cmp r3.y, r0, c8, c8.x
cmp r3.x, r3, c8.y, c8
mul_pp r3.x, r3, r3.y
min r1.w, r1, r0.x
if_gt r3.x, c8.y
mad r0.y, r2.w, r2.w, -r0.z
mad r0.x, c7, c7, -r0.z
rsq r0.y, r0.y
rsq r0.x, r0.x
rcp r0.y, r0.y
rcp r0.x, r0.x
add r3.x, r0, -r0.y
min r1.w, r3.x, r1
mad r0.xyz, r1.w, r2, c0
add r0.xyz, r0, -v3
dp3 r0.w, r0, r0
rsq r0.w, r0.w
rcp r2.x, r0.w
mul r1.xyz, r0.w, r0
max r2.y, r2.w, r2.x
mul r0.y, r2, c8.z
min r0.x, r2.w, r2
mad r0.y, r0.x, c8.w, r0
else
mad r0.x, c7, c7, -r0.z
rsq r0.x, r0.x
rcp r0.x, r0.x
add r0.z, r0.y, -r0.x
add r4.x, r0.y, r0
add r0.x, r4, -r0.z
add_sat r3.z, -r2.w, c7.x
mad r0.z, r3, r0.x, r0
add r0.x, -r0.w, c7
min r4.x, r4, r1.w
cmp r0.y, r0, c8.x, c8
cmp r0.x, r0, c8, c8.y
mul_pp r3.y, r0.x, r0
cmp r3.x, -r3.y, c8.y, r0.z
min r3.w, r3.x, r1
mad r0.xyz, r3.w, r2, c0
add r0.xyz, r0, -v3
dp3 r4.y, r0, r0
rsq r4.y, r4.y
mul r0.xyz, r4.y, r0
mad r2.xyz, r2, r4.x, c0
cmp_pp r1.xyz, -r3.y, r1, r0
add r0.xyz, v3, -r2
dp3 r0.x, r0, r0
add r2.x, r0.w, -c7
add r0.w, -r1, r4.x
mad r0.w, r0, r2.x, c7.x
add r0.y, r2.w, -r0.w
mad r0.w, r3.z, r0.y, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
max r2.x, r0.z, r0.w
add r0.y, -r3.x, r4.x
min r0.x, r3, r3.w
add r0.x, r0, -r0.y
mad r0.x, r3.z, r0, r0.y
mul r2.x, r2, c8.z
min r0.z, r0, r0.w
mad r0.z, r0, c8.w, r2.x
cmp r0.y, -r3, c7.x, r0.z
cmp r1.w, -r3.y, r1, r0.x
endif
dp4_pp r0.x, c2, c2
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, c2
dp3_pp r0.z, r1, r2
mul_pp r0.z, r0, c3.w
texldp r0.x, v2, s1
mul_pp r0.x, r0.z, r0
mul_pp_sat r0.z, r0.x, c9.x
mul_pp r0.z, r0, c3.x
mov r0.x, c7
add r0.x, -c6, r0
max r0.w, r0.z, c8.y
rcp r0.z, r0.x
add r0.x, r0.y, -c6
mul_sat r0.x, r0, r0.z
add r0.y, -r0.x, c8.x
mov_sat r0.x, r3
max r0.z, r0.w, c8.y
mul r0.y, r0, c5.x
mul r0.x, r0, r1.w
mul r0.x, r0, r0.y
mul r0.x, r0, r0.z
mul_pp oC0.w, r0.x, c4
mov_pp oC0.xyz, c4
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES3"
}

}

#LINE 173

	
		}
		
	} 
	
}
}
