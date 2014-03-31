Shader "Sphere/Cloud" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		_BumpMap ("Bumpmap", 2D) = "bump" {}
		_FalloffPow ("Falloff Power", Range(0,3)) = 2
		_FalloffScale ("Falloff Scale", Range(0,20)) = 3
		_DetailScale ("Detail Scale", Range(0,1000)) = 100
		_DetailOffset ("Detail Offset", Color) = (0,0,0,0)
		_BumpScale ("Bump Scale", Range(0,1000)) = 50
		_BumpOffset ("Bump offset", Color) = (0,0,0,0)
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
varying vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
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
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
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
eefiecedainegilhdjeeengejdhaojchfgibcjiiabaaaaaaaaafaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaahaaaaaaaaaaaaaa
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

varying highp vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
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
#line 415
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
#line 408
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 399
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 403
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 407
uniform highp float _RimDist;
#line 427
#line 452
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 427
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 431
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 435
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 439
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD7 = vec3(xl_retval._LightCoord);
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
#line 415
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
#line 408
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 399
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 403
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 407
uniform highp float _RimDist;
#line 427
#line 452
#line 441
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 443
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 447
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 452
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 456
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 460
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 464
    mediump vec4 normalX = texture( _BumpMap, ((objNrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((objNrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((objNrm.xy * _BumpScale) + _BumpOffset.xy));
    objNrm = abs(objNrm);
    #line 468
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( objNrm.x));
    normal = mix( normal, normalY, vec4( objNrm.y));
    #line 472
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 476
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((1e-05 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 480
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 484
    mediump float diff = ((NdotL - 0.01) / 0.99);
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
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD7);
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
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
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
#line 413
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 397
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 401
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 405
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
#line 413
struct v2f {
    highp vec4 pos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
    highp vec3 worldNormal;
    highp vec3 objNormal;
    highp vec3 viewDir;
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 397
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 401
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 405
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
    mediump vec4 normalX = texture( _BumpMap, ((objNrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((objNrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((objNrm.xy * _BumpScale) + _BumpOffset.xy));
    objNrm = abs(objNrm);
    #line 465
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( objNrm.x));
    normal = mix( normal, normalY, vec4( objNrm.y));
    #line 469
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 473
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((1e-05 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 477
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 481
    mediump float diff = ((NdotL - 0.01) / 0.99);
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
varying vec4 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
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
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
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
eefiecedjglehiajglffloknhhcfccgdilahoneiabaaaaaaaaafaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaahaaaaaaaaaaaaaa
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

varying highp vec4 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
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
#line 424
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
#line 417
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 408
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 412
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 416
uniform highp float _RimDist;
#line 436
#line 461
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 436
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 440
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 444
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 448
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD7 = vec4(xl_retval._LightCoord);
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
#line 424
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
#line 417
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 408
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 412
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 416
uniform highp float _RimDist;
#line 436
#line 461
#line 450
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 452
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 456
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 461
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 465
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 469
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 473
    mediump vec4 normalX = texture( _BumpMap, ((objNrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((objNrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((objNrm.xy * _BumpScale) + _BumpOffset.xy));
    objNrm = abs(objNrm);
    #line 477
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( objNrm.x));
    normal = mix( normal, normalY, vec4( objNrm.y));
    #line 481
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 485
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((1e-05 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 489
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 493
    mediump float diff = ((NdotL - 0.01) / 0.99);
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
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
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
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
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
eefiecedainegilhdjeeengejdhaojchfgibcjiiabaaaaaaaaafaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaahaaaaaaaaaaaaaa
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

varying highp vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
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
#line 416
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
#line 409
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 400
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 404
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 408
uniform highp float _RimDist;
#line 428
#line 453
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 428
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 432
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 436
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 440
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD7 = vec3(xl_retval._LightCoord);
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
#line 416
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
#line 409
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 400
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 404
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 408
uniform highp float _RimDist;
#line 428
#line 453
#line 442
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 444
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 448
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 453
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 457
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 461
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 465
    mediump vec4 normalX = texture( _BumpMap, ((objNrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((objNrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((objNrm.xy * _BumpScale) + _BumpOffset.xy));
    objNrm = abs(objNrm);
    #line 469
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( objNrm.x));
    normal = mix( normal, normalY, vec4( objNrm.y));
    #line 473
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 477
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((1e-05 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 481
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 485
    mediump float diff = ((NdotL - 0.01) / 0.99);
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
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD7);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec2 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
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
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
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
eefiecedhlgmflaefejpnmdgflenemnohnefcefnabaaaaaaaaafaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaahaaaaaaaaaaaaaa
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

varying highp vec2 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
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
#line 415
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
#line 408
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 399
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 403
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 407
uniform highp float _RimDist;
#line 427
#line 452
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 427
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 431
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 435
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 439
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec2 xlv_TEXCOORD7;
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
    xlv_TEXCOORD7 = vec2(xl_retval._LightCoord);
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
#line 415
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
#line 408
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 399
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 403
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 407
uniform highp float _RimDist;
#line 427
#line 452
#line 441
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 443
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 447
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 452
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 456
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 460
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 464
    mediump vec4 normalX = texture( _BumpMap, ((objNrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((objNrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((objNrm.xy * _BumpScale) + _BumpOffset.xy));
    objNrm = abs(objNrm);
    #line 468
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( objNrm.x));
    normal = mix( normal, normalY, vec4( objNrm.y));
    #line 472
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 476
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((1e-05 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 480
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 484
    mediump float diff = ((NdotL - 0.01) / 0.99);
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
in highp vec2 xlv_TEXCOORD7;
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
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD7);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
varying vec4 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
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
eefieceddgnegfgjofjjpnejbacobapogdaofbioabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaahaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaaomaaaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaa
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

varying highp vec4 xlv_TEXCOORD8;
varying highp vec4 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec4 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
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
#line 430
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
#line 423
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 414
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 418
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 422
uniform highp float _RimDist;
#line 443
#line 468
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 443
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 447
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 451
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 455
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD7;
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD7 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD8 = vec4(xl_retval._ShadowCoord);
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
#line 430
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
#line 423
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 414
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 418
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 422
uniform highp float _RimDist;
#line 443
#line 468
#line 457
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 459
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 463
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 468
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 472
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 476
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 480
    mediump vec4 normalX = texture( _BumpMap, ((objNrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((objNrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((objNrm.xy * _BumpScale) + _BumpOffset.xy));
    objNrm = abs(objNrm);
    #line 484
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( objNrm.x));
    normal = mix( normal, normalY, vec4( objNrm.y));
    #line 488
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 492
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((1e-05 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 496
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 500
    mediump float diff = ((NdotL - 0.01) / 0.99);
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
in highp vec4 xlv_TEXCOORD7;
in highp vec4 xlv_TEXCOORD8;
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
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD7);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
varying vec4 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
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
eefieceddgnegfgjofjjpnejbacobapogdaofbioabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaahaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaaomaaaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaa
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec4 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
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
#line 431
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 415
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 419
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 423
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
out highp vec4 xlv_TEXCOORD7;
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD7 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD8 = vec4(xl_retval._ShadowCoord);
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
#line 431
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 415
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 419
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 423
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
    mediump vec4 normalX = texture( _BumpMap, ((objNrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((objNrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((objNrm.xy * _BumpScale) + _BumpOffset.xy));
    objNrm = abs(objNrm);
    #line 485
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( objNrm.x));
    normal = mix( normal, normalY, vec4( objNrm.y));
    #line 489
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 493
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((1e-05 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 497
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 501
    mediump float diff = ((NdotL - 0.01) / 0.99);
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
in highp vec4 xlv_TEXCOORD7;
in highp vec4 xlv_TEXCOORD8;
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
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD7);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
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
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
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
eefiecedjglehiajglffloknhhcfccgdilahoneiabaaaaaaaaafaaaaadaaaaaa
cmaaaaaajmaaaaaaieabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
oaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaahaaaaaaaaaaaaaa
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

varying highp vec4 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
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
#line 421
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 405
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 409
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 413
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
#line 323
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
    highp vec4 _ShadowCoord;
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 405
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 409
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 413
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
    mediump vec4 normalX = texture( _BumpMap, ((objNrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((objNrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((objNrm.xy * _BumpScale) + _BumpOffset.xy));
    objNrm = abs(objNrm);
    #line 474
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( objNrm.x));
    normal = mix( normal, normalY, vec4( objNrm.y));
    #line 478
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 482
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((1e-05 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 486
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 490
    mediump float diff = ((NdotL - 0.01) / 0.99);
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
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
varying vec2 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
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
eefiecedaglephhmnnjhcoicfdjfmmbffefdcbegabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaahaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadapaaaaomaaaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaa
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

varying highp vec4 xlv_TEXCOORD8;
varying highp vec2 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec2 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
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
#line 423
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
#line 416
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 407
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 411
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 415
uniform highp float _RimDist;
#line 436
#line 461
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 436
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 440
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 444
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 448
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec2 xlv_TEXCOORD7;
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD7 = vec2(xl_retval._LightCoord);
    xlv_TEXCOORD8 = vec4(xl_retval._ShadowCoord);
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
#line 423
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
#line 416
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 407
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 411
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 415
uniform highp float _RimDist;
#line 436
#line 461
#line 450
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 452
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 456
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 461
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 465
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 469
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 473
    mediump vec4 normalX = texture( _BumpMap, ((objNrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((objNrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((objNrm.xy * _BumpScale) + _BumpOffset.xy));
    objNrm = abs(objNrm);
    #line 477
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( objNrm.x));
    normal = mix( normal, normalY, vec4( objNrm.y));
    #line 481
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 485
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((1e-05 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 489
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 493
    mediump float diff = ((NdotL - 0.01) / 0.99);
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
in highp vec2 xlv_TEXCOORD7;
in highp vec4 xlv_TEXCOORD8;
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
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD7);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
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
eefieceddlgahhldonipgaikaoljfmpmbmmllhkjabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaahaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaaomaaaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaa
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

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
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
#line 428
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 412
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 416
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 420
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
out highp vec3 xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
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
    xlv_TEXCOORD7 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD8 = vec3(xl_retval._ShadowCoord);
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
#line 428
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 412
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 416
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 420
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
    mediump vec4 normalX = texture( _BumpMap, ((objNrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((objNrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((objNrm.xy * _BumpScale) + _BumpOffset.xy));
    objNrm = abs(objNrm);
    #line 482
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( objNrm.x));
    normal = mix( normal, normalY, vec4( objNrm.y));
    #line 486
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 490
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((1e-05 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 494
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 498
    mediump float diff = ((NdotL - 0.01) / 0.99);
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
in highp vec3 xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
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
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD7);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
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
eefieceddlgahhldonipgaikaoljfmpmbmmllhkjabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaahaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaaomaaaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaa
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

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
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
#line 429
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
#line 422
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 413
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 417
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 421
uniform highp float _RimDist;
#line 442
#line 467
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 442
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 446
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 450
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 454
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
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
    xlv_TEXCOORD7 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD8 = vec3(xl_retval._ShadowCoord);
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
#line 429
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
#line 422
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 413
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 417
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 421
uniform highp float _RimDist;
#line 442
#line 467
#line 456
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 458
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 462
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 471
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 475
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 479
    mediump vec4 normalX = texture( _BumpMap, ((objNrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((objNrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((objNrm.xy * _BumpScale) + _BumpOffset.xy));
    objNrm = abs(objNrm);
    #line 483
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( objNrm.x));
    normal = mix( normal, normalY, vec4( objNrm.y));
    #line 487
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 491
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((1e-05 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 495
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 499
    mediump float diff = ((NdotL - 0.01) / 0.99);
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
in highp vec3 xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
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
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD7);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
varying vec4 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
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
eefieceddgnegfgjofjjpnejbacobapogdaofbioabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaahaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaaomaaaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaa
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

varying highp vec4 xlv_TEXCOORD8;
varying highp vec4 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
varying highp vec4 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
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
#line 438
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
#line 431
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 422
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 426
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 430
uniform highp float _RimDist;
#line 451
#line 476
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 451
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 455
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 459
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 463
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD7;
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD7 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD8 = vec4(xl_retval._ShadowCoord);
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
#line 438
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
#line 431
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 422
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 426
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 430
uniform highp float _RimDist;
#line 451
#line 476
#line 465
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 467
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 471
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 476
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 480
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 484
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 488
    mediump vec4 normalX = texture( _BumpMap, ((objNrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((objNrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((objNrm.xy * _BumpScale) + _BumpOffset.xy));
    objNrm = abs(objNrm);
    #line 492
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( objNrm.x));
    normal = mix( normal, normalY, vec4( objNrm.y));
    #line 496
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 500
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((1e-05 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 504
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 508
    mediump float diff = ((NdotL - 0.01) / 0.99);
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
in highp vec4 xlv_TEXCOORD7;
in highp vec4 xlv_TEXCOORD8;
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
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD7);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
varying vec4 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
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
eefieceddgnegfgjofjjpnejbacobapogdaofbioabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaahaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaaomaaaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaa
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec4 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
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
#line 438
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
#line 431
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 422
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 426
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 430
uniform highp float _RimDist;
#line 451
#line 476
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 451
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 455
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 459
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 463
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD7;
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD7 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD8 = vec4(xl_retval._ShadowCoord);
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
#line 438
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
#line 431
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 422
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 426
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 430
uniform highp float _RimDist;
#line 451
#line 476
#line 465
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 467
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 471
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 476
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 480
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 484
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 488
    mediump vec4 normalX = texture( _BumpMap, ((objNrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((objNrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((objNrm.xy * _BumpScale) + _BumpOffset.xy));
    objNrm = abs(objNrm);
    #line 492
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( objNrm.x));
    normal = mix( normal, normalY, vec4( objNrm.y));
    #line 496
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 500
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((1e-05 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 504
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 508
    mediump float diff = ((NdotL - 0.01) / 0.99);
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
in highp vec4 xlv_TEXCOORD7;
in highp vec4 xlv_TEXCOORD8;
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
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD7);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
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
eefieceddlgahhldonipgaikaoljfmpmbmmllhkjabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaahaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaaomaaaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaa
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

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
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
#line 434
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
#line 427
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 418
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 422
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 426
uniform highp float _RimDist;
#line 447
#line 472
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 447
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 451
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 455
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((vertexPos - origin));
    o.objNormal = vec3( normalize(v.vertex));
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    #line 459
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
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
    xlv_TEXCOORD7 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD8 = vec3(xl_retval._ShadowCoord);
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
#line 434
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
#line 427
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 418
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 422
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 426
uniform highp float _RimDist;
#line 447
#line 472
#line 461
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 463
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 467
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 472
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    #line 476
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.z, objNrm.x)));
    uv.y = (0.31831 * acos((-objNrm.y)));
    highp vec4 uvdd = Derivatives( objNrm);
    #line 480
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy * _DetailScale) + _DetailOffset.xy));
    #line 484
    mediump vec4 normalX = texture( _BumpMap, ((objNrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((objNrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((objNrm.xy * _BumpScale) + _BumpOffset.xy));
    objNrm = abs(objNrm);
    #line 488
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( objNrm.x));
    normal = mix( normal, normalY, vec4( objNrm.y));
    #line 492
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 496
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((1e-05 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 500
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 504
    mediump float diff = ((NdotL - 0.01) / 0.99);
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
in highp vec3 xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
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
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD7);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
  color_2.w = mix (0.0, tmpvar_17.w, mix (clamp (((_FadeScale * sqrt(dot (p_18, p_18))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_19, p_19)) - (1.05 * sqrt(dot (p_20, p_20))))), 0.0, 1.0)));
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
eefieceddlgahhldonipgaikaoljfmpmbmmllhkjabaaaaaabiafaaaaadaaaaaa
cmaaaaaajmaaaaaajmabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
piaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaahaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaaomaaaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaa
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

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD7;
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
  xlv_TEXCOORD7 = tmpvar_1;
  xlv_TEXCOORD8 = tmpvar_2;
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
uniform highp float _BumpScale;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
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
  mediump vec4 normal_6;
  mediump vec4 detail_7;
  mediump vec4 normalZ_8;
  mediump vec4 normalY_9;
  mediump vec4 normalX_10;
  mediump vec4 detailZ_11;
  mediump vec4 detailY_12;
  mediump vec4 detailX_13;
  mediump vec4 main_14;
  highp vec2 uv_15;
  mediump vec4 color_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD4.z / xlv_TEXCOORD4.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD4.z) * 1.5708);
  };
  uv_15.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD4.y);
  uv_15.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD4.x) > (1e-08 * abs(xlv_TEXCOORD4.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD4.y / xlv_TEXCOORD4.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD4.x < 0.0)) {
      if ((xlv_TEXCOORD4.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD4.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.z))) * (1.5708 + (abs(xlv_TEXCOORD4.z) * (-0.214602 + (abs(xlv_TEXCOORD4.z) * (0.0865667 + (abs(xlv_TEXCOORD4.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD4.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD4.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_15, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_14 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD4.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_13 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD4.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_12 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD4.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_11 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD4.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_10 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD4.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_9 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD4.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_8 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_11, detailX_13, tmpvar_43.xxxx);
  detail_7 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_7, detailY_12, tmpvar_43.yyyy);
  detail_7 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_8, normalX_10, tmpvar_43.xxxx);
  normal_6 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_6, normalY_9, tmpvar_43.yyyy);
  normal_6 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49 = (main_14 * mix (detail_7, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_49.w, mix (clamp (((_FadeScale * sqrt(dot (p_50, p_50))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(dot (xlv_TEXCOORD5, xlv_TEXCOORD3)), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((1e-05 * (sqrt(dot (p_51, p_51)) - (1.05 * sqrt(dot (p_52, p_52))))), 0.0, 1.0)));
  color_16.w = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  color_16.xyz = (tmpvar_49.xyz * tmpvar_58);
  tmpvar_1 = color_16;
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
#line 435
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 419
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 423
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 427
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
out highp vec3 xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
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
    xlv_TEXCOORD7 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD8 = vec3(xl_retval._ShadowCoord);
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
#line 435
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
uniform sampler2D _BumpMap;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _BumpOffset;
#line 419
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 423
uniform highp float _BumpScale;
uniform highp float _MinLight;
uniform highp float _FadeDist;
uniform highp float _FadeScale;
#line 427
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
    mediump vec4 normalX = texture( _BumpMap, ((objNrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((objNrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((objNrm.xy * _BumpScale) + _BumpOffset.xy));
    objNrm = abs(objNrm);
    #line 489
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( objNrm.x));
    normal = mix( normal, normalY, vec4( objNrm.y));
    #line 493
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    highp float rim = xll_saturate_f(abs(dot( IN.viewDir, IN.worldNormal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    #line 497
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((1e-05 * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.05 * distance( IN.worldVert, IN.worldOrigin)))));
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    #line 501
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    #line 505
    mediump float diff = ((NdotL - 0.01) / 0.99);
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
in highp vec3 xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
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
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD7);
    xlt_IN._ShadowCoord = vec3(xlv_TEXCOORD8);
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
def c18, 1.04999995, 0.00001000, 0, 0
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
ConstBuffer "$Globals" 208 // 192 used size, 16 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 180 [_MinLight]
Float 184 [_FadeDist]
Float 188 [_FadeScale]
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
eefiecedehfkkajhmncgijbbijgfdjlkiheolbclabaaaaaabeaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
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
aaaaaaaaakaaaaaaegiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
dcaabaaaadaaaaaaegbabaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaaegiacaaa
aaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaa
aeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
fgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaal
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaa
aaaaaaaaakaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaia
ebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaa
dicaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaakmmfchdhbaaaaaah
ccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaa
abaaaaaabkaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaa
ddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaj
hcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaadkiacaaa
aaaaaaaaalaaaaaackaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaalaaaaaa
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
fgifcaaaaaaaaaaaalaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
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
def c18, 1.04999995, 0.00001000, 0, 0
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
ConstBuffer "$Globals" 144 // 128 used size, 15 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Vector 64 [_DetailOffset] 4
Float 96 [_FalloffPow]
Float 100 [_FalloffScale]
Float 104 [_DetailScale]
Float 108 [_DetailDist]
Float 116 [_MinLight]
Float 120 [_FadeDist]
Float 124 [_FadeScale]
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
eefiecedpdagfhinnghkgefbkogkhckbnlgmmdcaabaaaaaapmanaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmeamaaaaeaaaaaaadbadaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
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
aeaaaaaakgikcaaaaaaaaaaaagaaaaaaegiecaaaaaaaaaaaaeaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaldcaabaaaadaaaaaaegbabaaaaeaaaaaakgikcaaaaaaaaaaa
agaaaaaaegiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaa
agbabaiaibaaaaaaaeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaak
pcaabaaaabaaaaaafgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaaaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaa
abaaaaaapgipcaaaaaaaaaaaagaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaa
adaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaa
acaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaa
abaaaaaaagbjbaiaebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaa
abaaaaaajgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaa
dcaaaaakbcaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaggggigdp
akaabaaaabaaaaaadicaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
kmmfchdhbaaaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaa
ddaaaaaiccaabaaaabaaaaaabkaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadp
diaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaagaaaaaa
cpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaa
bkaabaaaabaaaaaaakiacaaaaaaaaaaaagaaaaaabjaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaiadpaaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaa
abaaaaaadkiacaaaaaaaaaaaahaaaaaackaabaaaabaaaaaackiacaiaebaaaaaa
aaaaaaaaahaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaa
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
aaaaaaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaadccaaaakhcaabaaaabaaaaaa
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
def c18, 1.04999995, 0.00001000, 0, 0
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
ConstBuffer "$Globals" 208 // 192 used size, 16 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 180 [_MinLight]
Float 184 [_FadeDist]
Float 188 [_FadeScale]
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
eefiecedpionldlbglaapoonpmgglfhibggjhpkbabaaaaaabeaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
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
aaaaaaaaakaaaaaaegiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
dcaabaaaadaaaaaaegbabaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaaegiacaaa
aaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaa
aeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
fgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaal
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaa
aaaaaaaaakaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaia
ebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaa
dicaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaakmmfchdhbaaaaaah
ccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaa
abaaaaaabkaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaa
ddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaj
hcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaadkiacaaa
aaaaaaaaalaaaaaackaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaalaaaaaa
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
fgifcaaaaaaaaaaaalaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
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
def c18, 1.04999995, 0.00001000, 0, 0
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
ConstBuffer "$Globals" 208 // 192 used size, 16 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 180 [_MinLight]
Float 184 [_FadeDist]
Float 188 [_FadeScale]
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
eefiecedehfkkajhmncgijbbijgfdjlkiheolbclabaaaaaabeaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
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
aaaaaaaaakaaaaaaegiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
dcaabaaaadaaaaaaegbabaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaaegiacaaa
aaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaa
aeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
fgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaal
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaa
aaaaaaaaakaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaia
ebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaa
dicaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaakmmfchdhbaaaaaah
ccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaa
abaaaaaabkaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaa
ddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaj
hcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaadkiacaaa
aaaaaaaaalaaaaaackaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaalaaaaaa
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
fgifcaaaaaaaaaaaalaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
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
def c18, 1.04999995, 0.00001000, 0, 0
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
ConstBuffer "$Globals" 208 // 192 used size, 16 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 180 [_MinLight]
Float 184 [_FadeDist]
Float 188 [_FadeScale]
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
eefiecednfjfkamleffdhocdimlgidaojhllamdgabaaaaaabeaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaadaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
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
aaaaaaaaakaaaaaaegiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
dcaabaaaadaaaaaaegbabaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaaegiacaaa
aaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaa
aeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
fgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaal
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaa
aaaaaaaaakaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaia
ebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaa
dicaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaakmmfchdhbaaaaaah
ccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaa
abaaaaaabkaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaa
ddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaj
hcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaadkiacaaa
aaaaaaaaalaaaaaackaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaalaaaaaa
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
fgifcaaaaaaaaaaaalaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
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
def c18, 1.04999995, 0.00001000, 0, 0
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
ConstBuffer "$Globals" 208 // 192 used size, 16 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 180 [_MinLight]
Float 184 [_FadeDist]
Float 188 [_FadeScale]
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
eefiecedkignmkgnfoeinkbbmmhepchmoeogdbjkabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaa
aiaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
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
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaa
egiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaaegiacaaaaaaaaaaaaiaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaakmmfchdhbaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
akaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
ckaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaalaaaaaaaaaaaaaiccaabaaa
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
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaafgifcaaaaaaaaaaa
alaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
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
def c18, 1.04999995, 0.00001000, 0, 0
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
ConstBuffer "$Globals" 208 // 192 used size, 16 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 180 [_MinLight]
Float 184 [_FadeDist]
Float 188 [_FadeScale]
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
eefiecedkignmkgnfoeinkbbmmhepchmoeogdbjkabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaa
aiaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
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
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaa
egiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaaegiacaaaaaaaaaaaaiaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaakmmfchdhbaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
akaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
ckaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaalaaaaaaaaaaaaaiccaabaaa
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
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaafgifcaaaaaaaaaaa
alaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
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
def c18, 1.04999995, 0.00001000, 0, 0
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
ConstBuffer "$Globals" 208 // 192 used size, 16 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 180 [_MinLight]
Float 184 [_FadeDist]
Float 188 [_FadeScale]
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
eefiecedpionldlbglaapoonpmgglfhibggjhpkbabaaaaaabeaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
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
aaaaaaaaakaaaaaaegiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
dcaabaaaadaaaaaaegbabaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaaegiacaaa
aaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaa
aeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
fgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaal
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaa
aaaaaaaaakaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaia
ebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaa
dicaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaakmmfchdhbaaaaaah
ccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaa
abaaaaaabkaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
akiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaa
ddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaj
hcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaadkiacaaa
aaaaaaaaalaaaaaackaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaalaaaaaa
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
fgifcaaaaaaaaaaaalaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
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
def c18, 1.04999995, 0.00001000, 0, 0
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
ConstBuffer "$Globals" 272 // 256 used size, 17 vars
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Vector 192 [_DetailOffset] 4
Float 224 [_FalloffPow]
Float 228 [_FalloffScale]
Float 232 [_DetailScale]
Float 236 [_DetailDist]
Float 244 [_MinLight]
Float 248 [_FadeDist]
Float 252 [_FadeScale]
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
eefiecedlghiehcoigalggilefmnhmckcdhjbcbgabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaadaaaaaaomaaaaaa
aiaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
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
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaaoaaaaaa
egiecaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaaoaaaaaaegiacaaaaaaaaaaaamaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaaoaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaakmmfchdhbaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaaoaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
aoaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaadkiacaaaaaaaaaaaapaaaaaa
ckaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaapaaaaaaaaaaaaaiccaabaaa
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
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaafgifcaaaaaaaaaaa
apaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
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
def c18, 1.04999995, 0.00001000, 0, 0
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
ConstBuffer "$Globals" 208 // 192 used size, 16 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 180 [_MinLight]
Float 184 [_FadeDist]
Float 188 [_FadeScale]
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
eefiecedjcmadaomhgjaokfnfmlckjkikkfibjgmabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
aiaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
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
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaa
egiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaaegiacaaaaaaaaaaaaiaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaakmmfchdhbaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
akaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
ckaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaalaaaaaaaaaaaaaiccaabaaa
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
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaafgifcaaaaaaaaaaa
alaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
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
def c18, 1.04999995, 0.00001000, 0, 0
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
ConstBuffer "$Globals" 208 // 192 used size, 16 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 180 [_MinLight]
Float 184 [_FadeDist]
Float 188 [_FadeScale]
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
eefiecedjcmadaomhgjaokfnfmlckjkikkfibjgmabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
aiaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
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
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaa
egiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaaegiacaaaaaaaaaaaaiaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaakmmfchdhbaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
akaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
ckaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaalaaaaaaaaaaaaaiccaabaaa
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
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaafgifcaaaaaaaaaaa
alaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
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
def c18, 1.04999995, 0.00001000, 0, 0
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
ConstBuffer "$Globals" 272 // 256 used size, 17 vars
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Vector 192 [_DetailOffset] 4
Float 224 [_FalloffPow]
Float 228 [_FalloffScale]
Float 232 [_DetailScale]
Float 236 [_DetailDist]
Float 244 [_MinLight]
Float 248 [_FadeDist]
Float 252 [_FadeScale]
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
eefiecedllmhbeahlecomfdoogjkmjnoeojomnpmabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaa
aiaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
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
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaaoaaaaaa
egiecaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaaoaaaaaaegiacaaaaaaaaaaaamaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaaoaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaakmmfchdhbaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaaoaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
aoaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaadkiacaaaaaaaaaaaapaaaaaa
ckaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaapaaaaaaaaaaaaaiccaabaaa
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
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaafgifcaaaaaaaaaaa
apaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
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
def c18, 1.04999995, 0.00001000, 0, 0
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
ConstBuffer "$Globals" 272 // 256 used size, 17 vars
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Vector 192 [_DetailOffset] 4
Float 224 [_FalloffPow]
Float 228 [_FalloffScale]
Float 232 [_DetailScale]
Float 236 [_DetailDist]
Float 244 [_MinLight]
Float 248 [_FadeDist]
Float 252 [_FadeScale]
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
eefiecedllmhbeahlecomfdoogjkmjnoeojomnpmabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaa
aiaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
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
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaaoaaaaaa
egiecaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaaoaaaaaaegiacaaaaaaaaaaaamaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaaoaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaakmmfchdhbaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaaoaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
aoaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaadkiacaaaaaaaaaaaapaaaaaa
ckaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaapaaaaaaaaaaaaaiccaabaaa
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
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaafgifcaaaaaaaaaaa
apaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
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
def c18, 1.04999995, 0.00001000, 0, 0
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
ConstBuffer "$Globals" 208 // 192 used size, 16 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 180 [_MinLight]
Float 184 [_FadeDist]
Float 188 [_FadeScale]
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
eefiecedjcmadaomhgjaokfnfmlckjkikkfibjgmabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
aiaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
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
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaa
egiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaaegiacaaaaaaaaaaaaiaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaakmmfchdhbaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
akaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
ckaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaalaaaaaaaaaaaaaiccaabaaa
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
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaafgifcaaaaaaaaaaa
alaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
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
def c18, 1.04999995, 0.00001000, 0, 0
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
ConstBuffer "$Globals" 208 // 192 used size, 16 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 180 [_MinLight]
Float 184 [_FadeDist]
Float 188 [_FadeScale]
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
eefiecedjcmadaomhgjaokfnfmlckjkikkfibjgmabaaaaaacmaoaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaaomaaaaaa
aiaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmeamaaaaeaaaaaaadbadaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
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
dcaaaaalpcaabaaaabaaaaaaggbcbaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaa
egiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
egbabaaaaeaaaaaakgikcaaaaaaaaaaaakaaaaaaegiacaaaaaaaaaaaaiaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaa
aeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
apcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaggggigdpakaabaaaabaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaakmmfchdhbaaaaaahccaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaadaaaaaaddaaaaaiccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
akaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaa
egbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadccaaaamecaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
ckaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaalaaaaaaaaaaaaaiccaabaaa
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
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaafgifcaaaaaaaaaaa
alaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
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

#LINE 161

	
		}
		
	} 
	
}
}
