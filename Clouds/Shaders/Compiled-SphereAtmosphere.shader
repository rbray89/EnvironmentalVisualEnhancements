Shader "Sphere/Atmosphere" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_OceanRadius ("Ocean Radius", Float) = 63000
		_SphereRadius ("Sphere Radius", Float) = 67000
		_PlanetOrigin ("Sphere Center", Vector) = (0,0,0,1)
		_SunsetColor ("Color Sunset", Color) = (1,0,0,.45)
		_DensityFactorA ("Density RatioA", Float) = .22
		_DensityFactorB ("Density RatioB", Float) = 800
		_DensityFactorC ("Density RatioC", Float) = 1
		_DensityFactorD ("Density RatioD", Float) = 1
		_DensityFactorE ("Density RatioE", Float) = 1
		_Scale ("Scale", Float) = 1
		_Visibility ("Visibility", Float) = .0001
		_DensityVisibilityBase ("_DensityVisibilityBase", Float) = 1
		_DensityVisibilityPow ("_DensityVisibilityPow", Float) = 1
		_DensityVisibilityOffset ("_DensityVisibilityOffset", Float) = 1
		_DensityCutoffBase ("_DensityCutoffBase", Float) = 1
		_DensityCutoffPow ("_DensityCutoffPow", Float) = 1
		_DensityCutoffOffset ("_DensityCutoffyOffset", Float) = 1
		_DensityCutoffScale ("_DensityCutoffScale", Float) = 1
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
//   d3d9 - ALU: 19 to 24
//   d3d11 - ALU: 18 to 19, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _Scale;
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
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityCutoffScale;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffBase;
uniform float _DensityVisibilityOffset;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityBase;
uniform float _Visibility;
uniform float _Scale;
uniform float _DensityFactorE;
uniform float _DensityFactorD;
uniform float _DensityFactorC;
uniform float _DensityFactorB;
uniform float _DensityFactorA;
uniform float _OceanRadius;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = (_Scale * _OceanRadius);
  float tmpvar_9;
  tmpvar_9 = min (mix (tmpvar_2, (tmpvar_4 - sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_6))), (float((tmpvar_8 >= tmpvar_5)) * float((tmpvar_4 >= 0.0)))), tmpvar_2);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  vec3 arg0_11;
  arg0_11 = ((_WorldSpaceCameraPos + (tmpvar_9 * tmpvar_3)) - ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos));
  float tmpvar_12;
  tmpvar_12 = float((tmpvar_4 >= 0.0));
  float tmpvar_13;
  tmpvar_13 = mix ((tmpvar_9 + tmpvar_7), max (0.0, (tmpvar_9 - tmpvar_4)), tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = (tmpvar_12 * tmpvar_4);
  float tmpvar_15;
  tmpvar_15 = mix (tmpvar_7, max (0.0, (tmpvar_4 - tmpvar_9)), tmpvar_12);
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityFactorC * (tmpvar_13 * tmpvar_13)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_17;
  tmpvar_17 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * (tmpvar_14 * tmpvar_14)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_19;
  tmpvar_19 = sqrt(((_DensityFactorC * (tmpvar_15 * tmpvar_15)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  color_1.w = (_Color.w * clamp (((((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_16 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_16 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_17 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_17 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC)) + ((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_18 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_19 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC))) + (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_10 + _DensityCutoffOffset)))), 0.0, 1.0) * ((_Visibility * tmpvar_9) * pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * (tmpvar_10 + sqrt(dot (arg0_11, arg0_11)))) + _DensityVisibilityOffset)))))), 0.0, 1.0));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_Scale]
"vs_3_0
; 21 ALU
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
dp4 r0.w, v0, c2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
mov o3.xyz, r0
add r0.xyz, r0, -c12
mad o1.xy, r1.z, c14.zwzw, r1
mul o4.xyz, r0, c15.x
mov o1.z, -r0.w
mov o1.w, r1
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 176 // 132 used size, 22 vars
Float 128 [_Scale]
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
// 22 instructions, 2 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedidimabcfglhlknbhdnmigagegmhkkhjiabaaaaaakaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmadaaaaeaaaabaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
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
hccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaai
hccabaaaaeaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadoaaaaab
"
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 411
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 397
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 401
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 405
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 409
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 427
#line 457
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 442
v2f vert( in appdata_t v ) {
    #line 444
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 448
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 452
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 411
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 397
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 401
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 405
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 409
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 427
#line 457
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 427
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 431
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 435
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 439
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 457
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 461
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    #line 465
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    #line 469
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    #line 473
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    #line 477
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    #line 481
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    #line 485
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
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
uniform float _Scale;
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
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityCutoffScale;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffBase;
uniform float _DensityVisibilityOffset;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityBase;
uniform float _Visibility;
uniform float _Scale;
uniform float _DensityFactorE;
uniform float _DensityFactorD;
uniform float _DensityFactorC;
uniform float _DensityFactorB;
uniform float _DensityFactorA;
uniform float _OceanRadius;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = (_Scale * _OceanRadius);
  float tmpvar_9;
  tmpvar_9 = min (mix (tmpvar_2, (tmpvar_4 - sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_6))), (float((tmpvar_8 >= tmpvar_5)) * float((tmpvar_4 >= 0.0)))), tmpvar_2);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  vec3 arg0_11;
  arg0_11 = ((_WorldSpaceCameraPos + (tmpvar_9 * tmpvar_3)) - ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos));
  float tmpvar_12;
  tmpvar_12 = float((tmpvar_4 >= 0.0));
  float tmpvar_13;
  tmpvar_13 = mix ((tmpvar_9 + tmpvar_7), max (0.0, (tmpvar_9 - tmpvar_4)), tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = (tmpvar_12 * tmpvar_4);
  float tmpvar_15;
  tmpvar_15 = mix (tmpvar_7, max (0.0, (tmpvar_4 - tmpvar_9)), tmpvar_12);
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityFactorC * (tmpvar_13 * tmpvar_13)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_17;
  tmpvar_17 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * (tmpvar_14 * tmpvar_14)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_19;
  tmpvar_19 = sqrt(((_DensityFactorC * (tmpvar_15 * tmpvar_15)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  color_1.w = (_Color.w * clamp (((((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_16 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_16 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_17 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_17 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC)) + ((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_18 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_19 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC))) + (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_10 + _DensityCutoffOffset)))), 0.0, 1.0) * ((_Visibility * tmpvar_9) * pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * (tmpvar_10 + sqrt(dot (arg0_11, arg0_11)))) + _DensityVisibilityOffset)))))), 0.0, 1.0));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_Scale]
"vs_3_0
; 21 ALU
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
dp4 r0.w, v0, c2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
mov o3.xyz, r0
add r0.xyz, r0, -c12
mad o1.xy, r1.z, c14.zwzw, r1
mul o4.xyz, r0, c15.x
mov o1.z, -r0.w
mov o1.w, r1
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 176 // 132 used size, 22 vars
Float 128 [_Scale]
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
// 22 instructions, 2 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedidimabcfglhlknbhdnmigagegmhkkhjiabaaaaaakaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmadaaaaeaaaabaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
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
hccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaai
hccabaaaaeaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadoaaaaab
"
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 411
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 397
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 401
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 405
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 409
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 427
#line 457
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 442
v2f vert( in appdata_t v ) {
    #line 444
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 448
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 452
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 411
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 397
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 401
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 405
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 409
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 427
#line 457
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 427
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 431
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 435
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 439
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 457
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 461
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    #line 465
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    #line 469
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    #line 473
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    #line 477
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    #line 481
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    #line 485
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
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
uniform float _Scale;
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
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityCutoffScale;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffBase;
uniform float _DensityVisibilityOffset;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityBase;
uniform float _Visibility;
uniform float _Scale;
uniform float _DensityFactorE;
uniform float _DensityFactorD;
uniform float _DensityFactorC;
uniform float _DensityFactorB;
uniform float _DensityFactorA;
uniform float _OceanRadius;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = (_Scale * _OceanRadius);
  float tmpvar_9;
  tmpvar_9 = min (mix (tmpvar_2, (tmpvar_4 - sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_6))), (float((tmpvar_8 >= tmpvar_5)) * float((tmpvar_4 >= 0.0)))), tmpvar_2);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  vec3 arg0_11;
  arg0_11 = ((_WorldSpaceCameraPos + (tmpvar_9 * tmpvar_3)) - ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos));
  float tmpvar_12;
  tmpvar_12 = float((tmpvar_4 >= 0.0));
  float tmpvar_13;
  tmpvar_13 = mix ((tmpvar_9 + tmpvar_7), max (0.0, (tmpvar_9 - tmpvar_4)), tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = (tmpvar_12 * tmpvar_4);
  float tmpvar_15;
  tmpvar_15 = mix (tmpvar_7, max (0.0, (tmpvar_4 - tmpvar_9)), tmpvar_12);
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityFactorC * (tmpvar_13 * tmpvar_13)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_17;
  tmpvar_17 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * (tmpvar_14 * tmpvar_14)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_19;
  tmpvar_19 = sqrt(((_DensityFactorC * (tmpvar_15 * tmpvar_15)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  color_1.w = (_Color.w * clamp (((((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_16 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_16 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_17 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_17 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC)) + ((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_18 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_19 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC))) + (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_10 + _DensityCutoffOffset)))), 0.0, 1.0) * ((_Visibility * tmpvar_9) * pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * (tmpvar_10 + sqrt(dot (arg0_11, arg0_11)))) + _DensityVisibilityOffset)))))), 0.0, 1.0));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_Scale]
"vs_3_0
; 21 ALU
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
dp4 r0.w, v0, c2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
mov o3.xyz, r0
add r0.xyz, r0, -c12
mad o1.xy, r1.z, c14.zwzw, r1
mul o4.xyz, r0, c15.x
mov o1.z, -r0.w
mov o1.w, r1
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 176 // 132 used size, 22 vars
Float 128 [_Scale]
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
// 22 instructions, 2 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedidimabcfglhlknbhdnmigagegmhkkhjiabaaaaaakaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmadaaaaeaaaabaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
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
hccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaai
hccabaaaaeaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadoaaaaab
"
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 411
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 397
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 401
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 405
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 409
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 427
#line 457
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 442
v2f vert( in appdata_t v ) {
    #line 444
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 448
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 452
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 411
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 397
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 401
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 405
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 409
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 427
#line 457
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 427
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 431
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 435
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 439
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 457
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 461
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    #line 465
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    #line 469
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    #line 473
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    #line 477
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    #line 481
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    #line 485
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
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
uniform float _Scale;
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
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
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
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityCutoffScale;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffBase;
uniform float _DensityVisibilityOffset;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityBase;
uniform float _Visibility;
uniform float _Scale;
uniform float _DensityFactorE;
uniform float _DensityFactorD;
uniform float _DensityFactorC;
uniform float _DensityFactorB;
uniform float _DensityFactorA;
uniform float _OceanRadius;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = (_Scale * _OceanRadius);
  float tmpvar_9;
  tmpvar_9 = min (mix (tmpvar_2, (tmpvar_4 - sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_6))), (float((tmpvar_8 >= tmpvar_5)) * float((tmpvar_4 >= 0.0)))), tmpvar_2);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  vec3 arg0_11;
  arg0_11 = ((_WorldSpaceCameraPos + (tmpvar_9 * tmpvar_3)) - ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos));
  float tmpvar_12;
  tmpvar_12 = float((tmpvar_4 >= 0.0));
  float tmpvar_13;
  tmpvar_13 = mix ((tmpvar_9 + tmpvar_7), max (0.0, (tmpvar_9 - tmpvar_4)), tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = (tmpvar_12 * tmpvar_4);
  float tmpvar_15;
  tmpvar_15 = mix (tmpvar_7, max (0.0, (tmpvar_4 - tmpvar_9)), tmpvar_12);
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityFactorC * (tmpvar_13 * tmpvar_13)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_17;
  tmpvar_17 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * (tmpvar_14 * tmpvar_14)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_19;
  tmpvar_19 = sqrt(((_DensityFactorC * (tmpvar_15 * tmpvar_15)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  color_1.w = (_Color.w * clamp (((((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_16 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_16 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_17 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_17 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC)) + ((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_18 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_19 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC))) + (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_10 + _DensityCutoffOffset)))), 0.0, 1.0) * ((_Visibility * tmpvar_9) * pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * (tmpvar_10 + sqrt(dot (arg0_11, arg0_11)))) + _DensityVisibilityOffset)))))), 0.0, 1.0));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_Scale]
"vs_3_0
; 24 ALU
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
dp4 r0.w, v0, c2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
mov o4.xyz, r0
add r0.xyz, r0, -c12
mov o0, r1
mul o5.xyz, r0, c15.x
mov o1.z, -r0.w
mov o1.w, r2.x
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 240 // 196 used size, 23 vars
Float 192 [_Scale]
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
// 24 instructions, 2 temp regs, 0 temp arrays:
// ALU 19 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedlkcedfgfmjkmhaanemnohoanianildkiabaaaaaapeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiadaaaaeaaaabaa
ogaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
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
acaaaaaaapaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadoaaaaab"
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 451
v2f vert( in appdata_t v ) {
    #line 453
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 461
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 440
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 444
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 448
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 473
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    #line 477
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    #line 481
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    #line 485
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    #line 489
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    #line 493
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
    color.w *= xll_saturate_f(depth);
    #line 497
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
uniform float _Scale;
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
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
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
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityCutoffScale;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffBase;
uniform float _DensityVisibilityOffset;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityBase;
uniform float _Visibility;
uniform float _Scale;
uniform float _DensityFactorE;
uniform float _DensityFactorD;
uniform float _DensityFactorC;
uniform float _DensityFactorB;
uniform float _DensityFactorA;
uniform float _OceanRadius;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = (_Scale * _OceanRadius);
  float tmpvar_9;
  tmpvar_9 = min (mix (tmpvar_2, (tmpvar_4 - sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_6))), (float((tmpvar_8 >= tmpvar_5)) * float((tmpvar_4 >= 0.0)))), tmpvar_2);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  vec3 arg0_11;
  arg0_11 = ((_WorldSpaceCameraPos + (tmpvar_9 * tmpvar_3)) - ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos));
  float tmpvar_12;
  tmpvar_12 = float((tmpvar_4 >= 0.0));
  float tmpvar_13;
  tmpvar_13 = mix ((tmpvar_9 + tmpvar_7), max (0.0, (tmpvar_9 - tmpvar_4)), tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = (tmpvar_12 * tmpvar_4);
  float tmpvar_15;
  tmpvar_15 = mix (tmpvar_7, max (0.0, (tmpvar_4 - tmpvar_9)), tmpvar_12);
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityFactorC * (tmpvar_13 * tmpvar_13)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_17;
  tmpvar_17 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * (tmpvar_14 * tmpvar_14)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_19;
  tmpvar_19 = sqrt(((_DensityFactorC * (tmpvar_15 * tmpvar_15)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  color_1.w = (_Color.w * clamp (((((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_16 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_16 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_17 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_17 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC)) + ((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_18 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_19 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC))) + (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_10 + _DensityCutoffOffset)))), 0.0, 1.0) * ((_Visibility * tmpvar_9) * pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * (tmpvar_10 + sqrt(dot (arg0_11, arg0_11)))) + _DensityVisibilityOffset)))))), 0.0, 1.0));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_Scale]
"vs_3_0
; 24 ALU
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
dp4 r0.w, v0, c2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
mov o4.xyz, r0
add r0.xyz, r0, -c12
mov o0, r1
mul o5.xyz, r0, c15.x
mov o1.z, -r0.w
mov o1.w, r2.x
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 240 // 196 used size, 23 vars
Float 192 [_Scale]
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
// 24 instructions, 2 temp regs, 0 temp arrays:
// ALU 19 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedlkcedfgfmjkmhaanemnohoanianildkiabaaaaaapeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiadaaaaeaaaabaa
ogaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
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
acaaaaaaapaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadoaaaaab"
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 451
v2f vert( in appdata_t v ) {
    #line 453
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 461
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 440
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 444
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 448
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 473
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    #line 477
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    #line 481
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    #line 485
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    #line 489
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    #line 493
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
    color.w *= xll_saturate_f(depth);
    #line 497
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
uniform float _Scale;
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
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
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
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityCutoffScale;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffBase;
uniform float _DensityVisibilityOffset;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityBase;
uniform float _Visibility;
uniform float _Scale;
uniform float _DensityFactorE;
uniform float _DensityFactorD;
uniform float _DensityFactorC;
uniform float _DensityFactorB;
uniform float _DensityFactorA;
uniform float _OceanRadius;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = (_Scale * _OceanRadius);
  float tmpvar_9;
  tmpvar_9 = min (mix (tmpvar_2, (tmpvar_4 - sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_6))), (float((tmpvar_8 >= tmpvar_5)) * float((tmpvar_4 >= 0.0)))), tmpvar_2);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  vec3 arg0_11;
  arg0_11 = ((_WorldSpaceCameraPos + (tmpvar_9 * tmpvar_3)) - ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos));
  float tmpvar_12;
  tmpvar_12 = float((tmpvar_4 >= 0.0));
  float tmpvar_13;
  tmpvar_13 = mix ((tmpvar_9 + tmpvar_7), max (0.0, (tmpvar_9 - tmpvar_4)), tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = (tmpvar_12 * tmpvar_4);
  float tmpvar_15;
  tmpvar_15 = mix (tmpvar_7, max (0.0, (tmpvar_4 - tmpvar_9)), tmpvar_12);
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityFactorC * (tmpvar_13 * tmpvar_13)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_17;
  tmpvar_17 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * (tmpvar_14 * tmpvar_14)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_19;
  tmpvar_19 = sqrt(((_DensityFactorC * (tmpvar_15 * tmpvar_15)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  color_1.w = (_Color.w * clamp (((((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_16 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_16 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_17 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_17 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC)) + ((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_18 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_19 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC))) + (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_10 + _DensityCutoffOffset)))), 0.0, 1.0) * ((_Visibility * tmpvar_9) * pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * (tmpvar_10 + sqrt(dot (arg0_11, arg0_11)))) + _DensityVisibilityOffset)))))), 0.0, 1.0));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_Scale]
