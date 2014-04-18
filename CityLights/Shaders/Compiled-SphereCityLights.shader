Shader "Sphere/CityLight" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_DetailTex ("Detail (RGB) (A)", 2D) = "white" {}
		_DetailScale ("Detail Scale", Range(0,1000)) = 80
		_DetailOffset ("Detail Offset", Color) = (0,0,0,0)
		_FadeDist ("Fade Distance", Range(0,10000)) = .01
		_FadeScale ("Fade Scale", Range(0,1)) = .002
		_Opacity ("Fade Alpha", Range(0,1)) = 1
	}
	Category {
	   Lighting On
	   ZWrite Off
	   Cull Back
	   Blend SrcAlpha OneMinusSrcAlpha
	   Tags {
	   "Queue"="Transparent"
	   "RenderMode"="Transparent"
	   }
	   SubShader {  	
        
     	
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
Program "vp" {
// Vertex combos: 6
//   d3d9 - ALU: 29 to 34
//   d3d11 - ALU: 22 to 25, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform vec4 unity_Scale;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_2;
  p_2 = (tmpvar_1 - (_Object2World * gl_Vertex).xyz);
  vec3 p_3;
  p_3 = (tmpvar_1 - _WorldSpaceCameraPos);
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = abs((sqrt(dot (p_2, p_2)) - sqrt(dot (p_3, p_3))));
  xlv_TEXCOORD1 = -(normalize(gl_Vertex.xyz));
  xlv_TEXCOORD2 = (tmpvar_4 * (gl_Normal * unity_Scale.w));
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform vec4 _Color;
uniform float _Opacity;
uniform float _FadeScale;
uniform float _FadeDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec2 uv_2;
  float r_3;
  if ((abs(xlv_TEXCOORD1.z) > (1e-08 * abs(xlv_TEXCOORD1.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD1.x / xlv_TEXCOORD1.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD1.z < 0.0)) {
      if ((xlv_TEXCOORD1.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD1.x) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_3));
  uv_2.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.y))) * (1.5708 + (abs(xlv_TEXCOORD1.y) * (-0.214602 + (abs(xlv_TEXCOORD1.y) * (0.0865667 + (abs(xlv_TEXCOORD1.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD1.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD1.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD1);
  vec4 tmpvar_16;
  tmpvar_16 = ((texture2DGradARB (_MainTex, uv_2, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy));
  vec4 c_17;
  c_17.w = ((_Opacity * min (tmpvar_16.w, clamp ((_FadeScale * (xlv_TEXCOORD0 - _FadeDist)), 0.0, 1.0))) * (1.0 - clamp ((_LightColor0.w * (((dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz) - 0.01) / 0.99) * 4.0)), 0.0, 1.0)));
  c_17.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = c_17.w;
  c_1.xyz = tmpvar_16.xyz;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Vector 9 [unity_Scale]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c10, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
add r1.xyz, r1, -r0
add r0.xyz, -r0, c8
dp3 r0.y, r0, r0
dp3 r0.w, r1, r1
mul r1.xyz, v1, c9.w
rsq r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
rcp r0.x, r0.x
add r0.x, r0, -r0.y
dp3 r0.z, v0, v0
rsq r0.y, r0.z
abs o1.x, r0
mul r0.xyz, r0.y, v0
mov o2.xyz, -r0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
mov o4.xyz, c10.x
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhifkmapocbmlcmllmpppfdpngpahjnkiabaaaaaadmafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaoabaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckaadaaaaeaaaabaa
oiaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaadoccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakocaabaaaaaaaaaaa
agijcaiaebaaaaaaaaaaaaaaaeaaaaaaagijcaaaabaaaaaaapaaaaaabaaaaaah
ccaabaaaaaaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaelaaaaafdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaagbccabaaaabaaaaaaakaabaiaibaaaaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegbcbaaaaaaaaaaadgaaaaagoccabaaaabaaaaaaagajbaia
ebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
abaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaabaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
abaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaihccabaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - (_Object2World * _glesVertex).xyz);
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = abs((sqrt(dot (p_3, p_3)) - sqrt(dot (p_4, p_4))));
  xlv_TEXCOORD1 = -(normalize(_glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _Opacity;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.z) > (1e-08 * abs(xlv_TEXCOORD1.x)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.x / xlv_TEXCOORD1.z);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.z < 0.0)) {
      if ((xlv_TEXCOORD1.x >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.x) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  uv_9.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.y))) * (1.5708 + (abs(xlv_TEXCOORD1.y) * (-0.214602 + (abs(xlv_TEXCOORD1.y) * (0.0865667 + (abs(xlv_TEXCOORD1.y) * -0.0310296)))))))))));
  highp float r_14;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_18;
  tmpvar_18 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_7 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_6 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_5 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_5, detailX_7, tmpvar_29.xxxx);
  detail_4 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_4, detailY_6, tmpvar_29.yyyy);
  detail_4 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_8 * detail_4);
  main_8 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (_Opacity * min (tmpvar_32.w, clamp ((_FadeScale * (xlv_TEXCOORD0 - _FadeDist)), 0.0, 1.0)));
  tmpvar_3 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_32.xyz;
  tmpvar_2 = tmpvar_34;
  mediump vec4 tmpvar_35;
  mediump vec3 lightDir_36;
  lightDir_36 = _WorldSpaceLightPos0.xyz;
  lowp vec4 c_37;
  highp float lightIntensity_38;
  mediump float tmpvar_39;
  tmpvar_39 = (_LightColor0.w * (((dot (xlv_TEXCOORD2, lightDir_36) - 0.01) / 0.99) * 4.0));
  lightIntensity_38 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (tmpvar_3 * (1.0 - clamp (lightIntensity_38, 0.0, 1.0)));
  c_37.w = tmpvar_40;
  c_37.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_35 = c_37;
  c_1 = tmpvar_35;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - (_Object2World * _glesVertex).xyz);
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = abs((sqrt(dot (p_3, p_3)) - sqrt(dot (p_4, p_4))));
  xlv_TEXCOORD1 = -(normalize(_glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _Opacity;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.z) > (1e-08 * abs(xlv_TEXCOORD1.x)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.x / xlv_TEXCOORD1.z);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.z < 0.0)) {
      if ((xlv_TEXCOORD1.x >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.x) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  uv_9.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.y))) * (1.5708 + (abs(xlv_TEXCOORD1.y) * (-0.214602 + (abs(xlv_TEXCOORD1.y) * (0.0865667 + (abs(xlv_TEXCOORD1.y) * -0.0310296)))))))))));
  highp float r_14;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_18;
  tmpvar_18 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_7 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_6 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_5 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_5, detailX_7, tmpvar_29.xxxx);
  detail_4 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_4, detailY_6, tmpvar_29.yyyy);
  detail_4 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_8 * detail_4);
  main_8 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (_Opacity * min (tmpvar_32.w, clamp ((_FadeScale * (xlv_TEXCOORD0 - _FadeDist)), 0.0, 1.0)));
  tmpvar_3 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_32.xyz;
  tmpvar_2 = tmpvar_34;
  mediump vec4 tmpvar_35;
  mediump vec3 lightDir_36;
  lightDir_36 = _WorldSpaceLightPos0.xyz;
  lowp vec4 c_37;
  highp float lightIntensity_38;
  mediump float tmpvar_39;
  tmpvar_39 = (_LightColor0.w * (((dot (xlv_TEXCOORD2, lightDir_36) - 0.01) / 0.99) * 4.0));
  lightIntensity_38 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (tmpvar_3 * (1.0 - clamp (lightIntensity_38, 0.0, 1.0)));
  c_37.w = tmpvar_40;
  c_37.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_35 = c_37;
  c_1 = tmpvar_35;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 401
