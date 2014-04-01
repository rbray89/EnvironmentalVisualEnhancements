Shader "Sphere/Cloud" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		_FalloffPow ("Falloff Power", Range(0,3)) = 2
		_FalloffScale ("Falloff Scale", Range(0,20)) = 3
		_DetailScale ("Detail Scale", Range(0,1000)) = 100
		_DetailOffset ("Detail Offset", Color) = (0,0,0,0)
		_DetailDist ("Detail Distance", Range(0,1)) = 0.00875
		_MinLight ("Minimum Light", Range(0,1)) = .5
		_FadeDist ("Fade Distance", Range(0,100)) = 10
		_FadeScale ("Fade Scale", Range(0,1)) = .002
		_RimDist ("Rim Distance", Range(0,100000)) = 1000
	}

Category {
	
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Mode Global}
	AlphaTest Greater 0
	ColorMask RGB
	Cull Off Lighting On ZWrite Off
	
SubShader {
	Pass {

		Lighting On
		Tags { "LightMode"="ForwardBase"}
		
		Program "vp" {
// Vertex combos: 15
//   d3d9 - ALU: 24 to 24
//   d3d11 - ALU: 22 to 22, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD3 = normalize((tmpvar_2 - tmpvar_3));
  xlv_TEXCOORD4 = normalize(gl_Vertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD4.y);
  uv_1.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD4.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD4.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_1, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_19;
  p_19 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_20;
  p_20 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_17.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r2.xyz, -r0, c8
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r3.xyz, r0, -r1
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mov o1.xyz, r0
dp4 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r1.w, r3
mul o6.xyz, r0.w, r2
mov o2.xyz, r1
rcp o3.x, r0.w
mul o5.xyz, r0.x, v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkojddmoijfcaoigfcinlpgalflkocjepabaaaaaaaaafaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcheadaaaaeaaaabaannaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
iccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaa
aaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaa
pgapbaaaaaaaaaaaegbcbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD3 = normalize((tmpvar_2 - tmpvar_3));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD3 = normalize((tmpvar_2 - tmpvar_3));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_OFF" }
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
#line 317
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 412
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
};
#line 405
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
#line 315
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 327
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 340
#line 348
#line 362
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 395
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 399
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 403
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 424
#line 449
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 424
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 428
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 432
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 436
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
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
#line 317
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 412
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
};
#line 405
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
#line 315
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 327
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 340
#line 348
#line 362
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 395
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 399
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 403
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 424
#line 449
#line 438
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 440
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 444
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 449
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 453
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 457
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 461
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 465
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    #line 469
    highp float distLerp = xll_saturate_f((0.0001 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    #line 473
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 477
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_3;
  p_3 = (tmpvar_1 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD3 = normalize((tmpvar_1 - tmpvar_2));
  xlv_TEXCOORD4 = normalize(gl_Vertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD4.y);
  uv_1.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD4.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD4.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_1, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_19;
  p_19 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_20;
  p_20 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_17.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r2.xyz, -r0, c8
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r3.xyz, r0, -r1
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mov o1.xyz, r0
dp4 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r1.w, r3
mul o6.xyz, r0.w, r2
mov o2.xyz, r1
rcp o3.x, r0.w
mul o5.xyz, r0.x, v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedchkhmlegdebkngeklcfmincfpkjchoelabaaaaaaoiaeaaaaadaaaaaa
cmaaaaaajmaaaaaagmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcheadaaaaeaaaabaannaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaa
abaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaapaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaa
egbobaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaaeaaaaaapgapbaaaaaaaaaaaegbcbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_1 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD3 = normalize((tmpvar_1 - tmpvar_2));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  lowp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_3;
  p_3 = (tmpvar_1 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = sqrt(dot (p_3, p_3));
  xlv_TEXCOORD3 = normalize((tmpvar_1 - tmpvar_2));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  lowp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
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
#line 410
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
};
#line 403
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
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 393
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 397
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 401
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 421
#line 446
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 421
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 425
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 429
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 433
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
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
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
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
#line 410
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
};
#line 403
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
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 393
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 397
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 401
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 421
#line 446
#line 435
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 437
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 441
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 446
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 450
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 454
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 458
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 462
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    #line 466
    highp float distLerp = xll_saturate_f((0.0001 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    #line 470
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 474
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD3 = normalize((tmpvar_2 - tmpvar_3));
  xlv_TEXCOORD4 = normalize(gl_Vertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD4.y);
  uv_1.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD4.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD4.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_1, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_19;
  p_19 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_20;
  p_20 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_17.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r2.xyz, -r0, c8
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r3.xyz, r0, -r1
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mov o1.xyz, r0
dp4 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r1.w, r3
mul o6.xyz, r0.w, r2
mov o2.xyz, r1
rcp o3.x, r0.w
mul o5.xyz, r0.x, v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedifbpcdimabdphaedijdongjlalnicnbkabaaaaaaaaafaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcheadaaaaeaaaabaannaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
iccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaa
aaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaa
pgapbaaaaaaaaaaaegbcbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD3 = normalize((tmpvar_2 - tmpvar_3));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD3 = normalize((tmpvar_2 - tmpvar_3));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_OFF" }
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
#line 326
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 421
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
};
#line 414
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
#line 315
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 336
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 349
#line 357
#line 371
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 404
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 408
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 412
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 433
#line 458
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 433
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 437
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 441
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 445
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval._LightCoord);
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
#line 326
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 421
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
};
#line 414
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
#line 315
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 336
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 349
#line 357
#line 371
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 404
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 408
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 412
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 433
#line 458
#line 447
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 449
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 453
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 458
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 462
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 466
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 470
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 474
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    #line 478
    highp float distLerp = xll_saturate_f((0.0001 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    #line 482
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 486
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD3 = normalize((tmpvar_2 - tmpvar_3));
  xlv_TEXCOORD4 = normalize(gl_Vertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD4.y);
  uv_1.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD4.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD4.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_1, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_19;
  p_19 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_20;
  p_20 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_17.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r2.xyz, -r0, c8
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r3.xyz, r0, -r1
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mov o1.xyz, r0
dp4 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r1.w, r3
mul o6.xyz, r0.w, r2
mov o2.xyz, r1
rcp o3.x, r0.w
mul o5.xyz, r0.x, v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkojddmoijfcaoigfcinlpgalflkocjepabaaaaaaaaafaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcheadaaaaeaaaabaannaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
iccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaa
aaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaa
pgapbaaaaaaaaaaaegbcbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD3 = normalize((tmpvar_2 - tmpvar_3));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD3 = normalize((tmpvar_2 - tmpvar_3));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
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
#line 318
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
};
#line 406
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
#line 315
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 328
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 341
#line 349
#line 363
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 396
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 400
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 404
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 425
#line 450
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 425
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 429
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 433
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 437
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
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
#line 318
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 413
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
};
#line 406
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
#line 315
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 328
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 341
#line 349
#line 363
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 396
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 400
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 404
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 425
#line 450
#line 439
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 441
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 445
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 450
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 454
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 458
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 462
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 466
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    #line 470
    highp float distLerp = xll_saturate_f((0.0001 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    #line 474
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 478
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec2 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD3 = normalize((tmpvar_2 - tmpvar_3));
  xlv_TEXCOORD4 = normalize(gl_Vertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD4.y);
  uv_1.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD4.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD4.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_1, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_19;
  p_19 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_20;
  p_20 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_17.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r2.xyz, -r0, c8
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r3.xyz, r0, -r1
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mov o1.xyz, r0
dp4 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r1.w, r3
mul o6.xyz, r0.w, r2
mov o2.xyz, r1
rcp o3.x, r0.w
mul o5.xyz, r0.x, v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmeiciapghipfbapafcjhpnkfkfcihmmgabaaaaaaaaafaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcheadaaaaeaaaabaannaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
iccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaa
aaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaa
pgapbaaaaaaaaaaaegbcbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD3 = normalize((tmpvar_2 - tmpvar_3));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  lowp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD3 = normalize((tmpvar_2 - tmpvar_3));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  lowp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
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
#line 317
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 412
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec2 _LightCoord;
};
#line 405
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
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 327
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 340
#line 348
#line 362
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 395
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 399
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 403
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 424
#line 449
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 424
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 428
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 432
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 436
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec2 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec2(xl_retval._LightCoord);
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
#line 317
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 412
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec2 _LightCoord;
};
#line 405
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
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 327
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 340
#line 348
#line 362
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 395
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 399
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 403
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 424
#line 449
#line 438
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 440
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 444
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 449
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 453
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 457
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 461
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 465
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    #line 469
    highp float distLerp = xll_saturate_f((0.0001 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    #line 473
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 477
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec2 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(gl_Vertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD4.y);
  uv_1.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD4.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD4.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_1, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_19;
  p_19 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_20;
  p_20 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_17.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r2.xyz, -r0, c8
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r3.xyz, r0, -r1
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mov o1.xyz, r0
dp4 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r1.w, r3
mul o6.xyz, r0.w, r2
mov o2.xyz, r1
rcp o3.x, r0.w
mul o5.xyz, r0.x, v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedobajmilmmlildbkfejmfaknbclhbjkooabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
headaaaaeaaaabaannaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaa
abaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaah
icaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaa
egbcbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
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
#line 332
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 427
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 420
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
#line 315
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 323
uniform sampler2D _LightTextureB0;
#line 328
#line 342
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 355
#line 363
#line 377
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 410
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 414
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 418
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 440
#line 465
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 440
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 444
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 448
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 452
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
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
#line 332
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 427
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 420
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
#line 315
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 323
uniform sampler2D _LightTextureB0;
#line 328
#line 342
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 355
#line 363
#line 377
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 410
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 414
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 418
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 440
#line 465
#line 454
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 456
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 460
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 465
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 469
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 473
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 477
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 481
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    #line 485
    highp float distLerp = xll_saturate_f((0.0001 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    #line 489
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 493
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(gl_Vertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD4.y);
  uv_1.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD4.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD4.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_1, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_19;
  p_19 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_20;
  p_20 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_17.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r2.xyz, -r0, c8
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r3.xyz, r0, -r1
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mov o1.xyz, r0
dp4 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r1.w, r3
mul o6.xyz, r0.w, r2
mov o2.xyz, r1
rcp o3.x, r0.w
mul o5.xyz, r0.x, v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedobajmilmmlildbkfejmfaknbclhbjkooabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
headaaaaeaaaabaannaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaa
abaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaah
icaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaa
egbcbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
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
#line 333
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 428
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 421
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
#line 315
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
#line 323
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 343
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 356
#line 364
#line 378
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 411
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 415
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 419
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 441
#line 466
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 441
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 445
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 449
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 453
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
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
#line 333
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 428
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 421
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
#line 315
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
#line 323
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 343
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 356
#line 364
#line 378
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 411
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 415
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 419
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 441
#line 466
#line 455
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 457
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 461
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 466
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 470
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 474
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 478
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 482
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    #line 486
    highp float distLerp = xll_saturate_f((0.0001 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    #line 490
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 494
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD3 = normalize((tmpvar_2 - tmpvar_3));
  xlv_TEXCOORD4 = normalize(gl_Vertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD4.y);
  uv_1.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD4.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD4.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_1, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_19;
  p_19 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_20;
  p_20 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_17.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r2.xyz, -r0, c8
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r3.xyz, r0, -r1
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mov o1.xyz, r0
dp4 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r1.w, r3
mul o6.xyz, r0.w, r2
mov o2.xyz, r1
rcp o3.x, r0.w
mul o5.xyz, r0.x, v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedifbpcdimabdphaedijdongjlalnicnbkabaaaaaaaaafaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcheadaaaaeaaaabaannaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
iccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaa
aaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabbaaaaahicaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaa
pgapbaaaaaaaaaaaegbcbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD3 = normalize((tmpvar_2 - tmpvar_3));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  lowp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = sqrt(dot (p_4, p_4));
  xlv_TEXCOORD3 = normalize((tmpvar_2 - tmpvar_3));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  lowp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
#line 418
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
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
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 405
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 409
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 430
#line 455
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 430
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 434
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 438
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 442
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval._ShadowCoord);
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
#line 323
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
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
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
#line 315
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 333
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 346
#line 354
#line 368
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 405
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 409
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 430
#line 455
#line 444
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 446
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 450
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 455
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 459
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 463
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 467
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 471
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    #line 475
    highp float distLerp = xll_saturate_f((0.0001 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    #line 479
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 483
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
varying vec2 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 tmpvar_1;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(gl_Vertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD4.y);
  uv_1.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD4.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD4.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_1, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_19;
  p_19 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_20;
  p_20 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_17.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r2.xyz, -r0, c8
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r3.xyz, r0, -r1
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mov o1.xyz, r0
dp4 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r1.w, r3
mul o6.xyz, r0.w, r2
mov o2.xyz, r1
rcp o3.x, r0.w
mul o5.xyz, r0.x, v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedfgccmabolgfgheelcdiocafaaegjbgjhabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadapaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
headaaaaeaaaabaannaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaa
abaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaah
icaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaa
egbcbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  lowp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  lowp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
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
#line 325
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 420
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec2 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 413
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
#line 323
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 335
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 348
#line 356
#line 370
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 403
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 407
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 411
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 433
#line 458
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 433
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 437
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 441
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 445
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec2 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec2(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
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
#line 325
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 420
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec2 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 413
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
#line 323
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 335
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 348
#line 356
#line 370
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 403
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 407
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 411
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 433
#line 458
#line 447
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 449
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 453
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 458
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 462
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 466
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 470
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 474
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    #line 478
    highp float distLerp = xll_saturate_f((0.0001 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    #line 482
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 486
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec2 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(gl_Vertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD4.y);
  uv_1.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD4.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD4.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_1, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_19;
  p_19 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_20;
  p_20 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_17.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r2.xyz, -r0, c8
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r3.xyz, r0, -r1
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mov o1.xyz, r0
dp4 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r1.w, r3
mul o6.xyz, r0.w, r2
mov o2.xyz, r1
rcp o3.x, r0.w
mul o5.xyz, r0.x, v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedegkoojmfbjfjfmjhdohpanjhlfffnpklabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
headaaaaeaaaabaannaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaa
abaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaah
icaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaa
egbcbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" }
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
#line 330
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 425
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 418
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
#line 315
uniform samplerCube _ShadowMapTexture;
#line 328
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 340
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 353
#line 361
#line 375
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 408
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 412
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 416
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 438
#line 463
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 438
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 442
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 446
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 450
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec3(xl_retval._ShadowCoord);
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
#line 330
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 425
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 418
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
#line 315
uniform samplerCube _ShadowMapTexture;
#line 328
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 340
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 353
#line 361
#line 375
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 408
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 412
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 416
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 438
#line 463
#line 452
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 454
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 458
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 463
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 467
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 471
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 475
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 479
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    #line 483
    highp float distLerp = xll_saturate_f((0.0001 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    #line 487
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 491
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD7);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(gl_Vertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD4.y);
  uv_1.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD4.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD4.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_1, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_19;
  p_19 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_20;
  p_20 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_17.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r2.xyz, -r0, c8
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r3.xyz, r0, -r1
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mov o1.xyz, r0
dp4 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r1.w, r3
mul o6.xyz, r0.w, r2
mov o2.xyz, r1
rcp o3.x, r0.w
mul o5.xyz, r0.x, v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedegkoojmfbjfjfmjhdohpanjhlfffnpklabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
headaaaaeaaaabaannaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaa
abaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaah
icaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaa
egbcbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
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
#line 331
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
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
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
#line 315
uniform samplerCube _ShadowMapTexture;
#line 328
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 341
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 354
#line 362
#line 376
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 409
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 413
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 417
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 439
#line 464
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 439
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 443
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 447
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 451
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec3(xl_retval._ShadowCoord);
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
#line 331
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
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
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
#line 315
uniform samplerCube _ShadowMapTexture;
#line 328
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 341
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 354
#line 362
#line 376
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 409
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 413
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 417
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 439
#line 464
#line 453
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 455
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 459
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 464
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 468
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 472
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 476
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 480
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    #line 484
    highp float distLerp = xll_saturate_f((0.0001 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    #line 488
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 492
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD7);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(gl_Vertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD4.y);
  uv_1.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD4.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD4.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_1, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_19;
  p_19 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_20;
  p_20 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_17.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r2.xyz, -r0, c8
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r3.xyz, r0, -r1
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mov o1.xyz, r0
dp4 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r1.w, r3
mul o6.xyz, r0.w, r2
mov o2.xyz, r1
rcp o3.x, r0.w
mul o5.xyz, r0.x, v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedobajmilmmlildbkfejmfaknbclhbjkooabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
headaaaaeaaaabaannaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaa
abaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaah
icaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaa
egbcbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
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
#line 340
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 435
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 428
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
#line 315
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 331
uniform sampler2D _LightTextureB0;
#line 336
#line 350
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 363
#line 371
#line 385
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 418
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 422
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 426
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 448
#line 473
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 448
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 452
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 456
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 460
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
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
#line 340
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 435
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 428
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
#line 315
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 331
uniform sampler2D _LightTextureB0;
#line 336
#line 350
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 363
#line 371
#line 385
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 418
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 422
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 426
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 448
#line 473
#line 462
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 464
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 468
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 473
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 477
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 481
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 485
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 489
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    #line 493
    highp float distLerp = xll_saturate_f((0.0001 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    #line 497
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 501
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(gl_Vertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD4.y);
  uv_1.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD4.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD4.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_1, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_19;
  p_19 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_20;
  p_20 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_17.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r2.xyz, -r0, c8
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r3.xyz, r0, -r1
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mov o1.xyz, r0
dp4 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r1.w, r3
mul o6.xyz, r0.w, r2
mov o2.xyz, r1
rcp o3.x, r0.w
mul o5.xyz, r0.x, v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedobajmilmmlildbkfejmfaknbclhbjkooabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
headaaaaeaaaabaannaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaa
abaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaah
icaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaa
egbcbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
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
#line 340
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 435
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 428
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
#line 315
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 331
uniform sampler2D _LightTextureB0;
#line 336
#line 350
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 363
#line 371
#line 385
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 418
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 422
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 426
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 448
#line 473
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 448
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 452
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 456
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 460
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
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
#line 340
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 435
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 428
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
#line 315
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 331
uniform sampler2D _LightTextureB0;
#line 336
#line 350
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 363
#line 371
#line 385
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 418
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 422
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 426
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 448
#line 473
#line 462
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 464
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 468
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 473
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 477
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 481
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 485
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 489
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    #line 493
    highp float distLerp = xll_saturate_f((0.0001 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    #line 497
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 501
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(gl_Vertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD4.y);
  uv_1.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD4.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD4.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_1, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_19;
  p_19 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_20;
  p_20 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_17.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r2.xyz, -r0, c8
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r3.xyz, r0, -r1
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mov o1.xyz, r0
dp4 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r1.w, r3
mul o6.xyz, r0.w, r2
mov o2.xyz, r1
rcp o3.x, r0.w
mul o5.xyz, r0.x, v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedegkoojmfbjfjfmjhdohpanjhlfffnpklabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
headaaaaeaaaabaannaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaa
abaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaah
icaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaa
egbcbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
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
#line 336
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 431
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 424
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
#line 315
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
#line 335
uniform highp mat4 _LightMatrix0;
#line 346
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 359
#line 367
#line 381
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 414
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 418
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 422
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 444
#line 469
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 444
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 448
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 452
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 456
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec3(xl_retval._ShadowCoord);
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
#line 336
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 431
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 424
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
#line 315
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
#line 335
uniform highp mat4 _LightMatrix0;
#line 346
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 359
#line 367
#line 381
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 414
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 418
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 422
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 444
#line 469
#line 458
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 460
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 464
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 469
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 473
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 477
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 481
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 485
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    #line 489
    highp float distLerp = xll_saturate_f((0.0001 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    #line 493
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 497
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD7);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(gl_Vertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 uv_1;
  vec4 color_2;
  float r_3;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD4.y);
  uv_1.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD4.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD4.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_1, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_18;
  p_18 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_19;
  p_19 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_20;
  p_20 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_17.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
add r2.xyz, -r0, c8
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r3.xyz, r0, -r1
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mov o1.xyz, r0
dp4 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r1.w, r3
mul o6.xyz, r0.w, r2
mov o2.xyz, r1
rcp o3.x, r0.w
mul o5.xyz, r0.x, v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedegkoojmfbjfjfmjhdohpanjhlfffnpklabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
headaaaaeaaaabaannaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaa
abaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaah
icaabaaaaaaaaaaaegbobaaaaaaaaaaaegbobaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaa
egbcbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD3 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD4 = normalize(_glesVertex).xyz;
  xlv_TEXCOORD5 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float NdotL_2;
  mediump vec3 lightDirection_3;
  mediump vec3 ambientLighting_4;
  mediump float detailLevel_5;
  mediump vec4 detail_6;
  mediump vec4 detailZ_7;
  mediump vec4 detailY_8;
  mediump vec4 detailX_9;
  mediump vec4 main_10;
  highp vec2 uv_11;
  mediump vec4 color_12;
  highp float r_13;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  highp float x_17;
  x_17 = -(xlv_TEXCOORD4.y);
  uv_11.y = (0.31831 * (1.5708 - (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))))));
  highp float r_18;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_22;
  tmpvar_22 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22);
  lowp vec4 tmpvar_26;
  tmpvar_26 = (texture2DGradEXT (_MainTex, uv_11, tmpvar_25.xy, tmpvar_25.zw) * _Color);
  main_10 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailX_9 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_29 = texture2D (_DetailTex, P_30);
  detailY_8 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailZ_7 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_34;
  tmpvar_34 = mix (detailZ_7, detailX_9, tmpvar_33.xxxx);
  detail_6 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (detail_6, detailY_8, tmpvar_33.yyyy);
  detail_6 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_38;
  p_38 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_39;
  p_39 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_40;
  p_40 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_41;
  tmpvar_41 = mix (0.0, tmpvar_37.w, mix (clamp (((_FadeScale * sqrt(dot (p_38, p_38))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((0.0001 * (sqrt(dot (p_39, p_39)) - (1.05 * sqrt(dot (p_40, p_40))))), 0.0, 1.0)));
  color_12.w = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_45)), 0.0, 1.0);
  color_12.xyz = (tmpvar_37.xyz * tmpvar_46);
  tmpvar_1 = color_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
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
#line 337
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 432
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 425
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
#line 315
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
#line 335
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 347
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 360
#line 368
#line 382
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 415
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 419
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 423
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 445
#line 470
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 445
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 449
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 453
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 457
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD1 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD2 = float(xl_retval.viewDist);
    xlv_TEXCOORD3 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD4 = vec3(xl_retval.objNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec3(xl_retval._ShadowCoord);
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
#line 337
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 432
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 425
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
#line 315
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
#line 335
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 347
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 360
#line 368
#line 382
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 415
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
#line 419
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _FadeDist;
#line 423
uniform highp float _FadeScale;
uniform highp float _RimDist;
#line 445
#line 470
#line 459
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 461
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 465
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 470
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 474
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 478
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 482
    objNrm = abs(objNrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 486
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    #line 490
    highp float distLerp = xll_saturate_f((0.0001 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    #line 494
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 498
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    color.xyz *= xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    return color;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD0);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDist = float(xlv_TEXCOORD2);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD3);
    xlt_IN.objNormal = vec3(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD7);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 15
//   d3d9 - ALU: 117 to 117, TEX: 6 to 6
//   d3d11 - ALU: 88 to 88, TEX: 3 to 3, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_DetailOffset]
Float 6 [_FalloffPow]
Float 7 [_FalloffScale]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 117 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, 1.04999995, 0.00010000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v4.zyzw, c8.x
add r0.xy, r0, c5
texld r2, r0, s1
mul r1.xy, v4, c8.x
dsy r3.zw, v4.xyxy
abs r0.zw, v4.xyxy
abs r0.x, v4.z
max r0.y, r0.x, r0.z
rcp r1.z, r0.y
min r0.y, r0.x, r0.z
mul r3.x, r0.y, r1.z
mul r0.y, r3.x, r3.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r2, r2, -r1
mad_pp r2, r0.z, r2, r1
mad r3.y, r0, c15, c15.z
mad r1.z, r3.y, r0.y, c15.w
mad r1.z, r1, r0.y, c16.x
mad r3.y, r1.z, r0, c16
mul r1.xy, v4.zxzw, c8.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r1, r1, -r2
mad_pp r2, r0.w, r1, r2
mad r0.y, r3, r0, c16.z
mul r0.w, r0.y, r3.x
add r0.y, r0.x, -r0.z
add r3.x, -r0.w, c16.w
cmp r0.z, -r0.y, r0.w, r3.x
add r0.y, -r0.z, c13.z
cmp r0.y, v4.x, r0.z, r0
cmp r0.y, v4.z, r0, -r0
mad r3.x, r0.y, c17, c17.y
mad r0.y, r0.x, c14.x, c14
mul r0.w, v2.x, c9.x
dp4 r0.z, c2, c2
add_pp r1, -r2, c13.y
mul_sat r0.w, r0, c14
mad_pp r1, r0.w, r1, r2
abs r0.w, -v4.y
rsq r0.z, r0.z
mul r2.xyz, r0.z, c2
dp3_sat r2.x, v3, r2
add r0.z, -r0.x, c13.y
mad r0.y, r0.x, r0, c13.w
add r3.y, -r0.w, c13
mad r2.w, r0, c14.x, c14.y
mad r2.w, r2, r0, c13
rsq r0.z, r0.z
rsq r3.y, r3.y
mad r0.x, r0, r0.y, c14.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
mad r0.w, r2, r0, c14.z
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v4.y, c13.x, c13.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c14.w, r2.w
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.w, r0.y
dsx r0.xz, v4.xyyw
mul r0.xz, r0, r0
add r0.x, r0, r0.z
mul r3.zw, r3, r3
add r0.z, r3, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r2.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c17.x
mul r0.x, r2.w, c17
dsy r0.y, r0
texldd r0, r3, s0, r0.zwzw, r0
add r3.xyz, -v1, c1
dp3 r2.w, r3, r3
mul r0, r0, c4
mul_pp r0, r0, r1
add_pp r2.x, r2, c17.z
mul_pp r1.y, r2.x, c3.w
mov r2.xyz, v0
add r2.xyz, v1, -r2
mul_pp_sat r1.w, r1.y, c17
mov r1.x, c10
add r1.xyz, c3, r1.x
mad_sat r1.xyz, r1, r1.w, c0
dp3 r1.w, r2, r2
rsq r2.x, r2.w
mov r3.xyz, v3
rsq r1.w, r1.w
dp3 r2.w, v5, r3
rcp r2.x, r2.x
rcp r1.w, r1.w
mad r1.w, -r1, c18.x, r2.x
add r2.xyz, -v0, c1
dp3 r2.y, r2, r2
abs_sat r2.x, r2.w
rsq r2.y, r2.y
rcp r3.y, r2.y
mul r3.x, r2, c7
pow_sat r2, r3.x, c6.x
mul r2.y, r3, c12.x
add_sat r2.y, r2, -c11.x
add r2.x, r2, -r2.y
mul_sat r1.w, r1, c18.y
mad r1.w, r1, r2.x, r2.y
mul_pp oC0.xyz, r0, r1
mul_pp oC0.w, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 172 used size, 14 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 144 [_FalloffPow]
Float 148 [_FalloffScale]
Float 152 [_DetailScale]
Float 156 [_DetailDist]
Float 160 [_MinLight]
Float 164 [_FadeDist]
Float 168 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 94 instructions, 4 temp regs, 0 temp arrays:
// ALU 84 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedpcpgfnphhmoglcheedanihfedepeijeiabaaaaaabeaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
icbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaiaibaaaaaa
aeaaaaaackbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaa
aaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlo
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
diphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaajicaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaia
ibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaaagbcbaaaaeaaaaaaagbcbaia
ebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
nlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaadbaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadp
alaaaaafdcaabaaaabaaaaaaegbabaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaabaaaaaaegaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdo
amaaaaafmcaabaaaabaaaaaaagbebaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaa
ogakbaaaabaaaaaaogakbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdo
dbaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaaeaaaaaabkbabaaaaeaaaaaa
dcaaaabamcaabaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaadagojjlmdagojjlmaceaaaaaaaaaaaaaaaaaaaaachbgjidnchbgjidn
dcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaiedefjloiedefjlodcaaaaanmcaabaaaabaaaaaa
kgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
keanmjdpkeanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaa
kgaobaaaacaaaaaadiaaaaahdcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaa
acaaaaaadcaaaaapdcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaama
aaaaaamaaaaaaaaaaaaaaaaaaceaaaaanlapejeanlapejeaaaaaaaaaaaaaaaaa
abaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgabbaaaadaaaaaadcaaaaaj
ecaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaa
dcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaackaabaaaacaaaaaadkaabaaa
aaaaaaaadiaaaaakgcaabaaaaaaaaaaapgaobaaaaaaaaaaaaceaaaaaaaaaaaaa
idpjkcdoidpjkcdoaaaaaaaaalaaaaafccaabaaaabaaaaaackaabaaaaaaaaaaa
amaaaaafccaabaaaacaaaaaackaabaaaaaaaaaaaejaaaaanpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaahaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaa
aaaaaaaaajaaaaaaegiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
dcaabaaaadaaaaaaegbabaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaaegiacaaa
aaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaa
aeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
fgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaal
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaa
aaaaaaaaajaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaia
ebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaa
dicaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdibaaaaaah
ccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaa
abaaaaaabkaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaacpaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaaaaaaaaaajaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaa
ddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaj
hcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaackiacaaa
aaaaaaaaakaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaakaaaaaa
aaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
bbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaa
aaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaa
agiacaaaaaaaaaaaakaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_DetailOffset]
Float 6 [_FalloffPow]
Float 7 [_FalloffScale]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 117 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, 1.04999995, 0.00010000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v4.zyzw, c8.x
add r0.xy, r0, c5
texld r2, r0, s1
mul r1.xy, v4, c8.x
dsy r3.zw, v4.xyxy
abs r0.zw, v4.xyxy
abs r0.x, v4.z
max r0.y, r0.x, r0.z
rcp r1.z, r0.y
min r0.y, r0.x, r0.z
mul r3.x, r0.y, r1.z
mul r0.y, r3.x, r3.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r2, r2, -r1
mad_pp r2, r0.z, r2, r1
mad r3.y, r0, c15, c15.z
mad r1.z, r3.y, r0.y, c15.w
mad r1.z, r1, r0.y, c16.x
mad r3.y, r1.z, r0, c16
mul r1.xy, v4.zxzw, c8.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r1, r1, -r2
mad_pp r2, r0.w, r1, r2
mad r0.y, r3, r0, c16.z
mul r0.w, r0.y, r3.x
add r0.y, r0.x, -r0.z
add r3.x, -r0.w, c16.w
cmp r0.z, -r0.y, r0.w, r3.x
add r0.y, -r0.z, c13.z
cmp r0.y, v4.x, r0.z, r0
cmp r0.y, v4.z, r0, -r0
mad r3.x, r0.y, c17, c17.y
mad r0.y, r0.x, c14.x, c14
mul r0.w, v2.x, c9.x
dp4_pp r0.z, c2, c2
add_pp r1, -r2, c13.y
mul_sat r0.w, r0, c14
mad_pp r1, r0.w, r1, r2
abs r0.w, -v4.y
rsq_pp r0.z, r0.z
mul_pp r2.xyz, r0.z, c2
dp3_sat r2.x, v3, r2
add r0.z, -r0.x, c13.y
mad r0.y, r0.x, r0, c13.w
add r3.y, -r0.w, c13
mad r2.w, r0, c14.x, c14.y
mad r2.w, r2, r0, c13
rsq r0.z, r0.z
rsq r3.y, r3.y
mad r0.x, r0, r0.y, c14.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
mad r0.w, r2, r0, c14.z
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v4.y, c13.x, c13.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c14.w, r2.w
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.w, r0.y
dsx r0.xz, v4.xyyw
mul r0.xz, r0, r0
add r0.x, r0, r0.z
mul r3.zw, r3, r3
add r0.z, r3, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r2.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c17.x
mul r0.x, r2.w, c17
dsy r0.y, r0
texldd r0, r3, s0, r0.zwzw, r0
add r3.xyz, -v1, c1
dp3 r2.w, r3, r3
mul r0, r0, c4
mul_pp r0, r0, r1
add_pp r2.x, r2, c17.z
mul_pp r1.y, r2.x, c3.w
mov r2.xyz, v0
add r2.xyz, v1, -r2
mul_pp_sat r1.w, r1.y, c17
mov r1.x, c10
add r1.xyz, c3, r1.x
mad_sat r1.xyz, r1, r1.w, c0
dp3 r1.w, r2, r2
rsq r2.x, r2.w
mov r3.xyz, v3
rsq r1.w, r1.w
dp3 r2.w, v5, r3
rcp r2.x, r2.x
rcp r1.w, r1.w
mad r1.w, -r1, c18.x, r2.x
add r2.xyz, -v0, c1
dp3 r2.y, r2, r2
abs_sat r2.x, r2.w
rsq r2.y, r2.y
rcp r3.y, r2.y
mul r3.x, r2, c7
pow_sat r2, r3.x, c6.x
mul r2.y, r3, c12.x
add_sat r2.y, r2, -c11.x
add r2.x, r2, -r2.y
mul_sat r1.w, r1, c18.y
mad r1.w, r1, r2.x, r2.y
mul_pp oC0.xyz, r0, r1
mul_pp oC0.w, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
ConstBuffer "$Globals" 112 // 108 used size, 13 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Vector 64 [_DetailOffset] 4
Float 80 [_FalloffPow]
Float 84 [_FalloffScale]
Float 88 [_DetailScale]
Float 92 [_DetailDist]
Float 96 [_MinLight]
Float 100 [_FadeDist]
Float 104 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 94 instructions, 4 temp regs, 0 temp arrays:
// ALU 84 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkhgpigjalfkjoclgjmdlcleadcimihnjabaaaaaapmanaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmeamaaaaeaaaaaaadbadaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaa
akbabaiaibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
ddaaaaajccaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaiaibaaaaaa
aeaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
ochgdidodcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaaaaaaaaaaakbabaiaibaaaaaa
aeaaaaaackbabaiaibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaaagbcbaaa
aeaaaaaaagbcbaiaebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaddaaaaahccaabaaaaaaaaaaaakbabaaaaeaaaaaackbabaaa
aeaaaaaadbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadeaaaaahicaabaaaaaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaa
bnaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaak
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdo
abeaaaaaaaaaaadpalaaaaafdcaabaaaabaaaaaaegbabaaaaeaaaaaaapaaaaah
icaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaabaaaaaaagbebaaaaeaaaaaaapaaaaah
icaabaaaaaaaaaaaogakbaaaabaaaaaaogakbaaaabaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaa
abeaaaaaidpjccdodbaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaaeaaaaaa
bkbabaaaaeaaaaaadcaaaabamcaabaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaadagojjlmdagojjlmaceaaaaaaaaaaaaaaaaaaaaa
chbgjidnchbgjidndcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaafgbjbaia
ibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaiedefjloiedefjlodcaaaaan
mcaabaaaabaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaakeanmjdpkeanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaia
mbaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaaf
mcaabaaaacaaaaaakgaobaaaacaaaaaadiaaaaahdcaabaaaadaaaaaaogakbaaa
abaaaaaaogakbaaaacaaaaaadcaaaaapdcaabaaaadaaaaaaegaabaaaadaaaaaa
aceaaaaaaaaaaamaaaaaaamaaaaaaaaaaaaaaaaaaceaaaaanlapejeanlapejea
aaaaaaaaaaaaaaaaabaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgabbaaa
adaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaa
ckaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaackaabaaa
acaaaaaadkaabaaaaaaaaaaadiaaaaakgcaabaaaaaaaaaaapgaobaaaaaaaaaaa
aceaaaaaaaaaaaaaidpjkcdoidpjkcdoaaaaaaaaalaaaaafccaabaaaabaaaaaa
ckaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaackaabaaaaaaaaaaaejaaaaan
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
egaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegiocaaaaaaaaaaaadaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaa
aeaaaaaakgikcaaaaaaaaaaaafaaaaaaegiecaaaaaaaaaaaaeaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaldcaabaaaadaaaaaaegbabaaaaeaaaaaakgikcaaaaaaaaaaa
afaaaaaaegiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaa
agbabaiaibaaaaaaaeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaak
pcaabaaaabaaaaaafgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaaaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaa
abaaaaaapgipcaaaaaaaaaaaafaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaa
adaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaa
acaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaa
abaaaaaaagbjbaiaebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaa
abaaaaaajgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaa
dcaaaaakbcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaggggigdp
akaabaaaabaaaaaadicaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
bhlhnbdibaaaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaa
ddaaaaaiccaabaaaabaaaaaabkaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadp
diaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaafaaaaaa
cpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaa
bkaabaaaabaaaaaaakiacaaaaaaaaaaaafaaaaaabjaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaiadpaaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaa
abaaaaaackiacaaaaaaaaaaaagaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaa
aaaaaaaaagaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaackaabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
bacaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaadicaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaa
aaaaaaaaabaaaaaaagiacaaaaaaaaaaaagaaaaaadccaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_DetailOffset]
Float 6 [_FalloffPow]
Float 7 [_FalloffScale]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 117 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, 1.04999995, 0.00010000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v4.zyzw, c8.x
add r0.xy, r0, c5
texld r2, r0, s1
mul r1.xy, v4, c8.x
dsy r3.zw, v4.xyxy
abs r0.zw, v4.xyxy
abs r0.x, v4.z
max r0.y, r0.x, r0.z
rcp r1.z, r0.y
min r0.y, r0.x, r0.z
mul r3.x, r0.y, r1.z
mul r0.y, r3.x, r3.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r2, r2, -r1
mad_pp r2, r0.z, r2, r1
mad r3.y, r0, c15, c15.z
mad r1.z, r3.y, r0.y, c15.w
mad r1.z, r1, r0.y, c16.x
mad r3.y, r1.z, r0, c16
mul r1.xy, v4.zxzw, c8.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r1, r1, -r2
mad_pp r2, r0.w, r1, r2
mad r0.y, r3, r0, c16.z
mul r0.w, r0.y, r3.x
add r0.y, r0.x, -r0.z
add r3.x, -r0.w, c16.w
cmp r0.z, -r0.y, r0.w, r3.x
add r0.y, -r0.z, c13.z
cmp r0.y, v4.x, r0.z, r0
cmp r0.y, v4.z, r0, -r0
mad r3.x, r0.y, c17, c17.y
mad r0.y, r0.x, c14.x, c14
mul r0.w, v2.x, c9.x
dp4 r0.z, c2, c2
add_pp r1, -r2, c13.y
mul_sat r0.w, r0, c14
mad_pp r1, r0.w, r1, r2
abs r0.w, -v4.y
rsq r0.z, r0.z
mul r2.xyz, r0.z, c2
dp3_sat r2.x, v3, r2
add r0.z, -r0.x, c13.y
mad r0.y, r0.x, r0, c13.w
add r3.y, -r0.w, c13
mad r2.w, r0, c14.x, c14.y
mad r2.w, r2, r0, c13
rsq r0.z, r0.z
rsq r3.y, r3.y
mad r0.x, r0, r0.y, c14.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
mad r0.w, r2, r0, c14.z
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v4.y, c13.x, c13.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c14.w, r2.w
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.w, r0.y
dsx r0.xz, v4.xyyw
mul r0.xz, r0, r0
add r0.x, r0, r0.z
mul r3.zw, r3, r3
add r0.z, r3, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r2.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c17.x
mul r0.x, r2.w, c17
dsy r0.y, r0
texldd r0, r3, s0, r0.zwzw, r0
add r3.xyz, -v1, c1
dp3 r2.w, r3, r3
mul r0, r0, c4
mul_pp r0, r0, r1
add_pp r2.x, r2, c17.z
mul_pp r1.y, r2.x, c3.w
mov r2.xyz, v0
add r2.xyz, v1, -r2
mul_pp_sat r1.w, r1.y, c17
mov r1.x, c10
add r1.xyz, c3, r1.x
mad_sat r1.xyz, r1, r1.w, c0
dp3 r1.w, r2, r2
rsq r2.x, r2.w
mov r3.xyz, v3
rsq r1.w, r1.w
dp3 r2.w, v5, r3
rcp r2.x, r2.x
rcp r1.w, r1.w
mad r1.w, -r1, c18.x, r2.x
add r2.xyz, -v0, c1
dp3 r2.y, r2, r2
abs_sat r2.x, r2.w
rsq r2.y, r2.y
rcp r3.y, r2.y
mul r3.x, r2, c7
pow_sat r2, r3.x, c6.x
mul r2.y, r3, c12.x
add_sat r2.y, r2, -c11.x
add r2.x, r2, -r2.y
mul_sat r1.w, r1, c18.y
mad r1.w, r1, r2.x, r2.y
mul_pp oC0.xyz, r0, r1
mul_pp oC0.w, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 172 used size, 14 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 144 [_FalloffPow]
Float 148 [_FalloffScale]
Float 152 [_DetailScale]
Float 156 [_DetailDist]
Float 160 [_MinLight]
Float 164 [_FadeDist]
Float 168 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 94 instructions, 4 temp regs, 0 temp arrays:
// ALU 84 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjmkopjbjplmdbjkcilcngeocgmlholhhabaaaaaabeaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
icbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaiaibaaaaaa
aeaaaaaackbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaa
aaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlo
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
diphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaajicaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaia
ibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaaagbcbaaaaeaaaaaaagbcbaia
ebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
nlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaadbaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadp
alaaaaafdcaabaaaabaaaaaaegbabaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaabaaaaaaegaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdo
amaaaaafmcaabaaaabaaaaaaagbebaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaa
ogakbaaaabaaaaaaogakbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdo
dbaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaaeaaaaaabkbabaaaaeaaaaaa
dcaaaabamcaabaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaadagojjlmdagojjlmaceaaaaaaaaaaaaaaaaaaaaachbgjidnchbgjidn
dcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaiedefjloiedefjlodcaaaaanmcaabaaaabaaaaaa
kgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
keanmjdpkeanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaa
kgaobaaaacaaaaaadiaaaaahdcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaa
acaaaaaadcaaaaapdcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaama
aaaaaamaaaaaaaaaaaaaaaaaaceaaaaanlapejeanlapejeaaaaaaaaaaaaaaaaa
abaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgabbaaaadaaaaaadcaaaaaj
ecaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaa
dcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaackaabaaaacaaaaaadkaabaaa
aaaaaaaadiaaaaakgcaabaaaaaaaaaaapgaobaaaaaaaaaaaaceaaaaaaaaaaaaa
idpjkcdoidpjkcdoaaaaaaaaalaaaaafccaabaaaabaaaaaackaabaaaaaaaaaaa
amaaaaafccaabaaaacaaaaaackaabaaaaaaaaaaaejaaaaanpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaahaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaa
aaaaaaaaajaaaaaaegiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
dcaabaaaadaaaaaaegbabaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaaegiacaaa
aaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaa
aeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
fgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaal
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaa
aaaaaaaaajaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaia
ebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaa
dicaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdibaaaaaah
ccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaa
abaaaaaabkaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaacpaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaaaaaaaaaajaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaa
ddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaj
hcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaackiacaaa
aaaaaaaaakaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaakaaaaaa
aaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
bbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaa
aaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaa
agiacaaaaaaaaaaaakaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_DetailOffset]
Float 6 [_FalloffPow]
Float 7 [_FalloffScale]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 117 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, 1.04999995, 0.00010000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v4.zyzw, c8.x
add r0.xy, r0, c5
texld r2, r0, s1
mul r1.xy, v4, c8.x
dsy r3.zw, v4.xyxy
abs r0.zw, v4.xyxy
abs r0.x, v4.z
max r0.y, r0.x, r0.z
rcp r1.z, r0.y
min r0.y, r0.x, r0.z
mul r3.x, r0.y, r1.z
mul r0.y, r3.x, r3.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r2, r2, -r1
mad_pp r2, r0.z, r2, r1
mad r3.y, r0, c15, c15.z
mad r1.z, r3.y, r0.y, c15.w
mad r1.z, r1, r0.y, c16.x
mad r3.y, r1.z, r0, c16
mul r1.xy, v4.zxzw, c8.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r1, r1, -r2
mad_pp r2, r0.w, r1, r2
mad r0.y, r3, r0, c16.z
mul r0.w, r0.y, r3.x
add r0.y, r0.x, -r0.z
add r3.x, -r0.w, c16.w
cmp r0.z, -r0.y, r0.w, r3.x
add r0.y, -r0.z, c13.z
cmp r0.y, v4.x, r0.z, r0
cmp r0.y, v4.z, r0, -r0
mad r3.x, r0.y, c17, c17.y
mad r0.y, r0.x, c14.x, c14
mul r0.w, v2.x, c9.x
dp4 r0.z, c2, c2
add_pp r1, -r2, c13.y
mul_sat r0.w, r0, c14
mad_pp r1, r0.w, r1, r2
abs r0.w, -v4.y
rsq r0.z, r0.z
mul r2.xyz, r0.z, c2
dp3_sat r2.x, v3, r2
add r0.z, -r0.x, c13.y
mad r0.y, r0.x, r0, c13.w
add r3.y, -r0.w, c13
mad r2.w, r0, c14.x, c14.y
mad r2.w, r2, r0, c13
rsq r0.z, r0.z
rsq r3.y, r3.y
mad r0.x, r0, r0.y, c14.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
mad r0.w, r2, r0, c14.z
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v4.y, c13.x, c13.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c14.w, r2.w
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.w, r0.y
dsx r0.xz, v4.xyyw
mul r0.xz, r0, r0
add r0.x, r0, r0.z
mul r3.zw, r3, r3
add r0.z, r3, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r2.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c17.x
mul r0.x, r2.w, c17
dsy r0.y, r0
texldd r0, r3, s0, r0.zwzw, r0
add r3.xyz, -v1, c1
dp3 r2.w, r3, r3
mul r0, r0, c4
mul_pp r0, r0, r1
add_pp r2.x, r2, c17.z
mul_pp r1.y, r2.x, c3.w
mov r2.xyz, v0
add r2.xyz, v1, -r2
mul_pp_sat r1.w, r1.y, c17
mov r1.x, c10
add r1.xyz, c3, r1.x
mad_sat r1.xyz, r1, r1.w, c0
dp3 r1.w, r2, r2
rsq r2.x, r2.w
mov r3.xyz, v3
rsq r1.w, r1.w
dp3 r2.w, v5, r3
rcp r2.x, r2.x
rcp r1.w, r1.w
mad r1.w, -r1, c18.x, r2.x
add r2.xyz, -v0, c1
dp3 r2.y, r2, r2
abs_sat r2.x, r2.w
rsq r2.y, r2.y
rcp r3.y, r2.y
mul r3.x, r2, c7
pow_sat r2, r3.x, c6.x
mul r2.y, r3, c12.x
add_sat r2.y, r2, -c11.x
add r2.x, r2, -r2.y
mul_sat r1.w, r1, c18.y
mad r1.w, r1, r2.x, r2.y
mul_pp oC0.xyz, r0, r1
mul_pp oC0.w, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 172 used size, 14 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 144 [_FalloffPow]
Float 148 [_FalloffScale]
Float 152 [_DetailScale]
Float 156 [_DetailDist]
Float 160 [_MinLight]
Float 164 [_FadeDist]
Float 168 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 94 instructions, 4 temp regs, 0 temp arrays:
// ALU 84 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedpcpgfnphhmoglcheedanihfedepeijeiabaaaaaabeaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
icbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaiaibaaaaaa
aeaaaaaackbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaa
aaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlo
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
diphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaajicaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaia
ibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaaagbcbaaaaeaaaaaaagbcbaia
ebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
nlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaadbaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadp
alaaaaafdcaabaaaabaaaaaaegbabaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaabaaaaaaegaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdo
amaaaaafmcaabaaaabaaaaaaagbebaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaa
ogakbaaaabaaaaaaogakbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdo
dbaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaaeaaaaaabkbabaaaaeaaaaaa
dcaaaabamcaabaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaadagojjlmdagojjlmaceaaaaaaaaaaaaaaaaaaaaachbgjidnchbgjidn
dcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaiedefjloiedefjlodcaaaaanmcaabaaaabaaaaaa
kgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
keanmjdpkeanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaa
kgaobaaaacaaaaaadiaaaaahdcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaa
acaaaaaadcaaaaapdcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaama
aaaaaamaaaaaaaaaaaaaaaaaaceaaaaanlapejeanlapejeaaaaaaaaaaaaaaaaa
abaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgabbaaaadaaaaaadcaaaaaj
ecaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaa
dcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaackaabaaaacaaaaaadkaabaaa
aaaaaaaadiaaaaakgcaabaaaaaaaaaaapgaobaaaaaaaaaaaaceaaaaaaaaaaaaa
idpjkcdoidpjkcdoaaaaaaaaalaaaaafccaabaaaabaaaaaackaabaaaaaaaaaaa
amaaaaafccaabaaaacaaaaaackaabaaaaaaaaaaaejaaaaanpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaahaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaa
aaaaaaaaajaaaaaaegiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
dcaabaaaadaaaaaaegbabaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaaegiacaaa
aaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaa
aeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
fgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaal
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaa
aaaaaaaaajaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaia
ebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaa
dicaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdibaaaaaah
ccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaa
abaaaaaabkaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaacpaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaaaaaaaaaajaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaa
ddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaj
hcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaackiacaaa
aaaaaaaaakaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaakaaaaaa
aaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
bbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaa
aaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaa
agiacaaaaaaaaaaaakaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_DetailOffset]
Float 6 [_FalloffPow]
Float 7 [_FalloffScale]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 117 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, 1.04999995, 0.00010000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v4.zyzw, c8.x
add r0.xy, r0, c5
texld r2, r0, s1
mul r1.xy, v4, c8.x
dsy r3.zw, v4.xyxy
abs r0.zw, v4.xyxy
abs r0.x, v4.z
max r0.y, r0.x, r0.z
rcp r1.z, r0.y
min r0.y, r0.x, r0.z
mul r3.x, r0.y, r1.z
mul r0.y, r3.x, r3.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r2, r2, -r1
mad_pp r2, r0.z, r2, r1
mad r3.y, r0, c15, c15.z
mad r1.z, r3.y, r0.y, c15.w
mad r1.z, r1, r0.y, c16.x
mad r3.y, r1.z, r0, c16
mul r1.xy, v4.zxzw, c8.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r1, r1, -r2
mad_pp r2, r0.w, r1, r2
mad r0.y, r3, r0, c16.z
mul r0.w, r0.y, r3.x
add r0.y, r0.x, -r0.z
add r3.x, -r0.w, c16.w
cmp r0.z, -r0.y, r0.w, r3.x
add r0.y, -r0.z, c13.z
cmp r0.y, v4.x, r0.z, r0
cmp r0.y, v4.z, r0, -r0
mad r3.x, r0.y, c17, c17.y
mad r0.y, r0.x, c14.x, c14
mul r0.w, v2.x, c9.x
dp4_pp r0.z, c2, c2
add_pp r1, -r2, c13.y
mul_sat r0.w, r0, c14
mad_pp r1, r0.w, r1, r2
abs r0.w, -v4.y
rsq_pp r0.z, r0.z
mul_pp r2.xyz, r0.z, c2
dp3_sat r2.x, v3, r2
add r0.z, -r0.x, c13.y
mad r0.y, r0.x, r0, c13.w
add r3.y, -r0.w, c13
mad r2.w, r0, c14.x, c14.y
mad r2.w, r2, r0, c13
rsq r0.z, r0.z
rsq r3.y, r3.y
mad r0.x, r0, r0.y, c14.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
mad r0.w, r2, r0, c14.z
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v4.y, c13.x, c13.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c14.w, r2.w
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.w, r0.y
dsx r0.xz, v4.xyyw
mul r0.xz, r0, r0
add r0.x, r0, r0.z
mul r3.zw, r3, r3
add r0.z, r3, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r2.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c17.x
mul r0.x, r2.w, c17
dsy r0.y, r0
texldd r0, r3, s0, r0.zwzw, r0
add r3.xyz, -v1, c1
dp3 r2.w, r3, r3
mul r0, r0, c4
mul_pp r0, r0, r1
add_pp r2.x, r2, c17.z
mul_pp r1.y, r2.x, c3.w
mov r2.xyz, v0
add r2.xyz, v1, -r2
mul_pp_sat r1.w, r1.y, c17
mov r1.x, c10
add r1.xyz, c3, r1.x
mad_sat r1.xyz, r1, r1.w, c0
dp3 r1.w, r2, r2
rsq r2.x, r2.w
mov r3.xyz, v3
rsq r1.w, r1.w
dp3 r2.w, v5, r3
rcp r2.x, r2.x
rcp r1.w, r1.w
mad r1.w, -r1, c18.x, r2.x
add r2.xyz, -v0, c1
dp3 r2.y, r2, r2
abs_sat r2.x, r2.w
rsq r2.y, r2.y
rcp r3.y, r2.y
mul r3.x, r2, c7
pow_sat r2, r3.x, c6.x
mul r2.y, r3, c12.x
add_sat r2.y, r2, -c11.x
add r2.x, r2, -r2.y
mul_sat r1.w, r1, c18.y
mad r1.w, r1, r2.x, r2.y
mul_pp oC0.xyz, r0, r1
mul_pp oC0.w, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 172 used size, 14 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 144 [_FalloffPow]
Float 148 [_FalloffScale]
Float 152 [_DetailScale]
Float 156 [_DetailDist]
Float 160 [_MinLight]
Float 164 [_FadeDist]
Float 168 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 94 instructions, 4 temp regs, 0 temp arrays:
// ALU 84 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedgdnhbefdmiagifgjljkcladgkddfmiagabaaaaaabeaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaadaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
icbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaiaibaaaaaa
aeaaaaaackbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaa
aaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlo
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
diphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaajicaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaia
ibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaaagbcbaaaaeaaaaaaagbcbaia
ebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
nlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaadbaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadp
alaaaaafdcaabaaaabaaaaaaegbabaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaabaaaaaaegaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdo
amaaaaafmcaabaaaabaaaaaaagbebaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaa
ogakbaaaabaaaaaaogakbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdo
dbaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaaeaaaaaabkbabaaaaeaaaaaa
dcaaaabamcaabaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaadagojjlmdagojjlmaceaaaaaaaaaaaaaaaaaaaaachbgjidnchbgjidn
dcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaiedefjloiedefjlodcaaaaanmcaabaaaabaaaaaa
kgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
keanmjdpkeanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaa
kgaobaaaacaaaaaadiaaaaahdcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaa
acaaaaaadcaaaaapdcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaama
aaaaaamaaaaaaaaaaaaaaaaaaceaaaaanlapejeanlapejeaaaaaaaaaaaaaaaaa
abaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgabbaaaadaaaaaadcaaaaaj
ecaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaa
dcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaackaabaaaacaaaaaadkaabaaa
aaaaaaaadiaaaaakgcaabaaaaaaaaaaapgaobaaaaaaaaaaaaceaaaaaaaaaaaaa
idpjkcdoidpjkcdoaaaaaaaaalaaaaafccaabaaaabaaaaaackaabaaaaaaaaaaa
amaaaaafccaabaaaacaaaaaackaabaaaaaaaaaaaejaaaaanpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaahaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaa
aaaaaaaaajaaaaaaegiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
dcaabaaaadaaaaaaegbabaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaaegiacaaa
aaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaa
aeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
fgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaal
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaa
aaaaaaaaajaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaia
ebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaa
dicaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdibaaaaaah
ccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaa
abaaaaaabkaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaacpaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaaaaaaaaaajaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaa
ddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaj
hcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaackiacaaa
aaaaaaaaakaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaakaaaaaa
aaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
bbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaa
aaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaa
agiacaaaaaaaaaaaakaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_DetailOffset]
Float 6 [_FalloffPow]
Float 7 [_FalloffScale]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 117 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, 1.04999995, 0.00010000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v4.zyzw, c8.x
add r0.xy, r0, c5
texld r2, r0, s1
mul r1.xy, v4, c8.x
dsy r3.zw, v4.xyxy
abs r0.zw, v4.xyxy
abs r0.x, v4.z
max r0.y, r0.x, r0.z
rcp r1.z, r0.y
min r0.y, r0.x, r0.z
mul r3.x, r0.y, r1.z
mul r0.y, r3.x, r3.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r2, r2, -r1
mad_pp r2, r0.z, r2, r1
mad r3.y, r0, c15, c15.z
mad r1.z, r3.y, r0.y, c15.w
mad r1.z, r1, r0.y, c16.x
mad r3.y, r1.z, r0, c16
mul r1.xy, v4.zxzw, c8.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r1, r1, -r2
mad_pp r2, r0.w, r1, r2
mad r0.y, r3, r0, c16.z
mul r0.w, r0.y, r3.x
add r0.y, r0.x, -r0.z
add r3.x, -r0.w, c16.w
cmp r0.z, -r0.y, r0.w, r3.x
add r0.y, -r0.z, c13.z
cmp r0.y, v4.x, r0.z, r0
cmp r0.y, v4.z, r0, -r0
mad r3.x, r0.y, c17, c17.y
mad r0.y, r0.x, c14.x, c14
mul r0.w, v2.x, c9.x
dp4 r0.z, c2, c2
add_pp r1, -r2, c13.y
mul_sat r0.w, r0, c14
mad_pp r1, r0.w, r1, r2
abs r0.w, -v4.y
rsq r0.z, r0.z
mul r2.xyz, r0.z, c2
dp3_sat r2.x, v3, r2
add r0.z, -r0.x, c13.y
mad r0.y, r0.x, r0, c13.w
add r3.y, -r0.w, c13
mad r2.w, r0, c14.x, c14.y
mad r2.w, r2, r0, c13
rsq r0.z, r0.z
rsq r3.y, r3.y
mad r0.x, r0, r0.y, c14.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
mad r0.w, r2, r0, c14.z
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v4.y, c13.x, c13.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c14.w, r2.w
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.w, r0.y
dsx r0.xz, v4.xyyw
mul r0.xz, r0, r0
add r0.x, r0, r0.z
mul r3.zw, r3, r3
add r0.z, r3, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r2.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c17.x
mul r0.x, r2.w, c17
dsy r0.y, r0
texldd r0, r3, s0, r0.zwzw, r0
add r3.xyz, -v1, c1
dp3 r2.w, r3, r3
mul r0, r0, c4
mul_pp r0, r0, r1
add_pp r2.x, r2, c17.z
mul_pp r1.y, r2.x, c3.w
mov r2.xyz, v0
add r2.xyz, v1, -r2
mul_pp_sat r1.w, r1.y, c17
mov r1.x, c10
add r1.xyz, c3, r1.x
mad_sat r1.xyz, r1, r1.w, c0
dp3 r1.w, r2, r2
rsq r2.x, r2.w
mov r3.xyz, v3
rsq r1.w, r1.w
dp3 r2.w, v5, r3
rcp r2.x, r2.x
rcp r1.w, r1.w
mad r1.w, -r1, c18.x, r2.x
add r2.xyz, -v0, c1
dp3 r2.y, r2, r2
abs_sat r2.x, r2.w
rsq r2.y, r2.y
rcp r3.y, r2.y
mul r3.x, r2, c7
pow_sat r2, r3.x, c6.x
mul r2.y, r3, c12.x
add_sat r2.y, r2, -c11.x
add r2.x, r2, -r2.y
mul_sat r1.w, r1, c18.y
mad r1.w, r1, r2.x, r2.y
mul_pp oC0.xyz, r0, r1
mul_pp oC0.w, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
ConstBuffer "$Globals" 176 // 172 used size, 14 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 144 [_FalloffPow]
Float 148 [_FalloffScale]
Float 152 [_DetailScale]
Float 156 [_DetailDist]
Float 160 [_MinLight]
Float 164 [_FadeDist]
Float 168 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 94 instructions, 4 temp regs, 0 temp arrays:
// ALU 84 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedglghnmcilfcfmncoifhnhhhlllfkekdpabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaaakbabaia
ibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaaagbcbaaaaeaaaaaaagbcbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
akbabaaaaeaaaaaackbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaafdcaabaaa
abaaaaaaegbabaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaa
abaaaaaaagbebaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaogakbaaaabaaaaaa
ogakbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdodbaaaaaiicaabaaa
aaaaaaaabkbabaiaebaaaaaaaeaaaaaabkbabaaaaeaaaaaadcaaaabamcaabaaa
abaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaadagojjlm
dagojjlmaceaaaaaaaaaaaaaaaaaaaaachbgjidnchbgjidndcaaaaanmcaabaaa
abaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaiedefjloiedefjlodcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaa
fgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaakeanmjdpkeanmjdp
aaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaa
diaaaaahdcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaaacaaaaaadcaaaaap
dcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaaaa
aaaaaaaaaceaaaaanlapejeanlapejeaaaaaaaaaaaaaaaaaabaaaaahmcaabaaa
aaaaaaaakgaobaaaaaaaaaaafgabbaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaadcaaaaajicaabaaa
aaaaaaaackaabaaaabaaaaaackaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaak
gcaabaaaaaaaaaaapgaobaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaabaaaaaackaabaaaaaaaaaaaamaaaaafccaabaaa
acaaaaaackaabaaaaaaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaa
egiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaaegiacaaaaaaaaaaaaiaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaajaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdibaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaajaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
ajaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaackiacaaaaaaaaaaaakaaaaaa
ckaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaakaaaaaaaaaaaaaiccaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaah
iccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaa
adaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaa
akaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_DetailOffset]
Float 6 [_FalloffPow]
Float 7 [_FalloffScale]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 117 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, 1.04999995, 0.00010000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v4.zyzw, c8.x
add r0.xy, r0, c5
texld r2, r0, s1
mul r1.xy, v4, c8.x
dsy r3.zw, v4.xyxy
abs r0.zw, v4.xyxy
abs r0.x, v4.z
max r0.y, r0.x, r0.z
rcp r1.z, r0.y
min r0.y, r0.x, r0.z
mul r3.x, r0.y, r1.z
mul r0.y, r3.x, r3.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r2, r2, -r1
mad_pp r2, r0.z, r2, r1
mad r3.y, r0, c15, c15.z
mad r1.z, r3.y, r0.y, c15.w
mad r1.z, r1, r0.y, c16.x
mad r3.y, r1.z, r0, c16
mul r1.xy, v4.zxzw, c8.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r1, r1, -r2
mad_pp r2, r0.w, r1, r2
mad r0.y, r3, r0, c16.z
mul r0.w, r0.y, r3.x
add r0.y, r0.x, -r0.z
add r3.x, -r0.w, c16.w
cmp r0.z, -r0.y, r0.w, r3.x
add r0.y, -r0.z, c13.z
cmp r0.y, v4.x, r0.z, r0
cmp r0.y, v4.z, r0, -r0
mad r3.x, r0.y, c17, c17.y
mad r0.y, r0.x, c14.x, c14
mul r0.w, v2.x, c9.x
dp4 r0.z, c2, c2
add_pp r1, -r2, c13.y
mul_sat r0.w, r0, c14
mad_pp r1, r0.w, r1, r2
abs r0.w, -v4.y
rsq r0.z, r0.z
mul r2.xyz, r0.z, c2
dp3_sat r2.x, v3, r2
add r0.z, -r0.x, c13.y
mad r0.y, r0.x, r0, c13.w
add r3.y, -r0.w, c13
mad r2.w, r0, c14.x, c14.y
mad r2.w, r2, r0, c13
rsq r0.z, r0.z
rsq r3.y, r3.y
mad r0.x, r0, r0.y, c14.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
mad r0.w, r2, r0, c14.z
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v4.y, c13.x, c13.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c14.w, r2.w
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.w, r0.y
dsx r0.xz, v4.xyyw
mul r0.xz, r0, r0
add r0.x, r0, r0.z
mul r3.zw, r3, r3
add r0.z, r3, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r2.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c17.x
mul r0.x, r2.w, c17
dsy r0.y, r0
texldd r0, r3, s0, r0.zwzw, r0
add r3.xyz, -v1, c1
dp3 r2.w, r3, r3
mul r0, r0, c4
mul_pp r0, r0, r1
add_pp r2.x, r2, c17.z
mul_pp r1.y, r2.x, c3.w
mov r2.xyz, v0
add r2.xyz, v1, -r2
mul_pp_sat r1.w, r1.y, c17
mov r1.x, c10
add r1.xyz, c3, r1.x
mad_sat r1.xyz, r1, r1.w, c0
dp3 r1.w, r2, r2
rsq r2.x, r2.w
mov r3.xyz, v3
rsq r1.w, r1.w
dp3 r2.w, v5, r3
rcp r2.x, r2.x
rcp r1.w, r1.w
mad r1.w, -r1, c18.x, r2.x
add r2.xyz, -v0, c1
dp3 r2.y, r2, r2
abs_sat r2.x, r2.w
rsq r2.y, r2.y
rcp r3.y, r2.y
mul r3.x, r2, c7
pow_sat r2, r3.x, c6.x
mul r2.y, r3, c12.x
add_sat r2.y, r2, -c11.x
add r2.x, r2, -r2.y
mul_sat r1.w, r1, c18.y
mad r1.w, r1, r2.x, r2.y
mul_pp oC0.xyz, r0, r1
mul_pp oC0.w, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
ConstBuffer "$Globals" 176 // 172 used size, 14 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 144 [_FalloffPow]
Float 148 [_FalloffScale]
Float 152 [_DetailScale]
Float 156 [_DetailDist]
Float 160 [_MinLight]
Float 164 [_FadeDist]
Float 168 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 94 instructions, 4 temp regs, 0 temp arrays:
// ALU 84 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedglghnmcilfcfmncoifhnhhhlllfkekdpabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaaakbabaia
ibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaaagbcbaaaaeaaaaaaagbcbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
akbabaaaaeaaaaaackbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaafdcaabaaa
abaaaaaaegbabaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaa
abaaaaaaagbebaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaogakbaaaabaaaaaa
ogakbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdodbaaaaaiicaabaaa
aaaaaaaabkbabaiaebaaaaaaaeaaaaaabkbabaaaaeaaaaaadcaaaabamcaabaaa
abaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaadagojjlm
dagojjlmaceaaaaaaaaaaaaaaaaaaaaachbgjidnchbgjidndcaaaaanmcaabaaa
abaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaiedefjloiedefjlodcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaa
fgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaakeanmjdpkeanmjdp
aaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaa
diaaaaahdcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaaacaaaaaadcaaaaap
dcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaaaa
aaaaaaaaaceaaaaanlapejeanlapejeaaaaaaaaaaaaaaaaaabaaaaahmcaabaaa
aaaaaaaakgaobaaaaaaaaaaafgabbaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaadcaaaaajicaabaaa
aaaaaaaackaabaaaabaaaaaackaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaak
gcaabaaaaaaaaaaapgaobaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaabaaaaaackaabaaaaaaaaaaaamaaaaafccaabaaa
acaaaaaackaabaaaaaaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaa
egiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaaegiacaaaaaaaaaaaaiaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaajaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdibaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaajaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
ajaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaackiacaaaaaaaaaaaakaaaaaa
ckaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaakaaaaaaaaaaaaaiccaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaah
iccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaa
adaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaa
akaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_DetailOffset]
Float 6 [_FalloffPow]
Float 7 [_FalloffScale]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 117 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, 1.04999995, 0.00010000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v4.zyzw, c8.x
add r0.xy, r0, c5
texld r2, r0, s1
mul r1.xy, v4, c8.x
dsy r3.zw, v4.xyxy
abs r0.zw, v4.xyxy
abs r0.x, v4.z
max r0.y, r0.x, r0.z
rcp r1.z, r0.y
min r0.y, r0.x, r0.z
mul r3.x, r0.y, r1.z
mul r0.y, r3.x, r3.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r2, r2, -r1
mad_pp r2, r0.z, r2, r1
mad r3.y, r0, c15, c15.z
mad r1.z, r3.y, r0.y, c15.w
mad r1.z, r1, r0.y, c16.x
mad r3.y, r1.z, r0, c16
mul r1.xy, v4.zxzw, c8.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r1, r1, -r2
mad_pp r2, r0.w, r1, r2
mad r0.y, r3, r0, c16.z
mul r0.w, r0.y, r3.x
add r0.y, r0.x, -r0.z
add r3.x, -r0.w, c16.w
cmp r0.z, -r0.y, r0.w, r3.x
add r0.y, -r0.z, c13.z
cmp r0.y, v4.x, r0.z, r0
cmp r0.y, v4.z, r0, -r0
mad r3.x, r0.y, c17, c17.y
mad r0.y, r0.x, c14.x, c14
mul r0.w, v2.x, c9.x
dp4_pp r0.z, c2, c2
add_pp r1, -r2, c13.y
mul_sat r0.w, r0, c14
mad_pp r1, r0.w, r1, r2
abs r0.w, -v4.y
rsq_pp r0.z, r0.z
mul_pp r2.xyz, r0.z, c2
dp3_sat r2.x, v3, r2
add r0.z, -r0.x, c13.y
mad r0.y, r0.x, r0, c13.w
add r3.y, -r0.w, c13
mad r2.w, r0, c14.x, c14.y
mad r2.w, r2, r0, c13
rsq r0.z, r0.z
rsq r3.y, r3.y
mad r0.x, r0, r0.y, c14.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
mad r0.w, r2, r0, c14.z
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v4.y, c13.x, c13.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c14.w, r2.w
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.w, r0.y
dsx r0.xz, v4.xyyw
mul r0.xz, r0, r0
add r0.x, r0, r0.z
mul r3.zw, r3, r3
add r0.z, r3, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r2.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c17.x
mul r0.x, r2.w, c17
dsy r0.y, r0
texldd r0, r3, s0, r0.zwzw, r0
add r3.xyz, -v1, c1
dp3 r2.w, r3, r3
mul r0, r0, c4
mul_pp r0, r0, r1
add_pp r2.x, r2, c17.z
mul_pp r1.y, r2.x, c3.w
mov r2.xyz, v0
add r2.xyz, v1, -r2
mul_pp_sat r1.w, r1.y, c17
mov r1.x, c10
add r1.xyz, c3, r1.x
mad_sat r1.xyz, r1, r1.w, c0
dp3 r1.w, r2, r2
rsq r2.x, r2.w
mov r3.xyz, v3
rsq r1.w, r1.w
dp3 r2.w, v5, r3
rcp r2.x, r2.x
rcp r1.w, r1.w
mad r1.w, -r1, c18.x, r2.x
add r2.xyz, -v0, c1
dp3 r2.y, r2, r2
abs_sat r2.x, r2.w
rsq r2.y, r2.y
rcp r3.y, r2.y
mul r3.x, r2, c7
pow_sat r2, r3.x, c6.x
mul r2.y, r3, c12.x
add_sat r2.y, r2, -c11.x
add r2.x, r2, -r2.y
mul_sat r1.w, r1, c18.y
mad r1.w, r1, r2.x, r2.y
mul_pp oC0.xyz, r0, r1
mul_pp oC0.w, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 176 // 172 used size, 14 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 144 [_FalloffPow]
Float 148 [_FalloffScale]
Float 152 [_DetailScale]
Float 156 [_DetailDist]
Float 160 [_MinLight]
Float 164 [_FadeDist]
Float 168 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 94 instructions, 4 temp regs, 0 temp arrays:
// ALU 84 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjmkopjbjplmdbjkcilcngeocgmlholhhabaaaaaabeaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
icbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaiaibaaaaaa
aeaaaaaackbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaa
aaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlo
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
diphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaajicaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaia
ibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaaagbcbaaaaeaaaaaaagbcbaia
ebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
nlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaadbaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadp
alaaaaafdcaabaaaabaaaaaaegbabaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaabaaaaaaegaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdo
amaaaaafmcaabaaaabaaaaaaagbebaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaa
ogakbaaaabaaaaaaogakbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdo
dbaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaaeaaaaaabkbabaaaaeaaaaaa
dcaaaabamcaabaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaadagojjlmdagojjlmaceaaaaaaaaaaaaaaaaaaaaachbgjidnchbgjidn
dcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaiedefjloiedefjlodcaaaaanmcaabaaaabaaaaaa
kgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
keanmjdpkeanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaa
kgaobaaaacaaaaaadiaaaaahdcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaa
acaaaaaadcaaaaapdcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaama
aaaaaamaaaaaaaaaaaaaaaaaaceaaaaanlapejeanlapejeaaaaaaaaaaaaaaaaa
abaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgabbaaaadaaaaaadcaaaaaj
ecaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaa
dcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaackaabaaaacaaaaaadkaabaaa
aaaaaaaadiaaaaakgcaabaaaaaaaaaaapgaobaaaaaaaaaaaaceaaaaaaaaaaaaa
idpjkcdoidpjkcdoaaaaaaaaalaaaaafccaabaaaabaaaaaackaabaaaaaaaaaaa
amaaaaafccaabaaaacaaaaaackaabaaaaaaaaaaaejaaaaanpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaahaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaa
aaaaaaaaajaaaaaaegiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
dcaabaaaadaaaaaaegbabaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaaegiacaaa
aaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaa
aeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
fgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaal
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaa
aaaaaaaaajaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaia
ebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaa
dicaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdibaaaaaah
ccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaa
abaaaaaabkaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaacpaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaaaaaaaaaajaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaa
ddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaj
hcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaackiacaaa
aaaaaaaaakaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaakaaaaaa
aaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
bbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaa
aaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaa
agiacaaaaaaaaaaaakaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_DetailOffset]
Float 6 [_FalloffPow]
Float 7 [_FalloffScale]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 117 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, 1.04999995, 0.00010000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v4.zyzw, c8.x
add r0.xy, r0, c5
texld r2, r0, s1
mul r1.xy, v4, c8.x
dsy r3.zw, v4.xyxy
abs r0.zw, v4.xyxy
abs r0.x, v4.z
max r0.y, r0.x, r0.z
rcp r1.z, r0.y
min r0.y, r0.x, r0.z
mul r3.x, r0.y, r1.z
mul r0.y, r3.x, r3.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r2, r2, -r1
mad_pp r2, r0.z, r2, r1
mad r3.y, r0, c15, c15.z
mad r1.z, r3.y, r0.y, c15.w
mad r1.z, r1, r0.y, c16.x
mad r3.y, r1.z, r0, c16
mul r1.xy, v4.zxzw, c8.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r1, r1, -r2
mad_pp r2, r0.w, r1, r2
mad r0.y, r3, r0, c16.z
mul r0.w, r0.y, r3.x
add r0.y, r0.x, -r0.z
add r3.x, -r0.w, c16.w
cmp r0.z, -r0.y, r0.w, r3.x
add r0.y, -r0.z, c13.z
cmp r0.y, v4.x, r0.z, r0
cmp r0.y, v4.z, r0, -r0
mad r3.x, r0.y, c17, c17.y
mad r0.y, r0.x, c14.x, c14
mul r0.w, v2.x, c9.x
dp4_pp r0.z, c2, c2
add_pp r1, -r2, c13.y
mul_sat r0.w, r0, c14
mad_pp r1, r0.w, r1, r2
abs r0.w, -v4.y
rsq_pp r0.z, r0.z
mul_pp r2.xyz, r0.z, c2
dp3_sat r2.x, v3, r2
add r0.z, -r0.x, c13.y
mad r0.y, r0.x, r0, c13.w
add r3.y, -r0.w, c13
mad r2.w, r0, c14.x, c14.y
mad r2.w, r2, r0, c13
rsq r0.z, r0.z
rsq r3.y, r3.y
mad r0.x, r0, r0.y, c14.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
mad r0.w, r2, r0, c14.z
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v4.y, c13.x, c13.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c14.w, r2.w
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.w, r0.y
dsx r0.xz, v4.xyyw
mul r0.xz, r0, r0
add r0.x, r0, r0.z
mul r3.zw, r3, r3
add r0.z, r3, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r2.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c17.x
mul r0.x, r2.w, c17
dsy r0.y, r0
texldd r0, r3, s0, r0.zwzw, r0
add r3.xyz, -v1, c1
dp3 r2.w, r3, r3
mul r0, r0, c4
mul_pp r0, r0, r1
add_pp r2.x, r2, c17.z
mul_pp r1.y, r2.x, c3.w
mov r2.xyz, v0
add r2.xyz, v1, -r2
mul_pp_sat r1.w, r1.y, c17
mov r1.x, c10
add r1.xyz, c3, r1.x
mad_sat r1.xyz, r1, r1.w, c0
dp3 r1.w, r2, r2
rsq r2.x, r2.w
mov r3.xyz, v3
rsq r1.w, r1.w
dp3 r2.w, v5, r3
rcp r2.x, r2.x
rcp r1.w, r1.w
mad r1.w, -r1, c18.x, r2.x
add r2.xyz, -v0, c1
dp3 r2.y, r2, r2
abs_sat r2.x, r2.w
rsq r2.y, r2.y
rcp r3.y, r2.y
mul r3.x, r2, c7
pow_sat r2, r3.x, c6.x
mul r2.y, r3, c12.x
add_sat r2.y, r2, -c11.x
add r2.x, r2, -r2.y
mul_sat r1.w, r1, c18.y
mad r1.w, r1, r2.x, r2.y
mul_pp oC0.xyz, r0, r1
mul_pp oC0.w, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 240 // 236 used size, 15 vars
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Vector 192 [_DetailOffset] 4
Float 208 [_FalloffPow]
Float 212 [_FalloffScale]
Float 216 [_DetailScale]
Float 220 [_DetailDist]
Float 224 [_MinLight]
Float 228 [_FadeDist]
Float 232 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 94 instructions, 4 temp regs, 0 temp arrays:
// ALU 84 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedcnbcekoflldipnmgkmeldknpdhcdhlcgabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaadaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaaakbabaia
ibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaaagbcbaaaaeaaaaaaagbcbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
akbabaaaaeaaaaaackbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaafdcaabaaa
abaaaaaaegbabaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaa
abaaaaaaagbebaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaogakbaaaabaaaaaa
ogakbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdodbaaaaaiicaabaaa
aaaaaaaabkbabaiaebaaaaaaaeaaaaaabkbabaaaaeaaaaaadcaaaabamcaabaaa
abaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaadagojjlm
dagojjlmaceaaaaaaaaaaaaaaaaaaaaachbgjidnchbgjidndcaaaaanmcaabaaa
abaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaiedefjloiedefjlodcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaa
fgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaakeanmjdpkeanmjdp
aaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaa
diaaaaahdcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaaacaaaaaadcaaaaap
dcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaaaa
aaaaaaaaaceaaaaanlapejeanlapejeaaaaaaaaaaaaaaaaaabaaaaahmcaabaaa
aaaaaaaakgaobaaaaaaaaaaafgabbaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaadcaaaaajicaabaaa
aaaaaaaackaabaaaabaaaaaackaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaak
gcaabaaaaaaaaaaapgaobaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaabaaaaaackaabaaaaaaaaaaaamaaaaafccaabaaa
acaaaaaackaabaaaaaaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaa
egiecaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaaegiacaaaaaaaaaaaamaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaanaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdibaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaanaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
anaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaackiacaaaaaaaaaaaaoaaaaaa
ckaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaaoaaaaaaaaaaaaaiccaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaah
iccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaa
adaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
ajaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagiacaaaaaaaaaaa
aoaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_DetailOffset]
Float 6 [_FalloffPow]
Float 7 [_FalloffScale]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 117 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, 1.04999995, 0.00010000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v4.zyzw, c8.x
add r0.xy, r0, c5
texld r2, r0, s1
mul r1.xy, v4, c8.x
dsy r3.zw, v4.xyxy
abs r0.zw, v4.xyxy
abs r0.x, v4.z
max r0.y, r0.x, r0.z
rcp r1.z, r0.y
min r0.y, r0.x, r0.z
mul r3.x, r0.y, r1.z
mul r0.y, r3.x, r3.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r2, r2, -r1
mad_pp r2, r0.z, r2, r1
mad r3.y, r0, c15, c15.z
mad r1.z, r3.y, r0.y, c15.w
mad r1.z, r1, r0.y, c16.x
mad r3.y, r1.z, r0, c16
mul r1.xy, v4.zxzw, c8.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r1, r1, -r2
mad_pp r2, r0.w, r1, r2
mad r0.y, r3, r0, c16.z
mul r0.w, r0.y, r3.x
add r0.y, r0.x, -r0.z
add r3.x, -r0.w, c16.w
cmp r0.z, -r0.y, r0.w, r3.x
add r0.y, -r0.z, c13.z
cmp r0.y, v4.x, r0.z, r0
cmp r0.y, v4.z, r0, -r0
mad r3.x, r0.y, c17, c17.y
mad r0.y, r0.x, c14.x, c14
mul r0.w, v2.x, c9.x
dp4 r0.z, c2, c2
add_pp r1, -r2, c13.y
mul_sat r0.w, r0, c14
mad_pp r1, r0.w, r1, r2
abs r0.w, -v4.y
rsq r0.z, r0.z
mul r2.xyz, r0.z, c2
dp3_sat r2.x, v3, r2
add r0.z, -r0.x, c13.y
mad r0.y, r0.x, r0, c13.w
add r3.y, -r0.w, c13
mad r2.w, r0, c14.x, c14.y
mad r2.w, r2, r0, c13
rsq r0.z, r0.z
rsq r3.y, r3.y
mad r0.x, r0, r0.y, c14.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
mad r0.w, r2, r0, c14.z
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v4.y, c13.x, c13.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c14.w, r2.w
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.w, r0.y
dsx r0.xz, v4.xyyw
mul r0.xz, r0, r0
add r0.x, r0, r0.z
mul r3.zw, r3, r3
add r0.z, r3, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r2.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c17.x
mul r0.x, r2.w, c17
dsy r0.y, r0
texldd r0, r3, s0, r0.zwzw, r0
add r3.xyz, -v1, c1
dp3 r2.w, r3, r3
mul r0, r0, c4
mul_pp r0, r0, r1
add_pp r2.x, r2, c17.z
mul_pp r1.y, r2.x, c3.w
mov r2.xyz, v0
add r2.xyz, v1, -r2
mul_pp_sat r1.w, r1.y, c17
mov r1.x, c10
add r1.xyz, c3, r1.x
mad_sat r1.xyz, r1, r1.w, c0
dp3 r1.w, r2, r2
rsq r2.x, r2.w
mov r3.xyz, v3
rsq r1.w, r1.w
dp3 r2.w, v5, r3
rcp r2.x, r2.x
rcp r1.w, r1.w
mad r1.w, -r1, c18.x, r2.x
add r2.xyz, -v0, c1
dp3 r2.y, r2, r2
abs_sat r2.x, r2.w
rsq r2.y, r2.y
rcp r3.y, r2.y
mul r3.x, r2, c7
pow_sat r2, r3.x, c6.x
mul r2.y, r3, c12.x
add_sat r2.y, r2, -c11.x
add r2.x, r2, -r2.y
mul_sat r1.w, r1, c18.y
mad r1.w, r1, r2.x, r2.y
mul_pp oC0.xyz, r0, r1
mul_pp oC0.w, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
ConstBuffer "$Globals" 176 // 172 used size, 14 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 144 [_FalloffPow]
Float 148 [_FalloffScale]
Float 152 [_DetailScale]
Float 156 [_DetailDist]
Float 160 [_MinLight]
Float 164 [_FadeDist]
Float 168 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 94 instructions, 4 temp regs, 0 temp arrays:
// ALU 84 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkoemoldghhmpajfllldbheahghnncgclabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaaakbabaia
ibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaaagbcbaaaaeaaaaaaagbcbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
akbabaaaaeaaaaaackbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaafdcaabaaa
abaaaaaaegbabaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaa
abaaaaaaagbebaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaogakbaaaabaaaaaa
ogakbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdodbaaaaaiicaabaaa
aaaaaaaabkbabaiaebaaaaaaaeaaaaaabkbabaaaaeaaaaaadcaaaabamcaabaaa
abaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaadagojjlm
dagojjlmaceaaaaaaaaaaaaaaaaaaaaachbgjidnchbgjidndcaaaaanmcaabaaa
abaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaiedefjloiedefjlodcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaa
fgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaakeanmjdpkeanmjdp
aaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaa
diaaaaahdcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaaacaaaaaadcaaaaap
dcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaaaa
aaaaaaaaaceaaaaanlapejeanlapejeaaaaaaaaaaaaaaaaaabaaaaahmcaabaaa
aaaaaaaakgaobaaaaaaaaaaafgabbaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaadcaaaaajicaabaaa
aaaaaaaackaabaaaabaaaaaackaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaak
gcaabaaaaaaaaaaapgaobaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaabaaaaaackaabaaaaaaaaaaaamaaaaafccaabaaa
acaaaaaackaabaaaaaaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaa
egiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaaegiacaaaaaaaaaaaaiaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaajaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdibaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaajaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
ajaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaackiacaaaaaaaaaaaakaaaaaa
ckaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaakaaaaaaaaaaaaaiccaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaah
iccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaa
adaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaa
akaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_DetailOffset]
Float 6 [_FalloffPow]
Float 7 [_FalloffScale]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 117 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, 1.04999995, 0.00010000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v4.zyzw, c8.x
add r0.xy, r0, c5
texld r2, r0, s1
mul r1.xy, v4, c8.x
dsy r3.zw, v4.xyxy
abs r0.zw, v4.xyxy
abs r0.x, v4.z
max r0.y, r0.x, r0.z
rcp r1.z, r0.y
min r0.y, r0.x, r0.z
mul r3.x, r0.y, r1.z
mul r0.y, r3.x, r3.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r2, r2, -r1
mad_pp r2, r0.z, r2, r1
mad r3.y, r0, c15, c15.z
mad r1.z, r3.y, r0.y, c15.w
mad r1.z, r1, r0.y, c16.x
mad r3.y, r1.z, r0, c16
mul r1.xy, v4.zxzw, c8.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r1, r1, -r2
mad_pp r2, r0.w, r1, r2
mad r0.y, r3, r0, c16.z
mul r0.w, r0.y, r3.x
add r0.y, r0.x, -r0.z
add r3.x, -r0.w, c16.w
cmp r0.z, -r0.y, r0.w, r3.x
add r0.y, -r0.z, c13.z
cmp r0.y, v4.x, r0.z, r0
cmp r0.y, v4.z, r0, -r0
mad r3.x, r0.y, c17, c17.y
mad r0.y, r0.x, c14.x, c14
mul r0.w, v2.x, c9.x
dp4 r0.z, c2, c2
add_pp r1, -r2, c13.y
mul_sat r0.w, r0, c14
mad_pp r1, r0.w, r1, r2
abs r0.w, -v4.y
rsq r0.z, r0.z
mul r2.xyz, r0.z, c2
dp3_sat r2.x, v3, r2
add r0.z, -r0.x, c13.y
mad r0.y, r0.x, r0, c13.w
add r3.y, -r0.w, c13
mad r2.w, r0, c14.x, c14.y
mad r2.w, r2, r0, c13
rsq r0.z, r0.z
rsq r3.y, r3.y
mad r0.x, r0, r0.y, c14.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
mad r0.w, r2, r0, c14.z
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v4.y, c13.x, c13.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c14.w, r2.w
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.w, r0.y
dsx r0.xz, v4.xyyw
mul r0.xz, r0, r0
add r0.x, r0, r0.z
mul r3.zw, r3, r3
add r0.z, r3, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r2.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c17.x
mul r0.x, r2.w, c17
dsy r0.y, r0
texldd r0, r3, s0, r0.zwzw, r0
add r3.xyz, -v1, c1
dp3 r2.w, r3, r3
mul r0, r0, c4
mul_pp r0, r0, r1
add_pp r2.x, r2, c17.z
mul_pp r1.y, r2.x, c3.w
mov r2.xyz, v0
add r2.xyz, v1, -r2
mul_pp_sat r1.w, r1.y, c17
mov r1.x, c10
add r1.xyz, c3, r1.x
mad_sat r1.xyz, r1, r1.w, c0
dp3 r1.w, r2, r2
rsq r2.x, r2.w
mov r3.xyz, v3
rsq r1.w, r1.w
dp3 r2.w, v5, r3
rcp r2.x, r2.x
rcp r1.w, r1.w
mad r1.w, -r1, c18.x, r2.x
add r2.xyz, -v0, c1
dp3 r2.y, r2, r2
abs_sat r2.x, r2.w
rsq r2.y, r2.y
rcp r3.y, r2.y
mul r3.x, r2, c7
pow_sat r2, r3.x, c6.x
mul r2.y, r3, c12.x
add_sat r2.y, r2, -c11.x
add r2.x, r2, -r2.y
mul_sat r1.w, r1, c18.y
mad r1.w, r1, r2.x, r2.y
mul_pp oC0.xyz, r0, r1
mul_pp oC0.w, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
ConstBuffer "$Globals" 176 // 172 used size, 14 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 144 [_FalloffPow]
Float 148 [_FalloffScale]
Float 152 [_DetailScale]
Float 156 [_DetailDist]
Float 160 [_MinLight]
Float 164 [_FadeDist]
Float 168 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 94 instructions, 4 temp regs, 0 temp arrays:
// ALU 84 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkoemoldghhmpajfllldbheahghnncgclabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaaakbabaia
ibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaaagbcbaaaaeaaaaaaagbcbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
akbabaaaaeaaaaaackbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaafdcaabaaa
abaaaaaaegbabaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaa
abaaaaaaagbebaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaogakbaaaabaaaaaa
ogakbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdodbaaaaaiicaabaaa
aaaaaaaabkbabaiaebaaaaaaaeaaaaaabkbabaaaaeaaaaaadcaaaabamcaabaaa
abaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaadagojjlm
dagojjlmaceaaaaaaaaaaaaaaaaaaaaachbgjidnchbgjidndcaaaaanmcaabaaa
abaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaiedefjloiedefjlodcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaa
fgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaakeanmjdpkeanmjdp
aaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaa
diaaaaahdcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaaacaaaaaadcaaaaap
dcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaaaa
aaaaaaaaaceaaaaanlapejeanlapejeaaaaaaaaaaaaaaaaaabaaaaahmcaabaaa
aaaaaaaakgaobaaaaaaaaaaafgabbaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaadcaaaaajicaabaaa
aaaaaaaackaabaaaabaaaaaackaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaak
gcaabaaaaaaaaaaapgaobaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaabaaaaaackaabaaaaaaaaaaaamaaaaafccaabaaa
acaaaaaackaabaaaaaaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaa
egiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaaegiacaaaaaaaaaaaaiaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaajaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdibaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaajaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
ajaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaackiacaaaaaaaaaaaakaaaaaa
ckaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaakaaaaaaaaaaaaaiccaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaah
iccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaa
adaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaa
akaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_DetailOffset]
Float 6 [_FalloffPow]
Float 7 [_FalloffScale]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 117 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, 1.04999995, 0.00010000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v4.zyzw, c8.x
add r0.xy, r0, c5
texld r2, r0, s1
mul r1.xy, v4, c8.x
dsy r3.zw, v4.xyxy
abs r0.zw, v4.xyxy
abs r0.x, v4.z
max r0.y, r0.x, r0.z
rcp r1.z, r0.y
min r0.y, r0.x, r0.z
mul r3.x, r0.y, r1.z
mul r0.y, r3.x, r3.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r2, r2, -r1
mad_pp r2, r0.z, r2, r1
mad r3.y, r0, c15, c15.z
mad r1.z, r3.y, r0.y, c15.w
mad r1.z, r1, r0.y, c16.x
mad r3.y, r1.z, r0, c16
mul r1.xy, v4.zxzw, c8.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r1, r1, -r2
mad_pp r2, r0.w, r1, r2
mad r0.y, r3, r0, c16.z
mul r0.w, r0.y, r3.x
add r0.y, r0.x, -r0.z
add r3.x, -r0.w, c16.w
cmp r0.z, -r0.y, r0.w, r3.x
add r0.y, -r0.z, c13.z
cmp r0.y, v4.x, r0.z, r0
cmp r0.y, v4.z, r0, -r0
mad r3.x, r0.y, c17, c17.y
mad r0.y, r0.x, c14.x, c14
mul r0.w, v2.x, c9.x
dp4 r0.z, c2, c2
add_pp r1, -r2, c13.y
mul_sat r0.w, r0, c14
mad_pp r1, r0.w, r1, r2
abs r0.w, -v4.y
rsq r0.z, r0.z
mul r2.xyz, r0.z, c2
dp3_sat r2.x, v3, r2
add r0.z, -r0.x, c13.y
mad r0.y, r0.x, r0, c13.w
add r3.y, -r0.w, c13
mad r2.w, r0, c14.x, c14.y
mad r2.w, r2, r0, c13
rsq r0.z, r0.z
rsq r3.y, r3.y
mad r0.x, r0, r0.y, c14.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
mad r0.w, r2, r0, c14.z
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v4.y, c13.x, c13.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c14.w, r2.w
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.w, r0.y
dsx r0.xz, v4.xyyw
mul r0.xz, r0, r0
add r0.x, r0, r0.z
mul r3.zw, r3, r3
add r0.z, r3, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r2.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c17.x
mul r0.x, r2.w, c17
dsy r0.y, r0
texldd r0, r3, s0, r0.zwzw, r0
add r3.xyz, -v1, c1
dp3 r2.w, r3, r3
mul r0, r0, c4
mul_pp r0, r0, r1
add_pp r2.x, r2, c17.z
mul_pp r1.y, r2.x, c3.w
mov r2.xyz, v0
add r2.xyz, v1, -r2
mul_pp_sat r1.w, r1.y, c17
mov r1.x, c10
add r1.xyz, c3, r1.x
mad_sat r1.xyz, r1, r1.w, c0
dp3 r1.w, r2, r2
rsq r2.x, r2.w
mov r3.xyz, v3
rsq r1.w, r1.w
dp3 r2.w, v5, r3
rcp r2.x, r2.x
rcp r1.w, r1.w
mad r1.w, -r1, c18.x, r2.x
add r2.xyz, -v0, c1
dp3 r2.y, r2, r2
abs_sat r2.x, r2.w
rsq r2.y, r2.y
rcp r3.y, r2.y
mul r3.x, r2, c7
pow_sat r2, r3.x, c6.x
mul r2.y, r3, c12.x
add_sat r2.y, r2, -c11.x
add r2.x, r2, -r2.y
mul_sat r1.w, r1, c18.y
mad r1.w, r1, r2.x, r2.y
mul_pp oC0.xyz, r0, r1
mul_pp oC0.w, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 240 // 236 used size, 15 vars
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Vector 192 [_DetailOffset] 4
Float 208 [_FalloffPow]
Float 212 [_FalloffScale]
Float 216 [_DetailScale]
Float 220 [_DetailDist]
Float 224 [_MinLight]
Float 228 [_FadeDist]
Float 232 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 94 instructions, 4 temp regs, 0 temp arrays:
// ALU 84 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedibonnlmjhfhpbnabfiaemjijdffeicieabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaaakbabaia
ibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaaagbcbaaaaeaaaaaaagbcbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
akbabaaaaeaaaaaackbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaafdcaabaaa
abaaaaaaegbabaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaa
abaaaaaaagbebaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaogakbaaaabaaaaaa
ogakbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdodbaaaaaiicaabaaa
aaaaaaaabkbabaiaebaaaaaaaeaaaaaabkbabaaaaeaaaaaadcaaaabamcaabaaa
abaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaadagojjlm
dagojjlmaceaaaaaaaaaaaaaaaaaaaaachbgjidnchbgjidndcaaaaanmcaabaaa
abaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaiedefjloiedefjlodcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaa
fgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaakeanmjdpkeanmjdp
aaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaa
diaaaaahdcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaaacaaaaaadcaaaaap
dcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaaaa
aaaaaaaaaceaaaaanlapejeanlapejeaaaaaaaaaaaaaaaaaabaaaaahmcaabaaa
aaaaaaaakgaobaaaaaaaaaaafgabbaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaadcaaaaajicaabaaa
aaaaaaaackaabaaaabaaaaaackaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaak
gcaabaaaaaaaaaaapgaobaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaabaaaaaackaabaaaaaaaaaaaamaaaaafccaabaaa
acaaaaaackaabaaaaaaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaa
egiecaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaaegiacaaaaaaaaaaaamaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaanaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdibaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaanaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
anaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaackiacaaaaaaaaaaaaoaaaaaa
ckaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaaoaaaaaaaaaaaaaiccaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaah
iccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaa
adaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
ajaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagiacaaaaaaaaaaa
aoaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_DetailOffset]
Float 6 [_FalloffPow]
Float 7 [_FalloffScale]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 117 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, 1.04999995, 0.00010000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v4.zyzw, c8.x
add r0.xy, r0, c5
texld r2, r0, s1
mul r1.xy, v4, c8.x
dsy r3.zw, v4.xyxy
abs r0.zw, v4.xyxy
abs r0.x, v4.z
max r0.y, r0.x, r0.z
rcp r1.z, r0.y
min r0.y, r0.x, r0.z
mul r3.x, r0.y, r1.z
mul r0.y, r3.x, r3.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r2, r2, -r1
mad_pp r2, r0.z, r2, r1
mad r3.y, r0, c15, c15.z
mad r1.z, r3.y, r0.y, c15.w
mad r1.z, r1, r0.y, c16.x
mad r3.y, r1.z, r0, c16
mul r1.xy, v4.zxzw, c8.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r1, r1, -r2
mad_pp r2, r0.w, r1, r2
mad r0.y, r3, r0, c16.z
mul r0.w, r0.y, r3.x
add r0.y, r0.x, -r0.z
add r3.x, -r0.w, c16.w
cmp r0.z, -r0.y, r0.w, r3.x
add r0.y, -r0.z, c13.z
cmp r0.y, v4.x, r0.z, r0
cmp r0.y, v4.z, r0, -r0
mad r3.x, r0.y, c17, c17.y
mad r0.y, r0.x, c14.x, c14
mul r0.w, v2.x, c9.x
dp4 r0.z, c2, c2
add_pp r1, -r2, c13.y
mul_sat r0.w, r0, c14
mad_pp r1, r0.w, r1, r2
abs r0.w, -v4.y
rsq r0.z, r0.z
mul r2.xyz, r0.z, c2
dp3_sat r2.x, v3, r2
add r0.z, -r0.x, c13.y
mad r0.y, r0.x, r0, c13.w
add r3.y, -r0.w, c13
mad r2.w, r0, c14.x, c14.y
mad r2.w, r2, r0, c13
rsq r0.z, r0.z
rsq r3.y, r3.y
mad r0.x, r0, r0.y, c14.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
mad r0.w, r2, r0, c14.z
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v4.y, c13.x, c13.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c14.w, r2.w
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.w, r0.y
dsx r0.xz, v4.xyyw
mul r0.xz, r0, r0
add r0.x, r0, r0.z
mul r3.zw, r3, r3
add r0.z, r3, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r2.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c17.x
mul r0.x, r2.w, c17
dsy r0.y, r0
texldd r0, r3, s0, r0.zwzw, r0
add r3.xyz, -v1, c1
dp3 r2.w, r3, r3
mul r0, r0, c4
mul_pp r0, r0, r1
add_pp r2.x, r2, c17.z
mul_pp r1.y, r2.x, c3.w
mov r2.xyz, v0
add r2.xyz, v1, -r2
mul_pp_sat r1.w, r1.y, c17
mov r1.x, c10
add r1.xyz, c3, r1.x
mad_sat r1.xyz, r1, r1.w, c0
dp3 r1.w, r2, r2
rsq r2.x, r2.w
mov r3.xyz, v3
rsq r1.w, r1.w
dp3 r2.w, v5, r3
rcp r2.x, r2.x
rcp r1.w, r1.w
mad r1.w, -r1, c18.x, r2.x
add r2.xyz, -v0, c1
dp3 r2.y, r2, r2
abs_sat r2.x, r2.w
rsq r2.y, r2.y
rcp r3.y, r2.y
mul r3.x, r2, c7
pow_sat r2, r3.x, c6.x
mul r2.y, r3, c12.x
add_sat r2.y, r2, -c11.x
add r2.x, r2, -r2.y
mul_sat r1.w, r1, c18.y
mad r1.w, r1, r2.x, r2.y
mul_pp oC0.xyz, r0, r1
mul_pp oC0.w, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
ConstBuffer "$Globals" 240 // 236 used size, 15 vars
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Vector 192 [_DetailOffset] 4
Float 208 [_FalloffPow]
Float 212 [_FalloffScale]
Float 216 [_DetailScale]
Float 220 [_DetailDist]
Float 224 [_MinLight]
Float 228 [_FadeDist]
Float 232 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 94 instructions, 4 temp regs, 0 temp arrays:
// ALU 84 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedibonnlmjhfhpbnabfiaemjijdffeicieabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaaakbabaia
ibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaaagbcbaaaaeaaaaaaagbcbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
akbabaaaaeaaaaaackbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaafdcaabaaa
abaaaaaaegbabaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaa
abaaaaaaagbebaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaogakbaaaabaaaaaa
ogakbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdodbaaaaaiicaabaaa
aaaaaaaabkbabaiaebaaaaaaaeaaaaaabkbabaaaaeaaaaaadcaaaabamcaabaaa
abaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaadagojjlm
dagojjlmaceaaaaaaaaaaaaaaaaaaaaachbgjidnchbgjidndcaaaaanmcaabaaa
abaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaiedefjloiedefjlodcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaa
fgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaakeanmjdpkeanmjdp
aaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaa
diaaaaahdcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaaacaaaaaadcaaaaap
dcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaaaa
aaaaaaaaaceaaaaanlapejeanlapejeaaaaaaaaaaaaaaaaaabaaaaahmcaabaaa
aaaaaaaakgaobaaaaaaaaaaafgabbaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaadcaaaaajicaabaaa
aaaaaaaackaabaaaabaaaaaackaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaak
gcaabaaaaaaaaaaapgaobaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaabaaaaaackaabaaaaaaaaaaaamaaaaafccaabaaa
acaaaaaackaabaaaaaaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaa
egiecaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaanaaaaaaegiacaaaaaaaaaaaamaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaanaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdibaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaanaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
anaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaackiacaaaaaaaaaaaaoaaaaaa
ckaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaaoaaaaaaaaaaaaaiccaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaah
iccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaa
adaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
ajaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagiacaaaaaaaaaaa
aoaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_DetailOffset]
Float 6 [_FalloffPow]
Float 7 [_FalloffScale]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 117 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, 1.04999995, 0.00010000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v4.zyzw, c8.x
add r0.xy, r0, c5
texld r2, r0, s1
mul r1.xy, v4, c8.x
dsy r3.zw, v4.xyxy
abs r0.zw, v4.xyxy
abs r0.x, v4.z
max r0.y, r0.x, r0.z
rcp r1.z, r0.y
min r0.y, r0.x, r0.z
mul r3.x, r0.y, r1.z
mul r0.y, r3.x, r3.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r2, r2, -r1
mad_pp r2, r0.z, r2, r1
mad r3.y, r0, c15, c15.z
mad r1.z, r3.y, r0.y, c15.w
mad r1.z, r1, r0.y, c16.x
mad r3.y, r1.z, r0, c16
mul r1.xy, v4.zxzw, c8.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r1, r1, -r2
mad_pp r2, r0.w, r1, r2
mad r0.y, r3, r0, c16.z
mul r0.w, r0.y, r3.x
add r0.y, r0.x, -r0.z
add r3.x, -r0.w, c16.w
cmp r0.z, -r0.y, r0.w, r3.x
add r0.y, -r0.z, c13.z
cmp r0.y, v4.x, r0.z, r0
cmp r0.y, v4.z, r0, -r0
mad r3.x, r0.y, c17, c17.y
mad r0.y, r0.x, c14.x, c14
mul r0.w, v2.x, c9.x
dp4 r0.z, c2, c2
add_pp r1, -r2, c13.y
mul_sat r0.w, r0, c14
mad_pp r1, r0.w, r1, r2
abs r0.w, -v4.y
rsq r0.z, r0.z
mul r2.xyz, r0.z, c2
dp3_sat r2.x, v3, r2
add r0.z, -r0.x, c13.y
mad r0.y, r0.x, r0, c13.w
add r3.y, -r0.w, c13
mad r2.w, r0, c14.x, c14.y
mad r2.w, r2, r0, c13
rsq r0.z, r0.z
rsq r3.y, r3.y
mad r0.x, r0, r0.y, c14.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
mad r0.w, r2, r0, c14.z
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v4.y, c13.x, c13.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c14.w, r2.w
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.w, r0.y
dsx r0.xz, v4.xyyw
mul r0.xz, r0, r0
add r0.x, r0, r0.z
mul r3.zw, r3, r3
add r0.z, r3, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r2.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c17.x
mul r0.x, r2.w, c17
dsy r0.y, r0
texldd r0, r3, s0, r0.zwzw, r0
add r3.xyz, -v1, c1
dp3 r2.w, r3, r3
mul r0, r0, c4
mul_pp r0, r0, r1
add_pp r2.x, r2, c17.z
mul_pp r1.y, r2.x, c3.w
mov r2.xyz, v0
add r2.xyz, v1, -r2
mul_pp_sat r1.w, r1.y, c17
mov r1.x, c10
add r1.xyz, c3, r1.x
mad_sat r1.xyz, r1, r1.w, c0
dp3 r1.w, r2, r2
rsq r2.x, r2.w
mov r3.xyz, v3
rsq r1.w, r1.w
dp3 r2.w, v5, r3
rcp r2.x, r2.x
rcp r1.w, r1.w
mad r1.w, -r1, c18.x, r2.x
add r2.xyz, -v0, c1
dp3 r2.y, r2, r2
abs_sat r2.x, r2.w
rsq r2.y, r2.y
rcp r3.y, r2.y
mul r3.x, r2, c7
pow_sat r2, r3.x, c6.x
mul r2.y, r3, c12.x
add_sat r2.y, r2, -c11.x
add r2.x, r2, -r2.y
mul_sat r1.w, r1, c18.y
mad r1.w, r1, r2.x, r2.y
mul_pp oC0.xyz, r0, r1
mul_pp oC0.w, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 176 // 172 used size, 14 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 144 [_FalloffPow]
Float 148 [_FalloffScale]
Float 152 [_DetailScale]
Float 156 [_DetailDist]
Float 160 [_MinLight]
Float 164 [_FadeDist]
Float 168 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 94 instructions, 4 temp regs, 0 temp arrays:
// ALU 84 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkoemoldghhmpajfllldbheahghnncgclabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaaakbabaia
ibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaaagbcbaaaaeaaaaaaagbcbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
akbabaaaaeaaaaaackbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaafdcaabaaa
abaaaaaaegbabaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaa
abaaaaaaagbebaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaogakbaaaabaaaaaa
ogakbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdodbaaaaaiicaabaaa
aaaaaaaabkbabaiaebaaaaaaaeaaaaaabkbabaaaaeaaaaaadcaaaabamcaabaaa
abaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaadagojjlm
dagojjlmaceaaaaaaaaaaaaaaaaaaaaachbgjidnchbgjidndcaaaaanmcaabaaa
abaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaiedefjloiedefjlodcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaa
fgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaakeanmjdpkeanmjdp
aaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaa
diaaaaahdcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaaacaaaaaadcaaaaap
dcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaaaa
aaaaaaaaaceaaaaanlapejeanlapejeaaaaaaaaaaaaaaaaaabaaaaahmcaabaaa
aaaaaaaakgaobaaaaaaaaaaafgabbaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaadcaaaaajicaabaaa
aaaaaaaackaabaaaabaaaaaackaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaak
gcaabaaaaaaaaaaapgaobaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaabaaaaaackaabaaaaaaaaaaaamaaaaafccaabaaa
acaaaaaackaabaaaaaaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaa
egiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaaegiacaaaaaaaaaaaaiaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaajaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdibaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaajaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
ajaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaackiacaaaaaaaaaaaakaaaaaa
ckaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaakaaaaaaaaaaaaaiccaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaah
iccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaa
adaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaa
akaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_DetailOffset]
Float 6 [_FalloffPow]
Float 7 [_FalloffScale]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 117 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, 1.04999995, 0.00010000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v4.zyzw, c8.x
add r0.xy, r0, c5
texld r2, r0, s1
mul r1.xy, v4, c8.x
dsy r3.zw, v4.xyxy
abs r0.zw, v4.xyxy
abs r0.x, v4.z
max r0.y, r0.x, r0.z
rcp r1.z, r0.y
min r0.y, r0.x, r0.z
mul r3.x, r0.y, r1.z
mul r0.y, r3.x, r3.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r2, r2, -r1
mad_pp r2, r0.z, r2, r1
mad r3.y, r0, c15, c15.z
mad r1.z, r3.y, r0.y, c15.w
mad r1.z, r1, r0.y, c16.x
mad r3.y, r1.z, r0, c16
mul r1.xy, v4.zxzw, c8.x
add r1.xy, r1, c5
texld r1, r1, s1
add_pp r1, r1, -r2
mad_pp r2, r0.w, r1, r2
mad r0.y, r3, r0, c16.z
mul r0.w, r0.y, r3.x
add r0.y, r0.x, -r0.z
add r3.x, -r0.w, c16.w
cmp r0.z, -r0.y, r0.w, r3.x
add r0.y, -r0.z, c13.z
cmp r0.y, v4.x, r0.z, r0
cmp r0.y, v4.z, r0, -r0
mad r3.x, r0.y, c17, c17.y
mad r0.y, r0.x, c14.x, c14
mul r0.w, v2.x, c9.x
dp4 r0.z, c2, c2
add_pp r1, -r2, c13.y
mul_sat r0.w, r0, c14
mad_pp r1, r0.w, r1, r2
abs r0.w, -v4.y
rsq r0.z, r0.z
mul r2.xyz, r0.z, c2
dp3_sat r2.x, v3, r2
add r0.z, -r0.x, c13.y
mad r0.y, r0.x, r0, c13.w
add r3.y, -r0.w, c13
mad r2.w, r0, c14.x, c14.y
mad r2.w, r2, r0, c13
rsq r0.z, r0.z
rsq r3.y, r3.y
mad r0.x, r0, r0.y, c14.z
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, v4.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
mad r0.w, r2, r0, c14.z
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v4.y, c13.x, c13.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c14.w, r2.w
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.w, r0.y
dsx r0.xz, v4.xyyw
mul r0.xz, r0, r0
add r0.x, r0, r0.z
mul r3.zw, r3, r3
add r0.z, r3, r3.w
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r2.w, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c17.x
mul r0.x, r2.w, c17
dsy r0.y, r0
texldd r0, r3, s0, r0.zwzw, r0
add r3.xyz, -v1, c1
dp3 r2.w, r3, r3
mul r0, r0, c4
mul_pp r0, r0, r1
add_pp r2.x, r2, c17.z
mul_pp r1.y, r2.x, c3.w
mov r2.xyz, v0
add r2.xyz, v1, -r2
mul_pp_sat r1.w, r1.y, c17
mov r1.x, c10
add r1.xyz, c3, r1.x
mad_sat r1.xyz, r1, r1.w, c0
dp3 r1.w, r2, r2
rsq r2.x, r2.w
mov r3.xyz, v3
rsq r1.w, r1.w
dp3 r2.w, v5, r3
rcp r2.x, r2.x
rcp r1.w, r1.w
mad r1.w, -r1, c18.x, r2.x
add r2.xyz, -v0, c1
dp3 r2.y, r2, r2
abs_sat r2.x, r2.w
rsq r2.y, r2.y
rcp r3.y, r2.y
mul r3.x, r2, c7
pow_sat r2, r3.x, c6.x
mul r2.y, r3, c12.x
add_sat r2.y, r2, -c11.x
add r2.x, r2, -r2.y
mul_sat r1.w, r1, c18.y
mad r1.w, r1, r2.x, r2.y
mul_pp oC0.xyz, r0, r1
mul_pp oC0.w, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 176 // 172 used size, 14 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 144 [_FalloffPow]
Float 148 [_FalloffScale]
Float 152 [_DetailScale]
Float 156 [_DetailDist]
Float 160 [_MinLight]
Float 164 [_FadeDist]
Float 168 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerFrame" 3
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 94 instructions, 4 temp regs, 0 temp arrays:
// ALU 84 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkoemoldghhmpajfllldbheahghnncgclabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaaakbabaia
ibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaaakbabaiaibaaaaaaaeaaaaaackbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaaagbcbaaaaeaaaaaaagbcbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaaakbabaaaaeaaaaaackbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
akbabaaaaeaaaaaackbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaafdcaabaaa
abaaaaaaegbabaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaa
abaaaaaaagbebaaaaeaaaaaaapaaaaahicaabaaaaaaaaaaaogakbaaaabaaaaaa
ogakbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdodbaaaaaiicaabaaa
aaaaaaaabkbabaiaebaaaaaaaeaaaaaabkbabaaaaeaaaaaadcaaaabamcaabaaa
abaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaadagojjlm
dagojjlmaceaaaaaaaaaaaaaaaaaaaaachbgjidnchbgjidndcaaaaanmcaabaaa
abaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaiedefjloiedefjlodcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaa
fgbjbaiaibaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaakeanmjdpkeanmjdp
aaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaa
diaaaaahdcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaaacaaaaaadcaaaaap
dcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaaaa
aaaaaaaaaceaaaaanlapejeanlapejeaaaaaaaaaaaaaaaaaabaaaaahmcaabaaa
aaaaaaaakgaobaaaaaaaaaaafgabbaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaadcaaaaajicaabaaa
aaaaaaaackaabaaaabaaaaaackaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaak
gcaabaaaaaaaaaaapgaobaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdo
aaaaaaaaalaaaaafccaabaaaabaaaaaackaabaaaaaaaaaaaamaaaaafccaabaaa
acaaaaaackaabaaaaaaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaa
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaa
egiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaajaaaaaaegiacaaaaaaaaaaaaiaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaajaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdibaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaajaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
ajaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaackiacaaaaaaaaaaaakaaaaaa
ckaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaakaaaaaaaaaaaaaiccaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaah
iccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaa
adaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaa
akaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3"
}

}

#LINE 147

	
		}
		
	} 
	
}
}
