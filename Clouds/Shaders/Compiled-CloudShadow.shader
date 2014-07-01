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
//   d3d9 - ALU: 60 to 60
//   d3d11 - ALU: 45 to 45, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL
#ifdef VERTEX
varying float xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform mat4 _Projector;
uniform vec4 _ShadowOffset;

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
  tmpvar_4 = -((sign(_ShadowOffset.y) * (1.5708 - (sqrt((1.0 - abs(_ShadowOffset.y))) * (1.5708 + (abs(_ShadowOffset.y) * (-0.214602 + (abs(_ShadowOffset.y) * (0.0865667 + (abs(_ShadowOffset.y) * -0.0310296))))))))));
  float r_6;
  if ((abs(_ShadowOffset.z) > (1e-08 * abs(_ShadowOffset.x)))) {
    float y_over_x_7;
    y_over_x_7 = (_ShadowOffset.x / _ShadowOffset.z);
    float s_8;
    float x_9;
    x_9 = (y_over_x_7 * inversesqrt(((y_over_x_7 * y_over_x_7) + 1.0)));
    s_8 = (sign(x_9) * (1.5708 - (sqrt((1.0 - abs(x_9))) * (1.5708 + (abs(x_9) * (-0.214602 + (abs(x_9) * (0.0865667 + (abs(x_9) * -0.0310296)))))))));
    r_6 = s_8;
    if ((_ShadowOffset.z < 0.0)) {
      if ((_ShadowOffset.x >= 0.0)) {
        r_6 = (s_8 + 3.14159);
      } else {
        r_6 = (r_6 - 3.14159);
      };
    };
  } else {
    r_6 = (sign(_ShadowOffset.x) * 1.5708);
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = r_6;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying float xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform vec4 _ShadowOffset;
uniform sampler2D _ShadowTex;
void main ()
{
  vec4 color_1;
  float radCheck_2;
  vec2 dy_3;
  vec2 dx_4;
  vec2 uv_5;
  float dirCheck_6;
  dirCheck_6 = (clamp (floor((xlv_TEXCOORD0.w + 1.0)), 0.0, 1.0) * xlv_TEXCOORD1);
  vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  dx_4 = dFdx(xlv_TEXCOORD0.xy);
  dy_3 = dFdy(xlv_TEXCOORD0.xy);
  uv_5.x = (-((2.0 * tmpvar_7.x)) + 1.0);
  uv_5.y = ((2.0 * tmpvar_7.y) - 1.0);
  float tmpvar_8;
  tmpvar_8 = sqrt((pow (uv_5.x, 2.0) + pow (uv_5.y, 2.0)));
  radCheck_2 = clamp (floor((2.0 - tmpvar_8)), 0.0, 1.0);
  float tmpvar_9;
  tmpvar_9 = (sign(tmpvar_8) * (1.5708 - (sqrt((1.0 - abs(tmpvar_8))) * (1.5708 + (abs(tmpvar_8) * (-0.214602 + (abs(tmpvar_8) * (0.0865667 + (abs(tmpvar_8) * -0.0310296)))))))));
  float tmpvar_10;
  tmpvar_10 = sin(tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = cos(tmpvar_9);
  float tmpvar_12;
  tmpvar_12 = cos(xlv_TEXCOORD2);
  float tmpvar_13;
  tmpvar_13 = sin(xlv_TEXCOORD2);
  float y_14;
  y_14 = (uv_5.x * tmpvar_10);
  float x_15;
  x_15 = (((tmpvar_8 * tmpvar_12) * tmpvar_11) - ((uv_5.y * tmpvar_13) * tmpvar_10));
  float r_16;
  if ((abs(x_15) > (1e-08 * abs(y_14)))) {
    float y_over_x_17;
    y_over_x_17 = (y_14 / x_15);
    float s_18;
    float x_19;
    x_19 = (y_over_x_17 * inversesqrt(((y_over_x_17 * y_over_x_17) + 1.0)));
    s_18 = (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))));
    r_16 = s_18;
    if ((x_15 < 0.0)) {
      if ((y_14 >= 0.0)) {
        r_16 = (s_18 + 3.14159);
      } else {
        r_16 = (r_16 - 3.14159);
      };
    };
  } else {
    r_16 = (sign(y_14) * 1.5708);
  };
  uv_5.x = (((0.31831 * (xlv_TEXCOORD3 + r_16)) + 0.5) + _ShadowOffset.w);
  float x_20;
  x_20 = ((tmpvar_11 * tmpvar_13) + (((uv_5.y * tmpvar_10) * tmpvar_12) / tmpvar_8));
  uv_5.y = ((0.31831 * (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))))) + 0.5);
  vec4 tmpvar_21;
  tmpvar_21 = texture2DGradARB (_ShadowTex, uv_5, dx_4, dy_3);
  color_1.w = tmpvar_21.w;
  color_1.xyz = (tmpvar_21.xyz * (1.25 * (1.25 - tmpvar_21.w)));
  vec4 tmpvar_22;
  tmpvar_22 = clamp (color_1, 0.0, 1.0);
  color_1 = tmpvar_22;
  gl_FragData[0] = vec4(mix (1.0, tmpvar_22.x, (dirCheck_6 * radCheck_2)));
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ShadowOffset]
Matrix 4 [_Projector]
"vs_3_0
; 60 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c9, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c10, -0.21211439, 1.57072902, 1.57079601, 2.00000000
def c11, -0.01348047, 0.05747731, -0.12123910, 0.19563590
def c12, -0.33299461, 0.99999559, 3.14159298, 0
dcl_position0 v0
dcl_normal0 v1
abs r0.w, c8.x
abs r0.z, c8
max r0.x, r0.z, r0.w
rcp r0.y, r0.x
min r0.x, r0.z, r0.w
mul r0.y, r0.x, r0
mul r0.x, r0.y, r0.y
slt r0.z, r0, r0.w
mad r1.x, r0, c11, c11.y
mad r1.x, r1, r0, c11.z
mad r0.w, r1.x, r0.x, c11
mad r0.w, r0, r0.x, c12.x
mad r0.x, r0.w, r0, c12.y
max r0.z, -r0, r0
slt r0.z, c9.x, r0
mul r0.x, r0, r0.y
add r0.w, -r0.z, c9.y
mul r0.y, r0.x, r0.w
add r0.x, -r0, c10.z
mad r0.x, r0.z, r0, r0.y
mov r0.z, c9.x
slt r0.w, c8.z, r0.z
mov r0.z, c9.x
max r0.w, -r0, r0
slt r0.w, c9.x, r0
slt r0.z, c8.x, r0
max r0.z, -r0, r0
add r1.x, -r0.w, c9.y
add r0.y, -r0.x, c12.z
mul r0.x, r0, r1
mad r0.y, r0.w, r0, r0.x
slt r0.z, c9.x, r0
add r1.x, -r0.z, c9.y
mul r0.w, r0.y, r1.x
abs r0.x, c8.y
mad o4.x, r0.z, -r0.y, r0.w
mad r0.z, r0.x, c9, c9.w
add r0.y, -r0.x, c9
mad r0.z, r0.x, r0, c10.x
mad r0.z, r0.x, r0, c10.y
rsq r0.y, r0.y
rcp r0.x, r0.y
mad r0.x, -r0, r0.z, c10.z
dp3 r0.y, c6, c6
mov r0.z, c9.x
rsq r0.y, r0.y
slt r0.z, c8.y, r0
mul r0.z, r0, r0.x
mul r1.xyz, r0.y, c6
mad r0.x, -r0.z, c10.w, r0
dp3_sat o2.x, -v1, r1
mov o3.x, -r0
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
Vector 0 [_ShadowOffset] 4
Matrix 16 [_Projector] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerDraw" 1
// 50 instructions, 2 temp regs, 0 temp arrays:
// ALU 41 float, 0 int, 4 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbdocphhkoeajohmliefocdibpbddiidjabaaaaaaciaiaaaaadaaaaaa
cmaaaaaahmaaaaaabmabaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafaepfdejfeejepeoaaeoepfcenebemaaepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaabaoaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaacanaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
aealaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
aeahaaaaeaaaabaambabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
abaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadbccabaaaacaaaaaagfaaaaadcccabaaaacaaaaaagfaaaaadeccabaaa
acaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
adaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaabaaaaaa
egiocaaaaaaaaaaaaeaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadeaaaaal
bcaabaaaaaaaaaaackiacaiaibaaaaaaaaaaaaaaaaaaaaaaakiacaiaibaaaaaa
aaaaaaaaaaaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaalccaabaaaaaaaaaaackiacaia
ibaaaaaaaaaaaaaaaaaaaaaaakiacaiaibaaaaaaaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlo
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
diphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaalicaabaaaaaaaaaaackiacaiaibaaaaaaaaaaaaaaaaaaaaaa
akiacaiaibaaaaaaaaaaaaaaaaaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaakgcaabaaaaaaaaaaafgigcaaa
aaaaaaaaaaaaaaaafgigcaiaebaaaaaaaaaaaaaaaaaaaaaaabaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaajecaabaaaaaaaaaaackiacaaa
aaaaaaaaaaaaaaaaakiacaaaaaaaaaaaaaaaaaaadbaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadeaaaaajicaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaaaaaaaaakiacaaaaaaaaaaaaaaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahecaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadhaaaaakeccabaaaacaaaaaa
ckaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
bcaabaaaabaaaaaackiacaaaaaaaaaaaabaaaaaadgaaaaagccaabaaaabaaaaaa
ckiacaaaaaaaaaaaacaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaaaaaaaaa
adaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahncaabaaaaaaaaaaa
agaabaaaaaaaaaaaagajbaaaabaaaaaabacaaaaibccabaaaacaaaaaaegbcbaia
ebaaaaaaabaaaaaaigadbaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaabkiacaia
ibaaaaaaaaaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaal
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaiaibaaaaaaaaaaaaaaaaaaaaaa
abeaaaaaiedefjlodcaaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaia
ibaaaaaaaaaaaaaaaaaaaaaaabeaaaaakeanmjdpaaaaaaajecaabaaaaaaaaaaa
bkiacaiambaaaaaaaaaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapejeaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaaabeaaaaanlapmjdpdgaaaaagcccabaaaacaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Projector;
uniform highp vec4 _ShadowOffset;
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
  tmpvar_7 = -((sign(_ShadowOffset.y) * (1.5708 - (sqrt((1.0 - abs(_ShadowOffset.y))) * (1.5708 + (abs(_ShadowOffset.y) * (-0.214602 + (abs(_ShadowOffset.y) * (0.0865667 + (abs(_ShadowOffset.y) * -0.0310296))))))))));
  tmpvar_4 = tmpvar_7;
  highp float r_8;
  if ((abs(_ShadowOffset.z) > (1e-08 * abs(_ShadowOffset.x)))) {
    highp float y_over_x_9;
    y_over_x_9 = (_ShadowOffset.x / _ShadowOffset.z);
    highp float s_10;
    highp float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((_ShadowOffset.z < 0.0)) {
      if ((_ShadowOffset.x >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(_ShadowOffset.x) * 1.5708);
  };
  tmpvar_5 = r_8;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _ShadowOffset;
uniform sampler2D _ShadowTex;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float c_3;
  mediump float radCheck_4;
  highp float p_5;
  mediump vec2 dy_6;
  mediump vec2 dx_7;
  mediump vec2 uv_8;
  mediump float dirCheck_9;
  highp float tmpvar_10;
  tmpvar_10 = (clamp (floor((xlv_TEXCOORD0.w + 1.0)), 0.0, 1.0) * xlv_TEXCOORD1);
  dirCheck_9 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  uv_8 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD0.xy);
  dx_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD0.xy);
  dy_6 = tmpvar_13;
  uv_8.x = (-((2.0 * uv_8.x)) + 1.0);
  uv_8.y = ((2.0 * uv_8.y) - 1.0);
  mediump float tmpvar_14;
  tmpvar_14 = sqrt((pow (uv_8.x, 2.0) + pow (uv_8.y, 2.0)));
  p_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (floor((2.0 - p_5)), 0.0, 1.0);
  radCheck_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (sign(p_5) * (1.5708 - (sqrt((1.0 - abs(p_5))) * (1.5708 + (abs(p_5) * (-0.214602 + (abs(p_5) * (0.0865667 + (abs(p_5) * -0.0310296)))))))));
  c_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sin(c_3);
  mediump float tmpvar_18;
  tmpvar_18 = cos(c_3);
  mediump float tmpvar_19;
  tmpvar_19 = cos(xlv_TEXCOORD2);
  mediump float tmpvar_20;
  tmpvar_20 = sin(xlv_TEXCOORD2);
  highp float tmpvar_21;
  mediump float y_22;
  y_22 = (uv_8.x * tmpvar_17);
  highp float x_23;
  x_23 = (((p_5 * tmpvar_19) * tmpvar_18) - ((uv_8.y * tmpvar_20) * tmpvar_17));
  mediump float r_24;
  if ((abs(x_23) > (1e-08 * abs(y_22)))) {
    highp float y_over_x_25;
    y_over_x_25 = (y_22 / x_23);
    highp float x_26;
    x_26 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    r_24 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    if ((x_23 < 0.0)) {
      if ((y_22 >= 0.0)) {
        r_24 = (r_24 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(y_22) * 1.5708);
  };
  tmpvar_21 = r_24;
  highp float tmpvar_27;
  tmpvar_27 = (((0.31831 * (xlv_TEXCOORD3 + tmpvar_21)) + 0.5) + _ShadowOffset.w);
  uv_8.x = tmpvar_27;
  highp float x_28;
  x_28 = ((tmpvar_18 * tmpvar_20) + (((uv_8.y * tmpvar_17) * tmpvar_19) / p_5));
  highp float tmpvar_29;
  tmpvar_29 = ((0.31831 * (sign(x_28) * (1.5708 - (sqrt((1.0 - abs(x_28))) * (1.5708 + (abs(x_28) * (-0.214602 + (abs(x_28) * (0.0865667 + (abs(x_28) * -0.0310296)))))))))) + 0.5);
  uv_8.y = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DGradEXT (_ShadowTex, uv_8, dx_7, dy_6);
  color_2.w = tmpvar_30.w;
  color_2.xyz = (tmpvar_30.xyz * (1.25 * (1.25 - tmpvar_30.w)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = clamp (color_2, 0.0, 1.0);
  color_2 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = vec4(mix (1.0, tmpvar_31.x, (dirCheck_9 * radCheck_4)));
  tmpvar_1 = tmpvar_32;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Projector;
uniform highp vec4 _ShadowOffset;
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
  tmpvar_7 = -((sign(_ShadowOffset.y) * (1.5708 - (sqrt((1.0 - abs(_ShadowOffset.y))) * (1.5708 + (abs(_ShadowOffset.y) * (-0.214602 + (abs(_ShadowOffset.y) * (0.0865667 + (abs(_ShadowOffset.y) * -0.0310296))))))))));
  tmpvar_4 = tmpvar_7;
  highp float r_8;
  if ((abs(_ShadowOffset.z) > (1e-08 * abs(_ShadowOffset.x)))) {
    highp float y_over_x_9;
    y_over_x_9 = (_ShadowOffset.x / _ShadowOffset.z);
    highp float s_10;
    highp float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((_ShadowOffset.z < 0.0)) {
      if ((_ShadowOffset.x >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(_ShadowOffset.x) * 1.5708);
  };
  tmpvar_5 = r_8;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _ShadowOffset;
uniform sampler2D _ShadowTex;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float c_3;
  mediump float radCheck_4;
  highp float p_5;
  mediump vec2 dy_6;
  mediump vec2 dx_7;
  mediump vec2 uv_8;
  mediump float dirCheck_9;
  highp float tmpvar_10;
  tmpvar_10 = (clamp (floor((xlv_TEXCOORD0.w + 1.0)), 0.0, 1.0) * xlv_TEXCOORD1);
  dirCheck_9 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  uv_8 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD0.xy);
  dx_7 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD0.xy);
  dy_6 = tmpvar_13;
  uv_8.x = (-((2.0 * uv_8.x)) + 1.0);
  uv_8.y = ((2.0 * uv_8.y) - 1.0);
  mediump float tmpvar_14;
  tmpvar_14 = sqrt((pow (uv_8.x, 2.0) + pow (uv_8.y, 2.0)));
  p_5 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (floor((2.0 - p_5)), 0.0, 1.0);
  radCheck_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (sign(p_5) * (1.5708 - (sqrt((1.0 - abs(p_5))) * (1.5708 + (abs(p_5) * (-0.214602 + (abs(p_5) * (0.0865667 + (abs(p_5) * -0.0310296)))))))));
  c_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sin(c_3);
  mediump float tmpvar_18;
  tmpvar_18 = cos(c_3);
  mediump float tmpvar_19;
  tmpvar_19 = cos(xlv_TEXCOORD2);
  mediump float tmpvar_20;
  tmpvar_20 = sin(xlv_TEXCOORD2);
  highp float tmpvar_21;
  mediump float y_22;
  y_22 = (uv_8.x * tmpvar_17);
  highp float x_23;
  x_23 = (((p_5 * tmpvar_19) * tmpvar_18) - ((uv_8.y * tmpvar_20) * tmpvar_17));
  mediump float r_24;
  if ((abs(x_23) > (1e-08 * abs(y_22)))) {
    highp float y_over_x_25;
    y_over_x_25 = (y_22 / x_23);
    highp float x_26;
    x_26 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    r_24 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    if ((x_23 < 0.0)) {
      if ((y_22 >= 0.0)) {
        r_24 = (r_24 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(y_22) * 1.5708);
  };
  tmpvar_21 = r_24;
  highp float tmpvar_27;
  tmpvar_27 = (((0.31831 * (xlv_TEXCOORD3 + tmpvar_21)) + 0.5) + _ShadowOffset.w);
  uv_8.x = tmpvar_27;
  highp float x_28;
  x_28 = ((tmpvar_18 * tmpvar_20) + (((uv_8.y * tmpvar_17) * tmpvar_19) / p_5));
  highp float tmpvar_29;
  tmpvar_29 = ((0.31831 * (sign(x_28) * (1.5708 - (sqrt((1.0 - abs(x_28))) * (1.5708 + (abs(x_28) * (-0.214602 + (abs(x_28) * (0.0865667 + (abs(x_28) * -0.0310296)))))))))) + 0.5);
  uv_8.y = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DGradEXT (_ShadowTex, uv_8, dx_7, dy_6);
  color_2.w = tmpvar_30.w;
  color_2.xyz = (tmpvar_30.xyz * (1.25 * (1.25 - tmpvar_30.w)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = clamp (color_2, 0.0, 1.0);
  color_2 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = vec4(mix (1.0, tmpvar_31.x, (dirCheck_9 * radCheck_4)));
  tmpvar_1 = tmpvar_32;
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
    mediump float latitude;
    mediump float longitude;
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
#line 69
#line 69
v2f vert( in appdata_t v ) {
    v2f o;
    o.posProj = (_Projector * v.vertex);
    #line 73
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 normView = normalize(vec3( _Projector[0][2], _Projector[1][2], _Projector[2][2]));
    o.dotcoeff = xll_saturate_f(dot( (-v.normal), normView));
    o.latitude = (-asin(_ShadowOffset.y));
    #line 77
    o.longitude = atan( _ShadowOffset.x, _ShadowOffset.z);
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out mediump float xlv_TEXCOORD2;
out mediump float xlv_TEXCOORD3;
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
#line 60
struct v2f {
    highp vec4 pos;
    highp vec4 posProj;
    highp float dotcoeff;
    mediump float latitude;
    mediump float longitude;
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
#line 69
#line 80
lowp vec4 frag( in v2f IN ) {
    #line 82
    mediump float dirCheck = (xll_saturate_f(floor((IN.posProj.w + 1.0))) * IN.dotcoeff);
    mediump vec2 uv = (IN.posProj.xy / IN.posProj.w);
    mediump vec2 dx = xll_dFdx_vf2(IN.posProj.xy);
    mediump vec2 dy = xll_dFdy_vf2(IN.posProj.xy);
    #line 86
    uv.x = ((-(2.0 * uv.x)) + 1.0);
    uv.y = ((2.0 * uv.y) - 1.0);
    highp float p = sqrt((pow( uv.x, 2.0) + pow( uv.y, 2.0)));
    mediump float radCheck = xll_saturate_f(floor((2.0 - p)));
    #line 90
    mediump float c = asin(p);
    mediump float sinC = sin(c);
    mediump float cosC = cos(c);
    mediump float cosLat = cos(IN.latitude);
    #line 94
    mediump float sinLat = sin(IN.latitude);
    uv.x = (((0.31831 * (IN.longitude + atan( (uv.x * sinC), (((p * cosLat) * cosC) - ((uv.y * sinLat) * sinC))))) + 0.5) + _ShadowOffset.w);
    uv.y = ((0.31831 * asin(((cosC * sinLat) + (((uv.y * sinC) * cosLat) / p)))) + 0.5);
    lowp vec4 color = xll_tex2Dgrad( _ShadowTex, uv, dx, dy);
    #line 98
    color.xyz *= (1.25 * (1.25 - color.w));
    color = xll_saturate_vf4(color);
    return vec4( mix( 1.0, float( color), (dirCheck * radCheck)));
}
in highp vec4 xlv_TEXCOORD0;
in highp float xlv_TEXCOORD1;
in mediump float xlv_TEXCOORD2;
in mediump float xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.posProj = vec4(xlv_TEXCOORD0);
    xlt_IN.dotcoeff = float(xlv_TEXCOORD1);
    xlt_IN.latitude = float(xlv_TEXCOORD2);
    xlt_IN.longitude = float(xlv_TEXCOORD3);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   d3d9 - ALU: 99 to 99, TEX: 3 to 3
//   d3d11 - ALU: 67 to 67, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { }
Vector 0 [_ShadowOffset]
SetTexture 0 [_ShadowTex] 2D
"ps_3_0
; 99 ALU, 3 TEX
dcl_2d s0
def c1, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c2, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c3, 1.57079601, 0.15917969, 0.50000000, 0.31830987
def c4, 6.28125000, -3.14062500, -0.01348114, 0.05746460
def c5, -0.12121582, 0.19567871, -0.33300781, 1.57031250
def c6, 3.14062500, 0.31835938, 0.50000000, 1.25000000
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.x
dcl_texcoord2 v2.x
dcl_texcoord3 v3.x
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
mad_pp r2.y, r0, c1, c1.z
mad_pp r2.w, -r0.x, c1.y, c1.x
mul_pp r0.y, r2, r2
mad_pp r0.x, r2.w, r2.w, r0.y
rsq_pp r2.z, r0.x
rcp_pp r2.x, r2.z
abs r0.x, r2
mad r0.z, r0.x, c2.x, c2.y
add r0.y, -r0.x, c1.x
mad r0.z, r0.x, r0, c2
mad r0.z, r0.x, r0, c2.w
rsq r0.y, r0.y
rcp r0.x, r0.y
mad r0.y, -r0.x, r0.z, c3.x
cmp r0.x, r2, c1.w, c1.y
mad r0.x, -r0, r0.y, r0.y
mad_pp r0.z, v2.x, c3.y, c3
frc_pp r0.y, r0.z
mad_pp r0.x, r0, c3.y, c3.z
mad_pp r1.y, r0, c4.x, c4
frc_pp r1.x, r0
sincos_pp r0.xy, r1.y
mad_pp r0.z, r1.x, c4.x, c4.y
sincos_pp r1.xy, r0.z
mul_pp r0.z, r2.y, r0.y
mul_pp r0.w, r1.y, r0.z
mul r0.z, r2.x, r0.x
mad r0.z, r1.x, r0, -r0.w
mul_pp r0.w, r2, r1.y
abs_pp r1.w, r0
abs_pp r1.z, r0
max_pp r2.w, r1, r1.z
rcp_pp r3.x, r2.w
min_pp r2.w, r1, r1.z
mul_pp r2.w, r2, r3.x
mul_pp r3.x, r2.w, r2.w
mad_pp r3.y, r3.x, c4.z, c4.w
mad_pp r3.y, r3, r3.x, c5.x
mad_pp r3.y, r3, r3.x, c5
mad_pp r3.y, r3, r3.x, c5.z
mad_pp r3.x, r3.y, r3, c1
mul_pp r2.w, r3.x, r2
mul_pp r0.y, r1.x, r0
add_pp r1.z, r1.w, -r1
add_pp r3.x, -r2.w, c5.w
cmp_pp r1.z, -r1, r2.w, r3.x
add_pp r1.w, -r1.z, c6.x
cmp_pp r0.z, r0, r1, r1.w
cmp_pp r0.w, r0, r0.z, -r0.z
mul_pp r0.z, r2.y, r1.y
mul_pp r0.x, r0.z, r0
mad r0.x, r2.z, r0, r0.y
abs r0.y, r0.x
add_pp r0.z, v3.x, r0.w
mad_pp r1.x, r0.z, c6.y, c6.z
mad r0.w, r0.y, c2.x, c2.y
add r0.z, -r0.y, c1.x
mad r0.w, r0.y, r0, c2.z
mad r0.w, r0.y, r0, c2
rsq r0.z, r0.z
rcp r0.y, r0.z
mad r0.y, -r0, r0.w, c3.x
cmp r0.x, r0, c1.w, c1.y
mad r0.y, -r0.x, r0, r0
add r0.x, r1, c0.w
mad r0.y, r0, c3.w, c3.z
dsy r1.xy, v0
dsx r0.zw, v0.xyxy
texldd r0.xw, r0, s0, r0.zwzw, r1
add_pp r0.y, -r0.w, c6.w
mul_pp r0.x, r0.y, r0
mul_pp_sat r0.x, r0, c6.w
add_pp r1.x, r0, c1.z
add r0.x, v0.w, c1
frc r0.y, r0.x
add_sat r0.x, r0, -r0.y
add r0.z, -r2.x, c1.y
frc r0.w, r0.z
add_sat r0.y, r0.z, -r0.w
mul r0.x, r0, v1
mul_pp r0.x, r0, r0.y
mad_pp oC0, r0.x, r1.x, c1.x
"
}

SubProgram "d3d11 " {
Keywords { }
ConstBuffer "$Globals" 80 // 16 used size, 2 vars
Vector 0 [_ShadowOffset] 4
BindCB "$Globals" 0
SetTexture 0 [_ShadowTex] 2D 0
// 73 instructions, 6 temp regs, 0 temp arrays:
// ALU 63 float, 0 int, 4 uint
// TEX 0 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedhbgcgaadpneccknjgfmhanjenpjjdlkoabaaaaaaimakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ababaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaacacaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaacaaaaaaaeaeaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcieajaaaaeaaaaaaagbacaaaafjaaaaaeegiocaaaaaaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
lcbabaaaabaaaaaagcbaaaadbcbabaaaacaaaaaagcbaaaadccbabaaaacaaaaaa
gcbaaaadecbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaadcaaaaak
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaaeaabeaaaaa
aaaaiadpdcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaea
abeaaaaaaaaaialpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
icaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
iedefjlodcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaakeanmjdpaaaaaaaldcaabaaaabaaaaaakgakbaiaebaaaaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaiadpaaaaaaaaaaaaaaaaelaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
bkaabaaaabaaaaaaabeaaaaanlapmjdpenaaaaahbcaabaaaacaaaaaabcaabaaa
adaaaaaadkaabaaaaaaaaaaaenaaaaahbcaabaaaaeaaaaaabcaabaaaafaaaaaa
bkbabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aeaaaaaadiaaaaahlcaabaaaaaaaaaaaegambaaaaaaaaaaaagaabaaaacaaaaaa
diaaaaahccaabaaaaaaaaaaaakaabaaaafaaaaaabkaabaaaaaaaaaaaaoaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaafaaaaaadcaaaaajccaabaaaaaaaaaaa
akaabaaaadaaaaaaakaabaaaaeaaaaaabkaabaaaaaaaaaaadcaaaaakecaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadkaabaiaebaaaaaaaaaaaaaa
deaaaaajicaabaaaaaaaaaaackaabaiaibaaaaaaaaaaaaaaakaabaiaibaaaaaa
aaaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaaaaaaaaaddaaaaajccaabaaaabaaaaaackaabaiaibaaaaaa
aaaaaaaaakaabaiaibaaaaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaabaaaaaabkaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaa
abaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadcaaaaajecaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaa
abaaaaaackaabaiaibaaaaaaaaaaaaaaakaabaiaibaaaaaaaaaaaaaaabaaaaah
ecaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaadcaaaaajicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadbaaaaai
ccaabaaaabaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaanlapejmaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaaabaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaadbaaaaaiecaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaiaebaaaaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaaaacaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaidpjkcdodkiacaaaaaaaaaaaaaaaaaaaaaaaaaahbcaabaaaacaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakbcaabaaaaaaaaaaabkaabaia
ibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlo
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaa
abeaaaaakeanmjdpaaaaaaaiecaabaaaaaaaaaaabkaabaiambaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaai
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaanlapmjdpdcaaaaaj
ccaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjkcdoabeaaaaaaaaaaadp
alaaaaafdcaabaaaaaaaaaaaegbabaaaabaaaaaaamaaaaafmcaabaaaaaaaaaaa
agbebaaaabaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaaaaaaaaaogakbaaaaaaaaaaaaaaaaaai
ccaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaakadpdiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaakadpdicaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaafgafbaaaabaaaaaadgcaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaialpaaaaaaahccaabaaaabaaaaaadkbabaaa
abaaaaaaabeaaaaaaaaaiadpebcaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaakbabaaaacaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaampccabaaa
aaaaaaaaagaabaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdoaaaaab"
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

#LINE 71

      }
   }  
}