struct Input {
    highp float viewDist;
    highp vec3 nrm;
};
#line 458
struct v2f_surf {
    highp vec4 pos;
    highp float cust_viewDist;
    highp vec3 cust_nrm;
    lowp vec3 normal;
    lowp vec3 vlight;
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
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 393
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 397
uniform highp float _SwapFadeDist;
uniform highp float _SwapFadeScale;
uniform highp float _Opacity;
uniform lowp vec4 _Color;
#line 407
#line 419
#line 428
#line 467
#line 419
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 423
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float dist = abs((distance( origin, vertexPos) - distance( origin, _WorldSpaceCameraPos)));
    o.viewDist = dist;
    o.nrm = (-normalize(v.vertex.xyz));
}
#line 467
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 471
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_nrm = customInputData.nrm;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 475
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    #line 479
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_nrm);
    xlv_TEXCOORD2 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 401
struct Input {
    highp float viewDist;
    highp vec3 nrm;
};
#line 458
struct v2f_surf {
    highp vec4 pos;
    highp float cust_viewDist;
    highp vec3 cust_nrm;
    lowp vec3 normal;
    lowp vec3 vlight;
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
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 393
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 397
uniform highp float _SwapFadeDist;
uniform highp float _SwapFadeScale;
uniform highp float _Opacity;
uniform lowp vec4 _Color;
#line 407
#line 419
#line 428
#line 467
#line 407
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 411
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 4.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 415
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
#line 428
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 432
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 436
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 439
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 441
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( nrm.x, nrm.z)));
    uv.y = (0.31831 * acos(nrm.y));
    #line 445
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    #line 449
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    #line 453
    main = (main * detail);
    highp float distAlpha = xll_saturate_f((_FadeScale * (IN.viewDist - _FadeDist)));
    o.Alpha = (_Opacity * min( main.w, distAlpha));
    o.Emission = main.xyz;
}
#line 481
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 483
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.nrm = IN.cust_nrm;
    SurfaceOutput o;
    #line 487
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 491
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = 1.0;
    #line 495
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 499
    return c;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.normal = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform vec4 unity_Scale;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_2;
  p_2 = (tmpvar_1 - (_Object2World * gl_Vertex).xyz);
  vec3 p_3;
  p_3 = (tmpvar_1 - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = abs((sqrt(dot (p_2, p_2)) - sqrt(dot (p_3, p_3))));
  xlv_TEXCOORD1 = -(normalize(gl_Vertex.xyz));
  xlv_TEXCOORD2 = (tmpvar_5 * (gl_Normal * unity_Scale.w));
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = o_6;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform vec4 _Color;
uniform float _Opacity;
uniform float _FadeScale;
uniform float _FadeDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec2 uv_2;
  float r_3;
  if ((abs(xlv_TEXCOORD1.z) > (1e-08 * abs(xlv_TEXCOORD1.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD1.x / xlv_TEXCOORD1.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD1.z < 0.0)) {
      if ((xlv_TEXCOORD1.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD1.x) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_3));
  uv_2.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.y))) * (1.5708 + (abs(xlv_TEXCOORD1.y) * (-0.214602 + (abs(xlv_TEXCOORD1.y) * (0.0865667 + (abs(xlv_TEXCOORD1.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD1.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD1.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD1);
  vec4 tmpvar_16;
  tmpvar_16 = ((texture2DGradARB (_MainTex, uv_2, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy));
  vec4 c_17;
  c_17.w = ((_Opacity * min (tmpvar_16.w, clamp ((_FadeScale * (xlv_TEXCOORD0 - _FadeDist)), 0.0, 1.0))) * (1.0 - clamp ((_LightColor0.w * ((((dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz) - 0.01) / 0.99) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x) * 4.0)), 0.0, 1.0)));
  c_17.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = c_17.w;
  c_1.xyz = tmpvar_16.xyz;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Matrix 4 [_Object2World]
Vector 11 [unity_Scale]
"vs_3_0
; 34 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c12, 0.50000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r2.xyz, -r1, c8
dp3 r0.w, r2, r2
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
add r0.xyz, r0, -r1
dp3 r0.x, r0, r0
rsq r0.y, r0.w
rsq r0.x, r0.x
dp4 r0.w, v0, c3
rcp r0.y, r0.y
rcp r0.x, r0.x
add r0.z, r0.x, -r0.y
abs o1.x, r0.z
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c9.x
mad o5.xy, r1.z, c10.zwzw, r1
dp3 r1.x, v0, v0
mov o0, r0
rsq r0.x, r1.x
mul r1.xyz, v1, c11.w
mov o5.zw, r0
mul r0.xyz, r0.x, v0
mov o2.xyz, -r0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
mov o4.xyz, c12.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 30 instructions, 3 temp regs, 0 temp arrays:
// ALU 25 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednfnpmjiogfpcgfjeflnafhdoahnafpnpabaaaaaaomafaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaoabaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcdiaeaaaaeaaaabaaaoabaaaafjaaaaae
egiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
giaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaiaebaaaaaa
abaaaaaaegiccaaaabaaaaaaapaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaakocaabaaaabaaaaaaagijcaiaebaaaaaa
aaaaaaaaaeaaaaaaagijcaaaabaaaaaaapaaaaaabaaaaaahccaabaaaabaaaaaa
jgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaa
abaaaaaaaaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaakaabaaa
abaaaaaadgaaaaagbccabaaaabaaaaaaakaabaiaibaaaaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaa
egbcbaaaaaaaaaaadgaaaaagoccabaaaabaaaaaaagajbaiaebaaaaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaa
diaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaaklcaabaaaabaaaaaaegiicaaaabaaaaaaamaaaaaaagaabaaaabaaaaaa
egaibaaaacaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaaihccabaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
aeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - (_Object2World * _glesVertex).xyz);
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = abs((sqrt(dot (p_3, p_3)) - sqrt(dot (p_4, p_4))));
  xlv_TEXCOORD1 = -(normalize(_glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _Opacity;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.z) > (1e-08 * abs(xlv_TEXCOORD1.x)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.x / xlv_TEXCOORD1.z);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.z < 0.0)) {
      if ((xlv_TEXCOORD1.x >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.x) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  uv_9.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.y))) * (1.5708 + (abs(xlv_TEXCOORD1.y) * (-0.214602 + (abs(xlv_TEXCOORD1.y) * (0.0865667 + (abs(xlv_TEXCOORD1.y) * -0.0310296)))))))))));
  highp float r_14;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_18;
  tmpvar_18 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_7 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_6 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_5 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_5, detailX_7, tmpvar_29.xxxx);
  detail_4 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_4, detailY_6, tmpvar_29.yyyy);
  detail_4 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_8 * detail_4);
  main_8 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (_Opacity * min (tmpvar_32.w, clamp ((_FadeScale * (xlv_TEXCOORD0 - _FadeDist)), 0.0, 1.0)));
  tmpvar_3 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_32.xyz;
  tmpvar_2 = tmpvar_34;
  lowp float tmpvar_35;
  mediump float lightShadowDataX_36;
  highp float dist_37;
  lowp float tmpvar_38;
  tmpvar_38 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_37 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = _LightShadowData.x;
  lightShadowDataX_36 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = max (float((dist_37 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_36);
  tmpvar_35 = tmpvar_40;
  mediump vec4 tmpvar_41;
  mediump vec3 lightDir_42;
  lightDir_42 = _WorldSpaceLightPos0.xyz;
  mediump float atten_43;
  atten_43 = tmpvar_35;
  lowp vec4 c_44;
  highp float lightIntensity_45;
  mediump float tmpvar_46;
  tmpvar_46 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_42) - 0.01) / 0.99) * atten_43) * 4.0));
  lightIntensity_45 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (tmpvar_3 * (1.0 - clamp (lightIntensity_45, 0.0, 1.0)));
  c_44.w = tmpvar_47;
  c_44.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_41 = c_44;
  c_1 = tmpvar_41;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - (_Object2World * _glesVertex).xyz);
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_7;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_5.zw;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = abs((sqrt(dot (p_3, p_3)) - sqrt(dot (p_4, p_4))));
  xlv_TEXCOORD1 = -(normalize(_glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = o_8;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _Opacity;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.z) > (1e-08 * abs(xlv_TEXCOORD1.x)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.x / xlv_TEXCOORD1.z);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.z < 0.0)) {
      if ((xlv_TEXCOORD1.x >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.x) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  uv_9.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.y))) * (1.5708 + (abs(xlv_TEXCOORD1.y) * (-0.214602 + (abs(xlv_TEXCOORD1.y) * (0.0865667 + (abs(xlv_TEXCOORD1.y) * -0.0310296)))))))))));
  highp float r_14;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_18;
  tmpvar_18 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_7 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_6 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_5 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_5, detailX_7, tmpvar_29.xxxx);
  detail_4 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_4, detailY_6, tmpvar_29.yyyy);
  detail_4 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_8 * detail_4);
  main_8 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (_Opacity * min (tmpvar_32.w, clamp ((_FadeScale * (xlv_TEXCOORD0 - _FadeDist)), 0.0, 1.0)));
  tmpvar_3 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_32.xyz;
  tmpvar_2 = tmpvar_34;
  lowp float tmpvar_35;
  tmpvar_35 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  mediump vec4 tmpvar_36;
  mediump vec3 lightDir_37;
  lightDir_37 = _WorldSpaceLightPos0.xyz;
  mediump float atten_38;
  atten_38 = tmpvar_35;
  lowp vec4 c_39;
  highp float lightIntensity_40;
  mediump float tmpvar_41;
  tmpvar_41 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_37) - 0.01) / 0.99) * atten_38) * 4.0));
  lightIntensity_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (tmpvar_3 * (1.0 - clamp (lightIntensity_40, 0.0, 1.0)));
  c_39.w = tmpvar_42;
  c_39.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_36 = c_39;
  c_1 = tmpvar_36;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 409
