Shader "EVE/CloudShadow" {
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
  vec2 tmpvar_25;
  tmpvar_25 = dFdx(objNrm_1.xz);
  vec2 tmpvar_26;
  tmpvar_26 = dFdy(objNrm_1.xz);
  vec4 tmpvar_27;
  tmpvar_27.x = (0.159155 * sqrt(dot (tmpvar_25, tmpvar_25)));
  tmpvar_27.y = dFdx(uv_7.y);
  tmpvar_27.z = (0.159155 * sqrt(dot (tmpvar_26, tmpvar_26)));
  tmpvar_27.w = dFdy(uv_7.y);
  objNrm_1 = abs(objNrm_1);
  vec3 p_28;
  p_28 = (xlv_TEXCOORD4 - _WorldSpaceCameraPos);
  vec4 tmpvar_29;
  tmpvar_29 = (texture2DGradARB (_MainTex, uv_7, dx_6, dy_5) * mix (texture2D (_DetailTex, (tmpvar_27.zw * _DetailScale)), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * sqrt(dot (p_28, p_28))), 0.0, 1.0))));
  color_2.xyz = tmpvar_29.xyz;
  color_2.w = (1.2 * (1.2 - tmpvar_29.w));
  vec4 tmpvar_30;
  tmpvar_30 = clamp (color_2, 0.0, 1.0);
  color_2 = tmpvar_30;
  gl_FragData[0] = vec4(mix (1.0, tmpvar_30.w, (dirCheck_8 * radCheck_4)));
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
uniform sampler2D _DetailTex;
uniform highp vec4 _MainOffset;
uniform sampler2D _MainTex;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float detailLevel_2;
  mediump vec4 detail_3;
  mediump vec3 objNrm_4;
  lowp vec4 color_5;
  mediump vec2 detailuv_6;
  mediump float c_7;
  mediump float radCheck_8;
  highp float p_9;
  mediump vec2 dy_10;
  mediump vec2 dx_11;
  mediump vec2 uv_12;
  mediump float dirCheck_13;
  highp float tmpvar_14;
  tmpvar_14 = (clamp (floor((xlv_TEXCOORD0.w + 1.0)), 0.0, 1.0) * xlv_TEXCOORD1);
  dirCheck_13 = tmpvar_14;
  highp vec2 tmpvar_15;
  tmpvar_15 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  uv_12 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = dFdx(xlv_TEXCOORD0.xy);
  dx_11 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdy(xlv_TEXCOORD0.xy);
  dy_10 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = (-((2.0 * uv_12.x)) + 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = ((2.0 * uv_12.y) - 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = sqrt((pow (tmpvar_18, 2.0) + pow (tmpvar_19, 2.0)));
  p_9 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (floor((2.0 - p_9)), 0.0, 1.0);
  radCheck_8 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = (sign(p_9) * (1.5708 - (sqrt((1.0 - abs(p_9))) * (1.5708 + (abs(p_9) * (-0.214602 + (abs(p_9) * (0.0865667 + (abs(p_9) * -0.0310296)))))))));
  c_7 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = sin(c_7);
  mediump float tmpvar_24;
  tmpvar_24 = cos(c_7);
  mediump float tmpvar_25;
  tmpvar_25 = cos(xlv_TEXCOORD2);
  mediump float tmpvar_26;
  tmpvar_26 = sin(xlv_TEXCOORD2);
  highp float tmpvar_27;
  mediump float y_28;
  y_28 = (tmpvar_18 * tmpvar_23);
  highp float x_29;
  x_29 = (((p_9 * tmpvar_25) * tmpvar_24) - ((tmpvar_19 * tmpvar_26) * tmpvar_23));
  mediump float r_30;
  if ((abs(x_29) > (1e-08 * abs(y_28)))) {
    highp float y_over_x_31;
    y_over_x_31 = (y_28 / x_29);
    highp float x_32;
    x_32 = (y_over_x_31 * inversesqrt(((y_over_x_31 * y_over_x_31) + 1.0)));
    r_30 = (sign(x_32) * (1.5708 - (sqrt((1.0 - abs(x_32))) * (1.5708 + (abs(x_32) * (-0.214602 + (abs(x_32) * (0.0865667 + (abs(x_32) * -0.0310296)))))))));
    if ((x_29 < 0.0)) {
      if ((y_28 >= 0.0)) {
        r_30 = (r_30 + 3.14159);
      } else {
        r_30 = (r_30 - 3.14159);
      };
    };
  } else {
    r_30 = (sign(y_28) * 1.5708);
  };
  tmpvar_27 = r_30;
  highp float tmpvar_33;
  tmpvar_33 = ((0.31831 * (xlv_TEXCOORD3 + tmpvar_27)) + 0.5);
  uv_12.x = tmpvar_33;
  highp float x_34;
  x_34 = ((tmpvar_24 * tmpvar_26) + (((tmpvar_19 * tmpvar_23) * tmpvar_25) / p_9));
  highp float tmpvar_35;
  tmpvar_35 = ((0.31831 * (sign(x_34) * (1.5708 - (sqrt((1.0 - abs(x_34))) * (1.5708 + (abs(x_34) * (-0.214602 + (abs(x_34) * (0.0865667 + (abs(x_34) * -0.0310296)))))))))) + 0.5);
  uv_12.y = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (uv_12.x + _MainOffset.w);
  detailuv_6.x = tmpvar_36;
  detailuv_6.y = (uv_12.y * 2.0);
  detailuv_6.y = (detailuv_6.y - 1.0);
  uv_12.x = (uv_12.x + 1.0);
  uv_12.x = (uv_12.x * 0.5);
  highp float tmpvar_37;
  tmpvar_37 = (uv_12.x + _MainOffset.w);
  uv_12.x = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2DGradEXT (_MainTex, uv_12, dx_11, dy_10);
  objNrm_4.y = sin((1.5708 * detailuv_6.y));
  objNrm_4.z = (cos((1.5708 * detailuv_6.y)) * cos((3.14159 * detailuv_6.x)));
  objNrm_4.x = (cos((1.5708 * detailuv_6.y)) * sin((3.14159 * detailuv_6.x)));
  highp float lon_39;
  lon_39 = uv_12.y;
  highp vec3 pos_40;
  pos_40 = objNrm_4;
  highp vec2 tmpvar_41;
  tmpvar_41 = dFdx(pos_40.xz);
  highp vec2 tmpvar_42;
  tmpvar_42 = dFdy(pos_40.xz);
  highp vec4 tmpvar_43;
  tmpvar_43.x = (0.159155 * sqrt(dot (tmpvar_41, tmpvar_41)));
  tmpvar_43.y = dFdx(lon_39);
  tmpvar_43.z = (0.159155 * sqrt(dot (tmpvar_42, tmpvar_42)));
  tmpvar_43.w = dFdy(lon_39);
  objNrm_4 = abs(objNrm_4);
  lowp vec4 tmpvar_44;
  highp vec2 P_45;
  P_45 = (tmpvar_43.zw * _DetailScale);
  tmpvar_44 = texture2D (_DetailTex, P_45);
  detail_3 = tmpvar_44;
  highp vec3 p_46;
  p_46 = (xlv_TEXCOORD4 - _WorldSpaceCameraPos);
  highp float tmpvar_47;
  tmpvar_47 = clamp (((2.0 * _DetailDist) * sqrt(dot (p_46, p_46))), 0.0, 1.0);
  detailLevel_2 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48 = (tmpvar_38 * mix (detail_3, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_2)));
  color_5 = tmpvar_48;
  color_5.w = (1.2 * (1.2 - color_5.w));
  lowp vec4 tmpvar_49;
  tmpvar_49 = clamp (color_5, 0.0, 1.0);
  color_5 = tmpvar_49;
  mediump vec4 tmpvar_50;
  tmpvar_50 = vec4(mix (1.0, tmpvar_49.w, (dirCheck_13 * radCheck_8)));
  tmpvar_1 = tmpvar_50;
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
uniform sampler2D _DetailTex;
uniform highp vec4 _MainOffset;
uniform sampler2D _MainTex;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float detailLevel_2;
  mediump vec4 detail_3;
  mediump vec3 objNrm_4;
  lowp vec4 color_5;
  mediump vec2 detailuv_6;
  mediump float c_7;
  mediump float radCheck_8;
  highp float p_9;
  mediump vec2 dy_10;
  mediump vec2 dx_11;
  mediump vec2 uv_12;
  mediump float dirCheck_13;
  highp float tmpvar_14;
  tmpvar_14 = (clamp (floor((xlv_TEXCOORD0.w + 1.0)), 0.0, 1.0) * xlv_TEXCOORD1);
  dirCheck_13 = tmpvar_14;
  highp vec2 tmpvar_15;
  tmpvar_15 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  uv_12 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = dFdx(xlv_TEXCOORD0.xy);
  dx_11 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdy(xlv_TEXCOORD0.xy);
  dy_10 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = (-((2.0 * uv_12.x)) + 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = ((2.0 * uv_12.y) - 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = sqrt((pow (tmpvar_18, 2.0) + pow (tmpvar_19, 2.0)));
  p_9 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (floor((2.0 - p_9)), 0.0, 1.0);
  radCheck_8 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = (sign(p_9) * (1.5708 - (sqrt((1.0 - abs(p_9))) * (1.5708 + (abs(p_9) * (-0.214602 + (abs(p_9) * (0.0865667 + (abs(p_9) * -0.0310296)))))))));
  c_7 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = sin(c_7);
  mediump float tmpvar_24;
  tmpvar_24 = cos(c_7);
  mediump float tmpvar_25;
  tmpvar_25 = cos(xlv_TEXCOORD2);
  mediump float tmpvar_26;
  tmpvar_26 = sin(xlv_TEXCOORD2);
  highp float tmpvar_27;
  mediump float y_28;
  y_28 = (tmpvar_18 * tmpvar_23);
  highp float x_29;
  x_29 = (((p_9 * tmpvar_25) * tmpvar_24) - ((tmpvar_19 * tmpvar_26) * tmpvar_23));
  mediump float r_30;
  if ((abs(x_29) > (1e-08 * abs(y_28)))) {
    highp float y_over_x_31;
    y_over_x_31 = (y_28 / x_29);
    highp float x_32;
    x_32 = (y_over_x_31 * inversesqrt(((y_over_x_31 * y_over_x_31) + 1.0)));
    r_30 = (sign(x_32) * (1.5708 - (sqrt((1.0 - abs(x_32))) * (1.5708 + (abs(x_32) * (-0.214602 + (abs(x_32) * (0.0865667 + (abs(x_32) * -0.0310296)))))))));
    if ((x_29 < 0.0)) {
      if ((y_28 >= 0.0)) {
        r_30 = (r_30 + 3.14159);
      } else {
        r_30 = (r_30 - 3.14159);
      };
    };
  } else {
    r_30 = (sign(y_28) * 1.5708);
  };
  tmpvar_27 = r_30;
  highp float tmpvar_33;
  tmpvar_33 = ((0.31831 * (xlv_TEXCOORD3 + tmpvar_27)) + 0.5);
  uv_12.x = tmpvar_33;
  highp float x_34;
  x_34 = ((tmpvar_24 * tmpvar_26) + (((tmpvar_19 * tmpvar_23) * tmpvar_25) / p_9));
  highp float tmpvar_35;
  tmpvar_35 = ((0.31831 * (sign(x_34) * (1.5708 - (sqrt((1.0 - abs(x_34))) * (1.5708 + (abs(x_34) * (-0.214602 + (abs(x_34) * (0.0865667 + (abs(x_34) * -0.0310296)))))))))) + 0.5);
  uv_12.y = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (uv_12.x + _MainOffset.w);
  detailuv_6.x = tmpvar_36;
  detailuv_6.y = (uv_12.y * 2.0);
  detailuv_6.y = (detailuv_6.y - 1.0);
  uv_12.x = (uv_12.x + 1.0);
  uv_12.x = (uv_12.x * 0.5);
  highp float tmpvar_37;
  tmpvar_37 = (uv_12.x + _MainOffset.w);
  uv_12.x = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2DGradEXT (_MainTex, uv_12, dx_11, dy_10);
  objNrm_4.y = sin((1.5708 * detailuv_6.y));
  objNrm_4.z = (cos((1.5708 * detailuv_6.y)) * cos((3.14159 * detailuv_6.x)));
  objNrm_4.x = (cos((1.5708 * detailuv_6.y)) * sin((3.14159 * detailuv_6.x)));
  highp float lon_39;
  lon_39 = uv_12.y;
  highp vec3 pos_40;
  pos_40 = objNrm_4;
  highp vec2 tmpvar_41;
  tmpvar_41 = dFdx(pos_40.xz);
  highp vec2 tmpvar_42;
  tmpvar_42 = dFdy(pos_40.xz);
  highp vec4 tmpvar_43;
  tmpvar_43.x = (0.159155 * sqrt(dot (tmpvar_41, tmpvar_41)));
  tmpvar_43.y = dFdx(lon_39);
  tmpvar_43.z = (0.159155 * sqrt(dot (tmpvar_42, tmpvar_42)));
  tmpvar_43.w = dFdy(lon_39);
  objNrm_4 = abs(objNrm_4);
  lowp vec4 tmpvar_44;
  highp vec2 P_45;
  P_45 = (tmpvar_43.zw * _DetailScale);
  tmpvar_44 = texture2D (_DetailTex, P_45);
  detail_3 = tmpvar_44;
  highp vec3 p_46;
  p_46 = (xlv_TEXCOORD4 - _WorldSpaceCameraPos);
  highp float tmpvar_47;
  tmpvar_47 = clamp (((2.0 * _DetailDist) * sqrt(dot (p_46, p_46))), 0.0, 1.0);
  detailLevel_2 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48 = (tmpvar_38 * mix (detail_3, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_2)));
  color_5 = tmpvar_48;
  color_5.w = (1.2 * (1.2 - color_5.w));
  lowp vec4 tmpvar_49;
  tmpvar_49 = clamp (color_5, 0.0, 1.0);
  color_5 = tmpvar_49;
  mediump vec4 tmpvar_50;
  tmpvar_50 = vec4(mix (1.0, tmpvar_49.w, (dirCheck_13 * radCheck_8)));
  tmpvar_1 = tmpvar_50;
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
#line 96
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
#line 96
#line 87
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    #line 91
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 96
lowp vec4 frag( in v2f IN ) {
    mediump float dirCheck = (xll_saturate_f(floor((IN.posProj.w + 1.0))) * IN.dotcoeff);
    mediump vec2 uv = (IN.posProj.xy / IN.posProj.w);
    #line 100
    mediump vec2 dx = xll_dFdx_vf2(IN.posProj.xy);
    mediump vec2 dy = xll_dFdy_vf2(IN.posProj.xy);
    mediump float x = ((-(2.0 * uv.x)) + 1.0);
    mediump float y = ((2.0 * uv.y) - 1.0);
    #line 104
    highp float p = sqrt((pow( x, 2.0) + pow( y, 2.0)));
    mediump float radCheck = xll_saturate_f(floor((2.0 - p)));
    mediump float c = asin(p);
    mediump float sinC = sin(c);
    #line 108
    mediump float cosC = cos(c);
    mediump float cosLat = cos(IN.latitude);
    mediump float sinLat = sin(IN.latitude);
    uv.x = ((0.31831 * (IN.longitude + atan( (x * sinC), (((p * cosLat) * cosC) - ((y * sinLat) * sinC))))) + 0.5);
    #line 112
    uv.y = ((0.31831 * asin(((cosC * sinLat) + (((y * sinC) * cosLat) / p)))) + 0.5);
    mediump vec2 detailuv = uv;
    detailuv.x += _MainOffset.w;
    detailuv.y *= 2.0;
    #line 116
    detailuv.y -= 1.0;
    uv.x += 1.0;
    uv.x *= 0.5;
    uv.x += _MainOffset.w;
    #line 120
    lowp vec4 color = xll_tex2Dgrad( _MainTex, uv, dx, dy);
    mediump vec3 objNrm;
    objNrm.y = sin((1.5708 * detailuv.y));
    highp float ymag = (1.0 - (objNrm.y * objNrm.y));
    #line 124
    objNrm.z = (cos((1.5708 * detailuv.y)) * cos((3.14159 * detailuv.x)));
    objNrm.x = (cos((1.5708 * detailuv.y)) * sin((3.14159 * detailuv.x)));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    objNrm = abs(objNrm);
    #line 128
    mediump float zxlerp = xll_saturate_f(floor(((1.0 + objNrm.x) - objNrm.z)));
    mediump vec3 detailCoords = mix( objNrm.zxy, objNrm.xyz, vec3( zxlerp));
    mediump float nylerp = xll_saturate_f(floor(((1.0 + objNrm.y) - mix( objNrm.z, objNrm.x, zxlerp))));
    detailCoords = mix( detailCoords, objNrm.yxz, vec3( nylerp));
    #line 132
    mediump vec4 detail = texture( _DetailTex, ((((0.5 * detailCoords.zy) / abs(detailCoords.x)) + _DetailOffset.xy), uvdd.xy, uvdd.zw * _DetailScale));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * distance( IN.worldPos, _WorldSpaceCameraPos)));
    color *= mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    color.w = (1.2 * (1.2 - color.w));
    #line 136
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
//   d3d9 - ALU: 144 to 144, TEX: 4 to 4
//   d3d11 - ALU: 87 to 87, TEX: 1 to 1, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_MainOffset]
Float 2 [_DetailScale]
Float 3 [_DetailDist]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 144 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
def c4, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c5, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c6, 1.57079601, 0.15917969, 0.50000000, -0.12121582
def c7, 6.28125000, -3.14062500, -0.01348114, 0.05746460
def c8, 0.19567871, -0.33300781, 1.57031250, 3.14062500
def c9, 0.31835938, 0.50000000, 0.31830987, 0.24996185
def c10, 0.49992371, 0.50000000, 0.15915494, 1.20019531
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.x
dcl_texcoord2 v2.x
dcl_texcoord3 v3.x
dcl_texcoord4 v4.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
mad_pp r2.y, r0, c4, c4.z
mad_pp r2.w, -r0.x, c4.y, c4.x
mul_pp r0.y, r2, r2
mad_pp r0.x, r2.w, r2.w, r0.y
rsq_pp r2.z, r0.x
rcp_pp r2.x, r2.z
abs r0.x, r2
mad r0.z, r0.x, c5.x, c5.y
add r0.y, -r0.x, c4.x
mad r0.z, r0.x, r0, c5
mad r0.z, r0.x, r0, c5.w
rsq r0.y, r0.y
rcp r0.x, r0.y
mad r0.y, -r0.x, r0.z, c6.x
cmp r0.x, r2, c4.w, c4.y
mad r0.x, -r0, r0.y, r0.y
mad_pp r0.z, v2.x, c6.y, c6
frc_pp r0.y, r0.z
mad_pp r0.x, r0, c6.y, c6.z
mad_pp r1.y, r0, c7.x, c7
frc_pp r1.x, r0
sincos_pp r0.xy, r1.y
mad_pp r0.z, r1.x, c7.x, c7.y
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
mad_pp r3.y, r3.x, c7.z, c7.w
mad_pp r3.y, r3, r3.x, c6.w
mad_pp r3.y, r3, r3.x, c8.x
mad_pp r3.y, r3, r3.x, c8
mad_pp r3.x, r3.y, r3, c4
mul_pp r2.w, r3.x, r2
mul_pp r0.x, r0, r1.y
mul_pp r0.y, r1.x, r0
mad r0.y, r2.z, r0.x, r0
add_pp r3.x, -r2.w, c8.z
add_pp r1.z, r1.w, -r1
cmp_pp r1.z, -r1, r2.w, r3.x
add_pp r1.w, -r1.z, c8
cmp_pp r0.z, r0, r1, r1.w
cmp_pp r0.x, r0.w, r0.z, -r0.z
abs r0.z, r0.y
add_pp r0.x, v3, r0
mad r1.x, r0.z, c5, c5.y
add r0.w, -r0.z, c4.x
mad r1.x, r0.z, r1, c5.z
mad r1.x, r0.z, r1, c5.w
rsq r0.w, r0.w
rcp r0.z, r0.w
mad r0.z, -r0, r1.x, c6.x
cmp r0.y, r0, c4.w, c4
mad r0.y, -r0, r0.z, r0.z
mad r2.y, r0, c9.z, c9
mad_pp r2.z, r0.x, c9.x, c9.y
add_pp r0.y, r2.z, c1.w
mad_pp r0.x, r2.y, c4.y, c4.z
mad_pp r0.y, r0, c10.x, c10
frc_pp r0.y, r0
mad_pp r0.x, r0, c9.w, c9.y
frc_pp r0.x, r0
mad_pp r1.x, r0.y, c7, c7.y
mad_pp r2.w, r0.x, c7.x, c7.y
sincos_pp r0.xy, r1.x
sincos_pp r1.xy, r2.w
mul_pp r0.xy, r1.x, r0.yxzw
add r1.xyz, -v4, c0
dp3 r0.z, r1, r1
dsy r0.xy, r0
mul r0.xy, r0, r0
add r0.x, r0, r0.y
rsq r0.x, r0.x
rcp r0.x, r0.x
rsq r0.z, r0.z
rcp r0.z, r0.z
dsy r1.xy, v0
mul r0.x, r0, c10.z
dsy r0.y, r2
mul r0.xy, r0, c2.x
texld r0.w, r0, s1
mul r0.x, r0.z, c3
add_pp r0.y, -r0.w, c4.x
mul_sat r0.x, r0, c4.y
mad_pp r1.z, r0.x, r0.y, r0.w
mov_pp r0.y, c1.w
add_pp r0.x, r2.z, c4
mad_pp r0.x, r0, c6.z, r0.y
mov_pp r0.y, r2
dsx r0.zw, v0.xyxy
texldd r0.w, r0, s0, r0.zwzw, r1
mad_pp r0.x, -r0.w, r1.z, c10.w
mul_pp_sat r0.x, r0, c10.w
add_pp r1.x, r0, c4.z
add r0.x, v0.w, c4
frc r0.y, r0.x
add_sat r0.x, r0, -r0.y
add r0.z, -r2.x, c4.y
frc r0.w, r0.z
add_sat r0.y, r0.z, -r0.w
mul r0.x, r0, v1
mul_pp r0.x, r0, r0.y
mad_pp oC0, r0.x, r1.x, c4.x
"
}

