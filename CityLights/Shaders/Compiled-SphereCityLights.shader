Shader "Sphere/CityLight" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_DetailTex ("Detail (RGB) (A)", 2D) = "white" {}
		_DetailScale ("Detail Scale", Range(0,1000)) = 80
		_DetailOffset ("Detail Offset", Color) = (0,0,0,0)
		_FadeDist ("Fade Distance", Range(0,1)) = .01
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
//   d3d9 - ALU: 15 to 20
//   d3d11 - ALU: 15 to 18, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform vec4 unity_Scale;
uniform mat4 _Object2World;

void main ()
{
  mat3 tmpvar_1;
  tmpvar_1[0] = _Object2World[0].xyz;
  tmpvar_1[1] = _Object2World[1].xyz;
  tmpvar_1[2] = _Object2World[2].xyz;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = (tmpvar_1 * (gl_Normal * unity_Scale.w));
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform vec4 _Color;
uniform float _FadeDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 c_1;
  vec2 uv_2;
  float r_3;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD1.y);
  uv_2.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD1.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD1.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD1);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_2, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec4 c_19;
  c_19.w = (min (tmpvar_17.w, clamp ((_FadeDist * sqrt(dot (p_18, p_18))), 0.0, 1.0)) * (1.0 - clamp ((_LightColor0.w * (((dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz) - 0.01) / 0.99) * 16.0)), 0.0, 1.0)));
  c_19.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = c_19.w;
  c_1.xyz = tmpvar_17.xyz;
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
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
"vs_3_0
; 15 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
mul r0.yzw, v1.xxyz, c8.w
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul o2.xyz, r0.x, v0
dp3 o3.z, r0.yzww, c6
dp3 o3.y, r0.yzww, c5
dp3 o3.x, r0.yzww, c4
mov o4.xyz, c9.x
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
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerDraw" 0
// 17 instructions, 2 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcleljjnddlogfphemfplmdgkagfogdekabaaaaaaeeaeaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckiacaaaaeaaaabaa
kkaaaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaaaaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaabaaaaaaegiccaaaaaaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaa
agaabaaaaaaaaaaaegbcbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaaaaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
aaaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaaaaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
dgaaaaaihccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
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
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_35;
  tmpvar_35 = min (tmpvar_33.w, clamp ((_FadeDist * sqrt(dot (p_34, p_34))), 0.0, 1.0));
  tmpvar_3 = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_36;
  mediump vec4 tmpvar_37;
  mediump vec3 lightDir_38;
  lightDir_38 = _WorldSpaceLightPos0.xyz;
  lowp vec4 c_39;
  highp float lightIntensity_40;
  mediump float tmpvar_41;
  tmpvar_41 = (_LightColor0.w * (((dot (xlv_TEXCOORD2, lightDir_38) - 0.01) / 0.99) * 16.0));
  lightIntensity_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (tmpvar_3 * (1.0 - clamp (lightIntensity_40, 0.0, 1.0)));
  c_39.w = tmpvar_42;
  c_39.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_37 = c_39;
  c_1 = tmpvar_37;
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
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
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
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_35;
  tmpvar_35 = min (tmpvar_33.w, clamp ((_FadeDist * sqrt(dot (p_34, p_34))), 0.0, 1.0));
  tmpvar_3 = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_36;
  mediump vec4 tmpvar_37;
  mediump vec3 lightDir_38;
  lightDir_38 = _WorldSpaceLightPos0.xyz;
  lowp vec4 c_39;
  highp float lightIntensity_40;
  mediump float tmpvar_41;
  tmpvar_41 = (_LightColor0.w * (((dot (xlv_TEXCOORD2, lightDir_38) - 0.01) / 0.99) * 16.0));
  lightIntensity_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (tmpvar_3 * (1.0 - clamp (lightIntensity_40, 0.0, 1.0)));
  c_39.w = tmpvar_42;
  c_39.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_37 = c_39;
  c_1 = tmpvar_37;
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
#line 397
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
};
#line 452
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
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
uniform lowp vec4 _Color;
#line 403
#line 415
#line 433
#line 461
#line 415
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 419
    o.worldPos = vertexPos;
    o.nrm = normalize(v.vertex.xyz);
}
#line 461
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 465
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.worldPos = (_Object2World * v.vertex).xyz;
    #line 469
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    #line 473
    return o;
}