struct Input {
    highp float viewDist;
    highp vec3 nrm;
};
#line 466
struct v2f_surf {
    highp vec4 pos;
    highp float cust_viewDist;
    highp vec3 cust_nrm;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
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
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 405
uniform highp float _SwapFadeDist;
uniform highp float _SwapFadeScale;
uniform highp float _Opacity;
uniform lowp vec4 _Color;
#line 415
#line 427
#line 436
#line 476
#line 427
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 431
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float dist = abs((distance( origin, vertexPos) - distance( origin, _WorldSpaceCameraPos)));
    o.viewDist = dist;
    o.nrm = (-normalize(v.vertex.xyz));
}
#line 476
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 480
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_nrm = customInputData.nrm;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 484
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 489
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_nrm);
    xlv_TEXCOORD2 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 409
struct Input {
    highp float viewDist;
    highp vec3 nrm;
};
#line 466
struct v2f_surf {
    highp vec4 pos;
    highp float cust_viewDist;
    highp vec3 cust_nrm;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
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
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 405
uniform highp float _SwapFadeDist;
uniform highp float _SwapFadeScale;
uniform highp float _Opacity;
uniform lowp vec4 _Color;
#line 415
#line 427
#line 436
#line 476
#line 415
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 419
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 4.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 423
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
#line 436
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 440
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 444
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 447
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 449
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( nrm.x, nrm.z)));
    uv.y = (0.31831 * acos(nrm.y));
    #line 453
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    #line 457
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    #line 461
    main = (main * detail);
    highp float distAlpha = xll_saturate_f((_FadeScale * (IN.viewDist - _FadeDist)));
    o.Alpha = (_Opacity * min( main.w, distAlpha));
    o.Emission = main.xyz;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 491
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 493
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.nrm = IN.cust_nrm;
    SurfaceOutput o;
    #line 497
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 501
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 505
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 509
    return c;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.normal = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform vec4 unity_Scale;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_2;
  p_2 = (tmpvar_1 - (_Object2World * gl_Vertex).xyz);
  vec3 p_3;
  p_3 = (tmpvar_1 - _WorldSpaceCameraPos);
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = abs((sqrt(dot (p_2, p_2)) - sqrt(dot (p_3, p_3))));
  xlv_TEXCOORD1 = -(normalize(gl_Vertex.xyz));
  xlv_TEXCOORD2 = (tmpvar_4 * (gl_Normal * unity_Scale.w));
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform vec4 _Color;
uniform float _Opacity;
uniform float _FadeScale;
uniform float _FadeDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec2 uv_2;
  float r_3;
  if ((abs(xlv_TEXCOORD1.z) > (1e-08 * abs(xlv_TEXCOORD1.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD1.x / xlv_TEXCOORD1.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD1.z < 0.0)) {
      if ((xlv_TEXCOORD1.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD1.x) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_3));
  uv_2.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.y))) * (1.5708 + (abs(xlv_TEXCOORD1.y) * (-0.214602 + (abs(xlv_TEXCOORD1.y) * (0.0865667 + (abs(xlv_TEXCOORD1.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD1.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD1.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD1);
  vec4 tmpvar_16;
  tmpvar_16 = ((texture2DGradARB (_MainTex, uv_2, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy));
  vec4 c_17;
  c_17.w = ((_Opacity * min (tmpvar_16.w, clamp ((_FadeScale * (xlv_TEXCOORD0 - _FadeDist)), 0.0, 1.0))) * (1.0 - clamp ((_LightColor0.w * (((dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz) - 0.01) / 0.99) * 4.0)), 0.0, 1.0)));
  c_17.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = c_17.w;
  c_1.xyz = tmpvar_16.xyz;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Vector 9 [unity_Scale]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c10, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
add r1.xyz, r1, -r0
add r0.xyz, -r0, c8
dp3 r0.y, r0, r0
dp3 r0.w, r1, r1
mul r1.xyz, v1, c9.w
rsq r0.x, r0.w
rsq r0.y, r0.y
rcp r0.y, r0.y
rcp r0.x, r0.x
add r0.x, r0, -r0.y
dp3 r0.z, v0, v0
rsq r0.y, r0.z
abs o1.x, r0
mul r0.xyz, r0.y, v0
mov o2.xyz, -r0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
mov o4.xyz, c10.x
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhifkmapocbmlcmllmpppfdpngpahjnkiabaaaaaadmafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaoabaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckaadaaaaeaaaabaa
oiaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaadoccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakocaabaaaaaaaaaaa
agijcaiaebaaaaaaaaaaaaaaaeaaaaaaagijcaaaabaaaaaaapaaaaaabaaaaaah
ccaabaaaaaaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaelaaaaafdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaagbccabaaaabaaaaaaakaabaiaibaaaaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegbcbaaaaaaaaaaadgaaaaagoccabaaaabaaaaaaagajbaia
ebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
abaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaabaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
abaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaihccabaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - (_Object2World * _glesVertex).xyz);
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = abs((sqrt(dot (p_3, p_3)) - sqrt(dot (p_4, p_4))));
  xlv_TEXCOORD1 = -(normalize(_glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _Opacity;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.z) > (1e-08 * abs(xlv_TEXCOORD1.x)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.x / xlv_TEXCOORD1.z);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.z < 0.0)) {
      if ((xlv_TEXCOORD1.x >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.x) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  uv_9.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.y))) * (1.5708 + (abs(xlv_TEXCOORD1.y) * (-0.214602 + (abs(xlv_TEXCOORD1.y) * (0.0865667 + (abs(xlv_TEXCOORD1.y) * -0.0310296)))))))))));
  highp float r_14;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_18;
  tmpvar_18 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_7 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_6 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_5 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_5, detailX_7, tmpvar_29.xxxx);
  detail_4 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_4, detailY_6, tmpvar_29.yyyy);
  detail_4 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_8 * detail_4);
  main_8 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (_Opacity * min (tmpvar_32.w, clamp ((_FadeScale * (xlv_TEXCOORD0 - _FadeDist)), 0.0, 1.0)));
  tmpvar_3 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_32.xyz;
  tmpvar_2 = tmpvar_34;
  mediump vec4 tmpvar_35;
  mediump vec3 lightDir_36;
  lightDir_36 = _WorldSpaceLightPos0.xyz;
  lowp vec4 c_37;
  highp float lightIntensity_38;
  mediump float tmpvar_39;
  tmpvar_39 = (_LightColor0.w * (((dot (xlv_TEXCOORD2, lightDir_36) - 0.01) / 0.99) * 4.0));
  lightIntensity_38 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (tmpvar_3 * (1.0 - clamp (lightIntensity_38, 0.0, 1.0)));
  c_37.w = tmpvar_40;
  c_37.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_35 = c_37;
  c_1 = tmpvar_35;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - (_Object2World * _glesVertex).xyz);
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = abs((sqrt(dot (p_3, p_3)) - sqrt(dot (p_4, p_4))));
  xlv_TEXCOORD1 = -(normalize(_glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _Opacity;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.z) > (1e-08 * abs(xlv_TEXCOORD1.x)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.x / xlv_TEXCOORD1.z);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.z < 0.0)) {
      if ((xlv_TEXCOORD1.x >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.x) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  uv_9.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.y))) * (1.5708 + (abs(xlv_TEXCOORD1.y) * (-0.214602 + (abs(xlv_TEXCOORD1.y) * (0.0865667 + (abs(xlv_TEXCOORD1.y) * -0.0310296)))))))))));
  highp float r_14;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_18;
  tmpvar_18 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_7 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_6 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_5 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_5, detailX_7, tmpvar_29.xxxx);
  detail_4 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_4, detailY_6, tmpvar_29.yyyy);
  detail_4 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_8 * detail_4);
  main_8 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (_Opacity * min (tmpvar_32.w, clamp ((_FadeScale * (xlv_TEXCOORD0 - _FadeDist)), 0.0, 1.0)));
  tmpvar_3 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_32.xyz;
  tmpvar_2 = tmpvar_34;
  mediump vec4 tmpvar_35;
  mediump vec3 lightDir_36;
  lightDir_36 = _WorldSpaceLightPos0.xyz;
  lowp vec4 c_37;
  highp float lightIntensity_38;
  mediump float tmpvar_39;
  tmpvar_39 = (_LightColor0.w * (((dot (xlv_TEXCOORD2, lightDir_36) - 0.01) / 0.99) * 4.0));
  lightIntensity_38 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (tmpvar_3 * (1.0 - clamp (lightIntensity_38, 0.0, 1.0)));
  c_37.w = tmpvar_40;
  c_37.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_35 = c_37;
  c_1 = tmpvar_35;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 401
