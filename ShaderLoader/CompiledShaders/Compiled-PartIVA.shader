Shader "EVE/RealWindows" {
	Properties{
		_MainTex("_MainTex (RGB spec(A))", 2D) = "white" {}
		_IVATex("Base (RGB) Gloss (A)", 2D) = "white" {}
		_Clarity("Clarity", Float) = 1.1
		_Shininess("Shininess", Float) = 0
	}

		SubShader{
			Tags{ "Queue" = "Geometry+1" "IgnoreProjector" = "True" "RenderType" = "Transparent" }

			ZWrite Off
			Blend SrcAlpha OneMinusSrcAlpha
			Offset 0, 0
			Lighting Off
		
			Pass{
			Program "vp" {
// Vertex combos: 2
//   d3d9 - ALU: 10 to 10
//   d3d11 - ALU: 8 to 8, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "TRANSPARENT_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform vec4 _MainTex_ST;

uniform vec4 _ProjectionParams;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_2;
  vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_2;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform vec4 _RearWindowColor;
uniform float _Clarity;
uniform sampler2D _IVATex;
uniform sampler2D _MainTex;
void main ()
{
  vec4 iva_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_IVATex, (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w));
  iva_1.w = tmpvar_3.w;
  iva_1.xyz = mix (tmpvar_2.xyz, tmpvar_3.xyz, vec3(clamp (((1.0 - tmpvar_2.w) * _Clarity), 0.0, 1.0)));
  iva_1.xyz = mix (_RearWindowColor.xyz, iva_1.xyz, tmpvar_3.www);
  iva_1.w = (1.0 - float((tmpvar_2.w >= 0.9)));
  gl_FragData[0] = iva_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "TRANSPARENT_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
Vector 6 [_MainTex_ST]
"vs_3_0
; 10 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c7, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c7.x
mul r1.y, r1, c4.x
mad o2.xy, r1.z, c5.zwzw, r1
mov o0, r0
mov o2.zw, r0
mad o1.xy, v1, c6, c6.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "TRANSPARENT_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64 // 32 used size, 5 vars
Vector 16 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedfgkpbhnjbgljamgpbiljojcpbdgbcjjlabaaaaaammacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcneabaaaaeaaaabaahfaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
acaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "TRANSPARENT_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
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
  xlv_TEXCOORD1 = o_4;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD0;
uniform mediump vec4 _RearWindowColor;
uniform highp float _Clarity;
uniform sampler2D _IVATex;
uniform sampler2D _MainTex;
void main ()
{
  mediump float alpha_1;
  lowp vec4 iva_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_IVATex, tmpvar_3);
  iva_2.w = tmpvar_5.w;
  highp float tmpvar_6;
  tmpvar_6 = clamp (((1.0 - tmpvar_4.w) * _Clarity), 0.0, 1.0);
  alpha_1 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_4.xyz, tmpvar_5.xyz, vec3(alpha_1));
  iva_2.xyz = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (_RearWindowColor.xyz, iva_2.xyz, tmpvar_5.www);
  iva_2.xyz = tmpvar_8;
  iva_2.w = (1.0 - float((tmpvar_4.w >= 0.9)));
  gl_FragData[0] = iva_2;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "TRANSPARENT_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
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
  xlv_TEXCOORD1 = o_4;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD0;
uniform mediump vec4 _RearWindowColor;
uniform highp float _Clarity;
uniform sampler2D _IVATex;
uniform sampler2D _MainTex;
void main ()
{
  mediump float alpha_1;
  lowp vec4 iva_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_IVATex, tmpvar_3);
  iva_2.w = tmpvar_5.w;
  highp float tmpvar_6;
  tmpvar_6 = clamp (((1.0 - tmpvar_4.w) * _Clarity), 0.0, 1.0);
  alpha_1 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_4.xyz, tmpvar_5.xyz, vec3(alpha_1));
  iva_2.xyz = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (_RearWindowColor.xyz, iva_2.xyz, tmpvar_5.www);
  iva_2.xyz = tmpvar_8;
  iva_2.w = (1.0 - float((tmpvar_4.w >= 0.9)));
  gl_FragData[0] = iva_2;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "TRANSPARENT_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;

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
#line 321
struct v2f {
    highp vec4 vertex;
    mediump vec2 texcoord;
    highp vec4 scrPos;
};
#line 315
struct appdata_t {
    highp vec4 vertex;
    highp vec2 texcoord;
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
uniform highp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform sampler2D _MainTex;
uniform sampler2D _IVATex;
uniform highp vec4 _MainTex_ST;
uniform highp float _Clarity;
#line 332
uniform highp float _Shininess;
uniform mediump vec4 _RearWindowColor;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 334
v2f vert( in appdata_t v ) {
    #line 336
    v2f o;
    o.vertex = (glstate_matrix_mvp * v.vertex);
    o.texcoord = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.scrPos = ComputeScreenPos( o.vertex);
    #line 340
    return o;
}
out mediump vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.vertex);
    xlv_TEXCOORD0 = vec2(xl_retval.texcoord);
    xlv_TEXCOORD1 = vec4(xl_retval.scrPos);
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
#line 321
struct v2f {
    highp vec4 vertex;
    mediump vec2 texcoord;
    highp vec4 scrPos;
};
#line 315
struct appdata_t {
    highp vec4 vertex;
    highp vec2 texcoord;
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
uniform highp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform sampler2D _MainTex;
uniform sampler2D _IVATex;
uniform highp vec4 _MainTex_ST;
uniform highp float _Clarity;
#line 332
uniform highp float _Shininess;
uniform mediump vec4 _RearWindowColor;
#line 342
lowp vec4 frag( in v2f i ) {
    #line 344
    highp vec2 scrPos = (i.scrPos.xy / i.scrPos.w);
    lowp vec4 tex = texture( _MainTex, i.texcoord);
    lowp vec4 iva = texture( _IVATex, scrPos);
    mediump float alpha = xll_saturate_f(((1.0 - tex.w) * _Clarity));
    #line 348
    iva.xyz = mix( tex.xyz, iva.xyz, vec3( alpha));
    iva.xyz = mix( _RearWindowColor.xyz, iva.xyz, vec3( iva.w));
    iva.w = 1.0;
    iva.w = (iva.w * (1.0 - step( 0.9, tex.w)));
    #line 352
    return iva;
}
in mediump vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.vertex = vec4(0.0);
    xlt_i.texcoord = vec2(xlv_TEXCOORD0);
    xlt_i.scrPos = vec4(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "TRANSPARENT" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform vec4 _MainTex_ST;

uniform vec4 _ProjectionParams;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_2;
  vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_2;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform vec4 _RearWindowColor;
uniform float _Clarity;
uniform sampler2D _IVATex;
uniform sampler2D _MainTex;
void main ()
{
  vec4 iva_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_IVATex, (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w));
  iva_1.w = tmpvar_3.w;
  iva_1.xyz = mix (tmpvar_2.xyz, tmpvar_3.xyz, vec3(clamp (((1.0 - tmpvar_2.w) * _Clarity), 0.0, 1.0)));
  iva_1.xyz = mix (_RearWindowColor.xyz, iva_1.xyz, tmpvar_3.www);
  iva_1.w = (clamp ((tmpvar_3.w + (1.0 - _Clarity)), 0.0, 1.0) * (1.0 - float((tmpvar_2.w >= 0.9))));
  gl_FragData[0] = iva_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "TRANSPARENT" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
Vector 6 [_MainTex_ST]
"vs_3_0
; 10 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c7, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c7.x
mul r1.y, r1, c4.x
mad o2.xy, r1.z, c5.zwzw, r1
mov o0, r0
mov o2.zw, r0
mad o1.xy, v1, c6, c6.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "TRANSPARENT" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64 // 32 used size, 5 vars
Vector 16 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedfgkpbhnjbgljamgpbiljojcpbdgbcjjlabaaaaaammacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcneabaaaaeaaaabaahfaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
acaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "TRANSPARENT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
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
  xlv_TEXCOORD1 = o_4;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD0;
uniform mediump vec4 _RearWindowColor;
uniform highp float _Clarity;
uniform sampler2D _IVATex;
uniform sampler2D _MainTex;
void main ()
{
  mediump float alpha_1;
  lowp vec4 iva_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_IVATex, tmpvar_3);
  iva_2.w = tmpvar_5.w;
  highp float tmpvar_6;
  tmpvar_6 = clamp (((1.0 - tmpvar_4.w) * _Clarity), 0.0, 1.0);
  alpha_1 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_4.xyz, tmpvar_5.xyz, vec3(alpha_1));
  iva_2.xyz = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp ((tmpvar_5.w + (1.0 - _Clarity)), 0.0, 1.0);
  alpha_1 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (_RearWindowColor.xyz, iva_2.xyz, tmpvar_5.www);
  iva_2.xyz = tmpvar_9;
  iva_2.w = alpha_1;
  iva_2.w = (iva_2.w * (1.0 - float((tmpvar_4.w >= 0.9))));
  gl_FragData[0] = iva_2;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "TRANSPARENT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
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
  xlv_TEXCOORD1 = o_4;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD0;
uniform mediump vec4 _RearWindowColor;
uniform highp float _Clarity;
uniform sampler2D _IVATex;
uniform sampler2D _MainTex;
void main ()
{
  mediump float alpha_1;
  lowp vec4 iva_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_IVATex, tmpvar_3);
  iva_2.w = tmpvar_5.w;
  highp float tmpvar_6;
  tmpvar_6 = clamp (((1.0 - tmpvar_4.w) * _Clarity), 0.0, 1.0);
  alpha_1 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_4.xyz, tmpvar_5.xyz, vec3(alpha_1));
  iva_2.xyz = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp ((tmpvar_5.w + (1.0 - _Clarity)), 0.0, 1.0);
  alpha_1 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (_RearWindowColor.xyz, iva_2.xyz, tmpvar_5.www);
  iva_2.xyz = tmpvar_9;
  iva_2.w = alpha_1;
  iva_2.w = (iva_2.w * (1.0 - float((tmpvar_4.w >= 0.9))));
  gl_FragData[0] = iva_2;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "TRANSPARENT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;

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
#line 321
struct v2f {
    highp vec4 vertex;
    mediump vec2 texcoord;
    highp vec4 scrPos;
};
#line 315
struct appdata_t {
    highp vec4 vertex;
    highp vec2 texcoord;
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
uniform highp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform sampler2D _MainTex;
uniform sampler2D _IVATex;
uniform highp vec4 _MainTex_ST;
uniform highp float _Clarity;
#line 332
uniform highp float _Shininess;
uniform mediump vec4 _RearWindowColor;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 334
v2f vert( in appdata_t v ) {
    #line 336
    v2f o;
    o.vertex = (glstate_matrix_mvp * v.vertex);
    o.texcoord = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.scrPos = ComputeScreenPos( o.vertex);
    #line 340
    return o;
}
out mediump vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.vertex);
    xlv_TEXCOORD0 = vec2(xl_retval.texcoord);
    xlv_TEXCOORD1 = vec4(xl_retval.scrPos);
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
#line 321
struct v2f {
    highp vec4 vertex;
    mediump vec2 texcoord;
    highp vec4 scrPos;
};
#line 315
struct appdata_t {
    highp vec4 vertex;
    highp vec2 texcoord;
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
uniform highp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform sampler2D _MainTex;
uniform sampler2D _IVATex;
uniform highp vec4 _MainTex_ST;
uniform highp float _Clarity;
#line 332
uniform highp float _Shininess;
uniform mediump vec4 _RearWindowColor;
#line 342
lowp vec4 frag( in v2f i ) {
    #line 344
    highp vec2 scrPos = (i.scrPos.xy / i.scrPos.w);
    lowp vec4 tex = texture( _MainTex, i.texcoord);
    lowp vec4 iva = texture( _IVATex, scrPos);
    mediump float alpha = xll_saturate_f(((1.0 - tex.w) * _Clarity));
    #line 348
    iva.xyz = mix( tex.xyz, iva.xyz, vec3( alpha));
    alpha = xll_saturate_f((iva.w + (1.0 - _Clarity)));
    iva.xyz = mix( _RearWindowColor.xyz, iva.xyz, vec3( iva.w));
    iva.w = alpha;
    #line 352
    iva.w = (iva.w * (1.0 - step( 0.9, tex.w)));
    return iva;
}
in mediump vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.vertex = vec4(0.0);
    xlt_i.texcoord = vec2(xlv_TEXCOORD0);
    xlt_i.scrPos = vec4(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 2
//   d3d9 - ALU: 11 to 15, TEX: 2 to 2
//   d3d11 - ALU: 8 to 10, TEX: 2 to 2, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "TRANSPARENT_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "TRANSPARENT_OFF" }
Float 0 [_Clarity]
Vector 1 [_RearWindowColor]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_IVATex] 2D
"ps_3_0
; 11 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c2, -0.89990234, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyzw
rcp r0.x, v1.w
mul r1.xy, v1, r0.x
texld r0, v0, s0
texld r1, r1, s1
add_pp r2.x, -r0.w, c2.y
add_pp r1.xyz, -r0, r1
mul_sat r2.x, r2, c0
mad_pp r1.xyz, r2.x, r1, r0
add_pp r0.x, r0.w, c2
add_pp r1.xyz, r1, -c1
cmp_pp r0.x, r0, c2.y, c2.z
mad_pp oC0.xyz, r1.w, r1, c1
add_pp oC0.w, -r0.x, c2.y
"
}

SubProgram "d3d11 " {
Keywords { "TRANSPARENT_OFF" }
ConstBuffer "$Globals" 64 // 64 used size, 5 vars
Float 32 [_Clarity]
Vector 48 [_RearWindowColor] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_IVATex] 2D 1
// 12 instructions, 3 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedidnemajhiiijdmlnhjnkminncldgicahabaaaaaammacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpeabaaaaeaaaaaaahnaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaaibcaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdicaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaacaaaaaaaoaaaaahgcaabaaa
abaaaaaaagbbbaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
jgafbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaiocaabaaa
abaaaaaaagajbaiaebaaaaaaaaaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaa
aaaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaaaaaaaaabnaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaggggggdpdhaaaaajiccabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaa
dcaaaaakhccabaaaaaaaaaaapgapbaaaacaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "TRANSPARENT_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "TRANSPARENT_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "TRANSPARENT_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "TRANSPARENT" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "TRANSPARENT" }
Float 0 [_Clarity]
Vector 1 [_RearWindowColor]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_IVATex] 2D
"ps_3_0
; 15 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c2, 1.00000000, 0.00000000, -0.89990234, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyzw
rcp r0.x, v1.w
mul r1.xy, v1, r0.x
texld r0, v0, s0
texld r1, r1, s1
add_pp r2.x, -r0.w, c2
add_pp r1.xyz, r1, -r0
mul_sat r2.x, r2, c0
mad_pp r0.xyz, r2.x, r1, r0
add_pp r0.xyz, r0, -c1
mad_pp oC0.xyz, r1.w, r0, c1
add_pp r0.y, r0.w, c2.z
mov r0.x, c0
cmp_pp r0.y, r0, c2.x, c2
add r0.x, c2, -r0
add_pp r0.y, -r0, c2.x
add_sat r0.x, r1.w, r0
mul_pp oC0.w, r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "TRANSPARENT" }
ConstBuffer "$Globals" 64 // 64 used size, 5 vars
Float 32 [_Clarity]
Vector 48 [_RearWindowColor] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_IVATex] 2D 1
// 14 instructions, 3 temp regs, 0 temp arrays:
// ALU 10 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedglbhgedenpfpkagiehlaojakmnnapbpmabaaaaaaamadaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdeacaaaaeaaaaaaainaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaaibcaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdicaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaacaaaaaaaoaaaaahgcaabaaa
abaaaaaaagbbbaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
jgafbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaiocaabaaa
abaaaaaaagajbaiaebaaaaaaaaaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaa
aaaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaaaaaaaaabnaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaggggggdpaaaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaadcaaaaak
hccabaaaaaaaaaaapgapbaaaacaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaaaaaaaaajbcaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaacaaaaaa
abeaaaaaaaaaiadpaacaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
acaaaaaadhaaaaajiccabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
akaabaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "TRANSPARENT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "TRANSPARENT" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "TRANSPARENT" }
"!!GLES3"
}

}

#LINE 73

		}
	}
}