out highp vec3 xlv_TEXCOORD0;
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
    xlv_TEXCOORD0 = vec3(xl_retval.worldPos);
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
#line 397
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
};
#line 452
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
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
uniform lowp vec4 _Color;
#line 403
#line 415
#line 433
#line 461
#line 403
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 407
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 16.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 411
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
#line 422
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 424
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 428
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 433
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    #line 437
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 441
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    nrm = abs(nrm);
    #line 445
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    main = (main * detail);
    highp float distAlpha = xll_saturate_f((_FadeDist * distance( IN.worldPos, _WorldSpaceCameraPos)));
    #line 449
    o.Alpha = min( main.w, distAlpha);
    o.Emission = main.xyz;
}
#line 475
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 477
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    surfIN.worldPos = IN.worldPos;
    SurfaceOutput o;
    #line 481
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 485
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = 1.0;
    #line 489
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 493
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldPos = vec3(xlv_TEXCOORD0);
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
varying vec3 xlv_TEXCOORD0;
uniform vec4 unity_Scale;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = (tmpvar_2 * (gl_Normal * unity_Scale.w));
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = o_3;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform vec4 _Color;
uniform float _FadeDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 c_1;
  vec2 uv_2;
  float r_3;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD1.y);
  uv_2.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD1.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD1.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD1);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_2, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec4 c_19;
  c_19.w = (min (tmpvar_17.w, clamp ((_FadeDist * sqrt(dot (p_18, p_18))), 0.0, 1.0)) * (1.0 - clamp ((_LightColor0.w * ((((dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz) - 0.01) / 0.99) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x) * 16.0)), 0.0, 1.0)));
  c_19.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = c_19.w;
  c_1.xyz = tmpvar_17.xyz;
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
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Matrix 4 [_Object2World]
Vector 10 [unity_Scale]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c11, 0.50000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
mad o5.xy, r1.z, c9.zwzw, r1
mul r1.xyz, v1, c10.w
mov o0, r0
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mov o5.zw, r0
mul o2.xyz, r0.x, v0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
mov o4.xyz, c11.y
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 22 instructions, 3 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedigklicidmcfaphlcilipefdjkehlgdibabaaaaaaaeafaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcfaadaaaaeaaaabaaneaaaaaafjaaaaae
egiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
giaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaa
egbcbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hccabaaaacaaaaaaagaabaaaabaaaaaaegbcbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaaegbcbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaabaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaaklcaabaaa
abaaaaaaegiicaaaabaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaaoaaaaaakgakbaaaabaaaaaa
egadbaaaabaaaaaadgaaaaaihccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
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
varying highp vec3 xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
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
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_35;
  tmpvar_35 = min (tmpvar_33.w, clamp ((_FadeDist * sqrt(dot (p_34, p_34))), 0.0, 1.0));
  tmpvar_3 = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_36;
  lowp float tmpvar_37;
  mediump float lightShadowDataX_38;
  highp float dist_39;
  lowp float tmpvar_40;
  tmpvar_40 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_39 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = _LightShadowData.x;
  lightShadowDataX_38 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = max (float((dist_39 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_38);
  tmpvar_37 = tmpvar_42;
  mediump vec4 tmpvar_43;
  mediump vec3 lightDir_44;
  lightDir_44 = _WorldSpaceLightPos0.xyz;
  mediump float atten_45;
  atten_45 = tmpvar_37;
  lowp vec4 c_46;
  highp float lightIntensity_47;
  mediump float tmpvar_48;
  tmpvar_48 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_44) - 0.01) / 0.99) * atten_45) * 16.0));
  lightIntensity_47 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_3 * (1.0 - clamp (lightIntensity_47, 0.0, 1.0)));
  c_46.w = tmpvar_49;
  c_46.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_43 = c_46;
  c_1 = tmpvar_43;
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
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = o_5;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
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
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_35;
  tmpvar_35 = min (tmpvar_33.w, clamp ((_FadeDist * sqrt(dot (p_34, p_34))), 0.0, 1.0));
  tmpvar_3 = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_36;
  lowp float tmpvar_37;
  tmpvar_37 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  mediump vec4 tmpvar_38;
  mediump vec3 lightDir_39;
  lightDir_39 = _WorldSpaceLightPos0.xyz;
  mediump float atten_40;
  atten_40 = tmpvar_37;
  lowp vec4 c_41;
  highp float lightIntensity_42;
  mediump float tmpvar_43;
  tmpvar_43 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_39) - 0.01) / 0.99) * atten_40) * 16.0));
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
#line 405
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
};
#line 460
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
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
uniform lowp vec4 _Color;
#line 411
#line 423
#line 441
#line 470
#line 423
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 427
    o.worldPos = vertexPos;
    o.nrm = normalize(v.vertex.xyz);
}
#line 470
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 474
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.worldPos = (_Object2World * v.vertex).xyz;
    #line 478
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 483
    return o;
}