struct Input {
    highp float viewDist;
    highp vec3 nrm;
};
#line 458
struct v2f_surf {
    highp vec4 pos;
    highp float cust_viewDist;
    highp vec3 cust_nrm;
    lowp vec3 normal;
    lowp vec3 vlight;
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
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 393
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 397
uniform highp float _SwapFadeDist;
uniform highp float _SwapFadeScale;
uniform highp float _Opacity;
uniform lowp vec4 _Color;
#line 407
#line 419
#line 428
#line 467
#line 419
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 423
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float dist = abs((distance( origin, vertexPos) - distance( origin, _WorldSpaceCameraPos)));
    o.viewDist = dist;
    o.nrm = (-normalize(v.vertex.xyz));
}
#line 467
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 471
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_nrm = customInputData.nrm;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 475
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    #line 479
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_nrm);
    xlv_TEXCOORD2 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 401
struct Input {
    highp float viewDist;
    highp vec3 nrm;
};
#line 458
struct v2f_surf {
    highp vec4 pos;
    highp float cust_viewDist;
    highp vec3 cust_nrm;
    lowp vec3 normal;
    lowp vec3 vlight;
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
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 393
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 397
uniform highp float _SwapFadeDist;
uniform highp float _SwapFadeScale;
uniform highp float _Opacity;
uniform lowp vec4 _Color;
#line 407
#line 419
#line 428
#line 467
#line 407
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 411
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 4.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 415
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
#line 428
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 432
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 436
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 439
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 441
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( nrm.x, nrm.z)));
    uv.y = (0.31831 * acos(nrm.y));
    #line 445
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    #line 449
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    #line 453
    main = (main * detail);
    highp float distAlpha = xll_saturate_f((_FadeScale * (IN.viewDist - _FadeDist)));
    o.Alpha = (_Opacity * min( main.w, distAlpha));
    o.Emission = main.xyz;
}
#line 481
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 483
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.nrm = IN.cust_nrm;
    SurfaceOutput o;
    #line 487
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 491
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = 1.0;
    #line 495
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 499
    return c;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.normal = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform vec4 unity_Scale;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_2;
  p_2 = (tmpvar_1 - (_Object2World * gl_Vertex).xyz);
  vec3 p_3;
  p_3 = (tmpvar_1 - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = abs((sqrt(dot (p_2, p_2)) - sqrt(dot (p_3, p_3))));
  xlv_TEXCOORD1 = -(normalize(gl_Vertex.xyz));
  xlv_TEXCOORD2 = (tmpvar_5 * (gl_Normal * unity_Scale.w));
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = o_6;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform vec4 _Color;
uniform float _Opacity;
uniform float _FadeScale;
uniform float _FadeDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec2 uv_2;
  float r_3;
  if ((abs(xlv_TEXCOORD1.z) > (1e-08 * abs(xlv_TEXCOORD1.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD1.x / xlv_TEXCOORD1.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD1.z < 0.0)) {
      if ((xlv_TEXCOORD1.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD1.x) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_3));
  uv_2.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.y))) * (1.5708 + (abs(xlv_TEXCOORD1.y) * (-0.214602 + (abs(xlv_TEXCOORD1.y) * (0.0865667 + (abs(xlv_TEXCOORD1.y) * -0.0310296)))))))))));
  float r_7;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    float y_over_x_8;
    y_over_x_8 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  float tmpvar_11;
  tmpvar_11 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  vec2 tmpvar_12;
  tmpvar_12 = dFdx(xlv_TEXCOORD1.xy);
  vec2 tmpvar_13;
  tmpvar_13 = dFdy(xlv_TEXCOORD1.xy);
  vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(tmpvar_11);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(tmpvar_11);
  vec3 tmpvar_15;
  tmpvar_15 = abs(xlv_TEXCOORD1);
  vec4 tmpvar_16;
  tmpvar_16 = ((texture2DGradARB (_MainTex, uv_2, tmpvar_14.xy, tmpvar_14.zw) * _Color) * mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_15.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_15.yyyy));
  vec4 c_17;
  c_17.w = ((_Opacity * min (tmpvar_16.w, clamp ((_FadeScale * (xlv_TEXCOORD0 - _FadeDist)), 0.0, 1.0))) * (1.0 - clamp ((_LightColor0.w * ((((dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz) - 0.01) / 0.99) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x) * 4.0)), 0.0, 1.0)));
  c_17.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = c_17.w;
  c_1.xyz = tmpvar_16.xyz;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Matrix 4 [_Object2World]