"vs_3_0
; 24 ALU
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
dp4 r0.w, v0, c2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
mov o4.xyz, r0
add r0.xyz, r0, -c12
mov o0, r1
mul o5.xyz, r0, c15.x
mov o1.z, -r0.w
mov o1.w, r2.x
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 240 // 196 used size, 23 vars
Float 192 [_Scale]
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
// 24 instructions, 2 temp regs, 0 temp arrays:
// ALU 19 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedlkcedfgfmjkmhaanemnohoanianildkiabaaaaaapeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiadaaaaeaaaabaa
ogaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
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
acaaaaaaapaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadoaaaaab"
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 451
v2f vert( in appdata_t v ) {
    #line 453
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 461
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 440
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 444
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 448
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 473
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    #line 477
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    #line 481
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    #line 485
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    #line 489
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    #line 493
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
    color.w *= xll_saturate_f(depth);
    #line 497
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
uniform float _Scale;
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
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityCutoffScale;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffBase;
uniform float _DensityVisibilityOffset;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityBase;
uniform float _Visibility;
uniform float _Scale;
uniform float _DensityFactorE;
uniform float _DensityFactorD;
uniform float _DensityFactorC;
uniform float _DensityFactorB;
uniform float _DensityFactorA;
uniform float _OceanRadius;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = (_Scale * _OceanRadius);
  float tmpvar_9;
  tmpvar_9 = min (mix (tmpvar_2, (tmpvar_4 - sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_6))), (float((tmpvar_8 >= tmpvar_5)) * float((tmpvar_4 >= 0.0)))), tmpvar_2);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  vec3 arg0_11;
  arg0_11 = ((_WorldSpaceCameraPos + (tmpvar_9 * tmpvar_3)) - ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos));
  float tmpvar_12;
  tmpvar_12 = float((tmpvar_4 >= 0.0));
  float tmpvar_13;
  tmpvar_13 = mix ((tmpvar_9 + tmpvar_7), max (0.0, (tmpvar_9 - tmpvar_4)), tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = (tmpvar_12 * tmpvar_4);
  float tmpvar_15;
  tmpvar_15 = mix (tmpvar_7, max (0.0, (tmpvar_4 - tmpvar_9)), tmpvar_12);
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityFactorC * (tmpvar_13 * tmpvar_13)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_17;
  tmpvar_17 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * (tmpvar_14 * tmpvar_14)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_19;
  tmpvar_19 = sqrt(((_DensityFactorC * (tmpvar_15 * tmpvar_15)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  color_1.w = (_Color.w * clamp (((((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_16 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_16 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_17 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_17 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC)) + ((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_18 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_19 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC))) + (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_10 + _DensityCutoffOffset)))), 0.0, 1.0) * ((_Visibility * tmpvar_9) * pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * (tmpvar_10 + sqrt(dot (arg0_11, arg0_11)))) + _DensityVisibilityOffset)))))), 0.0, 1.0));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_Scale]
"vs_3_0
; 21 ALU
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
dp4 r0.w, v0, c2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
mov o3.xyz, r0
add r0.xyz, r0, -c12
mad o1.xy, r1.z, c14.zwzw, r1
mul o4.xyz, r0, c15.x
mov o1.z, -r0.w
mov o1.w, r1
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 176 // 132 used size, 22 vars
Float 128 [_Scale]
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
// 22 instructions, 2 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedidimabcfglhlknbhdnmigagegmhkkhjiabaaaaaakaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmadaaaaeaaaabaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
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
hccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaai
hccabaaaaeaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadoaaaaab
"
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 411
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 397
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 401
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 405
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 409
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 427
#line 457
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 442
v2f vert( in appdata_t v ) {
    #line 444
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 448
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 452
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 411
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 397
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 401
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 405
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 409
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 427
#line 457
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 427
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 431
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 435
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 439
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 457
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 461
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    #line 465
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    #line 469
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    #line 473
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    #line 477
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    #line 481
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    #line 485
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
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
uniform float _Scale;
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
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
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
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_7;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = ((tmpvar_3 - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityCutoffScale;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffBase;
uniform float _DensityVisibilityOffset;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityBase;
uniform float _Visibility;
uniform float _Scale;
uniform float _DensityFactorE;
uniform float _DensityFactorD;
uniform float _DensityFactorC;
uniform float _DensityFactorB;
uniform float _DensityFactorA;
uniform float _OceanRadius;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = (_Scale * _OceanRadius);
  float tmpvar_9;
  tmpvar_9 = min (mix (tmpvar_2, (tmpvar_4 - sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_6))), (float((tmpvar_8 >= tmpvar_5)) * float((tmpvar_4 >= 0.0)))), tmpvar_2);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  vec3 arg0_11;
  arg0_11 = ((_WorldSpaceCameraPos + (tmpvar_9 * tmpvar_3)) - ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos));
  float tmpvar_12;
  tmpvar_12 = float((tmpvar_4 >= 0.0));
  float tmpvar_13;
  tmpvar_13 = mix ((tmpvar_9 + tmpvar_7), max (0.0, (tmpvar_9 - tmpvar_4)), tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = (tmpvar_12 * tmpvar_4);
  float tmpvar_15;
  tmpvar_15 = mix (tmpvar_7, max (0.0, (tmpvar_4 - tmpvar_9)), tmpvar_12);
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityFactorC * (tmpvar_13 * tmpvar_13)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_17;
  tmpvar_17 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * (tmpvar_14 * tmpvar_14)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_19;
  tmpvar_19 = sqrt(((_DensityFactorC * (tmpvar_15 * tmpvar_15)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  color_1.w = (_Color.w * clamp (((((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_16 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_16 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_17 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_17 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC)) + ((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_18 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_19 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC))) + (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_10 + _DensityCutoffOffset)))), 0.0, 1.0) * ((_Visibility * tmpvar_9) * pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * (tmpvar_10 + sqrt(dot (arg0_11, arg0_11)))) + _DensityVisibilityOffset)))))), 0.0, 1.0));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_Scale]