SubProgram "d3d11 " {
Keywords { }
ConstBuffer "$Globals" 112 // 40 used size, 5 vars
Vector 0 [_MainOffset] 4
Float 32 [_DetailScale]
Float 36 [_DetailDist]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 96 instructions, 6 temp regs, 0 temp arrays:
// ALU 83 float, 0 int, 4 uint
// TEX 1 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedijegmbhobhfmlddmndcnbfkhieibdbgaabaaaaaaiaanaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ababaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaacacaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaacaaaaaaaeaeaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgaamaaaa
eaaaaaaabiadaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaa
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
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapmjdpenaaaaag
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
adaaaaaabkaabaaaaaaaaaaaamaaaaafdcaabaaaadaaaaaaegaabaaaaaaaaaaa
apaaaaahbcaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaelaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaacaaaaaaamaaaaafccaabaaaaaaaaaaabkaabaaa
acaaaaaadgaaaaafbcaabaaaadaaaaaaabeaaaaaidpjccdodgaaaaagccaabaaa
adaaaaaaakiacaaaaaaaaaaaacaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegaabaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaibcaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaajocaabaaaabaaaaaaagbjbaaa
adaaaaaaagijcaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahccaabaaaaaaaaaaa
jgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaajecaabaaaaaaaaaaabkiacaaaaaaaaaaaacaaaaaabkiacaaa
aaaaaaaaacaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaaalaaaaafgcaabaaaaaaaaaaaagbbbaaaabaaaaaaamaaaaaf
gcaabaaaabaaaaaaagbbbaaaabaaaaaaejaaaaanpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaajgafbaaaaaaaaaaajgafbaaa
abaaaaaadcaaaaakbcaabaaaaaaaaaaadkaabaiaebaaaaaaacaaaaaaakaabaaa
aaaaaaaaabeaaaaajkjjjjdpdicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaajkjjjjdpaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaialpaaaaaaahccaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaaaaiadp
ebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakbabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
abaaaaaabkaabaaaaaaaaaaadcaaaaampccabaaaaaaaaaaafgafbaaaaaaaaaaa
agaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdoaaaaab
"
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

#LINE 121

      }
   }  
}