Vector 11 [unity_Scale]
"vs_3_0
; 34 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c12, 0.50000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r2.xyz, -r1, c8
dp3 r0.w, r2, r2
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
add r0.xyz, r0, -r1
dp3 r0.x, r0, r0
rsq r0.y, r0.w
rsq r0.x, r0.x
dp4 r0.w, v0, c3
rcp r0.y, r0.y
rcp r0.x, r0.x
add r0.z, r0.x, -r0.y
abs o1.x, r0.z
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c9.x
mad o5.xy, r1.z, c10.zwzw, r1
dp3 r1.x, v0, v0
mov o0, r0
rsq r0.x, r1.x
mul r1.xyz, v1, c11.w
mov o5.zw, r0
mul r0.xyz, r0.x, v0
mov o2.xyz, -r0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
mov o4.xyz, c12.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 30 instructions, 3 temp regs, 0 temp arrays:
// ALU 25 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednfnpmjiogfpcgfjeflnafhdoahnafpnpabaaaaaaomafaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaoabaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcdiaeaaaaeaaaabaaaoabaaaafjaaaaae
egiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
giaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaiaebaaaaaa
abaaaaaaegiccaaaabaaaaaaapaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaakocaabaaaabaaaaaaagijcaiaebaaaaaa
aaaaaaaaaeaaaaaaagijcaaaabaaaaaaapaaaaaabaaaaaahccaabaaaabaaaaaa
jgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaa
abaaaaaaaaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaakaabaaa
abaaaaaadgaaaaagbccabaaaabaaaaaaakaabaiaibaaaaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaa
egbcbaaaaaaaaaaadgaaaaagoccabaaaabaaaaaaagajbaiaebaaaaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaa
diaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaaklcaabaaaabaaaaaaegiicaaaabaaaaaaamaaaaaaagaabaaaabaaaaaa
egaibaaaacaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaaihccabaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
aeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - (_Object2World * _glesVertex).xyz);
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = abs((sqrt(dot (p_3, p_3)) - sqrt(dot (p_4, p_4))));
  xlv_TEXCOORD1 = -(normalize(_glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _Opacity;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.z) > (1e-08 * abs(xlv_TEXCOORD1.x)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.x / xlv_TEXCOORD1.z);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.z < 0.0)) {
      if ((xlv_TEXCOORD1.x >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.x) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  uv_9.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.y))) * (1.5708 + (abs(xlv_TEXCOORD1.y) * (-0.214602 + (abs(xlv_TEXCOORD1.y) * (0.0865667 + (abs(xlv_TEXCOORD1.y) * -0.0310296)))))))))));
  highp float r_14;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_18;
  tmpvar_18 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_7 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_6 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_5 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_5, detailX_7, tmpvar_29.xxxx);
  detail_4 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_4, detailY_6, tmpvar_29.yyyy);
  detail_4 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_8 * detail_4);
  main_8 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (_Opacity * min (tmpvar_32.w, clamp ((_FadeScale * (xlv_TEXCOORD0 - _FadeDist)), 0.0, 1.0)));
  tmpvar_3 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_32.xyz;
  tmpvar_2 = tmpvar_34;
  lowp float tmpvar_35;
  mediump float lightShadowDataX_36;
  highp float dist_37;
  lowp float tmpvar_38;
  tmpvar_38 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_37 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = _LightShadowData.x;
  lightShadowDataX_36 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = max (float((dist_37 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_36);
  tmpvar_35 = tmpvar_40;
  mediump vec4 tmpvar_41;
  mediump vec3 lightDir_42;
  lightDir_42 = _WorldSpaceLightPos0.xyz;
  mediump float atten_43;
  atten_43 = tmpvar_35;
  lowp vec4 c_44;
  highp float lightIntensity_45;
  mediump float tmpvar_46;
  tmpvar_46 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_42) - 0.01) / 0.99) * atten_43) * 4.0));
  lightIntensity_45 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (tmpvar_3 * (1.0 - clamp (lightIntensity_45, 0.0, 1.0)));
  c_44.w = tmpvar_47;
  c_44.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_41 = c_44;
  c_1 = tmpvar_41;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - (_Object2World * _glesVertex).xyz);
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_7;
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_5.zw;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = abs((sqrt(dot (p_3, p_3)) - sqrt(dot (p_4, p_4))));
  xlv_TEXCOORD1 = -(normalize(_glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = o_8;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _Opacity;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.z) > (1e-08 * abs(xlv_TEXCOORD1.x)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.x / xlv_TEXCOORD1.z);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.z < 0.0)) {
      if ((xlv_TEXCOORD1.x >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.x) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  uv_9.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.y))) * (1.5708 + (abs(xlv_TEXCOORD1.y) * (-0.214602 + (abs(xlv_TEXCOORD1.y) * (0.0865667 + (abs(xlv_TEXCOORD1.y) * -0.0310296)))))))))));
  highp float r_14;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_18;
  tmpvar_18 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_7 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_6 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_5 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_5, detailX_7, tmpvar_29.xxxx);
  detail_4 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_4, detailY_6, tmpvar_29.yyyy);
  detail_4 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_8 * detail_4);
  main_8 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (_Opacity * min (tmpvar_32.w, clamp ((_FadeScale * (xlv_TEXCOORD0 - _FadeDist)), 0.0, 1.0)));
  tmpvar_3 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_32.xyz;
  tmpvar_2 = tmpvar_34;
  lowp float tmpvar_35;
  tmpvar_35 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  mediump vec4 tmpvar_36;
  mediump vec3 lightDir_37;
  lightDir_37 = _WorldSpaceLightPos0.xyz;
  mediump float atten_38;
  atten_38 = tmpvar_35;
  lowp vec4 c_39;
  highp float lightIntensity_40;
  mediump float tmpvar_41;
  tmpvar_41 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_37) - 0.01) / 0.99) * atten_38) * 4.0));
  lightIntensity_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (tmpvar_3 * (1.0 - clamp (lightIntensity_40, 0.0, 1.0)));
  c_39.w = tmpvar_42;
  c_39.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_36 = c_39;
  c_1 = tmpvar_36;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 409
struct Input {
    highp float viewDist;
    highp vec3 nrm;
};
#line 466
struct v2f_surf {
    highp vec4 pos;
    highp float cust_viewDist;
    highp vec3 cust_nrm;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
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
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 405
uniform highp float _SwapFadeDist;
uniform highp float _SwapFadeScale;
uniform highp float _Opacity;
uniform lowp vec4 _Color;
#line 415
#line 427
#line 436
#line 476
#line 427
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 431
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float dist = abs((distance( origin, vertexPos) - distance( origin, _WorldSpaceCameraPos)));
    o.viewDist = dist;
    o.nrm = (-normalize(v.vertex.xyz));
}
#line 476
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 480
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_nrm = customInputData.nrm;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 484
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 489
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_nrm);
    xlv_TEXCOORD2 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 409