"vs_3_0
; 24 ALU
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
dp4 r0.w, v0, c2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
mov o4.xyz, r0
add r0.xyz, r0, -c12
mov o0, r1
mul o5.xyz, r0, c15.x
mov o1.z, -r0.w
mov o1.w, r2.x
dp4 o2.z, v0, c10
dp4 o2.y, v0, c9
dp4 o2.x, v0, c8
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 240 // 196 used size, 23 vars
Float 192 [_Scale]
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
// 24 instructions, 2 temp regs, 0 temp arrays:
// ALU 19 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedlkcedfgfmjkmhaanemnohoanianildkiabaaaaaapeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiadaaaaeaaaabaa
ogaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
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
acaaaaaaapaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadoaaaaab"
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 451
v2f vert( in appdata_t v ) {
    #line 453
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 461
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 440
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 444
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 448
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 473
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    #line 477
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    #line 481
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    #line 485
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    #line 489
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    #line 493
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
    color.w *= xll_saturate_f(depth);
    #line 497
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 451
v2f vert( in appdata_t v ) {
    #line 453
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 461
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 440
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 444
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 448
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 473
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    #line 477
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    #line 481
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    #line 485
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    #line 489
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    #line 493
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
    color.w *= xll_saturate_f(depth);
    #line 497
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 451
v2f vert( in appdata_t v ) {
    #line 453
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 461
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 440
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 444
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 448
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 473
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    #line 477
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    #line 481
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    #line 485
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    #line 489
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    #line 493
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
    color.w *= xll_saturate_f(depth);
    #line 497
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 451
v2f vert( in appdata_t v ) {
    #line 453
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 461
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 440
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 444
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 448
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 473
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    #line 477
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    #line 481
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    #line 485
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    #line 489
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    #line 493
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
    color.w *= xll_saturate_f(depth);
    #line 497
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 451
v2f vert( in appdata_t v ) {
    #line 453
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.worldVert = vertexPos;
    o.worldOrigin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 461
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 440
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 444
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 448
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 473
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    #line 477
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    #line 481
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    #line 485
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    #line 489
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    #line 493
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
    color.w *= xll_saturate_f(depth);
    #line 497
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
uniform float _Scale;
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
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityCutoffScale;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffBase;
uniform float _DensityVisibilityOffset;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityBase;
uniform float _Visibility;
uniform float _Scale;
uniform float _DensityFactorE;
uniform float _DensityFactorD;
uniform float _DensityFactorC;
uniform float _DensityFactorB;
uniform float _DensityFactorA;
uniform float _OceanRadius;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = (_Scale * _OceanRadius);
  float tmpvar_9;
  tmpvar_9 = min (mix (tmpvar_2, (tmpvar_4 - sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_6))), (float((tmpvar_8 >= tmpvar_5)) * float((tmpvar_4 >= 0.0)))), tmpvar_2);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  vec3 arg0_11;
  arg0_11 = ((_WorldSpaceCameraPos + (tmpvar_9 * tmpvar_3)) - ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos));
  float tmpvar_12;
  tmpvar_12 = float((tmpvar_4 >= 0.0));
  float tmpvar_13;
  tmpvar_13 = mix ((tmpvar_9 + tmpvar_7), max (0.0, (tmpvar_9 - tmpvar_4)), tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = (tmpvar_12 * tmpvar_4);
  float tmpvar_15;
  tmpvar_15 = mix (tmpvar_7, max (0.0, (tmpvar_4 - tmpvar_9)), tmpvar_12);
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityFactorC * (tmpvar_13 * tmpvar_13)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_17;
  tmpvar_17 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * (tmpvar_14 * tmpvar_14)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_19;
  tmpvar_19 = sqrt(((_DensityFactorC * (tmpvar_15 * tmpvar_15)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  color_1.w = (_Color.w * clamp (((((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_16 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_16 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_17 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_17 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC)) + ((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_18 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_19 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC))) + (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_10 + _DensityCutoffOffset)))), 0.0, 1.0) * ((_Visibility * tmpvar_9) * pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * (tmpvar_10 + sqrt(dot (arg0_11, arg0_11)))) + _DensityVisibilityOffset)))))), 0.0, 1.0));
  gl_FragData[0] = color_1;
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
Float 16 [_Scale]
"vs_3_0
; 19 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c17.x
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
mov r0.xyz, c15
add r0.xyz, -c12, r0
dp4 r0.w, v0, c2
mad o1.xy, r1.z, c14.zwzw, r1
mov o3.xyz, c15
mul o4.xyz, r0, c16.x
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
ConstBuffer "$Globals" 176 // 132 used size, 22 vars
Vector 96 [_PlanetOrigin] 3
Float 128 [_Scale]
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
// 22 instructions, 2 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedjfefbbjbbihnknepiajpnlopdgmgkanaabaaaaaakaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmadaaaaeaaaabaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
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
hccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaai
hccabaaaaeaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadoaaaaab
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 411
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 397
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 401
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 405
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 409
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 427
#line 457
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 442
v2f vert( in appdata_t v ) {
    #line 444
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 448
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 452
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 411
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 397
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 401
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 405
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 409
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 427
#line 457
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 427
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 431
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 435
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 439
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 457
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 461
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    #line 465
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    #line 469
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    #line 473
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    #line 477
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    #line 481
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    #line 485
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
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
uniform float _Scale;
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
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityCutoffScale;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffBase;
uniform float _DensityVisibilityOffset;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityBase;
uniform float _Visibility;
uniform float _Scale;
uniform float _DensityFactorE;
uniform float _DensityFactorD;
uniform float _DensityFactorC;
uniform float _DensityFactorB;
uniform float _DensityFactorA;
uniform float _OceanRadius;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = (_Scale * _OceanRadius);
  float tmpvar_9;
  tmpvar_9 = min (mix (tmpvar_2, (tmpvar_4 - sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_6))), (float((tmpvar_8 >= tmpvar_5)) * float((tmpvar_4 >= 0.0)))), tmpvar_2);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  vec3 arg0_11;
  arg0_11 = ((_WorldSpaceCameraPos + (tmpvar_9 * tmpvar_3)) - ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos));
  float tmpvar_12;
  tmpvar_12 = float((tmpvar_4 >= 0.0));
  float tmpvar_13;
  tmpvar_13 = mix ((tmpvar_9 + tmpvar_7), max (0.0, (tmpvar_9 - tmpvar_4)), tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = (tmpvar_12 * tmpvar_4);
  float tmpvar_15;
  tmpvar_15 = mix (tmpvar_7, max (0.0, (tmpvar_4 - tmpvar_9)), tmpvar_12);
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityFactorC * (tmpvar_13 * tmpvar_13)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_17;
  tmpvar_17 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * (tmpvar_14 * tmpvar_14)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_19;
  tmpvar_19 = sqrt(((_DensityFactorC * (tmpvar_15 * tmpvar_15)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  color_1.w = (_Color.w * clamp (((((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_16 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_16 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_17 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_17 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC)) + ((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_18 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_19 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC))) + (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_10 + _DensityCutoffOffset)))), 0.0, 1.0) * ((_Visibility * tmpvar_9) * pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * (tmpvar_10 + sqrt(dot (arg0_11, arg0_11)))) + _DensityVisibilityOffset)))))), 0.0, 1.0));
  gl_FragData[0] = color_1;
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
Float 16 [_Scale]
"vs_3_0
; 19 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c17.x
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
mov r0.xyz, c15
add r0.xyz, -c12, r0
dp4 r0.w, v0, c2
mad o1.xy, r1.z, c14.zwzw, r1
mov o3.xyz, c15
mul o4.xyz, r0, c16.x
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
ConstBuffer "$Globals" 176 // 132 used size, 22 vars
Vector 96 [_PlanetOrigin] 3
Float 128 [_Scale]
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
// 22 instructions, 2 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedjfefbbjbbihnknepiajpnlopdgmgkanaabaaaaaakaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmadaaaaeaaaabaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
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
hccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaai
hccabaaaaeaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadoaaaaab
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 411
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 397
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 401
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 405
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 409
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 427
#line 457
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 442
v2f vert( in appdata_t v ) {
    #line 444
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 448
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 452
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 411
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 397
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 401
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 405
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 409
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 427
#line 457
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 427
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 431
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 435
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 439
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 457
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 461
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    #line 465
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    #line 469
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    #line 473
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    #line 477
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    #line 481
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    #line 485
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
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
uniform float _Scale;
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
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityCutoffScale;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffBase;
uniform float _DensityVisibilityOffset;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityBase;
uniform float _Visibility;
uniform float _Scale;
uniform float _DensityFactorE;
uniform float _DensityFactorD;
uniform float _DensityFactorC;
uniform float _DensityFactorB;
uniform float _DensityFactorA;
uniform float _OceanRadius;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = (_Scale * _OceanRadius);
  float tmpvar_9;
  tmpvar_9 = min (mix (tmpvar_2, (tmpvar_4 - sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_6))), (float((tmpvar_8 >= tmpvar_5)) * float((tmpvar_4 >= 0.0)))), tmpvar_2);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  vec3 arg0_11;
  arg0_11 = ((_WorldSpaceCameraPos + (tmpvar_9 * tmpvar_3)) - ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos));
  float tmpvar_12;
  tmpvar_12 = float((tmpvar_4 >= 0.0));
  float tmpvar_13;
  tmpvar_13 = mix ((tmpvar_9 + tmpvar_7), max (0.0, (tmpvar_9 - tmpvar_4)), tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = (tmpvar_12 * tmpvar_4);
  float tmpvar_15;
  tmpvar_15 = mix (tmpvar_7, max (0.0, (tmpvar_4 - tmpvar_9)), tmpvar_12);
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityFactorC * (tmpvar_13 * tmpvar_13)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_17;
  tmpvar_17 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * (tmpvar_14 * tmpvar_14)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_19;
  tmpvar_19 = sqrt(((_DensityFactorC * (tmpvar_15 * tmpvar_15)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  color_1.w = (_Color.w * clamp (((((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_16 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_16 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_17 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_17 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC)) + ((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_18 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_19 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC))) + (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_10 + _DensityCutoffOffset)))), 0.0, 1.0) * ((_Visibility * tmpvar_9) * pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * (tmpvar_10 + sqrt(dot (arg0_11, arg0_11)))) + _DensityVisibilityOffset)))))), 0.0, 1.0));
  gl_FragData[0] = color_1;
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
Float 16 [_Scale]
"vs_3_0
; 19 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c17.x
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
mov r0.xyz, c15
add r0.xyz, -c12, r0
dp4 r0.w, v0, c2
mad o1.xy, r1.z, c14.zwzw, r1
mov o3.xyz, c15
mul o4.xyz, r0, c16.x
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
ConstBuffer "$Globals" 176 // 132 used size, 22 vars
Vector 96 [_PlanetOrigin] 3
Float 128 [_Scale]
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
// 22 instructions, 2 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedjfefbbjbbihnknepiajpnlopdgmgkanaabaaaaaakaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmadaaaaeaaaabaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
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
hccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaai
hccabaaaaeaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadoaaaaab
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 411
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 397
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 401
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 405
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 409
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 427
#line 457
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 442
v2f vert( in appdata_t v ) {
    #line 444
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 448
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 452
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 411
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 397
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 401
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 405
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 409
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 427
#line 457
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 427
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 431
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 435
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 439
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 457
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 461
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    #line 465
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    #line 469
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    #line 473
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    #line 477
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    #line 481
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    #line 485
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
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
uniform float _Scale;
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
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityCutoffScale;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffBase;
uniform float _DensityVisibilityOffset;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityBase;
uniform float _Visibility;
uniform float _Scale;
uniform float _DensityFactorE;
uniform float _DensityFactorD;
uniform float _DensityFactorC;
uniform float _DensityFactorB;
uniform float _DensityFactorA;
uniform float _OceanRadius;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = (_Scale * _OceanRadius);
  float tmpvar_9;
  tmpvar_9 = min (mix (tmpvar_2, (tmpvar_4 - sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_6))), (float((tmpvar_8 >= tmpvar_5)) * float((tmpvar_4 >= 0.0)))), tmpvar_2);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  vec3 arg0_11;
  arg0_11 = ((_WorldSpaceCameraPos + (tmpvar_9 * tmpvar_3)) - ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos));
  float tmpvar_12;
  tmpvar_12 = float((tmpvar_4 >= 0.0));
  float tmpvar_13;
  tmpvar_13 = mix ((tmpvar_9 + tmpvar_7), max (0.0, (tmpvar_9 - tmpvar_4)), tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = (tmpvar_12 * tmpvar_4);
  float tmpvar_15;
  tmpvar_15 = mix (tmpvar_7, max (0.0, (tmpvar_4 - tmpvar_9)), tmpvar_12);
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityFactorC * (tmpvar_13 * tmpvar_13)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_17;
  tmpvar_17 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * (tmpvar_14 * tmpvar_14)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_19;
  tmpvar_19 = sqrt(((_DensityFactorC * (tmpvar_15 * tmpvar_15)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  color_1.w = (_Color.w * clamp (((((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_16 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_16 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_17 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_17 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC)) + ((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_18 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_19 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC))) + (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_10 + _DensityCutoffOffset)))), 0.0, 1.0) * ((_Visibility * tmpvar_9) * pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * (tmpvar_10 + sqrt(dot (arg0_11, arg0_11)))) + _DensityVisibilityOffset)))))), 0.0, 1.0));
  gl_FragData[0] = color_1;
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
Float 16 [_Scale]
"vs_3_0
; 22 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.x, v0, c7
mov r1.w, r2.x
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
mov r0.xyz, c15
add r0.xyz, -c12, r0
dp4 r0.w, v0, c2
mov o0, r1
mov o4.xyz, c15
mul o5.xyz, r0, c16.x
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
ConstBuffer "$Globals" 240 // 196 used size, 23 vars
Vector 160 [_PlanetOrigin] 3
Float 192 [_Scale]
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
// 24 instructions, 2 temp regs, 0 temp arrays:
// ALU 19 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbojgppckidndjllokgfgcdfcdknpmkinabaaaaaapeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiadaaaaeaaaabaa
ogaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaakaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaakaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadoaaaaab"
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 451
v2f vert( in appdata_t v ) {
    #line 453
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 461
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 440
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 444
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 448
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 473
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    #line 477
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    #line 481
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    #line 485
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    #line 489
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    #line 493
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
    color.w *= xll_saturate_f(depth);
    #line 497
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
uniform float _Scale;
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
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityCutoffScale;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffBase;
uniform float _DensityVisibilityOffset;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityBase;
uniform float _Visibility;
uniform float _Scale;
uniform float _DensityFactorE;
uniform float _DensityFactorD;
uniform float _DensityFactorC;
uniform float _DensityFactorB;
uniform float _DensityFactorA;
uniform float _OceanRadius;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = (_Scale * _OceanRadius);
  float tmpvar_9;
  tmpvar_9 = min (mix (tmpvar_2, (tmpvar_4 - sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_6))), (float((tmpvar_8 >= tmpvar_5)) * float((tmpvar_4 >= 0.0)))), tmpvar_2);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  vec3 arg0_11;
  arg0_11 = ((_WorldSpaceCameraPos + (tmpvar_9 * tmpvar_3)) - ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos));
  float tmpvar_12;
  tmpvar_12 = float((tmpvar_4 >= 0.0));
  float tmpvar_13;
  tmpvar_13 = mix ((tmpvar_9 + tmpvar_7), max (0.0, (tmpvar_9 - tmpvar_4)), tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = (tmpvar_12 * tmpvar_4);
  float tmpvar_15;
  tmpvar_15 = mix (tmpvar_7, max (0.0, (tmpvar_4 - tmpvar_9)), tmpvar_12);
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityFactorC * (tmpvar_13 * tmpvar_13)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_17;
  tmpvar_17 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * (tmpvar_14 * tmpvar_14)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_19;
  tmpvar_19 = sqrt(((_DensityFactorC * (tmpvar_15 * tmpvar_15)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  color_1.w = (_Color.w * clamp (((((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_16 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_16 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_17 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_17 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC)) + ((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_18 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_19 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC))) + (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_10 + _DensityCutoffOffset)))), 0.0, 1.0) * ((_Visibility * tmpvar_9) * pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * (tmpvar_10 + sqrt(dot (arg0_11, arg0_11)))) + _DensityVisibilityOffset)))))), 0.0, 1.0));
  gl_FragData[0] = color_1;
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
Float 16 [_Scale]
"vs_3_0
; 22 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.x, v0, c7
mov r1.w, r2.x
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
mov r0.xyz, c15
add r0.xyz, -c12, r0
dp4 r0.w, v0, c2
mov o0, r1
mov o4.xyz, c15
mul o5.xyz, r0, c16.x
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
ConstBuffer "$Globals" 240 // 196 used size, 23 vars
Vector 160 [_PlanetOrigin] 3
Float 192 [_Scale]
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
// 24 instructions, 2 temp regs, 0 temp arrays:
// ALU 19 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbojgppckidndjllokgfgcdfcdknpmkinabaaaaaapeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiadaaaaeaaaabaa
ogaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaakaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaakaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadoaaaaab"
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 451
v2f vert( in appdata_t v ) {
    #line 453
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 461
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 440
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 444
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 448
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 473
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    #line 477
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    #line 481
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    #line 485
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    #line 489
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    #line 493
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
    color.w *= xll_saturate_f(depth);
    #line 497
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
uniform float _Scale;
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
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityCutoffScale;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffBase;
uniform float _DensityVisibilityOffset;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityBase;
uniform float _Visibility;
uniform float _Scale;
uniform float _DensityFactorE;
uniform float _DensityFactorD;
uniform float _DensityFactorC;
uniform float _DensityFactorB;
uniform float _DensityFactorA;
uniform float _OceanRadius;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = (_Scale * _OceanRadius);
  float tmpvar_9;
  tmpvar_9 = min (mix (tmpvar_2, (tmpvar_4 - sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_6))), (float((tmpvar_8 >= tmpvar_5)) * float((tmpvar_4 >= 0.0)))), tmpvar_2);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  vec3 arg0_11;
  arg0_11 = ((_WorldSpaceCameraPos + (tmpvar_9 * tmpvar_3)) - ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos));
  float tmpvar_12;
  tmpvar_12 = float((tmpvar_4 >= 0.0));
  float tmpvar_13;
  tmpvar_13 = mix ((tmpvar_9 + tmpvar_7), max (0.0, (tmpvar_9 - tmpvar_4)), tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = (tmpvar_12 * tmpvar_4);
  float tmpvar_15;
  tmpvar_15 = mix (tmpvar_7, max (0.0, (tmpvar_4 - tmpvar_9)), tmpvar_12);
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityFactorC * (tmpvar_13 * tmpvar_13)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_17;
  tmpvar_17 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * (tmpvar_14 * tmpvar_14)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_19;
  tmpvar_19 = sqrt(((_DensityFactorC * (tmpvar_15 * tmpvar_15)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  color_1.w = (_Color.w * clamp (((((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_16 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_16 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_17 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_17 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC)) + ((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_18 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_19 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC))) + (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_10 + _DensityCutoffOffset)))), 0.0, 1.0) * ((_Visibility * tmpvar_9) * pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * (tmpvar_10 + sqrt(dot (arg0_11, arg0_11)))) + _DensityVisibilityOffset)))))), 0.0, 1.0));
  gl_FragData[0] = color_1;
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
Float 16 [_Scale]
"vs_3_0
; 22 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.x, v0, c7
mov r1.w, r2.x
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
mov r0.xyz, c15
add r0.xyz, -c12, r0
dp4 r0.w, v0, c2
mov o0, r1
mov o4.xyz, c15
mul o5.xyz, r0, c16.x
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
ConstBuffer "$Globals" 240 // 196 used size, 23 vars
Vector 160 [_PlanetOrigin] 3
Float 192 [_Scale]
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
// 24 instructions, 2 temp regs, 0 temp arrays:
// ALU 19 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbojgppckidndjllokgfgcdfcdknpmkinabaaaaaapeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiadaaaaeaaaabaa
ogaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaakaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaakaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadoaaaaab"
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 451
v2f vert( in appdata_t v ) {
    #line 453
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 461
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 440
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 444
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 448
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 473
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    #line 477
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    #line 481
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    #line 485
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    #line 489
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    #line 493
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
    color.w *= xll_saturate_f(depth);
    #line 497
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
uniform float _Scale;
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
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityCutoffScale;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffBase;
uniform float _DensityVisibilityOffset;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityBase;
uniform float _Visibility;
uniform float _Scale;
uniform float _DensityFactorE;
uniform float _DensityFactorD;
uniform float _DensityFactorC;
uniform float _DensityFactorB;
uniform float _DensityFactorA;
uniform float _OceanRadius;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = (_Scale * _OceanRadius);
  float tmpvar_9;
  tmpvar_9 = min (mix (tmpvar_2, (tmpvar_4 - sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_6))), (float((tmpvar_8 >= tmpvar_5)) * float((tmpvar_4 >= 0.0)))), tmpvar_2);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  vec3 arg0_11;
  arg0_11 = ((_WorldSpaceCameraPos + (tmpvar_9 * tmpvar_3)) - ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos));
  float tmpvar_12;
  tmpvar_12 = float((tmpvar_4 >= 0.0));
  float tmpvar_13;
  tmpvar_13 = mix ((tmpvar_9 + tmpvar_7), max (0.0, (tmpvar_9 - tmpvar_4)), tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = (tmpvar_12 * tmpvar_4);
  float tmpvar_15;
  tmpvar_15 = mix (tmpvar_7, max (0.0, (tmpvar_4 - tmpvar_9)), tmpvar_12);
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityFactorC * (tmpvar_13 * tmpvar_13)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_17;
  tmpvar_17 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * (tmpvar_14 * tmpvar_14)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_19;
  tmpvar_19 = sqrt(((_DensityFactorC * (tmpvar_15 * tmpvar_15)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  color_1.w = (_Color.w * clamp (((((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_16 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_16 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_17 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_17 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC)) + ((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_18 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_19 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC))) + (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_10 + _DensityCutoffOffset)))), 0.0, 1.0) * ((_Visibility * tmpvar_9) * pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * (tmpvar_10 + sqrt(dot (arg0_11, arg0_11)))) + _DensityVisibilityOffset)))))), 0.0, 1.0));
  gl_FragData[0] = color_1;
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
Float 16 [_Scale]
"vs_3_0
; 19 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r1.w, v0, c7
mov r0.w, r1
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c17.x
dp4 r0.z, v0, c6
mov o0, r0
mul r1.y, r1, c13.x
mov r0.xyz, c15
add r0.xyz, -c12, r0
dp4 r0.w, v0, c2
mad o1.xy, r1.z, c14.zwzw, r1
mov o3.xyz, c15
mul o4.xyz, r0, c16.x
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
ConstBuffer "$Globals" 176 // 132 used size, 22 vars
Vector 96 [_PlanetOrigin] 3
Float 128 [_Scale]
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
// 22 instructions, 2 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedjfefbbjbbihnknepiajpnlopdgmgkanaabaaaaaakaaeaaaaadaaaaaa
cmaaaaaajmaaaaaadmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaimaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fmadaaaaeaaaabaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
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
hccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaai
hccabaaaaeaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadoaaaaab
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 411
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 397
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 401
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 405
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 409
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 427
#line 457
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 442
v2f vert( in appdata_t v ) {
    #line 444
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 448
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 452
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 411
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 397
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 401
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 405
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 409
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 427
#line 457
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 427
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 431
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 435
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 439
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 457
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    #line 461
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    #line 465
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    #line 469
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    #line 473
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    #line 477
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    #line 481
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    #line 485
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
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
uniform float _Scale;
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
  xlv_TEXCOORD5 = ((_PlanetOrigin - _WorldSpaceCameraPos) * _Scale);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DensityCutoffScale;
uniform float _DensityCutoffOffset;
uniform float _DensityCutoffPow;
uniform float _DensityCutoffBase;
uniform float _DensityVisibilityOffset;
uniform float _DensityVisibilityPow;
uniform float _DensityVisibilityBase;
uniform float _Visibility;
uniform float _Scale;
uniform float _DensityFactorE;
uniform float _DensityFactorD;
uniform float _DensityFactorC;
uniform float _DensityFactorB;
uniform float _DensityFactorA;
uniform float _OceanRadius;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  color_1.xyz = _Color.xyz;
  float tmpvar_2;
  tmpvar_2 = ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))) * _Scale);
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD5, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_4 * tmpvar_4)));
  float tmpvar_6;
  tmpvar_6 = pow (tmpvar_5, 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = (_Scale * _OceanRadius);
  float tmpvar_9;
  tmpvar_9 = min (mix (tmpvar_2, (tmpvar_4 - sqrt(((tmpvar_8 * tmpvar_8) - tmpvar_6))), (float((tmpvar_8 >= tmpvar_5)) * float((tmpvar_4 >= 0.0)))), tmpvar_2);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (xlv_TEXCOORD5, xlv_TEXCOORD5));
  vec3 arg0_11;
  arg0_11 = ((_WorldSpaceCameraPos + (tmpvar_9 * tmpvar_3)) - ((_Scale * (xlv_TEXCOORD4 - _WorldSpaceCameraPos)) + _WorldSpaceCameraPos));
  float tmpvar_12;
  tmpvar_12 = float((tmpvar_4 >= 0.0));
  float tmpvar_13;
  tmpvar_13 = mix ((tmpvar_9 + tmpvar_7), max (0.0, (tmpvar_9 - tmpvar_4)), tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = (tmpvar_12 * tmpvar_4);
  float tmpvar_15;
  tmpvar_15 = mix (tmpvar_7, max (0.0, (tmpvar_4 - tmpvar_9)), tmpvar_12);
  float tmpvar_16;
  tmpvar_16 = sqrt(((_DensityFactorC * (tmpvar_13 * tmpvar_13)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_17;
  tmpvar_17 = sqrt((_DensityFactorB * (tmpvar_5 * tmpvar_5)));
  float tmpvar_18;
  tmpvar_18 = sqrt(((_DensityFactorC * (tmpvar_14 * tmpvar_14)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  float tmpvar_19;
  tmpvar_19 = sqrt(((_DensityFactorC * (tmpvar_15 * tmpvar_15)) + (_DensityFactorB * (tmpvar_5 * tmpvar_5))));
  color_1.w = (_Color.w * clamp (((((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_16 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_16 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_17 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_17 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC)) + ((((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_18 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_18 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC) - (((((-2.0 * _DensityFactorA) * _DensityFactorD) * (tmpvar_19 + _DensityFactorD)) * pow (2.71828, (-((tmpvar_19 + _DensityFactorE)) / _DensityFactorD))) / _DensityFactorC))) + (clamp ((_DensityCutoffScale * pow (_DensityCutoffBase, (-(_DensityCutoffPow) * (tmpvar_10 + _DensityCutoffOffset)))), 0.0, 1.0) * ((_Visibility * tmpvar_9) * pow (_DensityVisibilityBase, (-(_DensityVisibilityPow) * ((0.5 * (tmpvar_10 + sqrt(dot (arg0_11, arg0_11)))) + _DensityVisibilityOffset)))))), 0.0, 1.0));
  gl_FragData[0] = color_1;
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
Float 16 [_Scale]
"vs_3_0
; 22 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r2.x, v0, c7
mov r1.w, r2.x
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r0.xyz, r1.xyww, c17.x
dp4 r1.z, v0, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov o3, r0
mov o1.xy, r0
mov r0.xyz, c15
add r0.xyz, -c12, r0
dp4 r0.w, v0, c2
mov o0, r1
mov o4.xyz, c15
mul o5.xyz, r0, c16.x
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
ConstBuffer "$Globals" 240 // 196 used size, 23 vars
Vector 160 [_PlanetOrigin] 3
Float 192 [_Scale]
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
// 24 instructions, 2 temp regs, 0 temp arrays:
// ALU 19 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbojgppckidndjllokgfgcdfcdknpmkinabaaaaaapeaeaaaaadaaaaaa
cmaaaaaajmaaaaaafeabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiadaaaaeaaaabaa
ogaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
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
aaaaaaaaakaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaakaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadoaaaaab"
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 451
v2f vert( in appdata_t v ) {
    #line 453
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 461
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 440
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 444
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 448
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 473
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    #line 477
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    #line 481
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    #line 485
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    #line 489
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    #line 493
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
    color.w *= xll_saturate_f(depth);
    #line 497
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 451
v2f vert( in appdata_t v ) {
    #line 453
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 461
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 440
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 444
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 448
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 473
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    #line 477
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    #line 481
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    #line 485
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    #line 489
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    #line 493
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
    color.w *= xll_saturate_f(depth);
    #line 497
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 451
v2f vert( in appdata_t v ) {
    #line 453
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 461
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 440
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 444
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 448
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 473
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    #line 477
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    #line 481
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    #line 485
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    #line 489
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    #line 493
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
    color.w *= xll_saturate_f(depth);
    #line 497
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 451
v2f vert( in appdata_t v ) {
    #line 453
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 461
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 440
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 444
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 448
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 473
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    #line 477
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    #line 481
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    #line 485
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    #line 489
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    #line 493
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
    color.w *= xll_saturate_f(depth);
    #line 497
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 451
v2f vert( in appdata_t v ) {
    #line 453
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.worldVert = vertexPos;
    o.worldOrigin = _PlanetOrigin;
    o.L = (o.worldOrigin - _WorldSpaceCameraPos.xyz);
    o.L *= _Scale;
    #line 461
    o.scrPos = ComputeScreenPos( o.pos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
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
#line 426
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec4 _ShadowCoord;
    highp vec3 worldOrigin;
    highp vec3 L;
};
#line 419
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
uniform highp float _OceanRadius;
uniform highp float _SphereRadius;
uniform highp vec3 _PlanetOrigin;
#line 405
uniform highp float _DensityFactorA;
uniform highp float _DensityFactorB;
uniform highp float _DensityFactorC;
uniform highp float _DensityFactorD;
#line 409
uniform highp float _DensityFactorE;
uniform highp float _Scale;
uniform highp float _Visibility;
uniform highp float _DensityVisibilityBase;
#line 413
uniform highp float _DensityVisibilityPow;
uniform highp float _DensityVisibilityOffset;
uniform highp float _DensityCutoffBase;
uniform highp float _DensityCutoffPow;
#line 417
uniform highp float _DensityCutoffOffset;
uniform highp float _DensityCutoffScale;
#line 436
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 436
highp float atmofunc( in highp float l, in highp float d ) {
    highp float e = 2.71828;
    highp float a = _DensityFactorA;
    #line 440
    highp float b = _DensityFactorB;
    highp float c = _DensityFactorC;
    highp float D = _DensityFactorD;
    highp float f = _DensityFactorE;
    #line 444
    highp float l2 = l;
    l2 *= l2;
    highp float d2 = d;
    d2 *= d2;
    #line 448
    highp float n = sqrt(((c * l2) + (b * d2)));
    return (((((-2.0 * a) * D) * (n + D)) * pow( e, ((-(n + f)) / D))) / c);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color = _Color;
    highp float depth = 1e+32;
    depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = LinearEyeDepth( depth);
    #line 473
    depth *= _Scale;
    mediump vec3 worldDir = normalize((IN.worldVert - _WorldSpaceCameraPos.xyz));
    highp float tc = dot( IN.L, worldDir);
    highp float d = sqrt((dot( IN.L, IN.L) - (tc * tc)));
    #line 477
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( IN.L, IN.L) - d2));
    highp float oceanRadius = (_Scale * _OceanRadius);
    mediump float sphereCheck = (step( d, oceanRadius) * step( 0.0, tc));
    #line 481
    highp float tlc = sqrt(((oceanRadius * oceanRadius) - d2));
    highp float oceanSphereDist = mix( depth, (tc - tlc), sphereCheck);
    depth = min( oceanSphereDist, depth);
    highp float dist = depth;
    #line 485
    highp float alt = length(IN.L);
    highp vec3 scaleOrigin = ((_Scale * (IN.worldOrigin - _WorldSpaceCameraPos.xyz)) + _WorldSpaceCameraPos.xyz);
    highp float altD = length(((_WorldSpaceCameraPos.xyz + (dist * worldDir)) - scaleOrigin));
    highp float altA = (0.5 * (alt + altD));
    #line 489
    sphereCheck = step( 0.0, tc);
    highp float depthL = mix( (depth + td), max( 0.0, (depth - tc)), sphereCheck);
    highp float camL = (sphereCheck * tc);
    highp float subDepthL = mix( td, max( 0.0, (tc - depth)), sphereCheck);
    #line 493
    depth = (atmofunc( depthL, d) - atmofunc( 0.0, d));
    depth += (atmofunc( camL, d) - atmofunc( subDepthL, d));
    depth += (xll_saturate_f((_DensityCutoffScale * pow( _DensityCutoffBase, ((-_DensityCutoffPow) * (alt + _DensityCutoffOffset))))) * ((_Visibility * dist) * pow( _DensityVisibilityBase, ((-_DensityVisibilityPow) * (altA + _DensityVisibilityOffset)))));
    color.w *= xll_saturate_f(depth);
    #line 497
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
//   d3d9 - ALU: 127 to 127, TEX: 1 to 1
//   d3d11 - ALU: 102 to 102, TEX: 1 to 1, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_ZBufferParams]
Vector 2 [_Color]
Float 3 [_OceanRadius]
Float 4 [_DensityFactorA]
Float 5 [_DensityFactorB]
Float 6 [_DensityFactorC]
Float 7 [_DensityFactorD]
Float 8 [_DensityFactorE]
Float 9 [_Scale]
Float 10 [_Visibility]
Float 11 [_DensityVisibilityBase]
Float 12 [_DensityVisibilityPow]
Float 13 [_DensityVisibilityOffset]
Float 14 [_DensityCutoffBase]
Float 15 [_DensityCutoffPow]
Float 16 [_DensityCutoffOffset]
Float 17 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 127 ALU, 1 TEX
dcl_2d s0
def c18, 1.00000000, 0.00000000, 2.71828175, 0.50000000
def c19, -2.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.z, v3, r1
dp3 r2.x, v3, v3
mad r0.x, -r2.z, r2.z, r2
rsq r0.y, r0.x
mov r0.x, c9
cmp r2.w, r2.z, c18.x, c18.y
mul r0.z, c3.x, r0.x
rcp r0.y, r0.y
add r0.x, r0.z, -r0.y
mul r0.y, r0, r0
mad r0.z, r0, r0, -r0.y
cmp r0.x, r0, c18, c18.y
mul r0.w, r0.x, r2
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rsq r0.z, r0.z
rcp r0.x, r0.x
rcp r0.z, r0.z
mul r3.x, r0.y, c5
mul r0.x, r0, c9
add r0.z, r2, -r0
add r0.z, r0, -r0.x
mad r0.z, r0.w, r0, r0.x
add r1.w, r2.x, -r0.y
rsq r0.w, r1.w
min r1.w, r0.z, r0.x
add r0.z, -r2, r1.w
rcp r0.x, r0.w
max r2.y, r0.z, c18
add r0.w, r1, r0.x
add r2.y, r2, -r0.w
mad r0.w, r2.y, r2, r0
mul r0.y, r0.w, r0.w
mad r0.y, r0, c6.x, r3.x
rsq r0.y, r0.y
rcp r0.w, r0.y
mov r0.y, c4.x
mul r2.y, c7.x, r0
add r3.y, r0.w, c7.x
mul r3.z, r2.y, r3.y
max r0.z, -r0, c18.y
add r0.z, -r0.x, r0
mad r0.x, r2.w, r0.z, r0
mul r0.x, r0, r0
mul r2.z, r2, r2.w
mul r2.z, r2, r2
mad r1.xyz, r1, r1.w, c0
rcp r3.y, c7.x
add r0.y, r0.w, c8.x
mul r3.w, -r0.y, r3.y
mad r4.x, r0, c6, r3
pow r0, c18.z, r3.w
rsq r0.y, r4.x
mul r3.z, r3, r0.x
rcp r0.y, r0.y
add r0.z, r0.y, c7.x
add r0.y, r0, c8.x
rsq r0.x, r3.x
mul r3.w, r2.y, r0.z
rcp r4.x, r0.x
mul r4.y, r3, -r0
pow r0, c18.z, r4.y
add r0.y, r4.x, c8.x
mul r4.z, r3.y, -r0.y
mov r4.y, r0.x
pow r0, c18.z, r4.z
add r0.y, r4.x, c7.x
mul r0.y, r2, r0
mul r0.x, r0.y, r0
rcp r0.w, c6.x
mul r0.x, r0, r0.w
mul r0.y, r3.w, r4
mad r3.w, r3.z, r0, -r0.x
mul r3.z, r0.w, r0.y
add r0.xyz, v2, -c0
mul r0.xyz, r0, c9.x
add r0.xyz, r0, c0
add r0.xyz, r1, -r0
dp3 r0.y, r0, r0
mad r2.z, r2, c6.x, r3.x
rsq r1.x, r2.z
rcp r0.x, r1.x
rsq r0.z, r0.y
add r0.y, r0.x, c8.x
rcp r1.x, r0.z
mul r0.y, r3, -r0
rsq r0.z, r2.x
rcp r0.z, r0.z
pow r4, c18.z, r0.y
add r0.x, r0, c7
add r1.x, r0.z, r1
mov r0.y, r4.x
mul r0.x, r2.y, r0
mul r0.x, r0, r0.y
mad r2.x, r0.w, r0, -r3.z
mul r0.x, r1, c18.w
add r0.y, r0.x, c13.x
add r0.x, r0.z, c16
mul r1.x, r0.y, -c12
mul r2.y, r0.x, -c15.x
pow r0, c11.x, r1.x
mul r2.z, r1.w, c10.x
mov r0.y, r0.x
pow r1, c14.x, r2.y
mov r0.x, r1
mul_sat r0.x, r0, c17
mul r0.y, r2.z, r0
mul r0.y, r0.x, r0
add r0.x, r3.w, r2
mad_sat r0.x, r0, c19, r0.y
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 164 used size, 22 vars
Vector 48 [_Color] 4
Float 80 [_OceanRadius]
Float 108 [_DensityFactorA]
Float 112 [_DensityFactorB]
Float 116 [_DensityFactorC]
Float 120 [_DensityFactorD]
Float 124 [_DensityFactorE]
Float 128 [_Scale]
Float 132 [_Visibility]
Float 136 [_DensityVisibilityBase]
Float 140 [_DensityVisibilityPow]
Float 144 [_DensityVisibilityOffset]
Float 148 [_DensityCutoffBase]
Float 152 [_DensityCutoffPow]
Float 156 [_DensityCutoffOffset]
Float 160 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 105 instructions, 4 temp regs, 0 temp arrays:
// ALU 100 float, 0 int, 2 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkpamapacpppinkdfdlahfflipnpjcojpabaaaaaaoeanaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcnmamaaaaeaaaaaaadhadaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
abaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaadiaaaaajecaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaaakiacaaa
aaaaaaaaaiaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaadcaaaaakbcaabaaaacaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaaelaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaakecaabaaaacaaaaaackaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabnaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaiccaabaaaacaaaaaabkaabaaaacaaaaaaakiacaaaaaaaaaaa
ahaaaaaaelaaaaaffcaabaaaacaaaaaaagacbaaaacaaaaaaaaaaaaaiecaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaadcaaaaalbcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaackaabaaa
acaaaaaabnaaaaahecaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
abaaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaa
akaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
ckaabaaaacaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaaaaaaaaahecaabaaa
aaaaaaaaakaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaaijcaabaaaacaaaaaafgafbaaaaaaaaaaa
kgiocaaaaaaaaaaaahaaaaaaaoaaaaajccaabaaaaaaaaaaadkaabaiaebaaaaaa
acaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaajicaabaaaacaaaaaadkiacaaaaaaaaaaaagaaaaaackiacaaaaaaaaaaa
ahaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaama
diaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaaaoaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaackaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaaimcaabaaaaaaaaaaakgakbaaaaaaaaaaa
kgiocaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaakbcaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaa
akaabaaaacaaaaaabkaabaaaacaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaa
acaaaaaaaaaaaaaigcaabaaaacaaaaaafgafbaaaacaaaaaakgilcaaaaaaaaaaa
ahaaaaaaaaaaaaaidcaabaaaadaaaaaaagaabaaaacaaaaaaogikcaaaaaaaaaaa
ahaaaaaaaoaaaaajbcaabaaaacaaaaaabkaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaahaaaaaadiaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaadlkklidp
bjaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaabkiacaaaaaaaaaaaahaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaa
acaaaaaadkaabaaaacaaaaaaaoaaaaajccaabaaaacaaaaaackaabaiaebaaaaaa
acaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaa
acaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaa
diaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaaaoaaaaai
bcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaaoaaaaajicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaaaaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaa
ckaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaakhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
egiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaaaadaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaacaaaaaaagiacaaa
aaaaaaaaaiaaaaaaegacbaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaajaaaaaadiaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaajaaaaaadcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaajaaaaaadiaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaaiaaaaaacpaaaaagbcaabaaa
abaaaaaackiacaaaaaaaaaaaaiaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaacpaaaaag
ecaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaa
akaaaaaadccaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
aaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaa
doaaaaab"
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
Vector 1 [_ZBufferParams]
Vector 2 [_Color]
Float 3 [_OceanRadius]
Float 4 [_DensityFactorA]
Float 5 [_DensityFactorB]
Float 6 [_DensityFactorC]
Float 7 [_DensityFactorD]
Float 8 [_DensityFactorE]
Float 9 [_Scale]
Float 10 [_Visibility]
Float 11 [_DensityVisibilityBase]
Float 12 [_DensityVisibilityPow]
Float 13 [_DensityVisibilityOffset]
Float 14 [_DensityCutoffBase]
Float 15 [_DensityCutoffPow]
Float 16 [_DensityCutoffOffset]
Float 17 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 127 ALU, 1 TEX
dcl_2d s0
def c18, 1.00000000, 0.00000000, 2.71828175, 0.50000000
def c19, -2.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.z, v3, r1
dp3 r2.x, v3, v3
mad r0.x, -r2.z, r2.z, r2
rsq r0.y, r0.x
mov r0.x, c9
cmp r2.w, r2.z, c18.x, c18.y
mul r0.z, c3.x, r0.x
rcp r0.y, r0.y
add r0.x, r0.z, -r0.y
mul r0.y, r0, r0
mad r0.z, r0, r0, -r0.y
cmp r0.x, r0, c18, c18.y
mul r0.w, r0.x, r2
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rsq r0.z, r0.z
rcp r0.x, r0.x
rcp r0.z, r0.z
mul r3.x, r0.y, c5
mul r0.x, r0, c9
add r0.z, r2, -r0
add r0.z, r0, -r0.x
mad r0.z, r0.w, r0, r0.x
add r1.w, r2.x, -r0.y
rsq r0.w, r1.w
min r1.w, r0.z, r0.x
add r0.z, -r2, r1.w
rcp r0.x, r0.w
max r2.y, r0.z, c18
add r0.w, r1, r0.x
add r2.y, r2, -r0.w
mad r0.w, r2.y, r2, r0
mul r0.y, r0.w, r0.w
mad r0.y, r0, c6.x, r3.x
rsq r0.y, r0.y
rcp r0.w, r0.y
mov r0.y, c4.x
mul r2.y, c7.x, r0
add r3.y, r0.w, c7.x
mul r3.z, r2.y, r3.y
max r0.z, -r0, c18.y
add r0.z, -r0.x, r0
mad r0.x, r2.w, r0.z, r0
mul r0.x, r0, r0
mul r2.z, r2, r2.w
mul r2.z, r2, r2
mad r1.xyz, r1, r1.w, c0
rcp r3.y, c7.x
add r0.y, r0.w, c8.x
mul r3.w, -r0.y, r3.y
mad r4.x, r0, c6, r3
pow r0, c18.z, r3.w
rsq r0.y, r4.x
mul r3.z, r3, r0.x
rcp r0.y, r0.y
add r0.z, r0.y, c7.x
add r0.y, r0, c8.x
rsq r0.x, r3.x
mul r3.w, r2.y, r0.z
rcp r4.x, r0.x
mul r4.y, r3, -r0
pow r0, c18.z, r4.y
add r0.y, r4.x, c8.x
mul r4.z, r3.y, -r0.y
mov r4.y, r0.x
pow r0, c18.z, r4.z
add r0.y, r4.x, c7.x
mul r0.y, r2, r0
mul r0.x, r0.y, r0
rcp r0.w, c6.x
mul r0.x, r0, r0.w
mul r0.y, r3.w, r4
mad r3.w, r3.z, r0, -r0.x
mul r3.z, r0.w, r0.y
add r0.xyz, v2, -c0
mul r0.xyz, r0, c9.x
add r0.xyz, r0, c0
add r0.xyz, r1, -r0
dp3 r0.y, r0, r0
mad r2.z, r2, c6.x, r3.x
rsq r1.x, r2.z
rcp r0.x, r1.x
rsq r0.z, r0.y
add r0.y, r0.x, c8.x
rcp r1.x, r0.z
mul r0.y, r3, -r0
rsq r0.z, r2.x
rcp r0.z, r0.z
pow r4, c18.z, r0.y
add r0.x, r0, c7
add r1.x, r0.z, r1
mov r0.y, r4.x
mul r0.x, r2.y, r0
mul r0.x, r0, r0.y
mad r2.x, r0.w, r0, -r3.z
mul r0.x, r1, c18.w
add r0.y, r0.x, c13.x
add r0.x, r0.z, c16
mul r1.x, r0.y, -c12
mul r2.y, r0.x, -c15.x
pow r0, c11.x, r1.x
mul r2.z, r1.w, c10.x
mov r0.y, r0.x
pow r1, c14.x, r2.y
mov r0.x, r1
mul_sat r0.x, r0, c17
mul r0.y, r2.z, r0
mul r0.y, r0.x, r0
add r0.x, r3.w, r2
mad_sat r0.x, r0, c19, r0.y
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 164 used size, 22 vars
Vector 48 [_Color] 4
Float 80 [_OceanRadius]
Float 108 [_DensityFactorA]
Float 112 [_DensityFactorB]
Float 116 [_DensityFactorC]
Float 120 [_DensityFactorD]
Float 124 [_DensityFactorE]
Float 128 [_Scale]
Float 132 [_Visibility]
Float 136 [_DensityVisibilityBase]
Float 140 [_DensityVisibilityPow]
Float 144 [_DensityVisibilityOffset]
Float 148 [_DensityCutoffBase]
Float 152 [_DensityCutoffPow]
Float 156 [_DensityCutoffOffset]
Float 160 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 105 instructions, 4 temp regs, 0 temp arrays:
// ALU 100 float, 0 int, 2 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkpamapacpppinkdfdlahfflipnpjcojpabaaaaaaoeanaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcnmamaaaaeaaaaaaadhadaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
abaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaadiaaaaajecaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaaakiacaaa
aaaaaaaaaiaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaadcaaaaakbcaabaaaacaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaaelaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaakecaabaaaacaaaaaackaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabnaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaiccaabaaaacaaaaaabkaabaaaacaaaaaaakiacaaaaaaaaaaa
ahaaaaaaelaaaaaffcaabaaaacaaaaaaagacbaaaacaaaaaaaaaaaaaiecaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaadcaaaaalbcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaackaabaaa
acaaaaaabnaaaaahecaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
abaaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaa
akaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
ckaabaaaacaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaaaaaaaaahecaabaaa
aaaaaaaaakaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaaijcaabaaaacaaaaaafgafbaaaaaaaaaaa
kgiocaaaaaaaaaaaahaaaaaaaoaaaaajccaabaaaaaaaaaaadkaabaiaebaaaaaa
acaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaajicaabaaaacaaaaaadkiacaaaaaaaaaaaagaaaaaackiacaaaaaaaaaaa
ahaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaama
diaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaaaoaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaackaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaaimcaabaaaaaaaaaaakgakbaaaaaaaaaaa
kgiocaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaakbcaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaa
akaabaaaacaaaaaabkaabaaaacaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaa
acaaaaaaaaaaaaaigcaabaaaacaaaaaafgafbaaaacaaaaaakgilcaaaaaaaaaaa
ahaaaaaaaaaaaaaidcaabaaaadaaaaaaagaabaaaacaaaaaaogikcaaaaaaaaaaa
ahaaaaaaaoaaaaajbcaabaaaacaaaaaabkaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaahaaaaaadiaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaadlkklidp
bjaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaabkiacaaaaaaaaaaaahaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaa
acaaaaaadkaabaaaacaaaaaaaoaaaaajccaabaaaacaaaaaackaabaiaebaaaaaa
acaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaa
acaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaa
diaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaaaoaaaaai
bcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaaoaaaaajicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaaaaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaa
ckaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaakhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
egiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaaaadaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaacaaaaaaagiacaaa
aaaaaaaaaiaaaaaaegacbaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaajaaaaaadiaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaajaaaaaadcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaajaaaaaadiaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaaiaaaaaacpaaaaagbcaabaaa
abaaaaaackiacaaaaaaaaaaaaiaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaacpaaaaag
ecaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaa
akaaaaaadccaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
aaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaa
doaaaaab"
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
Vector 1 [_ZBufferParams]
Vector 2 [_Color]
Float 3 [_OceanRadius]
Float 4 [_DensityFactorA]
Float 5 [_DensityFactorB]
Float 6 [_DensityFactorC]
Float 7 [_DensityFactorD]
Float 8 [_DensityFactorE]
Float 9 [_Scale]
Float 10 [_Visibility]
Float 11 [_DensityVisibilityBase]
Float 12 [_DensityVisibilityPow]
Float 13 [_DensityVisibilityOffset]
Float 14 [_DensityCutoffBase]
Float 15 [_DensityCutoffPow]
Float 16 [_DensityCutoffOffset]
Float 17 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 127 ALU, 1 TEX
dcl_2d s0
def c18, 1.00000000, 0.00000000, 2.71828175, 0.50000000
def c19, -2.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.z, v3, r1
dp3 r2.x, v3, v3
mad r0.x, -r2.z, r2.z, r2
rsq r0.y, r0.x
mov r0.x, c9
cmp r2.w, r2.z, c18.x, c18.y
mul r0.z, c3.x, r0.x
rcp r0.y, r0.y
add r0.x, r0.z, -r0.y
mul r0.y, r0, r0
mad r0.z, r0, r0, -r0.y
cmp r0.x, r0, c18, c18.y
mul r0.w, r0.x, r2
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rsq r0.z, r0.z
rcp r0.x, r0.x
rcp r0.z, r0.z
mul r3.x, r0.y, c5
mul r0.x, r0, c9
add r0.z, r2, -r0
add r0.z, r0, -r0.x
mad r0.z, r0.w, r0, r0.x
add r1.w, r2.x, -r0.y
rsq r0.w, r1.w
min r1.w, r0.z, r0.x
add r0.z, -r2, r1.w
rcp r0.x, r0.w
max r2.y, r0.z, c18
add r0.w, r1, r0.x
add r2.y, r2, -r0.w
mad r0.w, r2.y, r2, r0
mul r0.y, r0.w, r0.w
mad r0.y, r0, c6.x, r3.x
rsq r0.y, r0.y
rcp r0.w, r0.y
mov r0.y, c4.x
mul r2.y, c7.x, r0
add r3.y, r0.w, c7.x
mul r3.z, r2.y, r3.y
max r0.z, -r0, c18.y
add r0.z, -r0.x, r0
mad r0.x, r2.w, r0.z, r0
mul r0.x, r0, r0
mul r2.z, r2, r2.w
mul r2.z, r2, r2
mad r1.xyz, r1, r1.w, c0
rcp r3.y, c7.x
add r0.y, r0.w, c8.x
mul r3.w, -r0.y, r3.y
mad r4.x, r0, c6, r3
pow r0, c18.z, r3.w
rsq r0.y, r4.x
mul r3.z, r3, r0.x
rcp r0.y, r0.y
add r0.z, r0.y, c7.x
add r0.y, r0, c8.x
rsq r0.x, r3.x
mul r3.w, r2.y, r0.z
rcp r4.x, r0.x
mul r4.y, r3, -r0
pow r0, c18.z, r4.y
add r0.y, r4.x, c8.x
mul r4.z, r3.y, -r0.y
mov r4.y, r0.x
pow r0, c18.z, r4.z
add r0.y, r4.x, c7.x
mul r0.y, r2, r0
mul r0.x, r0.y, r0
rcp r0.w, c6.x
mul r0.x, r0, r0.w
mul r0.y, r3.w, r4
mad r3.w, r3.z, r0, -r0.x
mul r3.z, r0.w, r0.y
add r0.xyz, v2, -c0
mul r0.xyz, r0, c9.x
add r0.xyz, r0, c0
add r0.xyz, r1, -r0
dp3 r0.y, r0, r0
mad r2.z, r2, c6.x, r3.x
rsq r1.x, r2.z
rcp r0.x, r1.x
rsq r0.z, r0.y
add r0.y, r0.x, c8.x
rcp r1.x, r0.z
mul r0.y, r3, -r0
rsq r0.z, r2.x
rcp r0.z, r0.z
pow r4, c18.z, r0.y
add r0.x, r0, c7
add r1.x, r0.z, r1
mov r0.y, r4.x
mul r0.x, r2.y, r0
mul r0.x, r0, r0.y
mad r2.x, r0.w, r0, -r3.z
mul r0.x, r1, c18.w
add r0.y, r0.x, c13.x
add r0.x, r0.z, c16
mul r1.x, r0.y, -c12
mul r2.y, r0.x, -c15.x
pow r0, c11.x, r1.x
mul r2.z, r1.w, c10.x
mov r0.y, r0.x
pow r1, c14.x, r2.y
mov r0.x, r1
mul_sat r0.x, r0, c17
mul r0.y, r2.z, r0
mul r0.y, r0.x, r0
add r0.x, r3.w, r2
mad_sat r0.x, r0, c19, r0.y
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 164 used size, 22 vars
Vector 48 [_Color] 4
Float 80 [_OceanRadius]
Float 108 [_DensityFactorA]
Float 112 [_DensityFactorB]
Float 116 [_DensityFactorC]
Float 120 [_DensityFactorD]
Float 124 [_DensityFactorE]
Float 128 [_Scale]
Float 132 [_Visibility]
Float 136 [_DensityVisibilityBase]
Float 140 [_DensityVisibilityPow]
Float 144 [_DensityVisibilityOffset]
Float 148 [_DensityCutoffBase]
Float 152 [_DensityCutoffPow]
Float 156 [_DensityCutoffOffset]
Float 160 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 105 instructions, 4 temp regs, 0 temp arrays:
// ALU 100 float, 0 int, 2 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkpamapacpppinkdfdlahfflipnpjcojpabaaaaaaoeanaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcnmamaaaaeaaaaaaadhadaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
abaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaadiaaaaajecaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaaakiacaaa
aaaaaaaaaiaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaadcaaaaakbcaabaaaacaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaaelaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaakecaabaaaacaaaaaackaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabnaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaiccaabaaaacaaaaaabkaabaaaacaaaaaaakiacaaaaaaaaaaa
ahaaaaaaelaaaaaffcaabaaaacaaaaaaagacbaaaacaaaaaaaaaaaaaiecaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaadcaaaaalbcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaackaabaaa
acaaaaaabnaaaaahecaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
abaaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaa
akaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
ckaabaaaacaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaaaaaaaaahecaabaaa
aaaaaaaaakaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaaijcaabaaaacaaaaaafgafbaaaaaaaaaaa
kgiocaaaaaaaaaaaahaaaaaaaoaaaaajccaabaaaaaaaaaaadkaabaiaebaaaaaa
acaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaajicaabaaaacaaaaaadkiacaaaaaaaaaaaagaaaaaackiacaaaaaaaaaaa
ahaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaama
diaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaaaoaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaackaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaaimcaabaaaaaaaaaaakgakbaaaaaaaaaaa
kgiocaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaakbcaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaa
akaabaaaacaaaaaabkaabaaaacaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaa
acaaaaaaaaaaaaaigcaabaaaacaaaaaafgafbaaaacaaaaaakgilcaaaaaaaaaaa
ahaaaaaaaaaaaaaidcaabaaaadaaaaaaagaabaaaacaaaaaaogikcaaaaaaaaaaa
ahaaaaaaaoaaaaajbcaabaaaacaaaaaabkaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaahaaaaaadiaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaadlkklidp
bjaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaabkiacaaaaaaaaaaaahaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaa
acaaaaaadkaabaaaacaaaaaaaoaaaaajccaabaaaacaaaaaackaabaiaebaaaaaa
acaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaa
acaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaa
diaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaaaoaaaaai
bcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaaoaaaaajicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaaaaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaa
ckaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaakhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
egiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaaaadaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaacaaaaaaagiacaaa
aaaaaaaaaiaaaaaaegacbaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaajaaaaaadiaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaajaaaaaadcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaajaaaaaadiaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaaiaaaaaacpaaaaagbcaabaaa
abaaaaaackiacaaaaaaaaaaaaiaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaacpaaaaag
ecaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaa
akaaaaaadccaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
aaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaa
doaaaaab"
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
Vector 1 [_ZBufferParams]
Vector 2 [_Color]
Float 3 [_OceanRadius]
Float 4 [_DensityFactorA]
Float 5 [_DensityFactorB]
Float 6 [_DensityFactorC]
Float 7 [_DensityFactorD]
Float 8 [_DensityFactorE]
Float 9 [_Scale]
Float 10 [_Visibility]
Float 11 [_DensityVisibilityBase]
Float 12 [_DensityVisibilityPow]
Float 13 [_DensityVisibilityOffset]
Float 14 [_DensityCutoffBase]
Float 15 [_DensityCutoffPow]
Float 16 [_DensityCutoffOffset]
Float 17 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 127 ALU, 1 TEX
dcl_2d s0
def c18, 1.00000000, 0.00000000, 2.71828175, 0.50000000
def c19, -2.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.z, v3, r1
dp3 r2.x, v3, v3
mad r0.x, -r2.z, r2.z, r2
rsq r0.y, r0.x
mov r0.x, c9
cmp r2.w, r2.z, c18.x, c18.y
mul r0.z, c3.x, r0.x
rcp r0.y, r0.y
add r0.x, r0.z, -r0.y
mul r0.y, r0, r0
mad r0.z, r0, r0, -r0.y
cmp r0.x, r0, c18, c18.y
mul r0.w, r0.x, r2
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rsq r0.z, r0.z
rcp r0.x, r0.x
rcp r0.z, r0.z
mul r3.x, r0.y, c5
mul r0.x, r0, c9
add r0.z, r2, -r0
add r0.z, r0, -r0.x
mad r0.z, r0.w, r0, r0.x
add r1.w, r2.x, -r0.y
rsq r0.w, r1.w
min r1.w, r0.z, r0.x
add r0.z, -r2, r1.w
rcp r0.x, r0.w
max r2.y, r0.z, c18
add r0.w, r1, r0.x
add r2.y, r2, -r0.w
mad r0.w, r2.y, r2, r0
mul r0.y, r0.w, r0.w
mad r0.y, r0, c6.x, r3.x
rsq r0.y, r0.y
rcp r0.w, r0.y
mov r0.y, c4.x
mul r2.y, c7.x, r0
add r3.y, r0.w, c7.x
mul r3.z, r2.y, r3.y
max r0.z, -r0, c18.y
add r0.z, -r0.x, r0
mad r0.x, r2.w, r0.z, r0
mul r0.x, r0, r0
mul r2.z, r2, r2.w
mul r2.z, r2, r2
mad r1.xyz, r1, r1.w, c0
rcp r3.y, c7.x
add r0.y, r0.w, c8.x
mul r3.w, -r0.y, r3.y
mad r4.x, r0, c6, r3
pow r0, c18.z, r3.w
rsq r0.y, r4.x
mul r3.z, r3, r0.x
rcp r0.y, r0.y
add r0.z, r0.y, c7.x
add r0.y, r0, c8.x
rsq r0.x, r3.x
mul r3.w, r2.y, r0.z
rcp r4.x, r0.x
mul r4.y, r3, -r0
pow r0, c18.z, r4.y
add r0.y, r4.x, c8.x
mul r4.z, r3.y, -r0.y
mov r4.y, r0.x
pow r0, c18.z, r4.z
add r0.y, r4.x, c7.x
mul r0.y, r2, r0
mul r0.x, r0.y, r0
rcp r0.w, c6.x
mul r0.x, r0, r0.w
mul r0.y, r3.w, r4
mad r3.w, r3.z, r0, -r0.x
mul r3.z, r0.w, r0.y
add r0.xyz, v2, -c0
mul r0.xyz, r0, c9.x
add r0.xyz, r0, c0
add r0.xyz, r1, -r0
dp3 r0.y, r0, r0
mad r2.z, r2, c6.x, r3.x
rsq r1.x, r2.z
rcp r0.x, r1.x
rsq r0.z, r0.y
add r0.y, r0.x, c8.x
rcp r1.x, r0.z
mul r0.y, r3, -r0
rsq r0.z, r2.x
rcp r0.z, r0.z
pow r4, c18.z, r0.y
add r0.x, r0, c7
add r1.x, r0.z, r1
mov r0.y, r4.x
mul r0.x, r2.y, r0
mul r0.x, r0, r0.y
mad r2.x, r0.w, r0, -r3.z
mul r0.x, r1, c18.w
add r0.y, r0.x, c13.x
add r0.x, r0.z, c16
mul r1.x, r0.y, -c12
mul r2.y, r0.x, -c15.x
pow r0, c11.x, r1.x
mul r2.z, r1.w, c10.x
mov r0.y, r0.x
pow r1, c14.x, r2.y
mov r0.x, r1
mul_sat r0.x, r0, c17
mul r0.y, r2.z, r0
mul r0.y, r0.x, r0
add r0.x, r3.w, r2
mad_sat r0.x, r0, c19, r0.y
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 240 // 228 used size, 23 vars
Vector 112 [_Color] 4
Float 144 [_OceanRadius]
Float 172 [_DensityFactorA]
Float 176 [_DensityFactorB]
Float 180 [_DensityFactorC]
Float 184 [_DensityFactorD]
Float 188 [_DensityFactorE]
Float 192 [_Scale]
Float 196 [_Visibility]
Float 200 [_DensityVisibilityBase]
Float 204 [_DensityVisibilityPow]
Float 208 [_DensityVisibilityOffset]
Float 212 [_DensityCutoffBase]
Float 216 [_DensityCutoffPow]
Float 220 [_DensityCutoffOffset]
Float 224 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 105 instructions, 4 temp regs, 0 temp arrays:
// ALU 100 float, 0 int, 2 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedllbkgpciggdjjmbfnekbjclnakopioebabaaaaaapmanaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmamaaaa
eaaaaaaadhadaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaa
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
akaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadiaaaaaj
ecaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaakiacaaaaaaaaaaaamaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
afaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaadcaaaaakbcaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
dcaaaaakecaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaia
ebaaaaaaacaaaaaabnaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
acaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaai
ccaabaaaacaaaaaabkaabaaaacaaaaaaakiacaaaaaaaaaaaalaaaaaaelaaaaaf
fcaabaaaacaaaaaaagacbaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaiaebaaaaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaackaabaaaacaaaaaabnaaaaah
ecaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaabaaaaahecaabaaa
acaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaaakaabaiaebaaaaaa
acaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaackaabaaaacaaaaaa
bkaabaaaaaaaaaaaakaabaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaaakaabaaa
acaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
bkaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaaijcaabaaaacaaaaaafgafbaaaaaaaaaaakgiocaaaaaaaaaaa
alaaaaaaaoaaaaajccaabaaaaaaaaaaadkaabaiaebaaaaaaacaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaajicaabaaa
acaaaaaadkiacaaaaaaaaaaaakaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamadiaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaacaaaaaaaoaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaakaabaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
ckaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaaimcaabaaaaaaaaaaakgakbaaaaaaaaaaakgiocaaaaaaaaaaa
alaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
dcaaaaakbcaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaaakaabaaaacaaaaaa
bkaabaaaacaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaaaaaaaaai
gcaabaaaacaaaaaafgafbaaaacaaaaaakgilcaaaaaaaaaaaalaaaaaaaaaaaaai
dcaabaaaadaaaaaaagaabaaaacaaaaaaogikcaaaaaaaaaaaalaaaaaaaoaaaaaj
bcaabaaaacaaaaaabkaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaalaaaaaa
diaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadiaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaadaaaaaaaoaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaa
aaaaaaaaalaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
akaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaadkaabaaa
acaaaaaaaoaaaaajccaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahbcaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaaaoaaaaaibcaabaaaacaaaaaa
akaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaacaaaaaaaoaaaaajicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaak
hcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaabaaaaaa
aeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
amaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaaaaeaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaadcaaaaalhcaabaaaacaaaaaaagiacaaaaaaaaaaaamaaaaaa
egacbaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaa
diaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
anaaaaaadcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadp
akiacaaaaaaaaaaaanaaaaaadiaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaiaebaaaaaaaaaaaaaaamaaaaaacpaaaaagbcaabaaaabaaaaaackiacaaa
aaaaaaaaamaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaacpaaaaagecaabaaaaaaaaaaa
bkiacaaaaaaaaaaaanaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadicaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaoaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaa
dgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab"
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
Vector 1 [_ZBufferParams]
Vector 2 [_Color]
Float 3 [_OceanRadius]
Float 4 [_DensityFactorA]
Float 5 [_DensityFactorB]
Float 6 [_DensityFactorC]
Float 7 [_DensityFactorD]
Float 8 [_DensityFactorE]
Float 9 [_Scale]
Float 10 [_Visibility]
Float 11 [_DensityVisibilityBase]
Float 12 [_DensityVisibilityPow]
Float 13 [_DensityVisibilityOffset]
Float 14 [_DensityCutoffBase]
Float 15 [_DensityCutoffPow]
Float 16 [_DensityCutoffOffset]
Float 17 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 127 ALU, 1 TEX
dcl_2d s0
def c18, 1.00000000, 0.00000000, 2.71828175, 0.50000000
def c19, -2.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.z, v3, r1
dp3 r2.x, v3, v3
mad r0.x, -r2.z, r2.z, r2
rsq r0.y, r0.x
mov r0.x, c9
cmp r2.w, r2.z, c18.x, c18.y
mul r0.z, c3.x, r0.x
rcp r0.y, r0.y
add r0.x, r0.z, -r0.y
mul r0.y, r0, r0
mad r0.z, r0, r0, -r0.y
cmp r0.x, r0, c18, c18.y
mul r0.w, r0.x, r2
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rsq r0.z, r0.z
rcp r0.x, r0.x
rcp r0.z, r0.z
mul r3.x, r0.y, c5
mul r0.x, r0, c9
add r0.z, r2, -r0
add r0.z, r0, -r0.x
mad r0.z, r0.w, r0, r0.x
add r1.w, r2.x, -r0.y
rsq r0.w, r1.w
min r1.w, r0.z, r0.x
add r0.z, -r2, r1.w
rcp r0.x, r0.w
max r2.y, r0.z, c18
add r0.w, r1, r0.x
add r2.y, r2, -r0.w
mad r0.w, r2.y, r2, r0
mul r0.y, r0.w, r0.w
mad r0.y, r0, c6.x, r3.x
rsq r0.y, r0.y
rcp r0.w, r0.y
mov r0.y, c4.x
mul r2.y, c7.x, r0
add r3.y, r0.w, c7.x
mul r3.z, r2.y, r3.y
max r0.z, -r0, c18.y
add r0.z, -r0.x, r0
mad r0.x, r2.w, r0.z, r0
mul r0.x, r0, r0
mul r2.z, r2, r2.w
mul r2.z, r2, r2
mad r1.xyz, r1, r1.w, c0
rcp r3.y, c7.x
add r0.y, r0.w, c8.x
mul r3.w, -r0.y, r3.y
mad r4.x, r0, c6, r3
pow r0, c18.z, r3.w
rsq r0.y, r4.x
mul r3.z, r3, r0.x
rcp r0.y, r0.y
add r0.z, r0.y, c7.x
add r0.y, r0, c8.x
rsq r0.x, r3.x
mul r3.w, r2.y, r0.z
rcp r4.x, r0.x
mul r4.y, r3, -r0
pow r0, c18.z, r4.y
add r0.y, r4.x, c8.x
mul r4.z, r3.y, -r0.y
mov r4.y, r0.x
pow r0, c18.z, r4.z
add r0.y, r4.x, c7.x
mul r0.y, r2, r0
mul r0.x, r0.y, r0
rcp r0.w, c6.x
mul r0.x, r0, r0.w
mul r0.y, r3.w, r4
mad r3.w, r3.z, r0, -r0.x
mul r3.z, r0.w, r0.y
add r0.xyz, v2, -c0
mul r0.xyz, r0, c9.x
add r0.xyz, r0, c0
add r0.xyz, r1, -r0
dp3 r0.y, r0, r0
mad r2.z, r2, c6.x, r3.x
rsq r1.x, r2.z
rcp r0.x, r1.x
rsq r0.z, r0.y
add r0.y, r0.x, c8.x
rcp r1.x, r0.z
mul r0.y, r3, -r0
rsq r0.z, r2.x
rcp r0.z, r0.z
pow r4, c18.z, r0.y
add r0.x, r0, c7
add r1.x, r0.z, r1
mov r0.y, r4.x
mul r0.x, r2.y, r0
mul r0.x, r0, r0.y
mad r2.x, r0.w, r0, -r3.z
mul r0.x, r1, c18.w
add r0.y, r0.x, c13.x
add r0.x, r0.z, c16
mul r1.x, r0.y, -c12
mul r2.y, r0.x, -c15.x
pow r0, c11.x, r1.x
mul r2.z, r1.w, c10.x
mov r0.y, r0.x
pow r1, c14.x, r2.y
mov r0.x, r1
mul_sat r0.x, r0, c17
mul r0.y, r2.z, r0
mul r0.y, r0.x, r0
add r0.x, r3.w, r2
mad_sat r0.x, r0, c19, r0.y
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 240 // 228 used size, 23 vars
Vector 112 [_Color] 4
Float 144 [_OceanRadius]
Float 172 [_DensityFactorA]
Float 176 [_DensityFactorB]
Float 180 [_DensityFactorC]
Float 184 [_DensityFactorD]
Float 188 [_DensityFactorE]
Float 192 [_Scale]
Float 196 [_Visibility]
Float 200 [_DensityVisibilityBase]
Float 204 [_DensityVisibilityPow]
Float 208 [_DensityVisibilityOffset]
Float 212 [_DensityCutoffBase]
Float 216 [_DensityCutoffPow]
Float 220 [_DensityCutoffOffset]
Float 224 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 105 instructions, 4 temp regs, 0 temp arrays:
// ALU 100 float, 0 int, 2 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedllbkgpciggdjjmbfnekbjclnakopioebabaaaaaapmanaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmamaaaa
eaaaaaaadhadaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaa
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
akaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadiaaaaaj
ecaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaakiacaaaaaaaaaaaamaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
afaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaadcaaaaakbcaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
dcaaaaakecaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaia
ebaaaaaaacaaaaaabnaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
acaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaai
ccaabaaaacaaaaaabkaabaaaacaaaaaaakiacaaaaaaaaaaaalaaaaaaelaaaaaf
fcaabaaaacaaaaaaagacbaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaiaebaaaaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaackaabaaaacaaaaaabnaaaaah
ecaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaabaaaaahecaabaaa
acaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaaakaabaiaebaaaaaa
acaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaackaabaaaacaaaaaa
bkaabaaaaaaaaaaaakaabaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaaakaabaaa
acaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
bkaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaaijcaabaaaacaaaaaafgafbaaaaaaaaaaakgiocaaaaaaaaaaa
alaaaaaaaoaaaaajccaabaaaaaaaaaaadkaabaiaebaaaaaaacaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaajicaabaaa
acaaaaaadkiacaaaaaaaaaaaakaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamadiaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaacaaaaaaaoaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaakaabaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
ckaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaaimcaabaaaaaaaaaaakgakbaaaaaaaaaaakgiocaaaaaaaaaaa
alaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
dcaaaaakbcaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaaakaabaaaacaaaaaa
bkaabaaaacaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaaaaaaaaai
gcaabaaaacaaaaaafgafbaaaacaaaaaakgilcaaaaaaaaaaaalaaaaaaaaaaaaai
dcaabaaaadaaaaaaagaabaaaacaaaaaaogikcaaaaaaaaaaaalaaaaaaaoaaaaaj
bcaabaaaacaaaaaabkaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaalaaaaaa
diaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadiaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaadaaaaaaaoaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaa
aaaaaaaaalaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
akaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaadkaabaaa
acaaaaaaaoaaaaajccaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahbcaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaaaoaaaaaibcaabaaaacaaaaaa
akaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaacaaaaaaaoaaaaajicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaak
hcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaabaaaaaa
aeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
amaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaaaaeaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaadcaaaaalhcaabaaaacaaaaaaagiacaaaaaaaaaaaamaaaaaa
egacbaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaa
diaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
anaaaaaadcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadp
akiacaaaaaaaaaaaanaaaaaadiaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaiaebaaaaaaaaaaaaaaamaaaaaacpaaaaagbcaabaaaabaaaaaackiacaaa
aaaaaaaaamaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaacpaaaaagecaabaaaaaaaaaaa
bkiacaaaaaaaaaaaanaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadicaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaoaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaa
dgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab"
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
Vector 1 [_ZBufferParams]
Vector 2 [_Color]
Float 3 [_OceanRadius]
Float 4 [_DensityFactorA]
Float 5 [_DensityFactorB]
Float 6 [_DensityFactorC]
Float 7 [_DensityFactorD]
Float 8 [_DensityFactorE]
Float 9 [_Scale]
Float 10 [_Visibility]
Float 11 [_DensityVisibilityBase]
Float 12 [_DensityVisibilityPow]
Float 13 [_DensityVisibilityOffset]
Float 14 [_DensityCutoffBase]
Float 15 [_DensityCutoffPow]
Float 16 [_DensityCutoffOffset]
Float 17 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 127 ALU, 1 TEX
dcl_2d s0
def c18, 1.00000000, 0.00000000, 2.71828175, 0.50000000
def c19, -2.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.z, v3, r1
dp3 r2.x, v3, v3
mad r0.x, -r2.z, r2.z, r2
rsq r0.y, r0.x
mov r0.x, c9
cmp r2.w, r2.z, c18.x, c18.y
mul r0.z, c3.x, r0.x
rcp r0.y, r0.y
add r0.x, r0.z, -r0.y
mul r0.y, r0, r0
mad r0.z, r0, r0, -r0.y
cmp r0.x, r0, c18, c18.y
mul r0.w, r0.x, r2
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rsq r0.z, r0.z
rcp r0.x, r0.x
rcp r0.z, r0.z
mul r3.x, r0.y, c5
mul r0.x, r0, c9
add r0.z, r2, -r0
add r0.z, r0, -r0.x
mad r0.z, r0.w, r0, r0.x
add r1.w, r2.x, -r0.y
rsq r0.w, r1.w
min r1.w, r0.z, r0.x
add r0.z, -r2, r1.w
rcp r0.x, r0.w
max r2.y, r0.z, c18
add r0.w, r1, r0.x
add r2.y, r2, -r0.w
mad r0.w, r2.y, r2, r0
mul r0.y, r0.w, r0.w
mad r0.y, r0, c6.x, r3.x
rsq r0.y, r0.y
rcp r0.w, r0.y
mov r0.y, c4.x
mul r2.y, c7.x, r0
add r3.y, r0.w, c7.x
mul r3.z, r2.y, r3.y
max r0.z, -r0, c18.y
add r0.z, -r0.x, r0
mad r0.x, r2.w, r0.z, r0
mul r0.x, r0, r0
mul r2.z, r2, r2.w
mul r2.z, r2, r2
mad r1.xyz, r1, r1.w, c0
rcp r3.y, c7.x
add r0.y, r0.w, c8.x
mul r3.w, -r0.y, r3.y
mad r4.x, r0, c6, r3
pow r0, c18.z, r3.w
rsq r0.y, r4.x
mul r3.z, r3, r0.x
rcp r0.y, r0.y
add r0.z, r0.y, c7.x
add r0.y, r0, c8.x
rsq r0.x, r3.x
mul r3.w, r2.y, r0.z
rcp r4.x, r0.x
mul r4.y, r3, -r0
pow r0, c18.z, r4.y
add r0.y, r4.x, c8.x
mul r4.z, r3.y, -r0.y
mov r4.y, r0.x
pow r0, c18.z, r4.z
add r0.y, r4.x, c7.x
mul r0.y, r2, r0
mul r0.x, r0.y, r0
rcp r0.w, c6.x
mul r0.x, r0, r0.w
mul r0.y, r3.w, r4
mad r3.w, r3.z, r0, -r0.x
mul r3.z, r0.w, r0.y
add r0.xyz, v2, -c0
mul r0.xyz, r0, c9.x
add r0.xyz, r0, c0
add r0.xyz, r1, -r0
dp3 r0.y, r0, r0
mad r2.z, r2, c6.x, r3.x
rsq r1.x, r2.z
rcp r0.x, r1.x
rsq r0.z, r0.y
add r0.y, r0.x, c8.x
rcp r1.x, r0.z
mul r0.y, r3, -r0
rsq r0.z, r2.x
rcp r0.z, r0.z
pow r4, c18.z, r0.y
add r0.x, r0, c7
add r1.x, r0.z, r1
mov r0.y, r4.x
mul r0.x, r2.y, r0
mul r0.x, r0, r0.y
mad r2.x, r0.w, r0, -r3.z
mul r0.x, r1, c18.w
add r0.y, r0.x, c13.x
add r0.x, r0.z, c16
mul r1.x, r0.y, -c12
mul r2.y, r0.x, -c15.x
pow r0, c11.x, r1.x
mul r2.z, r1.w, c10.x
mov r0.y, r0.x
pow r1, c14.x, r2.y
mov r0.x, r1
mul_sat r0.x, r0, c17
mul r0.y, r2.z, r0
mul r0.y, r0.x, r0
add r0.x, r3.w, r2
mad_sat r0.x, r0, c19, r0.y
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_OFF" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 240 // 228 used size, 23 vars
Vector 112 [_Color] 4
Float 144 [_OceanRadius]
Float 172 [_DensityFactorA]
Float 176 [_DensityFactorB]
Float 180 [_DensityFactorC]
Float 184 [_DensityFactorD]
Float 188 [_DensityFactorE]
Float 192 [_Scale]
Float 196 [_Visibility]
Float 200 [_DensityVisibilityBase]
Float 204 [_DensityVisibilityPow]
Float 208 [_DensityVisibilityOffset]
Float 212 [_DensityCutoffBase]
Float 216 [_DensityCutoffPow]
Float 220 [_DensityCutoffOffset]
Float 224 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 105 instructions, 4 temp regs, 0 temp arrays:
// ALU 100 float, 0 int, 2 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedllbkgpciggdjjmbfnekbjclnakopioebabaaaaaapmanaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmamaaaa
eaaaaaaadhadaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaa
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
akaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadiaaaaaj
ecaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaakiacaaaaaaaaaaaamaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
afaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaadcaaaaakbcaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
dcaaaaakecaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaia
ebaaaaaaacaaaaaabnaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
acaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaai
ccaabaaaacaaaaaabkaabaaaacaaaaaaakiacaaaaaaaaaaaalaaaaaaelaaaaaf
fcaabaaaacaaaaaaagacbaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaiaebaaaaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaackaabaaaacaaaaaabnaaaaah
ecaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaabaaaaahecaabaaa
acaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaaakaabaiaebaaaaaa
acaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaackaabaaaacaaaaaa
bkaabaaaaaaaaaaaakaabaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaaakaabaaa
acaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
bkaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaaijcaabaaaacaaaaaafgafbaaaaaaaaaaakgiocaaaaaaaaaaa
alaaaaaaaoaaaaajccaabaaaaaaaaaaadkaabaiaebaaaaaaacaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaajicaabaaa
acaaaaaadkiacaaaaaaaaaaaakaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamadiaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaacaaaaaaaoaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaakaabaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
ckaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaaimcaabaaaaaaaaaaakgakbaaaaaaaaaaakgiocaaaaaaaaaaa
alaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
dcaaaaakbcaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaaakaabaaaacaaaaaa
bkaabaaaacaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaaaaaaaaai
gcaabaaaacaaaaaafgafbaaaacaaaaaakgilcaaaaaaaaaaaalaaaaaaaaaaaaai
dcaabaaaadaaaaaaagaabaaaacaaaaaaogikcaaaaaaaaaaaalaaaaaaaoaaaaaj
bcaabaaaacaaaaaabkaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaalaaaaaa
diaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadiaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaadaaaaaaaoaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaa
aaaaaaaaalaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
akaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaadkaabaaa
acaaaaaaaoaaaaajccaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahbcaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaaaoaaaaaibcaabaaaacaaaaaa
akaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaacaaaaaaaoaaaaajicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaak
hcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaabaaaaaa
aeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
amaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaaaaeaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaadcaaaaalhcaabaaaacaaaaaaagiacaaaaaaaaaaaamaaaaaa
egacbaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaa
diaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
anaaaaaadcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadp
akiacaaaaaaaaaaaanaaaaaadiaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaiaebaaaaaaaaaaaaaaamaaaaaacpaaaaagbcaabaaaabaaaaaackiacaaa
aaaaaaaaamaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaacpaaaaagecaabaaaaaaaaaaa
bkiacaaaaaaaaaaaanaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadicaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaoaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaa
dgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab"
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
Vector 2 [_Color]
Float 3 [_OceanRadius]
Float 4 [_DensityFactorA]
Float 5 [_DensityFactorB]
Float 6 [_DensityFactorC]
Float 7 [_DensityFactorD]
Float 8 [_DensityFactorE]
Float 9 [_Scale]
Float 10 [_Visibility]
Float 11 [_DensityVisibilityBase]
Float 12 [_DensityVisibilityPow]
Float 13 [_DensityVisibilityOffset]
Float 14 [_DensityCutoffBase]
Float 15 [_DensityCutoffPow]
Float 16 [_DensityCutoffOffset]
Float 17 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 127 ALU, 1 TEX
dcl_2d s0
def c18, 1.00000000, 0.00000000, 2.71828175, 0.50000000
def c19, -2.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.z, v3, r1
dp3 r2.x, v3, v3
mad r0.x, -r2.z, r2.z, r2
rsq r0.y, r0.x
mov r0.x, c9
cmp r2.w, r2.z, c18.x, c18.y
mul r0.z, c3.x, r0.x
rcp r0.y, r0.y
add r0.x, r0.z, -r0.y
mul r0.y, r0, r0
mad r0.z, r0, r0, -r0.y
cmp r0.x, r0, c18, c18.y
mul r0.w, r0.x, r2
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rsq r0.z, r0.z
rcp r0.x, r0.x
rcp r0.z, r0.z
mul r3.x, r0.y, c5
mul r0.x, r0, c9
add r0.z, r2, -r0
add r0.z, r0, -r0.x
mad r0.z, r0.w, r0, r0.x
add r1.w, r2.x, -r0.y
rsq r0.w, r1.w
min r1.w, r0.z, r0.x
add r0.z, -r2, r1.w
rcp r0.x, r0.w
max r2.y, r0.z, c18
add r0.w, r1, r0.x
add r2.y, r2, -r0.w
mad r0.w, r2.y, r2, r0
mul r0.y, r0.w, r0.w
mad r0.y, r0, c6.x, r3.x
rsq r0.y, r0.y
rcp r0.w, r0.y
mov r0.y, c4.x
mul r2.y, c7.x, r0
add r3.y, r0.w, c7.x
mul r3.z, r2.y, r3.y
max r0.z, -r0, c18.y
add r0.z, -r0.x, r0
mad r0.x, r2.w, r0.z, r0
mul r0.x, r0, r0
mul r2.z, r2, r2.w
mul r2.z, r2, r2
mad r1.xyz, r1, r1.w, c0
rcp r3.y, c7.x
add r0.y, r0.w, c8.x
mul r3.w, -r0.y, r3.y
mad r4.x, r0, c6, r3
pow r0, c18.z, r3.w
rsq r0.y, r4.x
mul r3.z, r3, r0.x
rcp r0.y, r0.y
add r0.z, r0.y, c7.x
add r0.y, r0, c8.x
rsq r0.x, r3.x
mul r3.w, r2.y, r0.z
rcp r4.x, r0.x
mul r4.y, r3, -r0
pow r0, c18.z, r4.y
add r0.y, r4.x, c8.x
mul r4.z, r3.y, -r0.y
mov r4.y, r0.x
pow r0, c18.z, r4.z
add r0.y, r4.x, c7.x
mul r0.y, r2, r0
mul r0.x, r0.y, r0
rcp r0.w, c6.x
mul r0.x, r0, r0.w
mul r0.y, r3.w, r4
mad r3.w, r3.z, r0, -r0.x
mul r3.z, r0.w, r0.y
add r0.xyz, v2, -c0
mul r0.xyz, r0, c9.x
add r0.xyz, r0, c0
add r0.xyz, r1, -r0
dp3 r0.y, r0, r0
mad r2.z, r2, c6.x, r3.x
rsq r1.x, r2.z
rcp r0.x, r1.x
rsq r0.z, r0.y
add r0.y, r0.x, c8.x
rcp r1.x, r0.z
mul r0.y, r3, -r0
rsq r0.z, r2.x
rcp r0.z, r0.z
pow r4, c18.z, r0.y
add r0.x, r0, c7
add r1.x, r0.z, r1
mov r0.y, r4.x
mul r0.x, r2.y, r0
mul r0.x, r0, r0.y
mad r2.x, r0.w, r0, -r3.z
mul r0.x, r1, c18.w
add r0.y, r0.x, c13.x
add r0.x, r0.z, c16
mul r1.x, r0.y, -c12
mul r2.y, r0.x, -c15.x
pow r0, c11.x, r1.x
mul r2.z, r1.w, c10.x
mov r0.y, r0.x
pow r1, c14.x, r2.y
mov r0.x, r1
mul_sat r0.x, r0, c17
mul r0.y, r2.z, r0
mul r0.y, r0.x, r0
add r0.x, r3.w, r2
mad_sat r0.x, r0, c19, r0.y
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 164 used size, 22 vars
Vector 48 [_Color] 4
Float 80 [_OceanRadius]
Float 108 [_DensityFactorA]
Float 112 [_DensityFactorB]
Float 116 [_DensityFactorC]
Float 120 [_DensityFactorD]
Float 124 [_DensityFactorE]
Float 128 [_Scale]
Float 132 [_Visibility]
Float 136 [_DensityVisibilityBase]
Float 140 [_DensityVisibilityPow]
Float 144 [_DensityVisibilityOffset]
Float 148 [_DensityCutoffBase]
Float 152 [_DensityCutoffPow]
Float 156 [_DensityCutoffOffset]
Float 160 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 105 instructions, 4 temp regs, 0 temp arrays:
// ALU 100 float, 0 int, 2 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkpamapacpppinkdfdlahfflipnpjcojpabaaaaaaoeanaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcnmamaaaaeaaaaaaadhadaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
abaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaadiaaaaajecaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaaakiacaaa
aaaaaaaaaiaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaadcaaaaakbcaabaaaacaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaaelaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaakecaabaaaacaaaaaackaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabnaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaiccaabaaaacaaaaaabkaabaaaacaaaaaaakiacaaaaaaaaaaa
ahaaaaaaelaaaaaffcaabaaaacaaaaaaagacbaaaacaaaaaaaaaaaaaiecaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaadcaaaaalbcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaackaabaaa
acaaaaaabnaaaaahecaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
abaaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaa
akaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
ckaabaaaacaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaaaaaaaaahecaabaaa
aaaaaaaaakaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaaijcaabaaaacaaaaaafgafbaaaaaaaaaaa
kgiocaaaaaaaaaaaahaaaaaaaoaaaaajccaabaaaaaaaaaaadkaabaiaebaaaaaa
acaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaajicaabaaaacaaaaaadkiacaaaaaaaaaaaagaaaaaackiacaaaaaaaaaaa
ahaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaama
diaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaaaoaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaackaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaaimcaabaaaaaaaaaaakgakbaaaaaaaaaaa
kgiocaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaakbcaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaa
akaabaaaacaaaaaabkaabaaaacaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaa
acaaaaaaaaaaaaaigcaabaaaacaaaaaafgafbaaaacaaaaaakgilcaaaaaaaaaaa
ahaaaaaaaaaaaaaidcaabaaaadaaaaaaagaabaaaacaaaaaaogikcaaaaaaaaaaa
ahaaaaaaaoaaaaajbcaabaaaacaaaaaabkaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaahaaaaaadiaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaadlkklidp
bjaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaabkiacaaaaaaaaaaaahaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaa
acaaaaaadkaabaaaacaaaaaaaoaaaaajccaabaaaacaaaaaackaabaiaebaaaaaa
acaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaa
acaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaa
diaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaaaoaaaaai
bcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaaoaaaaajicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaaaaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaa
ckaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaakhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
egiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaaaadaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaacaaaaaaagiacaaa
aaaaaaaaaiaaaaaaegacbaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaajaaaaaadiaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaajaaaaaadcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaajaaaaaadiaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaaiaaaaaacpaaaaagbcaabaaa
abaaaaaackiacaaaaaaaaaaaaiaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaacpaaaaag
ecaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaa
akaaaaaadccaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
aaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaa
doaaaaab"
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
Float 3 [_OceanRadius]
Float 4 [_DensityFactorA]
Float 5 [_DensityFactorB]
Float 6 [_DensityFactorC]
Float 7 [_DensityFactorD]
Float 8 [_DensityFactorE]
Float 9 [_Scale]
Float 10 [_Visibility]
Float 11 [_DensityVisibilityBase]
Float 12 [_DensityVisibilityPow]
Float 13 [_DensityVisibilityOffset]
Float 14 [_DensityCutoffBase]
Float 15 [_DensityCutoffPow]
Float 16 [_DensityCutoffOffset]
Float 17 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 127 ALU, 1 TEX
dcl_2d s0
def c18, 1.00000000, 0.00000000, 2.71828175, 0.50000000
def c19, -2.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.z, v3, r1
dp3 r2.x, v3, v3
mad r0.x, -r2.z, r2.z, r2
rsq r0.y, r0.x
mov r0.x, c9
cmp r2.w, r2.z, c18.x, c18.y
mul r0.z, c3.x, r0.x
rcp r0.y, r0.y
add r0.x, r0.z, -r0.y
mul r0.y, r0, r0
mad r0.z, r0, r0, -r0.y
cmp r0.x, r0, c18, c18.y
mul r0.w, r0.x, r2
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rsq r0.z, r0.z
rcp r0.x, r0.x
rcp r0.z, r0.z
mul r3.x, r0.y, c5
mul r0.x, r0, c9
add r0.z, r2, -r0
add r0.z, r0, -r0.x
mad r0.z, r0.w, r0, r0.x
add r1.w, r2.x, -r0.y
rsq r0.w, r1.w
min r1.w, r0.z, r0.x
add r0.z, -r2, r1.w
rcp r0.x, r0.w
max r2.y, r0.z, c18
add r0.w, r1, r0.x
add r2.y, r2, -r0.w
mad r0.w, r2.y, r2, r0
mul r0.y, r0.w, r0.w
mad r0.y, r0, c6.x, r3.x
rsq r0.y, r0.y
rcp r0.w, r0.y
mov r0.y, c4.x
mul r2.y, c7.x, r0
add r3.y, r0.w, c7.x
mul r3.z, r2.y, r3.y
max r0.z, -r0, c18.y
add r0.z, -r0.x, r0
mad r0.x, r2.w, r0.z, r0
mul r0.x, r0, r0
mul r2.z, r2, r2.w
mul r2.z, r2, r2
mad r1.xyz, r1, r1.w, c0
rcp r3.y, c7.x
add r0.y, r0.w, c8.x
mul r3.w, -r0.y, r3.y
mad r4.x, r0, c6, r3
pow r0, c18.z, r3.w
rsq r0.y, r4.x
mul r3.z, r3, r0.x
rcp r0.y, r0.y
add r0.z, r0.y, c7.x
add r0.y, r0, c8.x
rsq r0.x, r3.x
mul r3.w, r2.y, r0.z
rcp r4.x, r0.x
mul r4.y, r3, -r0
pow r0, c18.z, r4.y
add r0.y, r4.x, c8.x
mul r4.z, r3.y, -r0.y
mov r4.y, r0.x
pow r0, c18.z, r4.z
add r0.y, r4.x, c7.x
mul r0.y, r2, r0
mul r0.x, r0.y, r0
rcp r0.w, c6.x
mul r0.x, r0, r0.w
mul r0.y, r3.w, r4
mad r3.w, r3.z, r0, -r0.x
mul r3.z, r0.w, r0.y
add r0.xyz, v2, -c0
mul r0.xyz, r0, c9.x
add r0.xyz, r0, c0
add r0.xyz, r1, -r0
dp3 r0.y, r0, r0
mad r2.z, r2, c6.x, r3.x
rsq r1.x, r2.z
rcp r0.x, r1.x
rsq r0.z, r0.y
add r0.y, r0.x, c8.x
rcp r1.x, r0.z
mul r0.y, r3, -r0
rsq r0.z, r2.x
rcp r0.z, r0.z
pow r4, c18.z, r0.y
add r0.x, r0, c7
add r1.x, r0.z, r1
mov r0.y, r4.x
mul r0.x, r2.y, r0
mul r0.x, r0, r0.y
mad r2.x, r0.w, r0, -r3.z
mul r0.x, r1, c18.w
add r0.y, r0.x, c13.x
add r0.x, r0.z, c16
mul r1.x, r0.y, -c12
mul r2.y, r0.x, -c15.x
pow r0, c11.x, r1.x
mul r2.z, r1.w, c10.x
mov r0.y, r0.x
pow r1, c14.x, r2.y
mov r0.x, r1
mul_sat r0.x, r0, c17
mul r0.y, r2.z, r0
mul r0.y, r0.x, r0
add r0.x, r3.w, r2
mad_sat r0.x, r0, c19, r0.y
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 164 used size, 22 vars
Vector 48 [_Color] 4
Float 80 [_OceanRadius]
Float 108 [_DensityFactorA]
Float 112 [_DensityFactorB]
Float 116 [_DensityFactorC]
Float 120 [_DensityFactorD]
Float 124 [_DensityFactorE]
Float 128 [_Scale]
Float 132 [_Visibility]
Float 136 [_DensityVisibilityBase]
Float 140 [_DensityVisibilityPow]
Float 144 [_DensityVisibilityOffset]
Float 148 [_DensityCutoffBase]
Float 152 [_DensityCutoffPow]
Float 156 [_DensityCutoffOffset]
Float 160 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 105 instructions, 4 temp regs, 0 temp arrays:
// ALU 100 float, 0 int, 2 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkpamapacpppinkdfdlahfflipnpjcojpabaaaaaaoeanaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcnmamaaaaeaaaaaaadhadaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
abaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaadiaaaaajecaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaaakiacaaa
aaaaaaaaaiaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaadcaaaaakbcaabaaaacaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaaelaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaakecaabaaaacaaaaaackaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabnaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaiccaabaaaacaaaaaabkaabaaaacaaaaaaakiacaaaaaaaaaaa
ahaaaaaaelaaaaaffcaabaaaacaaaaaaagacbaaaacaaaaaaaaaaaaaiecaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaadcaaaaalbcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaackaabaaa
acaaaaaabnaaaaahecaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
abaaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaa
akaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
ckaabaaaacaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaaaaaaaaahecaabaaa
aaaaaaaaakaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaaijcaabaaaacaaaaaafgafbaaaaaaaaaaa
kgiocaaaaaaaaaaaahaaaaaaaoaaaaajccaabaaaaaaaaaaadkaabaiaebaaaaaa
acaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaajicaabaaaacaaaaaadkiacaaaaaaaaaaaagaaaaaackiacaaaaaaaaaaa
ahaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaama
diaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaaaoaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaackaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaaimcaabaaaaaaaaaaakgakbaaaaaaaaaaa
kgiocaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaakbcaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaa
akaabaaaacaaaaaabkaabaaaacaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaa
acaaaaaaaaaaaaaigcaabaaaacaaaaaafgafbaaaacaaaaaakgilcaaaaaaaaaaa
ahaaaaaaaaaaaaaidcaabaaaadaaaaaaagaabaaaacaaaaaaogikcaaaaaaaaaaa
ahaaaaaaaoaaaaajbcaabaaaacaaaaaabkaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaahaaaaaadiaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaadlkklidp
bjaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaabkiacaaaaaaaaaaaahaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaa
acaaaaaadkaabaaaacaaaaaaaoaaaaajccaabaaaacaaaaaackaabaiaebaaaaaa
acaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaa
acaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaa
diaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaaaoaaaaai
bcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaaoaaaaajicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaaaaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaa
ckaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaakhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
egiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaaaadaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaacaaaaaaagiacaaa
aaaaaaaaaiaaaaaaegacbaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaajaaaaaadiaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaajaaaaaadcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaajaaaaaadiaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaaiaaaaaacpaaaaagbcaabaaa
abaaaaaackiacaaaaaaaaaaaaiaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaacpaaaaag
ecaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaa
akaaaaaadccaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
aaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaa
doaaaaab"
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
Float 3 [_OceanRadius]
Float 4 [_DensityFactorA]
Float 5 [_DensityFactorB]
Float 6 [_DensityFactorC]
Float 7 [_DensityFactorD]
Float 8 [_DensityFactorE]
Float 9 [_Scale]
Float 10 [_Visibility]
Float 11 [_DensityVisibilityBase]
Float 12 [_DensityVisibilityPow]
Float 13 [_DensityVisibilityOffset]
Float 14 [_DensityCutoffBase]
Float 15 [_DensityCutoffPow]
Float 16 [_DensityCutoffOffset]
Float 17 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 127 ALU, 1 TEX
dcl_2d s0
def c18, 1.00000000, 0.00000000, 2.71828175, 0.50000000
def c19, -2.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.z, v3, r1
dp3 r2.x, v3, v3
mad r0.x, -r2.z, r2.z, r2
rsq r0.y, r0.x
mov r0.x, c9
cmp r2.w, r2.z, c18.x, c18.y
mul r0.z, c3.x, r0.x
rcp r0.y, r0.y
add r0.x, r0.z, -r0.y
mul r0.y, r0, r0
mad r0.z, r0, r0, -r0.y
cmp r0.x, r0, c18, c18.y
mul r0.w, r0.x, r2
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rsq r0.z, r0.z
rcp r0.x, r0.x
rcp r0.z, r0.z
mul r3.x, r0.y, c5
mul r0.x, r0, c9
add r0.z, r2, -r0
add r0.z, r0, -r0.x
mad r0.z, r0.w, r0, r0.x
add r1.w, r2.x, -r0.y
rsq r0.w, r1.w
min r1.w, r0.z, r0.x
add r0.z, -r2, r1.w
rcp r0.x, r0.w
max r2.y, r0.z, c18
add r0.w, r1, r0.x
add r2.y, r2, -r0.w
mad r0.w, r2.y, r2, r0
mul r0.y, r0.w, r0.w
mad r0.y, r0, c6.x, r3.x
rsq r0.y, r0.y
rcp r0.w, r0.y
mov r0.y, c4.x
mul r2.y, c7.x, r0
add r3.y, r0.w, c7.x
mul r3.z, r2.y, r3.y
max r0.z, -r0, c18.y
add r0.z, -r0.x, r0
mad r0.x, r2.w, r0.z, r0
mul r0.x, r0, r0
mul r2.z, r2, r2.w
mul r2.z, r2, r2
mad r1.xyz, r1, r1.w, c0
rcp r3.y, c7.x
add r0.y, r0.w, c8.x
mul r3.w, -r0.y, r3.y
mad r4.x, r0, c6, r3
pow r0, c18.z, r3.w
rsq r0.y, r4.x
mul r3.z, r3, r0.x
rcp r0.y, r0.y
add r0.z, r0.y, c7.x
add r0.y, r0, c8.x
rsq r0.x, r3.x
mul r3.w, r2.y, r0.z
rcp r4.x, r0.x
mul r4.y, r3, -r0
pow r0, c18.z, r4.y
add r0.y, r4.x, c8.x
mul r4.z, r3.y, -r0.y
mov r4.y, r0.x
pow r0, c18.z, r4.z
add r0.y, r4.x, c7.x
mul r0.y, r2, r0
mul r0.x, r0.y, r0
rcp r0.w, c6.x
mul r0.x, r0, r0.w
mul r0.y, r3.w, r4
mad r3.w, r3.z, r0, -r0.x
mul r3.z, r0.w, r0.y
add r0.xyz, v2, -c0
mul r0.xyz, r0, c9.x
add r0.xyz, r0, c0
add r0.xyz, r1, -r0
dp3 r0.y, r0, r0
mad r2.z, r2, c6.x, r3.x
rsq r1.x, r2.z
rcp r0.x, r1.x
rsq r0.z, r0.y
add r0.y, r0.x, c8.x
rcp r1.x, r0.z
mul r0.y, r3, -r0
rsq r0.z, r2.x
rcp r0.z, r0.z
pow r4, c18.z, r0.y
add r0.x, r0, c7
add r1.x, r0.z, r1
mov r0.y, r4.x
mul r0.x, r2.y, r0
mul r0.x, r0, r0.y
mad r2.x, r0.w, r0, -r3.z
mul r0.x, r1, c18.w
add r0.y, r0.x, c13.x
add r0.x, r0.z, c16
mul r1.x, r0.y, -c12
mul r2.y, r0.x, -c15.x
pow r0, c11.x, r1.x
mul r2.z, r1.w, c10.x
mov r0.y, r0.x
pow r1, c14.x, r2.y
mov r0.x, r1
mul_sat r0.x, r0, c17
mul r0.y, r2.z, r0
mul r0.y, r0.x, r0
add r0.x, r3.w, r2
mad_sat r0.x, r0, c19, r0.y
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 164 used size, 22 vars
Vector 48 [_Color] 4
Float 80 [_OceanRadius]
Float 108 [_DensityFactorA]
Float 112 [_DensityFactorB]
Float 116 [_DensityFactorC]
Float 120 [_DensityFactorD]
Float 124 [_DensityFactorE]
Float 128 [_Scale]
Float 132 [_Visibility]
Float 136 [_DensityVisibilityBase]
Float 140 [_DensityVisibilityPow]
Float 144 [_DensityVisibilityOffset]
Float 148 [_DensityCutoffBase]
Float 152 [_DensityCutoffPow]
Float 156 [_DensityCutoffOffset]
Float 160 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 105 instructions, 4 temp regs, 0 temp arrays:
// ALU 100 float, 0 int, 2 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkpamapacpppinkdfdlahfflipnpjcojpabaaaaaaoeanaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcnmamaaaaeaaaaaaadhadaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
abaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaadiaaaaajecaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaaakiacaaa
aaaaaaaaaiaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaadcaaaaakbcaabaaaacaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaaelaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaakecaabaaaacaaaaaackaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaiaebaaaaaaacaaaaaabnaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaiccaabaaaacaaaaaabkaabaaaacaaaaaaakiacaaaaaaaaaaa
ahaaaaaaelaaaaaffcaabaaaacaaaaaaagacbaaaacaaaaaaaaaaaaaiecaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaadcaaaaalbcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaackaabaaa
acaaaaaabnaaaaahecaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
abaaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaa
akaabaiaebaaaaaaacaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
ckaabaaaacaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaaaaaaaaahecaabaaa
aaaaaaaaakaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaaijcaabaaaacaaaaaafgafbaaaaaaaaaaa
kgiocaaaaaaaaaaaahaaaaaaaoaaaaajccaabaaaaaaaaaaadkaabaiaebaaaaaa
acaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaajicaabaaaacaaaaaadkiacaaaaaaaaaaaagaaaaaackiacaaaaaaaaaaa
ahaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaama
diaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaaaoaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaackaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaaimcaabaaaaaaaaaaakgakbaaaaaaaaaaa
kgiocaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaakbcaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaa
akaabaaaacaaaaaabkaabaaaacaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaa
acaaaaaaaaaaaaaigcaabaaaacaaaaaafgafbaaaacaaaaaakgilcaaaaaaaaaaa
ahaaaaaaaaaaaaaidcaabaaaadaaaaaaagaabaaaacaaaaaaogikcaaaaaaaaaaa
ahaaaaaaaoaaaaajbcaabaaaacaaaaaabkaabaiaebaaaaaaadaaaaaackiacaaa
aaaaaaaaahaaaaaadiaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaadlkklidp
bjaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaaaoaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaabkiacaaaaaaaaaaaahaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaa
acaaaaaadkaabaaaacaaaaaaaoaaaaajccaabaaaacaaaaaackaabaiaebaaaaaa
acaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaa
acaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaa
diaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaaaoaaaaai
bcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaacaaaaaaaoaaaaajicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaa
aaaaaaaaahaaaaaaaaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaa
ckaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaakhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
egiccaaaabaaaaaaaeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaaaadaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalhcaabaaaacaaaaaaagiacaaa
aaaaaaaaaiaaaaaaegacbaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaajaaaaaadiaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaajaaaaaadcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaadpakiacaaaaaaaaaaaajaaaaaadiaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaaaiaaaaaacpaaaaagbcaabaaa
abaaaaaackiacaaaaaaaaaaaaiaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaacpaaaaag
ecaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaa
akaaaaaadccaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
aaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaa
doaaaaab"
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
Float 3 [_OceanRadius]
Float 4 [_DensityFactorA]
Float 5 [_DensityFactorB]
Float 6 [_DensityFactorC]
Float 7 [_DensityFactorD]
Float 8 [_DensityFactorE]
Float 9 [_Scale]
Float 10 [_Visibility]
Float 11 [_DensityVisibilityBase]
Float 12 [_DensityVisibilityPow]
Float 13 [_DensityVisibilityOffset]
Float 14 [_DensityCutoffBase]
Float 15 [_DensityCutoffPow]
Float 16 [_DensityCutoffOffset]
Float 17 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 127 ALU, 1 TEX
dcl_2d s0
def c18, 1.00000000, 0.00000000, 2.71828175, 0.50000000
def c19, -2.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.z, v3, r1
dp3 r2.x, v3, v3
mad r0.x, -r2.z, r2.z, r2
rsq r0.y, r0.x
mov r0.x, c9
cmp r2.w, r2.z, c18.x, c18.y
mul r0.z, c3.x, r0.x
rcp r0.y, r0.y
add r0.x, r0.z, -r0.y
mul r0.y, r0, r0
mad r0.z, r0, r0, -r0.y
cmp r0.x, r0, c18, c18.y
mul r0.w, r0.x, r2
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rsq r0.z, r0.z
rcp r0.x, r0.x
rcp r0.z, r0.z
mul r3.x, r0.y, c5
mul r0.x, r0, c9
add r0.z, r2, -r0
add r0.z, r0, -r0.x
mad r0.z, r0.w, r0, r0.x
add r1.w, r2.x, -r0.y
rsq r0.w, r1.w
min r1.w, r0.z, r0.x
add r0.z, -r2, r1.w
rcp r0.x, r0.w
max r2.y, r0.z, c18
add r0.w, r1, r0.x
add r2.y, r2, -r0.w
mad r0.w, r2.y, r2, r0
mul r0.y, r0.w, r0.w
mad r0.y, r0, c6.x, r3.x
rsq r0.y, r0.y
rcp r0.w, r0.y
mov r0.y, c4.x
mul r2.y, c7.x, r0
add r3.y, r0.w, c7.x
mul r3.z, r2.y, r3.y
max r0.z, -r0, c18.y
add r0.z, -r0.x, r0
mad r0.x, r2.w, r0.z, r0
mul r0.x, r0, r0
mul r2.z, r2, r2.w
mul r2.z, r2, r2
mad r1.xyz, r1, r1.w, c0
rcp r3.y, c7.x
add r0.y, r0.w, c8.x
mul r3.w, -r0.y, r3.y
mad r4.x, r0, c6, r3
pow r0, c18.z, r3.w
rsq r0.y, r4.x
mul r3.z, r3, r0.x
rcp r0.y, r0.y
add r0.z, r0.y, c7.x
add r0.y, r0, c8.x
rsq r0.x, r3.x
mul r3.w, r2.y, r0.z
rcp r4.x, r0.x
mul r4.y, r3, -r0
pow r0, c18.z, r4.y
add r0.y, r4.x, c8.x
mul r4.z, r3.y, -r0.y
mov r4.y, r0.x
pow r0, c18.z, r4.z
add r0.y, r4.x, c7.x
mul r0.y, r2, r0
mul r0.x, r0.y, r0
rcp r0.w, c6.x
mul r0.x, r0, r0.w
mul r0.y, r3.w, r4
mad r3.w, r3.z, r0, -r0.x
mul r3.z, r0.w, r0.y
add r0.xyz, v2, -c0
mul r0.xyz, r0, c9.x
add r0.xyz, r0, c0
add r0.xyz, r1, -r0
dp3 r0.y, r0, r0
mad r2.z, r2, c6.x, r3.x
rsq r1.x, r2.z
rcp r0.x, r1.x
rsq r0.z, r0.y
add r0.y, r0.x, c8.x
rcp r1.x, r0.z
mul r0.y, r3, -r0
rsq r0.z, r2.x
rcp r0.z, r0.z
pow r4, c18.z, r0.y
add r0.x, r0, c7
add r1.x, r0.z, r1
mov r0.y, r4.x
mul r0.x, r2.y, r0
mul r0.x, r0, r0.y
mad r2.x, r0.w, r0, -r3.z
mul r0.x, r1, c18.w
add r0.y, r0.x, c13.x
add r0.x, r0.z, c16
mul r1.x, r0.y, -c12
mul r2.y, r0.x, -c15.x
pow r0, c11.x, r1.x
mul r2.z, r1.w, c10.x
mov r0.y, r0.x
pow r1, c14.x, r2.y
mov r0.x, r1
mul_sat r0.x, r0, c17
mul r0.y, r2.z, r0
mul r0.y, r0.x, r0
add r0.x, r3.w, r2
mad_sat r0.x, r0, c19, r0.y
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 240 // 228 used size, 23 vars
Vector 112 [_Color] 4
Float 144 [_OceanRadius]
Float 172 [_DensityFactorA]
Float 176 [_DensityFactorB]
Float 180 [_DensityFactorC]
Float 184 [_DensityFactorD]
Float 188 [_DensityFactorE]
Float 192 [_Scale]
Float 196 [_Visibility]
Float 200 [_DensityVisibilityBase]
Float 204 [_DensityVisibilityPow]
Float 208 [_DensityVisibilityOffset]
Float 212 [_DensityCutoffBase]
Float 216 [_DensityCutoffPow]
Float 220 [_DensityCutoffOffset]
Float 224 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 105 instructions, 4 temp regs, 0 temp arrays:
// ALU 100 float, 0 int, 2 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedllbkgpciggdjjmbfnekbjclnakopioebabaaaaaapmanaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmamaaaa
eaaaaaaadhadaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaa
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
akaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadiaaaaaj
ecaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaakiacaaaaaaaaaaaamaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
afaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaadcaaaaakbcaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
dcaaaaakecaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaia
ebaaaaaaacaaaaaabnaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
acaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaai
ccaabaaaacaaaaaabkaabaaaacaaaaaaakiacaaaaaaaaaaaalaaaaaaelaaaaaf
fcaabaaaacaaaaaaagacbaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaiaebaaaaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaackaabaaaacaaaaaabnaaaaah
ecaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaabaaaaahecaabaaa
acaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaaakaabaiaebaaaaaa
acaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaackaabaaaacaaaaaa
bkaabaaaaaaaaaaaakaabaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaaakaabaaa
acaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
bkaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaaijcaabaaaacaaaaaafgafbaaaaaaaaaaakgiocaaaaaaaaaaa
alaaaaaaaoaaaaajccaabaaaaaaaaaaadkaabaiaebaaaaaaacaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaajicaabaaa
acaaaaaadkiacaaaaaaaaaaaakaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamadiaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaacaaaaaaaoaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaakaabaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
ckaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaaimcaabaaaaaaaaaaakgakbaaaaaaaaaaakgiocaaaaaaaaaaa
alaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
dcaaaaakbcaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaaakaabaaaacaaaaaa
bkaabaaaacaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaaaaaaaaai
gcaabaaaacaaaaaafgafbaaaacaaaaaakgilcaaaaaaaaaaaalaaaaaaaaaaaaai
dcaabaaaadaaaaaaagaabaaaacaaaaaaogikcaaaaaaaaaaaalaaaaaaaoaaaaaj
bcaabaaaacaaaaaabkaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaalaaaaaa
diaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadiaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaadaaaaaaaoaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaa
aaaaaaaaalaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
akaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaadkaabaaa
acaaaaaaaoaaaaajccaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahbcaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaaaoaaaaaibcaabaaaacaaaaaa
akaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaacaaaaaaaoaaaaajicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaak
hcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaabaaaaaa
aeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
amaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaaaaeaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaadcaaaaalhcaabaaaacaaaaaaagiacaaaaaaaaaaaamaaaaaa
egacbaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaa
diaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
anaaaaaadcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadp
akiacaaaaaaaaaaaanaaaaaadiaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaiaebaaaaaaaaaaaaaaamaaaaaacpaaaaagbcaabaaaabaaaaaackiacaaa
aaaaaaaaamaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaacpaaaaagecaabaaaaaaaaaaa
bkiacaaaaaaaaaaaanaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadicaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaoaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaa
dgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab"
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
Float 3 [_OceanRadius]
Float 4 [_DensityFactorA]
Float 5 [_DensityFactorB]
Float 6 [_DensityFactorC]
Float 7 [_DensityFactorD]
Float 8 [_DensityFactorE]
Float 9 [_Scale]
Float 10 [_Visibility]
Float 11 [_DensityVisibilityBase]
Float 12 [_DensityVisibilityPow]
Float 13 [_DensityVisibilityOffset]
Float 14 [_DensityCutoffBase]
Float 15 [_DensityCutoffPow]
Float 16 [_DensityCutoffOffset]
Float 17 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 127 ALU, 1 TEX
dcl_2d s0
def c18, 1.00000000, 0.00000000, 2.71828175, 0.50000000
def c19, -2.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.z, v3, r1
dp3 r2.x, v3, v3
mad r0.x, -r2.z, r2.z, r2
rsq r0.y, r0.x
mov r0.x, c9
cmp r2.w, r2.z, c18.x, c18.y
mul r0.z, c3.x, r0.x
rcp r0.y, r0.y
add r0.x, r0.z, -r0.y
mul r0.y, r0, r0
mad r0.z, r0, r0, -r0.y
cmp r0.x, r0, c18, c18.y
mul r0.w, r0.x, r2
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rsq r0.z, r0.z
rcp r0.x, r0.x
rcp r0.z, r0.z
mul r3.x, r0.y, c5
mul r0.x, r0, c9
add r0.z, r2, -r0
add r0.z, r0, -r0.x
mad r0.z, r0.w, r0, r0.x
add r1.w, r2.x, -r0.y
rsq r0.w, r1.w
min r1.w, r0.z, r0.x
add r0.z, -r2, r1.w
rcp r0.x, r0.w
max r2.y, r0.z, c18
add r0.w, r1, r0.x
add r2.y, r2, -r0.w
mad r0.w, r2.y, r2, r0
mul r0.y, r0.w, r0.w
mad r0.y, r0, c6.x, r3.x
rsq r0.y, r0.y
rcp r0.w, r0.y
mov r0.y, c4.x
mul r2.y, c7.x, r0
add r3.y, r0.w, c7.x
mul r3.z, r2.y, r3.y
max r0.z, -r0, c18.y
add r0.z, -r0.x, r0
mad r0.x, r2.w, r0.z, r0
mul r0.x, r0, r0
mul r2.z, r2, r2.w
mul r2.z, r2, r2
mad r1.xyz, r1, r1.w, c0
rcp r3.y, c7.x
add r0.y, r0.w, c8.x
mul r3.w, -r0.y, r3.y
mad r4.x, r0, c6, r3
pow r0, c18.z, r3.w
rsq r0.y, r4.x
mul r3.z, r3, r0.x
rcp r0.y, r0.y
add r0.z, r0.y, c7.x
add r0.y, r0, c8.x
rsq r0.x, r3.x
mul r3.w, r2.y, r0.z
rcp r4.x, r0.x
mul r4.y, r3, -r0
pow r0, c18.z, r4.y
add r0.y, r4.x, c8.x
mul r4.z, r3.y, -r0.y
mov r4.y, r0.x
pow r0, c18.z, r4.z
add r0.y, r4.x, c7.x
mul r0.y, r2, r0
mul r0.x, r0.y, r0
rcp r0.w, c6.x
mul r0.x, r0, r0.w
mul r0.y, r3.w, r4
mad r3.w, r3.z, r0, -r0.x
mul r3.z, r0.w, r0.y
add r0.xyz, v2, -c0
mul r0.xyz, r0, c9.x
add r0.xyz, r0, c0
add r0.xyz, r1, -r0
dp3 r0.y, r0, r0
mad r2.z, r2, c6.x, r3.x
rsq r1.x, r2.z
rcp r0.x, r1.x
rsq r0.z, r0.y
add r0.y, r0.x, c8.x
rcp r1.x, r0.z
mul r0.y, r3, -r0
rsq r0.z, r2.x
rcp r0.z, r0.z
pow r4, c18.z, r0.y
add r0.x, r0, c7
add r1.x, r0.z, r1
mov r0.y, r4.x
mul r0.x, r2.y, r0
mul r0.x, r0, r0.y
mad r2.x, r0.w, r0, -r3.z
mul r0.x, r1, c18.w
add r0.y, r0.x, c13.x
add r0.x, r0.z, c16
mul r1.x, r0.y, -c12
mul r2.y, r0.x, -c15.x
pow r0, c11.x, r1.x
mul r2.z, r1.w, c10.x
mov r0.y, r0.x
pow r1, c14.x, r2.y
mov r0.x, r1
mul_sat r0.x, r0, c17
mul r0.y, r2.z, r0
mul r0.y, r0.x, r0
add r0.x, r3.w, r2
mad_sat r0.x, r0, c19, r0.y
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 240 // 228 used size, 23 vars
Vector 112 [_Color] 4
Float 144 [_OceanRadius]
Float 172 [_DensityFactorA]
Float 176 [_DensityFactorB]
Float 180 [_DensityFactorC]
Float 184 [_DensityFactorD]
Float 188 [_DensityFactorE]
Float 192 [_Scale]
Float 196 [_Visibility]
Float 200 [_DensityVisibilityBase]
Float 204 [_DensityVisibilityPow]
Float 208 [_DensityVisibilityOffset]
Float 212 [_DensityCutoffBase]
Float 216 [_DensityCutoffPow]
Float 220 [_DensityCutoffOffset]
Float 224 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 105 instructions, 4 temp regs, 0 temp arrays:
// ALU 100 float, 0 int, 2 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedllbkgpciggdjjmbfnekbjclnakopioebabaaaaaapmanaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmamaaaa
eaaaaaaadhadaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaa
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
akaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadiaaaaaj
ecaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaakiacaaaaaaaaaaaamaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
afaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaadcaaaaakbcaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
dcaaaaakecaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaia
ebaaaaaaacaaaaaabnaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
acaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaai
ccaabaaaacaaaaaabkaabaaaacaaaaaaakiacaaaaaaaaaaaalaaaaaaelaaaaaf
fcaabaaaacaaaaaaagacbaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaiaebaaaaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaackaabaaaacaaaaaabnaaaaah
ecaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaabaaaaahecaabaaa
acaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaaakaabaiaebaaaaaa
acaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaackaabaaaacaaaaaa
bkaabaaaaaaaaaaaakaabaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaaakaabaaa
acaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
bkaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaaijcaabaaaacaaaaaafgafbaaaaaaaaaaakgiocaaaaaaaaaaa
alaaaaaaaoaaaaajccaabaaaaaaaaaaadkaabaiaebaaaaaaacaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaajicaabaaa
acaaaaaadkiacaaaaaaaaaaaakaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamadiaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaacaaaaaaaoaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaakaabaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
ckaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaaimcaabaaaaaaaaaaakgakbaaaaaaaaaaakgiocaaaaaaaaaaa
alaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
dcaaaaakbcaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaaakaabaaaacaaaaaa
bkaabaaaacaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaaaaaaaaai
gcaabaaaacaaaaaafgafbaaaacaaaaaakgilcaaaaaaaaaaaalaaaaaaaaaaaaai
dcaabaaaadaaaaaaagaabaaaacaaaaaaogikcaaaaaaaaaaaalaaaaaaaoaaaaaj
bcaabaaaacaaaaaabkaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaalaaaaaa
diaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadiaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaadaaaaaaaoaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaa
aaaaaaaaalaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
akaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaadkaabaaa
acaaaaaaaoaaaaajccaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahbcaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaaaoaaaaaibcaabaaaacaaaaaa
akaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaacaaaaaaaoaaaaajicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaak
hcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaabaaaaaa
aeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
amaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaaaaeaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaadcaaaaalhcaabaaaacaaaaaaagiacaaaaaaaaaaaamaaaaaa
egacbaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaa
diaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
anaaaaaadcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadp
akiacaaaaaaaaaaaanaaaaaadiaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaiaebaaaaaaaaaaaaaaamaaaaaacpaaaaagbcaabaaaabaaaaaackiacaaa
aaaaaaaaamaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaacpaaaaagecaabaaaaaaaaaaa
bkiacaaaaaaaaaaaanaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadicaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaoaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaa
dgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab"
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
Float 3 [_OceanRadius]
Float 4 [_DensityFactorA]
Float 5 [_DensityFactorB]
Float 6 [_DensityFactorC]
Float 7 [_DensityFactorD]
Float 8 [_DensityFactorE]
Float 9 [_Scale]
Float 10 [_Visibility]
Float 11 [_DensityVisibilityBase]
Float 12 [_DensityVisibilityPow]
Float 13 [_DensityVisibilityOffset]
Float 14 [_DensityCutoffBase]
Float 15 [_DensityCutoffPow]
Float 16 [_DensityCutoffOffset]
Float 17 [_DensityCutoffScale]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 127 ALU, 1 TEX
dcl_2d s0
def c18, 1.00000000, 0.00000000, 2.71828175, 0.50000000
def c19, -2.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord4 v2.xyz
dcl_texcoord5 v3.xyz
add r0.xyz, v1, -c0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r2.z, v3, r1
dp3 r2.x, v3, v3
mad r0.x, -r2.z, r2.z, r2
rsq r0.y, r0.x
mov r0.x, c9
cmp r2.w, r2.z, c18.x, c18.y
mul r0.z, c3.x, r0.x
rcp r0.y, r0.y
add r0.x, r0.z, -r0.y
mul r0.y, r0, r0
mad r0.z, r0, r0, -r0.y
cmp r0.x, r0, c18, c18.y
mul r0.w, r0.x, r2
texldp r0.x, v0, s0
mad r0.x, r0, c1.z, c1.w
rsq r0.z, r0.z
rcp r0.x, r0.x
rcp r0.z, r0.z
mul r3.x, r0.y, c5
mul r0.x, r0, c9
add r0.z, r2, -r0
add r0.z, r0, -r0.x
mad r0.z, r0.w, r0, r0.x
add r1.w, r2.x, -r0.y
rsq r0.w, r1.w
min r1.w, r0.z, r0.x
add r0.z, -r2, r1.w
rcp r0.x, r0.w
max r2.y, r0.z, c18
add r0.w, r1, r0.x
add r2.y, r2, -r0.w
mad r0.w, r2.y, r2, r0
mul r0.y, r0.w, r0.w
mad r0.y, r0, c6.x, r3.x
rsq r0.y, r0.y
rcp r0.w, r0.y
mov r0.y, c4.x
mul r2.y, c7.x, r0
add r3.y, r0.w, c7.x
mul r3.z, r2.y, r3.y
max r0.z, -r0, c18.y
add r0.z, -r0.x, r0
mad r0.x, r2.w, r0.z, r0
mul r0.x, r0, r0
mul r2.z, r2, r2.w
mul r2.z, r2, r2
mad r1.xyz, r1, r1.w, c0
rcp r3.y, c7.x
add r0.y, r0.w, c8.x
mul r3.w, -r0.y, r3.y
mad r4.x, r0, c6, r3
pow r0, c18.z, r3.w
rsq r0.y, r4.x
mul r3.z, r3, r0.x
rcp r0.y, r0.y
add r0.z, r0.y, c7.x
add r0.y, r0, c8.x
rsq r0.x, r3.x
mul r3.w, r2.y, r0.z
rcp r4.x, r0.x
mul r4.y, r3, -r0
pow r0, c18.z, r4.y
add r0.y, r4.x, c8.x
mul r4.z, r3.y, -r0.y
mov r4.y, r0.x
pow r0, c18.z, r4.z
add r0.y, r4.x, c7.x
mul r0.y, r2, r0
mul r0.x, r0.y, r0
rcp r0.w, c6.x
mul r0.x, r0, r0.w
mul r0.y, r3.w, r4
mad r3.w, r3.z, r0, -r0.x
mul r3.z, r0.w, r0.y
add r0.xyz, v2, -c0
mul r0.xyz, r0, c9.x
add r0.xyz, r0, c0
add r0.xyz, r1, -r0
dp3 r0.y, r0, r0
mad r2.z, r2, c6.x, r3.x
rsq r1.x, r2.z
rcp r0.x, r1.x
rsq r0.z, r0.y
add r0.y, r0.x, c8.x
rcp r1.x, r0.z
mul r0.y, r3, -r0
rsq r0.z, r2.x
rcp r0.z, r0.z
pow r4, c18.z, r0.y
add r0.x, r0, c7
add r1.x, r0.z, r1
mov r0.y, r4.x
mul r0.x, r2.y, r0
mul r0.x, r0, r0.y
mad r2.x, r0.w, r0, -r3.z
mul r0.x, r1, c18.w
add r0.y, r0.x, c13.x
add r0.x, r0.z, c16
mul r1.x, r0.y, -c12
mul r2.y, r0.x, -c15.x
pow r0, c11.x, r1.x
mul r2.z, r1.w, c10.x
mov r0.y, r0.x
pow r1, c14.x, r2.y
mov r0.x, r1
mul_sat r0.x, r0, c17
mul r0.y, r2.z, r0
mul r0.y, r0.x, r0
add r0.x, r3.w, r2
mad_sat r0.x, r0, c19, r0.y
mul_pp oC0.w, r0.x, c2
mov_pp oC0.xyz, c2
"
}

SubProgram "d3d11 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 240 // 228 used size, 23 vars
Vector 112 [_Color] 4
Float 144 [_OceanRadius]
Float 172 [_DensityFactorA]
Float 176 [_DensityFactorB]
Float 180 [_DensityFactorC]
Float 184 [_DensityFactorD]
Float 188 [_DensityFactorE]
Float 192 [_Scale]
Float 196 [_Visibility]
Float 200 [_DensityVisibilityBase]
Float 204 [_DensityVisibilityPow]
Float 208 [_DensityVisibilityOffset]
Float 212 [_DensityCutoffBase]
Float 216 [_DensityCutoffPow]
Float 220 [_DensityCutoffOffset]
Float 224 [_DensityCutoffScale]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 105 instructions, 4 temp regs, 0 temp arrays:
// ALU 100 float, 0 int, 2 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedllbkgpciggdjjmbfnekbjclnakopioebabaaaaaapmanaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmamaaaa
eaaaaaaadhadaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaa
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
akaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadiaaaaaj
ecaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaakiacaaaaaaaaaaaamaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
afaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaadcaaaaakbcaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
dcaaaaakecaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaia
ebaaaaaaacaaaaaabnaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
acaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaai
ccaabaaaacaaaaaabkaabaaaacaaaaaaakiacaaaaaaaaaaaalaaaaaaelaaaaaf
fcaabaaaacaaaaaaagacbaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaiaebaaaaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaackaabaaaacaaaaaabnaaaaah
ecaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaabaaaaahecaabaaa
acaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaaakaabaiaebaaaaaa
acaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaackaabaaaacaaaaaa
bkaabaaaaaaaaaaaakaabaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaaakaabaaa
acaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
bkaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaaijcaabaaaacaaaaaafgafbaaaaaaaaaaakgiocaaaaaaaaaaa
alaaaaaaaoaaaaajccaabaaaaaaaaaaadkaabaiaebaaaaaaacaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaajicaabaaa
acaaaaaadkiacaaaaaaaaaaaakaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamadiaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaacaaaaaaaoaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaaaacaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaakaabaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
ckaabaaaaaaaaaaabkaabaaaacaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaaimcaabaaaaaaaaaaakgakbaaaaaaaaaaakgiocaaaaaaaaaaa
alaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
dcaaaaakbcaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaaakaabaaaacaaaaaa
bkaabaaaacaaaaaaelaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaaaaaaaaai
gcaabaaaacaaaaaafgafbaaaacaaaaaakgilcaaaaaaaaaaaalaaaaaaaaaaaaai
dcaabaaaadaaaaaaagaabaaaacaaaaaaogikcaaaaaaaaaaaalaaaaaaaoaaaaaj
bcaabaaaacaaaaaabkaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaalaaaaaa
diaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadiaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaadaaaaaaaoaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaa
aaaaaaaaalaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
akaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaadkaabaaa
acaaaaaaaoaaaaajccaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaackiacaaa
aaaaaaaaalaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahbcaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaaaoaaaaaibcaabaaaacaaaaaa
akaabaaaacaaaaaabkiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaacaaaaaaaoaaaaajicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaackiacaaaaaaaaaaaalaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
aaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaak
hcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaabaaaaaa
aeaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
amaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaaaaeaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaadcaaaaalhcaabaaaacaaaaaaagiacaaaaaaaaaaaamaaaaaa
egacbaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaa
diaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
anaaaaaadcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadp
akiacaaaaaaaaaaaanaaaaaadiaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkiacaiaebaaaaaaaaaaaaaaamaaaaaacpaaaaagbcaabaaaabaaaaaackiacaaa
aaaaaaaaamaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaacpaaaaagecaabaaaaaaaaaaa
bkiacaaaaaaaaaaaanaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaabjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadicaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaoaaaaaadccaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaa
dgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadoaaaaab"
}

SubProgram "gles3 " {
Keywords { "WORLD_SPACE_ON" "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES3"
}

}

#LINE 206

	
		}
		
	} 
	


			
}
}
