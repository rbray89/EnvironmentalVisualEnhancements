Shader "Sphere/Atmosphere" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_Visibility ("Visibility", Float) = .0001
		_OceanRadius ("Ocean Radius", Float) = 63000
		_SphereRadius ("Sphere Radius", Float) = 67000
		_PlanetOrigin ("Sphere Center", Vector) = (0,0,0,1)
		_SunsetColor ("Color Sunset", Color) = (1,0,0,.45)
		_DensityRatioY ("Density RatioY", Float) = 1
		_DensityRatioX ("Density RatioX", Float) = 1
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
//   d3d9 - ALU: 12 to 21
//   d3d11 - ALU: 9 to 18, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
uniform float _DensityRatioX;
uniform float _DensityRatioY;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  float d2_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  depth_3 = 1e+32;
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_6;
  tmpvar_6 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_5 * tmpvar_5)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_6, 2.0);
  d2_2 = tmpvar_7;
  float tmpvar_8;
  tmpvar_8 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_1 = 1e+32;
  if (((tmpvar_6 <= _OceanRadius) && (tmpvar_5 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_5 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_7)));
  };
  float tmpvar_9;
  tmpvar_9 = min (oceanSphereDist_1, 1e+32);
  depth_3 = tmpvar_9;
  vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  float tmpvar_11;
  tmpvar_11 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_8 < _SphereRadius) && (tmpvar_5 < 0.0))) {
    float tmpvar_12;
    tmpvar_12 = sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_7));
    float tmpvar_13;
    tmpvar_13 = (min (tmpvar_9, (sqrt((tmpvar_11 - tmpvar_7)) - tmpvar_12)) + tmpvar_12);
    float tmpvar_14;
    tmpvar_14 = (tmpvar_7 * _DensityRatioY);
    d2_2 = tmpvar_14;
    depth_3 = ((((tmpvar_12 * ((tmpvar_14 + (((_DensityRatioX * tmpvar_12) * tmpvar_12) * 0.333333)) - tmpvar_11)) - (tmpvar_13 * ((tmpvar_14 + (((_DensityRatioX * tmpvar_13) * tmpvar_13) * 0.333333)) - tmpvar_11))) / tmpvar_11) * _Visibility);
  } else {
    if (((tmpvar_6 <= _SphereRadius) && (tmpvar_5 >= 0.0))) {
      float tmpvar_15;
      tmpvar_15 = sqrt((tmpvar_11 - d2_2));
      float tmpvar_16;
      tmpvar_16 = max (0.0, (tmpvar_5 - depth_3));
      float tmpvar_17;
      tmpvar_17 = min (tmpvar_15, max (0.0, (depth_3 - tmpvar_5)));
      float tmpvar_18;
      tmpvar_18 = mix (tmpvar_15, tmpvar_5, clamp (floor(((1.0 + _SphereRadius) - tmpvar_8)), 0.0, 1.0));
      float tmpvar_19;
      tmpvar_19 = (d2_2 * _DensityRatioY);
      d2_2 = tmpvar_19;
      depth_3 = (((((tmpvar_16 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_16) * tmpvar_16) * 0.333333)) - tmpvar_11)) + -((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_11)))) + -((tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_11)))) / tmpvar_11) * _Visibility);
    } else {
      depth_3 = 0.0;
    };
  };
  color_4.w = (_Color.w * clamp ((depth_3 * max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (tmpvar_10, normalize(_WorldSpaceLightPos0).xyz)) * 2.0))).x))), 0.0, 1.0));
  gl_FragData[0] = color_4;
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
"vs_3_0
; 12 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord4 o2
dcl_texcoord5 o3
dcl_position0 v0
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
mov o2.xyz, r0
add o3.xyz, r0, -c8
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 11 instructions, 1 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedihbkcdeoplfjgilfaccgfjahpcdijoaaabaaaaaaciadaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oeabaaaaeaaaabaahjaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaak
hccabaaaaeaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaegiccaaaabaaaaaa
apaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0))).x));
  highp float tmpvar_29;
  tmpvar_29 = clamp ((depth_7 * tmpvar_28), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_29);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0))).x));
  highp float tmpvar_29;
  tmpvar_29 = clamp ((depth_7 * tmpvar_28), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_29);
  tmpvar_1 = color_8;
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
#line 407
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 400
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 416
#line 428
#line 416
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 420
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 424
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 407
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 400
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 416
#line 428
#line 428
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 432
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 436
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 440
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 444
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 448
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 452
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 456
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 460
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 464
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 468
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 475
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 479
    lowp float atten = 1.0;
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 483
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
uniform float _DensityRatioX;
uniform float _DensityRatioY;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  float d2_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  depth_3 = 1e+32;
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_6;
  tmpvar_6 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_5 * tmpvar_5)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_6, 2.0);
  d2_2 = tmpvar_7;
  float tmpvar_8;
  tmpvar_8 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_1 = 1e+32;
  if (((tmpvar_6 <= _OceanRadius) && (tmpvar_5 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_5 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_7)));
  };
  float tmpvar_9;
  tmpvar_9 = min (oceanSphereDist_1, 1e+32);
  depth_3 = tmpvar_9;
  vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  float tmpvar_11;
  tmpvar_11 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_8 < _SphereRadius) && (tmpvar_5 < 0.0))) {
    float tmpvar_12;
    tmpvar_12 = sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_7));
    float tmpvar_13;
    tmpvar_13 = (min (tmpvar_9, (sqrt((tmpvar_11 - tmpvar_7)) - tmpvar_12)) + tmpvar_12);
    float tmpvar_14;
    tmpvar_14 = (tmpvar_7 * _DensityRatioY);
    d2_2 = tmpvar_14;
    depth_3 = ((((tmpvar_12 * ((tmpvar_14 + (((_DensityRatioX * tmpvar_12) * tmpvar_12) * 0.333333)) - tmpvar_11)) - (tmpvar_13 * ((tmpvar_14 + (((_DensityRatioX * tmpvar_13) * tmpvar_13) * 0.333333)) - tmpvar_11))) / tmpvar_11) * _Visibility);
  } else {
    if (((tmpvar_6 <= _SphereRadius) && (tmpvar_5 >= 0.0))) {
      float tmpvar_15;
      tmpvar_15 = sqrt((tmpvar_11 - d2_2));
      float tmpvar_16;
      tmpvar_16 = max (0.0, (tmpvar_5 - depth_3));
      float tmpvar_17;
      tmpvar_17 = min (tmpvar_15, max (0.0, (depth_3 - tmpvar_5)));
      float tmpvar_18;
      tmpvar_18 = mix (tmpvar_15, tmpvar_5, clamp (floor(((1.0 + _SphereRadius) - tmpvar_8)), 0.0, 1.0));
      float tmpvar_19;
      tmpvar_19 = (d2_2 * _DensityRatioY);
      d2_2 = tmpvar_19;
      depth_3 = (((((tmpvar_16 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_16) * tmpvar_16) * 0.333333)) - tmpvar_11)) + -((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_11)))) + -((tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_11)))) / tmpvar_11) * _Visibility);
    } else {
      depth_3 = 0.0;
    };
  };
  color_4.w = (_Color.w * clamp ((depth_3 * max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (tmpvar_10, normalize(_WorldSpaceLightPos0).xyz)) * 2.0))).x))), 0.0, 1.0));
  gl_FragData[0] = color_4;
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
"vs_3_0
; 12 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord4 o2
dcl_texcoord5 o3
dcl_position0 v0
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
mov o2.xyz, r0
add o3.xyz, r0, -c8
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 11 instructions, 1 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedihbkcdeoplfjgilfaccgfjahpcdijoaaabaaaaaaciadaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oeabaaaaeaaaabaahjaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaak
hccabaaaaeaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaegiccaaaabaaaaaa
apaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0))).x));
  highp float tmpvar_29;
  tmpvar_29 = clamp ((depth_7 * tmpvar_28), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_29);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0))).x));
  highp float tmpvar_29;
  tmpvar_29 = clamp ((depth_7 * tmpvar_28), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_29);
  tmpvar_1 = color_8;
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
#line 407
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 400
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 416
#line 428
#line 416
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 420
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 424
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 407
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 400
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 416
#line 428
#line 428
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 432
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 436
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 440
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 444
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 448
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 452
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 456
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 460
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 464
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 468
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 475
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 479
    lowp float atten = 1.0;
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 483
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
uniform float _DensityRatioX;
uniform float _DensityRatioY;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  float d2_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  depth_3 = 1e+32;
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_6;
  tmpvar_6 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_5 * tmpvar_5)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_6, 2.0);
  d2_2 = tmpvar_7;
  float tmpvar_8;
  tmpvar_8 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_1 = 1e+32;
  if (((tmpvar_6 <= _OceanRadius) && (tmpvar_5 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_5 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_7)));
  };
  float tmpvar_9;
  tmpvar_9 = min (oceanSphereDist_1, 1e+32);
  depth_3 = tmpvar_9;
  vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  float tmpvar_11;
  tmpvar_11 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_8 < _SphereRadius) && (tmpvar_5 < 0.0))) {
    float tmpvar_12;
    tmpvar_12 = sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_7));
    float tmpvar_13;
    tmpvar_13 = (min (tmpvar_9, (sqrt((tmpvar_11 - tmpvar_7)) - tmpvar_12)) + tmpvar_12);
    float tmpvar_14;
    tmpvar_14 = (tmpvar_7 * _DensityRatioY);
    d2_2 = tmpvar_14;
    depth_3 = ((((tmpvar_12 * ((tmpvar_14 + (((_DensityRatioX * tmpvar_12) * tmpvar_12) * 0.333333)) - tmpvar_11)) - (tmpvar_13 * ((tmpvar_14 + (((_DensityRatioX * tmpvar_13) * tmpvar_13) * 0.333333)) - tmpvar_11))) / tmpvar_11) * _Visibility);
  } else {
    if (((tmpvar_6 <= _SphereRadius) && (tmpvar_5 >= 0.0))) {
      float tmpvar_15;
      tmpvar_15 = sqrt((tmpvar_11 - d2_2));
      float tmpvar_16;
      tmpvar_16 = max (0.0, (tmpvar_5 - depth_3));
      float tmpvar_17;
      tmpvar_17 = min (tmpvar_15, max (0.0, (depth_3 - tmpvar_5)));
      float tmpvar_18;
      tmpvar_18 = mix (tmpvar_15, tmpvar_5, clamp (floor(((1.0 + _SphereRadius) - tmpvar_8)), 0.0, 1.0));
      float tmpvar_19;
      tmpvar_19 = (d2_2 * _DensityRatioY);
      d2_2 = tmpvar_19;
      depth_3 = (((((tmpvar_16 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_16) * tmpvar_16) * 0.333333)) - tmpvar_11)) + -((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_11)))) + -((tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_11)))) / tmpvar_11) * _Visibility);
    } else {
      depth_3 = 0.0;
    };
  };
  color_4.w = (_Color.w * clamp ((depth_3 * max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (tmpvar_10, normalize(_WorldSpaceLightPos0).xyz)) * 2.0))).x))), 0.0, 1.0));
  gl_FragData[0] = color_4;
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
"vs_3_0
; 12 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord4 o2
dcl_texcoord5 o3
dcl_position0 v0
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
mov o2.xyz, r0
add o3.xyz, r0, -c8
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 11 instructions, 1 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedihbkcdeoplfjgilfaccgfjahpcdijoaaabaaaaaaciadaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oeabaaaaeaaaabaahjaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaak
hccabaaaaeaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaegiccaaaabaaaaaa
apaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0))).x));
  highp float tmpvar_29;
  tmpvar_29 = clamp ((depth_7 * tmpvar_28), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_29);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0))).x));
  highp float tmpvar_29;
  tmpvar_29 = clamp ((depth_7 * tmpvar_28), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_29);
  tmpvar_1 = color_8;
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
#line 407
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 400
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 416
#line 428
#line 416
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 420
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 424
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 407
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 400
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 416
#line 428
#line 428
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 432
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 436
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 440
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 444
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 448
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 452
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 456
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 460
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 464
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 468
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 475
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 479
    lowp float atten = 1.0;
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 483
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_4;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = (tmpvar_3 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
uniform float _DensityRatioX;
uniform float _DensityRatioY;
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
  float oceanSphereDist_1;
  float d2_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  depth_3 = 1e+32;
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_6;
  tmpvar_6 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_5 * tmpvar_5)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_6, 2.0);
  d2_2 = tmpvar_7;
  float tmpvar_8;
  tmpvar_8 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_1 = 1e+32;
  if (((tmpvar_6 <= _OceanRadius) && (tmpvar_5 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_5 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_7)));
  };
  float tmpvar_9;
  tmpvar_9 = min (oceanSphereDist_1, 1e+32);
  depth_3 = tmpvar_9;
  vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  float tmpvar_11;
  tmpvar_11 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_8 < _SphereRadius) && (tmpvar_5 < 0.0))) {
    float tmpvar_12;
    tmpvar_12 = sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_7));
    float tmpvar_13;
    tmpvar_13 = (min (tmpvar_9, (sqrt((tmpvar_11 - tmpvar_7)) - tmpvar_12)) + tmpvar_12);
    float tmpvar_14;
    tmpvar_14 = (tmpvar_7 * _DensityRatioY);
    d2_2 = tmpvar_14;
    depth_3 = ((((tmpvar_12 * ((tmpvar_14 + (((_DensityRatioX * tmpvar_12) * tmpvar_12) * 0.333333)) - tmpvar_11)) - (tmpvar_13 * ((tmpvar_14 + (((_DensityRatioX * tmpvar_13) * tmpvar_13) * 0.333333)) - tmpvar_11))) / tmpvar_11) * _Visibility);
  } else {
    if (((tmpvar_6 <= _SphereRadius) && (tmpvar_5 >= 0.0))) {
      float tmpvar_15;
      tmpvar_15 = sqrt((tmpvar_11 - d2_2));
      float tmpvar_16;
      tmpvar_16 = max (0.0, (tmpvar_5 - depth_3));
      float tmpvar_17;
      tmpvar_17 = min (tmpvar_15, max (0.0, (depth_3 - tmpvar_5)));
      float tmpvar_18;
      tmpvar_18 = mix (tmpvar_15, tmpvar_5, clamp (floor(((1.0 + _SphereRadius) - tmpvar_8)), 0.0, 1.0));
      float tmpvar_19;
      tmpvar_19 = (d2_2 * _DensityRatioY);
      d2_2 = tmpvar_19;
      depth_3 = (((((tmpvar_16 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_16) * tmpvar_16) * 0.333333)) - tmpvar_11)) + -((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_11)))) + -((tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_11)))) / tmpvar_11) * _Visibility);
    } else {
      depth_3 = 0.0;
    };
  };
  color_4.w = (_Color.w * clamp ((depth_3 * max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (tmpvar_10, normalize(_WorldSpaceLightPos0).xyz)) * 2.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x))).x))), 0.0, 1.0));
  gl_FragData[0] = color_4;
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
"vs_3_0
; 17 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c11.x
mov o0, r0
mul r1.y, r1, c9.x
mov o2.zw, r0
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
mad o2.xy, r1.z, c10.zwzw, r1
mov o3.xyz, r0
add o4.xyz, r0, -c8
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 16 instructions, 2 temp regs, 0 temp arrays:
// ALU 12 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedeohallacllmbpnmpafgolbepmfljlobcabaaaaaaniadaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmacaaaaeaaaabaa
jpaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaghccabaaaaeaaaaaa
egiccaaaabaaaaaaapaaaaaaaaaaaaakhccabaaaafaaaaaaegiccaiaebaaaaaa
aaaaaaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  lowp float tmpvar_28;
  mediump float lightShadowDataX_29;
  highp float dist_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = _LightShadowData.x;
  lightShadowDataX_29 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = max (float((dist_30 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_29);
  tmpvar_28 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * tmpvar_28))).x));
  highp float tmpvar_35;
  tmpvar_35 = clamp ((depth_7 * tmpvar_34), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_35);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
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
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = (tmpvar_3 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  mediump float tmpvar_29;
  tmpvar_29 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * tmpvar_28.x))).x));
  highp float tmpvar_30;
  tmpvar_30 = clamp ((depth_7 * tmpvar_29), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_30);
  tmpvar_1 = color_8;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 438
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 433
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 438
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 438
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 442
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 446
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 450
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 454
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 458
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 462
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 466
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 470
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 474
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 478
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 485
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 489
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 493
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_4;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = (tmpvar_3 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
uniform float _DensityRatioX;
uniform float _DensityRatioY;
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
  float oceanSphereDist_1;
  float d2_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  depth_3 = 1e+32;
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_6;
  tmpvar_6 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_5 * tmpvar_5)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_6, 2.0);
  d2_2 = tmpvar_7;
  float tmpvar_8;
  tmpvar_8 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_1 = 1e+32;
  if (((tmpvar_6 <= _OceanRadius) && (tmpvar_5 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_5 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_7)));
  };
  float tmpvar_9;
  tmpvar_9 = min (oceanSphereDist_1, 1e+32);
  depth_3 = tmpvar_9;
  vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  float tmpvar_11;
  tmpvar_11 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_8 < _SphereRadius) && (tmpvar_5 < 0.0))) {
    float tmpvar_12;
    tmpvar_12 = sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_7));
    float tmpvar_13;
    tmpvar_13 = (min (tmpvar_9, (sqrt((tmpvar_11 - tmpvar_7)) - tmpvar_12)) + tmpvar_12);
    float tmpvar_14;
    tmpvar_14 = (tmpvar_7 * _DensityRatioY);
    d2_2 = tmpvar_14;
    depth_3 = ((((tmpvar_12 * ((tmpvar_14 + (((_DensityRatioX * tmpvar_12) * tmpvar_12) * 0.333333)) - tmpvar_11)) - (tmpvar_13 * ((tmpvar_14 + (((_DensityRatioX * tmpvar_13) * tmpvar_13) * 0.333333)) - tmpvar_11))) / tmpvar_11) * _Visibility);
  } else {
    if (((tmpvar_6 <= _SphereRadius) && (tmpvar_5 >= 0.0))) {
      float tmpvar_15;
      tmpvar_15 = sqrt((tmpvar_11 - d2_2));
      float tmpvar_16;
      tmpvar_16 = max (0.0, (tmpvar_5 - depth_3));
      float tmpvar_17;
      tmpvar_17 = min (tmpvar_15, max (0.0, (depth_3 - tmpvar_5)));
      float tmpvar_18;
      tmpvar_18 = mix (tmpvar_15, tmpvar_5, clamp (floor(((1.0 + _SphereRadius) - tmpvar_8)), 0.0, 1.0));
      float tmpvar_19;
      tmpvar_19 = (d2_2 * _DensityRatioY);
      d2_2 = tmpvar_19;
      depth_3 = (((((tmpvar_16 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_16) * tmpvar_16) * 0.333333)) - tmpvar_11)) + -((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_11)))) + -((tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_11)))) / tmpvar_11) * _Visibility);
    } else {
      depth_3 = 0.0;
    };
  };
  color_4.w = (_Color.w * clamp ((depth_3 * max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (tmpvar_10, normalize(_WorldSpaceLightPos0).xyz)) * 2.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x))).x))), 0.0, 1.0));
  gl_FragData[0] = color_4;
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
"vs_3_0
; 17 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c11.x
mov o0, r0
mul r1.y, r1, c9.x
mov o2.zw, r0
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
mad o2.xy, r1.z, c10.zwzw, r1
mov o3.xyz, r0
add o4.xyz, r0, -c8
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 16 instructions, 2 temp regs, 0 temp arrays:
// ALU 12 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedeohallacllmbpnmpafgolbepmfljlobcabaaaaaaniadaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmacaaaaeaaaabaa
jpaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaghccabaaaaeaaaaaa
egiccaaaabaaaaaaapaaaaaaaaaaaaakhccabaaaafaaaaaaegiccaiaebaaaaaa
aaaaaaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  lowp float tmpvar_28;
  mediump float lightShadowDataX_29;
  highp float dist_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = _LightShadowData.x;
  lightShadowDataX_29 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = max (float((dist_30 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_29);
  tmpvar_28 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * tmpvar_28))).x));
  highp float tmpvar_35;
  tmpvar_35 = clamp ((depth_7 * tmpvar_34), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_35);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
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
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = (tmpvar_3 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  mediump float tmpvar_29;
  tmpvar_29 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * tmpvar_28.x))).x));
  highp float tmpvar_30;
  tmpvar_30 = clamp ((depth_7 * tmpvar_29), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_30);
  tmpvar_1 = color_8;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 438
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 433
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 438
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 438
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 442
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 446
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 450
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 454
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 458
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 462
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 466
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 470
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 474
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 478
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 485
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 489
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 493
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_4;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = (tmpvar_3 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
uniform float _DensityRatioX;
uniform float _DensityRatioY;
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
  float oceanSphereDist_1;
  float d2_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  depth_3 = 1e+32;
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_6;
  tmpvar_6 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_5 * tmpvar_5)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_6, 2.0);
  d2_2 = tmpvar_7;
  float tmpvar_8;
  tmpvar_8 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_1 = 1e+32;
  if (((tmpvar_6 <= _OceanRadius) && (tmpvar_5 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_5 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_7)));
  };
  float tmpvar_9;
  tmpvar_9 = min (oceanSphereDist_1, 1e+32);
  depth_3 = tmpvar_9;
  vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  float tmpvar_11;
  tmpvar_11 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_8 < _SphereRadius) && (tmpvar_5 < 0.0))) {
    float tmpvar_12;
    tmpvar_12 = sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_7));
    float tmpvar_13;
    tmpvar_13 = (min (tmpvar_9, (sqrt((tmpvar_11 - tmpvar_7)) - tmpvar_12)) + tmpvar_12);
    float tmpvar_14;
    tmpvar_14 = (tmpvar_7 * _DensityRatioY);
    d2_2 = tmpvar_14;
    depth_3 = ((((tmpvar_12 * ((tmpvar_14 + (((_DensityRatioX * tmpvar_12) * tmpvar_12) * 0.333333)) - tmpvar_11)) - (tmpvar_13 * ((tmpvar_14 + (((_DensityRatioX * tmpvar_13) * tmpvar_13) * 0.333333)) - tmpvar_11))) / tmpvar_11) * _Visibility);
  } else {
    if (((tmpvar_6 <= _SphereRadius) && (tmpvar_5 >= 0.0))) {
      float tmpvar_15;
      tmpvar_15 = sqrt((tmpvar_11 - d2_2));
      float tmpvar_16;
      tmpvar_16 = max (0.0, (tmpvar_5 - depth_3));
      float tmpvar_17;
      tmpvar_17 = min (tmpvar_15, max (0.0, (depth_3 - tmpvar_5)));
      float tmpvar_18;
      tmpvar_18 = mix (tmpvar_15, tmpvar_5, clamp (floor(((1.0 + _SphereRadius) - tmpvar_8)), 0.0, 1.0));
      float tmpvar_19;
      tmpvar_19 = (d2_2 * _DensityRatioY);
      d2_2 = tmpvar_19;
      depth_3 = (((((tmpvar_16 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_16) * tmpvar_16) * 0.333333)) - tmpvar_11)) + -((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_11)))) + -((tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_11)))) / tmpvar_11) * _Visibility);
    } else {
      depth_3 = 0.0;
    };
  };
  color_4.w = (_Color.w * clamp ((depth_3 * max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (tmpvar_10, normalize(_WorldSpaceLightPos0).xyz)) * 2.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x))).x))), 0.0, 1.0));
  gl_FragData[0] = color_4;
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
"vs_3_0
; 17 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c11.x
mov o0, r0
mul r1.y, r1, c9.x
mov o2.zw, r0
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
mad o2.xy, r1.z, c10.zwzw, r1
mov o3.xyz, r0
add o4.xyz, r0, -c8
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 16 instructions, 2 temp regs, 0 temp arrays:
// ALU 12 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedeohallacllmbpnmpafgolbepmfljlobcabaaaaaaniadaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmacaaaaeaaaabaa
jpaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaghccabaaaaeaaaaaa
egiccaaaabaaaaaaapaaaaaaaaaaaaakhccabaaaafaaaaaaegiccaiaebaaaaaa
aaaaaaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  lowp float tmpvar_28;
  mediump float lightShadowDataX_29;
  highp float dist_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = _LightShadowData.x;
  lightShadowDataX_29 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = max (float((dist_30 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_29);
  tmpvar_28 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * tmpvar_28))).x));
  highp float tmpvar_35;
  tmpvar_35 = clamp ((depth_7 * tmpvar_34), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_35);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
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
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = (tmpvar_3 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  mediump float tmpvar_29;
  tmpvar_29 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * tmpvar_28.x))).x));
  highp float tmpvar_30;
  tmpvar_30 = clamp ((depth_7 * tmpvar_29), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_30);
  tmpvar_1 = color_8;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 438
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 433
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 438
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 438
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 442
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 446
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 450
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 454
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 458
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 462
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 466
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 470
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 474
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 478
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 485
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 489
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 493
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
uniform float _DensityRatioX;
uniform float _DensityRatioY;
uniform float _SphereRadius;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  float d2_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  depth_3 = 1e+32;
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_6;
  tmpvar_6 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_5 * tmpvar_5)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_6, 2.0);
  d2_2 = tmpvar_7;
  float tmpvar_8;
  tmpvar_8 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_1 = 1e+32;
  if (((tmpvar_6 <= _OceanRadius) && (tmpvar_5 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_5 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_7)));
  };
  float tmpvar_9;
  tmpvar_9 = min (oceanSphereDist_1, 1e+32);
  depth_3 = tmpvar_9;
  vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  float tmpvar_11;
  tmpvar_11 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_8 < _SphereRadius) && (tmpvar_5 < 0.0))) {
    float tmpvar_12;
    tmpvar_12 = sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_7));
    float tmpvar_13;
    tmpvar_13 = (min (tmpvar_9, (sqrt((tmpvar_11 - tmpvar_7)) - tmpvar_12)) + tmpvar_12);
    float tmpvar_14;
    tmpvar_14 = (tmpvar_7 * _DensityRatioY);
    d2_2 = tmpvar_14;
    depth_3 = ((((tmpvar_12 * ((tmpvar_14 + (((_DensityRatioX * tmpvar_12) * tmpvar_12) * 0.333333)) - tmpvar_11)) - (tmpvar_13 * ((tmpvar_14 + (((_DensityRatioX * tmpvar_13) * tmpvar_13) * 0.333333)) - tmpvar_11))) / tmpvar_11) * _Visibility);
  } else {
    if (((tmpvar_6 <= _SphereRadius) && (tmpvar_5 >= 0.0))) {
      float tmpvar_15;
      tmpvar_15 = sqrt((tmpvar_11 - d2_2));
      float tmpvar_16;
      tmpvar_16 = max (0.0, (tmpvar_5 - depth_3));
      float tmpvar_17;
      tmpvar_17 = min (tmpvar_15, max (0.0, (depth_3 - tmpvar_5)));
      float tmpvar_18;
      tmpvar_18 = mix (tmpvar_15, tmpvar_5, clamp (floor(((1.0 + _SphereRadius) - tmpvar_8)), 0.0, 1.0));
      float tmpvar_19;
      tmpvar_19 = (d2_2 * _DensityRatioY);
      d2_2 = tmpvar_19;
      depth_3 = (((((tmpvar_16 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_16) * tmpvar_16) * 0.333333)) - tmpvar_11)) + -((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_11)))) + -((tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_11)))) / tmpvar_11) * _Visibility);
    } else {
      depth_3 = 0.0;
    };
  };
  color_4.w = (_Color.w * clamp ((depth_3 * max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (tmpvar_10, normalize(_WorldSpaceLightPos0).xyz)) * 2.0))).x))), 0.0, 1.0));
  gl_FragData[0] = color_4;
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
"vs_3_0
; 12 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord4 o2
dcl_texcoord5 o3
dcl_position0 v0
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
mov o2.xyz, r0
add o3.xyz, r0, -c8
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 11 instructions, 1 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedihbkcdeoplfjgilfaccgfjahpcdijoaaabaaaaaaciadaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oeabaaaaeaaaabaahjaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaak
hccabaaaaeaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaegiccaaaabaaaaaa
apaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0))).x));
  highp float tmpvar_29;
  tmpvar_29 = clamp ((depth_7 * tmpvar_28), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_29);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0))).x));
  highp float tmpvar_29;
  tmpvar_29 = clamp ((depth_7 * tmpvar_28), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_29);
  tmpvar_1 = color_8;
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
#line 407
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 400
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 416
#line 428
#line 416
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 420
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 424
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 407
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 400
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 416
#line 428
#line 428
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 432
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 436
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 440
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 444
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 448
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 452
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 456
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 460
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 464
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 468
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 475
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 479
    lowp float atten = 1.0;
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 483
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_4;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = (tmpvar_3 - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
uniform float _DensityRatioX;
uniform float _DensityRatioY;
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
  float oceanSphereDist_1;
  float d2_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  depth_3 = 1e+32;
  float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_6;
  tmpvar_6 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_5 * tmpvar_5)));
  float tmpvar_7;
  tmpvar_7 = pow (tmpvar_6, 2.0);
  d2_2 = tmpvar_7;
  float tmpvar_8;
  tmpvar_8 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_1 = 1e+32;
  if (((tmpvar_6 <= _OceanRadius) && (tmpvar_5 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_5 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_7)));
  };
  float tmpvar_9;
  tmpvar_9 = min (oceanSphereDist_1, 1e+32);
  depth_3 = tmpvar_9;
  vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  float tmpvar_11;
  tmpvar_11 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_8 < _SphereRadius) && (tmpvar_5 < 0.0))) {
    float tmpvar_12;
    tmpvar_12 = sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_7));
    float tmpvar_13;
    tmpvar_13 = (min (tmpvar_9, (sqrt((tmpvar_11 - tmpvar_7)) - tmpvar_12)) + tmpvar_12);
    float tmpvar_14;
    tmpvar_14 = (tmpvar_7 * _DensityRatioY);
    d2_2 = tmpvar_14;
    depth_3 = ((((tmpvar_12 * ((tmpvar_14 + (((_DensityRatioX * tmpvar_12) * tmpvar_12) * 0.333333)) - tmpvar_11)) - (tmpvar_13 * ((tmpvar_14 + (((_DensityRatioX * tmpvar_13) * tmpvar_13) * 0.333333)) - tmpvar_11))) / tmpvar_11) * _Visibility);
  } else {
    if (((tmpvar_6 <= _SphereRadius) && (tmpvar_5 >= 0.0))) {
      float tmpvar_15;
      tmpvar_15 = sqrt((tmpvar_11 - d2_2));
      float tmpvar_16;
      tmpvar_16 = max (0.0, (tmpvar_5 - depth_3));
      float tmpvar_17;
      tmpvar_17 = min (tmpvar_15, max (0.0, (depth_3 - tmpvar_5)));
      float tmpvar_18;
      tmpvar_18 = mix (tmpvar_15, tmpvar_5, clamp (floor(((1.0 + _SphereRadius) - tmpvar_8)), 0.0, 1.0));
      float tmpvar_19;
      tmpvar_19 = (d2_2 * _DensityRatioY);
      d2_2 = tmpvar_19;
      depth_3 = (((((tmpvar_16 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_16) * tmpvar_16) * 0.333333)) - tmpvar_11)) + -((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_11)))) + -((tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_11)))) / tmpvar_11) * _Visibility);
    } else {
      depth_3 = 0.0;
    };
  };
  color_4.w = (_Color.w * clamp ((depth_3 * max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (tmpvar_10, normalize(_WorldSpaceLightPos0).xyz)) * 2.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x))).x))), 0.0, 1.0));
  gl_FragData[0] = color_4;
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
"vs_3_0
; 17 ALU
dcl_position o0
dcl_texcoord1 o1
dcl_texcoord2 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c11.x
mov o0, r0
mul r1.y, r1, c9.x
mov o2.zw, r0
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
mad o2.xy, r1.z, c10.zwzw, r1
mov o3.xyz, r0
add o4.xyz, r0, -c8
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 16 instructions, 2 temp regs, 0 temp arrays:
// ALU 12 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedeohallacllmbpnmpafgolbepmfljlobcabaaaaaaniadaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmacaaaaeaaaabaa
jpaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaghccabaaaaeaaaaaa
egiccaaaabaaaaaaapaaaaaaaaaaaaakhccabaaaafaaaaaaegiccaiaebaaaaaa
aaaaaaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  lowp float tmpvar_28;
  mediump float lightShadowDataX_29;
  highp float dist_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = _LightShadowData.x;
  lightShadowDataX_29 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = max (float((dist_30 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_29);
  tmpvar_28 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * tmpvar_28))).x));
  highp float tmpvar_35;
  tmpvar_35 = clamp ((depth_7 * tmpvar_34), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_35);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
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
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = (tmpvar_3 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  mediump float tmpvar_29;
  tmpvar_29 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * tmpvar_28.x))).x));
  highp float tmpvar_30;
  tmpvar_30 = clamp ((depth_7 * tmpvar_29), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_30);
  tmpvar_1 = color_8;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 438
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 433
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 438
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 438
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 442
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 446
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 450
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 454
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 458
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 462
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 466
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 470
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 474
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 478
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 485
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 489
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 493
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  lowp float shadow_28;
  lowp float tmpvar_29;
  tmpvar_29 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (tmpvar_29 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * shadow_28))).x));
  highp float tmpvar_32;
  tmpvar_32 = clamp ((depth_7 * tmpvar_31), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_32);
  tmpvar_1 = color_8;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 438
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 433
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 438
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 438
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 442
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 446
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 450
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 454
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 458
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 462
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 466
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 470
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 474
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 478
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 485
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 489
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 493
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  lowp float shadow_28;
  lowp float tmpvar_29;
  tmpvar_29 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (tmpvar_29 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * shadow_28))).x));
  highp float tmpvar_32;
  tmpvar_32 = clamp ((depth_7 * tmpvar_31), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_32);
  tmpvar_1 = color_8;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 438
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 433
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 438
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 438
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 442
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 446
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 450
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 454
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 458
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 462
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 466
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 470
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 474
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 478
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 485
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 489
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 493
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  lowp float shadow_28;
  lowp float tmpvar_29;
  tmpvar_29 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (tmpvar_29 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * shadow_28))).x));
  highp float tmpvar_32;
  tmpvar_32 = clamp ((depth_7 * tmpvar_31), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_32);
  tmpvar_1 = color_8;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 438
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 433
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 438
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 438
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 442
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 446
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 450
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 454
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 458
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 462
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 466
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 470
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 474
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 478
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 485
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 489
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 493
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = (tmpvar_2 - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  depth_7 = 1e+32;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_11;
  tmpvar_11 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_10 * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = pow (tmpvar_11, 2.0);
  d2_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = 1e+32;
  if (((tmpvar_11 <= _OceanRadius) && (tmpvar_10 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_10 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_12)));
  };
  highp float tmpvar_14;
  tmpvar_14 = min (oceanSphereDist_4, 1e+32);
  depth_7 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_13 < _SphereRadius) && (tmpvar_10 < 0.0))) {
    highp float tmpvar_17;
    tmpvar_17 = sqrt(((tmpvar_13 * tmpvar_13) - tmpvar_12));
    highp float tmpvar_18;
    tmpvar_18 = (min (tmpvar_14, (sqrt((tmpvar_16 - tmpvar_12)) - tmpvar_17)) + tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = (tmpvar_12 * _DensityRatioY);
    d2_5 = tmpvar_19;
    depth_7 = ((((tmpvar_17 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_16)) - (tmpvar_18 * ((tmpvar_19 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_16))) / tmpvar_16) * _Visibility);
  } else {
    if (((tmpvar_11 <= _SphereRadius) && (tmpvar_10 >= 0.0))) {
      mediump float sphereCheck_20;
      highp float tmpvar_21;
      tmpvar_21 = sqrt((tmpvar_16 - d2_5));
      highp float tmpvar_22;
      tmpvar_22 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_13)), 0.0, 1.0);
      sphereCheck_20 = tmpvar_22;
      highp float tmpvar_23;
      tmpvar_23 = max (0.0, (tmpvar_10 - depth_7));
      highp float tmpvar_24;
      tmpvar_24 = min (tmpvar_21, max (0.0, (depth_7 - tmpvar_10)));
      highp float tmpvar_25;
      tmpvar_25 = mix (tmpvar_21, tmpvar_10, sphereCheck_20);
      highp float tmpvar_26;
      tmpvar_26 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_26;
      depth_7 = (((((tmpvar_23 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_23) * tmpvar_23) * 0.333333)) - tmpvar_16)) + -((tmpvar_24 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_24) * tmpvar_24) * 0.333333)) - tmpvar_16)))) + -((tmpvar_25 * ((tmpvar_26 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_16)))) / tmpvar_16) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_27;
  lowp float shadow_28;
  lowp float tmpvar_29;
  tmpvar_29 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (tmpvar_29 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * shadow_28))).x));
  highp float tmpvar_32;
  tmpvar_32 = clamp ((depth_7 * tmpvar_31), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_32);
  tmpvar_1 = color_8;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 438
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 433
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 438
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 438
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 442
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 446
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 450
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 454
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 458
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 462
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 466
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 470
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 474
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 478
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 485
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 489
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 493
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityRatioX;
uniform float _DensityRatioY;
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
  float oceanSphereDist_1;
  float d2_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  float tmpvar_5;
  tmpvar_5 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_3 = tmpvar_5;
  float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_6 * tmpvar_6)));
  float tmpvar_8;
  tmpvar_8 = pow (tmpvar_7, 2.0);
  d2_2 = tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_1 = tmpvar_5;
  if (((tmpvar_7 <= _OceanRadius) && (tmpvar_6 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_6 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_8)));
  };
  float tmpvar_10;
  tmpvar_10 = min (oceanSphereDist_1, tmpvar_5);
  depth_3 = tmpvar_10;
  vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  float tmpvar_12;
  tmpvar_12 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_9 < _SphereRadius) && (tmpvar_6 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_8));
    float tmpvar_14;
    tmpvar_14 = (min (tmpvar_10, (sqrt((tmpvar_12 - tmpvar_8)) - tmpvar_13)) + tmpvar_13);
    float tmpvar_15;
    tmpvar_15 = (tmpvar_8 * _DensityRatioY);
    d2_2 = tmpvar_15;
    depth_3 = ((((tmpvar_13 * ((tmpvar_15 + (((_DensityRatioX * tmpvar_13) * tmpvar_13) * 0.333333)) - tmpvar_12)) - (tmpvar_14 * ((tmpvar_15 + (((_DensityRatioX * tmpvar_14) * tmpvar_14) * 0.333333)) - tmpvar_12))) / tmpvar_12) * _Visibility);
  } else {
    if (((tmpvar_7 <= _SphereRadius) && (tmpvar_6 >= 0.0))) {
      float tmpvar_16;
      tmpvar_16 = sqrt((tmpvar_12 - d2_2));
      float tmpvar_17;
      tmpvar_17 = max (0.0, (tmpvar_6 - depth_3));
      float tmpvar_18;
      tmpvar_18 = min (tmpvar_16, max (0.0, (depth_3 - tmpvar_6)));
      float tmpvar_19;
      tmpvar_19 = mix (tmpvar_16, tmpvar_6, clamp (floor(((1.0 + _SphereRadius) - tmpvar_9)), 0.0, 1.0));
      float tmpvar_20;
      tmpvar_20 = (d2_2 * _DensityRatioY);
      d2_2 = tmpvar_20;
      depth_3 = (((((tmpvar_17 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_12)) + -((tmpvar_18 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_12)))) + -((tmpvar_19 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_12)))) / tmpvar_12) * _Visibility);
    } else {
      depth_3 = 0.0;
    };
  };
  color_4.w = (_Color.w * clamp ((depth_3 * max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (tmpvar_11, normalize(_WorldSpaceLightPos0).xyz)) * 2.0))).x))), 0.0, 1.0));
  gl_FragData[0] = color_4;
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
Vector 15 [_PlanetOrigin]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c16.x
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
mov r0.xyz, c15
dp4 r0.w, v0, c2
mad o1.xy, r1.z, c14.zwzw, r1
mov o3.xyz, c15
add o4.xyz, -c12, r0
mov o1.z, -r0.w
mov o1.w, r1
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 128 // 108 used size, 11 vars
Vector 96 [_PlanetOrigin] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 21 instructions, 2 temp regs, 0 temp arrays:
// ALU 17 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbjmhoooedljedajogfnmcfffmjidfijoabaaaaaaiaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
dmadaaaaeaaaabaampaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakhccabaaaaeaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0))).x));
  highp float tmpvar_31;
  tmpvar_31 = clamp ((depth_7 * tmpvar_30), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_31);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0))).x));
  highp float tmpvar_31;
  tmpvar_31 = clamp ((depth_7 * tmpvar_30), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_31);
  tmpvar_1 = color_8;
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
#line 407
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 400
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 416
#line 429
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 416
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 420
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 424
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 407
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 400
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 416
#line 429
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 429
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 433
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 437
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    #line 441
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    #line 446
    depth = min( oceanSphereDist, depth);
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 451
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 455
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 459
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 463
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 467
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 471
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 478
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 482
    lowp float atten = 1.0;
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 486
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityRatioX;
uniform float _DensityRatioY;
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
  float oceanSphereDist_1;
  float d2_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  float tmpvar_5;
  tmpvar_5 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_3 = tmpvar_5;
  float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_6 * tmpvar_6)));
  float tmpvar_8;
  tmpvar_8 = pow (tmpvar_7, 2.0);
  d2_2 = tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_1 = tmpvar_5;
  if (((tmpvar_7 <= _OceanRadius) && (tmpvar_6 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_6 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_8)));
  };
  float tmpvar_10;
  tmpvar_10 = min (oceanSphereDist_1, tmpvar_5);
  depth_3 = tmpvar_10;
  vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  float tmpvar_12;
  tmpvar_12 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_9 < _SphereRadius) && (tmpvar_6 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_8));
    float tmpvar_14;
    tmpvar_14 = (min (tmpvar_10, (sqrt((tmpvar_12 - tmpvar_8)) - tmpvar_13)) + tmpvar_13);
    float tmpvar_15;
    tmpvar_15 = (tmpvar_8 * _DensityRatioY);
    d2_2 = tmpvar_15;
    depth_3 = ((((tmpvar_13 * ((tmpvar_15 + (((_DensityRatioX * tmpvar_13) * tmpvar_13) * 0.333333)) - tmpvar_12)) - (tmpvar_14 * ((tmpvar_15 + (((_DensityRatioX * tmpvar_14) * tmpvar_14) * 0.333333)) - tmpvar_12))) / tmpvar_12) * _Visibility);
  } else {
    if (((tmpvar_7 <= _SphereRadius) && (tmpvar_6 >= 0.0))) {
      float tmpvar_16;
      tmpvar_16 = sqrt((tmpvar_12 - d2_2));
      float tmpvar_17;
      tmpvar_17 = max (0.0, (tmpvar_6 - depth_3));
      float tmpvar_18;
      tmpvar_18 = min (tmpvar_16, max (0.0, (depth_3 - tmpvar_6)));
      float tmpvar_19;
      tmpvar_19 = mix (tmpvar_16, tmpvar_6, clamp (floor(((1.0 + _SphereRadius) - tmpvar_9)), 0.0, 1.0));
      float tmpvar_20;
      tmpvar_20 = (d2_2 * _DensityRatioY);
      d2_2 = tmpvar_20;
      depth_3 = (((((tmpvar_17 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_12)) + -((tmpvar_18 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_12)))) + -((tmpvar_19 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_12)))) / tmpvar_12) * _Visibility);
    } else {
      depth_3 = 0.0;
    };
  };
  color_4.w = (_Color.w * clamp ((depth_3 * max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (tmpvar_11, normalize(_WorldSpaceLightPos0).xyz)) * 2.0))).x))), 0.0, 1.0));
  gl_FragData[0] = color_4;
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
Vector 15 [_PlanetOrigin]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c16.x
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
mov r0.xyz, c15
dp4 r0.w, v0, c2
mad o1.xy, r1.z, c14.zwzw, r1
mov o3.xyz, c15
add o4.xyz, -c12, r0
mov o1.z, -r0.w
mov o1.w, r1
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 128 // 108 used size, 11 vars
Vector 96 [_PlanetOrigin] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 21 instructions, 2 temp regs, 0 temp arrays:
// ALU 17 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbjmhoooedljedajogfnmcfffmjidfijoabaaaaaaiaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
dmadaaaaeaaaabaampaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakhccabaaaaeaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0))).x));
  highp float tmpvar_31;
  tmpvar_31 = clamp ((depth_7 * tmpvar_30), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_31);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0))).x));
  highp float tmpvar_31;
  tmpvar_31 = clamp ((depth_7 * tmpvar_30), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_31);
  tmpvar_1 = color_8;
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
#line 407
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 400
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 416
#line 429
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 416
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 420
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 424
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 407
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 400
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 416
#line 429
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 429
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 433
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 437
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    #line 441
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    #line 446
    depth = min( oceanSphereDist, depth);
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 451
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 455
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 459
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 463
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 467
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 471
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 478
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 482
    lowp float atten = 1.0;
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 486
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityRatioX;
uniform float _DensityRatioY;
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
  float oceanSphereDist_1;
  float d2_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  float tmpvar_5;
  tmpvar_5 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_3 = tmpvar_5;
  float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_6 * tmpvar_6)));
  float tmpvar_8;
  tmpvar_8 = pow (tmpvar_7, 2.0);
  d2_2 = tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_1 = tmpvar_5;
  if (((tmpvar_7 <= _OceanRadius) && (tmpvar_6 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_6 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_8)));
  };
  float tmpvar_10;
  tmpvar_10 = min (oceanSphereDist_1, tmpvar_5);
  depth_3 = tmpvar_10;
  vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  float tmpvar_12;
  tmpvar_12 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_9 < _SphereRadius) && (tmpvar_6 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_8));
    float tmpvar_14;
    tmpvar_14 = (min (tmpvar_10, (sqrt((tmpvar_12 - tmpvar_8)) - tmpvar_13)) + tmpvar_13);
    float tmpvar_15;
    tmpvar_15 = (tmpvar_8 * _DensityRatioY);
    d2_2 = tmpvar_15;
    depth_3 = ((((tmpvar_13 * ((tmpvar_15 + (((_DensityRatioX * tmpvar_13) * tmpvar_13) * 0.333333)) - tmpvar_12)) - (tmpvar_14 * ((tmpvar_15 + (((_DensityRatioX * tmpvar_14) * tmpvar_14) * 0.333333)) - tmpvar_12))) / tmpvar_12) * _Visibility);
  } else {
    if (((tmpvar_7 <= _SphereRadius) && (tmpvar_6 >= 0.0))) {
      float tmpvar_16;
      tmpvar_16 = sqrt((tmpvar_12 - d2_2));
      float tmpvar_17;
      tmpvar_17 = max (0.0, (tmpvar_6 - depth_3));
      float tmpvar_18;
      tmpvar_18 = min (tmpvar_16, max (0.0, (depth_3 - tmpvar_6)));
      float tmpvar_19;
      tmpvar_19 = mix (tmpvar_16, tmpvar_6, clamp (floor(((1.0 + _SphereRadius) - tmpvar_9)), 0.0, 1.0));
      float tmpvar_20;
      tmpvar_20 = (d2_2 * _DensityRatioY);
      d2_2 = tmpvar_20;
      depth_3 = (((((tmpvar_17 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_12)) + -((tmpvar_18 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_12)))) + -((tmpvar_19 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_12)))) / tmpvar_12) * _Visibility);
    } else {
      depth_3 = 0.0;
    };
  };
  color_4.w = (_Color.w * clamp ((depth_3 * max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (tmpvar_11, normalize(_WorldSpaceLightPos0).xyz)) * 2.0))).x))), 0.0, 1.0));
  gl_FragData[0] = color_4;
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
Vector 15 [_PlanetOrigin]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c16.x
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
mov r0.xyz, c15
dp4 r0.w, v0, c2
mad o1.xy, r1.z, c14.zwzw, r1
mov o3.xyz, c15
add o4.xyz, -c12, r0
mov o1.z, -r0.w
mov o1.w, r1
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 128 // 108 used size, 11 vars
Vector 96 [_PlanetOrigin] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 21 instructions, 2 temp regs, 0 temp arrays:
// ALU 17 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbjmhoooedljedajogfnmcfffmjidfijoabaaaaaaiaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
dmadaaaaeaaaabaampaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakhccabaaaaeaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0))).x));
  highp float tmpvar_31;
  tmpvar_31 = clamp ((depth_7 * tmpvar_30), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_31);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0))).x));
  highp float tmpvar_31;
  tmpvar_31 = clamp ((depth_7 * tmpvar_30), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_31);
  tmpvar_1 = color_8;
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
#line 407
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 400
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 416
#line 429
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 416
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 420
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 424
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 407
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 400
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 416
#line 429
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 429
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 433
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 437
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    #line 441
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    #line 446
    depth = min( oceanSphereDist, depth);
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 451
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 455
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 459
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 463
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 467
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 471
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 478
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 482
    lowp float atten = 1.0;
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 486
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityRatioX;
uniform float _DensityRatioY;
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
  float oceanSphereDist_1;
  float d2_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  float tmpvar_5;
  tmpvar_5 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_3 = tmpvar_5;
  float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_6 * tmpvar_6)));
  float tmpvar_8;
  tmpvar_8 = pow (tmpvar_7, 2.0);
  d2_2 = tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_1 = tmpvar_5;
  if (((tmpvar_7 <= _OceanRadius) && (tmpvar_6 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_6 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_8)));
  };
  float tmpvar_10;
  tmpvar_10 = min (oceanSphereDist_1, tmpvar_5);
  depth_3 = tmpvar_10;
  vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  float tmpvar_12;
  tmpvar_12 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_9 < _SphereRadius) && (tmpvar_6 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_8));
    float tmpvar_14;
    tmpvar_14 = (min (tmpvar_10, (sqrt((tmpvar_12 - tmpvar_8)) - tmpvar_13)) + tmpvar_13);
    float tmpvar_15;
    tmpvar_15 = (tmpvar_8 * _DensityRatioY);
    d2_2 = tmpvar_15;
    depth_3 = ((((tmpvar_13 * ((tmpvar_15 + (((_DensityRatioX * tmpvar_13) * tmpvar_13) * 0.333333)) - tmpvar_12)) - (tmpvar_14 * ((tmpvar_15 + (((_DensityRatioX * tmpvar_14) * tmpvar_14) * 0.333333)) - tmpvar_12))) / tmpvar_12) * _Visibility);
  } else {
    if (((tmpvar_7 <= _SphereRadius) && (tmpvar_6 >= 0.0))) {
      float tmpvar_16;
      tmpvar_16 = sqrt((tmpvar_12 - d2_2));
      float tmpvar_17;
      tmpvar_17 = max (0.0, (tmpvar_6 - depth_3));
      float tmpvar_18;
      tmpvar_18 = min (tmpvar_16, max (0.0, (depth_3 - tmpvar_6)));
      float tmpvar_19;
      tmpvar_19 = mix (tmpvar_16, tmpvar_6, clamp (floor(((1.0 + _SphereRadius) - tmpvar_9)), 0.0, 1.0));
      float tmpvar_20;
      tmpvar_20 = (d2_2 * _DensityRatioY);
      d2_2 = tmpvar_20;
      depth_3 = (((((tmpvar_17 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_12)) + -((tmpvar_18 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_12)))) + -((tmpvar_19 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_12)))) / tmpvar_12) * _Visibility);
    } else {
      depth_3 = 0.0;
    };
  };
  color_4.w = (_Color.w * clamp ((depth_3 * max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (tmpvar_11, normalize(_WorldSpaceLightPos0).xyz)) * 2.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x))).x))), 0.0, 1.0));
  gl_FragData[0] = color_4;
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
Vector 15 [_PlanetOrigin]
"vs_3_0
; 21 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.x, v0, c7
mov r1.w, r2.x
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c16.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
mov r0.xyz, c15
dp4 r0.w, v0, c2
mov o0, r1
mov o4.xyz, c15
add o5.xyz, -c12, r0
mov o1.z, -r0.w
mov o1.w, r2.x
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 192 // 172 used size, 12 vars
Vector 160 [_PlanetOrigin] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 23 instructions, 2 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedodlhddggfglkgijljbdkcppefmcalmbjabaaaaaaneaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchiadaaaaeaaaabaa
noaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaaflccabaaaabaaaaaaegambaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaa
aaaaaaaaakaaaaaaaaaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaaakaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  lowp float tmpvar_30;
  mediump float lightShadowDataX_31;
  highp float dist_32;
  lowp float tmpvar_33;
  tmpvar_33 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_32 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = _LightShadowData.x;
  lightShadowDataX_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = max (float((dist_32 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_31);
  tmpvar_30 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * tmpvar_30))).x));
  highp float tmpvar_37;
  tmpvar_37 = clamp ((depth_7 * tmpvar_36), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_37);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  mediump float tmpvar_31;
  tmpvar_31 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * tmpvar_30.x))).x));
  highp float tmpvar_32;
  tmpvar_32 = clamp ((depth_7 * tmpvar_31), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_32);
  tmpvar_1 = color_8;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 433
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 437
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
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
#line 439
lowp vec4 frag( in v2f IN ) {
    #line 441
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 445
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 449
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 453
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 457
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 461
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 465
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 469
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 473
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 477
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 481
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 488
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 492
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 496
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityRatioX;
uniform float _DensityRatioY;
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
  float oceanSphereDist_1;
  float d2_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  float tmpvar_5;
  tmpvar_5 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_3 = tmpvar_5;
  float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_6 * tmpvar_6)));
  float tmpvar_8;
  tmpvar_8 = pow (tmpvar_7, 2.0);
  d2_2 = tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_1 = tmpvar_5;
  if (((tmpvar_7 <= _OceanRadius) && (tmpvar_6 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_6 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_8)));
  };
  float tmpvar_10;
  tmpvar_10 = min (oceanSphereDist_1, tmpvar_5);
  depth_3 = tmpvar_10;
  vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  float tmpvar_12;
  tmpvar_12 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_9 < _SphereRadius) && (tmpvar_6 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_8));
    float tmpvar_14;
    tmpvar_14 = (min (tmpvar_10, (sqrt((tmpvar_12 - tmpvar_8)) - tmpvar_13)) + tmpvar_13);
    float tmpvar_15;
    tmpvar_15 = (tmpvar_8 * _DensityRatioY);
    d2_2 = tmpvar_15;
    depth_3 = ((((tmpvar_13 * ((tmpvar_15 + (((_DensityRatioX * tmpvar_13) * tmpvar_13) * 0.333333)) - tmpvar_12)) - (tmpvar_14 * ((tmpvar_15 + (((_DensityRatioX * tmpvar_14) * tmpvar_14) * 0.333333)) - tmpvar_12))) / tmpvar_12) * _Visibility);
  } else {
    if (((tmpvar_7 <= _SphereRadius) && (tmpvar_6 >= 0.0))) {
      float tmpvar_16;
      tmpvar_16 = sqrt((tmpvar_12 - d2_2));
      float tmpvar_17;
      tmpvar_17 = max (0.0, (tmpvar_6 - depth_3));
      float tmpvar_18;
      tmpvar_18 = min (tmpvar_16, max (0.0, (depth_3 - tmpvar_6)));
      float tmpvar_19;
      tmpvar_19 = mix (tmpvar_16, tmpvar_6, clamp (floor(((1.0 + _SphereRadius) - tmpvar_9)), 0.0, 1.0));
      float tmpvar_20;
      tmpvar_20 = (d2_2 * _DensityRatioY);
      d2_2 = tmpvar_20;
      depth_3 = (((((tmpvar_17 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_12)) + -((tmpvar_18 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_12)))) + -((tmpvar_19 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_12)))) / tmpvar_12) * _Visibility);
    } else {
      depth_3 = 0.0;
    };
  };
  color_4.w = (_Color.w * clamp ((depth_3 * max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (tmpvar_11, normalize(_WorldSpaceLightPos0).xyz)) * 2.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x))).x))), 0.0, 1.0));
  gl_FragData[0] = color_4;
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
Vector 15 [_PlanetOrigin]
"vs_3_0
; 21 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.x, v0, c7
mov r1.w, r2.x
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c16.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
mov r0.xyz, c15
dp4 r0.w, v0, c2
mov o0, r1
mov o4.xyz, c15
add o5.xyz, -c12, r0
mov o1.z, -r0.w
mov o1.w, r2.x
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 192 // 172 used size, 12 vars
Vector 160 [_PlanetOrigin] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 23 instructions, 2 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedodlhddggfglkgijljbdkcppefmcalmbjabaaaaaaneaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchiadaaaaeaaaabaa
noaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaaflccabaaaabaaaaaaegambaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaa
aaaaaaaaakaaaaaaaaaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaaakaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  lowp float tmpvar_30;
  mediump float lightShadowDataX_31;
  highp float dist_32;
  lowp float tmpvar_33;
  tmpvar_33 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_32 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = _LightShadowData.x;
  lightShadowDataX_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = max (float((dist_32 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_31);
  tmpvar_30 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * tmpvar_30))).x));
  highp float tmpvar_37;
  tmpvar_37 = clamp ((depth_7 * tmpvar_36), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_37);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  mediump float tmpvar_31;
  tmpvar_31 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * tmpvar_30.x))).x));
  highp float tmpvar_32;
  tmpvar_32 = clamp ((depth_7 * tmpvar_31), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_32);
  tmpvar_1 = color_8;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 433
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 437
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
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
#line 439
lowp vec4 frag( in v2f IN ) {
    #line 441
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 445
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 449
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 453
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 457
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 461
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 465
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 469
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 473
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 477
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 481
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 488
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 492
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 496
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityRatioX;
uniform float _DensityRatioY;
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
  float oceanSphereDist_1;
  float d2_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  float tmpvar_5;
  tmpvar_5 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_3 = tmpvar_5;
  float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_6 * tmpvar_6)));
  float tmpvar_8;
  tmpvar_8 = pow (tmpvar_7, 2.0);
  d2_2 = tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_1 = tmpvar_5;
  if (((tmpvar_7 <= _OceanRadius) && (tmpvar_6 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_6 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_8)));
  };
  float tmpvar_10;
  tmpvar_10 = min (oceanSphereDist_1, tmpvar_5);
  depth_3 = tmpvar_10;
  vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  float tmpvar_12;
  tmpvar_12 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_9 < _SphereRadius) && (tmpvar_6 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_8));
    float tmpvar_14;
    tmpvar_14 = (min (tmpvar_10, (sqrt((tmpvar_12 - tmpvar_8)) - tmpvar_13)) + tmpvar_13);
    float tmpvar_15;
    tmpvar_15 = (tmpvar_8 * _DensityRatioY);
    d2_2 = tmpvar_15;
    depth_3 = ((((tmpvar_13 * ((tmpvar_15 + (((_DensityRatioX * tmpvar_13) * tmpvar_13) * 0.333333)) - tmpvar_12)) - (tmpvar_14 * ((tmpvar_15 + (((_DensityRatioX * tmpvar_14) * tmpvar_14) * 0.333333)) - tmpvar_12))) / tmpvar_12) * _Visibility);
  } else {
    if (((tmpvar_7 <= _SphereRadius) && (tmpvar_6 >= 0.0))) {
      float tmpvar_16;
      tmpvar_16 = sqrt((tmpvar_12 - d2_2));
      float tmpvar_17;
      tmpvar_17 = max (0.0, (tmpvar_6 - depth_3));
      float tmpvar_18;
      tmpvar_18 = min (tmpvar_16, max (0.0, (depth_3 - tmpvar_6)));
      float tmpvar_19;
      tmpvar_19 = mix (tmpvar_16, tmpvar_6, clamp (floor(((1.0 + _SphereRadius) - tmpvar_9)), 0.0, 1.0));
      float tmpvar_20;
      tmpvar_20 = (d2_2 * _DensityRatioY);
      d2_2 = tmpvar_20;
      depth_3 = (((((tmpvar_17 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_12)) + -((tmpvar_18 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_12)))) + -((tmpvar_19 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_12)))) / tmpvar_12) * _Visibility);
    } else {
      depth_3 = 0.0;
    };
  };
  color_4.w = (_Color.w * clamp ((depth_3 * max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (tmpvar_11, normalize(_WorldSpaceLightPos0).xyz)) * 2.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x))).x))), 0.0, 1.0));
  gl_FragData[0] = color_4;
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
Vector 15 [_PlanetOrigin]
"vs_3_0
; 21 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.x, v0, c7
mov r1.w, r2.x
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c16.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
mov r0.xyz, c15
dp4 r0.w, v0, c2
mov o0, r1
mov o4.xyz, c15
add o5.xyz, -c12, r0
mov o1.z, -r0.w
mov o1.w, r2.x
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 192 // 172 used size, 12 vars
Vector 160 [_PlanetOrigin] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 23 instructions, 2 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedodlhddggfglkgijljbdkcppefmcalmbjabaaaaaaneaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchiadaaaaeaaaabaa
noaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaaflccabaaaabaaaaaaegambaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaa
aaaaaaaaakaaaaaaaaaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaaakaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  lowp float tmpvar_30;
  mediump float lightShadowDataX_31;
  highp float dist_32;
  lowp float tmpvar_33;
  tmpvar_33 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_32 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = _LightShadowData.x;
  lightShadowDataX_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = max (float((dist_32 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_31);
  tmpvar_30 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * tmpvar_30))).x));
  highp float tmpvar_37;
  tmpvar_37 = clamp ((depth_7 * tmpvar_36), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_37);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  mediump float tmpvar_31;
  tmpvar_31 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * tmpvar_30.x))).x));
  highp float tmpvar_32;
  tmpvar_32 = clamp ((depth_7 * tmpvar_31), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_32);
  tmpvar_1 = color_8;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 433
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 437
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
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
#line 439
lowp vec4 frag( in v2f IN ) {
    #line 441
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 445
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 449
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 453
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 457
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 461
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 465
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 469
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 473
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 477
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 481
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 488
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 492
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 496
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityRatioX;
uniform float _DensityRatioY;
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
  float oceanSphereDist_1;
  float d2_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  float tmpvar_5;
  tmpvar_5 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_3 = tmpvar_5;
  float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_6 * tmpvar_6)));
  float tmpvar_8;
  tmpvar_8 = pow (tmpvar_7, 2.0);
  d2_2 = tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_1 = tmpvar_5;
  if (((tmpvar_7 <= _OceanRadius) && (tmpvar_6 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_6 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_8)));
  };
  float tmpvar_10;
  tmpvar_10 = min (oceanSphereDist_1, tmpvar_5);
  depth_3 = tmpvar_10;
  vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  float tmpvar_12;
  tmpvar_12 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_9 < _SphereRadius) && (tmpvar_6 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_8));
    float tmpvar_14;
    tmpvar_14 = (min (tmpvar_10, (sqrt((tmpvar_12 - tmpvar_8)) - tmpvar_13)) + tmpvar_13);
    float tmpvar_15;
    tmpvar_15 = (tmpvar_8 * _DensityRatioY);
    d2_2 = tmpvar_15;
    depth_3 = ((((tmpvar_13 * ((tmpvar_15 + (((_DensityRatioX * tmpvar_13) * tmpvar_13) * 0.333333)) - tmpvar_12)) - (tmpvar_14 * ((tmpvar_15 + (((_DensityRatioX * tmpvar_14) * tmpvar_14) * 0.333333)) - tmpvar_12))) / tmpvar_12) * _Visibility);
  } else {
    if (((tmpvar_7 <= _SphereRadius) && (tmpvar_6 >= 0.0))) {
      float tmpvar_16;
      tmpvar_16 = sqrt((tmpvar_12 - d2_2));
      float tmpvar_17;
      tmpvar_17 = max (0.0, (tmpvar_6 - depth_3));
      float tmpvar_18;
      tmpvar_18 = min (tmpvar_16, max (0.0, (depth_3 - tmpvar_6)));
      float tmpvar_19;
      tmpvar_19 = mix (tmpvar_16, tmpvar_6, clamp (floor(((1.0 + _SphereRadius) - tmpvar_9)), 0.0, 1.0));
      float tmpvar_20;
      tmpvar_20 = (d2_2 * _DensityRatioY);
      d2_2 = tmpvar_20;
      depth_3 = (((((tmpvar_17 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_12)) + -((tmpvar_18 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_12)))) + -((tmpvar_19 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_12)))) / tmpvar_12) * _Visibility);
    } else {
      depth_3 = 0.0;
    };
  };
  color_4.w = (_Color.w * clamp ((depth_3 * max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (tmpvar_11, normalize(_WorldSpaceLightPos0).xyz)) * 2.0))).x))), 0.0, 1.0));
  gl_FragData[0] = color_4;
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
Vector 15 [_PlanetOrigin]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c16.x
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
mov r0.xyz, c15
dp4 r0.w, v0, c2
mad o1.xy, r1.z, c14.zwzw, r1
mov o3.xyz, c15
add o4.xyz, -c12, r0
mov o1.z, -r0.w
mov o1.w, r1
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 128 // 108 used size, 11 vars
Vector 96 [_PlanetOrigin] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 21 instructions, 2 temp regs, 0 temp arrays:
// ALU 17 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbjmhoooedljedajogfnmcfffmjidfijoabaaaaaaiaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
dmadaaaaeaaaabaampaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakhccabaaaaeaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0))).x));
  highp float tmpvar_31;
  tmpvar_31 = clamp ((depth_7 * tmpvar_30), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_31);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, ((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0))).x));
  highp float tmpvar_31;
  tmpvar_31 = clamp ((depth_7 * tmpvar_30), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_31);
  tmpvar_1 = color_8;
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
#line 407
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 400
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 416
#line 429
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 416
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 420
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 424
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 407
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 400
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 416
#line 429
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 429
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 433
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 437
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    #line 441
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    #line 446
    depth = min( oceanSphereDist, depth);
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 451
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 455
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 459
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 463
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 467
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 471
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 478
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 482
    lowp float atten = 1.0;
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 486
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec3 _PlanetOrigin;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityRatioX;
uniform float _DensityRatioY;
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
  float oceanSphereDist_1;
  float d2_2;
  float depth_3;
  vec4 color_4;
  color_4 = _Color;
  float tmpvar_5;
  tmpvar_5 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  depth_3 = tmpvar_5;
  float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_6 * tmpvar_6)));
  float tmpvar_8;
  tmpvar_8 = pow (tmpvar_7, 2.0);
  d2_2 = tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_1 = tmpvar_5;
  if (((tmpvar_7 <= _OceanRadius) && (tmpvar_6 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_6 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_8)));
  };
  float tmpvar_10;
  tmpvar_10 = min (oceanSphereDist_1, tmpvar_5);
  depth_3 = tmpvar_10;
  vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  float tmpvar_12;
  tmpvar_12 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_9 < _SphereRadius) && (tmpvar_6 < 0.0))) {
    float tmpvar_13;
    tmpvar_13 = sqrt(((tmpvar_9 * tmpvar_9) - tmpvar_8));
    float tmpvar_14;
    tmpvar_14 = (min (tmpvar_10, (sqrt((tmpvar_12 - tmpvar_8)) - tmpvar_13)) + tmpvar_13);
    float tmpvar_15;
    tmpvar_15 = (tmpvar_8 * _DensityRatioY);
    d2_2 = tmpvar_15;
    depth_3 = ((((tmpvar_13 * ((tmpvar_15 + (((_DensityRatioX * tmpvar_13) * tmpvar_13) * 0.333333)) - tmpvar_12)) - (tmpvar_14 * ((tmpvar_15 + (((_DensityRatioX * tmpvar_14) * tmpvar_14) * 0.333333)) - tmpvar_12))) / tmpvar_12) * _Visibility);
  } else {
    if (((tmpvar_7 <= _SphereRadius) && (tmpvar_6 >= 0.0))) {
      float tmpvar_16;
      tmpvar_16 = sqrt((tmpvar_12 - d2_2));
      float tmpvar_17;
      tmpvar_17 = max (0.0, (tmpvar_6 - depth_3));
      float tmpvar_18;
      tmpvar_18 = min (tmpvar_16, max (0.0, (depth_3 - tmpvar_6)));
      float tmpvar_19;
      tmpvar_19 = mix (tmpvar_16, tmpvar_6, clamp (floor(((1.0 + _SphereRadius) - tmpvar_9)), 0.0, 1.0));
      float tmpvar_20;
      tmpvar_20 = (d2_2 * _DensityRatioY);
      d2_2 = tmpvar_20;
      depth_3 = (((((tmpvar_17 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_17) * tmpvar_17) * 0.333333)) - tmpvar_12)) + -((tmpvar_18 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_18) * tmpvar_18) * 0.333333)) - tmpvar_12)))) + -((tmpvar_19 * ((tmpvar_20 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_12)))) / tmpvar_12) * _Visibility);
    } else {
      depth_3 = 0.0;
    };
  };
  color_4.w = (_Color.w * clamp ((depth_3 * max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (tmpvar_11, normalize(_WorldSpaceLightPos0).xyz)) * 2.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x))).x))), 0.0, 1.0));
  gl_FragData[0] = color_4;
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
Vector 15 [_PlanetOrigin]
"vs_3_0
; 21 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.x, v0, c7
mov r1.w, r2.x
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c16.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
mov r0.xyz, c15
dp4 r0.w, v0, c2
mov o0, r1
mov o4.xyz, c15
add o5.xyz, -c12, r0
mov o1.z, -r0.w
mov o1.w, r2.x
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 192 // 172 used size, 12 vars
Vector 160 [_PlanetOrigin] 3
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 23 instructions, 2 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedodlhddggfglkgijljbdkcppefmcalmbjabaaaaaaneaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchiadaaaaeaaaabaa
noaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaaflccabaaaabaaaaaaegambaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
acaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaa
aaaaaaaaakaaaaaaaaaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaaakaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  lowp float tmpvar_30;
  mediump float lightShadowDataX_31;
  highp float dist_32;
  lowp float tmpvar_33;
  tmpvar_33 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_32 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = _LightShadowData.x;
  lightShadowDataX_31 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = max (float((dist_32 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_31);
  tmpvar_30 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * tmpvar_30))).x));
  highp float tmpvar_37;
  tmpvar_37 = clamp ((depth_7 * tmpvar_36), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_37);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2);
  mediump float tmpvar_31;
  tmpvar_31 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * tmpvar_30.x))).x));
  highp float tmpvar_32;
  tmpvar_32 = clamp ((depth_7 * tmpvar_31), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_32);
  tmpvar_1 = color_8;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 433
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 437
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
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
#line 439
lowp vec4 frag( in v2f IN ) {
    #line 441
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 445
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 449
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 453
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 457
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 461
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 465
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 469
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 473
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 477
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 481
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 488
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 492
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 496
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  lowp float shadow_30;
  lowp float tmpvar_31;
  tmpvar_31 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_32;
  tmpvar_32 = (_LightShadowData.x + (tmpvar_31 * (1.0 - _LightShadowData.x)));
  shadow_30 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * shadow_30))).x));
  highp float tmpvar_34;
  tmpvar_34 = clamp ((depth_7 * tmpvar_33), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_34);
  tmpvar_1 = color_8;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 433
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 437
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
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
#line 439
lowp vec4 frag( in v2f IN ) {
    #line 441
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 445
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 449
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 453
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 457
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 461
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 465
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 469
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 473
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 477
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 481
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 488
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 492
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 496
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  lowp float shadow_30;
  lowp float tmpvar_31;
  tmpvar_31 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_32;
  tmpvar_32 = (_LightShadowData.x + (tmpvar_31 * (1.0 - _LightShadowData.x)));
  shadow_30 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * shadow_30))).x));
  highp float tmpvar_34;
  tmpvar_34 = clamp ((depth_7 * tmpvar_33), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_34);
  tmpvar_1 = color_8;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 433
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 437
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
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
#line 439
lowp vec4 frag( in v2f IN ) {
    #line 441
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 445
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 449
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 453
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 457
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 461
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 465
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 469
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 473
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 477
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 481
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 488
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 492
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 496
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  lowp float shadow_30;
  lowp float tmpvar_31;
  tmpvar_31 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_32;
  tmpvar_32 = (_LightShadowData.x + (tmpvar_31 * (1.0 - _LightShadowData.x)));
  shadow_30 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * shadow_30))).x));
  highp float tmpvar_34;
  tmpvar_34 = clamp ((depth_7 * tmpvar_33), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_34);
  tmpvar_1 = color_8;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 433
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 437
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
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
#line 439
lowp vec4 frag( in v2f IN ) {
    #line 441
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 445
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 449
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 453
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 457
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 461
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 465
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 469
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 473
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 477
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 481
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 488
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 492
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 496
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
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
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec3 _PlanetOrigin;
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
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = _PlanetOrigin;
  xlv_TEXCOORD5 = (_PlanetOrigin - _WorldSpaceCameraPos);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
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
  highp float oceanSphereDist_4;
  highp float d2_5;
  mediump vec3 worldDir_6;
  highp float depth_7;
  mediump vec4 color_8;
  color_8 = _Color;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_7 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (1.0/(((_ZBufferParams.z * depth_7) + _ZBufferParams.w)));
  depth_7 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  worldDir_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD5, worldDir_6);
  highp float tmpvar_13;
  tmpvar_13 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_12 * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = pow (tmpvar_13, 2.0);
  d2_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  oceanSphereDist_4 = tmpvar_10;
  if (((tmpvar_13 <= _OceanRadius) && (tmpvar_12 >= 0.0))) {
    oceanSphereDist_4 = (tmpvar_12 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_14)));
  };
  highp float tmpvar_16;
  tmpvar_16 = min (oceanSphereDist_4, tmpvar_10);
  depth_7 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  norm_3 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_SphereRadius * _SphereRadius);
  if (((tmpvar_15 < _SphereRadius) && (tmpvar_12 < 0.0))) {
    highp float tmpvar_19;
    tmpvar_19 = sqrt(((tmpvar_15 * tmpvar_15) - tmpvar_14));
    highp float tmpvar_20;
    tmpvar_20 = (min (tmpvar_16, (sqrt((tmpvar_18 - tmpvar_14)) - tmpvar_19)) + tmpvar_19);
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_14 * _DensityRatioY);
    d2_5 = tmpvar_21;
    depth_7 = ((((tmpvar_19 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_19) * tmpvar_19) * 0.333333)) - tmpvar_18)) - (tmpvar_20 * ((tmpvar_21 + (((_DensityRatioX * tmpvar_20) * tmpvar_20) * 0.333333)) - tmpvar_18))) / tmpvar_18) * _Visibility);
  } else {
    if (((tmpvar_13 <= _SphereRadius) && (tmpvar_12 >= 0.0))) {
      mediump float sphereCheck_22;
      highp float tmpvar_23;
      tmpvar_23 = sqrt((tmpvar_18 - d2_5));
      highp float tmpvar_24;
      tmpvar_24 = clamp (floor(((1.0 + _SphereRadius) - tmpvar_15)), 0.0, 1.0);
      sphereCheck_22 = tmpvar_24;
      highp float tmpvar_25;
      tmpvar_25 = max (0.0, (tmpvar_12 - depth_7));
      highp float tmpvar_26;
      tmpvar_26 = min (tmpvar_23, max (0.0, (depth_7 - tmpvar_12)));
      highp float tmpvar_27;
      tmpvar_27 = mix (tmpvar_23, tmpvar_12, sphereCheck_22);
      highp float tmpvar_28;
      tmpvar_28 = (d2_5 * _DensityRatioY);
      d2_5 = tmpvar_28;
      depth_7 = (((((tmpvar_25 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_25) * tmpvar_25) * 0.333333)) - tmpvar_18)) + -((tmpvar_26 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_26) * tmpvar_26) * 0.333333)) - tmpvar_18)))) + -((tmpvar_27 * ((tmpvar_28 + (((_DensityRatioX * tmpvar_27) * tmpvar_27) * 0.333333)) - tmpvar_18)))) / tmpvar_18) * _Visibility);
    } else {
      depth_7 = 0.0;
    };
  };
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_29;
  lowp float shadow_30;
  lowp float tmpvar_31;
  tmpvar_31 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_32;
  tmpvar_32 = (_LightShadowData.x + (tmpvar_31 * (1.0 - _LightShadowData.x)));
  shadow_30 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, max (0.0, (_LightColor0.xyz * max (0.0, (((_LightColor0.w * dot (norm_3, lightDirection_2)) * 2.0) * shadow_30))).x));
  highp float tmpvar_34;
  tmpvar_34 = clamp ((depth_7 * tmpvar_33), 0.0, 1.0);
  color_8.w = (color_8.w * tmpvar_34);
  tmpvar_1 = color_8;
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 433
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 437
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD5 = vec3(xl_retval.L);
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
#line 415
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 408
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
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioX;
#line 425
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
#line 439
lowp vec4 frag( in v2f IN ) {
    #line 441
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 445
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    highp float d2 = pow( d, 2.0);
    #line 449
    highp float Llength = length(IN.L);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 453
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 457
    mediump vec3 norm = normalize((_WorldSpaceCameraPos - IN.worldOrigin));
    highp float r2 = (_SphereRadius * _SphereRadius);
    if (((Llength < _SphereRadius) && (tc < 0.0))){
        #line 461
        highp float tlc_1 = sqrt((r2 - d2));
        highp float td = sqrt(((Llength * Llength) - d2));
        depth = min( depth, (tlc_1 - td));
        highp float l = (depth + td);
        #line 465
        d2 *= _DensityRatioY;
        highp float c = _DensityRatioX;
        depth = ((td * ((d2 + (((c * td) * td) * 0.333333)) - r2)) - (l * ((d2 + (((c * l) * l) * 0.333333)) - r2)));
        depth /= r2;
        #line 469
        depth *= _Visibility;
    }
    else{
        if (((d <= _SphereRadius) && (tc >= 0.0))){
            #line 473
            highp float tlc_2 = sqrt((r2 - d2));
            mediump float sphereCheck = xll_saturate_f(floor(((1.0 + _SphereRadius) - Llength)));
            highp float subDepthL = max( 0.0, (tc - depth));
            highp float depthL = min( tlc_2, max( 0.0, (depth - tc)));
            #line 477
            highp float camL = mix( tlc_2, tc, sphereCheck);
            d2 *= _DensityRatioY;
            highp float c_1 = _DensityRatioX;
            depth = (subDepthL * ((d2 + (((c_1 * subDepthL) * subDepthL) * 0.333333)) - r2));
            #line 481
            depth += (-(depthL * ((d2 + (((c_1 * depthL) * depthL) * 0.333333)) - r2)));
            depth += (-(camL * ((d2 + (((c_1 * camL) * camL) * 0.333333)) - r2)));
            depth /= r2;
            depth *= _Visibility;
        }
        else{
            #line 488
            depth = 0.0;
        }
    }
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = dot( norm, lightDirection);
    #line 492
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = max( 0.0, (((_LightColor0.w * NdotL) * 2.0) * atten));
    mediump vec3 light = vec3( max( 0.0, float( (_LightColor0.xyz * lightIntensity))));
    NdotL = abs(NdotL);
    #line 496
    mediump float VdotL = dot( (-worldDir), lightDirection);
    color.w *= xll_saturate_f((depth * max( 0.0, float( light))));
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD4);
    xlt_IN.L = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 12