struct Input {
    highp float viewDist;
    highp vec3 nrm;
};
#line 466
struct v2f_surf {
    highp vec4 pos;
    highp float cust_viewDist;
    highp vec3 cust_nrm;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
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
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 405
uniform highp float _SwapFadeDist;
uniform highp float _SwapFadeScale;
uniform highp float _Opacity;
uniform lowp vec4 _Color;
#line 415
#line 427
#line 436
#line 476
#line 415
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 419
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 4.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 423
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
#line 436
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 440
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 444
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 447
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 449
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( nrm.x, nrm.z)));
    uv.y = (0.31831 * acos(nrm.y));
    #line 453
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    #line 457
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    #line 461
    main = (main * detail);
    highp float distAlpha = xll_saturate_f((_FadeScale * (IN.viewDist - _FadeDist)));
    o.Alpha = (_Opacity * min( main.w, distAlpha));
    o.Emission = main.xyz;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 491
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 493
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.nrm = IN.cust_nrm;
    SurfaceOutput o;
    #line 497
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 501
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 505
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 509
    return c;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.normal = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - (_Object2World * _glesVertex).xyz);
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = abs((sqrt(dot (p_3, p_3)) - sqrt(dot (p_4, p_4))));
  xlv_TEXCOORD1 = -(normalize(_glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _Opacity;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.z) > (1e-08 * abs(xlv_TEXCOORD1.x)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.x / xlv_TEXCOORD1.z);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.z < 0.0)) {
      if ((xlv_TEXCOORD1.x >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.x) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  uv_9.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.y))) * (1.5708 + (abs(xlv_TEXCOORD1.y) * (-0.214602 + (abs(xlv_TEXCOORD1.y) * (0.0865667 + (abs(xlv_TEXCOORD1.y) * -0.0310296)))))))))));
  highp float r_14;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_18;
  tmpvar_18 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_7 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_6 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_5 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_5, detailX_7, tmpvar_29.xxxx);
  detail_4 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_4, detailY_6, tmpvar_29.yyyy);
  detail_4 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_8 * detail_4);
  main_8 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (_Opacity * min (tmpvar_32.w, clamp ((_FadeScale * (xlv_TEXCOORD0 - _FadeDist)), 0.0, 1.0)));
  tmpvar_3 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_32.xyz;
  tmpvar_2 = tmpvar_34;
  lowp float shadow_35;
  lowp float tmpvar_36;
  tmpvar_36 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_37;
  tmpvar_37 = (_LightShadowData.x + (tmpvar_36 * (1.0 - _LightShadowData.x)));
  shadow_35 = tmpvar_37;
  mediump vec4 tmpvar_38;
  mediump vec3 lightDir_39;
  lightDir_39 = _WorldSpaceLightPos0.xyz;
  mediump float atten_40;
  atten_40 = shadow_35;
  lowp vec4 c_41;
  highp float lightIntensity_42;
  mediump float tmpvar_43;
  tmpvar_43 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_39) - 0.01) / 0.99) * atten_40) * 4.0));
  lightIntensity_42 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (tmpvar_3 * (1.0 - clamp (lightIntensity_42, 0.0, 1.0)));
  c_41.w = tmpvar_44;
  c_41.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_38 = c_41;
  c_1 = tmpvar_38;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 409
struct Input {
    highp float viewDist;
    highp vec3 nrm;
};
#line 466
struct v2f_surf {
    highp vec4 pos;
    highp float cust_viewDist;
    highp vec3 cust_nrm;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
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
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 405
uniform highp float _SwapFadeDist;
uniform highp float _SwapFadeScale;
uniform highp float _Opacity;
uniform lowp vec4 _Color;
#line 415
#line 427
#line 436
#line 476
#line 427
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 431
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float dist = abs((distance( origin, vertexPos) - distance( origin, _WorldSpaceCameraPos)));
    o.viewDist = dist;
    o.nrm = (-normalize(v.vertex.xyz));
}
#line 476
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 480
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_nrm = customInputData.nrm;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 484
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 489
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_nrm);
    xlv_TEXCOORD2 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 409
struct Input {
    highp float viewDist;
    highp vec3 nrm;
};
#line 466
struct v2f_surf {
    highp vec4 pos;
    highp float cust_viewDist;
    highp vec3 cust_nrm;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
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
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 405
uniform highp float _SwapFadeDist;
uniform highp float _SwapFadeScale;
uniform highp float _Opacity;
uniform lowp vec4 _Color;
#line 415
#line 427
#line 436
#line 476
#line 415
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 419
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 4.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 423
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
#line 436
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 440
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 444
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 447
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 449
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( nrm.x, nrm.z)));
    uv.y = (0.31831 * acos(nrm.y));
    #line 453
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    #line 457
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    #line 461
    main = (main * detail);
    highp float distAlpha = xll_saturate_f((_FadeScale * (IN.viewDist - _FadeDist)));
    o.Alpha = (_Opacity * min( main.w, distAlpha));
    o.Emission = main.xyz;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 491
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 493
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.nrm = IN.cust_nrm;
    SurfaceOutput o;
    #line 497
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 501
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 505
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 509
    return c;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.normal = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_2 - (_Object2World * _glesVertex).xyz);
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = abs((sqrt(dot (p_3, p_3)) - sqrt(dot (p_4, p_4))));
  xlv_TEXCOORD1 = -(normalize(_glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _Opacity;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.z) > (1e-08 * abs(xlv_TEXCOORD1.x)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.x / xlv_TEXCOORD1.z);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.z < 0.0)) {
      if ((xlv_TEXCOORD1.x >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.x) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  uv_9.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.y))) * (1.5708 + (abs(xlv_TEXCOORD1.y) * (-0.214602 + (abs(xlv_TEXCOORD1.y) * (0.0865667 + (abs(xlv_TEXCOORD1.y) * -0.0310296)))))))))));
  highp float r_14;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_15;
    y_over_x_15 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_16;
    highp float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_18;
  tmpvar_18 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(tmpvar_18);
  tmpvar_21.z = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(tmpvar_18);
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_21.xy, tmpvar_21.zw) * _Color);
  main_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_7 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_6 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_5 = tmpvar_27;
  highp vec3 tmpvar_29;
  tmpvar_29 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detailZ_5, detailX_7, tmpvar_29.xxxx);
  detail_4 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detail_4, detailY_6, tmpvar_29.yyyy);
  detail_4 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_8 * detail_4);
  main_8 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (_Opacity * min (tmpvar_32.w, clamp ((_FadeScale * (xlv_TEXCOORD0 - _FadeDist)), 0.0, 1.0)));
  tmpvar_3 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_32.xyz;
  tmpvar_2 = tmpvar_34;
  lowp float shadow_35;
  lowp float tmpvar_36;
  tmpvar_36 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_37;
  tmpvar_37 = (_LightShadowData.x + (tmpvar_36 * (1.0 - _LightShadowData.x)));
  shadow_35 = tmpvar_37;
  mediump vec4 tmpvar_38;
  mediump vec3 lightDir_39;
  lightDir_39 = _WorldSpaceLightPos0.xyz;
  mediump float atten_40;
  atten_40 = shadow_35;
  lowp vec4 c_41;
  highp float lightIntensity_42;
  mediump float tmpvar_43;
  tmpvar_43 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_39) - 0.01) / 0.99) * atten_40) * 4.0));
  lightIntensity_42 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (tmpvar_3 * (1.0 - clamp (lightIntensity_42, 0.0, 1.0)));
  c_41.w = tmpvar_44;
  c_41.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_38 = c_41;
  c_1 = tmpvar_38;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 409
struct Input {
    highp float viewDist;
    highp vec3 nrm;
};
#line 466
struct v2f_surf {
    highp vec4 pos;
    highp float cust_viewDist;
    highp vec3 cust_nrm;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
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
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 405
uniform highp float _SwapFadeDist;
uniform highp float _SwapFadeScale;
uniform highp float _Opacity;
uniform lowp vec4 _Color;
#line 415
#line 427
#line 436
#line 476
#line 427
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 431
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float dist = abs((distance( origin, vertexPos) - distance( origin, _WorldSpaceCameraPos)));
    o.viewDist = dist;
    o.nrm = (-normalize(v.vertex.xyz));
}
#line 476
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 480
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_nrm = customInputData.nrm;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 484
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 489
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_nrm);
    xlv_TEXCOORD2 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 409
struct Input {
    highp float viewDist;
    highp vec3 nrm;
};
#line 466
struct v2f_surf {
    highp vec4 pos;
    highp float cust_viewDist;
    highp vec3 cust_nrm;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
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
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform highp float _DetailScale;
uniform lowp vec4 _DetailOffset;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 405
uniform highp float _SwapFadeDist;
uniform highp float _SwapFadeScale;
uniform highp float _Opacity;
uniform lowp vec4 _Color;
#line 415
#line 427
#line 436
#line 476
#line 415
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 419
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 4.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 423
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
#line 436
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 440
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 444
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 447
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 449
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( nrm.x, nrm.z)));
    uv.y = (0.31831 * acos(nrm.y));
    #line 453
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    #line 457
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    #line 461
    main = (main * detail);
    highp float distAlpha = xll_saturate_f((_FadeScale * (IN.viewDist - _FadeDist)));
    o.Alpha = (_Opacity * min( main.w, distAlpha));
    o.Emission = main.xyz;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 491
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 493
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.nrm = IN.cust_nrm;
    SurfaceOutput o;
    #line 497
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 501
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 505
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 509
    return c;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.normal = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 2