out highp vec3 xlv_TEXCOORD0;
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
    xlv_TEXCOORD0 = vec3(xl_retval.worldPos);
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
#line 405
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
};
#line 460
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
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
uniform lowp vec4 _Color;
#line 411
#line 423
#line 441
#line 470
#line 411
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 415
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 16.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 419
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
#line 430
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 432
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 436
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 441
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    #line 445
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 449
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    nrm = abs(nrm);
    #line 453
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    main = (main * detail);
    highp float distAlpha = xll_saturate_f((_FadeDist * distance( IN.worldPos, _WorldSpaceCameraPos)));
    #line 457
    o.Alpha = min( main.w, distAlpha);
    o.Emission = main.xyz;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 485
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 487
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    surfIN.worldPos = IN.worldPos;
    SurfaceOutput o;
    #line 491
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 495
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 499
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 503
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldPos = vec3(xlv_TEXCOORD0);
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
varying vec3 xlv_TEXCOORD0;
uniform vec4 unity_Scale;
uniform mat4 _Object2World;

void main ()
{
  mat3 tmpvar_1;
  tmpvar_1[0] = _Object2World[0].xyz;
  tmpvar_1[1] = _Object2World[1].xyz;
  tmpvar_1[2] = _Object2World[2].xyz;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = (tmpvar_1 * (gl_Normal * unity_Scale.w));
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform vec4 _Color;
uniform float _FadeDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 c_1;
  vec2 uv_2;
  float r_3;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD1.y);
  uv_2.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD1.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD1.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD1);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_2, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec4 c_19;
  c_19.w = (min (tmpvar_17.w, clamp ((_FadeDist * sqrt(dot (p_18, p_18))), 0.0, 1.0)) * (1.0 - clamp ((_LightColor0.w * (((dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz) - 0.01) / 0.99) * 16.0)), 0.0, 1.0)));
  c_19.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = c_19.w;
  c_1.xyz = tmpvar_17.xyz;
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
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
"vs_3_0
; 15 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
mul r0.yzw, v1.xxyz, c8.w
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul o2.xyz, r0.x, v0
dp3 o3.z, r0.yzww, c6
dp3 o3.y, r0.yzww, c5
dp3 o3.x, r0.yzww, c4
mov o4.xyz, c9.x
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
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerDraw" 0
// 17 instructions, 2 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcleljjnddlogfphemfplmdgkagfogdekabaaaaaaeeaeaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckiacaaaaeaaaabaa
kkaaaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaaaaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaabaaaaaaegiccaaaaaaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaa
agaabaaaaaaaaaaaegbcbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaaaaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
aaaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaaaaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
dgaaaaaihccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
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
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_35;
  tmpvar_35 = min (tmpvar_33.w, clamp ((_FadeDist * sqrt(dot (p_34, p_34))), 0.0, 1.0));
  tmpvar_3 = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_36;
  mediump vec4 tmpvar_37;
  mediump vec3 lightDir_38;
  lightDir_38 = _WorldSpaceLightPos0.xyz;
  lowp vec4 c_39;
  highp float lightIntensity_40;
  mediump float tmpvar_41;
  tmpvar_41 = (_LightColor0.w * (((dot (xlv_TEXCOORD2, lightDir_38) - 0.01) / 0.99) * 16.0));
  lightIntensity_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (tmpvar_3 * (1.0 - clamp (lightIntensity_40, 0.0, 1.0)));
  c_39.w = tmpvar_42;
  c_39.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_37 = c_39;
  c_1 = tmpvar_37;
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
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
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
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_35;
  tmpvar_35 = min (tmpvar_33.w, clamp ((_FadeDist * sqrt(dot (p_34, p_34))), 0.0, 1.0));
  tmpvar_3 = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_36;
  mediump vec4 tmpvar_37;
  mediump vec3 lightDir_38;
  lightDir_38 = _WorldSpaceLightPos0.xyz;
  lowp vec4 c_39;
  highp float lightIntensity_40;
  mediump float tmpvar_41;
  tmpvar_41 = (_LightColor0.w * (((dot (xlv_TEXCOORD2, lightDir_38) - 0.01) / 0.99) * 16.0));
  lightIntensity_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (tmpvar_3 * (1.0 - clamp (lightIntensity_40, 0.0, 1.0)));
  c_39.w = tmpvar_42;
  c_39.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_37 = c_39;
  c_1 = tmpvar_37;
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
#line 397
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
};
#line 452
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
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
uniform lowp vec4 _Color;
#line 403
#line 415
#line 433
#line 461
#line 415
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 419
    o.worldPos = vertexPos;
    o.nrm = normalize(v.vertex.xyz);
}
#line 461
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 465
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.worldPos = (_Object2World * v.vertex).xyz;
    #line 469
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    #line 473
    return o;
}

