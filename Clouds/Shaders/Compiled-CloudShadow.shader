Shader "Projector/CloudShadow" {
   Properties {
      _MainTex ("Main (RGB)", 2D) = "white" {}
      _MainOffset ("Main Offset", Vector) = (0,0,0,0)
      _DetailTex ("Detail (RGB)", 2D) = "white" {}
      _DetailScale ("Detail Scale", float) = 100
	  _DetailOffset ("Detail Offset", Vector) = (.5,.5,0,0)
	  _DetailDist ("Detail Distance", Range(0,1)) = 0.00875
   }
   SubShader {
      Pass {      
        Blend DstColor Zero
        ZWrite Off
        Program "vp" {
// Vertex combos: 1
//   d3d9 - ALU: 62 to 62
//   d3d11 - ALU: 48 to 48, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform mat4 _Projector;
uniform vec4 _MainOffset;
uniform mat4 _Object2World;

void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  float tmpvar_3;
  float tmpvar_4;
  tmpvar_2 = (_Projector * gl_Vertex);
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_5;
  tmpvar_5.x = _Projector[0].z;
  tmpvar_5.y = _Projector[1].z;
  tmpvar_5.z = _Projector[2].z;
  tmpvar_3 = clamp (dot (-(gl_Normal), normalize(tmpvar_5)), 0.0, 1.0);
  tmpvar_4 = (sign(_MainOffset.y) * (1.5708 - (sqrt((1.0 - abs(_MainOffset.y))) * (1.5708 + (abs(_MainOffset.y) * (-0.214602 + (abs(_MainOffset.y) * (0.0865667 + (abs(_MainOffset.y) * -0.0310296)))))))));
  float r_6;
  if ((abs(_MainOffset.z) > (1e-08 * abs(_MainOffset.x)))) {
    float y_over_x_7;
    y_over_x_7 = (_MainOffset.x / _MainOffset.z);
    float s_8;
    float x_9;
    x_9 = (y_over_x_7 * inversesqrt(((y_over_x_7 * y_over_x_7) + 1.0)));
    s_8 = (sign(x_9) * (1.5708 - (sqrt((1.0 - abs(x_9))) * (1.5708 + (abs(x_9) * (-0.214602 + (abs(x_9) * (0.0865667 + (abs(x_9) * -0.0310296)))))))));
    r_6 = s_8;
    if ((_MainOffset.z < 0.0)) {
      if ((_MainOffset.x >= 0.0)) {
        r_6 = (s_8 + 3.14159);
      } else {
        r_6 = (r_6 - 3.14159);
      };
    };
  } else {
    r_6 = (sign(_MainOffset.x) * 1.5708);
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = r_6;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _DetailDist;
uniform float _DetailScale;
uniform vec4 _DetailOffset;
uniform sampler2D _DetailTex;
uniform vec4 _MainOffset;
uniform sampler2D _MainTex;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 objNrm_1;
  vec4 color_2;
  vec2 detailuv_3;
  float radCheck_4;
  vec2 dy_5;
  vec2 dx_6;
  vec2 uv_7;
  float dirCheck_8;
  dirCheck_8 = (clamp (floor((xlv_TEXCOORD0.w + 1.0)), 0.0, 1.0) * xlv_TEXCOORD1);
  vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  uv_7 = tmpvar_9;
  dx_6 = dFdx(xlv_TEXCOORD0.xy);
  dy_5 = dFdy(xlv_TEXCOORD0.xy);
  float tmpvar_10;
  tmpvar_10 = (-((2.0 * tmpvar_9.x)) + 1.0);
  float tmpvar_11;
  tmpvar_11 = ((2.0 * tmpvar_9.y) - 1.0);
  float tmpvar_12;
  tmpvar_12 = sqrt((pow (tmpvar_10, 2.0) + pow (tmpvar_11, 2.0)));
  radCheck_4 = clamp (floor((2.0 - tmpvar_12)), 0.0, 1.0);
  float tmpvar_13;
  tmpvar_13 = (sign(tmpvar_12) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12))) * (1.5708 + (abs(tmpvar_12) * (-0.214602 + (abs(tmpvar_12) * (0.0865667 + (abs(tmpvar_12) * -0.0310296)))))))));
  float tmpvar_14;
  tmpvar_14 = sin(tmpvar_13);
  float tmpvar_15;
  tmpvar_15 = cos(tmpvar_13);
  float tmpvar_16;
  tmpvar_16 = cos(xlv_TEXCOORD2);
  float tmpvar_17;
  tmpvar_17 = sin(xlv_TEXCOORD2);
  float y_18;
  y_18 = (tmpvar_10 * tmpvar_14);
  float x_19;
  x_19 = (((tmpvar_12 * tmpvar_16) * tmpvar_15) - ((tmpvar_11 * tmpvar_17) * tmpvar_14));
  float r_20;
  if ((abs(x_19) > (1e-08 * abs(y_18)))) {
    float y_over_x_21;
    y_over_x_21 = (y_18 / x_19);
    float s_22;
    float x_23;
    x_23 = (y_over_x_21 * inversesqrt(((y_over_x_21 * y_over_x_21) + 1.0)));
    s_22 = (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))));
    r_20 = s_22;
    if ((x_19 < 0.0)) {
      if ((y_18 >= 0.0)) {
        r_20 = (s_22 + 3.14159);
      } else {
        r_20 = (r_20 - 3.14159);
      };
    };
  } else {
    r_20 = (sign(y_18) * 1.5708);
  };
  uv_7.x = ((0.31831 * (xlv_TEXCOORD3 + r_20)) + 0.5);
  float x_24;
  x_24 = ((tmpvar_15 * tmpvar_17) + (((tmpvar_11 * tmpvar_14) * tmpvar_16) / tmpvar_12));
  uv_7.y = ((0.31831 * (sign(x_24) * (1.5708 - (sqrt((1.0 - abs(x_24))) * (1.5708 + (abs(x_24) * (-0.214602 + (abs(x_24) * (0.0865667 + (abs(x_24) * -0.0310296)))))))))) + 0.5);
  detailuv_3.x = (uv_7.x + _MainOffset.w);
  detailuv_3.y = (uv_7.y * 2.0);
  detailuv_3.y = (detailuv_3.y - 1.0);
  uv_7.x = (uv_7.x + 1.0);
  uv_7.x = (uv_7.x * 0.5);
  uv_7.x = (uv_7.x + _MainOffset.w);
  objNrm_1.y = sin((1.5708 * detailuv_3.y));
  objNrm_1.z = (cos((1.5708 * detailuv_3.y)) * cos((3.14159 * detailuv_3.x)));
  objNrm_1.x = (cos((1.5708 * detailuv_3.y)) * sin((3.14159 * detailuv_3.x)));
  vec4 tmpvar_25;
  tmpvar_25 = texture2D (_DetailTex, ((((0.5 * objNrm_1.zy) / abs(objNrm_1.x)) + _DetailOffset.xy) * _DetailScale));
  vec4 tmpvar_26;
  tmpvar_26 = texture2D (_DetailTex, ((((0.5 * objNrm_1.zy) / abs(objNrm_1.y)) + _DetailOffset.xy) * _DetailScale));
  vec4 tmpvar_27;
  tmpvar_27 = texture2D (_DetailTex, ((((0.5 * objNrm_1.xy) / abs(objNrm_1.z)) + _DetailOffset.xy) * _DetailScale));
  vec3 tmpvar_28;
  tmpvar_28 = abs(objNrm_1);
  objNrm_1 = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = clamp (floor(((1.0 + tmpvar_28.x) - tmpvar_28.z)), 0.0, 1.0);
  vec3 p_30;
  p_30 = (xlv_TEXCOORD4 - _WorldSpaceCameraPos);
  vec4 tmpvar_31;
  tmpvar_31 = (texture2DGradARB (_MainTex, uv_7, dx_6, dy_5) * mix (mix (mix (tmpvar_27, tmpvar_25, vec4(tmpvar_29)), tmpvar_26, vec4(clamp (floor(((1.0 + tmpvar_28.y) - mix (tmpvar_28.z, tmpvar_28.x, tmpvar_29))), 0.0, 1.0))), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * sqrt(dot (p_30, p_30))), 0.0, 1.0))));
  color_2.xyz = tmpvar_31.xyz;
  color_2.w = (1.2 * (1.2 - tmpvar_31.w));
  vec4 tmpvar_32;
  tmpvar_32 = clamp (color_2, 0.0, 1.0);
  color_2 = tmpvar_32;
  gl_FragData[0] = vec4(mix (1.0, tmpvar_32.w, (dirCheck_8 * radCheck_4)));
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 12 [_MainOffset]
Matrix 8 [_Projector]
"vs_3_0
; 62 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c13, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c14, -0.21211439, 1.57072902, 1.57079601, 2.00000000
def c15, -0.01348047, 0.05747731, -0.12123910, 0.19563590
def c16, -0.33299461, 0.99999559, 3.14159298, 0
dcl_position0 v0
dcl_normal0 v1
abs r0.w, c12.x
abs r0.z, c12
max r0.x, r0.z, r0.w
rcp r0.y, r0.x
min r0.x, r0.z, r0.w
mul r0.y, r0.x, r0
mul r0.x, r0.y, r0.y
slt r0.z, r0, r0.w
mad r1.x, r0, c15, c15.y
mad r1.x, r1, r0, c15.z
mad r0.w, r1.x, r0.x, c15
mad r0.w, r0, r0.x, c16.x
mad r0.x, r0.w, r0, c16.y
max r0.z, -r0, r0
slt r0.z, c13.x, r0
mul r0.x, r0, r0.y
add r0.w, -r0.z, c13.y
mul r0.y, r0.x, r0.w
add r0.x, -r0, c14.z
mad r0.x, r0.z, r0, r0.y
mov r0.z, c13.x
slt r0.w, c12.z, r0.z
add r0.y, -r0.x, c16.z
max r1.x, -r0.w, r0.w
mov r0.z, c13.x
slt r0.w, c12.x, r0.z
slt r0.z, c13.x, r1.x
add r1.x, -r0.z, c13.y
mul r0.x, r0, r1
max r0.w, -r0, r0
slt r0.w, c13.x, r0
mad r0.x, r0.z, r0.y, r0
add r1.x, -r0.w, c13.y
mul r0.y, r0.x, r1.x
mad o4.x, r0.w, -r0, r0.y
abs r0.w, c12.y
mad r1.x, r0.w, c13.z, c13.w
mad r1.y, r0.w, r1.x, c14.x
add r1.x, -r0.w, c13.y
mad r1.y, r0.w, r1, c14
dp3 r0.x, c10, c10
rsq r0.x, r0.x
mul r0.xyz, r0.x, c10
rsq r1.x, r1.x
mov r0.w, c13.x
rcp r1.x, r1.x
mad r1.x, -r1, r1.y, c14.z
slt r0.w, c12.y, r0
mul r0.w, r0, r1.x
dp3_sat o2.x, -v1, r0
mad o3.x, -r0.w, c14.w, r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.w, v0, c11
dp4 o1.z, v0, c10
dp4 o1.y, v0, c9
dp4 o1.x, v0, c8
dp4 o5.z, v0, c6
dp4 o5.y, v0, c5
dp4 o5.x, v0, c4
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
ConstBuffer "$Globals" 112 // 112 used size, 5 vars
Vector 0 [_MainOffset] 4
Matrix 48 [_Projector] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerDraw" 1
// 53 instructions, 2 temp regs, 0 temp arrays:
// ALU 44 float, 0 int, 4 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddleongflfpcojokhglmoajjpnfaciljbabaaaaaammaiaaaaadaaaaaa
cmaaaaaahmaaaaaadeabaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafaepfdejfeejepeoaaeoepfcenebemaaepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaabaoaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaacanaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
aealaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjaahaaaaeaaaabaa
oeabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadbccabaaa
acaaaaaagfaaaaadcccabaaaacaaaaaagfaaaaadeccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
aaaaaaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaafaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
abaaaaaaegiocaaaaaaaaaaaagaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
deaaaaalbcaabaaaaaaaaaaackiacaiaibaaaaaaaaaaaaaaaaaaaaaaakiacaia
ibaaaaaaaaaaaaaaaaaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaalccaabaaaaaaaaaaa
ckiacaiaibaaaaaaaaaaaaaaaaaaaaaaakiacaiaibaaaaaaaaaaaaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdido
dcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpdbaaaaalicaabaaaaaaaaaaackiacaiaibaaaaaaaaaaaaaa
aaaaaaaaakiacaiaibaaaaaaaaaaaaaaaaaaaaaaabaaaaahecaabaaaaaaaaaaa
dkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaakgcaabaaaaaaaaaaa
fgigcaaaaaaaaaaaaaaaaaaafgigcaiaebaaaaaaaaaaaaaaaaaaaaaaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaajecaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaaaaaaaaakiacaaaaaaaaaaaaaaaaaaadbaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadeaaaaajicaabaaa
aaaaaaaackiacaaaaaaaaaaaaaaaaaaaakiacaaaaaaaaaaaaaaaaaaabnaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaah
ecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadhaaaaakeccabaaa
acaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaagbcaabaaaabaaaaaackiacaaaaaaaaaaaadaaaaaadgaaaaagccaabaaa
abaaaaaackiacaaaaaaaaaaaaeaaaaaadgaaaaagecaabaaaabaaaaaackiacaaa
aaaaaaaaafaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahncaabaaa
aaaaaaaaagaabaaaaaaaaaaaagajbaaaabaaaaaabacaaaaibccabaaaacaaaaaa
egbcbaiaebaaaaaaabaaaaaaigadbaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaa
bkiacaiaibaaaaaaaaaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaiaibaaaaaaaaaaaaaa
aaaaaaaaabeaaaaaiedefjlodcaaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaiaibaaaaaaaaaaaaaaaaaaaaaaabeaaaaakeanmjdpaaaaaaajecaabaaa
aaaaaaaabkiacaiambaaaaaaaaaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaicccabaaaacaaaaaaakaabaia
ebaaaaaaaaaaaaaaabeaaaaanlapmjdpdiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Projector;
uniform highp vec4 _MainOffset;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  mediump float tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_2 = (_Projector * _glesVertex);
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_6;
  tmpvar_6.x = _Projector[0].z;
  tmpvar_6.y = _Projector[1].z;
  tmpvar_6.z = _Projector[2].z;
  tmpvar_3 = clamp (dot (-(normalize(_glesNormal)), normalize(tmpvar_6)), 0.0, 1.0);
  highp float tmpvar_7;
  tmpvar_7 = (sign(_MainOffset.y) * (1.5708 - (sqrt((1.0 - abs(_MainOffset.y))) * (1.5708 + (abs(_MainOffset.y) * (-0.214602 + (abs(_MainOffset.y) * (0.0865667 + (abs(_MainOffset.y) * -0.0310296)))))))));
  tmpvar_4 = tmpvar_7;
  highp float r_8;
  if ((abs(_MainOffset.z) > (1e-08 * abs(_MainOffset.x)))) {
    highp float y_over_x_9;
    y_over_x_9 = (_MainOffset.x / _MainOffset.z);
    highp float s_10;
    highp float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((_MainOffset.z < 0.0)) {
      if ((_MainOffset.x >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(_MainOffset.x) * 1.5708);
  };
  tmpvar_5 = r_8;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform sampler2D _DetailTex;
uniform highp vec4 _MainOffset;
uniform sampler2D _MainTex;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float detailLevel_2;
  mediump vec4 detailZ_3;
  mediump vec4 detailY_4;
  mediump vec4 detailX_5;
  mediump vec3 objNrm_6;
  lowp vec4 color_7;
  mediump vec2 detailuv_8;
  mediump float c_9;
  mediump float radCheck_10;
  highp float p_11;
  mediump vec2 dy_12;
  mediump vec2 dx_13;
  mediump vec2 uv_14;
  mediump float dirCheck_15;
  highp float tmpvar_16;
  tmpvar_16 = (clamp (floor((xlv_TEXCOORD0.w + 1.0)), 0.0, 1.0) * xlv_TEXCOORD1);
  dirCheck_15 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  uv_14 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD0.xy);
  dx_13 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD0.xy);
  dy_12 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = (-((2.0 * uv_14.x)) + 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = ((2.0 * uv_14.y) - 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = sqrt((pow (tmpvar_20, 2.0) + pow (tmpvar_21, 2.0)));
  p_11 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp (floor((2.0 - p_11)), 0.0, 1.0);
  radCheck_10 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = (sign(p_11) * (1.5708 - (sqrt((1.0 - abs(p_11))) * (1.5708 + (abs(p_11) * (-0.214602 + (abs(p_11) * (0.0865667 + (abs(p_11) * -0.0310296)))))))));
  c_9 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = sin(c_9);
  mediump float tmpvar_26;
  tmpvar_26 = cos(c_9);
  mediump float tmpvar_27;
  tmpvar_27 = cos(xlv_TEXCOORD2);
  mediump float tmpvar_28;
  tmpvar_28 = sin(xlv_TEXCOORD2);
  highp float tmpvar_29;
  mediump float y_30;
  y_30 = (tmpvar_20 * tmpvar_25);
  highp float x_31;
  x_31 = (((p_11 * tmpvar_27) * tmpvar_26) - ((tmpvar_21 * tmpvar_28) * tmpvar_25));
  mediump float r_32;
  if ((abs(x_31) > (1e-08 * abs(y_30)))) {
    highp float y_over_x_33;
    y_over_x_33 = (y_30 / x_31);
    highp float x_34;
    x_34 = (y_over_x_33 * inversesqrt(((y_over_x_33 * y_over_x_33) + 1.0)));
    r_32 = (sign(x_34) * (1.5708 - (sqrt((1.0 - abs(x_34))) * (1.5708 + (abs(x_34) * (-0.214602 + (abs(x_34) * (0.0865667 + (abs(x_34) * -0.0310296)))))))));
    if ((x_31 < 0.0)) {
      if ((y_30 >= 0.0)) {
        r_32 = (r_32 + 3.14159);
      } else {
        r_32 = (r_32 - 3.14159);
      };
    };
  } else {
    r_32 = (sign(y_30) * 1.5708);
  };
  tmpvar_29 = r_32;
  highp float tmpvar_35;
  tmpvar_35 = ((0.31831 * (xlv_TEXCOORD3 + tmpvar_29)) + 0.5);
  uv_14.x = tmpvar_35;
  highp float x_36;
  x_36 = ((tmpvar_26 * tmpvar_28) + (((tmpvar_21 * tmpvar_25) * tmpvar_27) / p_11));
  highp float tmpvar_37;
  tmpvar_37 = ((0.31831 * (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))))) + 0.5);
  uv_14.y = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (uv_14.x + _MainOffset.w);
  detailuv_8.x = tmpvar_38;
  detailuv_8.y = (uv_14.y * 2.0);
  detailuv_8.y = (detailuv_8.y - 1.0);
  uv_14.x = (uv_14.x + 1.0);
  uv_14.x = (uv_14.x * 0.5);
  highp float tmpvar_39;
  tmpvar_39 = (uv_14.x + _MainOffset.w);
  uv_14.x = tmpvar_39;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DGradEXT (_MainTex, uv_14, dx_13, dy_12);
  objNrm_6.y = sin((1.5708 * detailuv_8.y));
  objNrm_6.z = (cos((1.5708 * detailuv_8.y)) * cos((3.14159 * detailuv_8.x)));
  objNrm_6.x = (cos((1.5708 * detailuv_8.y)) * sin((3.14159 * detailuv_8.x)));
  mediump float tmpvar_41;
  tmpvar_41 = abs(objNrm_6.x);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = ((((0.5 * objNrm_6.zy) / tmpvar_41) + _DetailOffset.xy) * _DetailScale);
  tmpvar_42 = texture2D (_DetailTex, P_43);
  detailX_5 = tmpvar_42;
  mediump float tmpvar_44;
  tmpvar_44 = abs(objNrm_6.y);
  lowp vec4 tmpvar_45;
  highp vec2 P_46;
  P_46 = ((((0.5 * objNrm_6.zy) / tmpvar_44) + _DetailOffset.xy) * _DetailScale);
  tmpvar_45 = texture2D (_DetailTex, P_46);
  detailY_4 = tmpvar_45;
  mediump float tmpvar_47;
  tmpvar_47 = abs(objNrm_6.z);
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = ((((0.5 * objNrm_6.xy) / tmpvar_47) + _DetailOffset.xy) * _DetailScale);
  tmpvar_48 = texture2D (_DetailTex, P_49);
  detailZ_3 = tmpvar_48;
  mediump vec3 tmpvar_50;
  tmpvar_50 = abs(objNrm_6);
  objNrm_6 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (floor(((1.0 + tmpvar_50.x) - tmpvar_50.z)), 0.0, 1.0);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD4 - _WorldSpaceCameraPos);
  highp float tmpvar_53;
  tmpvar_53 = clamp (((2.0 * _DetailDist) * sqrt(dot (p_52, p_52))), 0.0, 1.0);
  detailLevel_2 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54 = (tmpvar_40 * mix (mix (mix (detailZ_3, detailX_5, vec4(tmpvar_51)), detailY_4, vec4(clamp (floor(((1.0 + tmpvar_50.y) - mix (tmpvar_50.z, tmpvar_50.x, tmpvar_51))), 0.0, 1.0))), vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_2)));
  color_7 = tmpvar_54;
  color_7.w = (1.2 * (1.2 - color_7.w));
  lowp vec4 tmpvar_55;
  tmpvar_55 = clamp (color_7, 0.0, 1.0);
  color_7 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56 = vec4(mix (1.0, tmpvar_55.w, (dirCheck_15 * radCheck_10)));
  tmpvar_1 = tmpvar_56;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Projector;