//   d3d9 - ALU: 86 to 87, TEX: 6 to 7
//   d3d11 - ALU: 61 to 64, TEX: 3 to 4, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_DetailScale]
Vector 3 [_DetailOffset]
Float 4 [_FadeDist]
Float 5 [_FadeScale]
Float 6 [_Opacity]
Vector 7 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 86 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dsy r4.xy, v1
abs r3.y, v1.z
abs r4.zw, v1.xyxy
max r0.x, r4.z, r3.y
rcp r0.y, r0.x
min r0.x, r4.z, r3.y
mul r0.x, r0, r0.y
mul r0.y, r0.x, r0.x
mad r0.z, r0.y, c10.y, c10
mad r0.z, r0, r0.y, c10.w
mad r0.z, r0, r0.y, c11.x
mad r0.z, r0, r0.y, c11.y
mad r0.y, r0.z, r0, c11.z
mul r2.x, r0.y, r0
mul r0.zw, v1.xyxy, c2.x
add r1.xy, r0.zwzw, c3
mul r0.xy, v1.zyzw, c2.x
add r0.xy, r0, c3
add r2.z, -r2.x, c11.w
add r2.y, r4.z, -r3
cmp r2.x, -r2.y, r2, r2.z
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r4.z, r0, r1
add r0.x, -r2, c9.w
cmp r0.z, v1, r2.x, r0.x
mul r2.zw, v1.xyzx, c2.x
cmp r3.x, v1, r0.z, -r0.z
add r0.xy, r2.zwzw, c3
texld r0, r0, s1
add_pp r2, r0, -r1
abs r0.w, v1.y
add r0.y, -r3, c8
mad r0.x, r3.y, c8.z, c8.w
mad r0.x, r3.y, r0, c9
mad r0.x, r3.y, r0, c9.y
add r3.z, -r0.w, c8.y
mad r3.y, r0.w, c8.z, c8.w
mad r3.y, r3, r0.w, c9.x
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.y, r0.x, r0
cmp r0.x, v1.z, c8, c8.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c9, r0.y
rsq r3.z, r3.z
mad r0.w, r3.y, r0, c9.y
rcp r3.z, r3.z
mul r3.y, r0.w, r3.z
cmp r0.w, v1.y, c8.x, c8.y
mul r3.z, r0.w, r3.y
mad r0.y, -r3.z, c9.z, r3
mad r0.z, r0.x, c9.w, r0
mad r0.x, r0.w, c9.w, r0.y
mul r0.y, r0.z, c10.x
dsx r0.w, r0.y
dsx r3.zw, v1.xyxy
mul r4.xy, r4, r4
add r0.z, r4.x, r4.y
mul r3.y, r0.x, c10.x
mul r3.zw, r3, r3
add r0.x, r3.z, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r0.x, r0.x
rcp r3.z, r0.z
mul r0.z, r0.x, c12.x
mad_pp r1, r4.w, r2, r1
mad r3.x, r3, c12, c12.y
dsy r0.y, r0
mul r0.x, r3.z, c12
texldd r0, r3, s0, r0.zwzw, r0
mul r0, r0, c7
mul_pp r0, r0, r1
mov_pp oC0.xyz, r0
dp3_pp r1.x, v2, c0
add_pp r0.y, r1.x, c12.z
add r0.x, v0, -c4
mul_pp r0.y, r0, c1.w
mul_sat r0.x, r0, c5
mul_pp_sat r0.y, r0, c12.w
min_pp r0.x, r0.w, r0
add r0.y, -r0, c8
mul r0.x, r0, c6
mul oC0.w, r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 128 used size, 11 vars
Vector 16 [_LightColor0] 4
Float 48 [_DetailScale]
Vector 64 [_DetailOffset] 4
Float 80 [_FadeDist]
Float 84 [_FadeScale]
Float 96 [_Opacity]
Vector 112 [_Color] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 68 instructions, 4 temp regs, 0 temp arrays:
// ALU 57 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedciheiklpjacmhpdjjlnbkobidfcbjhdmabaaaaaafeakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcemajaaaaeaaaaaaafdacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadbcbabaaaabaaaaaagcbaaaadocbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
deaaaaajbcaabaaaaaaaaaaadkbabaiaibaaaaaaabaaaaaabkbabaiaibaaaaaa
abaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaadkbabaiaibaaaaaa
abaaaaaabkbabaiaibaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaa
aaaaaaaadkbabaiaibaaaaaaabaaaaaabkbabaiaibaaaaaaabaaaaaaabaaaaah
ecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaai
gcaabaaaaaaaaaaakgblbaaaabaaaaaakgblbaiaebaaaaaaabaaaaaaabaaaaah
icaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaa
dkbabaaaabaaaaaabkbabaaaabaaaaaadbaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaadeaaaaahbcaabaaaabaaaaaadkbabaaa
abaaaaaabkbabaaaabaaaaaabnaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadhaaaaakbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaa
aaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaafjcaabaaaaaaaaaaa
fgbjbaaaabaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaaaaaaaaaamgaabaaa
aaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaa
acaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafjcaabaaaaaaaaaaa
fgbjbaaaabaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaaaaaaaaaamgaabaaa
aaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaa
adaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdodcaaaabajcaabaaaaaaaaaaa
kgbobaiaibaaaaaaabaaaaaaaceaaaaadagojjlmaaaaaaaaaaaaaaaadagojjlm
aceaaaaachbgjidnaaaaaaaaaaaaaaaachbgjidndcaaaaanjcaabaaaaaaaaaaa
agambaaaaaaaaaaakgbobaiaibaaaaaaabaaaaaaaceaaaaaiedefjloaaaaaaaa
aaaaaaaaiedefjlodcaaaaanjcaabaaaaaaaaaaaagambaaaaaaaaaaakgbobaia
ibaaaaaaabaaaaaaaceaaaaakeanmjdpaaaaaaaaaaaaaaaakeanmjdpaaaaaaal
mcaabaaaacaaaaaakgbobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaadiaaaaah
mcaabaaaadaaaaaaagambaaaaaaaaaaakgaobaaaacaaaaaadcaaaaapmcaabaaa
adaaaaaakgaobaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaamaaaaaaama
aceaaaaaaaaaaaaaaaaaaaaanlapejeanlapejeaabaaaaahgcaabaaaaaaaaaaa
fgagbaaaaaaaaaaakgalbaaaadaaaaaadcaaaaajdcaabaaaaaaaaaaamgaabaaa
aaaaaaaaogakbaaaacaaaaaajgafbaaaaaaaaaaadiaaaaakgcaabaaaabaaaaaa
agabbaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdoaaaaaaaaalaaaaaf
ccaabaaaacaaaaaackaabaaaabaaaaaaamaaaaafccaabaaaadaaaaaackaabaaa
abaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaadaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaadcaaaaalpcaabaaa
abaaaaaalgbhbaaaabaaaaaaagiacaaaaaaaaaaaadaaaaaaegiecaaaaaaaaaaa
aeaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaajgbfbaaaabaaaaaa
agiacaaaaaaaaaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaai
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaak
pcaabaaaacaaaaaafgbfbaiaibaaaaaaabaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaa
acaaaaaadcaaaaakpcaabaaaabaaaaaakgbkbaiaibaaaaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaajbcaabaaaabaaaaaaakbabaaaabaaaaaaakiacaia
ebaaaaaaaaaaaaaaafaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
bkiacaaaaaaaaaaaafaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaagaaaaaabaaaaaai
ccaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaapnekibeadicaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaaaaaaaaaiccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahiccabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_DetailScale]
Vector 3 [_DetailOffset]
Float 4 [_FadeDist]
Float 5 [_FadeScale]
Float 6 [_Opacity]
Vector 7 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"ps_3_0
; 87 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c8, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c9, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c10, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c11, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c12, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord4 v4
dsy r4.xy, v1
abs r3.y, v1.z
abs r4.zw, v1.xyxy
max r0.x, r4.z, r3.y
rcp r0.y, r0.x
min r0.x, r4.z, r3.y
mul r0.x, r0, r0.y
mul r0.y, r0.x, r0.x
mad r0.z, r0.y, c10.y, c10
mad r0.z, r0, r0.y, c10.w
mad r0.z, r0, r0.y, c11.x
mad r0.z, r0, r0.y, c11.y
mad r0.y, r0.z, r0, c11.z
mul r2.x, r0.y, r0
mul r0.zw, v1.xyxy, c2.x
add r1.xy, r0.zwzw, c3
mul r0.xy, v1.zyzw, c2.x
add r0.xy, r0, c3
add r2.z, -r2.x, c11.w
add r2.y, r4.z, -r3
cmp r2.x, -r2.y, r2, r2.z
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r4.z, r0, r1
add r0.x, -r2, c9.w
cmp r0.z, v1, r2.x, r0.x
mul r2.zw, v1.xyzx, c2.x
cmp r3.x, v1, r0.z, -r0.z
add r0.xy, r2.zwzw, c3
texld r0, r0, s1
add_pp r2, r0, -r1
abs r0.w, v1.y
add r0.y, -r3, c8
mad r0.x, r3.y, c8.z, c8.w
mad r0.x, r3.y, r0, c9
mad r0.x, r3.y, r0, c9.y
add r3.z, -r0.w, c8.y
mad r3.y, r0.w, c8.z, c8.w
mad r3.y, r3, r0.w, c9.x
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.y, r0.x, r0
cmp r0.x, v1.z, c8, c8.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c9, r0.y
rsq r3.z, r3.z
mad r0.w, r3.y, r0, c9.y
rcp r3.z, r3.z
mul r3.y, r0.w, r3.z
cmp r0.w, v1.y, c8.x, c8.y
mul r3.z, r0.w, r3.y
mad r0.y, -r3.z, c9.z, r3
mad r0.z, r0.x, c9.w, r0
mad r0.x, r0.w, c9.w, r0.y
mul r0.y, r0.z, c10.x
dsx r0.w, r0.y
dsx r3.zw, v1.xyxy
mul r4.xy, r4, r4
add r0.z, r4.x, r4.y
mul r3.y, r0.x, c10.x
mul r3.zw, r3, r3
add r0.x, r3.z, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r0.x, r0.x
rcp r3.z, r0.z
mul r0.z, r0.x, c12.x
mad_pp r1, r4.w, r2, r1
mad r3.x, r3, c12, c12.y
dsy r0.y, r0
mul r0.x, r3.z, c12
texldd r0, r3, s0, r0.zwzw, r0
mul r0, r0, c7
mul_pp r0, r0, r1
mov_pp oC0.xyz, r0
dp3_pp r0.x, v2, c0
add_pp r0.x, r0, c12.z
texldp r1.x, v4, s2
mul_pp r0.y, r0.x, r1.x
add r0.x, v0, -c4
mul_pp r0.y, r0, c1.w
mul_sat r0.x, r0, c5
mul_pp_sat r0.y, r0, c12.w
min_pp r0.x, r0.w, r0
add r0.y, -r0, c8
mul r0.x, r0, c6
mul oC0.w, r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 192 used size, 12 vars
Vector 16 [_LightColor0] 4
Float 112 [_DetailScale]
Vector 128 [_DetailOffset] 4
Float 144 [_FadeDist]
Float 148 [_FadeScale]
Float 160 [_Opacity]
Vector 176 [_Color] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_DetailTex] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
// 72 instructions, 4 temp regs, 0 temp arrays:
// ALU 60 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedofdippgpnicgpnlgihgiebdmgblmenngabaaaaaaamalaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcomajaaaa
eaaaaaaahlacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
bcbabaaaabaaaaaagcbaaaadocbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadlcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
deaaaaajbcaabaaaaaaaaaaadkbabaiaibaaaaaaabaaaaaabkbabaiaibaaaaaa
abaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaadkbabaiaibaaaaaa
abaaaaaabkbabaiaibaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaa
aaaaaaaadkbabaiaibaaaaaaabaaaaaabkbabaiaibaaaaaaabaaaaaaabaaaaah
ecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaai
gcaabaaaaaaaaaaakgblbaaaabaaaaaakgblbaiaebaaaaaaabaaaaaaabaaaaah
icaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaa
dkbabaaaabaaaaaabkbabaaaabaaaaaadbaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaadeaaaaahbcaabaaaabaaaaaadkbabaaa
abaaaaaabkbabaaaabaaaaaabnaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadhaaaaakbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaa
aaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaafjcaabaaaaaaaaaaa
fgbjbaaaabaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaaaaaaaaaamgaabaaa
aaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaa
acaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafjcaabaaaaaaaaaaa
fgbjbaaaabaaaaaaapaaaaahbcaabaaaaaaaaaaamgaabaaaaaaaaaaamgaabaaa
aaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaa
adaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdodcaaaabajcaabaaaaaaaaaaa
kgbobaiaibaaaaaaabaaaaaaaceaaaaadagojjlmaaaaaaaaaaaaaaaadagojjlm
aceaaaaachbgjidnaaaaaaaaaaaaaaaachbgjidndcaaaaanjcaabaaaaaaaaaaa
agambaaaaaaaaaaakgbobaiaibaaaaaaabaaaaaaaceaaaaaiedefjloaaaaaaaa
aaaaaaaaiedefjlodcaaaaanjcaabaaaaaaaaaaaagambaaaaaaaaaaakgbobaia
ibaaaaaaabaaaaaaaceaaaaakeanmjdpaaaaaaaaaaaaaaaakeanmjdpaaaaaaal
mcaabaaaacaaaaaakgbobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaadiaaaaah
mcaabaaaadaaaaaaagambaaaaaaaaaaakgaobaaaacaaaaaadcaaaaapmcaabaaa
adaaaaaakgaobaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaamaaaaaaama
aceaaaaaaaaaaaaaaaaaaaaanlapejeanlapejeaabaaaaahgcaabaaaaaaaaaaa
fgagbaaaaaaaaaaakgalbaaaadaaaaaadcaaaaajdcaabaaaaaaaaaaamgaabaaa
aaaaaaaaogakbaaaacaaaaaajgafbaaaaaaaaaaadiaaaaakgcaabaaaabaaaaaa
agabbaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdoaaaaaaaaalaaaaaf
ccaabaaaacaaaaaackaabaaaabaaaaaaamaaaaafccaabaaaadaaaaaackaabaaa
abaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaegaabaaaacaaaaaaegaabaaaadaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaadcaaaaalpcaabaaa
abaaaaaalgbhbaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaegiecaaaaaaaaaaa
aiaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaaldcaabaaaadaaaaaajgbfbaaaabaaaaaa
agiacaaaaaaaaaaaahaaaaaaegiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaai
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaak
pcaabaaaacaaaaaafgbfbaiaibaaaaaaabaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaa
acaaaaaadcaaaaakpcaabaaaabaaaaaakgbkbaiaibaaaaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaajbcaabaaaabaaaaaaakbabaaaabaaaaaaakiacaia
ebaaaaaaaaaaaaaaajaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
bkiacaaaaaaaaaaaajaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaakaaaaaabaaaaaai
ccaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaapnekibdpaoaaaaahmcaabaaaaaaaaaaa
agbebaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
aaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaadkiacaaaaaaaaaaaabaaaaaadicaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiaeaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahiccabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

}
	}

#LINE 106

	 	 
	 } 
    }
}