out highp vec3 xlv_TEXCOORD0;
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
    xlv_TEXCOORD0 = vec3(xl_retval.worldPos);
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
#line 397
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
};
#line 452
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
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
uniform lowp vec4 _Color;
#line 403
#line 415
#line 433
#line 461
#line 403
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 407
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 16.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 411
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
#line 422
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 424
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 428
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 433
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    #line 437
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 441
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    nrm = abs(nrm);
    #line 445
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    main = (main * detail);
    highp float distAlpha = xll_saturate_f((_FadeDist * distance( IN.worldPos, _WorldSpaceCameraPos)));
    #line 449
    o.Alpha = min( main.w, distAlpha);
    o.Emission = main.xyz;
}
#line 475
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 477
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    surfIN.worldPos = IN.worldPos;
    SurfaceOutput o;
    #line 481
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 485
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = 1.0;
    #line 489
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 493
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldPos = vec3(xlv_TEXCOORD0);
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
varying vec3 xlv_TEXCOORD0;
uniform vec4 unity_Scale;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = (tmpvar_2 * (gl_Normal * unity_Scale.w));
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = o_3;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform vec4 _Color;
uniform float _FadeDist;
uniform vec4 _DetailOffset;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 c_1;
  vec2 uv_2;
  float r_3;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD1.y);
  uv_2.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD1.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD1.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD1);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_2, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec4 c_19;
  c_19.w = (min (tmpvar_17.w, clamp ((_FadeDist * sqrt(dot (p_18, p_18))), 0.0, 1.0)) * (1.0 - clamp ((_LightColor0.w * ((((dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz) - 0.01) / 0.99) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x) * 16.0)), 0.0, 1.0)));
  c_19.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = c_19.w;
  c_1.xyz = tmpvar_17.xyz;
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
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Matrix 4 [_Object2World]
Vector 10 [unity_Scale]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c11, 0.50000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
mad o5.xy, r1.z, c9.zwzw, r1
mul r1.xyz, v1, c10.w
mov o0, r0
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mov o5.zw, r0
mul o2.xyz, r0.x, v0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
mov o4.xyz, c11.y
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 22 instructions, 3 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedigklicidmcfaphlcilipefdjkehlgdibabaaaaaaaeafaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcfaadaaaaeaaaabaaneaaaaaafjaaaaae
egiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
giaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaa
egbcbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hccabaaaacaaaaaaagaabaaaabaaaaaaegbcbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaaegbcbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaabaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaaklcaabaaa
abaaaaaaegiicaaaabaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaaoaaaaaakgakbaaaabaaaaaa
egadbaaaabaaaaaadgaaaaaihccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
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
varying highp vec3 xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
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
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_35;
  tmpvar_35 = min (tmpvar_33.w, clamp ((_FadeDist * sqrt(dot (p_34, p_34))), 0.0, 1.0));
  tmpvar_3 = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_36;
  lowp float tmpvar_37;
  mediump float lightShadowDataX_38;
  highp float dist_39;
  lowp float tmpvar_40;
  tmpvar_40 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_39 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = _LightShadowData.x;
  lightShadowDataX_38 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = max (float((dist_39 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_38);
  tmpvar_37 = tmpvar_42;
  mediump vec4 tmpvar_43;
  mediump vec3 lightDir_44;
  lightDir_44 = _WorldSpaceLightPos0.xyz;
  mediump float atten_45;
  atten_45 = tmpvar_37;
  lowp vec4 c_46;
  highp float lightIntensity_47;
  mediump float tmpvar_48;
  tmpvar_48 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_44) - 0.01) / 0.99) * atten_45) * 16.0));
  lightIntensity_47 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_3 * (1.0 - clamp (lightIntensity_47, 0.0, 1.0)));
  c_46.w = tmpvar_49;
  c_46.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_43 = c_46;
  c_1 = tmpvar_43;
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
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = o_5;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
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
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_35;
  tmpvar_35 = min (tmpvar_33.w, clamp ((_FadeDist * sqrt(dot (p_34, p_34))), 0.0, 1.0));
  tmpvar_3 = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_36;
  lowp float tmpvar_37;
  tmpvar_37 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  mediump vec4 tmpvar_38;
  mediump vec3 lightDir_39;
  lightDir_39 = _WorldSpaceLightPos0.xyz;
  mediump float atten_40;
  atten_40 = tmpvar_37;
  lowp vec4 c_41;
  highp float lightIntensity_42;
  mediump float tmpvar_43;
  tmpvar_43 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_39) - 0.01) / 0.99) * atten_40) * 16.0));
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
#line 405
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
};
#line 460
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
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
uniform lowp vec4 _Color;
#line 411
#line 423
#line 441
#line 470
#line 423
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 427
    o.worldPos = vertexPos;
    o.nrm = normalize(v.vertex.xyz);
}
#line 470
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 474
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.worldPos = (_Object2World * v.vertex).xyz;
    #line 478
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 483
    return o;
}