uniform highp vec4 _MainOffset;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  mediump float tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_2 = (_Projector * _glesVertex);
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_6;
  tmpvar_6.x = _Projector[0].z;
  tmpvar_6.y = _Projector[1].z;
  tmpvar_6.z = _Projector[2].z;
  tmpvar_3 = clamp (dot (-(normalize(_glesNormal)), normalize(tmpvar_6)), 0.0, 1.0);
  highp float tmpvar_7;
  tmpvar_7 = (sign(_MainOffset.y) * (1.5708 - (sqrt((1.0 - abs(_MainOffset.y))) * (1.5708 + (abs(_MainOffset.y) * (-0.214602 + (abs(_MainOffset.y) * (0.0865667 + (abs(_MainOffset.y) * -0.0310296)))))))));
  tmpvar_4 = tmpvar_7;
  highp float r_8;
  if ((abs(_MainOffset.z) > (1e-08 * abs(_MainOffset.x)))) {
    highp float y_over_x_9;
    y_over_x_9 = (_MainOffset.x / _MainOffset.z);
    highp float s_10;
    highp float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((_MainOffset.z < 0.0)) {
      if ((_MainOffset.x >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(_MainOffset.x) * 1.5708);
  };
  tmpvar_5 = r_8;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD4;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform sampler2D _DetailTex;
uniform highp vec4 _MainOffset;
uniform sampler2D _MainTex;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float detailLevel_2;
  mediump vec4 detailZ_3;
  mediump vec4 detailY_4;
  mediump vec4 detailX_5;
  mediump vec3 objNrm_6;
  lowp vec4 color_7;
  mediump vec2 detailuv_8;
  mediump float c_9;
  mediump float radCheck_10;
  highp float p_11;
  mediump vec2 dy_12;
  mediump vec2 dx_13;
  mediump vec2 uv_14;
  mediump float dirCheck_15;
  highp float tmpvar_16;
  tmpvar_16 = (clamp (floor((xlv_TEXCOORD0.w + 1.0)), 0.0, 1.0) * xlv_TEXCOORD1);
  dirCheck_15 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  uv_14 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD0.xy);
  dx_13 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD0.xy);
  dy_12 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = (-((2.0 * uv_14.x)) + 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = ((2.0 * uv_14.y) - 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = sqrt((pow (tmpvar_20, 2.0) + pow (tmpvar_21, 2.0)));
  p_11 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp (floor((2.0 - p_11)), 0.0, 1.0);
  radCheck_10 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = (sign(p_11) * (1.5708 - (sqrt((1.0 - abs(p_11))) * (1.5708 + (abs(p_11) * (-0.214602 + (abs(p_11) * (0.0865667 + (abs(p_11) * -0.0310296)))))))));
  c_9 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = sin(c_9);
  mediump float tmpvar_26;
  tmpvar_26 = cos(c_9);
  mediump float tmpvar_27;
  tmpvar_27 = cos(xlv_TEXCOORD2);
  mediump float tmpvar_28;
  tmpvar_28 = sin(xlv_TEXCOORD2);
  highp float tmpvar_29;
  mediump float y_30;
  y_30 = (tmpvar_20 * tmpvar_25);
  highp float x_31;
  x_31 = (((p_11 * tmpvar_27) * tmpvar_26) - ((tmpvar_21 * tmpvar_28) * tmpvar_25));
  mediump float r_32;
  if ((abs(x_31) > (1e-08 * abs(y_30)))) {
    highp float y_over_x_33;
    y_over_x_33 = (y_30 / x_31);
    highp float x_34;
    x_34 = (y_over_x_33 * inversesqrt(((y_over_x_33 * y_over_x_33) + 1.0)));
    r_32 = (sign(x_34) * (1.5708 - (sqrt((1.0 - abs(x_34))) * (1.5708 + (abs(x_34) * (-0.214602 + (abs(x_34) * (0.0865667 + (abs(x_34) * -0.0310296)))))))));
    if ((x_31 < 0.0)) {
      if ((y_30 >= 0.0)) {
        r_32 = (r_32 + 3.14159);
      } else {
        r_32 = (r_32 - 3.14159);
      };
    };
  } else {
    r_32 = (sign(y_30) * 1.5708);
  };
  tmpvar_29 = r_32;
  highp float tmpvar_35;
  tmpvar_35 = ((0.31831 * (xlv_TEXCOORD3 + tmpvar_29)) + 0.5);
  uv_14.x = tmpvar_35;
  highp float x_36;
  x_36 = ((tmpvar_26 * tmpvar_28) + (((tmpvar_21 * tmpvar_25) * tmpvar_27) / p_11));
  highp float tmpvar_37;
  tmpvar_37 = ((0.31831 * (sign(x_36) * (1.5708 - (sqrt((1.0 - abs(x_36))) * (1.5708 + (abs(x_36) * (-0.214602 + (abs(x_36) * (0.0865667 + (abs(x_36) * -0.0310296)))))))))) + 0.5);
  uv_14.y = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (uv_14.x + _MainOffset.w);
  detailuv_8.x = tmpvar_38;
  detailuv_8.y = (uv_14.y * 2.0);
  detailuv_8.y = (detailuv_8.y - 1.0);
  uv_14.x = (uv_14.x + 1.0);
  uv_14.x = (uv_14.x * 0.5);
  highp float tmpvar_39;
  tmpvar_39 = (uv_14.x + _MainOffset.w);
  uv_14.x = tmpvar_39;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DGradEXT (_MainTex, uv_14, dx_13, dy_12);
  objNrm_6.y = sin((1.5708 * detailuv_8.y));
  objNrm_6.z = (cos((1.5708 * detailuv_8.y)) * cos((3.14159 * detailuv_8.x)));
  objNrm_6.x = (cos((1.5708 * detailuv_8.y)) * sin((3.14159 * detailuv_8.x)));
  mediump float tmpvar_41;
  tmpvar_41 = abs(objNrm_6.x);
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = ((((0.5 * objNrm_6.zy) / tmpvar_41) + _DetailOffset.xy) * _DetailScale);
  tmpvar_42 = texture2D (_DetailTex, P_43);
  detailX_5 = tmpvar_42;
  mediump float tmpvar_44;
  tmpvar_44 = abs(objNrm_6.y);
  lowp vec4 tmpvar_45;
  highp vec2 P_46;
  P_46 = ((((0.5 * objNrm_6.zy) / tmpvar_44) + _DetailOffset.xy) * _DetailScale);
  tmpvar_45 = texture2D (_DetailTex, P_46);
  detailY_4 = tmpvar_45;
  mediump float tmpvar_47;
  tmpvar_47 = abs(objNrm_6.z);
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = ((((0.5 * objNrm_6.xy) / tmpvar_47) + _DetailOffset.xy) * _DetailScale);
  tmpvar_48 = texture2D (_DetailTex, P_49);
  detailZ_3 = tmpvar_48;
  mediump vec3 tmpvar_50;
  tmpvar_50 = abs(objNrm_6);
  objNrm_6 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (floor(((1.0 + tmpvar_50.x) - tmpvar_50.z)), 0.0, 1.0);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD4 - _WorldSpaceCameraPos);
  highp float tmpvar_53;
  tmpvar_53 = clamp (((2.0 * _DetailDist) * sqrt(dot (p_52, p_52))), 0.0, 1.0);
  detailLevel_2 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54 = (tmpvar_40 * mix (mix (mix (detailZ_3, detailX_5, vec4(tmpvar_51)), detailY_4, vec4(clamp (floor(((1.0 + tmpvar_50.y) - mix (tmpvar_50.z, tmpvar_50.x, tmpvar_51))), 0.0, 1.0))), vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_2)));
  color_7 = tmpvar_54;
  color_7.w = (1.2 * (1.2 - color_7.w));
  lowp vec4 tmpvar_55;
  tmpvar_55 = clamp (color_7, 0.0, 1.0);
  color_7 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56 = vec4(mix (1.0, tmpvar_55.w, (dirCheck_15 * radCheck_10)));
  tmpvar_1 = tmpvar_56;
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
#line 64
struct v2f {
    highp vec4 pos;
    highp vec4 posProj;
    highp float dotcoeff;
    mediump float latitude;
    mediump float longitude;
    highp vec3 worldPos;
};
#line 58
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainOffset;
uniform sampler2D _DetailTex;
uniform lowp vec4 _DetailOffset;
#line 55
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp mat4 _Projector;
#line 74
#line 87
#line 74
v2f vert( in appdata_t v ) {
    v2f o;
    o.posProj = (_Projector * v.vertex);
    #line 78
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 normView = normalize(vec3( _Projector[0][2], _Projector[1][2], _Projector[2][2]));
    o.dotcoeff = xll_saturate_f(dot( (-v.normal), normView));
    o.latitude = asin(_MainOffset.y);
    #line 82
    o.longitude = atan( _MainOffset.x, _MainOffset.z);
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    o.worldPos = vertexPos;
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out mediump float xlv_TEXCOORD2;
out mediump float xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.posProj);
    xlv_TEXCOORD1 = float(xl_retval.dotcoeff);
    xlv_TEXCOORD2 = float(xl_retval.latitude);
    xlv_TEXCOORD3 = float(xl_retval.longitude);
    xlv_TEXCOORD4 = vec3(xl_retval.worldPos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dgrad(sampler2D s, vec2 coord, vec2 ddx, vec2 ddy) {
   return textureGrad( s, coord, ddx, ddy);
}
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
#line 64
struct v2f {
    highp vec4 pos;
    highp vec4 posProj;
    highp float dotcoeff;
    mediump float latitude;
    mediump float longitude;
    highp vec3 worldPos;
};
#line 58
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainOffset;
uniform sampler2D _DetailTex;
uniform lowp vec4 _DetailOffset;
#line 55
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp mat4 _Projector;
#line 74
#line 87
#line 87
lowp vec4 frag( in v2f IN ) {
    mediump float dirCheck = (xll_saturate_f(floor((IN.posProj.w + 1.0))) * IN.dotcoeff);
    mediump vec2 uv = (IN.posProj.xy / IN.posProj.w);
    #line 91
    mediump vec2 dx = xll_dFdx_vf2(IN.posProj.xy);
    mediump vec2 dy = xll_dFdy_vf2(IN.posProj.xy);
    mediump float x = ((-(2.0 * uv.x)) + 1.0);
    mediump float y = ((2.0 * uv.y) - 1.0);
    #line 95
    highp float p = sqrt((pow( x, 2.0) + pow( y, 2.0)));
    mediump float radCheck = xll_saturate_f(floor((2.0 - p)));
    mediump float c = asin(p);
    mediump float sinC = sin(c);
    #line 99
    mediump float cosC = cos(c);
    mediump float cosLat = cos(IN.latitude);
    mediump float sinLat = sin(IN.latitude);
    uv.x = ((0.31831 * (IN.longitude + atan( (x * sinC), (((p * cosLat) * cosC) - ((y * sinLat) * sinC))))) + 0.5);
    #line 103
    uv.y = ((0.31831 * asin(((cosC * sinLat) + (((y * sinC) * cosLat) / p)))) + 0.5);
    mediump vec2 detailuv = uv;
    detailuv.x += _MainOffset.w;
    detailuv.y *= 2.0;
    #line 107
    detailuv.y -= 1.0;
    uv.x += 1.0;
    uv.x *= 0.5;
    uv.x += _MainOffset.w;
    #line 111
    lowp vec4 color = xll_tex2Dgrad( _MainTex, uv, dx, dy);
    mediump vec3 objNrm;
    objNrm.y = sin((1.5708 * detailuv.y));
    highp float ymag = (1.0 - (objNrm.y * objNrm.y));
    #line 115
    objNrm.z = (cos((1.5708 * detailuv.y)) * cos((3.14159 * detailuv.x)));
    objNrm.x = (cos((1.5708 * detailuv.y)) * sin((3.14159 * detailuv.x)));
    mediump vec4 detailX = texture( _DetailTex, ((((0.5 * objNrm.zy) / abs(objNrm.x)) + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((((0.5 * objNrm.zy) / abs(objNrm.y)) + _DetailOffset.xy) * _DetailScale));
    #line 119
    mediump vec4 detailZ = texture( _DetailTex, ((((0.5 * objNrm.xy) / abs(objNrm.z)) + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    mediump float zxlerp = xll_saturate_f(floor(((1.0 + objNrm.x) - objNrm.z)));
    mediump vec4 detail = mix( detailZ, detailX, vec4( zxlerp));
    #line 123
    mediump float nylerp = xll_saturate_f(floor(((1.0 + objNrm.y) - mix( objNrm.z, objNrm.x, zxlerp))));
    detail = mix( detail, detailY, vec4( nylerp));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * distance( IN.worldPos, _WorldSpaceCameraPos)));
    color *= mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    #line 127
    color.w = (1.2 * (1.2 - color.w));
    color = xll_saturate_vf4(color);
    return vec4( mix( 1.0, color.w, (dirCheck * radCheck)));
}
in highp vec4 xlv_TEXCOORD0;
in highp float xlv_TEXCOORD1;
in mediump float xlv_TEXCOORD2;
in mediump float xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.posProj = vec4(xlv_TEXCOORD0);
    xlt_IN.dotcoeff = float(xlv_TEXCOORD1);
    xlt_IN.latitude = float(xlv_TEXCOORD2);
    xlt_IN.longitude = float(xlv_TEXCOORD3);
    xlt_IN.worldPos = vec3(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   d3d9 - ALU: 169 to 169, TEX: 6 to 6
//   d3d11 - ALU: 100 to 100, TEX: 3 to 3, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_MainOffset]
Vector 2 [_DetailOffset]
Float 3 [_DetailScale]
Float 4 [_DetailDist]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 169 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c5, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c6, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c7, 1.57079601, 0.15917969, 0.50000000, -0.12121582
def c8, 6.28125000, -3.14062500, -0.01348114, 0.05746460
def c9, 0.19567871, -0.33300781, 1.57031250, 3.14062500
def c10, 0.31835938, 0.50000000, 0.31830987, 0.24996185
def c11, 0.49992371, 0.50000000, 1.20019531, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.x
dcl_texcoord2 v2.x
dcl_texcoord3 v3.x
dcl_texcoord4 v4.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
mad_pp r2.y, r0, c5, c5.z
mad_pp r2.w, -r0.x, c5.y, c5.x
mul_pp r0.y, r2, r2
mad_pp r0.x, r2.w, r2.w, r0.y
rsq_pp r2.z, r0.x
rcp_pp r2.x, r2.z
abs r0.x, r2
mad r0.z, r0.x, c6.x, c6.y
add r0.y, -r0.x, c5.x
mad r0.z, r0.x, r0, c6
mad r0.z, r0.x, r0, c6.w
rsq r0.y, r0.y
rcp r0.x, r0.y
mad r0.y, -r0.x, r0.z, c7.x
cmp r0.x, r2, c5.w, c5.y
mad r0.x, -r0, r0.y, r0.y
mad_pp r0.z, v2.x, c7.y, c7
frc_pp r0.y, r0.z
mad_pp r0.x, r0, c7.y, c7.z
mad_pp r1.y, r0, c8.x, c8
frc_pp r1.x, r0
sincos_pp r0.xy, r1.y
mad_pp r0.z, r1.x, c8.x, c8.y
sincos_pp r1.xy, r0.z
mul_pp r0.z, r2.y, r0.y
mul_pp r0.w, r1.y, r0.z
mul r0.z, r2.x, r0.x
mad r0.z, r1.x, r0, -r0.w
mul_pp r0.w, r2, r1.y
mul_pp r1.y, r2, r1
abs_pp r1.w, r0
abs_pp r1.z, r0
max_pp r2.w, r1, r1.z
rcp_pp r3.x, r2.w
min_pp r2.w, r1, r1.z
mul_pp r2.w, r2, r3.x
mul_pp r3.x, r2.w, r2.w
mad_pp r3.y, r3.x, c8.z, c8.w
mad_pp r3.y, r3, r3.x, c7.w
mad_pp r3.y, r3, r3.x, c9.x
mad_pp r3.y, r3, r3.x, c9
mad_pp r3.x, r3.y, r3, c5
mul_pp r2.w, r3.x, r2
mul_pp r0.x, r0, r1.y
mul_pp r0.y, r1.x, r0
mad r0.y, r2.z, r0.x, r0
add_pp r3.x, -r2.w, c9.z
add_pp r1.z, r1.w, -r1
cmp_pp r1.z, -r1, r2.w, r3.x
add_pp r1.w, -r1.z, c9
cmp_pp r0.z, r0, r1, r1.w
cmp_pp r0.x, r0.w, r0.z, -r0.z
abs r0.z, r0.y
add_pp r0.x, v3, r0
mad r1.x, r0.z, c6, c6.y
add r0.w, -r0.z, c5.x
mad r1.x, r0.z, r1, c6.z
mad r1.x, r0.z, r1, c6.w
rsq r0.w, r0.w
rcp r0.z, r0.w
mad r0.z, -r0, r1.x, c7.x
cmp r0.y, r0, c5.w, c5
mad r0.y, -r0, r0.z, r0.z
mad_pp r2.y, r0.x, c10.x, c10
mad r2.z, r0.y, c10, c10.y
add_pp r0.y, r2, c1.w
mad_pp r0.x, r2.z, c5.y, c5.z
mad_pp r0.y, r0, c11.x, c11
mad_pp r0.x, r0, c10.w, c10.y
frc_pp r0.x, r0
frc_pp r0.y, r0
mad_pp r0.y, r0, c8.x, c8
sincos_pp r1.xy, r0.y
mad_pp r2.w, r0.x, c8.x, c8.y
sincos_pp r0.xy, r2.w
mul_pp r0.z, r0.x, r1.x
mov_pp r3.y, r0
mul_pp r3.x, r0, r1.y
mov_pp r3.z, r0
abs_pp r1.xyz, r3
add_pp r0.w, r1.x, -r1.z
add_pp r0.x, r0.w, c5
frc_pp r1.x, r0
add_pp_sat r0.x, r0, -r1
mad_pp r0.w, r0.x, r0, r1.z
add_pp r0.w, r1.y, -r0
abs_pp r1.x, r0.z
add_pp r0.w, r0, c5.x
frc_pp r0.z, r0.w
add_pp_sat r2.w, r0, -r0.z
rcp_pp r1.x, r1.x
mul_pp r1.xy, r3, r1.x
mov_pp r0.zw, c2.xyxy
mad_pp r1.zw, r1.xyxy, c7.z, r0
abs_pp r3.x, r3
rcp_pp r1.x, r3.x
mul_pp r1.xy, r3.zyzw, r1.x
mov_pp r0.zw, c2.xyxy
mad_pp r0.zw, r1.xyxy, c7.z, r0
mul r1.xy, r1.zwzw, c3.x
mul r4.xy, r0.zwzw, c3.x
texld r0.w, r1, s1
texld r1.w, r4, s1
add_pp r0.z, r1.w, -r0.w
mad_pp r1.z, r0.x, r0, r0.w
abs_pp r0.y, r0
rcp_pp r0.z, r0.y
mul_pp r0.zw, r3.xyzy, r0.z
mov_pp r0.xy, c2
mad_pp r1.xy, r0.zwzw, c7.z, r0
add r0.xyz, -v4, c0
dp3 r0.x, r0, r0
mul r1.xy, r1, c3.x
texld r0.w, r1, s1
add_pp r0.y, r0.w, -r1.z
mad_pp r0.y, r2.w, r0, r1.z
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.x, r0, c4
add_pp r0.z, -r0.y, c5.x
mul_sat r0.x, r0, c5.y
mad_pp r1.z, r0.x, r0, r0.y
mov_pp r0.y, c1.w
add_pp r0.x, r2.y, c5
mad_pp r0.x, r0, c7.z, r0.y
mov_pp r0.y, r2.z
dsy r1.xy, v0
dsx r0.zw, v0.xyxy
texldd r0.w, r0, s0, r0.zwzw, r1
mad_pp r0.x, -r0.w, r1.z, c11.z
mul_pp_sat r0.x, r0, c11.z
add_pp r1.x, r0, c5.z
add r0.x, v0.w, c5
frc r0.y, r0.x
add_sat r0.x, r0, -r0.y
add r0.z, -r2.x, c5.y
frc r0.w, r0.z
add_sat r0.y, r0.z, -r0.w
mul r0.x, r0, v1
mul_pp r0.x, r0, r0.y
mad_pp oC0, r0.x, r1.x, c5.x
"
}

SubProgram "d3d11 " {
Keywords { }
ConstBuffer "$Globals" 112 // 40 used size, 5 vars
Vector 0 [_MainOffset] 4
Vector 16 [_DetailOffset] 4
Float 32 [_DetailScale]
Float 36 [_DetailDist]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 111 instructions, 6 temp regs, 0 temp arrays:
// ALU 96 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedmfjkegochaopibilhehmfcgbnacflnboabaaaaaakiapaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ababaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaacacaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaacaaaaaaaeaeaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefciiaoaaaa
eaaaaaaakcadaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadlcbabaaaabaaaaaagcbaaaadbcbabaaaacaaaaaagcbaaaadccbabaaa
acaaaaaagcbaaaadecbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacagaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
abaaaaaapgbpbaaaabaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadpdcaaaaajccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdiaaaaahecaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaadagojjlmabeaaaaachbgjidndcaaaaajicaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaiedefjlodcaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaakeanmjdpaaaaaaaldcaabaaa
abaaaaaakgakbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaiadpaaaaaaaa
aaaaaaaaelaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaebcaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaabkaabaaaabaaaaaaabeaaaaanlapmjdpenaaaaahbcaabaaaacaaaaaa
bcaabaaaadaaaaaadkaabaaaaaaaaaaaenaaaaahbcaabaaaaeaaaaaabcaabaaa
afaaaaaabkbabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaeaaaaaadiaaaaahlcaabaaaaaaaaaaaegambaaaaaaaaaaaagaabaaa
acaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaafaaaaaabkaabaaaaaaaaaaa
aoaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaafaaaaaadcaaaaajccaabaaa
aaaaaaaaakaabaaaadaaaaaaakaabaaaaeaaaaaabkaabaaaaaaaaaaadcaaaaak
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadkaabaiaebaaaaaa
aaaaaaaadeaaaaajicaabaaaaaaaaaaackaabaiaibaaaaaaaaaaaaaaakaabaia
ibaaaaaaaaaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaaaaaaaaaddaaaaajccaabaaaabaaaaaackaabaia
ibaaaaaaaaaaaaaaakaabaiaibaaaaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaabaaaaaabkaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
abaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaabaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadcaaaaajecaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaabaaaaaackaabaiaibaaaaaaaaaaaaaaakaabaiaibaaaaaaaaaaaaaa
abaaaaahecaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaadcaaaaaj
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaa
dbaaaaaiccaabaaaabaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
abaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaanlapejmaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadbaaaaaiecaabaaaaaaaaaaabkaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackbabaaaacaaaaaadcaaaaapfcaabaaaaaaaaaaaagaabaaa
aaaaaaaaaceaaaaaidpjkcdoaaaaaaaaidpjkcdoaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaamadpaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaaaaaaaadcaaaaakbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaadpdkiacaaaaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaanlapejeaenaaaaahbcaabaaaaaaaaaaabcaabaaa
adaaaaaaakaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaabkaabaiaibaaaaaa
aaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlodcaaaaak
ecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaabeaaaaa
keanmjdpaaaaaaaiicaabaaaaaaaaaaabkaabaiambaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahccaabaaa
abaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaabaaaaaadcaaaaajccaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaajccaabaaa
acaaaaaabkaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadpdcaaaaaj
ccaabaaaaaaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialp
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapmjdpenaaaaah
bcaabaaaaeaaaaaabcaabaaaafaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaafaaaaaadiaaaaahecaabaaaaaaaaaaa
akaabaaaadaaaaaaakaabaaaafaaaaaadgaaaaafccaabaaaaaaaaaaaakaabaaa
aeaaaaaadiaaaaakpcaabaaaadaaaaaaggaebaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaadpaaaaaaalkcaabaaaaaaaaaaaagaebaiaibaaaaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadpaoaaaaaipcaabaaa
afaaaaaaegaobaaaadaaaaaaagakbaiaibaaaaaaaaaaaaaaaaaaaaajbcaabaaa
aaaaaaaackaabaiambaaaaaaaaaaaaaaakaabaiaibaaaaaaaaaaaaaaaoaaaaai
gcaabaaaabaaaaaaagabbaaaadaaaaaaagaabaiaibaaaaaaaeaaaaaaaaaaaaai
gcaabaaaabaaaaaafgagbaaaabaaaaaaagibcaaaaaaaaaaaabaaaaaadiaaaaai
gcaabaaaabaaaaaafgagbaaaabaaaaaaagiacaaaaaaaaaaaacaaaaaaefaaaaaj
pcaabaaaadaaaaaajgafbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaaipcaabaaaaeaaaaaaegaobaaaafaaaaaaegiecaaaaaaaaaaaabaaaaaa
diaaaaaipcaabaaaaeaaaaaaegaobaaaaeaaaaaaagiacaaaaaaaaaaaacaaaaaa
efaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaiccaabaaaabaaaaaadkaabaiaebaaaaaaaeaaaaaa
dkaabaaaafaaaaaaaaaaaaaiccaabaaaaaaaaaaackaabaiambaaaaaaaaaaaaaa
bkaabaaaaaaaaaaaebaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaajccaabaaa
abaaaaaabkaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaaaeaaaaaadcaaaaak
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaiaibaaaaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadkaabaaa
aaaaaaaaebaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiccaabaaaaaaaaaaa
bkaabaiaebaaaaaaabaaaaaadkaabaaaadaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaabaaaaaaaaaaaaaiccaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaajocaabaaa
abaaaaaaagbjbaaaadaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
ecaabaaaaaaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaajicaabaaaaaaaaaaabkiacaaaaaaaaaaa
acaaaaaabkiacaaaaaaaaaaaacaaaaaadicaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaalaaaaafgcaabaaaaaaaaaaaagbbbaaa
abaaaaaaamaaaaafgcaabaaaabaaaaaaagbbbaaaabaaaaaaejaaaaanpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaajgafbaaa
aaaaaaaajgafbaaaabaaaaaadcaaaaakbcaabaaaaaaaaaaadkaabaiaebaaaaaa
acaaaaaaakaabaaaaaaaaaaaabeaaaaajkjjjjdpdicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaajkjjjjdpaaaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaialpaaaaaaahccaabaaaaaaaaaaadkbabaaaabaaaaaa
abeaaaaaaaaaiadpebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakbabaaaacaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaabaaaaaabkaabaaaaaaaaaaadcaaaaampccabaaaaaaaaaaa
fgafbaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdoaaaaab"
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

#LINE 110

      }
   }  
}