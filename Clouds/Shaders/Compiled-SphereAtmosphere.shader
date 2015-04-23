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
		_DensityRatioZ ("Density RatioZ", Float) = 1
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
		
		Program "vp" {
// Vertex combos: 24
//   d3d9 - ALU: 12 to 21
//   d3d11 - ALU: 9 to 18, TEX: 0 to 0, FLOW: 1 to 1
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
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityRatioZ;
uniform float _DensityRatioY;
uniform float _DensityRatioX;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  oceanSphereDist_1 = tmpvar_3;
  if (((tmpvar_5 <= _OceanRadius) && (tmpvar_4 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_4 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_6)));
  };
  float tmpvar_7;
  tmpvar_7 = min (oceanSphereDist_1, tmpvar_3);
  float tmpvar_8;
  tmpvar_8 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_9;
  tmpvar_9 = clamp (floor((1.0 + tmpvar_4)), 0.0, 1.0);
  float tmpvar_10;
  tmpvar_10 = mix ((tmpvar_7 + tmpvar_8), max (0.0, (tmpvar_7 - tmpvar_4)), tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = (tmpvar_9 * tmpvar_4);
  float tmpvar_12;
  tmpvar_12 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_7)), tmpvar_9);
  float tmpvar_13;
  tmpvar_13 = (tmpvar_6 / _Visibility);
  float tmpvar_14;
  tmpvar_14 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_10) * tmpvar_10) + tmpvar_13)));
  float tmpvar_15;
  tmpvar_15 = sqrt(((_DensityRatioZ * _DensityRatioZ) * tmpvar_13));
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_11) * tmpvar_11) + tmpvar_13)));
  float tmpvar_17;
  tmpvar_17 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_12) * tmpvar_12) + tmpvar_13)));
  color_2.w = (_Color.w * clamp ((((-((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_14 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_14) / _DensityRatioY)))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_15 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_15) / _DensityRatioY))))) + -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_16 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_16) / _DensityRatioY))))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_17 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_17) / _DensityRatioY))))), 0.0, 1.0));
  gl_FragData[0] = color_2;
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
ConstBuffer "$Globals" 128 // 108 used size, 13 vars
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 402
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 401
uniform highp float _DensityRatioPow;
#line 418
#line 439
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
    #line 427
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 431
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 435
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 402
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 401
uniform highp float _DensityRatioPow;
#line 418
#line 439
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 418
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 422
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 439
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 443
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 447
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 452
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 456
    highp float alt = length(IN.L);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    #line 460
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    #line 464
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 468
    color.w *= xll_saturate_f(depth);
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
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityRatioZ;
uniform float _DensityRatioY;
uniform float _DensityRatioX;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  oceanSphereDist_1 = tmpvar_3;
  if (((tmpvar_5 <= _OceanRadius) && (tmpvar_4 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_4 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_6)));
  };
  float tmpvar_7;
  tmpvar_7 = min (oceanSphereDist_1, tmpvar_3);
  float tmpvar_8;
  tmpvar_8 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_9;
  tmpvar_9 = clamp (floor((1.0 + tmpvar_4)), 0.0, 1.0);
  float tmpvar_10;
  tmpvar_10 = mix ((tmpvar_7 + tmpvar_8), max (0.0, (tmpvar_7 - tmpvar_4)), tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = (tmpvar_9 * tmpvar_4);
  float tmpvar_12;
  tmpvar_12 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_7)), tmpvar_9);
  float tmpvar_13;
  tmpvar_13 = (tmpvar_6 / _Visibility);
  float tmpvar_14;
  tmpvar_14 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_10) * tmpvar_10) + tmpvar_13)));
  float tmpvar_15;
  tmpvar_15 = sqrt(((_DensityRatioZ * _DensityRatioZ) * tmpvar_13));
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_11) * tmpvar_11) + tmpvar_13)));
  float tmpvar_17;
  tmpvar_17 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_12) * tmpvar_12) + tmpvar_13)));
  color_2.w = (_Color.w * clamp ((((-((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_14 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_14) / _DensityRatioY)))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_15 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_15) / _DensityRatioY))))) + -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_16 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_16) / _DensityRatioY))))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_17 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_17) / _DensityRatioY))))), 0.0, 1.0));
  gl_FragData[0] = color_2;
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
ConstBuffer "$Globals" 128 // 108 used size, 13 vars
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 402
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 401
uniform highp float _DensityRatioPow;
#line 418
#line 439
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
    #line 427
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 431
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 435
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 402
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 401
uniform highp float _DensityRatioPow;
#line 418
#line 439
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 418
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 422
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 439
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 443
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 447
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 452
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 456
    highp float alt = length(IN.L);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    #line 460
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    #line 464
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 468
    color.w *= xll_saturate_f(depth);
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
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityRatioZ;
uniform float _DensityRatioY;
uniform float _DensityRatioX;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  oceanSphereDist_1 = tmpvar_3;
  if (((tmpvar_5 <= _OceanRadius) && (tmpvar_4 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_4 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_6)));
  };
  float tmpvar_7;
  tmpvar_7 = min (oceanSphereDist_1, tmpvar_3);
  float tmpvar_8;
  tmpvar_8 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_9;
  tmpvar_9 = clamp (floor((1.0 + tmpvar_4)), 0.0, 1.0);
  float tmpvar_10;
  tmpvar_10 = mix ((tmpvar_7 + tmpvar_8), max (0.0, (tmpvar_7 - tmpvar_4)), tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = (tmpvar_9 * tmpvar_4);
  float tmpvar_12;
  tmpvar_12 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_7)), tmpvar_9);
  float tmpvar_13;
  tmpvar_13 = (tmpvar_6 / _Visibility);
  float tmpvar_14;
  tmpvar_14 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_10) * tmpvar_10) + tmpvar_13)));
  float tmpvar_15;
  tmpvar_15 = sqrt(((_DensityRatioZ * _DensityRatioZ) * tmpvar_13));
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_11) * tmpvar_11) + tmpvar_13)));
  float tmpvar_17;
  tmpvar_17 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_12) * tmpvar_12) + tmpvar_13)));
  color_2.w = (_Color.w * clamp ((((-((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_14 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_14) / _DensityRatioY)))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_15 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_15) / _DensityRatioY))))) + -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_16 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_16) / _DensityRatioY))))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_17 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_17) / _DensityRatioY))))), 0.0, 1.0));
  gl_FragData[0] = color_2;
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
ConstBuffer "$Globals" 128 // 108 used size, 13 vars
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 402
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 401
uniform highp float _DensityRatioPow;
#line 418
#line 439
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
    #line 427
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 431
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 435
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 402
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 401
uniform highp float _DensityRatioPow;
#line 418
#line 439
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 418
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 422
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 439
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 443
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 447
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 452
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 456
    highp float alt = length(IN.L);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    #line 460
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    #line 464
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 468
    color.w *= xll_saturate_f(depth);
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
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityRatioZ;
uniform float _DensityRatioY;
uniform float _DensityRatioX;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  oceanSphereDist_1 = tmpvar_3;
  if (((tmpvar_5 <= _OceanRadius) && (tmpvar_4 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_4 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_6)));
  };
  float tmpvar_7;
  tmpvar_7 = min (oceanSphereDist_1, tmpvar_3);
  float tmpvar_8;
  tmpvar_8 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_9;
  tmpvar_9 = clamp (floor((1.0 + tmpvar_4)), 0.0, 1.0);
  float tmpvar_10;
  tmpvar_10 = mix ((tmpvar_7 + tmpvar_8), max (0.0, (tmpvar_7 - tmpvar_4)), tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = (tmpvar_9 * tmpvar_4);
  float tmpvar_12;
  tmpvar_12 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_7)), tmpvar_9);
  float tmpvar_13;
  tmpvar_13 = (tmpvar_6 / _Visibility);
  float tmpvar_14;
  tmpvar_14 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_10) * tmpvar_10) + tmpvar_13)));
  float tmpvar_15;
  tmpvar_15 = sqrt(((_DensityRatioZ * _DensityRatioZ) * tmpvar_13));
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_11) * tmpvar_11) + tmpvar_13)));
  float tmpvar_17;
  tmpvar_17 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_12) * tmpvar_12) + tmpvar_13)));
  color_2.w = (_Color.w * clamp ((((-((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_14 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_14) / _DensityRatioY)))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_15 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_15) / _DensityRatioY))))) + -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_16 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_16) / _DensityRatioY))))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_17 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_17) / _DensityRatioY))))), 0.0, 1.0));
  gl_FragData[0] = color_2;
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
ConstBuffer "$Globals" 192 // 172 used size, 14 vars
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 449
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 434
v2f vert( in appdata_t v ) {
    #line 436
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 440
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 444
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 449
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 427
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 431
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 449
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 453
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 457
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 462
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 466
    highp float alt = length(IN.L);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    #line 470
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    #line 474
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 478
    color.w *= xll_saturate_f(depth);
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
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityRatioZ;
uniform float _DensityRatioY;
uniform float _DensityRatioX;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  oceanSphereDist_1 = tmpvar_3;
  if (((tmpvar_5 <= _OceanRadius) && (tmpvar_4 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_4 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_6)));
  };
  float tmpvar_7;
  tmpvar_7 = min (oceanSphereDist_1, tmpvar_3);
  float tmpvar_8;
  tmpvar_8 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_9;
  tmpvar_9 = clamp (floor((1.0 + tmpvar_4)), 0.0, 1.0);
  float tmpvar_10;
  tmpvar_10 = mix ((tmpvar_7 + tmpvar_8), max (0.0, (tmpvar_7 - tmpvar_4)), tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = (tmpvar_9 * tmpvar_4);
  float tmpvar_12;
  tmpvar_12 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_7)), tmpvar_9);
  float tmpvar_13;
  tmpvar_13 = (tmpvar_6 / _Visibility);
  float tmpvar_14;
  tmpvar_14 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_10) * tmpvar_10) + tmpvar_13)));
  float tmpvar_15;
  tmpvar_15 = sqrt(((_DensityRatioZ * _DensityRatioZ) * tmpvar_13));
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_11) * tmpvar_11) + tmpvar_13)));
  float tmpvar_17;
  tmpvar_17 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_12) * tmpvar_12) + tmpvar_13)));
  color_2.w = (_Color.w * clamp ((((-((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_14 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_14) / _DensityRatioY)))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_15 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_15) / _DensityRatioY))))) + -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_16 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_16) / _DensityRatioY))))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_17 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_17) / _DensityRatioY))))), 0.0, 1.0));
  gl_FragData[0] = color_2;
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
ConstBuffer "$Globals" 192 // 172 used size, 14 vars
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 449
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 434
v2f vert( in appdata_t v ) {
    #line 436
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 440
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 444
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 449
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 427
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 431
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 449
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 453
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 457
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 462
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 466
    highp float alt = length(IN.L);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    #line 470
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    #line 474
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 478
    color.w *= xll_saturate_f(depth);
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
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityRatioZ;
uniform float _DensityRatioY;
uniform float _DensityRatioX;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  oceanSphereDist_1 = tmpvar_3;
  if (((tmpvar_5 <= _OceanRadius) && (tmpvar_4 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_4 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_6)));
  };
  float tmpvar_7;
  tmpvar_7 = min (oceanSphereDist_1, tmpvar_3);
  float tmpvar_8;
  tmpvar_8 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_9;
  tmpvar_9 = clamp (floor((1.0 + tmpvar_4)), 0.0, 1.0);
  float tmpvar_10;
  tmpvar_10 = mix ((tmpvar_7 + tmpvar_8), max (0.0, (tmpvar_7 - tmpvar_4)), tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = (tmpvar_9 * tmpvar_4);
  float tmpvar_12;
  tmpvar_12 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_7)), tmpvar_9);
  float tmpvar_13;
  tmpvar_13 = (tmpvar_6 / _Visibility);
  float tmpvar_14;
  tmpvar_14 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_10) * tmpvar_10) + tmpvar_13)));
  float tmpvar_15;
  tmpvar_15 = sqrt(((_DensityRatioZ * _DensityRatioZ) * tmpvar_13));
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_11) * tmpvar_11) + tmpvar_13)));
  float tmpvar_17;
  tmpvar_17 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_12) * tmpvar_12) + tmpvar_13)));
  color_2.w = (_Color.w * clamp ((((-((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_14 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_14) / _DensityRatioY)))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_15 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_15) / _DensityRatioY))))) + -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_16 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_16) / _DensityRatioY))))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_17 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_17) / _DensityRatioY))))), 0.0, 1.0));
  gl_FragData[0] = color_2;
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
ConstBuffer "$Globals" 192 // 172 used size, 14 vars
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 449
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 434
v2f vert( in appdata_t v ) {
    #line 436
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 440
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 444
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 449
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 427
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 431
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 449
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 453
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 457
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 462
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 466
    highp float alt = length(IN.L);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    #line 470
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    #line 474
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 478
    color.w *= xll_saturate_f(depth);
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
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityRatioZ;
uniform float _DensityRatioY;
uniform float _DensityRatioX;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  oceanSphereDist_1 = tmpvar_3;
  if (((tmpvar_5 <= _OceanRadius) && (tmpvar_4 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_4 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_6)));
  };
  float tmpvar_7;
  tmpvar_7 = min (oceanSphereDist_1, tmpvar_3);
  float tmpvar_8;
  tmpvar_8 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_9;
  tmpvar_9 = clamp (floor((1.0 + tmpvar_4)), 0.0, 1.0);
  float tmpvar_10;
  tmpvar_10 = mix ((tmpvar_7 + tmpvar_8), max (0.0, (tmpvar_7 - tmpvar_4)), tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = (tmpvar_9 * tmpvar_4);
  float tmpvar_12;
  tmpvar_12 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_7)), tmpvar_9);
  float tmpvar_13;
  tmpvar_13 = (tmpvar_6 / _Visibility);
  float tmpvar_14;
  tmpvar_14 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_10) * tmpvar_10) + tmpvar_13)));
  float tmpvar_15;
  tmpvar_15 = sqrt(((_DensityRatioZ * _DensityRatioZ) * tmpvar_13));
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_11) * tmpvar_11) + tmpvar_13)));
  float tmpvar_17;
  tmpvar_17 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_12) * tmpvar_12) + tmpvar_13)));
  color_2.w = (_Color.w * clamp ((((-((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_14 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_14) / _DensityRatioY)))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_15 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_15) / _DensityRatioY))))) + -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_16 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_16) / _DensityRatioY))))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_17 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_17) / _DensityRatioY))))), 0.0, 1.0));
  gl_FragData[0] = color_2;
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
ConstBuffer "$Globals" 128 // 108 used size, 13 vars
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 402
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 401
uniform highp float _DensityRatioPow;
#line 418
#line 439
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
    #line 427
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 431
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 435
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 402
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 401
uniform highp float _DensityRatioPow;
#line 418
#line 439
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 418
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 422
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 439
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 443
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 447
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 452
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 456
    highp float alt = length(IN.L);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    #line 460
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    #line 464
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 468
    color.w *= xll_saturate_f(depth);
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
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityRatioZ;
uniform float _DensityRatioY;
uniform float _DensityRatioX;
uniform float _OceanRadius;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w)));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  oceanSphereDist_1 = tmpvar_3;
  if (((tmpvar_5 <= _OceanRadius) && (tmpvar_4 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_4 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_6)));
  };
  float tmpvar_7;
  tmpvar_7 = min (oceanSphereDist_1, tmpvar_3);
  float tmpvar_8;
  tmpvar_8 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_9;
  tmpvar_9 = clamp (floor((1.0 + tmpvar_4)), 0.0, 1.0);
  float tmpvar_10;
  tmpvar_10 = mix ((tmpvar_7 + tmpvar_8), max (0.0, (tmpvar_7 - tmpvar_4)), tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = (tmpvar_9 * tmpvar_4);
  float tmpvar_12;
  tmpvar_12 = mix (tmpvar_8, max (0.0, (tmpvar_4 - tmpvar_7)), tmpvar_9);
  float tmpvar_13;
  tmpvar_13 = (tmpvar_6 / _Visibility);
  float tmpvar_14;
  tmpvar_14 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_10) * tmpvar_10) + tmpvar_13)));
  float tmpvar_15;
  tmpvar_15 = sqrt(((_DensityRatioZ * _DensityRatioZ) * tmpvar_13));
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_11) * tmpvar_11) + tmpvar_13)));
  float tmpvar_17;
  tmpvar_17 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_12) * tmpvar_12) + tmpvar_13)));
  color_2.w = (_Color.w * clamp ((((-((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_14 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_14) / _DensityRatioY)))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_15 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_15) / _DensityRatioY))))) + -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_16 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_16) / _DensityRatioY))))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_17 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_17) / _DensityRatioY))))), 0.0, 1.0));
  gl_FragData[0] = color_2;
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
ConstBuffer "$Globals" 192 // 172 used size, 14 vars
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 449
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 434
v2f vert( in appdata_t v ) {
    #line 436
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 440
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 444
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 449
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 427
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 431
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 449
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 453
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 457
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 462
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 466
    highp float alt = length(IN.L);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    #line 470
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    #line 474
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 478
    color.w *= xll_saturate_f(depth);
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 449
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 434
v2f vert( in appdata_t v ) {
    #line 436
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 440
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 444
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 449
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 427
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 431
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 449
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 453
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 457
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 462
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 466
    highp float alt = length(IN.L);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    #line 470
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    #line 474
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 478
    color.w *= xll_saturate_f(depth);
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 449
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 434
v2f vert( in appdata_t v ) {
    #line 436
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 440
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 444
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 449
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 427
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 431
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 449
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 453
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 457
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 462
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 466
    highp float alt = length(IN.L);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    #line 470
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    #line 474
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 478
    color.w *= xll_saturate_f(depth);
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 449
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 434
v2f vert( in appdata_t v ) {
    #line 436
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 440
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 444
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 449
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 427
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 431
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 449
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 453
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 457
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 462
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 466
    highp float alt = length(IN.L);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    #line 470
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    #line 474
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 478
    color.w *= xll_saturate_f(depth);
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 449
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 434
v2f vert( in appdata_t v ) {
    #line 436
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 440
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.scrPos = ComputeScreenPos( o.pos);
    #line 444
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 449
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 427
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 431
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 449
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 453
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 457
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 462
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 466
    highp float alt = length(IN.L);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    #line 470
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    #line 474
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 478
    color.w *= xll_saturate_f(depth);
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
varying vec3 xlv_TEXCOORD1;
uniform float _DensityRatioZ;
uniform float _DensityRatioY;
uniform float _DensityRatioX;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_4;
  tmpvar_4 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_3 * tmpvar_3)));
  float tmpvar_5;
  tmpvar_5 = pow (tmpvar_4, 2.0);
  oceanSphereDist_1 = 1e+32;
  if (((tmpvar_4 <= _OceanRadius) && (tmpvar_3 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_3 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_5)));
  };
  float tmpvar_6;
  tmpvar_6 = min (oceanSphereDist_1, 1e+32);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_5));
  float tmpvar_8;
  tmpvar_8 = clamp (floor((1.0 + tmpvar_3)), 0.0, 1.0);
  float tmpvar_9;
  tmpvar_9 = mix ((tmpvar_6 + tmpvar_7), max (0.0, (tmpvar_6 - tmpvar_3)), tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = (tmpvar_8 * tmpvar_3);
  float tmpvar_11;
  tmpvar_11 = mix (tmpvar_7, max (0.0, (tmpvar_3 - tmpvar_6)), tmpvar_8);
  float tmpvar_12;
  tmpvar_12 = (tmpvar_5 / _Visibility);
  float tmpvar_13;
  tmpvar_13 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_9) * tmpvar_9) + tmpvar_12)));
  float tmpvar_14;
  tmpvar_14 = sqrt(((_DensityRatioZ * _DensityRatioZ) * tmpvar_12));
  float tmpvar_15;
  tmpvar_15 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_10) * tmpvar_10) + tmpvar_12)));
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_11) * tmpvar_11) + tmpvar_12)));
  color_2.w = (_Color.w * clamp ((((-((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_13 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_13) / _DensityRatioY)))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_14 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_14) / _DensityRatioY))))) + -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_15 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_15) / _DensityRatioY))))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_16 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_16) / _DensityRatioY))))), 0.0, 1.0));
  gl_FragData[0] = color_2;
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
// 12 instructions, 1 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkkccpabfaooigocpbhdnapgcmkmjmkdoabaaaaaafeadaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
baacaaaaeaaaabaaieaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaipccabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaa
abaaaaaaapaaaaaaaaaaaaakhccabaaaaeaaaaaaegiccaiaebaaaaaaaaaaaaaa
aeaaaaaaegiccaaaabaaaaaaapaaaaaadoaaaaab"
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 402
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 401
uniform highp float _DensityRatioPow;
#line 418
#line 425
v2f vert( in appdata_t v ) {
    #line 427
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 431
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 436
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 402
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 401
uniform highp float _DensityRatioPow;
#line 418
#line 418
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 422
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 438
lowp vec4 frag( in v2f IN ) {
    #line 440
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 444
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 449
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 453
    highp float alt = length(IN.L);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    #line 457
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    #line 461
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 465
    color.w *= xll_saturate_f(depth);
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
varying vec3 xlv_TEXCOORD1;
uniform float _DensityRatioZ;
uniform float _DensityRatioY;
uniform float _DensityRatioX;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_4;
  tmpvar_4 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_3 * tmpvar_3)));
  float tmpvar_5;
  tmpvar_5 = pow (tmpvar_4, 2.0);
  oceanSphereDist_1 = 1e+32;
  if (((tmpvar_4 <= _OceanRadius) && (tmpvar_3 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_3 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_5)));
  };
  float tmpvar_6;
  tmpvar_6 = min (oceanSphereDist_1, 1e+32);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_5));
  float tmpvar_8;
  tmpvar_8 = clamp (floor((1.0 + tmpvar_3)), 0.0, 1.0);
  float tmpvar_9;
  tmpvar_9 = mix ((tmpvar_6 + tmpvar_7), max (0.0, (tmpvar_6 - tmpvar_3)), tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = (tmpvar_8 * tmpvar_3);
  float tmpvar_11;
  tmpvar_11 = mix (tmpvar_7, max (0.0, (tmpvar_3 - tmpvar_6)), tmpvar_8);
  float tmpvar_12;
  tmpvar_12 = (tmpvar_5 / _Visibility);
  float tmpvar_13;
  tmpvar_13 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_9) * tmpvar_9) + tmpvar_12)));
  float tmpvar_14;
  tmpvar_14 = sqrt(((_DensityRatioZ * _DensityRatioZ) * tmpvar_12));
  float tmpvar_15;
  tmpvar_15 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_10) * tmpvar_10) + tmpvar_12)));
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_11) * tmpvar_11) + tmpvar_12)));
  color_2.w = (_Color.w * clamp ((((-((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_13 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_13) / _DensityRatioY)))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_14 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_14) / _DensityRatioY))))) + -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_15 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_15) / _DensityRatioY))))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_16 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_16) / _DensityRatioY))))), 0.0, 1.0));
  gl_FragData[0] = color_2;
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
// 12 instructions, 1 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkkccpabfaooigocpbhdnapgcmkmjmkdoabaaaaaafeadaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
baacaaaaeaaaabaaieaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaipccabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaa
abaaaaaaapaaaaaaaaaaaaakhccabaaaaeaaaaaaegiccaiaebaaaaaaaaaaaaaa
aeaaaaaaegiccaaaabaaaaaaapaaaaaadoaaaaab"
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 402
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 401
uniform highp float _DensityRatioPow;
#line 418
#line 425
v2f vert( in appdata_t v ) {
    #line 427
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 431
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 436
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 402
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 401
uniform highp float _DensityRatioPow;
#line 418
#line 418
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 422
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 438
lowp vec4 frag( in v2f IN ) {
    #line 440
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 444
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 449
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 453
    highp float alt = length(IN.L);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    #line 457
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    #line 461
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 465
    color.w *= xll_saturate_f(depth);
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
varying vec3 xlv_TEXCOORD1;
uniform float _DensityRatioZ;
uniform float _DensityRatioY;
uniform float _DensityRatioX;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_4;
  tmpvar_4 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_3 * tmpvar_3)));
  float tmpvar_5;
  tmpvar_5 = pow (tmpvar_4, 2.0);
  oceanSphereDist_1 = 1e+32;
  if (((tmpvar_4 <= _OceanRadius) && (tmpvar_3 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_3 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_5)));
  };
  float tmpvar_6;
  tmpvar_6 = min (oceanSphereDist_1, 1e+32);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_5));
  float tmpvar_8;
  tmpvar_8 = clamp (floor((1.0 + tmpvar_3)), 0.0, 1.0);
  float tmpvar_9;
  tmpvar_9 = mix ((tmpvar_6 + tmpvar_7), max (0.0, (tmpvar_6 - tmpvar_3)), tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = (tmpvar_8 * tmpvar_3);
  float tmpvar_11;
  tmpvar_11 = mix (tmpvar_7, max (0.0, (tmpvar_3 - tmpvar_6)), tmpvar_8);
  float tmpvar_12;
  tmpvar_12 = (tmpvar_5 / _Visibility);
  float tmpvar_13;
  tmpvar_13 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_9) * tmpvar_9) + tmpvar_12)));
  float tmpvar_14;
  tmpvar_14 = sqrt(((_DensityRatioZ * _DensityRatioZ) * tmpvar_12));
  float tmpvar_15;
  tmpvar_15 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_10) * tmpvar_10) + tmpvar_12)));
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_11) * tmpvar_11) + tmpvar_12)));
  color_2.w = (_Color.w * clamp ((((-((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_13 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_13) / _DensityRatioY)))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_14 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_14) / _DensityRatioY))))) + -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_15 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_15) / _DensityRatioY))))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_16 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_16) / _DensityRatioY))))), 0.0, 1.0));
  gl_FragData[0] = color_2;
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
// 12 instructions, 1 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkkccpabfaooigocpbhdnapgcmkmjmkdoabaaaaaafeadaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
baacaaaaeaaaabaaieaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaipccabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaa
abaaaaaaapaaaaaaaaaaaaakhccabaaaaeaaaaaaegiccaiaebaaaaaaaaaaaaaa
aeaaaaaaegiccaaaabaaaaaaapaaaaaadoaaaaab"
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 402
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 401
uniform highp float _DensityRatioPow;
#line 418
#line 425
v2f vert( in appdata_t v ) {
    #line 427
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 431
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 436
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 402
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 401
uniform highp float _DensityRatioPow;
#line 418
#line 418
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 422
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 438
lowp vec4 frag( in v2f IN ) {
    #line 440
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 444
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 449
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 453
    highp float alt = length(IN.L);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    #line 457
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    #line 461
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 465
    color.w *= xll_saturate_f(depth);
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
varying vec3 xlv_TEXCOORD1;
uniform float _DensityRatioZ;
uniform float _DensityRatioY;
uniform float _DensityRatioX;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_4;
  tmpvar_4 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_3 * tmpvar_3)));
  float tmpvar_5;
  tmpvar_5 = pow (tmpvar_4, 2.0);
  oceanSphereDist_1 = 1e+32;
  if (((tmpvar_4 <= _OceanRadius) && (tmpvar_3 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_3 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_5)));
  };
  float tmpvar_6;
  tmpvar_6 = min (oceanSphereDist_1, 1e+32);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_5));
  float tmpvar_8;
  tmpvar_8 = clamp (floor((1.0 + tmpvar_3)), 0.0, 1.0);
  float tmpvar_9;
  tmpvar_9 = mix ((tmpvar_6 + tmpvar_7), max (0.0, (tmpvar_6 - tmpvar_3)), tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = (tmpvar_8 * tmpvar_3);
  float tmpvar_11;
  tmpvar_11 = mix (tmpvar_7, max (0.0, (tmpvar_3 - tmpvar_6)), tmpvar_8);
  float tmpvar_12;
  tmpvar_12 = (tmpvar_5 / _Visibility);
  float tmpvar_13;
  tmpvar_13 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_9) * tmpvar_9) + tmpvar_12)));
  float tmpvar_14;
  tmpvar_14 = sqrt(((_DensityRatioZ * _DensityRatioZ) * tmpvar_12));
  float tmpvar_15;
  tmpvar_15 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_10) * tmpvar_10) + tmpvar_12)));
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_11) * tmpvar_11) + tmpvar_12)));
  color_2.w = (_Color.w * clamp ((((-((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_13 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_13) / _DensityRatioY)))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_14 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_14) / _DensityRatioY))))) + -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_15 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_15) / _DensityRatioY))))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_16 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_16) / _DensityRatioY))))), 0.0, 1.0));
  gl_FragData[0] = color_2;
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
// 17 instructions, 2 temp regs, 0 temp arrays:
// ALU 12 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmbmaabppfajoopdpljojiolknadogilbabaaaaaaaeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckiacaaaaeaaaabaa
kkaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaaghccabaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaakhccabaaa
afaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaa
doaaaaab"
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 448
#line 434
v2f vert( in appdata_t v ) {
    #line 436
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 440
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 444
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 448
#line 427
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 431
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 448
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 452
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    #line 456
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        #line 460
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float alt = length(IN.L);
    #line 464
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    #line 468
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 472
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    color.w *= xll_saturate_f(depth);
    #line 476
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
varying vec3 xlv_TEXCOORD1;
uniform float _DensityRatioZ;
uniform float _DensityRatioY;
uniform float _DensityRatioX;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_4;
  tmpvar_4 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_3 * tmpvar_3)));
  float tmpvar_5;
  tmpvar_5 = pow (tmpvar_4, 2.0);
  oceanSphereDist_1 = 1e+32;
  if (((tmpvar_4 <= _OceanRadius) && (tmpvar_3 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_3 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_5)));
  };
  float tmpvar_6;
  tmpvar_6 = min (oceanSphereDist_1, 1e+32);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_5));
  float tmpvar_8;
  tmpvar_8 = clamp (floor((1.0 + tmpvar_3)), 0.0, 1.0);
  float tmpvar_9;
  tmpvar_9 = mix ((tmpvar_6 + tmpvar_7), max (0.0, (tmpvar_6 - tmpvar_3)), tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = (tmpvar_8 * tmpvar_3);
  float tmpvar_11;
  tmpvar_11 = mix (tmpvar_7, max (0.0, (tmpvar_3 - tmpvar_6)), tmpvar_8);
  float tmpvar_12;
  tmpvar_12 = (tmpvar_5 / _Visibility);
  float tmpvar_13;
  tmpvar_13 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_9) * tmpvar_9) + tmpvar_12)));
  float tmpvar_14;
  tmpvar_14 = sqrt(((_DensityRatioZ * _DensityRatioZ) * tmpvar_12));
  float tmpvar_15;
  tmpvar_15 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_10) * tmpvar_10) + tmpvar_12)));
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_11) * tmpvar_11) + tmpvar_12)));
  color_2.w = (_Color.w * clamp ((((-((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_13 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_13) / _DensityRatioY)))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_14 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_14) / _DensityRatioY))))) + -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_15 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_15) / _DensityRatioY))))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_16 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_16) / _DensityRatioY))))), 0.0, 1.0));
  gl_FragData[0] = color_2;
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
// 17 instructions, 2 temp regs, 0 temp arrays:
// ALU 12 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmbmaabppfajoopdpljojiolknadogilbabaaaaaaaeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckiacaaaaeaaaabaa
kkaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaaghccabaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaakhccabaaa
afaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaa
doaaaaab"
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 448
#line 434
v2f vert( in appdata_t v ) {
    #line 436
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 440
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 444
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 448
#line 427
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 431
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 448
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 452
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    #line 456
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        #line 460
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float alt = length(IN.L);
    #line 464
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    #line 468
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 472
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    color.w *= xll_saturate_f(depth);
    #line 476
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
varying vec3 xlv_TEXCOORD1;
uniform float _DensityRatioZ;
uniform float _DensityRatioY;
uniform float _DensityRatioX;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_4;
  tmpvar_4 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_3 * tmpvar_3)));
  float tmpvar_5;
  tmpvar_5 = pow (tmpvar_4, 2.0);
  oceanSphereDist_1 = 1e+32;
  if (((tmpvar_4 <= _OceanRadius) && (tmpvar_3 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_3 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_5)));
  };
  float tmpvar_6;
  tmpvar_6 = min (oceanSphereDist_1, 1e+32);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_5));
  float tmpvar_8;
  tmpvar_8 = clamp (floor((1.0 + tmpvar_3)), 0.0, 1.0);
  float tmpvar_9;
  tmpvar_9 = mix ((tmpvar_6 + tmpvar_7), max (0.0, (tmpvar_6 - tmpvar_3)), tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = (tmpvar_8 * tmpvar_3);
  float tmpvar_11;
  tmpvar_11 = mix (tmpvar_7, max (0.0, (tmpvar_3 - tmpvar_6)), tmpvar_8);
  float tmpvar_12;
  tmpvar_12 = (tmpvar_5 / _Visibility);
  float tmpvar_13;
  tmpvar_13 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_9) * tmpvar_9) + tmpvar_12)));
  float tmpvar_14;
  tmpvar_14 = sqrt(((_DensityRatioZ * _DensityRatioZ) * tmpvar_12));
  float tmpvar_15;
  tmpvar_15 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_10) * tmpvar_10) + tmpvar_12)));
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_11) * tmpvar_11) + tmpvar_12)));
  color_2.w = (_Color.w * clamp ((((-((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_13 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_13) / _DensityRatioY)))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_14 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_14) / _DensityRatioY))))) + -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_15 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_15) / _DensityRatioY))))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_16 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_16) / _DensityRatioY))))), 0.0, 1.0));
  gl_FragData[0] = color_2;
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
// 17 instructions, 2 temp regs, 0 temp arrays:
// ALU 12 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmbmaabppfajoopdpljojiolknadogilbabaaaaaaaeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckiacaaaaeaaaabaa
kkaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaaghccabaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaakhccabaaa
afaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaa
doaaaaab"
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 448
#line 434
v2f vert( in appdata_t v ) {
    #line 436
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 440
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 444
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 448
#line 427
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 431
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 448
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 452
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    #line 456
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        #line 460
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float alt = length(IN.L);
    #line 464
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    #line 468
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 472
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    color.w *= xll_saturate_f(depth);
    #line 476
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
varying vec3 xlv_TEXCOORD1;
uniform float _DensityRatioZ;
uniform float _DensityRatioY;
uniform float _DensityRatioX;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_4;
  tmpvar_4 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_3 * tmpvar_3)));
  float tmpvar_5;
  tmpvar_5 = pow (tmpvar_4, 2.0);
  oceanSphereDist_1 = 1e+32;
  if (((tmpvar_4 <= _OceanRadius) && (tmpvar_3 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_3 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_5)));
  };
  float tmpvar_6;
  tmpvar_6 = min (oceanSphereDist_1, 1e+32);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_5));
  float tmpvar_8;
  tmpvar_8 = clamp (floor((1.0 + tmpvar_3)), 0.0, 1.0);
  float tmpvar_9;
  tmpvar_9 = mix ((tmpvar_6 + tmpvar_7), max (0.0, (tmpvar_6 - tmpvar_3)), tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = (tmpvar_8 * tmpvar_3);
  float tmpvar_11;
  tmpvar_11 = mix (tmpvar_7, max (0.0, (tmpvar_3 - tmpvar_6)), tmpvar_8);
  float tmpvar_12;
  tmpvar_12 = (tmpvar_5 / _Visibility);
  float tmpvar_13;
  tmpvar_13 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_9) * tmpvar_9) + tmpvar_12)));
  float tmpvar_14;
  tmpvar_14 = sqrt(((_DensityRatioZ * _DensityRatioZ) * tmpvar_12));
  float tmpvar_15;
  tmpvar_15 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_10) * tmpvar_10) + tmpvar_12)));
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_11) * tmpvar_11) + tmpvar_12)));
  color_2.w = (_Color.w * clamp ((((-((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_13 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_13) / _DensityRatioY)))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_14 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_14) / _DensityRatioY))))) + -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_15 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_15) / _DensityRatioY))))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_16 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_16) / _DensityRatioY))))), 0.0, 1.0));
  gl_FragData[0] = color_2;
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
// 12 instructions, 1 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkkccpabfaooigocpbhdnapgcmkmjmkdoabaaaaaafeadaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
baacaaaaeaaaabaaieaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaipccabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaa
abaaaaaaapaaaaaaaaaaaaakhccabaaaaeaaaaaaegiccaiaebaaaaaaaaaaaaaa
aeaaaaaaegiccaaaabaaaaaaapaaaaaadoaaaaab"
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 402
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 401
uniform highp float _DensityRatioPow;
#line 418
#line 425
v2f vert( in appdata_t v ) {
    #line 427
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 431
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 436
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
#line 409
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 402
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 401
uniform highp float _DensityRatioPow;
#line 418
#line 418
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 422
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 438
lowp vec4 frag( in v2f IN ) {
    #line 440
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    #line 444
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 449
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    #line 453
    highp float alt = length(IN.L);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    #line 457
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    #line 461
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 465
    color.w *= xll_saturate_f(depth);
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
varying vec3 xlv_TEXCOORD1;
uniform float _DensityRatioZ;
uniform float _DensityRatioY;
uniform float _DensityRatioX;
uniform float _OceanRadius;
uniform float _Visibility;
uniform vec4 _Color;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  float oceanSphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = dot (xlv_TEXCOORD5, normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos)));
  float tmpvar_4;
  tmpvar_4 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_3 * tmpvar_3)));
  float tmpvar_5;
  tmpvar_5 = pow (tmpvar_4, 2.0);
  oceanSphereDist_1 = 1e+32;
  if (((tmpvar_4 <= _OceanRadius) && (tmpvar_3 >= 0.0))) {
    oceanSphereDist_1 = (tmpvar_3 - sqrt(((_OceanRadius * _OceanRadius) - tmpvar_5)));
  };
  float tmpvar_6;
  tmpvar_6 = min (oceanSphereDist_1, 1e+32);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_5));
  float tmpvar_8;
  tmpvar_8 = clamp (floor((1.0 + tmpvar_3)), 0.0, 1.0);
  float tmpvar_9;
  tmpvar_9 = mix ((tmpvar_6 + tmpvar_7), max (0.0, (tmpvar_6 - tmpvar_3)), tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = (tmpvar_8 * tmpvar_3);
  float tmpvar_11;
  tmpvar_11 = mix (tmpvar_7, max (0.0, (tmpvar_3 - tmpvar_6)), tmpvar_8);
  float tmpvar_12;
  tmpvar_12 = (tmpvar_5 / _Visibility);
  float tmpvar_13;
  tmpvar_13 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_9) * tmpvar_9) + tmpvar_12)));
  float tmpvar_14;
  tmpvar_14 = sqrt(((_DensityRatioZ * _DensityRatioZ) * tmpvar_12));
  float tmpvar_15;
  tmpvar_15 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_10) * tmpvar_10) + tmpvar_12)));
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityRatioZ * _DensityRatioZ) * (((_Visibility * tmpvar_11) * tmpvar_11) + tmpvar_12)));
  color_2.w = (_Color.w * clamp ((((-((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_13 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_13) / _DensityRatioY)))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_14 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_14) / _DensityRatioY))))) + -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_15 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_15) / _DensityRatioY))))) - -((((((2.0 * _DensityRatioX) * _DensityRatioY) * (tmpvar_16 + _DensityRatioY)) * _DensityRatioX) * pow (2.71828, (-(tmpvar_16) / _DensityRatioY))))), 0.0, 1.0));
  gl_FragData[0] = color_2;
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
// 17 instructions, 2 temp regs, 0 temp arrays:
// ALU 12 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmbmaabppfajoopdpljojiolknadogilbabaaaaaaaeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckiacaaaaeaaaabaa
kkaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaaghccabaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaakhccabaaa
afaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaa
doaaaaab"
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 448
#line 434
v2f vert( in appdata_t v ) {
    #line 436
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 440
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 444
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 448
#line 427
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 431
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 448
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 452
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    #line 456
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        #line 460
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float alt = length(IN.L);
    #line 464
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    #line 468
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 472
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    color.w *= xll_saturate_f(depth);
    #line 476
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 448
#line 434
v2f vert( in appdata_t v ) {
    #line 436
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 440
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 444
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 448
#line 427
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 431
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 448
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 452
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    #line 456
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        #line 460
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float alt = length(IN.L);
    #line 464
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    #line 468
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 472
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    color.w *= xll_saturate_f(depth);
    #line 476
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 448
#line 434
v2f vert( in appdata_t v ) {
    #line 436
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 440
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 444
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 448
#line 427
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 431
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 448
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 452
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    #line 456
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        #line 460
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float alt = length(IN.L);
    #line 464
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    #line 468
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 472
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    color.w *= xll_saturate_f(depth);
    #line 476
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 448
#line 434
v2f vert( in appdata_t v ) {
    #line 436
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 440
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 444
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 448
#line 427
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 431
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 448
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 452
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    #line 456
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        #line 460
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float alt = length(IN.L);
    #line 464
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    #line 468
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 472
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    color.w *= xll_saturate_f(depth);
    #line 476
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 448
#line 434
v2f vert( in appdata_t v ) {
    #line 436
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 440
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    #line 444
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
#line 417
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 410
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
uniform highp float _DensityRatioX;
uniform highp float _DensityRatioY;
uniform highp float _DensityRatioZ;
#line 409
uniform highp float _DensityRatioPow;
#line 427
#line 448
#line 427
highp float atmofunc( in highp float l2, in highp float d2, in highp float a, in highp float b, in highp float c ) {
    highp float e = 2.71828;
    highp float c2 = (c * c);
    #line 431
    highp float n = sqrt((c2 * (l2 + d2)));
    return (-(((((2.0 * a) * b) * (n + b)) * a) * pow( e, ((-n) / b))));
}
#line 448
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 452
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    #line 456
    highp float oceanSphereDist = depth;
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        highp float tlc = sqrt(((_OceanRadius * _OceanRadius) - d2));
        #line 460
        oceanSphereDist = (tc - tlc);
    }
    depth = min( oceanSphereDist, depth);
    highp float alt = length(IN.L);
    #line 464
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float dist = sqrt(((depth * depth) - dot( td, td)));
    mediump float sphereCheck = xll_saturate_f(floor((1.0 + tc)));
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    #line 468
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    d2 /= _Visibility;
    depth = atmofunc( ((_Visibility * depthL) * depthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    #line 472
    depth -= atmofunc( 0.0, d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth += atmofunc( ((_Visibility * camL) * camL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    depth -= atmofunc( ((_Visibility * subDepthL) * subDepthL), d2, _DensityRatioX, _DensityRatioY, _DensityRatioZ);
    color.w *= xll_saturate_f(depth);
    #line 476
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
//   d3d9 - ALU: 98 to 100, TEX: 1 to 1
//   d3d11 - ALU: 73 to 74, TEX: 0 to 1, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_Color]
Float 3 [_Visibility]
Float 4 [_OceanRadius]
Float 5 [_DensityRatioX]
Float 6 [_DensityRatioY]
Float 7 [_DensityRatioZ]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 100 ALU, 1 TEX
dcl_2d s0
def c8, 1.00000000, 0.00000000, 2.71828175, 2.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord5 v2.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.x, v2, r1
dp3 r0.z, v2, v2
mad r0.x, -r2, r2, r0.z
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, r0.x, r0.x
mad r1.x, c4, c4, -r0.y
add r0.z, -r0.y, r0
rsq r0.z, r0.z
rcp r2.w, r0.z
add r0.x, -r0, c4
rsq r1.x, r1.x
rcp r1.x, r1.x
add r0.z, r2.x, c8.x
rcp r1.w, c6.x
add r1.x, r2, -r1
cmp r0.w, r2.x, c8.x, c8.y
cmp r0.x, r0, c8, c8.y
mul_pp r0.w, r0.x, r0
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rcp r0.x, r0.x
cmp r0.w, -r0, r0.x, r1.x
min r0.w, r0, r0.x
add r0.x, -r2, r0.w
add r1.y, r0.w, r2.w
max r1.x, r0, c8.y
frc r0.w, r0.z
add_sat r2.y, r0.z, -r0.w
add r1.x, r1, -r1.y
mad r0.w, r2.y, r1.x, r1.y
rcp r0.z, c3.x
mul r1.z, r0.y, r0
mul r0.y, r0.w, c3.x
max r0.x, -r0, c8.y
mul r1.y, c7.x, c7.x
mad r0.y, r0, r0.w, r1.z
mul r0.y, r1, r0
rsq r0.y, r0.y
rcp r0.z, r0.y
mov r0.y, c5.x
mul r1.x, c6, r0.y
add r0.w, r0.z, c6.x
mul r0.y, r1.x, r0.w
add r3.y, -r2.w, r0.x
mul r2.x, r2.y, r2
mul r3.x, r1.w, -r0.z
mul r2.z, r0.y, c5.x
pow r0, c8.z, r3.x
mad r0.y, r2, r3, r2.w
mul r0.z, r0.y, c3.x
mad r0.y, r0.z, r0, r1.z
mov r3.x, r0
mul r0.x, r1.y, r1.z
mul r0.y, r1, r0
rsq r0.x, r0.x
rcp r3.z, r0.x
rsq r0.y, r0.y
rcp r2.w, r0.y
add r3.y, r2.w, c6.x
mul r3.w, r1, -r3.z
pow r0, c8.z, r3.w
add r0.y, r3.z, c6.x
mov r0.z, r0.x
mul r0.y, r1.x, r0
mul r0.x, r0.y, c5
mul r0.x, r0, r0.z
mad r2.z, -r2, r3.x, r0.x
mul r0.y, r1.x, r3
mul r3.x, r0.y, c5
mul r2.w, r1, -r2
pow r0, c8.z, r2.w
mul r2.y, r2.x, c3.x
mad r0.y, r2, r2.x, r1.z
mul r0.y, r1, r0
mov r0.z, r0.x
rsq r0.x, r0.y
rcp r0.x, r0.x
mul r0.y, r3.x, r0.z
mul r2.x, r0.y, c8.w
add r1.y, r0.x, c6.x
mul r1.z, -r0.x, r1.w
pow r0, c8.z, r1.z
mul r0.y, r1.x, r1
mul r0.y, r0, c5.x
mad r0.x, -r0.y, r0, r2.z
mad_sat r0.x, r0, c8.w, r2
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 120 used size, 13 vars
Vector 48 [_Color] 4
Float 80 [_Visibility]
Float 84 [_OceanRadius]
Float 108 [_DensityRatioX]
Float 112 [_DensityRatioY]
Float 116 [_DensityRatioZ]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 78 instructions, 3 temp regs, 0 temp arrays:
// ALU 73 float, 0 int, 1 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedddmmgdoeginpdohfockodpaepaoceglhabaaaaaamiakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmaajaaaaeaaaaaaahaacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
aaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaabaaaaaahccaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabnaaaaai
bcaabaaaabaaaaaabkiacaaaaaaaaaaaafaaaaaadkaabaaaaaaaaaaabnaaaaah
ccaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaabaaaaahbcaabaaa
abaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaamicaabaaa
aaaaaaaabkiacaaaaaaaaaaaafaaaaaabkiacaaaaaaaaaaaafaaaaaabkaabaia
ebaaaaaaabaaaaaaaoaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaa
aaaaaaaaafaaaaaaelaaaaafkcaabaaaaaaaaaaafganbaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadhaaaaaj
icaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaah
bcaabaaaabaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadeaaaaakjcaabaaa
aaaaaaaaagambaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaibcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadkaabaaaaaaaaaaa
aaaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpebcaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaa
abaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakiacaaaaaaaaaaaafaaaaaabkaabaaaabaaaaaadiaaaaajbcaabaaa
abaaaaaabkiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaoaaaaajicaabaaaabaaaaaadkaabaiaebaaaaaa
aaaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
apaaaaajbcaabaaaacaaaaaaagiacaaaaaaaaaaaahaaaaaapgipcaaaaaaaaaaa
agaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaaelaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaaaoaaaaajccaabaaaacaaaaaadkaabaiaebaaaaaa
abaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaaa
abaaaaaaakiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaagaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaa
abeaaaaadlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaak
icaabaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaacaaaaaadkaabaiaebaaaaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaa
dcaaaaajbcaabaaaaaaaaaaackaabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaigaabaaaaaaaaaaaigaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaa
bkaabaaaabaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaabkaabaaaabaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaagaabaaaabaaaaaaelaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aoaaaaajecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaajecaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadccaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaadoaaaaab"
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
Vector 2 [_Color]
Float 3 [_Visibility]
Float 4 [_OceanRadius]
Float 5 [_DensityRatioX]
Float 6 [_DensityRatioY]
Float 7 [_DensityRatioZ]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 100 ALU, 1 TEX
dcl_2d s0
def c8, 1.00000000, 0.00000000, 2.71828175, 2.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord5 v2.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.x, v2, r1
dp3 r0.z, v2, v2
mad r0.x, -r2, r2, r0.z
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, r0.x, r0.x
mad r1.x, c4, c4, -r0.y
add r0.z, -r0.y, r0
rsq r0.z, r0.z
rcp r2.w, r0.z
add r0.x, -r0, c4
rsq r1.x, r1.x
rcp r1.x, r1.x
add r0.z, r2.x, c8.x
rcp r1.w, c6.x
add r1.x, r2, -r1
cmp r0.w, r2.x, c8.x, c8.y
cmp r0.x, r0, c8, c8.y
mul_pp r0.w, r0.x, r0
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rcp r0.x, r0.x
cmp r0.w, -r0, r0.x, r1.x
min r0.w, r0, r0.x
add r0.x, -r2, r0.w
add r1.y, r0.w, r2.w
max r1.x, r0, c8.y
frc r0.w, r0.z
add_sat r2.y, r0.z, -r0.w
add r1.x, r1, -r1.y
mad r0.w, r2.y, r1.x, r1.y
rcp r0.z, c3.x
mul r1.z, r0.y, r0
mul r0.y, r0.w, c3.x
max r0.x, -r0, c8.y
mul r1.y, c7.x, c7.x
mad r0.y, r0, r0.w, r1.z
mul r0.y, r1, r0
rsq r0.y, r0.y
rcp r0.z, r0.y
mov r0.y, c5.x
mul r1.x, c6, r0.y
add r0.w, r0.z, c6.x
mul r0.y, r1.x, r0.w
add r3.y, -r2.w, r0.x
mul r2.x, r2.y, r2
mul r3.x, r1.w, -r0.z
mul r2.z, r0.y, c5.x
pow r0, c8.z, r3.x
mad r0.y, r2, r3, r2.w
mul r0.z, r0.y, c3.x
mad r0.y, r0.z, r0, r1.z
mov r3.x, r0
mul r0.x, r1.y, r1.z
mul r0.y, r1, r0
rsq r0.x, r0.x
rcp r3.z, r0.x
rsq r0.y, r0.y
rcp r2.w, r0.y
add r3.y, r2.w, c6.x
mul r3.w, r1, -r3.z
pow r0, c8.z, r3.w
add r0.y, r3.z, c6.x
mov r0.z, r0.x
mul r0.y, r1.x, r0
mul r0.x, r0.y, c5
mul r0.x, r0, r0.z
mad r2.z, -r2, r3.x, r0.x
mul r0.y, r1.x, r3
mul r3.x, r0.y, c5
mul r2.w, r1, -r2
pow r0, c8.z, r2.w
mul r2.y, r2.x, c3.x
mad r0.y, r2, r2.x, r1.z
mul r0.y, r1, r0
mov r0.z, r0.x
rsq r0.x, r0.y
rcp r0.x, r0.x
mul r0.y, r3.x, r0.z
mul r2.x, r0.y, c8.w
add r1.y, r0.x, c6.x
mul r1.z, -r0.x, r1.w
pow r0, c8.z, r1.z
mul r0.y, r1.x, r1
mul r0.y, r0, c5.x
mad r0.x, -r0.y, r0, r2.z
mad_sat r0.x, r0, c8.w, r2
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 120 used size, 13 vars
Vector 48 [_Color] 4
Float 80 [_Visibility]
Float 84 [_OceanRadius]
Float 108 [_DensityRatioX]
Float 112 [_DensityRatioY]
Float 116 [_DensityRatioZ]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 78 instructions, 3 temp regs, 0 temp arrays:
// ALU 73 float, 0 int, 1 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedddmmgdoeginpdohfockodpaepaoceglhabaaaaaamiakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmaajaaaaeaaaaaaahaacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
aaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaabaaaaaahccaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabnaaaaai
bcaabaaaabaaaaaabkiacaaaaaaaaaaaafaaaaaadkaabaaaaaaaaaaabnaaaaah
ccaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaabaaaaahbcaabaaa
abaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaamicaabaaa
aaaaaaaabkiacaaaaaaaaaaaafaaaaaabkiacaaaaaaaaaaaafaaaaaabkaabaia
ebaaaaaaabaaaaaaaoaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaa
aaaaaaaaafaaaaaaelaaaaafkcaabaaaaaaaaaaafganbaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadhaaaaaj
icaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaah
bcaabaaaabaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadeaaaaakjcaabaaa
aaaaaaaaagambaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaibcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadkaabaaaaaaaaaaa
aaaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpebcaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaa
abaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakiacaaaaaaaaaaaafaaaaaabkaabaaaabaaaaaadiaaaaajbcaabaaa
abaaaaaabkiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaoaaaaajicaabaaaabaaaaaadkaabaiaebaaaaaa
aaaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
apaaaaajbcaabaaaacaaaaaaagiacaaaaaaaaaaaahaaaaaapgipcaaaaaaaaaaa
agaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaaelaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaaaoaaaaajccaabaaaacaaaaaadkaabaiaebaaaaaa
abaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaaa
abaaaaaaakiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaagaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaa
abeaaaaadlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaak
icaabaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaacaaaaaadkaabaiaebaaaaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaa
dcaaaaajbcaabaaaaaaaaaaackaabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaigaabaaaaaaaaaaaigaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaa
bkaabaaaabaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaabkaabaaaabaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaagaabaaaabaaaaaaelaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aoaaaaajecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaajecaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadccaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaadoaaaaab"
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
Vector 2 [_Color]
Float 3 [_Visibility]
Float 4 [_OceanRadius]
Float 5 [_DensityRatioX]
Float 6 [_DensityRatioY]
Float 7 [_DensityRatioZ]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 100 ALU, 1 TEX
dcl_2d s0
def c8, 1.00000000, 0.00000000, 2.71828175, 2.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord5 v2.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.x, v2, r1
dp3 r0.z, v2, v2
mad r0.x, -r2, r2, r0.z
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, r0.x, r0.x
mad r1.x, c4, c4, -r0.y
add r0.z, -r0.y, r0
rsq r0.z, r0.z
rcp r2.w, r0.z
add r0.x, -r0, c4
rsq r1.x, r1.x
rcp r1.x, r1.x
add r0.z, r2.x, c8.x
rcp r1.w, c6.x
add r1.x, r2, -r1
cmp r0.w, r2.x, c8.x, c8.y
cmp r0.x, r0, c8, c8.y
mul_pp r0.w, r0.x, r0
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rcp r0.x, r0.x
cmp r0.w, -r0, r0.x, r1.x
min r0.w, r0, r0.x
add r0.x, -r2, r0.w
add r1.y, r0.w, r2.w
max r1.x, r0, c8.y
frc r0.w, r0.z
add_sat r2.y, r0.z, -r0.w
add r1.x, r1, -r1.y
mad r0.w, r2.y, r1.x, r1.y
rcp r0.z, c3.x
mul r1.z, r0.y, r0
mul r0.y, r0.w, c3.x
max r0.x, -r0, c8.y
mul r1.y, c7.x, c7.x
mad r0.y, r0, r0.w, r1.z
mul r0.y, r1, r0
rsq r0.y, r0.y
rcp r0.z, r0.y
mov r0.y, c5.x
mul r1.x, c6, r0.y
add r0.w, r0.z, c6.x
mul r0.y, r1.x, r0.w
add r3.y, -r2.w, r0.x
mul r2.x, r2.y, r2
mul r3.x, r1.w, -r0.z
mul r2.z, r0.y, c5.x
pow r0, c8.z, r3.x
mad r0.y, r2, r3, r2.w
mul r0.z, r0.y, c3.x
mad r0.y, r0.z, r0, r1.z
mov r3.x, r0
mul r0.x, r1.y, r1.z
mul r0.y, r1, r0
rsq r0.x, r0.x
rcp r3.z, r0.x
rsq r0.y, r0.y
rcp r2.w, r0.y
add r3.y, r2.w, c6.x
mul r3.w, r1, -r3.z
pow r0, c8.z, r3.w
add r0.y, r3.z, c6.x
mov r0.z, r0.x
mul r0.y, r1.x, r0
mul r0.x, r0.y, c5
mul r0.x, r0, r0.z
mad r2.z, -r2, r3.x, r0.x
mul r0.y, r1.x, r3
mul r3.x, r0.y, c5
mul r2.w, r1, -r2
pow r0, c8.z, r2.w
mul r2.y, r2.x, c3.x
mad r0.y, r2, r2.x, r1.z
mul r0.y, r1, r0
mov r0.z, r0.x
rsq r0.x, r0.y
rcp r0.x, r0.x
mul r0.y, r3.x, r0.z
mul r2.x, r0.y, c8.w
add r1.y, r0.x, c6.x
mul r1.z, -r0.x, r1.w
pow r0, c8.z, r1.z
mul r0.y, r1.x, r1
mul r0.y, r0, c5.x
mad r0.x, -r0.y, r0, r2.z
mad_sat r0.x, r0, c8.w, r2
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 120 used size, 13 vars
Vector 48 [_Color] 4
Float 80 [_Visibility]
Float 84 [_OceanRadius]
Float 108 [_DensityRatioX]
Float 112 [_DensityRatioY]
Float 116 [_DensityRatioZ]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 78 instructions, 3 temp regs, 0 temp arrays:
// ALU 73 float, 0 int, 1 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedddmmgdoeginpdohfockodpaepaoceglhabaaaaaamiakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmaajaaaaeaaaaaaahaacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
aaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaabaaaaaahccaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabnaaaaai
bcaabaaaabaaaaaabkiacaaaaaaaaaaaafaaaaaadkaabaaaaaaaaaaabnaaaaah
ccaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaabaaaaahbcaabaaa
abaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaamicaabaaa
aaaaaaaabkiacaaaaaaaaaaaafaaaaaabkiacaaaaaaaaaaaafaaaaaabkaabaia
ebaaaaaaabaaaaaaaoaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaa
aaaaaaaaafaaaaaaelaaaaafkcaabaaaaaaaaaaafganbaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadhaaaaaj
icaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaah
bcaabaaaabaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadeaaaaakjcaabaaa
aaaaaaaaagambaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaibcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadkaabaaaaaaaaaaa
aaaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpebcaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaa
abaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakiacaaaaaaaaaaaafaaaaaabkaabaaaabaaaaaadiaaaaajbcaabaaa
abaaaaaabkiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaoaaaaajicaabaaaabaaaaaadkaabaiaebaaaaaa
aaaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
apaaaaajbcaabaaaacaaaaaaagiacaaaaaaaaaaaahaaaaaapgipcaaaaaaaaaaa
agaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaaelaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaaaoaaaaajccaabaaaacaaaaaadkaabaiaebaaaaaa
abaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaaa
abaaaaaaakiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaagaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaa
abeaaaaadlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaak
icaabaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaacaaaaaadkaabaiaebaaaaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaa
dcaaaaajbcaabaaaaaaaaaaackaabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaigaabaaaaaaaaaaaigaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaa
bkaabaaaabaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaabkaabaaaabaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaagaabaaaabaaaaaaelaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aoaaaaajecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaajecaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadccaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaadoaaaaab"
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
Vector 2 [_Color]
Float 3 [_Visibility]
Float 4 [_OceanRadius]
Float 5 [_DensityRatioX]
Float 6 [_DensityRatioY]
Float 7 [_DensityRatioZ]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 100 ALU, 1 TEX
dcl_2d s0
def c8, 1.00000000, 0.00000000, 2.71828175, 2.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord5 v2.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.x, v2, r1
dp3 r0.z, v2, v2
mad r0.x, -r2, r2, r0.z
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, r0.x, r0.x
mad r1.x, c4, c4, -r0.y
add r0.z, -r0.y, r0
rsq r0.z, r0.z
rcp r2.w, r0.z
add r0.x, -r0, c4
rsq r1.x, r1.x
rcp r1.x, r1.x
add r0.z, r2.x, c8.x
rcp r1.w, c6.x
add r1.x, r2, -r1
cmp r0.w, r2.x, c8.x, c8.y
cmp r0.x, r0, c8, c8.y
mul_pp r0.w, r0.x, r0
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rcp r0.x, r0.x
cmp r0.w, -r0, r0.x, r1.x
min r0.w, r0, r0.x
add r0.x, -r2, r0.w
add r1.y, r0.w, r2.w
max r1.x, r0, c8.y
frc r0.w, r0.z
add_sat r2.y, r0.z, -r0.w
add r1.x, r1, -r1.y
mad r0.w, r2.y, r1.x, r1.y
rcp r0.z, c3.x
mul r1.z, r0.y, r0
mul r0.y, r0.w, c3.x
max r0.x, -r0, c8.y
mul r1.y, c7.x, c7.x
mad r0.y, r0, r0.w, r1.z
mul r0.y, r1, r0
rsq r0.y, r0.y
rcp r0.z, r0.y
mov r0.y, c5.x
mul r1.x, c6, r0.y
add r0.w, r0.z, c6.x
mul r0.y, r1.x, r0.w
add r3.y, -r2.w, r0.x
mul r2.x, r2.y, r2
mul r3.x, r1.w, -r0.z
mul r2.z, r0.y, c5.x
pow r0, c8.z, r3.x
mad r0.y, r2, r3, r2.w
mul r0.z, r0.y, c3.x
mad r0.y, r0.z, r0, r1.z
mov r3.x, r0
mul r0.x, r1.y, r1.z
mul r0.y, r1, r0
rsq r0.x, r0.x
rcp r3.z, r0.x
rsq r0.y, r0.y
rcp r2.w, r0.y
add r3.y, r2.w, c6.x
mul r3.w, r1, -r3.z
pow r0, c8.z, r3.w
add r0.y, r3.z, c6.x
mov r0.z, r0.x
mul r0.y, r1.x, r0
mul r0.x, r0.y, c5
mul r0.x, r0, r0.z
mad r2.z, -r2, r3.x, r0.x
mul r0.y, r1.x, r3
mul r3.x, r0.y, c5
mul r2.w, r1, -r2
pow r0, c8.z, r2.w
mul r2.y, r2.x, c3.x
mad r0.y, r2, r2.x, r1.z
mul r0.y, r1, r0
mov r0.z, r0.x
rsq r0.x, r0.y
rcp r0.x, r0.x
mul r0.y, r3.x, r0.z
mul r2.x, r0.y, c8.w
add r1.y, r0.x, c6.x
mul r1.z, -r0.x, r1.w
pow r0, c8.z, r1.z
mul r0.y, r1.x, r1
mul r0.y, r0, c5.x
mad r0.x, -r0.y, r0, r2.z
mad_sat r0.x, r0, c8.w, r2
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 184 used size, 14 vars
Vector 112 [_Color] 4
Float 144 [_Visibility]
Float 148 [_OceanRadius]
Float 172 [_DensityRatioX]
Float 176 [_DensityRatioY]
Float 180 [_DensityRatioZ]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 78 instructions, 3 temp regs, 0 temp arrays:
// ALU 73 float, 0 int, 1 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedlgmobianlkkaiohpbmndlidmndhdohbnabaaaaaaoaakaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmaajaaaa
eaaaaaaahaacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
ecaabaaaaaaaaaaaegbcbaaaafaaaaaaegacbaaaabaaaaaadcaaaaakicaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
elaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabnaaaaaibcaabaaaabaaaaaa
bkiacaaaaaaaaaaaajaaaaaadkaabaaaaaaaaaaabnaaaaahccaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaaabaaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaamicaabaaaaaaaaaaabkiacaaa
aaaaaaaaajaaaaaabkiacaaaaaaaaaaaajaaaaaabkaabaiaebaaaaaaabaaaaaa
aoaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaajaaaaaa
elaaaaafkcaabaaaaaaaaaaafganbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadhaaaaajicaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaadeaaaaakjcaabaaaaaaaaaaaagambaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiicaabaaa
aaaaaaaaakaabaiaebaaaaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahecaabaaa
abaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpebcaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaa
aaaaaaaaajaaaaaabkaabaaaabaaaaaadiaaaaajbcaabaaaabaaaaaabkiacaaa
aaaaaaaaalaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaaoaaaaajicaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaaakiacaaa
aaaaaaaaalaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaa
aaaaaaaaalaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
dlkklidpbjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaapaaaaajbcaabaaa
acaaaaaaagiacaaaaaaaaaaaalaaaaaapgipcaaaaaaaaaaaakaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaaaoaaaaajccaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaakiacaaa
aaaaaaaaalaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaaakiacaaa
aaaaaaaaalaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
acaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaa
akaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaadlkklidp
bjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaaaabaaaaaabkaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaa
aaaaaaaackaabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
dcaabaaaaaaaaaaaigaabaaaaaaaaaaaigaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaabkaabaaaabaaaaaa
dcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaa
bkaabaaaabaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaagaabaaa
abaaaaaaelaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaajecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaajecaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaaaaaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaakaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
dccaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
ahaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab
"
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
Vector 2 [_Color]
Float 3 [_Visibility]
Float 4 [_OceanRadius]
Float 5 [_DensityRatioX]
Float 6 [_DensityRatioY]
Float 7 [_DensityRatioZ]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 100 ALU, 1 TEX
dcl_2d s0
def c8, 1.00000000, 0.00000000, 2.71828175, 2.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord5 v2.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.x, v2, r1
dp3 r0.z, v2, v2
mad r0.x, -r2, r2, r0.z
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, r0.x, r0.x
mad r1.x, c4, c4, -r0.y
add r0.z, -r0.y, r0
rsq r0.z, r0.z
rcp r2.w, r0.z
add r0.x, -r0, c4
rsq r1.x, r1.x
rcp r1.x, r1.x
add r0.z, r2.x, c8.x
rcp r1.w, c6.x
add r1.x, r2, -r1
cmp r0.w, r2.x, c8.x, c8.y
cmp r0.x, r0, c8, c8.y
mul_pp r0.w, r0.x, r0
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rcp r0.x, r0.x
cmp r0.w, -r0, r0.x, r1.x
min r0.w, r0, r0.x
add r0.x, -r2, r0.w
add r1.y, r0.w, r2.w
max r1.x, r0, c8.y
frc r0.w, r0.z
add_sat r2.y, r0.z, -r0.w
add r1.x, r1, -r1.y
mad r0.w, r2.y, r1.x, r1.y
rcp r0.z, c3.x
mul r1.z, r0.y, r0
mul r0.y, r0.w, c3.x
max r0.x, -r0, c8.y
mul r1.y, c7.x, c7.x
mad r0.y, r0, r0.w, r1.z
mul r0.y, r1, r0
rsq r0.y, r0.y
rcp r0.z, r0.y
mov r0.y, c5.x
mul r1.x, c6, r0.y
add r0.w, r0.z, c6.x
mul r0.y, r1.x, r0.w
add r3.y, -r2.w, r0.x
mul r2.x, r2.y, r2
mul r3.x, r1.w, -r0.z
mul r2.z, r0.y, c5.x
pow r0, c8.z, r3.x
mad r0.y, r2, r3, r2.w
mul r0.z, r0.y, c3.x
mad r0.y, r0.z, r0, r1.z
mov r3.x, r0
mul r0.x, r1.y, r1.z
mul r0.y, r1, r0
rsq r0.x, r0.x
rcp r3.z, r0.x
rsq r0.y, r0.y
rcp r2.w, r0.y
add r3.y, r2.w, c6.x
mul r3.w, r1, -r3.z
pow r0, c8.z, r3.w
add r0.y, r3.z, c6.x
mov r0.z, r0.x
mul r0.y, r1.x, r0
mul r0.x, r0.y, c5
mul r0.x, r0, r0.z
mad r2.z, -r2, r3.x, r0.x
mul r0.y, r1.x, r3
mul r3.x, r0.y, c5
mul r2.w, r1, -r2
pow r0, c8.z, r2.w
mul r2.y, r2.x, c3.x
mad r0.y, r2, r2.x, r1.z
mul r0.y, r1, r0
mov r0.z, r0.x
rsq r0.x, r0.y
rcp r0.x, r0.x
mul r0.y, r3.x, r0.z
mul r2.x, r0.y, c8.w
add r1.y, r0.x, c6.x
mul r1.z, -r0.x, r1.w
pow r0, c8.z, r1.z
mul r0.y, r1.x, r1
mul r0.y, r0, c5.x
mad r0.x, -r0.y, r0, r2.z
mad_sat r0.x, r0, c8.w, r2
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 184 used size, 14 vars
Vector 112 [_Color] 4
Float 144 [_Visibility]
Float 148 [_OceanRadius]
Float 172 [_DensityRatioX]
Float 176 [_DensityRatioY]
Float 180 [_DensityRatioZ]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 78 instructions, 3 temp regs, 0 temp arrays:
// ALU 73 float, 0 int, 1 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedlgmobianlkkaiohpbmndlidmndhdohbnabaaaaaaoaakaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmaajaaaa
eaaaaaaahaacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
ecaabaaaaaaaaaaaegbcbaaaafaaaaaaegacbaaaabaaaaaadcaaaaakicaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
elaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabnaaaaaibcaabaaaabaaaaaa
bkiacaaaaaaaaaaaajaaaaaadkaabaaaaaaaaaaabnaaaaahccaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaaabaaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaamicaabaaaaaaaaaaabkiacaaa
aaaaaaaaajaaaaaabkiacaaaaaaaaaaaajaaaaaabkaabaiaebaaaaaaabaaaaaa
aoaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaajaaaaaa
elaaaaafkcaabaaaaaaaaaaafganbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadhaaaaajicaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaadeaaaaakjcaabaaaaaaaaaaaagambaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiicaabaaa
aaaaaaaaakaabaiaebaaaaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahecaabaaa
abaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpebcaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaa
aaaaaaaaajaaaaaabkaabaaaabaaaaaadiaaaaajbcaabaaaabaaaaaabkiacaaa
aaaaaaaaalaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaaoaaaaajicaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaaakiacaaa
aaaaaaaaalaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaa
aaaaaaaaalaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
dlkklidpbjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaapaaaaajbcaabaaa
acaaaaaaagiacaaaaaaaaaaaalaaaaaapgipcaaaaaaaaaaaakaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaaaoaaaaajccaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaakiacaaa
aaaaaaaaalaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaaakiacaaa
aaaaaaaaalaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
acaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaa
akaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaadlkklidp
bjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaaaabaaaaaabkaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaa
aaaaaaaackaabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
dcaabaaaaaaaaaaaigaabaaaaaaaaaaaigaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaabkaabaaaabaaaaaa
dcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaa
bkaabaaaabaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaagaabaaa
abaaaaaaelaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaajecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaajecaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaaaaaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaakaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
dccaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
ahaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab
"
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
Vector 2 [_Color]
Float 3 [_Visibility]
Float 4 [_OceanRadius]
Float 5 [_DensityRatioX]
Float 6 [_DensityRatioY]
Float 7 [_DensityRatioZ]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 100 ALU, 1 TEX
dcl_2d s0
def c8, 1.00000000, 0.00000000, 2.71828175, 2.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord5 v2.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.x, v2, r1
dp3 r0.z, v2, v2
mad r0.x, -r2, r2, r0.z
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, r0.x, r0.x
mad r1.x, c4, c4, -r0.y
add r0.z, -r0.y, r0
rsq r0.z, r0.z
rcp r2.w, r0.z
add r0.x, -r0, c4
rsq r1.x, r1.x
rcp r1.x, r1.x
add r0.z, r2.x, c8.x
rcp r1.w, c6.x
add r1.x, r2, -r1
cmp r0.w, r2.x, c8.x, c8.y
cmp r0.x, r0, c8, c8.y
mul_pp r0.w, r0.x, r0
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rcp r0.x, r0.x
cmp r0.w, -r0, r0.x, r1.x
min r0.w, r0, r0.x
add r0.x, -r2, r0.w
add r1.y, r0.w, r2.w
max r1.x, r0, c8.y
frc r0.w, r0.z
add_sat r2.y, r0.z, -r0.w
add r1.x, r1, -r1.y
mad r0.w, r2.y, r1.x, r1.y
rcp r0.z, c3.x
mul r1.z, r0.y, r0
mul r0.y, r0.w, c3.x
max r0.x, -r0, c8.y
mul r1.y, c7.x, c7.x
mad r0.y, r0, r0.w, r1.z
mul r0.y, r1, r0
rsq r0.y, r0.y
rcp r0.z, r0.y
mov r0.y, c5.x
mul r1.x, c6, r0.y
add r0.w, r0.z, c6.x
mul r0.y, r1.x, r0.w
add r3.y, -r2.w, r0.x
mul r2.x, r2.y, r2
mul r3.x, r1.w, -r0.z
mul r2.z, r0.y, c5.x
pow r0, c8.z, r3.x
mad r0.y, r2, r3, r2.w
mul r0.z, r0.y, c3.x
mad r0.y, r0.z, r0, r1.z
mov r3.x, r0
mul r0.x, r1.y, r1.z
mul r0.y, r1, r0
rsq r0.x, r0.x
rcp r3.z, r0.x
rsq r0.y, r0.y
rcp r2.w, r0.y
add r3.y, r2.w, c6.x
mul r3.w, r1, -r3.z
pow r0, c8.z, r3.w
add r0.y, r3.z, c6.x
mov r0.z, r0.x
mul r0.y, r1.x, r0
mul r0.x, r0.y, c5
mul r0.x, r0, r0.z
mad r2.z, -r2, r3.x, r0.x
mul r0.y, r1.x, r3
mul r3.x, r0.y, c5
mul r2.w, r1, -r2
pow r0, c8.z, r2.w
mul r2.y, r2.x, c3.x
mad r0.y, r2, r2.x, r1.z
mul r0.y, r1, r0
mov r0.z, r0.x
rsq r0.x, r0.y
rcp r0.x, r0.x
mul r0.y, r3.x, r0.z
mul r2.x, r0.y, c8.w
add r1.y, r0.x, c6.x
mul r1.z, -r0.x, r1.w
pow r0, c8.z, r1.z
mul r0.y, r1.x, r1
mul r0.y, r0, c5.x
mad r0.x, -r0.y, r0, r2.z
mad_sat r0.x, r0, c8.w, r2
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 184 used size, 14 vars
Vector 112 [_Color] 4
Float 144 [_Visibility]
Float 148 [_OceanRadius]
Float 172 [_DensityRatioX]
Float 176 [_DensityRatioY]
Float 180 [_DensityRatioZ]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 78 instructions, 3 temp regs, 0 temp arrays:
// ALU 73 float, 0 int, 1 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedlgmobianlkkaiohpbmndlidmndhdohbnabaaaaaaoaakaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmaajaaaa
eaaaaaaahaacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
ecaabaaaaaaaaaaaegbcbaaaafaaaaaaegacbaaaabaaaaaadcaaaaakicaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
elaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaabnaaaaaibcaabaaaabaaaaaa
bkiacaaaaaaaaaaaajaaaaaadkaabaaaaaaaaaaabnaaaaahccaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaaabaaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaamicaabaaaaaaaaaaabkiacaaa
aaaaaaaaajaaaaaabkiacaaaaaaaaaaaajaaaaaabkaabaiaebaaaaaaabaaaaaa
aoaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaajaaaaaa
elaaaaafkcaabaaaaaaaaaaafganbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadhaaaaajicaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaadeaaaaakjcaabaaaaaaaaaaaagambaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiicaabaaa
aaaaaaaaakaabaiaebaaaaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahecaabaaa
abaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpebcaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaa
aaaaaaaaajaaaaaabkaabaaaabaaaaaadiaaaaajbcaabaaaabaaaaaabkiacaaa
aaaaaaaaalaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaaoaaaaajicaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaaakiacaaa
aaaaaaaaalaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaa
aaaaaaaaalaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
dlkklidpbjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaapaaaaajbcaabaaa
acaaaaaaagiacaaaaaaaaaaaalaaaaaapgipcaaaaaaaaaaaakaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaaaoaaaaajccaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaakiacaaa
aaaaaaaaalaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaaakiacaaa
aaaaaaaaalaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
acaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaa
akaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaadlkklidp
bjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaaaabaaaaaabkaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaa
aaaaaaaackaabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
dcaabaaaaaaaaaaaigaabaaaaaaaaaaaigaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaabkaabaaaabaaaaaa
dcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaa
bkaabaaaabaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaagaabaaa
abaaaaaaelaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaajecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaajecaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaaaaaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaakaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
dccaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
ahaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab
"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_Color]
Float 2 [_Visibility]
Float 3 [_OceanRadius]
Float 4 [_DensityRatioX]
Float 5 [_DensityRatioY]
Float 6 [_DensityRatioZ]
"ps_3_0
; 98 ALU
def c7, 1.00000000, 0.00000000, 2.71828175, 100000003318135350000000000000000.00000000
def c8, 2.00000000, 0, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord5 v1.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.x, v1, r1
dp3 r0.y, v1, v1
mad r0.x, -r2, r2, r0.y
rsq r0.x, r0.x
rcp r0.z, r0.x
mul r0.x, r0.z, r0.z
mad r0.w, c3.x, c3.x, -r0.x
rsq r0.w, r0.w
rcp r0.w, r0.w
add r1.x, r2, -r0.w
add r0.z, -r0, c3.x
rcp r1.w, c5.x
cmp r0.w, r2.x, c7.x, c7.y
cmp r0.z, r0, c7.x, c7.y
mul_pp r0.z, r0, r0.w
cmp r0.z, -r0, c7.w, r1.x
min r0.w, r0.z, c7
add r0.z, -r0.x, r0.y
add r0.y, -r2.x, r0.w
rsq r0.z, r0.z
rcp r2.w, r0.z
add r1.y, r0.w, r2.w
add r0.z, r2.x, c7.x
frc r0.w, r0.z
add_sat r2.y, r0.z, -r0.w
max r1.x, r0.y, c7.y
add r1.x, r1, -r1.y
mad r0.w, r2.y, r1.x, r1.y
rcp r0.z, c2.x
mul r1.z, r0.x, r0
mul r0.x, r0.w, c2
mul r1.y, c6.x, c6.x
mad r0.x, r0, r0.w, r1.z
mul r0.x, r1.y, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
mov r0.x, c4
mul r1.x, c5, r0
add r0.w, r0.z, c5.x
mul r0.x, r1, r0.w
mul r2.z, r0.x, c4.x
max r0.x, -r0.y, c7.y
add r3.y, -r2.w, r0.x
mul r3.x, r1.w, -r0.z
pow r0, c7.z, r3.x
mad r0.y, r2, r3, r2.w
mul r2.x, r2.y, r2
mul r0.z, r0.y, c2.x
mad r0.y, r0.z, r0, r1.z
mov r3.x, r0
mul r0.x, r1.y, r1.z
mul r0.y, r1, r0
rsq r0.x, r0.x
rcp r3.z, r0.x
rsq r0.y, r0.y
rcp r2.w, r0.y
add r3.y, r2.w, c5.x
mul r3.w, r1, -r3.z
pow r0, c7.z, r3.w
add r0.y, r3.z, c5.x
mov r0.z, r0.x
mul r0.y, r1.x, r0
mul r0.x, r0.y, c4
mul r0.x, r0, r0.z
mad r2.z, -r2, r3.x, r0.x
mul r0.y, r1.x, r3
mul r3.x, r0.y, c4
mul r2.w, r1, -r2
pow r0, c7.z, r2.w
mul r2.y, r2.x, c2.x
mad r0.y, r2, r2.x, r1.z
mul r0.y, r1, r0
mov r0.z, r0.x
rsq r0.x, r0.y
rcp r0.x, r0.x
mul r0.y, r3.x, r0.z
mul r2.x, r0.y, c8
add r1.y, r0.x, c5.x
mul r1.z, -r0.x, r1.w
pow r0, c7.z, r1.z
mul r0.y, r1.x, r1
mul r0.y, r0, c4.x
mad r0.x, -r0.y, r0, r2.z
mad_sat r0.x, r0, c8, r2
mul_pp oC0.w, r0.x, c1
mov_pp oC0.xyz, c1
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 120 used size, 13 vars
Vector 48 [_Color] 4
Float 80 [_Visibility]
Float 84 [_OceanRadius]
Float 108 [_DensityRatioX]
Float 112 [_DensityRatioY]
Float 116 [_DensityRatioZ]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
// 76 instructions, 3 temp regs, 0 temp arrays:
// ALU 72 float, 0 int, 1 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkkmkekapipfjkldccofbphihcijeapglabaaaaaadaakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcciajaaaaeaaaaaaaekacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaaaaaaaajocaabaaa
aaaaaaaaagbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
bcaabaaaabaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agaabaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaaeaaaaaajgahbaaa
aaaaaaaadcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaam
bcaabaaaabaaaaaabkiacaaaaaaaaaaaafaaaaaabkiacaaaaaaaaaaaafaaaaaa
dkaabaiaebaaaaaaaaaaaaaaaoaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akiacaaaaaaaaaaaafaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaa
ddaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaakomfjnhebnaaaaah
ccaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaabnaaaaaiecaabaaa
abaaaaaabkiacaaaaaaaaaaaafaaaaaackaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabaaaaahecaabaaaaaaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaadhaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaaabeaaaaakomfjnheaaaaaaaibcaabaaaabaaaaaa
bkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadeaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaabkaabaaaaaaaaaaadeaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
akaabaaaabaaaaaaaaaaaaahecaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadpebcaaaafecaabaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaafaaaaaadkaabaaaaaaaaaaa
diaaaaajccaabaaaabaaaaaabkiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaa
ahaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
elaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaaoaaaaajicaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaaapaaaaajbcaabaaaacaaaaaaagiacaaaaaaaaaaaahaaaaaa
pgipcaaaaaaaaaaaagaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaacaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaagaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaa
elaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaaoaaaaajccaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaaiicaabaaa
abaaaaaadkaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaadiaaaaaiicaabaaaabaaaaaa
dkaabaaaabaaaaaadkiacaaaaaaaaaaaagaaaaaadiaaaaahccaabaaaacaaaaaa
bkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaa
acaaaaaadcaaaaakbcaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaaacaaaaaa
akaabaiaebaaaaaaabaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaabaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaaabaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaaaaaaaaaafaaaaaadkaabaaaaaaaaaaadiaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaafgafbaaaabaaaaaaelaaaaafdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaoaaaaajecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
akiacaaaaaaaaaaaahaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaa
aaaaaaaaagaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
dlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaa
aoaaaaajecaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadccaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaa
akaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaa
egiccaaaaaaaaaaaadaaaaaadoaaaaab"
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
Vector 1 [_Color]
Float 2 [_Visibility]
Float 3 [_OceanRadius]
Float 4 [_DensityRatioX]
Float 5 [_DensityRatioY]
Float 6 [_DensityRatioZ]
"ps_3_0
; 98 ALU
def c7, 1.00000000, 0.00000000, 2.71828175, 100000003318135350000000000000000.00000000
def c8, 2.00000000, 0, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord5 v1.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.x, v1, r1
dp3 r0.y, v1, v1
mad r0.x, -r2, r2, r0.y
rsq r0.x, r0.x
rcp r0.z, r0.x
mul r0.x, r0.z, r0.z
mad r0.w, c3.x, c3.x, -r0.x
rsq r0.w, r0.w
rcp r0.w, r0.w
add r1.x, r2, -r0.w
add r0.z, -r0, c3.x
rcp r1.w, c5.x
cmp r0.w, r2.x, c7.x, c7.y
cmp r0.z, r0, c7.x, c7.y
mul_pp r0.z, r0, r0.w
cmp r0.z, -r0, c7.w, r1.x
min r0.w, r0.z, c7
add r0.z, -r0.x, r0.y
add r0.y, -r2.x, r0.w
rsq r0.z, r0.z
rcp r2.w, r0.z
add r1.y, r0.w, r2.w
add r0.z, r2.x, c7.x
frc r0.w, r0.z
add_sat r2.y, r0.z, -r0.w
max r1.x, r0.y, c7.y
add r1.x, r1, -r1.y
mad r0.w, r2.y, r1.x, r1.y
rcp r0.z, c2.x
mul r1.z, r0.x, r0
mul r0.x, r0.w, c2
mul r1.y, c6.x, c6.x
mad r0.x, r0, r0.w, r1.z
mul r0.x, r1.y, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
mov r0.x, c4
mul r1.x, c5, r0
add r0.w, r0.z, c5.x
mul r0.x, r1, r0.w
mul r2.z, r0.x, c4.x
max r0.x, -r0.y, c7.y
add r3.y, -r2.w, r0.x
mul r3.x, r1.w, -r0.z
pow r0, c7.z, r3.x
mad r0.y, r2, r3, r2.w
mul r2.x, r2.y, r2
mul r0.z, r0.y, c2.x
mad r0.y, r0.z, r0, r1.z
mov r3.x, r0
mul r0.x, r1.y, r1.z
mul r0.y, r1, r0
rsq r0.x, r0.x
rcp r3.z, r0.x
rsq r0.y, r0.y
rcp r2.w, r0.y
add r3.y, r2.w, c5.x
mul r3.w, r1, -r3.z
pow r0, c7.z, r3.w
add r0.y, r3.z, c5.x
mov r0.z, r0.x
mul r0.y, r1.x, r0
mul r0.x, r0.y, c4
mul r0.x, r0, r0.z
mad r2.z, -r2, r3.x, r0.x
mul r0.y, r1.x, r3
mul r3.x, r0.y, c4
mul r2.w, r1, -r2
pow r0, c7.z, r2.w
mul r2.y, r2.x, c2.x
mad r0.y, r2, r2.x, r1.z
mul r0.y, r1, r0
mov r0.z, r0.x
rsq r0.x, r0.y
rcp r0.x, r0.x
mul r0.y, r3.x, r0.z
mul r2.x, r0.y, c8
add r1.y, r0.x, c5.x
mul r1.z, -r0.x, r1.w
pow r0, c7.z, r1.z
mul r0.y, r1.x, r1
mul r0.y, r0, c4.x
mad r0.x, -r0.y, r0, r2.z
mad_sat r0.x, r0, c8, r2
mul_pp oC0.w, r0.x, c1
mov_pp oC0.xyz, c1
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 120 used size, 13 vars
Vector 48 [_Color] 4
Float 80 [_Visibility]
Float 84 [_OceanRadius]
Float 108 [_DensityRatioX]
Float 112 [_DensityRatioY]
Float 116 [_DensityRatioZ]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
// 76 instructions, 3 temp regs, 0 temp arrays:
// ALU 72 float, 0 int, 1 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkkmkekapipfjkldccofbphihcijeapglabaaaaaadaakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcciajaaaaeaaaaaaaekacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaaaaaaaajocaabaaa
aaaaaaaaagbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
bcaabaaaabaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agaabaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaaeaaaaaajgahbaaa
aaaaaaaadcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaam
bcaabaaaabaaaaaabkiacaaaaaaaaaaaafaaaaaabkiacaaaaaaaaaaaafaaaaaa
dkaabaiaebaaaaaaaaaaaaaaaoaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akiacaaaaaaaaaaaafaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaa
ddaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaakomfjnhebnaaaaah
ccaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaabnaaaaaiecaabaaa
abaaaaaabkiacaaaaaaaaaaaafaaaaaackaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabaaaaahecaabaaaaaaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaadhaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaaabeaaaaakomfjnheaaaaaaaibcaabaaaabaaaaaa
bkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadeaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaabkaabaaaaaaaaaaadeaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
akaabaaaabaaaaaaaaaaaaahecaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadpebcaaaafecaabaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaafaaaaaadkaabaaaaaaaaaaa
diaaaaajccaabaaaabaaaaaabkiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaa
ahaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
elaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaaoaaaaajicaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaaapaaaaajbcaabaaaacaaaaaaagiacaaaaaaaaaaaahaaaaaa
pgipcaaaaaaaaaaaagaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaacaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaagaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaa
elaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaaoaaaaajccaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaaiicaabaaa
abaaaaaadkaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaadiaaaaaiicaabaaaabaaaaaa
dkaabaaaabaaaaaadkiacaaaaaaaaaaaagaaaaaadiaaaaahccaabaaaacaaaaaa
bkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaa
acaaaaaadcaaaaakbcaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaaacaaaaaa
akaabaiaebaaaaaaabaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaabaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaaabaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaaaaaaaaaafaaaaaadkaabaaaaaaaaaaadiaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaafgafbaaaabaaaaaaelaaaaafdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaoaaaaajecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
akiacaaaaaaaaaaaahaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaa
aaaaaaaaagaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
dlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaa
aoaaaaajecaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadccaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaa
akaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaa
egiccaaaaaaaaaaaadaaaaaadoaaaaab"
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
Vector 1 [_Color]
Float 2 [_Visibility]
Float 3 [_OceanRadius]
Float 4 [_DensityRatioX]
Float 5 [_DensityRatioY]
Float 6 [_DensityRatioZ]
"ps_3_0
; 98 ALU
def c7, 1.00000000, 0.00000000, 2.71828175, 100000003318135350000000000000000.00000000
def c8, 2.00000000, 0, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord5 v1.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.x, v1, r1
dp3 r0.y, v1, v1
mad r0.x, -r2, r2, r0.y
rsq r0.x, r0.x
rcp r0.z, r0.x
mul r0.x, r0.z, r0.z
mad r0.w, c3.x, c3.x, -r0.x
rsq r0.w, r0.w
rcp r0.w, r0.w
add r1.x, r2, -r0.w
add r0.z, -r0, c3.x
rcp r1.w, c5.x
cmp r0.w, r2.x, c7.x, c7.y
cmp r0.z, r0, c7.x, c7.y
mul_pp r0.z, r0, r0.w
cmp r0.z, -r0, c7.w, r1.x
min r0.w, r0.z, c7
add r0.z, -r0.x, r0.y
add r0.y, -r2.x, r0.w
rsq r0.z, r0.z
rcp r2.w, r0.z
add r1.y, r0.w, r2.w
add r0.z, r2.x, c7.x
frc r0.w, r0.z
add_sat r2.y, r0.z, -r0.w
max r1.x, r0.y, c7.y
add r1.x, r1, -r1.y
mad r0.w, r2.y, r1.x, r1.y
rcp r0.z, c2.x
mul r1.z, r0.x, r0
mul r0.x, r0.w, c2
mul r1.y, c6.x, c6.x
mad r0.x, r0, r0.w, r1.z
mul r0.x, r1.y, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
mov r0.x, c4
mul r1.x, c5, r0
add r0.w, r0.z, c5.x
mul r0.x, r1, r0.w
mul r2.z, r0.x, c4.x
max r0.x, -r0.y, c7.y
add r3.y, -r2.w, r0.x
mul r3.x, r1.w, -r0.z
pow r0, c7.z, r3.x
mad r0.y, r2, r3, r2.w
mul r2.x, r2.y, r2
mul r0.z, r0.y, c2.x
mad r0.y, r0.z, r0, r1.z
mov r3.x, r0
mul r0.x, r1.y, r1.z
mul r0.y, r1, r0
rsq r0.x, r0.x
rcp r3.z, r0.x
rsq r0.y, r0.y
rcp r2.w, r0.y
add r3.y, r2.w, c5.x
mul r3.w, r1, -r3.z
pow r0, c7.z, r3.w
add r0.y, r3.z, c5.x
mov r0.z, r0.x
mul r0.y, r1.x, r0
mul r0.x, r0.y, c4
mul r0.x, r0, r0.z
mad r2.z, -r2, r3.x, r0.x
mul r0.y, r1.x, r3
mul r3.x, r0.y, c4
mul r2.w, r1, -r2
pow r0, c7.z, r2.w
mul r2.y, r2.x, c2.x
mad r0.y, r2, r2.x, r1.z
mul r0.y, r1, r0
mov r0.z, r0.x
rsq r0.x, r0.y
rcp r0.x, r0.x
mul r0.y, r3.x, r0.z
mul r2.x, r0.y, c8
add r1.y, r0.x, c5.x
mul r1.z, -r0.x, r1.w
pow r0, c7.z, r1.z
mul r0.y, r1.x, r1
mul r0.y, r0, c4.x
mad r0.x, -r0.y, r0, r2.z
mad_sat r0.x, r0, c8, r2
mul_pp oC0.w, r0.x, c1
mov_pp oC0.xyz, c1
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 120 used size, 13 vars
Vector 48 [_Color] 4
Float 80 [_Visibility]
Float 84 [_OceanRadius]
Float 108 [_DensityRatioX]
Float 112 [_DensityRatioY]
Float 116 [_DensityRatioZ]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
// 76 instructions, 3 temp regs, 0 temp arrays:
// ALU 72 float, 0 int, 1 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkkmkekapipfjkldccofbphihcijeapglabaaaaaadaakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcciajaaaaeaaaaaaaekacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaaaaaaaajocaabaaa
aaaaaaaaagbjbaaaacaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
bcaabaaaabaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agaabaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaaeaaaaaajgahbaaa
aaaaaaaadcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaam
bcaabaaaabaaaaaabkiacaaaaaaaaaaaafaaaaaabkiacaaaaaaaaaaaafaaaaaa
dkaabaiaebaaaaaaaaaaaaaaaoaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akiacaaaaaaaaaaaafaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaa
ddaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaakomfjnhebnaaaaah
ccaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaabnaaaaaiecaabaaa
abaaaaaabkiacaaaaaaaaaaaafaaaaaackaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabaaaaahecaabaaaaaaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaadhaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaaabeaaaaakomfjnheaaaaaaaibcaabaaaabaaaaaa
bkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadeaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaabkaabaaaaaaaaaaadeaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
akaabaaaabaaaaaaaaaaaaahecaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadpebcaaaafecaabaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaafaaaaaadkaabaaaaaaaaaaa
diaaaaajccaabaaaabaaaaaabkiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaa
ahaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
elaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaaoaaaaajicaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaaapaaaaajbcaabaaaacaaaaaaagiacaaaaaaaaaaaahaaaaaa
pgipcaaaaaaaaaaaagaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaacaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaagaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaa
elaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaaoaaaaajccaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaaiicaabaaa
abaaaaaadkaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaadiaaaaaiicaabaaaabaaaaaa
dkaabaaaabaaaaaadkiacaaaaaaaaaaaagaaaaaadiaaaaahccaabaaaacaaaaaa
bkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaa
acaaaaaadcaaaaakbcaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaaacaaaaaa
akaabaiaebaaaaaaabaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaabaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaaabaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaaaaaaaaaafaaaaaadkaabaaaaaaaaaaadiaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaafgafbaaaabaaaaaaelaaaaafdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaoaaaaajecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
akiacaaaaaaaaaaaahaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaa
aaaaaaaaagaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
dlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaa
aoaaaaajecaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadccaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaa
akaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaa
egiccaaaaaaaaaaaadaaaaaadoaaaaab"
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
Vector 1 [_Color]
Float 2 [_Visibility]
Float 3 [_OceanRadius]
Float 4 [_DensityRatioX]
Float 5 [_DensityRatioY]
Float 6 [_DensityRatioZ]
"ps_3_0
; 98 ALU
def c7, 1.00000000, 0.00000000, 2.71828175, 100000003318135350000000000000000.00000000
def c8, 2.00000000, 0, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord5 v1.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.x, v1, r1
dp3 r0.y, v1, v1
mad r0.x, -r2, r2, r0.y
rsq r0.x, r0.x
rcp r0.z, r0.x
mul r0.x, r0.z, r0.z
mad r0.w, c3.x, c3.x, -r0.x
rsq r0.w, r0.w
rcp r0.w, r0.w
add r1.x, r2, -r0.w
add r0.z, -r0, c3.x
rcp r1.w, c5.x
cmp r0.w, r2.x, c7.x, c7.y
cmp r0.z, r0, c7.x, c7.y
mul_pp r0.z, r0, r0.w
cmp r0.z, -r0, c7.w, r1.x
min r0.w, r0.z, c7
add r0.z, -r0.x, r0.y
add r0.y, -r2.x, r0.w
rsq r0.z, r0.z
rcp r2.w, r0.z
add r1.y, r0.w, r2.w
add r0.z, r2.x, c7.x
frc r0.w, r0.z
add_sat r2.y, r0.z, -r0.w
max r1.x, r0.y, c7.y
add r1.x, r1, -r1.y
mad r0.w, r2.y, r1.x, r1.y
rcp r0.z, c2.x
mul r1.z, r0.x, r0
mul r0.x, r0.w, c2
mul r1.y, c6.x, c6.x
mad r0.x, r0, r0.w, r1.z
mul r0.x, r1.y, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
mov r0.x, c4
mul r1.x, c5, r0
add r0.w, r0.z, c5.x
mul r0.x, r1, r0.w
mul r2.z, r0.x, c4.x
max r0.x, -r0.y, c7.y
add r3.y, -r2.w, r0.x
mul r3.x, r1.w, -r0.z
pow r0, c7.z, r3.x
mad r0.y, r2, r3, r2.w
mul r2.x, r2.y, r2
mul r0.z, r0.y, c2.x
mad r0.y, r0.z, r0, r1.z
mov r3.x, r0
mul r0.x, r1.y, r1.z
mul r0.y, r1, r0
rsq r0.x, r0.x
rcp r3.z, r0.x
rsq r0.y, r0.y
rcp r2.w, r0.y
add r3.y, r2.w, c5.x
mul r3.w, r1, -r3.z
pow r0, c7.z, r3.w
add r0.y, r3.z, c5.x
mov r0.z, r0.x
mul r0.y, r1.x, r0
mul r0.x, r0.y, c4
mul r0.x, r0, r0.z
mad r2.z, -r2, r3.x, r0.x
mul r0.y, r1.x, r3
mul r3.x, r0.y, c4
mul r2.w, r1, -r2
pow r0, c7.z, r2.w
mul r2.y, r2.x, c2.x
mad r0.y, r2, r2.x, r1.z
mul r0.y, r1, r0
mov r0.z, r0.x
rsq r0.x, r0.y
rcp r0.x, r0.x
mul r0.y, r3.x, r0.z
mul r2.x, r0.y, c8
add r1.y, r0.x, c5.x
mul r1.z, -r0.x, r1.w
pow r0, c7.z, r1.z
mul r0.y, r1.x, r1
mul r0.y, r0, c4.x
mad r0.x, -r0.y, r0, r2.z
mad_sat r0.x, r0, c8, r2
mul_pp oC0.w, r0.x, c1
mov_pp oC0.xyz, c1
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 184 used size, 14 vars
Vector 112 [_Color] 4
Float 144 [_Visibility]
Float 148 [_OceanRadius]
Float 172 [_DensityRatioX]
Float 176 [_DensityRatioY]
Float 180 [_DensityRatioZ]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
// 76 instructions, 3 temp regs, 0 temp arrays:
// ALU 72 float, 0 int, 1 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedceoinmmpiccjnenlfmmmloplgifjekikabaaaaaaeiakaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcciajaaaa
eaaaaaaaekacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaaaaaaaajocaabaaaaaaaaaaaagbjbaaa
acaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaa
jgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagaabaaaabaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaafaaaaaajgahbaaaaaaaaaaadcaaaaak
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaa
bkiacaaaaaaaaaaaajaaaaaabkiacaaaaaaaaaaaajaaaaaadkaabaiaebaaaaaa
aaaaaaaaaoaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaa
ajaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaaddaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaakomfjnhebnaaaaahccaabaaaabaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaabnaaaaaiecaabaaaabaaaaaabkiacaaa
aaaaaaaaajaaaaaackaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabaaaaahecaabaaaaaaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadhaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaaabeaaaaakomfjnheaaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaa
aaaaaaaadeaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
aaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaa
aaaaaaahecaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpebcaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaa
abaaaaaaakiacaaaaaaaaaaaajaaaaaadkaabaaaaaaaaaaadiaaaaajccaabaaa
abaaaaaabkiacaaaaaaaaaaaalaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaaelaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaaaoaaaaajicaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaakiacaaaaaaaaaaaalaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
apaaaaajbcaabaaaacaaaaaaagiacaaaaaaaaaaaalaaaaaapgipcaaaaaaaaaaa
akaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaacaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaakaaaaaa
diaaaaahbcaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaaelaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaaaoaaaaajccaabaaaacaaaaaadkaabaiaebaaaaaa
abaaaaaaakiacaaaaaaaaaaaalaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaaa
abaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaakaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaa
abeaaaaadlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaak
bcaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaaacaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaa
dcaaaaajbcaabaaaaaaaaaaackaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaa
dkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaajaaaaaadkaabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaa
aaaaaaaafgafbaaaabaaaaaaelaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aoaaaaajecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaa
alaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
alaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaaaoaaaaajecaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaaaaaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadccaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaahaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaa
ahaaaaaadoaaaaab"
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
Vector 1 [_Color]
Float 2 [_Visibility]
Float 3 [_OceanRadius]
Float 4 [_DensityRatioX]
Float 5 [_DensityRatioY]
Float 6 [_DensityRatioZ]
"ps_3_0
; 98 ALU
def c7, 1.00000000, 0.00000000, 2.71828175, 100000003318135350000000000000000.00000000
def c8, 2.00000000, 0, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord5 v1.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.x, v1, r1
dp3 r0.y, v1, v1
mad r0.x, -r2, r2, r0.y
rsq r0.x, r0.x
rcp r0.z, r0.x
mul r0.x, r0.z, r0.z
mad r0.w, c3.x, c3.x, -r0.x
rsq r0.w, r0.w
rcp r0.w, r0.w
add r1.x, r2, -r0.w
add r0.z, -r0, c3.x
rcp r1.w, c5.x
cmp r0.w, r2.x, c7.x, c7.y
cmp r0.z, r0, c7.x, c7.y
mul_pp r0.z, r0, r0.w
cmp r0.z, -r0, c7.w, r1.x
min r0.w, r0.z, c7
add r0.z, -r0.x, r0.y
add r0.y, -r2.x, r0.w
rsq r0.z, r0.z
rcp r2.w, r0.z
add r1.y, r0.w, r2.w
add r0.z, r2.x, c7.x
frc r0.w, r0.z
add_sat r2.y, r0.z, -r0.w
max r1.x, r0.y, c7.y
add r1.x, r1, -r1.y
mad r0.w, r2.y, r1.x, r1.y
rcp r0.z, c2.x
mul r1.z, r0.x, r0
mul r0.x, r0.w, c2
mul r1.y, c6.x, c6.x
mad r0.x, r0, r0.w, r1.z
mul r0.x, r1.y, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
mov r0.x, c4
mul r1.x, c5, r0
add r0.w, r0.z, c5.x
mul r0.x, r1, r0.w
mul r2.z, r0.x, c4.x
max r0.x, -r0.y, c7.y
add r3.y, -r2.w, r0.x
mul r3.x, r1.w, -r0.z
pow r0, c7.z, r3.x
mad r0.y, r2, r3, r2.w
mul r2.x, r2.y, r2
mul r0.z, r0.y, c2.x
mad r0.y, r0.z, r0, r1.z
mov r3.x, r0
mul r0.x, r1.y, r1.z
mul r0.y, r1, r0
rsq r0.x, r0.x
rcp r3.z, r0.x
rsq r0.y, r0.y
rcp r2.w, r0.y
add r3.y, r2.w, c5.x
mul r3.w, r1, -r3.z
pow r0, c7.z, r3.w
add r0.y, r3.z, c5.x
mov r0.z, r0.x
mul r0.y, r1.x, r0
mul r0.x, r0.y, c4
mul r0.x, r0, r0.z
mad r2.z, -r2, r3.x, r0.x
mul r0.y, r1.x, r3
mul r3.x, r0.y, c4
mul r2.w, r1, -r2
pow r0, c7.z, r2.w
mul r2.y, r2.x, c2.x
mad r0.y, r2, r2.x, r1.z
mul r0.y, r1, r0
mov r0.z, r0.x
rsq r0.x, r0.y
rcp r0.x, r0.x
mul r0.y, r3.x, r0.z
mul r2.x, r0.y, c8
add r1.y, r0.x, c5.x
mul r1.z, -r0.x, r1.w
pow r0, c7.z, r1.z
mul r0.y, r1.x, r1
mul r0.y, r0, c4.x
mad r0.x, -r0.y, r0, r2.z
mad_sat r0.x, r0, c8, r2
mul_pp oC0.w, r0.x, c1
mov_pp oC0.xyz, c1
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 184 used size, 14 vars
Vector 112 [_Color] 4
Float 144 [_Visibility]
Float 148 [_OceanRadius]
Float 172 [_DensityRatioX]
Float 176 [_DensityRatioY]
Float 180 [_DensityRatioZ]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
// 76 instructions, 3 temp regs, 0 temp arrays:
// ALU 72 float, 0 int, 1 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedceoinmmpiccjnenlfmmmloplgifjekikabaaaaaaeiakaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcciajaaaa
eaaaaaaaekacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaaaaaaaajocaabaaaaaaaaaaaagbjbaaa
acaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaa
jgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagaabaaaabaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaafaaaaaajgahbaaaaaaaaaaadcaaaaak
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaa
bkiacaaaaaaaaaaaajaaaaaabkiacaaaaaaaaaaaajaaaaaadkaabaiaebaaaaaa
aaaaaaaaaoaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaa
ajaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaaddaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaakomfjnhebnaaaaahccaabaaaabaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaabnaaaaaiecaabaaaabaaaaaabkiacaaa
aaaaaaaaajaaaaaackaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabaaaaahecaabaaaaaaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadhaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaaabeaaaaakomfjnheaaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaa
aaaaaaaadeaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
aaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaa
aaaaaaahecaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpebcaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaa
abaaaaaaakiacaaaaaaaaaaaajaaaaaadkaabaaaaaaaaaaadiaaaaajccaabaaa
abaaaaaabkiacaaaaaaaaaaaalaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaaelaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaaaoaaaaajicaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaakiacaaaaaaaaaaaalaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
apaaaaajbcaabaaaacaaaaaaagiacaaaaaaaaaaaalaaaaaapgipcaaaaaaaaaaa
akaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaacaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaakaaaaaa
diaaaaahbcaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaaelaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaaaoaaaaajccaabaaaacaaaaaadkaabaiaebaaaaaa
abaaaaaaakiacaaaaaaaaaaaalaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaaa
abaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaakaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaa
abeaaaaadlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaak
bcaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaaacaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaa
dcaaaaajbcaabaaaaaaaaaaackaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaa
dkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaajaaaaaadkaabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaa
aaaaaaaafgafbaaaabaaaaaaelaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aoaaaaajecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaa
alaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
alaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaaaoaaaaajecaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaaaaaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadccaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaahaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaa
ahaaaaaadoaaaaab"
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
Vector 1 [_Color]
Float 2 [_Visibility]
Float 3 [_OceanRadius]
Float 4 [_DensityRatioX]
Float 5 [_DensityRatioY]
Float 6 [_DensityRatioZ]
"ps_3_0
; 98 ALU
def c7, 1.00000000, 0.00000000, 2.71828175, 100000003318135350000000000000000.00000000
def c8, 2.00000000, 0, 0, 0
dcl_texcoord1 v0.xyz
dcl_texcoord5 v1.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.x, v1, r1
dp3 r0.y, v1, v1
mad r0.x, -r2, r2, r0.y
rsq r0.x, r0.x
rcp r0.z, r0.x
mul r0.x, r0.z, r0.z
mad r0.w, c3.x, c3.x, -r0.x
rsq r0.w, r0.w
rcp r0.w, r0.w
add r1.x, r2, -r0.w
add r0.z, -r0, c3.x
rcp r1.w, c5.x
cmp r0.w, r2.x, c7.x, c7.y
cmp r0.z, r0, c7.x, c7.y
mul_pp r0.z, r0, r0.w
cmp r0.z, -r0, c7.w, r1.x
min r0.w, r0.z, c7
add r0.z, -r0.x, r0.y
add r0.y, -r2.x, r0.w
rsq r0.z, r0.z
rcp r2.w, r0.z
add r1.y, r0.w, r2.w
add r0.z, r2.x, c7.x
frc r0.w, r0.z
add_sat r2.y, r0.z, -r0.w
max r1.x, r0.y, c7.y
add r1.x, r1, -r1.y
mad r0.w, r2.y, r1.x, r1.y
rcp r0.z, c2.x
mul r1.z, r0.x, r0
mul r0.x, r0.w, c2
mul r1.y, c6.x, c6.x
mad r0.x, r0, r0.w, r1.z
mul r0.x, r1.y, r0
rsq r0.x, r0.x
rcp r0.z, r0.x
mov r0.x, c4
mul r1.x, c5, r0
add r0.w, r0.z, c5.x
mul r0.x, r1, r0.w
mul r2.z, r0.x, c4.x
max r0.x, -r0.y, c7.y
add r3.y, -r2.w, r0.x
mul r3.x, r1.w, -r0.z
pow r0, c7.z, r3.x
mad r0.y, r2, r3, r2.w
mul r2.x, r2.y, r2
mul r0.z, r0.y, c2.x
mad r0.y, r0.z, r0, r1.z
mov r3.x, r0
mul r0.x, r1.y, r1.z
mul r0.y, r1, r0
rsq r0.x, r0.x
rcp r3.z, r0.x
rsq r0.y, r0.y
rcp r2.w, r0.y
add r3.y, r2.w, c5.x
mul r3.w, r1, -r3.z
pow r0, c7.z, r3.w
add r0.y, r3.z, c5.x
mov r0.z, r0.x
mul r0.y, r1.x, r0
mul r0.x, r0.y, c4
mul r0.x, r0, r0.z
mad r2.z, -r2, r3.x, r0.x
mul r0.y, r1.x, r3
mul r3.x, r0.y, c4
mul r2.w, r1, -r2
pow r0, c7.z, r2.w
mul r2.y, r2.x, c2.x
mad r0.y, r2, r2.x, r1.z
mul r0.y, r1, r0
mov r0.z, r0.x
rsq r0.x, r0.y
rcp r0.x, r0.x
mul r0.y, r3.x, r0.z
mul r2.x, r0.y, c8
add r1.y, r0.x, c5.x
mul r1.z, -r0.x, r1.w
pow r0, c7.z, r1.z
mul r0.y, r1.x, r1
mul r0.y, r0, c4.x
mad r0.x, -r0.y, r0, r2.z
mad_sat r0.x, r0, c8, r2
mul_pp oC0.w, r0.x, c1
mov_pp oC0.xyz, c1
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 184 used size, 14 vars
Vector 112 [_Color] 4
Float 144 [_Visibility]
Float 148 [_OceanRadius]
Float 172 [_DensityRatioX]
Float 176 [_DensityRatioY]
Float 180 [_DensityRatioZ]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
// 76 instructions, 3 temp regs, 0 temp arrays:
// ALU 72 float, 0 int, 1 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedceoinmmpiccjnenlfmmmloplgifjekikabaaaaaaeiakaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcciajaaaa
eaaaaaaaekacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaaaaaaaajocaabaaaaaaaaaaaagbjbaaa
acaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaa
jgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagaabaaaabaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaafaaaaaajgahbaaaaaaaaaaadcaaaaak
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaa
bkiacaaaaaaaaaaaajaaaaaabkiacaaaaaaaaaaaajaaaaaadkaabaiaebaaaaaa
aaaaaaaaaoaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaa
ajaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaaddaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaakomfjnhebnaaaaahccaabaaaabaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaabnaaaaaiecaabaaaabaaaaaabkiacaaa
aaaaaaaaajaaaaaackaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabaaaaahecaabaaaaaaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadhaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaaabeaaaaakomfjnheaaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaa
aaaaaaaadeaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
aaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaa
aaaaaaahecaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpebcaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaa
abaaaaaaakiacaaaaaaaaaaaajaaaaaadkaabaaaaaaaaaaadiaaaaajccaabaaa
abaaaaaabkiacaaaaaaaaaaaalaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaaelaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaaaoaaaaajicaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaakiacaaaaaaaaaaaalaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
apaaaaajbcaabaaaacaaaaaaagiacaaaaaaaaaaaalaaaaaapgipcaaaaaaaaaaa
akaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaacaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaakaaaaaa
diaaaaahbcaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaaelaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaaaoaaaaajccaabaaaacaaaaaadkaabaiaebaaaaaa
abaaaaaaakiacaaaaaaaaaaaalaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaaa
abaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaakaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaa
abeaaaaadlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaak
bcaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaaacaaaaaaakaabaiaebaaaaaa
abaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaa
dcaaaaajbcaabaaaaaaaaaaackaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaa
dkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaajaaaaaadkaabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaa
aaaaaaaafgafbaaaabaaaaaaelaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aoaaaaajecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaa
alaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
alaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaaaoaaaaajecaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaaaaaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadccaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaahaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaa
ahaaaaaadoaaaaab"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES3"
}

}

#LINE 169

	
		}
		
	} 
	


			
}
}