out highp vec3 xlv_TEXCOORD0;
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
    xlv_TEXCOORD0 = vec3(xl_retval.worldPos);
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
#line 405
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
};
#line 460
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
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
uniform lowp vec4 _Color;
#line 411
#line 423
#line 441
#line 470
#line 411
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 415
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 16.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 419
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
#line 430
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 432
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 436
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 441
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    #line 445
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 449
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    nrm = abs(nrm);
    #line 453
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    main = (main * detail);
    highp float distAlpha = xll_saturate_f((_FadeDist * distance( IN.worldPos, _WorldSpaceCameraPos)));
    #line 457
    o.Alpha = min( main.w, distAlpha);
    o.Emission = main.xyz;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 485
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 487
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    surfIN.worldPos = IN.worldPos;
    SurfaceOutput o;
    #line 491
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 495
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 499
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 503
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldPos = vec3(xlv_TEXCOORD0);
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
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
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
varying highp vec3 xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
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
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_35;
  tmpvar_35 = min (tmpvar_33.w, clamp ((_FadeDist * sqrt(dot (p_34, p_34))), 0.0, 1.0));
  tmpvar_3 = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_36;
  lowp float shadow_37;
  lowp float tmpvar_38;
  tmpvar_38 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_39;
  tmpvar_39 = (_LightShadowData.x + (tmpvar_38 * (1.0 - _LightShadowData.x)));
  shadow_37 = tmpvar_39;
  mediump vec4 tmpvar_40;
  mediump vec3 lightDir_41;
  lightDir_41 = _WorldSpaceLightPos0.xyz;
  mediump float atten_42;
  atten_42 = shadow_37;
  lowp vec4 c_43;
  highp float lightIntensity_44;
  mediump float tmpvar_45;
  tmpvar_45 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_41) - 0.01) / 0.99) * atten_42) * 16.0));
  lightIntensity_44 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_3 * (1.0 - clamp (lightIntensity_44, 0.0, 1.0)));
  c_43.w = tmpvar_46;
  c_43.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_40 = c_43;
  c_1 = tmpvar_40;
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
#line 405
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
};
#line 460
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
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
uniform lowp vec4 _Color;
#line 411
#line 423
#line 441
#line 470
#line 423
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 427
    o.worldPos = vertexPos;
    o.nrm = normalize(v.vertex.xyz);
}
#line 470
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 474
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.worldPos = (_Object2World * v.vertex).xyz;
    #line 478
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 483
    return o;
}

out highp vec3 xlv_TEXCOORD0;
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
    xlv_TEXCOORD0 = vec3(xl_retval.worldPos);
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
#line 405
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
};
#line 460
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
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
uniform lowp vec4 _Color;
#line 411
#line 423
#line 441
#line 470
#line 411
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 415
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 16.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 419
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
#line 430
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 432
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 436
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 441
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    #line 445
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 449
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    nrm = abs(nrm);
    #line 453
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    main = (main * detail);
    highp float distAlpha = xll_saturate_f((_FadeDist * distance( IN.worldPos, _WorldSpaceCameraPos)));
    #line 457
    o.Alpha = min( main.w, distAlpha);
    o.Emission = main.xyz;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 485
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 487
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    surfIN.worldPos = IN.worldPos;
    SurfaceOutput o;
    #line 491
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 495
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 499
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 503
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldPos = vec3(xlv_TEXCOORD0);
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
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
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
varying highp vec3 xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform highp float _FadeDist;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
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
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_35;
  tmpvar_35 = min (tmpvar_33.w, clamp ((_FadeDist * sqrt(dot (p_34, p_34))), 0.0, 1.0));
  tmpvar_3 = tmpvar_35;
  mediump vec3 tmpvar_36;
  tmpvar_36 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_36;
  lowp float shadow_37;
  lowp float tmpvar_38;
  tmpvar_38 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_39;
  tmpvar_39 = (_LightShadowData.x + (tmpvar_38 * (1.0 - _LightShadowData.x)));
  shadow_37 = tmpvar_39;
  mediump vec4 tmpvar_40;
  mediump vec3 lightDir_41;
  lightDir_41 = _WorldSpaceLightPos0.xyz;
  mediump float atten_42;
  atten_42 = shadow_37;
  lowp vec4 c_43;
  highp float lightIntensity_44;
  mediump float tmpvar_45;
  tmpvar_45 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_41) - 0.01) / 0.99) * atten_42) * 16.0));
  lightIntensity_44 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_3 * (1.0 - clamp (lightIntensity_44, 0.0, 1.0)));
  c_43.w = tmpvar_46;
  c_43.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_40 = c_43;
  c_1 = tmpvar_40;
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
#line 405
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
};
#line 460
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
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
uniform lowp vec4 _Color;
#line 411
#line 423
#line 441
#line 470
#line 423
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 427
    o.worldPos = vertexPos;
    o.nrm = normalize(v.vertex.xyz);
}
#line 470
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 474
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.worldPos = (_Object2World * v.vertex).xyz;
    #line 478
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 483
    return o;
}

