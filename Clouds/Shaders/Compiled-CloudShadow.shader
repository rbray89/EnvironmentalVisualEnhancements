Shader "Projector/CloudShadow" {
   Properties {
      _ShadowTex ("Projected Image", 2D) = "white" {}
      _ShadowOffset ("Shadow Offset", Vector) = (0,0,0,0)
   }
   SubShader {
      Pass {      
        Blend DstColor Zero
        Program "vp" {
// Vertex combos: 1
//   d3d9 - ALU: 12 to 12
//   d3d11 - ALU: 12 to 12, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL
#ifdef VERTEX
varying float xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform mat4 _Projector;

void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.x = _Projector[0].z;
  tmpvar_1.y = _Projector[1].z;
  tmpvar_1.z = _Projector[2].z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Projector * gl_Vertex);
  xlv_TEXCOORD1 = clamp (dot (-(gl_Normal), normalize(tmpvar_1)), 0.0, 1.0);
}


#endif
#ifdef FRAGMENT
varying float xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec4 _ShadowOffset;
uniform sampler2D _ShadowTex;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_ShadowTex, (((vec2(0.5, 1.0) * xlv_TEXCOORD0.xy) / xlv_TEXCOORD0.w) + _ShadowOffset.xy));
  color_1.w = tmpvar_2.w;
  color_1.xyz = (tmpvar_2.xyz * (1.25 * (1.25 - tmpvar_2.w)));
  vec4 tmpvar_3;
  tmpvar_3 = clamp (color_1, 0.0, 1.0);
  color_1 = tmpvar_3;
  gl_FragData[0] = vec4(mix (1.0, tmpvar_3.x, (clamp (floor((xlv_TEXCOORD0.w + 1.0)), 0.0, 1.0) * xlv_TEXCOORD1)));
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Projector]
"vs_3_0
; 12 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_position0 v0
dcl_normal0 v1
dp3 r0.x, c6, c6
rsq r0.x, r0.x
mul r0.xyz, r0.x, c6
dp3_sat o2.x, -v1, r0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.w, v0, c7
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
ConstBuffer "$Globals" 80 // 80 used size, 2 vars
Matrix 16 [_Projector] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerDraw" 1
// 16 instructions, 1 temp regs, 0 temp arrays:
// ALU 12 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedipliojeibnjgcphbnenmjfifjppkcgdlabaaaaaaemadaaaaadaaaaaa
cmaaaaaahmaaaaaaomaaaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafaepfdejfeejepeoaaeoepfcenebemaaepfdeheo
giaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaabaoaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcfiacaaaaeaaaabaajgaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadbccabaaaacaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaabaaaaaaegiocaaaaaaaaaaa
aeaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaagbcaabaaaaaaaaaaa
ckiacaaaaaaaaaaaabaaaaaadgaaaaagccaabaaaaaaaaaaackiacaaaaaaaaaaa
acaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaaaaaaaaaadaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabacaaaaibccabaaaacaaaaaaegbcbaiaebaaaaaaabaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Projector;
uniform highp mat4 glstate_matrix_mvp;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1.x = _Projector[0].z;
  tmpvar_1.y = _Projector[1].z;
  tmpvar_1.z = _Projector[2].z;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = clamp (dot (-(normalize(_glesNormal)), normalize(tmpvar_1)), 0.0, 1.0);
}



#endif
#ifdef FRAGMENT

varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _ShadowOffset;
uniform sampler2D _ShadowTex;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float dirCheck_3;
  highp float tmpvar_4;
  tmpvar_4 = (clamp (floor((xlv_TEXCOORD0.w + 1.0)), 0.0, 1.0) * xlv_TEXCOORD1);
  dirCheck_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((vec2(0.5, 1.0) * xlv_TEXCOORD0.xy) / xlv_TEXCOORD0.w) + _ShadowOffset.xy);
  tmpvar_5 = texture2D (_ShadowTex, P_6);
  color_2.w = tmpvar_5.w;
  color_2.xyz = (tmpvar_5.xyz * (1.25 * (1.25 - tmpvar_5.w)));
  lowp vec4 tmpvar_7;
  tmpvar_7 = clamp (color_2, 0.0, 1.0);
  color_2 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = vec4(mix (1.0, tmpvar_7.x, dirCheck_3));
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Projector;
uniform highp mat4 glstate_matrix_mvp;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1.x = _Projector[0].z;
  tmpvar_1.y = _Projector[1].z;
  tmpvar_1.z = _Projector[2].z;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = clamp (dot (-(normalize(_glesNormal)), normalize(tmpvar_1)), 0.0, 1.0);
}



#endif
#ifdef FRAGMENT

varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _ShadowOffset;
uniform sampler2D _ShadowTex;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float dirCheck_3;
  highp float tmpvar_4;
  tmpvar_4 = (clamp (floor((xlv_TEXCOORD0.w + 1.0)), 0.0, 1.0) * xlv_TEXCOORD1);
  dirCheck_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((vec2(0.5, 1.0) * xlv_TEXCOORD0.xy) / xlv_TEXCOORD0.w) + _ShadowOffset.xy);
  tmpvar_5 = texture2D (_ShadowTex, P_6);
  color_2.w = tmpvar_5.w;
  color_2.xyz = (tmpvar_5.xyz * (1.25 * (1.25 - tmpvar_5.w)));
  lowp vec4 tmpvar_7;
  tmpvar_7 = clamp (color_2, 0.0, 1.0);
  color_2 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = vec4(mix (1.0, tmpvar_7.x, dirCheck_3));
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
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
#line 60
struct v2f {
    highp vec4 pos;
    highp vec4 posProj;
    highp float dotcoeff;
};
#line 54
struct appdata_t {
    highp vec4 vertex;
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
uniform sampler2D _ShadowTex;
uniform highp vec4 _ShadowOffset;
uniform highp mat4 _Projector;
#line 67
#line 76
#line 67
v2f vert( in appdata_t v ) {
    v2f o;
    o.posProj = (_Projector * v.vertex);
    #line 71
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 normView = normalize(vec3( _Projector[0][2], _Projector[1][2], _Projector[2][2]));
    o.dotcoeff = xll_saturate_f(dot( (-v.normal), normView));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.posProj);
    xlv_TEXCOORD1 = float(xl_retval.dotcoeff);
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
#line 60
struct v2f {
    highp vec4 pos;
    highp vec4 posProj;
    highp float dotcoeff;
};
#line 54
struct appdata_t {
    highp vec4 vertex;
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
uniform sampler2D _ShadowTex;
uniform highp vec4 _ShadowOffset;
uniform highp mat4 _Projector;
#line 67
#line 76
#line 76
lowp vec4 frag( in v2f IN ) {
    mediump float dirCheck = (xll_saturate_f(floor((IN.posProj.w + 1.0))) * IN.dotcoeff);
    lowp vec4 color = texture( _ShadowTex, (((vec2( 0.5, 1.0) * IN.posProj.xy) / IN.posProj.w) + _ShadowOffset.xy));
    #line 80
    color.xyz *= (1.25 * (1.25 - color.w));
    color = xll_saturate_vf4(color);
    return vec4( mix( 1.0, float( color), dirCheck));
}
in highp vec4 xlv_TEXCOORD0;
in highp float xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.posProj = vec4(xlv_TEXCOORD0);
    xlt_IN.dotcoeff = float(xlv_TEXCOORD1);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   d3d9 - ALU: 13 to 13, TEX: 1 to 1
//   d3d11 - ALU: 11 to 11, TEX: 1 to 1, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { }
Vector 0 [_ShadowOffset]
SetTexture 0 [_ShadowTex] 2D
"ps_3_0
; 13 ALU, 1 TEX
dcl_2d s0
def c1, 1.00000000, 0.50000000, 1.25000000, -1.00000000
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.x
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
mul r0.xy, r0, c1.yxzw
add r0.xy, r0, c0
texld r0.xw, r0, s0
add_pp r0.z, -r0.w, c1
mul_pp r0.z, r0, r0.x
add r0.y, v0.w, c1.x
frc r0.x, r0.y
add_sat r0.x, r0.y, -r0
mul_pp_sat r0.z, r0, c1
add_pp r0.y, r0.z, c1.w
mul r0.x, r0, v1
mad_pp oC0, r0.x, r0.y, c1.x
"
}

SubProgram "d3d11 " {
Keywords { }
ConstBuffer "$Globals" 80 // 16 used size, 2 vars
Vector 0 [_ShadowOffset] 4
BindCB "$Globals" 0
SetTexture 0 [_ShadowTex] 2D 0
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 11 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedgcipecaohdncijlhagpdkciahicccbpkabaaaaaaneacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ababaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpmabaaaaeaaaaaaahpaaaaaa
fjaaaaaeegiocaaaaaaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadbcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaadiaaaaakdcaabaaa
aaaaaaaaegbabaaaabaaaaaaaceaaaaaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaaaaaaaai
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaakadp
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaakadpdicaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaaaabaaaaaadgcaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpaaaaaaahbcaabaaaabaaaaaa
dkbabaaaabaaaaaaabeaaaaaaaaaiadpebcaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakbabaaaacaaaaaa
dcaaaaampccabaaaaaaaaaaaagaabaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3"
}

}

#LINE 49

      }
   }  
}