//   d3d9 - ALU: 105 to 108, TEX: 1 to 2, FLOW: 2 to 2
//   d3d11 - ALU: 79 to 85, TEX: 0 to 2, FLOW: 1 to 1
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
Float 7 [_DensityRatioY]
Float 8 [_DensityRatioX]
"ps_3_0
; 105 ALU, 2 FLOW
def c9, 1.00000000, 0.00000000, 100000003318135350000000000000000.00000000, 0.33333334
def c10, 2.00000000, 0, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord4 v1.xyz
dcl_texcoord5 v2.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r1.x, v2, r0
dp3 r1.z, v2, v2
mad r0.x, -r1, r1, r1.z
rsq r0.x, r0.x
rcp r0.w, r0.x
mul r1.y, r0.w, r0.w
mad r0.x, c5, c5, -r1.y
rsq r0.x, r0.x
rcp r0.x, r0.x
add r0.z, r1.x, -r0.x
add r0.x, -r0.w, c5
cmp r0.y, r1.x, c9.x, c9
cmp r0.x, r0, c9, c9.y
mul_pp r0.x, r0, r0.y
cmp r1.w, -r0.x, c9.z, r0.z
add r0.xyz, -v1, c0
dp3 r2.x, r0, r0
rsq r2.y, r2.x
rsq r1.z, r1.z
mul r0.xyz, r2.y, r0
rcp r2.x, r1.z
add r1.z, r2.x, -c6.x
cmp r1.z, r1, c9.y, c9.x
cmp r2.y, r1.x, c9, c9.x
mul_pp r2.y, r1.z, r2
min r1.w, r1, c9.z
mul r1.z, c6.x, c6.x
if_gt r2.y, c9.y
add r1.x, -r1.y, r1.z
mad r0.w, r2.x, r2.x, -r1.y
rsq r1.x, r1.x
rsq r0.w, r0.w
rcp r0.w, r0.w
rcp r1.x, r1.x
add r1.x, -r0.w, r1
min r1.x, r1.w, r1
add r1.w, r0, r1.x
mul r1.x, r1.w, c8
mul r2.x, r1.w, r1
mul r1.y, r1, c7.x
mad r2.x, r2, c9.w, r1.y
mul r1.x, r0.w, c8
mul r1.x, r0.w, r1
mad r1.x, r1, c9.w, r1.y
add r2.x, -r1.z, r2
add r1.x, r1, -r1.z
mul r1.y, r1.w, r2.x
rcp r1.z, r1.z
mad r0.w, r0, r1.x, -r1.y
mul r0.w, r0, r1.z
mul r1.w, r0, c4.x
else
add r2.y, r1.z, -r1
add r0.w, -r0, c6.x
rsq r2.z, r2.y
add r2.x, -r2, c6
add r2.y, r2.x, c9.x
rcp r2.x, r2.z
frc r2.z, r2.y
add r2.w, r1.x, -r2.x
add_sat r2.y, r2, -r2.z
mad r2.y, r2, r2.w, r2.x
mul r2.z, r2.y, c8.x
mul r2.w, r2.y, r2.z
add r2.z, r1.x, -r1.w
max r3.x, -r2.z, c9.y
mul r1.y, r1, c7.x
mad r1.w, r2, c9, r1.y
min r2.x, r2, r3
mul r2.w, r2.x, c8.x
mul r3.x, r2, r2.w
max r2.z, r2, c9.y
mad r3.x, r3, c9.w, r1.y
add r3.x, -r1.z, r3
mul r2.w, r2.z, c8.x
mul r2.w, r2.z, r2
mad r1.y, r2.w, c9.w, r1
add r1.w, -r1.z, r1
add r1.y, -r1.z, r1
mul r2.x, r2, r3
mad r1.y, r2.z, r1, -r2.x
mad r1.y, -r2, r1.w, r1
rcp r1.z, r1.z
cmp r1.x, r1, c9, c9.y
cmp r0.w, r0, c9.x, c9.y
mul_pp r0.w, r0, r1.x
mul r1.y, r1, r1.z
mul r1.x, r1.y, c4
abs_pp r0.w, r0
cmp r1.w, -r0, c9.y, r1.x
endif
dp4_pp r0.w, c1, c1
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, c1
dp3_pp r0.x, r0, r1
mul_pp r0.x, r0, c2.w
mul_pp r0.x, r0, c10
max_pp r0.x, r0, c9.y
mul_pp r0.x, r0, c2
max r0.x, r0, c9.y
max r0.x, r0, c9.y
mul_sat r0.x, r1.w, r0
mul_pp oC0.w, r0.x, c3
mov_pp oC0.xyz, c3
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 116 used size, 11 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Float 80 [_Visibility]
Float 84 [_OceanRadius]
Float 88 [_SphereRadius]
Float 108 [_DensityRatioY]
Float 112 [_DensityRatioX]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
// 83 instructions, 3 temp regs, 0 temp arrays:
// ALU 76 float, 0 int, 3 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddihcfabmmhobnoopofgmjgmbnbddpiaoabaaaaaajmalaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcjeakaaaaeaaaaaaakfacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaa
aaaaaaaabnaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaahecaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaadcaaaaak
icaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabnaaaaaidcaabaaa
abaaaaaajgifcaaaaaaaaaaaafaaaaaapgapbaaaaaaaaaaaabaaaaahdcaabaaa
abaaaaaafgafbaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaafmcaabaaa
aaaaaaaakgaobaaaaaaaaaaadcaaaaammcaabaaaabaaaaaafgijcaaaaaaaaaaa
afaaaaaafgijcaaaaaaaaaaaafaaaaaafgafbaiaebaaaaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaaelaaaaaf
mcaabaaaabaaaaaakgaobaaaabaaaaaaaaaaaaaidcaabaaaacaaaaaaagaabaaa
aaaaaaaaogakbaiaebaaaaaaabaaaaaaddaaaaahecaabaaaabaaaaaaakaabaaa
acaaaaaaabeaaaaakomfjnhedhaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaakomfjnheaaaaaaaiecaabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaaakaabaaaabaaaaaadeaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaaaaddaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaa
ahaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaklkkkkdo
bkaabaaaaaaaaaaadcaaaaambcaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaa
afaaaaaackiacaaaaaaaaaaaafaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaa
akaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadbaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaadeaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaaaaadiaaaaahecaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaa
aaaaaaaaahaaaaaadcaaaaajecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaa
klkkkkdobkaabaaaaaaaaaaadcaaaaamecaabaaaacaaaaaackiacaiaebaaaaaa
aaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaackaabaaaacaaaaaadcaaaaak
ecaabaaaabaaaaaaakaabaaaacaaaaaackaabaaaacaaaaaackaabaiaebaaaaaa
abaaaaaaaaaaaaaibcaabaaaacaaaaaackiacaaaaaaaaaaaafaaaaaaabeaaaaa
aaaaiadpaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaa
acaaaaaadbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaaaaaaaaaaa
afaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaa
ebcaaaafecaabaaaaaaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaaddaaaaahbcaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaa
akiacaaaaaaaaaaaahaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaklkkkkdobkaabaaaaaaaaaaadcaaaaamicaabaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaadkaabaaaabaaaaaa
dcaaaaakecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaajecaabaaaabaaaaaackiacaaaaaaaaaaaafaaaaaa
ckiacaaaaaaaaaaaafaaaaaaaoaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaabaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaklkkkkdobkaabaaa
aaaaaaaadcaaaaamccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaa
ckiacaaaaaaaaaaaafaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaaaaaaaaaahaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaabaaaaaa
abeaaaaaklkkkkdobkaabaaaaaaaaaaadcaaaaamccaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaabkaabaaaaaaaaaaa
dcaaaaakccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaia
ebaaaaaaabaaaaaaaoaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
afaaaaaadhaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaajocaabaaaaaaaaaaaagbjbaiaebaaaaaaadaaaaaa
agijcaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaajgahbaaaaaaaaaaa
jgahbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagaabaaaabaaaaaabbaaaaajbcaabaaa
abaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaa
abaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaajgahbaaa
aaaaaaaaegacbaaaabaaaaaaapaaaaaiccaabaaaaaaaaaaapgipcaaaaaaaaaaa
abaaaaaafgafbaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaabaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaa
dgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadoaaaaab"
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
Float 7 [_DensityRatioY]
Float 8 [_DensityRatioX]
"ps_3_0
; 105 ALU, 2 FLOW
def c9, 1.00000000, 0.00000000, 100000003318135350000000000000000.00000000, 0.33333334
def c10, 2.00000000, 0, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord4 v1.xyz
dcl_texcoord5 v2.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r1.x, v2, r0
dp3 r1.z, v2, v2
mad r0.x, -r1, r1, r1.z
rsq r0.x, r0.x
rcp r0.w, r0.x
mul r1.y, r0.w, r0.w
mad r0.x, c5, c5, -r1.y
rsq r0.x, r0.x
rcp r0.x, r0.x
add r0.z, r1.x, -r0.x
add r0.x, -r0.w, c5
cmp r0.y, r1.x, c9.x, c9
cmp r0.x, r0, c9, c9.y
mul_pp r0.x, r0, r0.y
cmp r1.w, -r0.x, c9.z, r0.z
add r0.xyz, -v1, c0
dp3 r2.x, r0, r0
rsq r2.y, r2.x
rsq r1.z, r1.z
mul r0.xyz, r2.y, r0
rcp r2.x, r1.z
add r1.z, r2.x, -c6.x
cmp r1.z, r1, c9.y, c9.x
cmp r2.y, r1.x, c9, c9.x
mul_pp r2.y, r1.z, r2
min r1.w, r1, c9.z
mul r1.z, c6.x, c6.x
if_gt r2.y, c9.y
add r1.x, -r1.y, r1.z
mad r0.w, r2.x, r2.x, -r1.y
rsq r1.x, r1.x
rsq r0.w, r0.w
rcp r0.w, r0.w
rcp r1.x, r1.x
add r1.x, -r0.w, r1
min r1.x, r1.w, r1
add r1.w, r0, r1.x
mul r1.x, r1.w, c8
mul r2.x, r1.w, r1
mul r1.y, r1, c7.x
mad r2.x, r2, c9.w, r1.y
mul r1.x, r0.w, c8
mul r1.x, r0.w, r1
mad r1.x, r1, c9.w, r1.y
add r2.x, -r1.z, r2
add r1.x, r1, -r1.z
mul r1.y, r1.w, r2.x
rcp r1.z, r1.z
mad r0.w, r0, r1.x, -r1.y
mul r0.w, r0, r1.z
mul r1.w, r0, c4.x
else
add r2.y, r1.z, -r1
add r0.w, -r0, c6.x
rsq r2.z, r2.y
add r2.x, -r2, c6
add r2.y, r2.x, c9.x
rcp r2.x, r2.z
frc r2.z, r2.y
add r2.w, r1.x, -r2.x
add_sat r2.y, r2, -r2.z
mad r2.y, r2, r2.w, r2.x
mul r2.z, r2.y, c8.x
mul r2.w, r2.y, r2.z
add r2.z, r1.x, -r1.w
max r3.x, -r2.z, c9.y
mul r1.y, r1, c7.x
mad r1.w, r2, c9, r1.y
min r2.x, r2, r3
mul r2.w, r2.x, c8.x
mul r3.x, r2, r2.w
max r2.z, r2, c9.y
mad r3.x, r3, c9.w, r1.y
add r3.x, -r1.z, r3
mul r2.w, r2.z, c8.x
mul r2.w, r2.z, r2
mad r1.y, r2.w, c9.w, r1
add r1.w, -r1.z, r1
add r1.y, -r1.z, r1
mul r2.x, r2, r3
mad r1.y, r2.z, r1, -r2.x
mad r1.y, -r2, r1.w, r1
rcp r1.z, r1.z
cmp r1.x, r1, c9, c9.y
cmp r0.w, r0, c9.x, c9.y
mul_pp r0.w, r0, r1.x
mul r1.y, r1, r1.z
mul r1.x, r1.y, c4
abs_pp r0.w, r0
cmp r1.w, -r0, c9.y, r1.x
endif
dp4_pp r0.w, c1, c1
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, c1
dp3_pp r0.x, r0, r1
mul_pp r0.x, r0, c2.w
mul_pp r0.x, r0, c10
max_pp r0.x, r0, c9.y
mul_pp r0.x, r0, c2
max r0.x, r0, c9.y
max r0.x, r0, c9.y
mul_sat r0.x, r1.w, r0
mul_pp oC0.w, r0.x, c3
mov_pp oC0.xyz, c3
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 116 used size, 11 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Float 80 [_Visibility]
Float 84 [_OceanRadius]
Float 88 [_SphereRadius]
Float 108 [_DensityRatioY]
Float 112 [_DensityRatioX]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
// 83 instructions, 3 temp regs, 0 temp arrays:
// ALU 76 float, 0 int, 3 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddihcfabmmhobnoopofgmjgmbnbddpiaoabaaaaaajmalaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcjeakaaaaeaaaaaaakfacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaa
aaaaaaaabnaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaahecaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaadcaaaaak
icaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabnaaaaaidcaabaaa
abaaaaaajgifcaaaaaaaaaaaafaaaaaapgapbaaaaaaaaaaaabaaaaahdcaabaaa
abaaaaaafgafbaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaafmcaabaaa
aaaaaaaakgaobaaaaaaaaaaadcaaaaammcaabaaaabaaaaaafgijcaaaaaaaaaaa
afaaaaaafgijcaaaaaaaaaaaafaaaaaafgafbaiaebaaaaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaaelaaaaaf
mcaabaaaabaaaaaakgaobaaaabaaaaaaaaaaaaaidcaabaaaacaaaaaaagaabaaa
aaaaaaaaogakbaiaebaaaaaaabaaaaaaddaaaaahecaabaaaabaaaaaaakaabaaa
acaaaaaaabeaaaaakomfjnhedhaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaakomfjnheaaaaaaaiecaabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaaakaabaaaabaaaaaadeaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaaaaddaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaa
ahaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaklkkkkdo
bkaabaaaaaaaaaaadcaaaaambcaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaa
afaaaaaackiacaaaaaaaaaaaafaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaa
akaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadbaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaadeaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaaaaadiaaaaahecaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaa
aaaaaaaaahaaaaaadcaaaaajecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaa
klkkkkdobkaabaaaaaaaaaaadcaaaaamecaabaaaacaaaaaackiacaiaebaaaaaa
aaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaackaabaaaacaaaaaadcaaaaak
ecaabaaaabaaaaaaakaabaaaacaaaaaackaabaaaacaaaaaackaabaiaebaaaaaa
abaaaaaaaaaaaaaibcaabaaaacaaaaaackiacaaaaaaaaaaaafaaaaaaabeaaaaa
aaaaiadpaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaa
acaaaaaadbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaaaaaaaaaaa
afaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaa
ebcaaaafecaabaaaaaaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaaddaaaaahbcaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaa
akiacaaaaaaaaaaaahaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaklkkkkdobkaabaaaaaaaaaaadcaaaaamicaabaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaadkaabaaaabaaaaaa
dcaaaaakecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaajecaabaaaabaaaaaackiacaaaaaaaaaaaafaaaaaa
ckiacaaaaaaaaaaaafaaaaaaaoaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaabaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaklkkkkdobkaabaaa
aaaaaaaadcaaaaamccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaa
ckiacaaaaaaaaaaaafaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaaaaaaaaaahaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaabaaaaaa
abeaaaaaklkkkkdobkaabaaaaaaaaaaadcaaaaamccaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaabkaabaaaaaaaaaaa
dcaaaaakccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaia
ebaaaaaaabaaaaaaaoaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
afaaaaaadhaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaajocaabaaaaaaaaaaaagbjbaiaebaaaaaaadaaaaaa
agijcaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaajgahbaaaaaaaaaaa
jgahbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagaabaaaabaaaaaabbaaaaajbcaabaaa
abaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaa
abaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaajgahbaaa
aaaaaaaaegacbaaaabaaaaaaapaaaaaiccaabaaaaaaaaaaapgipcaaaaaaaaaaa
abaaaaaafgafbaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaabaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaa
dgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadoaaaaab"
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
Float 7 [_DensityRatioY]
Float 8 [_DensityRatioX]
"ps_3_0
; 105 ALU, 2 FLOW
def c9, 1.00000000, 0.00000000, 100000003318135350000000000000000.00000000, 0.33333334
def c10, 2.00000000, 0, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord4 v1.xyz
dcl_texcoord5 v2.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r1.x, v2, r0
dp3 r1.z, v2, v2
mad r0.x, -r1, r1, r1.z
rsq r0.x, r0.x
rcp r0.w, r0.x
mul r1.y, r0.w, r0.w
mad r0.x, c5, c5, -r1.y
rsq r0.x, r0.x
rcp r0.x, r0.x
add r0.z, r1.x, -r0.x
add r0.x, -r0.w, c5
cmp r0.y, r1.x, c9.x, c9
cmp r0.x, r0, c9, c9.y
mul_pp r0.x, r0, r0.y
cmp r1.w, -r0.x, c9.z, r0.z
add r0.xyz, -v1, c0
dp3 r2.x, r0, r0
rsq r2.y, r2.x
rsq r1.z, r1.z
mul r0.xyz, r2.y, r0
rcp r2.x, r1.z
add r1.z, r2.x, -c6.x
cmp r1.z, r1, c9.y, c9.x
cmp r2.y, r1.x, c9, c9.x
mul_pp r2.y, r1.z, r2
min r1.w, r1, c9.z
mul r1.z, c6.x, c6.x
if_gt r2.y, c9.y
add r1.x, -r1.y, r1.z
mad r0.w, r2.x, r2.x, -r1.y
rsq r1.x, r1.x
rsq r0.w, r0.w
rcp r0.w, r0.w
rcp r1.x, r1.x
add r1.x, -r0.w, r1
min r1.x, r1.w, r1
add r1.w, r0, r1.x
mul r1.x, r1.w, c8
mul r2.x, r1.w, r1
mul r1.y, r1, c7.x
mad r2.x, r2, c9.w, r1.y
mul r1.x, r0.w, c8
mul r1.x, r0.w, r1
mad r1.x, r1, c9.w, r1.y
add r2.x, -r1.z, r2
add r1.x, r1, -r1.z
mul r1.y, r1.w, r2.x
rcp r1.z, r1.z
mad r0.w, r0, r1.x, -r1.y
mul r0.w, r0, r1.z
mul r1.w, r0, c4.x
else
add r2.y, r1.z, -r1
add r0.w, -r0, c6.x
rsq r2.z, r2.y
add r2.x, -r2, c6
add r2.y, r2.x, c9.x
rcp r2.x, r2.z
frc r2.z, r2.y
add r2.w, r1.x, -r2.x
add_sat r2.y, r2, -r2.z
mad r2.y, r2, r2.w, r2.x
mul r2.z, r2.y, c8.x
mul r2.w, r2.y, r2.z
add r2.z, r1.x, -r1.w
max r3.x, -r2.z, c9.y
mul r1.y, r1, c7.x
mad r1.w, r2, c9, r1.y
min r2.x, r2, r3
mul r2.w, r2.x, c8.x
mul r3.x, r2, r2.w
max r2.z, r2, c9.y
mad r3.x, r3, c9.w, r1.y
add r3.x, -r1.z, r3
mul r2.w, r2.z, c8.x
mul r2.w, r2.z, r2
mad r1.y, r2.w, c9.w, r1
add r1.w, -r1.z, r1
add r1.y, -r1.z, r1
mul r2.x, r2, r3
mad r1.y, r2.z, r1, -r2.x
mad r1.y, -r2, r1.w, r1
rcp r1.z, r1.z
cmp r1.x, r1, c9, c9.y
cmp r0.w, r0, c9.x, c9.y
mul_pp r0.w, r0, r1.x
mul r1.y, r1, r1.z
mul r1.x, r1.y, c4
abs_pp r0.w, r0
cmp r1.w, -r0, c9.y, r1.x
endif
dp4_pp r0.w, c1, c1
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, c1
dp3_pp r0.x, r0, r1
mul_pp r0.x, r0, c2.w
mul_pp r0.x, r0, c10
max_pp r0.x, r0, c9.y
mul_pp r0.x, r0, c2
max r0.x, r0, c9.y
max r0.x, r0, c9.y
mul_sat r0.x, r1.w, r0
mul_pp oC0.w, r0.x, c3
mov_pp oC0.xyz, c3
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 116 used size, 11 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Float 80 [_Visibility]
Float 84 [_OceanRadius]
Float 88 [_SphereRadius]
Float 108 [_DensityRatioY]
Float 112 [_DensityRatioX]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
// 83 instructions, 3 temp regs, 0 temp arrays:
// ALU 76 float, 0 int, 3 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddihcfabmmhobnoopofgmjgmbnbddpiaoabaaaaaajmalaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcjeakaaaaeaaaaaaakfacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaa
aaaaaaaabnaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaahecaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaadcaaaaak
icaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabnaaaaaidcaabaaa
abaaaaaajgifcaaaaaaaaaaaafaaaaaapgapbaaaaaaaaaaaabaaaaahdcaabaaa
abaaaaaafgafbaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaafmcaabaaa
aaaaaaaakgaobaaaaaaaaaaadcaaaaammcaabaaaabaaaaaafgijcaaaaaaaaaaa
afaaaaaafgijcaaaaaaaaaaaafaaaaaafgafbaiaebaaaaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaaelaaaaaf
mcaabaaaabaaaaaakgaobaaaabaaaaaaaaaaaaaidcaabaaaacaaaaaaagaabaaa
aaaaaaaaogakbaiaebaaaaaaabaaaaaaddaaaaahecaabaaaabaaaaaaakaabaaa
acaaaaaaabeaaaaakomfjnhedhaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaakomfjnheaaaaaaaiecaabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaaakaabaaaabaaaaaadeaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaaaaddaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaa
ahaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaklkkkkdo
bkaabaaaaaaaaaaadcaaaaambcaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaa
afaaaaaackiacaaaaaaaaaaaafaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaa
akaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadbaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaadeaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaaaaadiaaaaahecaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaa
aaaaaaaaahaaaaaadcaaaaajecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaa
klkkkkdobkaabaaaaaaaaaaadcaaaaamecaabaaaacaaaaaackiacaiaebaaaaaa
aaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaackaabaaaacaaaaaadcaaaaak
ecaabaaaabaaaaaaakaabaaaacaaaaaackaabaaaacaaaaaackaabaiaebaaaaaa
abaaaaaaaaaaaaaibcaabaaaacaaaaaackiacaaaaaaaaaaaafaaaaaaabeaaaaa
aaaaiadpaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaa
acaaaaaadbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaaaaaaaaaaa
afaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaa
ebcaaaafecaabaaaaaaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaaddaaaaahbcaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaa
akiacaaaaaaaaaaaahaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaklkkkkdobkaabaaaaaaaaaaadcaaaaamicaabaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaadkaabaaaabaaaaaa
dcaaaaakecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaajecaabaaaabaaaaaackiacaaaaaaaaaaaafaaaaaa
ckiacaaaaaaaaaaaafaaaaaaaoaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaabaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaklkkkkdobkaabaaa
aaaaaaaadcaaaaamccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaa
ckiacaaaaaaaaaaaafaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaaaaaaaaaahaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaabaaaaaa
abeaaaaaklkkkkdobkaabaaaaaaaaaaadcaaaaamccaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaabkaabaaaaaaaaaaa
dcaaaaakccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaia
ebaaaaaaabaaaaaaaoaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
afaaaaaadhaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaajocaabaaaaaaaaaaaagbjbaiaebaaaaaaadaaaaaa
agijcaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaajgahbaaaaaaaaaaa
jgahbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagaabaaaabaaaaaabbaaaaajbcaabaaa
abaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaa
abaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaajgahbaaa
aaaaaaaaegacbaaaabaaaaaaapaaaaaiccaabaaaaaaaaaaapgipcaaaaaaaaaaa
abaaaaaafgafbaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaabaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaa
dgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadoaaaaab"
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
Float 7 [_DensityRatioY]
Float 8 [_DensityRatioX]
SetTexture 0 [_ShadowMapTexture] 2D
"ps_3_0
; 106 ALU, 1 TEX, 2 FLOW
dcl_2d s0
def c9, 1.00000000, 0.00000000, 100000003318135350000000000000000.00000000, 0.33333334
def c10, 2.00000000, 0, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord2 v1
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r1.x, v3, r0
dp3 r1.z, v3, v3
mad r0.x, -r1, r1, r1.z
rsq r0.x, r0.x
rcp r0.w, r0.x
mul r1.y, r0.w, r0.w
mad r0.x, c5, c5, -r1.y
rsq r0.x, r0.x
rcp r0.x, r0.x
add r0.z, r1.x, -r0.x
add r0.x, -r0.w, c5
cmp r0.y, r1.x, c9.x, c9
cmp r0.x, r0, c9, c9.y
mul_pp r0.x, r0, r0.y
cmp r1.w, -r0.x, c9.z, r0.z
add r0.xyz, -v2, c0
dp3 r2.x, r0, r0
rsq r2.y, r2.x
rsq r1.z, r1.z
mul r0.xyz, r2.y, r0
rcp r2.x, r1.z
add r1.z, r2.x, -c6.x
cmp r1.z, r1, c9.y, c9.x
cmp r2.y, r1.x, c9, c9.x
mul_pp r2.y, r1.z, r2
min r1.w, r1, c9.z
mul r1.z, c6.x, c6.x
if_gt r2.y, c9.y
add r1.x, -r1.y, r1.z
mad r0.w, r2.x, r2.x, -r1.y
rsq r1.x, r1.x
rsq r0.w, r0.w
rcp r0.w, r0.w
rcp r1.x, r1.x
add r1.x, -r0.w, r1
min r1.x, r1.w, r1
add r1.w, r0, r1.x
mul r1.x, r1.w, c8
mul r2.x, r1.w, r1
mul r1.y, r1, c7.x
mad r2.x, r2, c9.w, r1.y
mul r1.x, r0.w, c8
mul r1.x, r0.w, r1
mad r1.x, r1, c9.w, r1.y
add r2.x, -r1.z, r2
add r1.x, r1, -r1.z
mul r1.y, r1.w, r2.x
rcp r1.z, r1.z
mad r0.w, r0, r1.x, -r1.y
mul r0.w, r0, r1.z
mul r1.w, r0, c4.x
else
add r2.y, r1.z, -r1
add r0.w, -r0, c6.x
rsq r2.z, r2.y
add r2.x, -r2, c6
add r2.y, r2.x, c9.x
rcp r2.x, r2.z
frc r2.z, r2.y
add r2.w, r1.x, -r2.x
add_sat r2.y, r2, -r2.z
mad r2.y, r2, r2.w, r2.x
mul r2.z, r2.y, c8.x
mul r2.w, r2.y, r2.z
add r2.z, r1.x, -r1.w
max r3.x, -r2.z, c9.y
mul r1.y, r1, c7.x
mad r1.w, r2, c9, r1.y
min r2.x, r2, r3
mul r2.w, r2.x, c8.x
mul r3.x, r2, r2.w
max r2.z, r2, c9.y
mad r3.x, r3, c9.w, r1.y
add r3.x, -r1.z, r3
mul r2.w, r2.z, c8.x
mul r2.w, r2.z, r2
mad r1.y, r2.w, c9.w, r1
add r1.w, -r1.z, r1
add r1.y, -r1.z, r1
mul r2.x, r2, r3
mad r1.y, r2.z, r1, -r2.x
mad r1.y, -r2, r1.w, r1
rcp r1.z, r1.z
cmp r1.x, r1, c9, c9.y
cmp r0.w, r0, c9.x, c9.y
mul_pp r0.w, r0, r1.x
mul r1.y, r1, r1.z
mul r1.x, r1.y, c4
abs_pp r0.w, r0
cmp r1.w, -r0, c9.y, r1.x
endif
dp4_pp r0.w, c1, c1
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, c1
dp3_pp r0.y, r0, r1
texldp r0.x, v1, s0
mul_pp r0.y, r0, c2.w
mul_pp r0.x, r0.y, r0
mul_pp r0.x, r0, c10
max_pp r0.x, r0, c9.y
mul_pp r0.x, r0, c2
max r0.x, r0, c9.y
max r0.x, r0, c9.y
mul_sat r0.x, r1.w, r0
mul_pp oC0.w, r0.x, c3
mov_pp oC0.xyz, c3
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 180 used size, 12 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 144 [_Visibility]
Float 148 [_OceanRadius]
Float 152 [_SphereRadius]
Float 172 [_DensityRatioY]
Float 176 [_DensityRatioX]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
SetTexture 0 [_ShadowMapTexture] 2D 0
// 86 instructions, 3 temp regs, 0 temp arrays:
// ALU 78 float, 0 int, 3 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecediomlehlimpkpihccnocimfafkjjahhobabaaaaaadiamaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbialaaaa
eaaaaaaamgacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegacbaaa
aaaaaaaabnaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaahecaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaadcaaaaak
icaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabnaaaaaidcaabaaa
abaaaaaajgifcaaaaaaaaaaaajaaaaaapgapbaaaaaaaaaaaabaaaaahdcaabaaa
abaaaaaafgafbaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaafmcaabaaa
aaaaaaaakgaobaaaaaaaaaaadcaaaaammcaabaaaabaaaaaafgijcaaaaaaaaaaa
ajaaaaaafgijcaaaaaaaaaaaajaaaaaafgafbaiaebaaaaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaaelaaaaaf
mcaabaaaabaaaaaakgaobaaaabaaaaaaaaaaaaaidcaabaaaacaaaaaaagaabaaa
aaaaaaaaogakbaiaebaaaaaaabaaaaaaddaaaaahecaabaaaabaaaaaaakaabaaa
acaaaaaaabeaaaaakomfjnhedhaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaakomfjnheaaaaaaaiecaabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaaakaabaaaabaaaaaadeaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaaaaddaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaa
alaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaklkkkkdo
bkaabaaaaaaaaaaadcaaaaambcaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaa
ajaaaaaackiacaaaaaaaaaaaajaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaa
akaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadbaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaadeaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaaaaadiaaaaahecaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaa
aaaaaaaaalaaaaaadcaaaaajecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaa
klkkkkdobkaabaaaaaaaaaaadcaaaaamecaabaaaacaaaaaackiacaiaebaaaaaa
aaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaackaabaaaacaaaaaadcaaaaak
ecaabaaaabaaaaaaakaabaaaacaaaaaackaabaaaacaaaaaackaabaiaebaaaaaa
abaaaaaaaaaaaaaibcaabaaaacaaaaaackiacaaaaaaaaaaaajaaaaaaabeaaaaa
aaaaiadpaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaa
acaaaaaadbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaaaaaaaaaaa
ajaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaa
ebcaaaafecaabaaaaaaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaaddaaaaahbcaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaa
akiacaaaaaaaaaaaalaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaklkkkkdobkaabaaaaaaaaaaadcaaaaamicaabaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaadkaabaaaabaaaaaa
dcaaaaakecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaajecaabaaaabaaaaaackiacaaaaaaaaaaaajaaaaaa
ckiacaaaaaaaaaaaajaaaaaaaoaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaabaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaajaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaalaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaklkkkkdobkaabaaa
aaaaaaaadcaaaaamccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaa
ckiacaaaaaaaaaaaajaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaaaaaaaaaalaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaabaaaaaa
abeaaaaaklkkkkdobkaabaaaaaaaaaaadcaaaaamccaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaabkaabaaaaaaaaaaa
dcaaaaakccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaia
ebaaaaaaabaaaaaaaoaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
ajaaaaaadhaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaajocaabaaaaaaaaaaaagbjbaiaebaaaaaaaeaaaaaa
agijcaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaajgahbaaaaaaaaaaa
jgahbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagaabaaaabaaaaaabbaaaaajbcaabaaa
abaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaa
abaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaajgahbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaaaoaaaaahmcaabaaaaaaaaaaaagbebaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaapaaaaahccaabaaaaaaaaaaafgafbaaaaaaaaaaa
agaabaaaabaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
afaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
iccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaadgaaaaag
hccabaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab"
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
Float 7 [_DensityRatioY]
Float 8 [_DensityRatioX]
SetTexture 0 [_ShadowMapTexture] 2D
"ps_3_0
; 106 ALU, 1 TEX, 2 FLOW
dcl_2d s0
def c9, 1.00000000, 0.00000000, 100000003318135350000000000000000.00000000, 0.33333334
def c10, 2.00000000, 0, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord2 v1
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r1.x, v3, r0
dp3 r1.z, v3, v3
mad r0.x, -r1, r1, r1.z
rsq r0.x, r0.x
rcp r0.w, r0.x
mul r1.y, r0.w, r0.w
mad r0.x, c5, c5, -r1.y
rsq r0.x, r0.x
rcp r0.x, r0.x
add r0.z, r1.x, -r0.x
add r0.x, -r0.w, c5
cmp r0.y, r1.x, c9.x, c9
cmp r0.x, r0, c9, c9.y
mul_pp r0.x, r0, r0.y
cmp r1.w, -r0.x, c9.z, r0.z
add r0.xyz, -v2, c0
dp3 r2.x, r0, r0
rsq r2.y, r2.x
rsq r1.z, r1.z
mul r0.xyz, r2.y, r0
rcp r2.x, r1.z
add r1.z, r2.x, -c6.x
cmp r1.z, r1, c9.y, c9.x
cmp r2.y, r1.x, c9, c9.x
mul_pp r2.y, r1.z, r2
min r1.w, r1, c9.z
mul r1.z, c6.x, c6.x
if_gt r2.y, c9.y
add r1.x, -r1.y, r1.z
mad r0.w, r2.x, r2.x, -r1.y
rsq r1.x, r1.x
rsq r0.w, r0.w
rcp r0.w, r0.w
rcp r1.x, r1.x
add r1.x, -r0.w, r1
min r1.x, r1.w, r1
add r1.w, r0, r1.x
mul r1.x, r1.w, c8
mul r2.x, r1.w, r1
mul r1.y, r1, c7.x
mad r2.x, r2, c9.w, r1.y
mul r1.x, r0.w, c8
mul r1.x, r0.w, r1
mad r1.x, r1, c9.w, r1.y
add r2.x, -r1.z, r2
add r1.x, r1, -r1.z
mul r1.y, r1.w, r2.x
rcp r1.z, r1.z
mad r0.w, r0, r1.x, -r1.y
mul r0.w, r0, r1.z
mul r1.w, r0, c4.x
else
add r2.y, r1.z, -r1
add r0.w, -r0, c6.x
rsq r2.z, r2.y
add r2.x, -r2, c6
add r2.y, r2.x, c9.x
rcp r2.x, r2.z
frc r2.z, r2.y
add r2.w, r1.x, -r2.x
add_sat r2.y, r2, -r2.z
mad r2.y, r2, r2.w, r2.x
mul r2.z, r2.y, c8.x
mul r2.w, r2.y, r2.z
add r2.z, r1.x, -r1.w
max r3.x, -r2.z, c9.y
mul r1.y, r1, c7.x
mad r1.w, r2, c9, r1.y
min r2.x, r2, r3
mul r2.w, r2.x, c8.x
mul r3.x, r2, r2.w
max r2.z, r2, c9.y
mad r3.x, r3, c9.w, r1.y
add r3.x, -r1.z, r3
mul r2.w, r2.z, c8.x
mul r2.w, r2.z, r2
mad r1.y, r2.w, c9.w, r1
add r1.w, -r1.z, r1
add r1.y, -r1.z, r1
mul r2.x, r2, r3
mad r1.y, r2.z, r1, -r2.x
mad r1.y, -r2, r1.w, r1
rcp r1.z, r1.z
cmp r1.x, r1, c9, c9.y
cmp r0.w, r0, c9.x, c9.y
mul_pp r0.w, r0, r1.x
mul r1.y, r1, r1.z
mul r1.x, r1.y, c4
abs_pp r0.w, r0
cmp r1.w, -r0, c9.y, r1.x
endif
dp4_pp r0.w, c1, c1
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, c1
dp3_pp r0.y, r0, r1
texldp r0.x, v1, s0
mul_pp r0.y, r0, c2.w
mul_pp r0.x, r0.y, r0
mul_pp r0.x, r0, c10
max_pp r0.x, r0, c9.y
mul_pp r0.x, r0, c2
max r0.x, r0, c9.y
max r0.x, r0, c9.y
mul_sat r0.x, r1.w, r0
mul_pp oC0.w, r0.x, c3
mov_pp oC0.xyz, c3
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 180 used size, 12 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 144 [_Visibility]
Float 148 [_OceanRadius]
Float 152 [_SphereRadius]
Float 172 [_DensityRatioY]
Float 176 [_DensityRatioX]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
SetTexture 0 [_ShadowMapTexture] 2D 0
// 86 instructions, 3 temp regs, 0 temp arrays:
// ALU 78 float, 0 int, 3 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecediomlehlimpkpihccnocimfafkjjahhobabaaaaaadiamaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbialaaaa
eaaaaaaamgacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegacbaaa
aaaaaaaabnaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaahecaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaadcaaaaak
icaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabnaaaaaidcaabaaa
abaaaaaajgifcaaaaaaaaaaaajaaaaaapgapbaaaaaaaaaaaabaaaaahdcaabaaa
abaaaaaafgafbaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaafmcaabaaa
aaaaaaaakgaobaaaaaaaaaaadcaaaaammcaabaaaabaaaaaafgijcaaaaaaaaaaa
ajaaaaaafgijcaaaaaaaaaaaajaaaaaafgafbaiaebaaaaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaaelaaaaaf
mcaabaaaabaaaaaakgaobaaaabaaaaaaaaaaaaaidcaabaaaacaaaaaaagaabaaa
aaaaaaaaogakbaiaebaaaaaaabaaaaaaddaaaaahecaabaaaabaaaaaaakaabaaa
acaaaaaaabeaaaaakomfjnhedhaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaakomfjnheaaaaaaaiecaabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaaakaabaaaabaaaaaadeaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaaaaddaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaa
alaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaklkkkkdo
bkaabaaaaaaaaaaadcaaaaambcaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaa
ajaaaaaackiacaaaaaaaaaaaajaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaa
akaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadbaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaadeaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaaaaadiaaaaahecaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaa
aaaaaaaaalaaaaaadcaaaaajecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaa
klkkkkdobkaabaaaaaaaaaaadcaaaaamecaabaaaacaaaaaackiacaiaebaaaaaa
aaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaackaabaaaacaaaaaadcaaaaak
ecaabaaaabaaaaaaakaabaaaacaaaaaackaabaaaacaaaaaackaabaiaebaaaaaa
abaaaaaaaaaaaaaibcaabaaaacaaaaaackiacaaaaaaaaaaaajaaaaaaabeaaaaa
aaaaiadpaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaa
acaaaaaadbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaaaaaaaaaaa
ajaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaa
ebcaaaafecaabaaaaaaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaaddaaaaahbcaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaa
akiacaaaaaaaaaaaalaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaklkkkkdobkaabaaaaaaaaaaadcaaaaamicaabaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaadkaabaaaabaaaaaa
dcaaaaakecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaajecaabaaaabaaaaaackiacaaaaaaaaaaaajaaaaaa
ckiacaaaaaaaaaaaajaaaaaaaoaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaabaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaajaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaalaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaklkkkkdobkaabaaa
aaaaaaaadcaaaaamccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaa
ckiacaaaaaaaaaaaajaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaaaaaaaaaalaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaabaaaaaa
abeaaaaaklkkkkdobkaabaaaaaaaaaaadcaaaaamccaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaabkaabaaaaaaaaaaa
dcaaaaakccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaia
ebaaaaaaabaaaaaaaoaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
ajaaaaaadhaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaajocaabaaaaaaaaaaaagbjbaiaebaaaaaaaeaaaaaa
agijcaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaajgahbaaaaaaaaaaa
jgahbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagaabaaaabaaaaaabbaaaaajbcaabaaa
abaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaa
abaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaajgahbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaaaoaaaaahmcaabaaaaaaaaaaaagbebaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaapaaaaahccaabaaaaaaaaaaafgafbaaaaaaaaaaa
agaabaaaabaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
afaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
iccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaadgaaaaag
hccabaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab"
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
Float 7 [_DensityRatioY]
Float 8 [_DensityRatioX]
SetTexture 0 [_ShadowMapTexture] 2D
"ps_3_0
; 106 ALU, 1 TEX, 2 FLOW
dcl_2d s0
def c9, 1.00000000, 0.00000000, 100000003318135350000000000000000.00000000, 0.33333334
def c10, 2.00000000, 0, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord2 v1
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r1.x, v3, r0
dp3 r1.z, v3, v3
mad r0.x, -r1, r1, r1.z
rsq r0.x, r0.x
rcp r0.w, r0.x
mul r1.y, r0.w, r0.w
mad r0.x, c5, c5, -r1.y
rsq r0.x, r0.x
rcp r0.x, r0.x
add r0.z, r1.x, -r0.x
add r0.x, -r0.w, c5
cmp r0.y, r1.x, c9.x, c9
cmp r0.x, r0, c9, c9.y
mul_pp r0.x, r0, r0.y
cmp r1.w, -r0.x, c9.z, r0.z
add r0.xyz, -v2, c0
dp3 r2.x, r0, r0
rsq r2.y, r2.x
rsq r1.z, r1.z
mul r0.xyz, r2.y, r0
rcp r2.x, r1.z
add r1.z, r2.x, -c6.x
cmp r1.z, r1, c9.y, c9.x
cmp r2.y, r1.x, c9, c9.x
mul_pp r2.y, r1.z, r2
min r1.w, r1, c9.z
mul r1.z, c6.x, c6.x
if_gt r2.y, c9.y
add r1.x, -r1.y, r1.z
mad r0.w, r2.x, r2.x, -r1.y
rsq r1.x, r1.x
rsq r0.w, r0.w
rcp r0.w, r0.w
rcp r1.x, r1.x
add r1.x, -r0.w, r1
min r1.x, r1.w, r1
add r1.w, r0, r1.x
mul r1.x, r1.w, c8
mul r2.x, r1.w, r1
mul r1.y, r1, c7.x
mad r2.x, r2, c9.w, r1.y
mul r1.x, r0.w, c8
mul r1.x, r0.w, r1
mad r1.x, r1, c9.w, r1.y
add r2.x, -r1.z, r2
add r1.x, r1, -r1.z
mul r1.y, r1.w, r2.x
rcp r1.z, r1.z
mad r0.w, r0, r1.x, -r1.y
mul r0.w, r0, r1.z
mul r1.w, r0, c4.x
else
add r2.y, r1.z, -r1
add r0.w, -r0, c6.x
rsq r2.z, r2.y
add r2.x, -r2, c6
add r2.y, r2.x, c9.x
rcp r2.x, r2.z
frc r2.z, r2.y
add r2.w, r1.x, -r2.x
add_sat r2.y, r2, -r2.z
mad r2.y, r2, r2.w, r2.x
mul r2.z, r2.y, c8.x
mul r2.w, r2.y, r2.z
add r2.z, r1.x, -r1.w
max r3.x, -r2.z, c9.y
mul r1.y, r1, c7.x
mad r1.w, r2, c9, r1.y
min r2.x, r2, r3
mul r2.w, r2.x, c8.x
mul r3.x, r2, r2.w
max r2.z, r2, c9.y
mad r3.x, r3, c9.w, r1.y
add r3.x, -r1.z, r3
mul r2.w, r2.z, c8.x
mul r2.w, r2.z, r2
mad r1.y, r2.w, c9.w, r1
add r1.w, -r1.z, r1
add r1.y, -r1.z, r1
mul r2.x, r2, r3
mad r1.y, r2.z, r1, -r2.x
mad r1.y, -r2, r1.w, r1
rcp r1.z, r1.z
cmp r1.x, r1, c9, c9.y
cmp r0.w, r0, c9.x, c9.y
mul_pp r0.w, r0, r1.x
mul r1.y, r1, r1.z
mul r1.x, r1.y, c4
abs_pp r0.w, r0
cmp r1.w, -r0, c9.y, r1.x
endif
dp4_pp r0.w, c1, c1
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, c1
dp3_pp r0.y, r0, r1
texldp r0.x, v1, s0
mul_pp r0.y, r0, c2.w
mul_pp r0.x, r0.y, r0
mul_pp r0.x, r0, c10
max_pp r0.x, r0, c9.y
mul_pp r0.x, r0, c2
max r0.x, r0, c9.y
max r0.x, r0, c9.y
mul_sat r0.x, r1.w, r0
mul_pp oC0.w, r0.x, c3
mov_pp oC0.xyz, c3
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 180 used size, 12 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 144 [_Visibility]
Float 148 [_OceanRadius]
Float 152 [_SphereRadius]
Float 172 [_DensityRatioY]
Float 176 [_DensityRatioX]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
SetTexture 0 [_ShadowMapTexture] 2D 0
// 86 instructions, 3 temp regs, 0 temp arrays:
// ALU 78 float, 0 int, 3 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecediomlehlimpkpihccnocimfafkjjahhobabaaaaaadiamaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbialaaaa
eaaaaaaamgacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegacbaaa
aaaaaaaabnaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaahecaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaadcaaaaak
icaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabnaaaaaidcaabaaa
abaaaaaajgifcaaaaaaaaaaaajaaaaaapgapbaaaaaaaaaaaabaaaaahdcaabaaa
abaaaaaafgafbaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaafmcaabaaa
aaaaaaaakgaobaaaaaaaaaaadcaaaaammcaabaaaabaaaaaafgijcaaaaaaaaaaa
ajaaaaaafgijcaaaaaaaaaaaajaaaaaafgafbaiaebaaaaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaaelaaaaaf
mcaabaaaabaaaaaakgaobaaaabaaaaaaaaaaaaaidcaabaaaacaaaaaaagaabaaa
aaaaaaaaogakbaiaebaaaaaaabaaaaaaddaaaaahecaabaaaabaaaaaaakaabaaa
acaaaaaaabeaaaaakomfjnhedhaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaakomfjnheaaaaaaaiecaabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaaakaabaaaabaaaaaadeaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaaaaddaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaa
alaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaklkkkkdo
bkaabaaaaaaaaaaadcaaaaambcaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaa
ajaaaaaackiacaaaaaaaaaaaajaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaa
akaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadbaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaadeaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaaaaadiaaaaahecaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaa
aaaaaaaaalaaaaaadcaaaaajecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaa
klkkkkdobkaabaaaaaaaaaaadcaaaaamecaabaaaacaaaaaackiacaiaebaaaaaa
aaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaackaabaaaacaaaaaadcaaaaak
ecaabaaaabaaaaaaakaabaaaacaaaaaackaabaaaacaaaaaackaabaiaebaaaaaa
abaaaaaaaaaaaaaibcaabaaaacaaaaaackiacaaaaaaaaaaaajaaaaaaabeaaaaa
aaaaiadpaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaa
acaaaaaadbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaaaaaaaaaaa
ajaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaa
ebcaaaafecaabaaaaaaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaaddaaaaahbcaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaa
akiacaaaaaaaaaaaalaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaklkkkkdobkaabaaaaaaaaaaadcaaaaamicaabaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaadkaabaaaabaaaaaa
dcaaaaakecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaajecaabaaaabaaaaaackiacaaaaaaaaaaaajaaaaaa
ckiacaaaaaaaaaaaajaaaaaaaoaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaabaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaa
aaaaaaaaajaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaalaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaklkkkkdobkaabaaa
aaaaaaaadcaaaaamccaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaa
ckiacaaaaaaaaaaaajaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaaaaaaaaaalaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaabaaaaaa
abeaaaaaklkkkkdobkaabaaaaaaaaaaadcaaaaamccaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaabkaabaaaaaaaaaaa
dcaaaaakccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaia
ebaaaaaaabaaaaaaaoaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
ajaaaaaadhaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaajocaabaaaaaaaaaaaagbjbaiaebaaaaaaaeaaaaaa
agijcaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaajgahbaaaaaaaaaaa
jgahbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagaabaaaabaaaaaabbaaaaajbcaabaaa
abaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaa
abaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaajgahbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaaaoaaaaahmcaabaaaaaaaaaaaagbebaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaapaaaaahccaabaaaaaaaaaaafgafbaaaaaaaaaaa
agaabaaaabaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
afaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
iccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaadgaaaaag
hccabaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab"
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
Float 8 [_DensityRatioY]
Float 9 [_DensityRatioX]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 107 ALU, 1 TEX, 2 FLOW
dcl_2d s0
def c10, 1.00000000, 0.00000000, 0.33333334, 2.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r1.y, v3, r0
dp3 r1.z, v3, v3
mad r0.x, -r1.y, r1.y, r1.z
rsq r0.x, r0.x
rcp r1.x, r0.x
mul r0.w, r1.x, r1.x
mad r0.z, c6.x, c6.x, -r0.w
add r0.x, -r1, c6
rsq r0.z, r0.z
cmp r0.x, r0, c10, c10.y
cmp r0.y, r1, c10.x, c10
mul_pp r0.y, r0.x, r0
texldp r0.x, v0, s0
mad r1.w, r0.x, c1.z, c1
rcp r0.z, r0.z
add r0.x, r1.y, -r0.z
rcp r1.w, r1.w
cmp r2.x, -r0.y, r1.w, r0
add r0.xyz, -v2, c0
min r1.w, r2.x, r1
dp3 r2.x, r0, r0
rsq r2.y, r2.x
rsq r1.z, r1.z
mul r0.xyz, r2.y, r0
rcp r2.x, r1.z
add r1.z, r2.x, -c7.x
cmp r1.z, r1, c10.y, c10.x
cmp r2.y, r1, c10, c10.x
mul_pp r2.y, r1.z, r2
mul r1.z, c7.x, c7.x
if_gt r2.y, c10.y
add r1.y, -r0.w, r1.z
mad r1.x, r2, r2, -r0.w
rsq r1.y, r1.y
rsq r1.x, r1.x
rcp r1.x, r1.x
rcp r1.y, r1.y
add r1.y, -r1.x, r1
min r1.y, r1.w, r1
add r1.w, r1.x, r1.y
mul r1.y, r1.w, c9.x
mul r2.x, r1.w, r1.y
mul r1.y, r0.w, c8.x
mad r2.x, r2, c10.z, r1.y
mul r0.w, r1.x, c9.x
mul r0.w, r1.x, r0
mad r0.w, r0, c10.z, r1.y
add r2.x, -r1.z, r2
add r0.w, r0, -r1.z
mul r1.y, r1.w, r2.x
rcp r1.z, r1.z
mad r0.w, r1.x, r0, -r1.y
mul r0.w, r0, r1.z
mul r1.w, r0, c5.x
else
add r2.y, r1.z, -r0.w
rsq r2.z, r2.y
add r2.x, -r2, c7
add r2.y, r2.x, c10.x
rcp r2.x, r2.z
frc r2.z, r2.y
add r2.w, r1.y, -r2.x
add_sat r2.y, r2, -r2.z
mad r2.y, r2, r2.w, r2.x
mul r2.z, r2.y, c9.x
mul r2.w, r2.y, r2.z
add r2.z, r1.y, -r1.w
max r3.x, -r2.z, c10.y
mul r0.w, r0, c8.x
mad r1.w, r2, c10.z, r0
min r2.x, r2, r3
mul r2.w, r2.x, c9.x
mul r3.x, r2, r2.w
max r2.z, r2, c10.y
mad r3.x, r3, c10.z, r0.w
add r3.x, -r1.z, r3
mul r2.w, r2.z, c9.x
mul r2.w, r2.z, r2
mad r0.w, r2, c10.z, r0
add r1.w, -r1.z, r1
add r0.w, -r1.z, r0
mul r2.x, r2, r3
mad r0.w, r2.z, r0, -r2.x
mad r0.w, -r2.y, r1, r0
rcp r1.z, r1.z
mul r1.z, r0.w, r1
add r0.w, -r1.x, c7.x
cmp r1.x, r1.y, c10, c10.y
cmp r0.w, r0, c10.x, c10.y
mul_pp r0.w, r0, r1.x
mul r1.x, r1.z, c5
abs_pp r0.w, r0
cmp r1.w, -r0, c10.y, r1.x
endif
dp4_pp r0.w, c2, c2
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, c2
dp3_pp r0.x, r0, r1
mul_pp r0.x, r0, c3.w
mul_pp r0.x, r0, c10.w
max_pp r0.x, r0, c10.y
mul_pp r0.x, r0, c3
max r0.x, r0, c10.y
max r0.x, r0, c10.y
mul_sat r0.x, r1.w, r0
mul_pp oC0.w, r0.x, c4
mov_pp oC0.xyz, c4
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 116 used size, 11 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Float 80 [_Visibility]
Float 84 [_OceanRadius]
Float 88 [_SphereRadius]
Float 108 [_DensityRatioY]
Float 112 [_DensityRatioX]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
SetTexture 0 [_CameraDepthTexture] 2D 0
// 88 instructions, 3 temp regs, 0 temp arrays:
// ALU 80 float, 0 int, 3 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedajhonpjffcgankccgoabepgjpokfpiacabaaaaaagmamaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcgealaaaaeaaaaaaanjacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
lcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajocaabaaaaaaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
abaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagaabaaa
abaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaaeaaaaaajgahbaaaaaaaaaaa
bnaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaadcaaaaakbcaabaaa
abaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaa
elaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaaigcaabaaaabaaaaaa
fgigcaaaaaaaaaaaafaaaaaaagaabaaaabaaaaaaabaaaaahgcaabaaaabaaaaaa
kgakbaaaaaaaaaaafgagbaaaabaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaam
dcaabaaaacaaaaaajgifcaaaaaaaaaaaafaaaaaajgifcaaaaaaaaaaaafaaaaaa
kgakbaiaebaaaaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaagaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
aaaaaaaifcaabaaaacaaaaaafgafbaaaaaaaaaaaagabbaiaebaaaaaaacaaaaaa
dhaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaa
aaaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaa
aaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
deaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaaddaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaacaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiicaabaaaabaaaaaa
dkaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaajicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaamicaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaa
dkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaa
abaaaaaaaaaaaaaiicaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
deaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaibcaabaaa
acaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaajbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaam
bcaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaa
afaaaaaaakaabaaaacaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaabkaabaiaebaaaaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaa
ckiacaaaaaaaaaaaafaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadbaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackiacaaaaaaaaaaaafaaaaaaabaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaaaaaaaaaebcaaaaficaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaa
bkaabaaaacaaaaaaaaaaaaaiicaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
bkaabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
abaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaaaaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaabaaaaaadkaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaa
dcaaaaamicaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaackiacaaa
aaaaaaaaafaaaaaadkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaajccaabaaa
abaaaaaackiacaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaaaoaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaaabaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaaabaaaaaackaabaaa
abaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaajecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaamecaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaackaabaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaabaaaaaa
diaaaaahecaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
ecaabaaaabaaaaaackaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaa
dcaaaaamecaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaackiacaaa
aaaaaaaaafaaaaaackaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaaoaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadhaaaaajbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajocaabaaa
aaaaaaaaagbjbaiaebaaaaaaadaaaaaaagijcaaaabaaaaaaaeaaaaaabaaaaaah
bcaabaaaabaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agaabaaaabaaaaaabbaaaaajbcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaai
ccaabaaaaaaaaaaapgipcaaaaaaaaaaaabaaaaaafgafbaaaaaaaaaaadeaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaadoaaaaab"
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
Float 8 [_DensityRatioY]
Float 9 [_DensityRatioX]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 107 ALU, 1 TEX, 2 FLOW
dcl_2d s0
def c10, 1.00000000, 0.00000000, 0.33333334, 2.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r1.y, v3, r0
dp3 r1.z, v3, v3
mad r0.x, -r1.y, r1.y, r1.z
rsq r0.x, r0.x
rcp r1.x, r0.x
mul r0.w, r1.x, r1.x
mad r0.z, c6.x, c6.x, -r0.w
add r0.x, -r1, c6
rsq r0.z, r0.z
cmp r0.x, r0, c10, c10.y
cmp r0.y, r1, c10.x, c10
mul_pp r0.y, r0.x, r0
texldp r0.x, v0, s0
mad r1.w, r0.x, c1.z, c1
rcp r0.z, r0.z
add r0.x, r1.y, -r0.z
rcp r1.w, r1.w
cmp r2.x, -r0.y, r1.w, r0
add r0.xyz, -v2, c0
min r1.w, r2.x, r1
dp3 r2.x, r0, r0
rsq r2.y, r2.x
rsq r1.z, r1.z
mul r0.xyz, r2.y, r0
rcp r2.x, r1.z
add r1.z, r2.x, -c7.x
cmp r1.z, r1, c10.y, c10.x
cmp r2.y, r1, c10, c10.x
mul_pp r2.y, r1.z, r2
mul r1.z, c7.x, c7.x
if_gt r2.y, c10.y
add r1.y, -r0.w, r1.z
mad r1.x, r2, r2, -r0.w
rsq r1.y, r1.y
rsq r1.x, r1.x
rcp r1.x, r1.x
rcp r1.y, r1.y
add r1.y, -r1.x, r1
min r1.y, r1.w, r1
add r1.w, r1.x, r1.y
mul r1.y, r1.w, c9.x
mul r2.x, r1.w, r1.y
mul r1.y, r0.w, c8.x
mad r2.x, r2, c10.z, r1.y
mul r0.w, r1.x, c9.x
mul r0.w, r1.x, r0
mad r0.w, r0, c10.z, r1.y
add r2.x, -r1.z, r2
add r0.w, r0, -r1.z
mul r1.y, r1.w, r2.x
rcp r1.z, r1.z
mad r0.w, r1.x, r0, -r1.y
mul r0.w, r0, r1.z
mul r1.w, r0, c5.x
else
add r2.y, r1.z, -r0.w
rsq r2.z, r2.y
add r2.x, -r2, c7
add r2.y, r2.x, c10.x
rcp r2.x, r2.z
frc r2.z, r2.y
add r2.w, r1.y, -r2.x
add_sat r2.y, r2, -r2.z
mad r2.y, r2, r2.w, r2.x
mul r2.z, r2.y, c9.x
mul r2.w, r2.y, r2.z
add r2.z, r1.y, -r1.w
max r3.x, -r2.z, c10.y
mul r0.w, r0, c8.x
mad r1.w, r2, c10.z, r0
min r2.x, r2, r3
mul r2.w, r2.x, c9.x
mul r3.x, r2, r2.w
max r2.z, r2, c10.y
mad r3.x, r3, c10.z, r0.w
add r3.x, -r1.z, r3
mul r2.w, r2.z, c9.x
mul r2.w, r2.z, r2
mad r0.w, r2, c10.z, r0
add r1.w, -r1.z, r1
add r0.w, -r1.z, r0
mul r2.x, r2, r3
mad r0.w, r2.z, r0, -r2.x
mad r0.w, -r2.y, r1, r0
rcp r1.z, r1.z
mul r1.z, r0.w, r1
add r0.w, -r1.x, c7.x
cmp r1.x, r1.y, c10, c10.y
cmp r0.w, r0, c10.x, c10.y
mul_pp r0.w, r0, r1.x
mul r1.x, r1.z, c5
abs_pp r0.w, r0
cmp r1.w, -r0, c10.y, r1.x
endif
dp4_pp r0.w, c2, c2
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, c2
dp3_pp r0.x, r0, r1
mul_pp r0.x, r0, c3.w
mul_pp r0.x, r0, c10.w
max_pp r0.x, r0, c10.y
mul_pp r0.x, r0, c3
max r0.x, r0, c10.y
max r0.x, r0, c10.y
mul_sat r0.x, r1.w, r0
mul_pp oC0.w, r0.x, c4
mov_pp oC0.xyz, c4
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 116 used size, 11 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Float 80 [_Visibility]
Float 84 [_OceanRadius]
Float 88 [_SphereRadius]
Float 108 [_DensityRatioY]
Float 112 [_DensityRatioX]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
SetTexture 0 [_CameraDepthTexture] 2D 0
// 88 instructions, 3 temp regs, 0 temp arrays:
// ALU 80 float, 0 int, 3 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedajhonpjffcgankccgoabepgjpokfpiacabaaaaaagmamaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcgealaaaaeaaaaaaanjacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
lcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajocaabaaaaaaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
abaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagaabaaa
abaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaaeaaaaaajgahbaaaaaaaaaaa
bnaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaadcaaaaakbcaabaaa
abaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaa
elaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaaigcaabaaaabaaaaaa
fgigcaaaaaaaaaaaafaaaaaaagaabaaaabaaaaaaabaaaaahgcaabaaaabaaaaaa
kgakbaaaaaaaaaaafgagbaaaabaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaam
dcaabaaaacaaaaaajgifcaaaaaaaaaaaafaaaaaajgifcaaaaaaaaaaaafaaaaaa
kgakbaiaebaaaaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaagaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
aaaaaaaifcaabaaaacaaaaaafgafbaaaaaaaaaaaagabbaiaebaaaaaaacaaaaaa
dhaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaa
aaaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaa
aaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
deaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaaddaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaacaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiicaabaaaabaaaaaa
dkaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaajicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaamicaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaa
dkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaa
abaaaaaaaaaaaaaiicaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
deaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaibcaabaaa
acaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaajbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaam
bcaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaa
afaaaaaaakaabaaaacaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaabkaabaiaebaaaaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaa
ckiacaaaaaaaaaaaafaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadbaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackiacaaaaaaaaaaaafaaaaaaabaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaaaaaaaaaebcaaaaficaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaa
bkaabaaaacaaaaaaaaaaaaaiicaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
bkaabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
abaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaaaaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaabaaaaaadkaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaa
dcaaaaamicaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaackiacaaa
aaaaaaaaafaaaaaadkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaajccaabaaa
abaaaaaackiacaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaaaoaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaaabaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaaabaaaaaackaabaaa
abaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaajecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaamecaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaackaabaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaabaaaaaa
diaaaaahecaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
ecaabaaaabaaaaaackaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaa
dcaaaaamecaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaackiacaaa
aaaaaaaaafaaaaaackaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaaoaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadhaaaaajbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajocaabaaa
aaaaaaaaagbjbaiaebaaaaaaadaaaaaaagijcaaaabaaaaaaaeaaaaaabaaaaaah
bcaabaaaabaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agaabaaaabaaaaaabbaaaaajbcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaai
ccaabaaaaaaaaaaapgipcaaaaaaaaaaaabaaaaaafgafbaaaaaaaaaaadeaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaadoaaaaab"
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
Float 8 [_DensityRatioY]
Float 9 [_DensityRatioX]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 107 ALU, 1 TEX, 2 FLOW
dcl_2d s0
def c10, 1.00000000, 0.00000000, 0.33333334, 2.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r1.y, v3, r0
dp3 r1.z, v3, v3
mad r0.x, -r1.y, r1.y, r1.z
rsq r0.x, r0.x
rcp r1.x, r0.x
mul r0.w, r1.x, r1.x
mad r0.z, c6.x, c6.x, -r0.w
add r0.x, -r1, c6
rsq r0.z, r0.z
cmp r0.x, r0, c10, c10.y
cmp r0.y, r1, c10.x, c10
mul_pp r0.y, r0.x, r0
texldp r0.x, v0, s0
mad r1.w, r0.x, c1.z, c1
rcp r0.z, r0.z
add r0.x, r1.y, -r0.z
rcp r1.w, r1.w
cmp r2.x, -r0.y, r1.w, r0
add r0.xyz, -v2, c0
min r1.w, r2.x, r1
dp3 r2.x, r0, r0
rsq r2.y, r2.x
rsq r1.z, r1.z
mul r0.xyz, r2.y, r0
rcp r2.x, r1.z
add r1.z, r2.x, -c7.x
cmp r1.z, r1, c10.y, c10.x
cmp r2.y, r1, c10, c10.x
mul_pp r2.y, r1.z, r2
mul r1.z, c7.x, c7.x
if_gt r2.y, c10.y
add r1.y, -r0.w, r1.z
mad r1.x, r2, r2, -r0.w
rsq r1.y, r1.y
rsq r1.x, r1.x
rcp r1.x, r1.x
rcp r1.y, r1.y
add r1.y, -r1.x, r1
min r1.y, r1.w, r1
add r1.w, r1.x, r1.y
mul r1.y, r1.w, c9.x
mul r2.x, r1.w, r1.y
mul r1.y, r0.w, c8.x
mad r2.x, r2, c10.z, r1.y
mul r0.w, r1.x, c9.x
mul r0.w, r1.x, r0
mad r0.w, r0, c10.z, r1.y
add r2.x, -r1.z, r2
add r0.w, r0, -r1.z
mul r1.y, r1.w, r2.x
rcp r1.z, r1.z
mad r0.w, r1.x, r0, -r1.y
mul r0.w, r0, r1.z
mul r1.w, r0, c5.x
else
add r2.y, r1.z, -r0.w
rsq r2.z, r2.y
add r2.x, -r2, c7
add r2.y, r2.x, c10.x
rcp r2.x, r2.z
frc r2.z, r2.y
add r2.w, r1.y, -r2.x
add_sat r2.y, r2, -r2.z
mad r2.y, r2, r2.w, r2.x
mul r2.z, r2.y, c9.x
mul r2.w, r2.y, r2.z
add r2.z, r1.y, -r1.w
max r3.x, -r2.z, c10.y
mul r0.w, r0, c8.x
mad r1.w, r2, c10.z, r0
min r2.x, r2, r3
mul r2.w, r2.x, c9.x
mul r3.x, r2, r2.w
max r2.z, r2, c10.y
mad r3.x, r3, c10.z, r0.w
add r3.x, -r1.z, r3
mul r2.w, r2.z, c9.x
mul r2.w, r2.z, r2
mad r0.w, r2, c10.z, r0
add r1.w, -r1.z, r1
add r0.w, -r1.z, r0
mul r2.x, r2, r3
mad r0.w, r2.z, r0, -r2.x
mad r0.w, -r2.y, r1, r0
rcp r1.z, r1.z
mul r1.z, r0.w, r1
add r0.w, -r1.x, c7.x
cmp r1.x, r1.y, c10, c10.y
cmp r0.w, r0, c10.x, c10.y
mul_pp r0.w, r0, r1.x
mul r1.x, r1.z, c5
abs_pp r0.w, r0
cmp r1.w, -r0, c10.y, r1.x
endif
dp4_pp r0.w, c2, c2
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, c2
dp3_pp r0.x, r0, r1
mul_pp r0.x, r0, c3.w
mul_pp r0.x, r0, c10.w
max_pp r0.x, r0, c10.y
mul_pp r0.x, r0, c3
max r0.x, r0, c10.y
max r0.x, r0, c10.y
mul_sat r0.x, r1.w, r0
mul_pp oC0.w, r0.x, c4
mov_pp oC0.xyz, c4
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 116 used size, 11 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Float 80 [_Visibility]
Float 84 [_OceanRadius]
Float 88 [_SphereRadius]
Float 108 [_DensityRatioY]
Float 112 [_DensityRatioX]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
SetTexture 0 [_CameraDepthTexture] 2D 0
// 88 instructions, 3 temp regs, 0 temp arrays:
// ALU 80 float, 0 int, 3 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedajhonpjffcgankccgoabepgjpokfpiacabaaaaaagmamaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcgealaaaaeaaaaaaanjacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
lcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajocaabaaaaaaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
abaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagaabaaa
abaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaaeaaaaaajgahbaaaaaaaaaaa
bnaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaadcaaaaakbcaabaaa
abaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaa
elaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaaigcaabaaaabaaaaaa
fgigcaaaaaaaaaaaafaaaaaaagaabaaaabaaaaaaabaaaaahgcaabaaaabaaaaaa
kgakbaaaaaaaaaaafgagbaaaabaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaam
dcaabaaaacaaaaaajgifcaaaaaaaaaaaafaaaaaajgifcaaaaaaaaaaaafaaaaaa
kgakbaiaebaaaaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaagaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
aaaaaaaifcaabaaaacaaaaaafgafbaaaaaaaaaaaagabbaiaebaaaaaaacaaaaaa
dhaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaa
aaaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaa
aaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
deaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaaddaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaacaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiicaabaaaabaaaaaa
dkaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaajicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaamicaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaa
dkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaa
abaaaaaaaaaaaaaiicaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
deaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaibcaabaaa
acaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaajbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaam
bcaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaa
afaaaaaaakaabaaaacaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaabkaabaiaebaaaaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaa
ckiacaaaaaaaaaaaafaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadbaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackiacaaaaaaaaaaaafaaaaaaabaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaaaaaaaaaebcaaaaficaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaa
bkaabaaaacaaaaaaaaaaaaaiicaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
bkaabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
abaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaaaaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaabaaaaaadkaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaa
dcaaaaamicaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaackiacaaa
aaaaaaaaafaaaaaadkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaajccaabaaa
abaaaaaackiacaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaaaoaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaaabaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaaabaaaaaackaabaaa
abaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaajecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaamecaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaafaaaaaackiacaaaaaaaaaaaafaaaaaackaabaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaabaaaaaa
diaaaaahecaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
ecaabaaaabaaaaaackaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaa
dcaaaaamecaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaafaaaaaackiacaaa
aaaaaaaaafaaaaaackaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaaoaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadhaaaaajbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajocaabaaa
aaaaaaaaagbjbaiaebaaaaaaadaaaaaaagijcaaaabaaaaaaaeaaaaaabaaaaaah
bcaabaaaabaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agaabaaaabaaaaaabbaaaaajbcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaai
ccaabaaaaaaaaaaapgipcaaaaaaaaaaaabaaaaaafgafbaaaaaaaaaaadeaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaadoaaaaab"
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
Float 8 [_DensityRatioY]
Float 9 [_DensityRatioX]
SetTexture 0 [_CameraDepthTexture] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_3_0
; 108 ALU, 2 TEX, 2 FLOW
dcl_2d s0
dcl_2d s1
def c10, 1.00000000, 0.00000000, 0.33333334, 2.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord4 v3.xyz
dcl_texcoord5 v4.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r1.z, v4, r0
dp3 r1.w, v4, v4
mad r0.x, -r1.z, r1.z, r1.w
rsq r0.x, r0.x
rcp r1.y, r0.x
mul r1.x, r1.y, r1.y
mad r0.z, c6.x, c6.x, -r1.x
add r0.x, -r1.y, c6
rsq r0.z, r0.z
cmp r0.x, r0, c10, c10.y
cmp r0.y, r1.z, c10.x, c10
mul_pp r0.y, r0.x, r0
texldp r0.x, v0, s0
mad r0.w, r0.x, c1.z, c1
rcp r0.z, r0.z
add r0.x, r1.z, -r0.z
rcp r0.w, r0.w
cmp r2.x, -r0.y, r0.w, r0
add r0.xyz, -v3, c0
min r0.w, r2.x, r0
dp3 r2.x, r0, r0
rsq r2.y, r2.x
rsq r1.w, r1.w
mul r0.xyz, r2.y, r0
rcp r2.x, r1.w
add r1.w, r2.x, -c7.x
cmp r1.w, r1, c10.y, c10.x
cmp r2.y, r1.z, c10, c10.x
mul_pp r2.y, r1.w, r2
mul r1.w, c7.x, c7.x
if_gt r2.y, c10.y
mad r1.y, r2.x, r2.x, -r1.x
add r1.z, -r1.x, r1.w
rsq r1.z, r1.z
rsq r1.y, r1.y
rcp r1.y, r1.y
rcp r1.z, r1.z
add r1.z, -r1.y, r1
min r0.w, r0, r1.z
add r1.z, r1.y, r0.w
mul r0.w, r1.z, c9.x
mul r2.x, r1.z, r0.w
mul r1.x, r1, c8
mad r2.x, r2, c10.z, r1
mul r0.w, r1.y, c9.x
mul r0.w, r1.y, r0
mad r0.w, r0, c10.z, r1.x
add r2.x, -r1.w, r2
mul r1.x, r1.z, r2
add r0.w, r0, -r1
rcp r1.z, r1.w
mad r0.w, r1.y, r0, -r1.x
mul r0.w, r0, r1.z
mul r0.w, r0, c5.x
else
add r2.y, r1.w, -r1.x
rsq r2.z, r2.y
add r2.x, -r2, c7
add r2.y, r2.x, c10.x
rcp r2.x, r2.z
frc r2.z, r2.y
add r2.w, r1.z, -r2.x
add_sat r2.y, r2, -r2.z
mad r2.y, r2, r2.w, r2.x
mul r2.z, r2.y, c9.x
mul r2.w, r2.y, r2.z
add r2.z, r1, -r0.w
max r3.x, -r2.z, c10.y
mul r0.w, r1.x, c8.x
mad r1.x, r2.w, c10.z, r0.w
min r2.x, r2, r3
mul r2.w, r2.x, c9.x
mul r3.x, r2, r2.w
max r2.z, r2, c10.y
mad r3.x, r3, c10.z, r0.w
add r3.x, -r1.w, r3
mul r2.w, r2.z, c9.x
mul r2.w, r2.z, r2
mad r0.w, r2, c10.z, r0
add r1.x, -r1.w, r1
add r0.w, -r1, r0
mul r2.x, r2, r3
mad r0.w, r2.z, r0, -r2.x
mad r0.w, -r2.y, r1.x, r0
rcp r1.w, r1.w
mul r1.w, r0, r1
add r0.w, -r1.y, c7.x
cmp r1.x, r1.z, c10, c10.y
cmp r0.w, r0, c10.x, c10.y
mul_pp r0.w, r0, r1.x
mul r1.x, r1.w, c5
abs_pp r0.w, r0
cmp r0.w, -r0, c10.y, r1.x
endif
dp4_pp r1.x, c2, c2
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, c2
dp3_pp r0.y, r0, r1
texldp r0.x, v2, s1
mul_pp r0.y, r0, c3.w
mul_pp r0.x, r0.y, r0
mul_pp r0.x, r0, c10.w
max_pp r0.x, r0, c10.y
mul_pp r0.x, r0, c3
max r0.x, r0, c10.y
max r0.x, r0, c10.y
mul_sat r0.x, r0.w, r0
mul_pp oC0.w, r0.x, c4
mov_pp oC0.xyz, c4
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 180 used size, 12 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 144 [_Visibility]
Float 148 [_OceanRadius]
Float 152 [_SphereRadius]
Float 172 [_DensityRatioY]
Float 176 [_DensityRatioX]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
// 91 instructions, 3 temp regs, 0 temp arrays:
// ALU 82 float, 0 int, 3 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfjajjbbnoemckcjnfnkjbooifmbbhpbaabaaaaaaaianaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoialaaaa
eaaaaaaapkacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajocaabaaaaaaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
abaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagaabaaa
abaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaafaaaaaajgahbaaaaaaaaaaa
bnaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaadcaaaaakbcaabaaa
abaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaa
elaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaaigcaabaaaabaaaaaa
fgigcaaaaaaaaaaaajaaaaaaagaabaaaabaaaaaaabaaaaahgcaabaaaabaaaaaa
kgakbaaaaaaaaaaafgagbaaaabaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaam
dcaabaaaacaaaaaajgifcaaaaaaaaaaaajaaaaaajgifcaaaaaaaaaaaajaaaaaa
kgakbaiaebaaaaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaakaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
aaaaaaaifcaabaaaacaaaaaafgafbaaaaaaaaaaaagabbaiaebaaaaaaacaaaaaa
dhaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaa
aaaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaa
aaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
deaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaaddaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaacaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiicaabaaaabaaaaaa
dkaabaaaabaaaaaaakiacaaaaaaaaaaaalaaaaaadcaaaaajicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaamicaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaa
dkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaa
abaaaaaaaaaaaaaiicaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
deaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaibcaabaaa
acaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaalaaaaaadcaaaaajbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaam
bcaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaa
ajaaaaaaakaabaaaacaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaabkaabaiaebaaaaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaa
ckiacaaaaaaaaaaaajaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadbaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackiacaaaaaaaaaaaajaaaaaaabaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaaaaaaaaaebcaaaaficaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaa
bkaabaaaacaaaaaaaaaaaaaiicaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
bkaabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
abaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaaaaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaabaaaaaadkaabaaaabaaaaaaakiacaaaaaaaaaaaalaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaa
dcaaaaamicaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaa
aaaaaaaaajaaaaaadkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaajccaabaaa
abaaaaaackiacaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaaaoaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaabaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaaabaaaaaackaabaaa
abaaaaaaakiacaaaaaaaaaaaalaaaaaadcaaaaajecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaamecaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaackaabaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaabaaaaaa
diaaaaahecaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
ecaabaaaabaaaaaackaabaaaabaaaaaaakiacaaaaaaaaaaaalaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaa
dcaaaaamecaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaa
aaaaaaaaajaaaaaackaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaaoaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaadhaaaaajbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajocaabaaa
aaaaaaaaagbjbaiaebaaaaaaaeaaaaaaagijcaaaabaaaaaaaeaaaaaabaaaaaah
bcaabaaaabaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agaabaaaabaaaaaabbaaaaajbcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaaaoaaaaah
mcaabaaaaaaaaaaaagbebaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaah
ccaabaaaaaaaaaaafgafbaaaaaaaaaaaagaabaaaabaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadeaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaahaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaa
ahaaaaaadoaaaaab"
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
Float 8 [_DensityRatioY]
Float 9 [_DensityRatioX]
SetTexture 0 [_CameraDepthTexture] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_3_0
; 108 ALU, 2 TEX, 2 FLOW
dcl_2d s0
dcl_2d s1
def c10, 1.00000000, 0.00000000, 0.33333334, 2.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord4 v3.xyz
dcl_texcoord5 v4.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r1.z, v4, r0
dp3 r1.w, v4, v4
mad r0.x, -r1.z, r1.z, r1.w
rsq r0.x, r0.x
rcp r1.y, r0.x
mul r1.x, r1.y, r1.y
mad r0.z, c6.x, c6.x, -r1.x
add r0.x, -r1.y, c6
rsq r0.z, r0.z
cmp r0.x, r0, c10, c10.y
cmp r0.y, r1.z, c10.x, c10
mul_pp r0.y, r0.x, r0
texldp r0.x, v0, s0
mad r0.w, r0.x, c1.z, c1
rcp r0.z, r0.z
add r0.x, r1.z, -r0.z
rcp r0.w, r0.w
cmp r2.x, -r0.y, r0.w, r0
add r0.xyz, -v3, c0
min r0.w, r2.x, r0
dp3 r2.x, r0, r0
rsq r2.y, r2.x
rsq r1.w, r1.w
mul r0.xyz, r2.y, r0
rcp r2.x, r1.w
add r1.w, r2.x, -c7.x
cmp r1.w, r1, c10.y, c10.x
cmp r2.y, r1.z, c10, c10.x
mul_pp r2.y, r1.w, r2
mul r1.w, c7.x, c7.x
if_gt r2.y, c10.y
mad r1.y, r2.x, r2.x, -r1.x
add r1.z, -r1.x, r1.w
rsq r1.z, r1.z
rsq r1.y, r1.y
rcp r1.y, r1.y
rcp r1.z, r1.z
add r1.z, -r1.y, r1
min r0.w, r0, r1.z
add r1.z, r1.y, r0.w
mul r0.w, r1.z, c9.x
mul r2.x, r1.z, r0.w
mul r1.x, r1, c8
mad r2.x, r2, c10.z, r1
mul r0.w, r1.y, c9.x
mul r0.w, r1.y, r0
mad r0.w, r0, c10.z, r1.x
add r2.x, -r1.w, r2
mul r1.x, r1.z, r2
add r0.w, r0, -r1
rcp r1.z, r1.w
mad r0.w, r1.y, r0, -r1.x
mul r0.w, r0, r1.z
mul r0.w, r0, c5.x
else
add r2.y, r1.w, -r1.x
rsq r2.z, r2.y
add r2.x, -r2, c7
add r2.y, r2.x, c10.x
rcp r2.x, r2.z
frc r2.z, r2.y
add r2.w, r1.z, -r2.x
add_sat r2.y, r2, -r2.z
mad r2.y, r2, r2.w, r2.x
mul r2.z, r2.y, c9.x
mul r2.w, r2.y, r2.z
add r2.z, r1, -r0.w
max r3.x, -r2.z, c10.y
mul r0.w, r1.x, c8.x
mad r1.x, r2.w, c10.z, r0.w
min r2.x, r2, r3
mul r2.w, r2.x, c9.x
mul r3.x, r2, r2.w
max r2.z, r2, c10.y
mad r3.x, r3, c10.z, r0.w
add r3.x, -r1.w, r3
mul r2.w, r2.z, c9.x
mul r2.w, r2.z, r2
mad r0.w, r2, c10.z, r0
add r1.x, -r1.w, r1
add r0.w, -r1, r0
mul r2.x, r2, r3
mad r0.w, r2.z, r0, -r2.x
mad r0.w, -r2.y, r1.x, r0
rcp r1.w, r1.w
mul r1.w, r0, r1
add r0.w, -r1.y, c7.x
cmp r1.x, r1.z, c10, c10.y
cmp r0.w, r0, c10.x, c10.y
mul_pp r0.w, r0, r1.x
mul r1.x, r1.w, c5
abs_pp r0.w, r0
cmp r0.w, -r0, c10.y, r1.x
endif
dp4_pp r1.x, c2, c2
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, c2
dp3_pp r0.y, r0, r1
texldp r0.x, v2, s1
mul_pp r0.y, r0, c3.w
mul_pp r0.x, r0.y, r0
mul_pp r0.x, r0, c10.w
max_pp r0.x, r0, c10.y
mul_pp r0.x, r0, c3
max r0.x, r0, c10.y
max r0.x, r0, c10.y
mul_sat r0.x, r0.w, r0
mul_pp oC0.w, r0.x, c4
mov_pp oC0.xyz, c4
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 180 used size, 12 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 144 [_Visibility]
Float 148 [_OceanRadius]
Float 152 [_SphereRadius]
Float 172 [_DensityRatioY]
Float 176 [_DensityRatioX]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
// 91 instructions, 3 temp regs, 0 temp arrays:
// ALU 82 float, 0 int, 3 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfjajjbbnoemckcjnfnkjbooifmbbhpbaabaaaaaaaianaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoialaaaa
eaaaaaaapkacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajocaabaaaaaaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
abaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagaabaaa
abaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaafaaaaaajgahbaaaaaaaaaaa
bnaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaadcaaaaakbcaabaaa
abaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaa
elaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaaigcaabaaaabaaaaaa
fgigcaaaaaaaaaaaajaaaaaaagaabaaaabaaaaaaabaaaaahgcaabaaaabaaaaaa
kgakbaaaaaaaaaaafgagbaaaabaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaam
dcaabaaaacaaaaaajgifcaaaaaaaaaaaajaaaaaajgifcaaaaaaaaaaaajaaaaaa
kgakbaiaebaaaaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaakaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
aaaaaaaifcaabaaaacaaaaaafgafbaaaaaaaaaaaagabbaiaebaaaaaaacaaaaaa
dhaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaa
aaaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaa
aaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
deaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaaddaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaacaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiicaabaaaabaaaaaa
dkaabaaaabaaaaaaakiacaaaaaaaaaaaalaaaaaadcaaaaajicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaamicaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaa
dkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaa
abaaaaaaaaaaaaaiicaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
deaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaibcaabaaa
acaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaalaaaaaadcaaaaajbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaam
bcaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaa
ajaaaaaaakaabaaaacaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaabkaabaiaebaaaaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaa
ckiacaaaaaaaaaaaajaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadbaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackiacaaaaaaaaaaaajaaaaaaabaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaaaaaaaaaebcaaaaficaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaa
bkaabaaaacaaaaaaaaaaaaaiicaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
bkaabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
abaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaaaaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaabaaaaaadkaabaaaabaaaaaaakiacaaaaaaaaaaaalaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaa
dcaaaaamicaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaa
aaaaaaaaajaaaaaadkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaajccaabaaa
abaaaaaackiacaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaaaoaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaabaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaaabaaaaaackaabaaa
abaaaaaaakiacaaaaaaaaaaaalaaaaaadcaaaaajecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaamecaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaackaabaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaabaaaaaa
diaaaaahecaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
ecaabaaaabaaaaaackaabaaaabaaaaaaakiacaaaaaaaaaaaalaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaa
dcaaaaamecaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaa
aaaaaaaaajaaaaaackaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaaoaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaadhaaaaajbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajocaabaaa
aaaaaaaaagbjbaiaebaaaaaaaeaaaaaaagijcaaaabaaaaaaaeaaaaaabaaaaaah
bcaabaaaabaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agaabaaaabaaaaaabbaaaaajbcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaaaoaaaaah
mcaabaaaaaaaaaaaagbebaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaah
ccaabaaaaaaaaaaafgafbaaaaaaaaaaaagaabaaaabaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadeaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaahaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaa
ahaaaaaadoaaaaab"
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
Float 8 [_DensityRatioY]
Float 9 [_DensityRatioX]
SetTexture 0 [_CameraDepthTexture] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_3_0
; 108 ALU, 2 TEX, 2 FLOW
dcl_2d s0
dcl_2d s1
def c10, 1.00000000, 0.00000000, 0.33333334, 2.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord4 v3.xyz
dcl_texcoord5 v4.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r1.z, v4, r0
dp3 r1.w, v4, v4
mad r0.x, -r1.z, r1.z, r1.w
rsq r0.x, r0.x
rcp r1.y, r0.x
mul r1.x, r1.y, r1.y
mad r0.z, c6.x, c6.x, -r1.x
add r0.x, -r1.y, c6
rsq r0.z, r0.z
cmp r0.x, r0, c10, c10.y
cmp r0.y, r1.z, c10.x, c10
mul_pp r0.y, r0.x, r0
texldp r0.x, v0, s0
mad r0.w, r0.x, c1.z, c1
rcp r0.z, r0.z
add r0.x, r1.z, -r0.z
rcp r0.w, r0.w
cmp r2.x, -r0.y, r0.w, r0
add r0.xyz, -v3, c0
min r0.w, r2.x, r0
dp3 r2.x, r0, r0
rsq r2.y, r2.x
rsq r1.w, r1.w
mul r0.xyz, r2.y, r0
rcp r2.x, r1.w
add r1.w, r2.x, -c7.x
cmp r1.w, r1, c10.y, c10.x
cmp r2.y, r1.z, c10, c10.x
mul_pp r2.y, r1.w, r2
mul r1.w, c7.x, c7.x
if_gt r2.y, c10.y
mad r1.y, r2.x, r2.x, -r1.x
add r1.z, -r1.x, r1.w
rsq r1.z, r1.z
rsq r1.y, r1.y
rcp r1.y, r1.y
rcp r1.z, r1.z
add r1.z, -r1.y, r1
min r0.w, r0, r1.z
add r1.z, r1.y, r0.w
mul r0.w, r1.z, c9.x
mul r2.x, r1.z, r0.w
mul r1.x, r1, c8
mad r2.x, r2, c10.z, r1
mul r0.w, r1.y, c9.x
mul r0.w, r1.y, r0
mad r0.w, r0, c10.z, r1.x
add r2.x, -r1.w, r2
mul r1.x, r1.z, r2
add r0.w, r0, -r1
rcp r1.z, r1.w
mad r0.w, r1.y, r0, -r1.x
mul r0.w, r0, r1.z
mul r0.w, r0, c5.x
else
add r2.y, r1.w, -r1.x
rsq r2.z, r2.y
add r2.x, -r2, c7
add r2.y, r2.x, c10.x
rcp r2.x, r2.z
frc r2.z, r2.y
add r2.w, r1.z, -r2.x
add_sat r2.y, r2, -r2.z
mad r2.y, r2, r2.w, r2.x
mul r2.z, r2.y, c9.x
mul r2.w, r2.y, r2.z
add r2.z, r1, -r0.w
max r3.x, -r2.z, c10.y
mul r0.w, r1.x, c8.x
mad r1.x, r2.w, c10.z, r0.w
min r2.x, r2, r3
mul r2.w, r2.x, c9.x
mul r3.x, r2, r2.w
max r2.z, r2, c10.y
mad r3.x, r3, c10.z, r0.w
add r3.x, -r1.w, r3
mul r2.w, r2.z, c9.x
mul r2.w, r2.z, r2
mad r0.w, r2, c10.z, r0
add r1.x, -r1.w, r1
add r0.w, -r1, r0
mul r2.x, r2, r3
mad r0.w, r2.z, r0, -r2.x
mad r0.w, -r2.y, r1.x, r0
rcp r1.w, r1.w
mul r1.w, r0, r1
add r0.w, -r1.y, c7.x
cmp r1.x, r1.z, c10, c10.y
cmp r0.w, r0, c10.x, c10.y
mul_pp r0.w, r0, r1.x
mul r1.x, r1.w, c5
abs_pp r0.w, r0
cmp r0.w, -r0, c10.y, r1.x
endif
dp4_pp r1.x, c2, c2
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, c2
dp3_pp r0.y, r0, r1
texldp r0.x, v2, s1
mul_pp r0.y, r0, c3.w
mul_pp r0.x, r0.y, r0
mul_pp r0.x, r0, c10.w
max_pp r0.x, r0, c10.y
mul_pp r0.x, r0, c3
max r0.x, r0, c10.y
max r0.x, r0, c10.y
mul_sat r0.x, r0.w, r0
mul_pp oC0.w, r0.x, c4
mov_pp oC0.xyz, c4
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 180 used size, 12 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Float 144 [_Visibility]
Float 148 [_OceanRadius]
Float 152 [_SphereRadius]
Float 172 [_DensityRatioY]
Float 176 [_DensityRatioX]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
// 91 instructions, 3 temp regs, 0 temp arrays:
// ALU 82 float, 0 int, 3 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfjajjbbnoemckcjnfnkjbooifmbbhpbaabaaaaaaaianaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoialaaaa
eaaaaaaapkacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaajocaabaaaaaaaaaaa
agbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
abaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagaabaaa
abaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaafaaaaaajgahbaaaaaaaaaaa
bnaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaadcaaaaakbcaabaaa
abaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaa
elaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaaigcaabaaaabaaaaaa
fgigcaaaaaaaaaaaajaaaaaaagaabaaaabaaaaaaabaaaaahgcaabaaaabaaaaaa
kgakbaaaaaaaaaaafgagbaaaabaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaam
dcaabaaaacaaaaaajgifcaaaaaaaaaaaajaaaaaajgifcaaaaaaaaaaaajaaaaaa
kgakbaiaebaaaaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaakaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
aaaaaaaifcaabaaaacaaaaaafgafbaaaaaaaaaaaagabbaiaebaaaaaaacaaaaaa
dhaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaa
aaaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaa
aaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
deaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaaddaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaacaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiicaabaaaabaaaaaa
dkaabaaaabaaaaaaakiacaaaaaaaaaaaalaaaaaadcaaaaajicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaamicaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaa
dkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaa
abaaaaaaaaaaaaaiicaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
deaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaibcaabaaa
acaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaalaaaaaadcaaaaajbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaam
bcaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaa
ajaaaaaaakaabaaaacaaaaaadcaaaaakccaabaaaabaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaabkaabaiaebaaaaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaa
ckiacaaaaaaaaaaaajaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadbaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackiacaaaaaaaaaaaajaaaaaaabaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaaaaaaaaaebcaaaaficaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaa
bkaabaaaacaaaaaaaaaaaaaiicaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
bkaabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
abaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaaaaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaabaaaaaadkaabaaaabaaaaaaakiacaaaaaaaaaaaalaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaa
dcaaaaamicaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaa
aaaaaaaaajaaaaaadkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaajccaabaaa
abaaaaaackiacaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaaaoaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaabaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaaabaaaaaackaabaaa
abaaaaaaakiacaaaaaaaaaaaalaaaaaadcaaaaajecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaadcaaaaamecaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaaaaaaaaaaajaaaaaackaabaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaabaaaaaa
diaaaaahecaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
ecaabaaaabaaaaaackaabaaaabaaaaaaakiacaaaaaaaaaaaalaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaabaaaaaaabeaaaaaklkkkkdockaabaaaaaaaaaaa
dcaaaaamecaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaackiacaaa
aaaaaaaaajaaaaaackaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaaoaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaadhaaaaajbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajocaabaaa
aaaaaaaaagbjbaiaebaaaaaaaeaaaaaaagijcaaaabaaaaaaaeaaaaaabaaaaaah
bcaabaaaabaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agaabaaaabaaaaaabbaaaaajbcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaaaoaaaaah
mcaabaaaaaaaaaaaagbebaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaah
ccaabaaaaaaaaaaafgafbaaaaaaaaaaaagaabaaaabaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadeaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaahaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaa
ahaaaaaadoaaaaab"
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

#LINE 175

	
		}
		
	} 
	
}
}