out highp vec3 xlv_TEXCOORD0;
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
    xlv_TEXCOORD0 = vec3(xl_retval.worldPos);
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
#line 405
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
};
#line 460
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
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
uniform lowp vec4 _Color;
#line 411
#line 423
#line 441
#line 470
#line 411
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 415
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 16.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 419
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
#line 430
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 432
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 436
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 441
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    #line 445
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 449
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    nrm = abs(nrm);
    #line 453
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    main = (main * detail);
    highp float distAlpha = xll_saturate_f((_FadeDist * distance( IN.worldPos, _WorldSpaceCameraPos)));
    #line 457
    o.Alpha = min( main.w, distAlpha);
    o.Emission = main.xyz;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 485
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 487
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    surfIN.worldPos = IN.worldPos;
    SurfaceOutput o;
    #line 491
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 495
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 499
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 503
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldPos = vec3(xlv_TEXCOORD0);
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
//   d3d9 - ALU: 88 to 89, TEX: 6 to 7
//   d3d11 - ALU: 64 to 67, TEX: 3 to 4, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Float 3 [_DetailScale]
Vector 4 [_DetailOffset]
Float 5 [_FadeDist]
Vector 6 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 88 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c7, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c8, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c9, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c10, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c11, 0.15915494, 0.50000000, -0.01000214, 16.15779114
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dsy r4.xy, v1
abs r3.y, v1.z
abs r4.zw, v1.xyxy
max r0.x, r3.y, r4.z
rcp r0.y, r0.x
min r0.x, r3.y, r4.z
mul r0.x, r0, r0.y
mul r0.y, r0.x, r0.x
mad r0.z, r0.y, c9.y, c9
mad r0.z, r0, r0.y, c9.w
mad r0.z, r0, r0.y, c10.x
mad r0.z, r0, r0.y, c10.y
mad r0.y, r0.z, r0, c10.z
mul r2.x, r0.y, r0
mul r0.zw, v1.xyxy, c3.x
add r1.xy, r0.zwzw, c4
mul r0.xy, v1.zyzw, c3.x
add r0.xy, r0, c4
add r2.z, -r2.x, c10.w
add r2.y, r3, -r4.z
cmp r2.x, -r2.y, r2, r2.z
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r4.z, r0, r1
add r0.x, -r2, c8.w
cmp r0.z, v1.x, r2.x, r0.x
mul r2.zw, v1.xyzx, c3.x
cmp r3.x, v1.z, r0.z, -r0.z
add r0.xy, r2.zwzw, c4
texld r0, r0, s1
add_pp r2, r0, -r1
abs r0.w, -v1.y
add r0.y, -r3, c7
mad r0.x, r3.y, c7.z, c7.w
mad r0.x, r3.y, r0, c8
mad r0.x, r3.y, r0, c8.y
add r3.z, -r0.w, c7.y
mad r3.y, r0.w, c7.z, c7.w
mad r3.y, r3, r0.w, c8.x
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.y, r0.x, r0
cmp r0.x, v1.z, c7, c7.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c8, r0.y
rsq r3.z, r3.z
mad r0.w, r3.y, r0, c8.y
rcp r3.z, r3.z
mul r3.y, r0.w, r3.z
cmp r0.w, -v1.y, c7.x, c7.y
mul r3.z, r0.w, r3.y
mad r0.y, -r3.z, c8.z, r3
mad r0.z, r0.x, c8.w, r0
mad r0.x, r0.w, c8.w, r0.y
mul r0.y, r0.z, c9.x
dsx r0.w, r0.y
dsx r3.zw, v1.xyxy
mul r4.xy, r4, r4
add r0.z, r4.x, r4.y
mul r3.y, r0.x, c9.x
mul r3.zw, r3, r3
add r0.x, r3.z, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r0.x, r0.x
rcp r3.z, r0.z
mul r0.z, r0.x, c11.x
mad_pp r1, r4.w, r2, r1
mad r3.x, r3, c11, c11.y
dsy r0.y, r0
mul r0.x, r3.z, c11
texldd r0, r3, s0, r0.zwzw, r0
mul r0, r0, c6
mul_pp r0, r0, r1
mov_pp oC0.xyz, r0
add r0.xyz, -v0, c0
dp3 r0.x, r0, r0
dp3_pp r1.x, v2, c1
add_pp r0.y, r1.x, c11.z
rsq r0.x, r0.x
mul_pp r0.y, r0, c2.w
rcp r0.x, r0.x
mul_pp_sat r0.y, r0, c11.w
mul_sat r0.x, r0, c5
add r0.y, -r0, c7
min_pp r0.x, r0.w, r0
mul oC0.w, r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 112 // 112 used size, 7 vars
Vector 16 [_LightColor0] 4
Float 48 [_DetailScale]
Vector 64 [_DetailOffset] 4
Float 80 [_FadeDist]
Vector 96 [_Color] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 71 instructions, 4 temp regs, 0 temp arrays:
// ALU 60 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedggabaaopagnijjaoimhefjiohmfdhhnjabaaaaaaliakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefclaajaaaaeaaaaaaagmacaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaia
ibaaaaaaacaaaaaackbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaaj
ccaabaaaaaaaaaaaakbabaiaibaaaaaaacaaaaaackbabaiaibaaaaaaacaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdido
dcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpdbaaaaajicaabaaaaaaaaaaaakbabaiaibaaaaaaacaaaaaa
ckbabaiaibaaaaaaacaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaaagbcbaaaacaaaaaa
agbcbaiaebaaaaaaacaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaddaaaaahccaabaaaaaaaaaaaakbabaaaacaaaaaackbabaaaacaaaaaa
dbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
deaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaackbabaaaacaaaaaabnaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaah
ccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaa
aaaaaadpalaaaaafdcaabaaaabaaaaaaegbabaaaacaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
idpjccdoamaaaaafmcaabaaaabaaaaaaagbebaaaacaaaaaaapaaaaahicaabaaa
aaaaaaaaogakbaaaabaaaaaaogakbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaa
idpjccdodbaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaacaaaaaabkbabaaa
acaaaaaadcaaaabamcaabaaaabaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaadagojjlmdagojjlmaceaaaaaaaaaaaaaaaaaaaaachbgjidn
chbgjidndcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaiedefjloiedefjlodcaaaaanmcaabaaa
abaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaakeanmjdpkeanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaa
acaaaaaakgaobaaaacaaaaaadiaaaaahdcaabaaaadaaaaaaogakbaaaabaaaaaa
ogakbaaaacaaaaaadcaaaaapdcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaa
aaaaaamaaaaaaamaaaaaaaaaaaaaaaaaaceaaaaanlapejeanlapejeaaaaaaaaa
aaaaaaaaabaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgabbaaaadaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaa
aaaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaackaabaaaacaaaaaa
dkaabaaaaaaaaaaadiaaaaakgcaabaaaaaaaaaaapgaobaaaaaaaaaaaaceaaaaa
aaaaaaaaidpjkcdoidpjkcdoaaaaaaaaalaaaaafccaabaaaabaaaaaackaabaaa
aaaaaaaaamaaaaafccaabaaaacaaaaaackaabaaaaaaaaaaaejaaaaanpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaa
abaaaaaaegaabaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaagaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaa
agiacaaaaaaaaaaaadaaaaaaegiecaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaldcaabaaaadaaaaaaegbabaaaacaaaaaaagiacaaaaaaaaaaaadaaaaaa
egiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaia
ibaaaaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaafgbfbaiaibaaaaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakiacaaaaaaaaaaaafaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaaibcaabaaaaaaaaaaaegbcbaaaadaaaaaaegiccaaaacaaaaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibebdicaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaaaaaaaaaibcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahiccabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Float 3 [_DetailScale]
Vector 4 [_DetailOffset]
Float 5 [_FadeDist]
Vector 6 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"ps_3_0
; 89 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c7, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c8, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c9, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c10, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c11, 0.15915494, 0.50000000, -0.01000214, 16.15779114
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord4 v4
dsy r4.xy, v1
abs r3.y, v1.z
abs r4.zw, v1.xyxy
max r0.x, r3.y, r4.z
rcp r0.y, r0.x
min r0.x, r3.y, r4.z
mul r0.x, r0, r0.y
mul r0.y, r0.x, r0.x
mad r0.z, r0.y, c9.y, c9
mad r0.z, r0, r0.y, c9.w
mad r0.z, r0, r0.y, c10.x
mad r0.z, r0, r0.y, c10.y
mad r0.y, r0.z, r0, c10.z
mul r2.x, r0.y, r0
mul r0.zw, v1.xyxy, c3.x
add r1.xy, r0.zwzw, c4
mul r0.xy, v1.zyzw, c3.x
add r0.xy, r0, c4
add r2.z, -r2.x, c10.w
add r2.y, r3, -r4.z
cmp r2.x, -r2.y, r2, r2.z
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r4.z, r0, r1
add r0.x, -r2, c8.w
cmp r0.z, v1.x, r2.x, r0.x
mul r2.zw, v1.xyzx, c3.x
cmp r3.x, v1.z, r0.z, -r0.z
add r0.xy, r2.zwzw, c4
texld r0, r0, s1
add_pp r2, r0, -r1
abs r0.w, -v1.y
add r0.y, -r3, c7
mad r0.x, r3.y, c7.z, c7.w
mad r0.x, r3.y, r0, c8
mad r0.x, r3.y, r0, c8.y
add r3.z, -r0.w, c7.y
mad r3.y, r0.w, c7.z, c7.w
mad r3.y, r3, r0.w, c8.x
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.y, r0.x, r0
cmp r0.x, v1.z, c7, c7.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c8, r0.y
rsq r3.z, r3.z
mad r0.w, r3.y, r0, c8.y
rcp r3.z, r3.z
mul r3.y, r0.w, r3.z
cmp r0.w, -v1.y, c7.x, c7.y
mul r3.z, r0.w, r3.y
mad r0.y, -r3.z, c8.z, r3
mad r0.z, r0.x, c8.w, r0
mad r0.x, r0.w, c8.w, r0.y
mul r0.y, r0.z, c9.x
dsx r0.w, r0.y
dsx r3.zw, v1.xyxy
mul r4.xy, r4, r4
add r0.z, r4.x, r4.y
mul r3.y, r0.x, c9.x
mul r3.zw, r3, r3
add r0.x, r3.z, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r0.x, r0.x
rcp r3.z, r0.z
mul r0.z, r0.x, c11.x
mad_pp r1, r4.w, r2, r1
mad r3.x, r3, c11, c11.y
dsy r0.y, r0
mul r0.x, r3.z, c11
texldd r0, r3, s0, r0.zwzw, r0
mul r0, r0, c6
mul_pp r0, r0, r1
mov_pp oC0.xyz, r0
add r1.xyz, -v0, c0
dp3_pp r0.z, v2, c1
dp3 r0.y, r1, r1
texldp r0.x, v4, s2
add_pp r0.z, r0, c11
mul_pp r0.z, r0, r0.x
rsq r0.x, r0.y
mul_pp r0.y, r0.z, c2.w
rcp r0.x, r0.x
mul_pp_sat r0.y, r0, c11.w
mul_sat r0.x, r0, c5
add r0.y, -r0, c7
min_pp r0.x, r0.w, r0
mul oC0.w, r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 176 // 176 used size, 8 vars
Vector 16 [_LightColor0] 4
Float 112 [_DetailScale]
Vector 128 [_DetailOffset] 4
Float 144 [_FadeDist]
Vector 160 [_Color] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_DetailTex] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
// 75 instructions, 4 temp regs, 0 temp arrays:
// ALU 63 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedefgakiojpldfoikdgmadkoeijnjhbklcabaaaaaahaalaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfaakaaaa
eaaaaaaajeacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaia
ibaaaaaaacaaaaaackbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaaj
ccaabaaaaaaaaaaaakbabaiaibaaaaaaacaaaaaackbabaiaibaaaaaaacaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdido
dcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpdbaaaaajicaabaaaaaaaaaaaakbabaiaibaaaaaaacaaaaaa
ckbabaiaibaaaaaaacaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaaagbcbaaaacaaaaaa
agbcbaiaebaaaaaaacaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaddaaaaahccaabaaaaaaaaaaaakbabaaaacaaaaaackbabaaaacaaaaaa
dbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
deaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaackbabaaaacaaaaaabnaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaah
ccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaa
aaaaaadpalaaaaafdcaabaaaabaaaaaaegbabaaaacaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
idpjccdoamaaaaafmcaabaaaabaaaaaaagbebaaaacaaaaaaapaaaaahicaabaaa
aaaaaaaaogakbaaaabaaaaaaogakbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaa
idpjccdodbaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaacaaaaaabkbabaaa
acaaaaaadcaaaabamcaabaaaabaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaadagojjlmdagojjlmaceaaaaaaaaaaaaaaaaaaaaachbgjidn
chbgjidndcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaiedefjloiedefjlodcaaaaanmcaabaaa
abaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaakeanmjdpkeanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaa
acaaaaaakgaobaaaacaaaaaadiaaaaahdcaabaaaadaaaaaaogakbaaaabaaaaaa
ogakbaaaacaaaaaadcaaaaapdcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaa
aaaaaamaaaaaaamaaaaaaaaaaaaaaaaaaceaaaaanlapejeanlapejeaaaaaaaaa
aaaaaaaaabaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgabbaaaadaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaa
aaaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaackaabaaaacaaaaaa
dkaabaaaaaaaaaaadiaaaaakgcaabaaaaaaaaaaapgaobaaaaaaaaaaaaceaaaaa
aaaaaaaaidpjkcdoidpjkcdoaaaaaaaaalaaaaafccaabaaaabaaaaaackaabaaa
aaaaaaaaamaaaaafccaabaaaacaaaaaackaabaaaaaaaaaaaejaaaaanpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaegaabaaa
abaaaaaaegaabaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaakaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaa
agiacaaaaaaaaaaaahaaaaaaegiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
dcaaaaaldcaabaaaadaaaaaaegbabaaaacaaaaaaagiacaaaaaaaaaaaahaaaaaa
egiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaia
ibaaaaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaafgbfbaiaibaaaaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakiacaaaaaaaaaaaajaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaaibcaabaaaaaaaaaaaegbcbaaaadaaaaaaegiccaaaacaaaaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdpaoaaaaahgcaabaaa
aaaaaaaaagbbbaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaa
jgafbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaadicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiaebaaaaaaaibcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahiccabaaaaaaaaaaaakaabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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

#LINE 98

	 	 
	 } 
    }
}