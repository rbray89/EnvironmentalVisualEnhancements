Shader "Sphere/Cloud" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_MainOffset ("Main Offset", Vector) = (0,0,0,0)
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		_FalloffPow ("Falloff Power", Range(0,3)) = 2
		_FalloffScale ("Falloff Scale", Range(0,20)) = 3
		_DetailScale ("Detail Scale", Range(0,1000)) = 100
		_DetailOffset ("Detail Offset", Vector) = (0,0,0,0)
		_DetailDist ("Detail Distance", Range(0,1)) = 0.00875
		_MinLight ("Minimum Light", Range(0,1)) = .5
		_FadeDist ("Fade Distance", Range(0,100)) = 10
		_FadeScale ("Fade Scale", Range(0,1)) = .002
		_RimDist ("Rim Distance", Range(0,1)) = 1
		_RimDistSub ("Rim Distance Sub", Range(0,2)) = 1.01
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
//   d3d9 - ALU: 29 to 29
//   d3d11 - ALU: 27 to 27, TEX: 0 to 0, FLOW: 1 to 1
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
uniform mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
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
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_Rotation]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r2.z, v0, c6
dp4 r2.y, v0, c5
dp4 r2.x, v0, c4
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r0.xyz, r2, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 r0.w, r0, r0
rsq r1.w, r0.w
add r3.xyz, -r2, c12
dp3 r0.w, r3, r3
rsq r0.w, r0.w
mul r0.xyz, r1.w, r0
mov o5.xyz, -r0
mul o6.xyz, r0.w, r3
mov o1.xyz, r2
mov o2.xyz, r1
rcp o3.x, r0.w
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
ConstBuffer "$Globals" 272 // 272 used size, 17 vars
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkhchdmnfpboedkimjgcpcikifldiofbgabaaaaaamaafaaaaadaaaaaa
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
aaklklklfdeieefcdeaeaaaaeaaaabaaanabaaaafjaaaaaeegiocaaaaaaaaaaa
bbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
elaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
apaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaanaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaabbaaaaahicaabaaaaaaaaaaaegaobaaaabaaaaaa
egaobaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaa
aeaaaaaaegacbaiaebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 399
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 403
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 407
uniform highp mat4 _Rotation;
#line 427
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
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 439
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 399
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 403
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 407
uniform highp mat4 _Rotation;
#line 427
#line 442
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 444
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 448
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 451
lowp vec4 frag( in v2f IN ) {
    #line 453
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 457
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 461
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 465
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 469
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 473
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 477
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 481
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
uniform mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
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
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_Rotation]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r2.z, v0, c6
dp4 r2.y, v0, c5
dp4 r2.x, v0, c4
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r0.xyz, r2, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 r0.w, r0, r0
rsq r1.w, r0.w
add r3.xyz, -r2, c12
dp3 r0.w, r3, r3
rsq r0.w, r0.w
mul r0.xyz, r1.w, r0
mov o5.xyz, -r0
mul o6.xyz, r0.w, r3
mov o1.xyz, r2
mov o2.xyz, r1
rcp o3.x, r0.w
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
ConstBuffer "$Globals" 208 // 208 used size, 16 vars
Matrix 144 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedleagncbbajgpiikbhhkencajkhkgnomhabaaaaaakiafaaaaadaaaaaa
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
feeffiedepepfceeaaklklklfdeieefcdeaeaaaaeaaaabaaanabaaaafjaaaaae
egiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaadgaaaaaf
hccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaa
acaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaacaaaaaaapaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaakaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaajaaaaaaagbabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaalaaaaaakgbkbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
amaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaabbaaaaahicaabaaaaaaaaaaa
egaobaaaabaaaaaaegaobaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaabaaaaaahicaabaaa
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  lowp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  lowp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 397
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 401
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 405
uniform highp mat4 _Rotation;
#line 424
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
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 436
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 397
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 401
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 405
uniform highp mat4 _Rotation;
#line 424
#line 439
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 441
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 445
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 448
lowp vec4 frag( in v2f IN ) {
    #line 450
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 454
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 458
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 462
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 466
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 470
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 474
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 478
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
uniform mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
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
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_Rotation]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r2.z, v0, c6
dp4 r2.y, v0, c5
dp4 r2.x, v0, c4
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r0.xyz, r2, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 r0.w, r0, r0
rsq r1.w, r0.w
add r3.xyz, -r2, c12
dp3 r0.w, r3, r3
rsq r0.w, r0.w
mul r0.xyz, r1.w, r0
mov o5.xyz, -r0
mul o6.xyz, r0.w, r3
mov o1.xyz, r2
mov o2.xyz, r1
rcp o3.x, r0.w
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
ConstBuffer "$Globals" 272 // 272 used size, 17 vars
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedemgogdafibhaimdmhfbefldchjmmnhnfabaaaaaamaafaaaaadaaaaaa
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
aaklklklfdeieefcdeaeaaaaeaaaabaaanabaaaafjaaaaaeegiocaaaaaaaaaaa
bbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
elaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
apaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaanaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaabbaaaaahicaabaaaaaaaaaaaegaobaaaabaaaaaa
egaobaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaa
aeaaaaaaegacbaiaebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 408
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 412
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 416
uniform highp mat4 _Rotation;
#line 436
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
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 448
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 408
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 412
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 416
uniform highp mat4 _Rotation;
#line 436
#line 451
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 453
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 457
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 460
lowp vec4 frag( in v2f IN ) {
    #line 462
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 466
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 470
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 474
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 478
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 482
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 486
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 490
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
uniform mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
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
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_Rotation]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r2.z, v0, c6
dp4 r2.y, v0, c5
dp4 r2.x, v0, c4
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r0.xyz, r2, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 r0.w, r0, r0
rsq r1.w, r0.w
add r3.xyz, -r2, c12
dp3 r0.w, r3, r3
rsq r0.w, r0.w
mul r0.xyz, r1.w, r0
mov o5.xyz, -r0
mul o6.xyz, r0.w, r3
mov o1.xyz, r2
mov o2.xyz, r1
rcp o3.x, r0.w
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
ConstBuffer "$Globals" 272 // 272 used size, 17 vars
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkhchdmnfpboedkimjgcpcikifldiofbgabaaaaaamaafaaaaadaaaaaa
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
aaklklklfdeieefcdeaeaaaaeaaaabaaanabaaaafjaaaaaeegiocaaaaaaaaaaa
bbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
elaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
apaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaanaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaabbaaaaahicaabaaaaaaaaaaaegaobaaaabaaaaaa
egaobaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaa
aeaaaaaaegacbaiaebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 400
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 404
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 408
uniform highp mat4 _Rotation;
#line 428
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
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 440
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 400
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 404
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 408
uniform highp mat4 _Rotation;
#line 428
#line 443
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 445
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 449
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 452
lowp vec4 frag( in v2f IN ) {
    #line 454
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 458
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 462
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 466
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 470
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 474
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 478
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 482
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
uniform mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
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
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_Rotation]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r2.z, v0, c6
dp4 r2.y, v0, c5
dp4 r2.x, v0, c4
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r0.xyz, r2, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 r0.w, r0, r0
rsq r1.w, r0.w
add r3.xyz, -r2, c12
dp3 r0.w, r3, r3
rsq r0.w, r0.w
mul r0.xyz, r1.w, r0
mov o5.xyz, -r0
mul o6.xyz, r0.w, r3
mov o1.xyz, r2
mov o2.xyz, r1
rcp o3.x, r0.w
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
ConstBuffer "$Globals" 272 // 272 used size, 17 vars
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedaoccaknjhglfgcdmffbahmnlokecflbhabaaaaaamaafaaaaadaaaaaa
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
aaklklklfdeieefcdeaeaaaaeaaaabaaanabaaaafjaaaaaeegiocaaaaaaaaaaa
bbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
elaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
apaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaanaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaabbaaaaahicaabaaaaaaaaaaaegaobaaaabaaaaaa
egaobaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaa
aeaaaaaaegacbaiaebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  lowp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  lowp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 399
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 403
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 407
uniform highp mat4 _Rotation;
#line 427
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
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 439
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 399
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 403
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 407
uniform highp mat4 _Rotation;
#line 427
#line 442
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 444
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 448
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 451
lowp vec4 frag( in v2f IN ) {
    #line 453
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 457
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 461
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 465
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 469
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 473
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 477
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 481
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
uniform mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
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
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_Rotation]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r2.z, v0, c6
dp4 r2.y, v0, c5
dp4 r2.x, v0, c4
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r0.xyz, r2, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 r0.w, r0, r0
rsq r1.w, r0.w
add r3.xyz, -r2, c12
dp3 r0.w, r3, r3
rsq r0.w, r0.w
mul r0.xyz, r1.w, r0
mov o5.xyz, -r0
mul o6.xyz, r0.w, r3
mov o1.xyz, r2
mov o2.xyz, r1
rcp o3.x, r0.w
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
ConstBuffer "$Globals" 272 // 272 used size, 17 vars
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhndacmpiaedaadcbnhldahbhimgfmggeabaaaaaaniafaaaaadaaaaaa
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
deaeaaaaeaaaabaaanabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaa
abaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
anaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaabbaaaaahicaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaia
ebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 414
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 418
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 422
uniform highp mat4 _Rotation;
#line 443
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
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 455
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 414
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 418
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 422
uniform highp mat4 _Rotation;
#line 443
#line 458
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 460
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 464
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 467
lowp vec4 frag( in v2f IN ) {
    #line 469
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 473
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 477
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 481
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 485
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 489
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 493
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 497
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
uniform mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
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
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_Rotation]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r2.z, v0, c6
dp4 r2.y, v0, c5
dp4 r2.x, v0, c4
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r0.xyz, r2, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 r0.w, r0, r0
rsq r1.w, r0.w
add r3.xyz, -r2, c12
dp3 r0.w, r3, r3
rsq r0.w, r0.w
mul r0.xyz, r1.w, r0
mov o5.xyz, -r0
mul o6.xyz, r0.w, r3
mov o1.xyz, r2
mov o2.xyz, r1
rcp o3.x, r0.w
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
ConstBuffer "$Globals" 272 // 272 used size, 17 vars
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhndacmpiaedaadcbnhldahbhimgfmggeabaaaaaaniafaaaaadaaaaaa
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
deaeaaaaeaaaabaaanabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaa
abaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
anaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaabbaaaaahicaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaia
ebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 415
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 419
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 423
uniform highp mat4 _Rotation;
#line 444
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
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 456
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 415
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 419
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 423
uniform highp mat4 _Rotation;
#line 444
#line 459
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 461
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 465
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 468
lowp vec4 frag( in v2f IN ) {
    #line 470
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 474
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 478
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 482
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 486
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 490
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 494
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 498
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
uniform mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
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
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_Rotation]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r2.z, v0, c6
dp4 r2.y, v0, c5
dp4 r2.x, v0, c4
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r0.xyz, r2, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 r0.w, r0, r0
rsq r1.w, r0.w
add r3.xyz, -r2, c12
dp3 r0.w, r3, r3
rsq r0.w, r0.w
mul r0.xyz, r1.w, r0
mov o5.xyz, -r0
mul o6.xyz, r0.w, r3
mov o1.xyz, r2
mov o2.xyz, r1
rcp o3.x, r0.w
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
ConstBuffer "$Globals" 272 // 272 used size, 17 vars
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedemgogdafibhaimdmhfbefldchjmmnhnfabaaaaaamaafaaaaadaaaaaa
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
aaklklklfdeieefcdeaeaaaaeaaaabaaanabaaaafjaaaaaeegiocaaaaaaaaaaa
bbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
elaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
apaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaanaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaabbaaaaahicaabaaaaaaaaaaaegaobaaaabaaaaaa
egaobaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaa
aeaaaaaaegacbaiaebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  lowp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  lowp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 405
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 409
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 413
uniform highp mat4 _Rotation;
#line 433
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
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 445
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 405
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 409
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 413
uniform highp mat4 _Rotation;
#line 433
#line 448
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 450
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 454
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 457
lowp vec4 frag( in v2f IN ) {
    #line 459
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 463
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 467
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 471
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 475
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 479
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 483
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 487
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
uniform mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
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
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_Rotation]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r2.z, v0, c6
dp4 r2.y, v0, c5
dp4 r2.x, v0, c4
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r0.xyz, r2, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 r0.w, r0, r0
rsq r1.w, r0.w
add r3.xyz, -r2, c12
dp3 r0.w, r3, r3
rsq r0.w, r0.w
mul r0.xyz, r1.w, r0
mov o5.xyz, -r0
mul o6.xyz, r0.w, r3
mov o1.xyz, r2
mov o2.xyz, r1
rcp o3.x, r0.w
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
ConstBuffer "$Globals" 336 // 336 used size, 18 vars
Matrix 272 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedjfneehmafbfpenbafkljfbgekjeolpmaabaaaaaaniafaaaaadaaaaaa
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
deaeaaaaeaaaabaaanabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaa
abaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaabcaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
bbaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaabdaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabeaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaabbaaaaahicaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaia
ebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  lowp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  lowp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 407
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 411
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 415
uniform highp mat4 _Rotation;
#line 436
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
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 448
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 407
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 411
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 415
uniform highp mat4 _Rotation;
#line 436
#line 451
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 453
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 457
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 460
lowp vec4 frag( in v2f IN ) {
    #line 462
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 466
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 470
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 474
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 478
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 482
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 486
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 490
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
uniform mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
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
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_Rotation]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r2.z, v0, c6
dp4 r2.y, v0, c5
dp4 r2.x, v0, c4
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r0.xyz, r2, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 r0.w, r0, r0
rsq r1.w, r0.w
add r3.xyz, -r2, c12
dp3 r0.w, r3, r3
rsq r0.w, r0.w
mul r0.xyz, r1.w, r0
mov o5.xyz, -r0
mul o6.xyz, r0.w, r3
mov o1.xyz, r2
mov o2.xyz, r1
rcp o3.x, r0.w
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
ConstBuffer "$Globals" 272 // 272 used size, 17 vars
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbajbccjlcnhphhmgpnlnofkbcilhnoanabaaaaaaniafaaaaadaaaaaa
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
deaeaaaaeaaaabaaanabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaa
abaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
anaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaabbaaaaahicaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaia
ebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 412
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 416
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 420
uniform highp mat4 _Rotation;
#line 441
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
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 453
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 412
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 416
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 420
uniform highp mat4 _Rotation;
#line 441
#line 456
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 458
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 462
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 465
lowp vec4 frag( in v2f IN ) {
    #line 467
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 471
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 475
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 479
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 483
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 487
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 491
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 495
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
uniform mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
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
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_Rotation]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r2.z, v0, c6
dp4 r2.y, v0, c5
dp4 r2.x, v0, c4
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r0.xyz, r2, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 r0.w, r0, r0
rsq r1.w, r0.w
add r3.xyz, -r2, c12
dp3 r0.w, r3, r3
rsq r0.w, r0.w
mul r0.xyz, r1.w, r0
mov o5.xyz, -r0
mul o6.xyz, r0.w, r3
mov o1.xyz, r2
mov o2.xyz, r1
rcp o3.x, r0.w
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
ConstBuffer "$Globals" 272 // 272 used size, 17 vars
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbajbccjlcnhphhmgpnlnofkbcilhnoanabaaaaaaniafaaaaadaaaaaa
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
deaeaaaaeaaaabaaanabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaa
abaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
anaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaabbaaaaahicaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaia
ebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 413
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 417
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 421
uniform highp mat4 _Rotation;
#line 442
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
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 454
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 413
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 417
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 421
uniform highp mat4 _Rotation;
#line 442
#line 457
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 459
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 463
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 466
lowp vec4 frag( in v2f IN ) {
    #line 468
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 472
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 476
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 480
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 484
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 488
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 492
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 496
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
uniform mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
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
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_Rotation]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r2.z, v0, c6
dp4 r2.y, v0, c5
dp4 r2.x, v0, c4
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r0.xyz, r2, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 r0.w, r0, r0
rsq r1.w, r0.w
add r3.xyz, -r2, c12
dp3 r0.w, r3, r3
rsq r0.w, r0.w
mul r0.xyz, r1.w, r0
mov o5.xyz, -r0
mul o6.xyz, r0.w, r3
mov o1.xyz, r2
mov o2.xyz, r1
rcp o3.x, r0.w
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
ConstBuffer "$Globals" 336 // 336 used size, 18 vars
Matrix 272 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedlkhchcmmbbklcnpnanbjplobokolkkdcabaaaaaaniafaaaaadaaaaaa
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
deaeaaaaeaaaabaaanabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaa
abaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaabcaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
bbaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaabdaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabeaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaabbaaaaahicaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaia
ebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 422
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 426
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 430
uniform highp mat4 _Rotation;
#line 451
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
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 463
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 422
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 426
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 430
uniform highp mat4 _Rotation;
#line 451
#line 466
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 468
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 472
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 475
lowp vec4 frag( in v2f IN ) {
    #line 477
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 481
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 485
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 489
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 493
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 497
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 501
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 505
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
uniform mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
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
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_Rotation]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r2.z, v0, c6
dp4 r2.y, v0, c5
dp4 r2.x, v0, c4
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r0.xyz, r2, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 r0.w, r0, r0
rsq r1.w, r0.w
add r3.xyz, -r2, c12
dp3 r0.w, r3, r3
rsq r0.w, r0.w
mul r0.xyz, r1.w, r0
mov o5.xyz, -r0
mul o6.xyz, r0.w, r3
mov o1.xyz, r2
mov o2.xyz, r1
rcp o3.x, r0.w
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
ConstBuffer "$Globals" 336 // 336 used size, 18 vars
Matrix 272 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedlkhchcmmbbklcnpnanbjplobokolkkdcabaaaaaaniafaaaaadaaaaaa
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
deaeaaaaeaaaabaaanabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaa
abaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaabcaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
bbaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaabdaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabeaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaabbaaaaahicaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaia
ebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 422
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 426
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 430
uniform highp mat4 _Rotation;
#line 451
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
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 463
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 422
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 426
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 430
uniform highp mat4 _Rotation;
#line 451
#line 466
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 468
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 472
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 475
lowp vec4 frag( in v2f IN ) {
    #line 477
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 481
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 485
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 489
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 493
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 497
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 501
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 505
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
uniform mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
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
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_Rotation]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r2.z, v0, c6
dp4 r2.y, v0, c5
dp4 r2.x, v0, c4
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r0.xyz, r2, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 r0.w, r0, r0
rsq r1.w, r0.w
add r3.xyz, -r2, c12
dp3 r0.w, r3, r3
rsq r0.w, r0.w
mul r0.xyz, r1.w, r0
mov o5.xyz, -r0
mul o6.xyz, r0.w, r3
mov o1.xyz, r2
mov o2.xyz, r1
rcp o3.x, r0.w
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
ConstBuffer "$Globals" 272 // 272 used size, 17 vars
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbajbccjlcnhphhmgpnlnofkbcilhnoanabaaaaaaniafaaaaadaaaaaa
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
deaeaaaaeaaaabaaanabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaa
abaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
anaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaabbaaaaahicaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaia
ebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 418
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 422
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 426
uniform highp mat4 _Rotation;
#line 447
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
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 459
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 418
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 422
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 426
uniform highp mat4 _Rotation;
#line 447
#line 462
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 464
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 468
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 471
lowp vec4 frag( in v2f IN ) {
    #line 473
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 477
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 481
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 485
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 489
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 493
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 497
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 501
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
uniform mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * gl_Vertex))).xyz;
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
uniform float _RimDistSub;
uniform float _RimDist;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _DetailOffset;
uniform vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_1.x = (0.5 + (0.159155 * r_3));
  uv_1.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  vec2 tmpvar_7;
  tmpvar_7 = (uv_1 + _MainOffset.xy);
  uv_1 = tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8 = dFdx(xlv_TEXCOORD4.xz);
  vec2 tmpvar_9;
  tmpvar_9 = dFdy(xlv_TEXCOORD4.xz);
  vec4 tmpvar_10;
  tmpvar_10.x = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_10.y = dFdx(tmpvar_7.y);
  tmpvar_10.z = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_10.w = dFdy(tmpvar_7.y);
  vec3 tmpvar_11;
  tmpvar_11 = abs(xlv_TEXCOORD4);
  vec4 tmpvar_12;
  tmpvar_12 = ((texture2DGradARB (_MainTex, tmpvar_7, tmpvar_10.xy, tmpvar_10.zw) * _Color) * mix (mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale)), texture2D (_DetailTex, ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale)), tmpvar_11.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale)), tmpvar_11.yyyy), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0))));
  vec3 p_13;
  p_13 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 p_14;
  p_14 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  color_2.w = mix (0.0, tmpvar_12.w, mix (clamp (((_FadeScale * sqrt(dot (p_13, p_13))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_14, p_14)) - (_RimDistSub * sqrt(dot (p_15, p_15))))), 0.0, 1.0)));
  color_2.xyz = (tmpvar_12.xyz * clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (xlv_TEXCOORD3, normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_Rotation]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_position0 v0
dp4 r2.z, v0, c6
dp4 r2.y, v0, c5
dp4 r2.x, v0, c4
mov r1.z, c6.w
mov r1.x, c4.w
mov r1.y, c5.w
add r0.xyz, r2, -r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o4.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.w, v0, c11
dp4 r0.w, r0, r0
rsq r1.w, r0.w
add r3.xyz, -r2, c12
dp3 r0.w, r3, r3
rsq r0.w, r0.w
mul r0.xyz, r1.w, r0
mov o5.xyz, -r0
mul o6.xyz, r0.w, r3
mov o1.xyz, r2
mov o2.xyz, r1
rcp o3.x, r0.w
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
ConstBuffer "$Globals" 272 // 272 used size, 17 vars
Matrix 208 [_Rotation] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbajbccjlcnhphhmgpnlnofkbcilhnoanabaaaaaaniafaaaaadaaaaaa
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
deaeaaaaeaaaabaaanabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaa
abaaaaaadkaabaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaaaoaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
anaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaapaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaabbaaaaahicaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaaeaaaaaaegacbaia
ebaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform highp mat4 _Rotation;
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
  xlv_TEXCOORD4 = -(normalize((_Rotation * _glesVertex))).xyz;
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
uniform highp float _RimDistSub;
uniform highp float _RimDist;
uniform highp float _FadeScale;
uniform highp float _FadeDist;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _MainOffset;
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
  if ((abs(xlv_TEXCOORD4.z) > (1e-08 * abs(xlv_TEXCOORD4.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (xlv_TEXCOORD4.x / xlv_TEXCOORD4.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((xlv_TEXCOORD4.z < 0.0)) {
      if ((xlv_TEXCOORD4.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(xlv_TEXCOORD4.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_13));
  uv_11.y = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD4.y) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD4.y))) * (1.5708 + (abs(xlv_TEXCOORD4.y) * (-0.214602 + (abs(xlv_TEXCOORD4.y) * (0.0865667 + (abs(xlv_TEXCOORD4.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = (uv_11 + _MainOffset.xy);
  uv_11 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdx(xlv_TEXCOORD4.xz);
  highp vec2 tmpvar_19;
  tmpvar_19 = dFdy(xlv_TEXCOORD4.xz);
  highp vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(tmpvar_17.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(tmpvar_17.y);
  lowp vec4 tmpvar_21;
  tmpvar_21 = (texture2DGradEXT (_MainTex, tmpvar_17, tmpvar_20.xy, tmpvar_20.zw) * _Color);
  main_10 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.zy + _DetailOffset.xy) * _DetailScale);
  tmpvar_22 = texture2D (_DetailTex, P_23);
  detailX_9 = tmpvar_22;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD4.zx + _DetailOffset.xy) * _DetailScale);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailY_8 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD4.xy + _DetailOffset.xy) * _DetailScale);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailZ_7 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = abs(xlv_TEXCOORD4);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (detailZ_7, detailX_9, tmpvar_28.xxxx);
  detail_6 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (detail_6, detailY_8, tmpvar_28.yyyy);
  detail_6 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD2), 0.0, 1.0);
  detailLevel_5 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = (main_10 * mix (detail_6, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_5)));
  highp vec3 p_33;
  p_33 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp vec3 p_34;
  p_34 = (xlv_TEXCOORD1 - _WorldSpaceCameraPos);
  highp vec3 p_35;
  p_35 = (xlv_TEXCOORD0 - xlv_TEXCOORD1);
  highp float tmpvar_36;
  tmpvar_36 = mix (0.0, tmpvar_32.w, mix (clamp (((_FadeScale * sqrt(dot (p_33, p_33))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD3), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((_RimDist * (sqrt(dot (p_34, p_34)) - (_RimDistSub * sqrt(dot (p_35, p_35))))), 0.0, 1.0)));
  color_12.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = glstate_lightmodel_ambient.xyz;
  ambientLighting_4 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_3 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (xlv_TEXCOORD3, lightDirection_3), 0.0, 1.0);
  NdotL_2 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (((_LightColor0.w * ((NdotL_2 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp ((ambientLighting_4 + ((_MinLight + _LightColor0.xyz) * tmpvar_40)), 0.0, 1.0);
  color_12.xyz = (tmpvar_32.xyz * tmpvar_41);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 419
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 423
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 427
uniform highp mat4 _Rotation;
#line 448
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
    highp vec4 vertex = (_Rotation * v.vertex);
    o.objNormal = vec3( (-normalize(vertex)));
    #line 460
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
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
uniform lowp vec4 _Color;
uniform lowp vec4 _MainOffset;
uniform lowp vec4 _DetailOffset;
uniform highp float _FalloffPow;
#line 419
uniform highp float _FalloffScale;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _MinLight;
#line 423
uniform highp float _FadeDist;
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
#line 427
uniform highp mat4 _Rotation;
#line 448
#line 463
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 465
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 469
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 472
lowp vec4 frag( in v2f IN ) {
    #line 474
    mediump vec4 color;
    highp vec3 objNrm = IN.objNormal;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( objNrm.x, objNrm.z)));
    #line 478
    uv.y = (0.31831 * acos(objNrm.y));
    uv += _MainOffset.xy;
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, objNrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 482
    mediump vec4 detailX = texture( _DetailTex, ((objNrm.zy + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailY = texture( _DetailTex, ((objNrm.zx + _DetailOffset.xy) * _DetailScale));
    mediump vec4 detailZ = texture( _DetailTex, ((objNrm.xy + _DetailOffset.xy) * _DetailScale));
    objNrm = abs(objNrm);
    #line 486
    mediump vec4 detail = mix( detailZ, detailX, vec4( objNrm.x));
    detail = mix( detail, detailY, vec4( objNrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    #line 490
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 494
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    color.w = mix( 0.0, color.w, distAlpha);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 498
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( IN.worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 502
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
//   d3d9 - ALU: 105 to 105, TEX: 6 to 6
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
Vector 5 [_MainOffset]
Vector 6 [_DetailOffset]
Float 7 [_FalloffPow]
Float 8 [_FalloffScale]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_FadeDist]
Float 13 [_FadeScale]
Float 14 [_RimDist]
Float 15 [_RimDistSub]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 105 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c16, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c17, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c18, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c19, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c20, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.zw, v4.xyxy, c6.xyxy
mul r1.xy, r0.zwzw, c9.x
add r0.xy, v4.zyzw, c6
mul r0.xy, r0, c9.x
dsx r3.zw, v4.xyxz
abs r2.xy, v4
abs r2.z, v4
max r2.w, r2.x, r2.z
rcp r3.x, r2.w
min r2.w, r2.x, r2.z
mul r2.w, r2, r3.x
mul r3.x, r2.w, r2.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.x, c18.y, c18
mad r3.y, r0.z, r3.x, c18.w
add r0.xy, v4.zxzw, c6
mul r0.xy, r0, c9.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mad r3.y, r3, r3.x, c19.x
mad r2.y, r3, r3.x, c19
mad r2.y, r2, r3.x, c19.z
add_pp r1, -r0, c16.y
mul r2.y, r2, r2.w
mul r3.x, v2, c10
mul_sat r2.w, r3.x, c17
mad_pp r0, r2.w, r1, r0
mul r3.zw, r3, r3
add r1.x, r2, -r2.z
add r1.y, -r2, c19.w
cmp r1.w, -r1.x, r2.y, r1.y
abs r1.x, v4.y
add r2.x, -r1.w, c16.z
add r1.z, -r1.x, c16.y
mad r1.y, r1.x, c17.x, c17
mad r1.y, r1, r1.x, c16.w
rsq r1.z, r1.z
cmp r1.w, v4.z, r1, r2.x
mad r1.x, r1.y, r1, c17.z
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, v4.y, c16, c16.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c17.w, r1
mad r1.y, r1.x, c16.z, r1
cmp r1.z, v4.x, r1.w, -r1.w
mad r1.x, r1.z, c20, c20.y
mul r1.y, r1, c18.x
add r3.xy, r1, c5
dp4 r1.x, c2, c2
rsq r1.x, r1.x
mul r2.xyz, r1.x, c2
dp3_sat r2.x, v3, r2
dsy r1.xz, v4
mul r1.xz, r1, r1
add r1.z, r1.x, r1
add r2.w, r3.z, r3
rsq r1.x, r2.w
rsq r1.z, r1.z
rcp r2.w, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c20.x
dsx r1.w, r3.y
dsy r1.y, r3
mul r1.x, r2.w, c20
texldd r1, r3, s0, r1.zwzw, r1
mul r1, r1, c4
mul_pp r1, r1, r0
add_pp r2.x, r2, c20.z
mul_pp r0.y, r2.x, c3.w
mul_pp_sat r0.w, r0.y, c20
mov r0.x, c11
add r0.xyz, c3, r0.x
mad_sat r2.xyz, r0, r0.w, c0
add r3.xyz, -v1, c1
dp3 r0.w, r3, r3
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r3.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r3, r3
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c15.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
rcp r3.y, r0.y
mul r3.x, r0, c8
pow_sat r0, r3.x, c7.x
mul r0.y, r3, c13.x
add_sat r0.y, r0, -c12.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c14
mad r0.x, r0, r0.z, r0.y
mul_pp oC0.xyz, r1, r2
mul_pp oC0.w, r1, r0.x
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
ConstBuffer "$Globals" 272 // 196 used size, 17 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
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
eefiecededblgbgmekbkcpnafdnnjnkfcapgkpmjabaaaaaakaanaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfaamaaaaeaaaaaaabeadaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
icbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaa
aeaaaaaaakbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaa
aaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlo
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
diphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaia
ebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
nlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadp
dcaaaaakicaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlm
abeaaaaachbgjidndcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaa
abaaaaaabkbabaiambaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjkcdoaaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaa
aaaaaaaaaiaaaaaaalaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaaf
ccaabaaaacaaaaaabkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaa
acaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
ahaaaaaaaaaaaaaipcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaa
ajaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaa
kgikcaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaia
ibaaaaaaaeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaafgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
aaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaa
agbjbaiaebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaa
jgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaal
bcaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaalaaaaaabacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaa
adaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaa
akaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaam
ecaabaaaabaaaaaackiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaia
ebaaaaaaaaaaaaaaalaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaa
abaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaa
egiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaalaaaaaadccaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
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
Vector 5 [_MainOffset]
Vector 6 [_DetailOffset]
Float 7 [_FalloffPow]
Float 8 [_FalloffScale]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_FadeDist]
Float 13 [_FadeScale]
Float 14 [_RimDist]
Float 15 [_RimDistSub]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 105 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c16, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c17, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c18, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c19, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c20, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.zw, v4.xyxy, c6.xyxy
mul r1.xy, r0.zwzw, c9.x
add r0.xy, v4.zyzw, c6
mul r0.xy, r0, c9.x
dsx r3.zw, v4.xyxz
abs r2.xy, v4
abs r2.z, v4
max r2.w, r2.x, r2.z
rcp r3.x, r2.w
min r2.w, r2.x, r2.z
mul r2.w, r2, r3.x
mul r3.x, r2.w, r2.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.x, c18.y, c18
mad r3.y, r0.z, r3.x, c18.w
add r0.xy, v4.zxzw, c6
mul r0.xy, r0, c9.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mad r3.y, r3, r3.x, c19.x
mad r2.y, r3, r3.x, c19
mad r2.y, r2, r3.x, c19.z
add_pp r1, -r0, c16.y
mul r2.y, r2, r2.w
mul r3.x, v2, c10
mul_sat r2.w, r3.x, c17
mad_pp r0, r2.w, r1, r0
mul r3.zw, r3, r3
add r1.x, r2, -r2.z
add r1.y, -r2, c19.w
cmp r1.w, -r1.x, r2.y, r1.y
abs r1.x, v4.y
add r2.x, -r1.w, c16.z
add r1.z, -r1.x, c16.y
mad r1.y, r1.x, c17.x, c17
mad r1.y, r1, r1.x, c16.w
rsq r1.z, r1.z
cmp r1.w, v4.z, r1, r2.x
mad r1.x, r1.y, r1, c17.z
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, v4.y, c16, c16.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c17.w, r1
mad r1.y, r1.x, c16.z, r1
cmp r1.z, v4.x, r1.w, -r1.w
mad r1.x, r1.z, c20, c20.y
mul r1.y, r1, c18.x
add r3.xy, r1, c5
dp4_pp r1.x, c2, c2
rsq_pp r1.x, r1.x
mul_pp r2.xyz, r1.x, c2
dp3_sat r2.x, v3, r2
dsy r1.xz, v4
mul r1.xz, r1, r1
add r1.z, r1.x, r1
add r2.w, r3.z, r3
rsq r1.x, r2.w
rsq r1.z, r1.z
rcp r2.w, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c20.x
dsx r1.w, r3.y
dsy r1.y, r3
mul r1.x, r2.w, c20
texldd r1, r3, s0, r1.zwzw, r1
mul r1, r1, c4
mul_pp r1, r1, r0
add_pp r2.x, r2, c20.z
mul_pp r0.y, r2.x, c3.w
mul_pp_sat r0.w, r0.y, c20
mov r0.x, c11
add r0.xyz, c3, r0.x
mad_sat r2.xyz, r0, r0.w, c0
add r3.xyz, -v1, c1
dp3 r0.w, r3, r3
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r3.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r3, r3
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c15.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
rcp r3.y, r0.y
mul r3.x, r0, c8
pow_sat r0, r3.x, c7.x
mul r0.y, r3, c13.x
add_sat r0.y, r0, -c12.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c14
mad r0.x, r0, r0.z, r0.y
mul_pp oC0.xyz, r1, r2
mul_pp oC0.w, r1, r0.x
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
ConstBuffer "$Globals" 208 // 132 used size, 16 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Vector 64 [_MainOffset] 4
Vector 80 [_DetailOffset] 4
Float 96 [_FalloffPow]
Float 100 [_FalloffScale]
Float 104 [_DetailScale]
Float 108 [_DetailDist]
Float 112 [_MinLight]
Float 116 [_FadeDist]
Float 120 [_FadeScale]
Float 124 [_RimDist]
Float 128 [_RimDistSub]
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
eefiecedhjmiimiebfecbdmbdgaignamcbmimecoabaaaaaaiianaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfaamaaaaeaaaaaaabeadaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaa
ckbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
ddaaaaajccaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaa
aeaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
ochgdidodcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaa
aeaaaaaaakbabaiaibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaakgbjbaaa
aeaaaaaakgbjbaiaebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaddaaaaahccaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaa
aeaaaaaadbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadeaaaaahicaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaa
bnaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaak
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdo
abeaaaaaaaaaaadpdcaaaaakicaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaadagojjlmabeaaaaachbgjidndcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaakeanmjdp
aaaaaaaibcaabaaaabaaaaaabkbabaiambaaaaaaaeaaaaaaabeaaaaaaaaaiadp
elaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjkcdoaaaaaaaidcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegiacaaaaaaaaaaaaeaaaaaaalaaaaafccaabaaaabaaaaaabkaabaaa
aaaaaaaaamaaaaafccaabaaaacaaaaaabkaabaaaaaaaaaaaalaaaaafmcaabaaa
aaaaaaaaagbibaaaaeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaa
ogakbaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaa
aaaaaaaaagbibaaaaeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaa
ogakbaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaaidpjccdoejaaaaanpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaa
abaaaaaaegaabaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaggbcbaaaaeaaaaaa
egiecaaaaaaaaaaaafaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
kgikcaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaidcaabaaaadaaaaaa
egbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaadiaaaaaidcaabaaaadaaaaaa
egaabaaaadaaaaaakgikcaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaadaaaaaa
egaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaa
acaaaaaaagbabaiaibaaaaaaaeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaa
pgbpbaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaadcaaaaajpcaabaaaabaaaaaa
agaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaa
agbjbaaaabaaaaaaagbjbaiaebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaa
jgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaa
abaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaaiaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaadkiacaaaaaaaaaaaahaaaaaabacaaaahccaabaaaabaaaaaaegbcbaaa
afaaaaaaegbcbaaaadaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
bkiacaaaaaaaaaaaagaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaagaaaaaa
bjaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaaegbcbaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaackaabaaa
abaaaaaadccaaaamecaabaaaabaaaaaackiacaaaaaaaaaaaahaaaaaackaabaaa
abaaaaaabkiacaiaebaaaaaaaaaaaaaaahaaaaaaaaaaaaaiccaabaaaabaaaaaa
ckaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaa
egacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaa
dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaa
dccaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
adaaaaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
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
Vector 5 [_MainOffset]
Vector 6 [_DetailOffset]
Float 7 [_FalloffPow]
Float 8 [_FalloffScale]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_FadeDist]
Float 13 [_FadeScale]
Float 14 [_RimDist]
Float 15 [_RimDistSub]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 105 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c16, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c17, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c18, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c19, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c20, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.zw, v4.xyxy, c6.xyxy
mul r1.xy, r0.zwzw, c9.x
add r0.xy, v4.zyzw, c6
mul r0.xy, r0, c9.x
dsx r3.zw, v4.xyxz
abs r2.xy, v4
abs r2.z, v4
max r2.w, r2.x, r2.z
rcp r3.x, r2.w
min r2.w, r2.x, r2.z
mul r2.w, r2, r3.x
mul r3.x, r2.w, r2.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.x, c18.y, c18
mad r3.y, r0.z, r3.x, c18.w
add r0.xy, v4.zxzw, c6
mul r0.xy, r0, c9.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mad r3.y, r3, r3.x, c19.x
mad r2.y, r3, r3.x, c19
mad r2.y, r2, r3.x, c19.z
add_pp r1, -r0, c16.y
mul r2.y, r2, r2.w
mul r3.x, v2, c10
mul_sat r2.w, r3.x, c17
mad_pp r0, r2.w, r1, r0
mul r3.zw, r3, r3
add r1.x, r2, -r2.z
add r1.y, -r2, c19.w
cmp r1.w, -r1.x, r2.y, r1.y
abs r1.x, v4.y
add r2.x, -r1.w, c16.z
add r1.z, -r1.x, c16.y
mad r1.y, r1.x, c17.x, c17
mad r1.y, r1, r1.x, c16.w
rsq r1.z, r1.z
cmp r1.w, v4.z, r1, r2.x
mad r1.x, r1.y, r1, c17.z
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, v4.y, c16, c16.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c17.w, r1
mad r1.y, r1.x, c16.z, r1
cmp r1.z, v4.x, r1.w, -r1.w
mad r1.x, r1.z, c20, c20.y
mul r1.y, r1, c18.x
add r3.xy, r1, c5
dp4 r1.x, c2, c2
rsq r1.x, r1.x
mul r2.xyz, r1.x, c2
dp3_sat r2.x, v3, r2
dsy r1.xz, v4
mul r1.xz, r1, r1
add r1.z, r1.x, r1
add r2.w, r3.z, r3
rsq r1.x, r2.w
rsq r1.z, r1.z
rcp r2.w, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c20.x
dsx r1.w, r3.y
dsy r1.y, r3
mul r1.x, r2.w, c20
texldd r1, r3, s0, r1.zwzw, r1
mul r1, r1, c4
mul_pp r1, r1, r0
add_pp r2.x, r2, c20.z
mul_pp r0.y, r2.x, c3.w
mul_pp_sat r0.w, r0.y, c20
mov r0.x, c11
add r0.xyz, c3, r0.x
mad_sat r2.xyz, r0, r0.w, c0
add r3.xyz, -v1, c1
dp3 r0.w, r3, r3
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r3.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r3, r3
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c15.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
rcp r3.y, r0.y
mul r3.x, r0, c8
pow_sat r0, r3.x, c7.x
mul r0.y, r3, c13.x
add_sat r0.y, r0, -c12.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c14
mad r0.x, r0, r0.z, r0.y
mul_pp oC0.xyz, r1, r2
mul_pp oC0.w, r1, r0.x
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
ConstBuffer "$Globals" 272 // 196 used size, 17 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
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
eefiecednolhkhbhjoigcbclbkenndgdbdhljkpfabaaaaaakaanaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfaamaaaaeaaaaaaabeadaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
icbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaa
aeaaaaaaakbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaa
aaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlo
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
diphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaia
ebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
nlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadp
dcaaaaakicaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlm
abeaaaaachbgjidndcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaa
abaaaaaabkbabaiambaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjkcdoaaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaa
aaaaaaaaaiaaaaaaalaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaaf
ccaabaaaacaaaaaabkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaa
acaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
ahaaaaaaaaaaaaaipcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaa
ajaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaa
kgikcaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaia
ibaaaaaaaeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaafgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
aaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaa
agbjbaiaebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaa
jgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaal
bcaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaalaaaaaabacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaa
adaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaa
akaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaam
ecaabaaaabaaaaaackiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaia
ebaaaaaaaaaaaaaaalaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaa
abaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaa
egiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaalaaaaaadccaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
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
Vector 5 [_MainOffset]
Vector 6 [_DetailOffset]
Float 7 [_FalloffPow]
Float 8 [_FalloffScale]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_FadeDist]
Float 13 [_FadeScale]
Float 14 [_RimDist]
Float 15 [_RimDistSub]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 105 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c16, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c17, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c18, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c19, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c20, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.zw, v4.xyxy, c6.xyxy
mul r1.xy, r0.zwzw, c9.x
add r0.xy, v4.zyzw, c6
mul r0.xy, r0, c9.x
dsx r3.zw, v4.xyxz
abs r2.xy, v4
abs r2.z, v4
max r2.w, r2.x, r2.z
rcp r3.x, r2.w
min r2.w, r2.x, r2.z
mul r2.w, r2, r3.x
mul r3.x, r2.w, r2.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.x, c18.y, c18
mad r3.y, r0.z, r3.x, c18.w
add r0.xy, v4.zxzw, c6
mul r0.xy, r0, c9.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mad r3.y, r3, r3.x, c19.x
mad r2.y, r3, r3.x, c19
mad r2.y, r2, r3.x, c19.z
add_pp r1, -r0, c16.y
mul r2.y, r2, r2.w
mul r3.x, v2, c10
mul_sat r2.w, r3.x, c17
mad_pp r0, r2.w, r1, r0
mul r3.zw, r3, r3
add r1.x, r2, -r2.z
add r1.y, -r2, c19.w
cmp r1.w, -r1.x, r2.y, r1.y
abs r1.x, v4.y
add r2.x, -r1.w, c16.z
add r1.z, -r1.x, c16.y
mad r1.y, r1.x, c17.x, c17
mad r1.y, r1, r1.x, c16.w
rsq r1.z, r1.z
cmp r1.w, v4.z, r1, r2.x
mad r1.x, r1.y, r1, c17.z
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, v4.y, c16, c16.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c17.w, r1
mad r1.y, r1.x, c16.z, r1
cmp r1.z, v4.x, r1.w, -r1.w
mad r1.x, r1.z, c20, c20.y
mul r1.y, r1, c18.x
add r3.xy, r1, c5
dp4 r1.x, c2, c2
rsq r1.x, r1.x
mul r2.xyz, r1.x, c2
dp3_sat r2.x, v3, r2
dsy r1.xz, v4
mul r1.xz, r1, r1
add r1.z, r1.x, r1
add r2.w, r3.z, r3
rsq r1.x, r2.w
rsq r1.z, r1.z
rcp r2.w, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c20.x
dsx r1.w, r3.y
dsy r1.y, r3
mul r1.x, r2.w, c20
texldd r1, r3, s0, r1.zwzw, r1
mul r1, r1, c4
mul_pp r1, r1, r0
add_pp r2.x, r2, c20.z
mul_pp r0.y, r2.x, c3.w
mul_pp_sat r0.w, r0.y, c20
mov r0.x, c11
add r0.xyz, c3, r0.x
mad_sat r2.xyz, r0, r0.w, c0
add r3.xyz, -v1, c1
dp3 r0.w, r3, r3
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r3.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r3, r3
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c15.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
rcp r3.y, r0.y
mul r3.x, r0, c8
pow_sat r0, r3.x, c7.x
mul r0.y, r3, c13.x
add_sat r0.y, r0, -c12.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c14
mad r0.x, r0, r0.z, r0.y
mul_pp oC0.xyz, r1, r2
mul_pp oC0.w, r1, r0.x
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
ConstBuffer "$Globals" 272 // 196 used size, 17 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
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
eefiecededblgbgmekbkcpnafdnnjnkfcapgkpmjabaaaaaakaanaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfaamaaaaeaaaaaaabeadaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
icbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaa
aeaaaaaaakbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaa
aaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlo
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
diphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaia
ebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
nlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadp
dcaaaaakicaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlm
abeaaaaachbgjidndcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaa
abaaaaaabkbabaiambaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjkcdoaaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaa
aaaaaaaaaiaaaaaaalaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaaf
ccaabaaaacaaaaaabkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaa
acaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
ahaaaaaaaaaaaaaipcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaa
ajaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaa
kgikcaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaia
ibaaaaaaaeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaafgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
aaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaa
agbjbaiaebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaa
jgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaal
bcaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaalaaaaaabacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaa
adaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaa
akaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaam
ecaabaaaabaaaaaackiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaia
ebaaaaaaaaaaaaaaalaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaa
abaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaa
egiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaalaaaaaadccaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
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
Vector 5 [_MainOffset]
Vector 6 [_DetailOffset]
Float 7 [_FalloffPow]
Float 8 [_FalloffScale]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_FadeDist]
Float 13 [_FadeScale]
Float 14 [_RimDist]
Float 15 [_RimDistSub]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 105 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c16, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c17, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c18, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c19, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c20, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.zw, v4.xyxy, c6.xyxy
mul r1.xy, r0.zwzw, c9.x
add r0.xy, v4.zyzw, c6
mul r0.xy, r0, c9.x
dsx r3.zw, v4.xyxz
abs r2.xy, v4
abs r2.z, v4
max r2.w, r2.x, r2.z
rcp r3.x, r2.w
min r2.w, r2.x, r2.z
mul r2.w, r2, r3.x
mul r3.x, r2.w, r2.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.x, c18.y, c18
mad r3.y, r0.z, r3.x, c18.w
add r0.xy, v4.zxzw, c6
mul r0.xy, r0, c9.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mad r3.y, r3, r3.x, c19.x
mad r2.y, r3, r3.x, c19
mad r2.y, r2, r3.x, c19.z
add_pp r1, -r0, c16.y
mul r2.y, r2, r2.w
mul r3.x, v2, c10
mul_sat r2.w, r3.x, c17
mad_pp r0, r2.w, r1, r0
mul r3.zw, r3, r3
add r1.x, r2, -r2.z
add r1.y, -r2, c19.w
cmp r1.w, -r1.x, r2.y, r1.y
abs r1.x, v4.y
add r2.x, -r1.w, c16.z
add r1.z, -r1.x, c16.y
mad r1.y, r1.x, c17.x, c17
mad r1.y, r1, r1.x, c16.w
rsq r1.z, r1.z
cmp r1.w, v4.z, r1, r2.x
mad r1.x, r1.y, r1, c17.z
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, v4.y, c16, c16.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c17.w, r1
mad r1.y, r1.x, c16.z, r1
cmp r1.z, v4.x, r1.w, -r1.w
mad r1.x, r1.z, c20, c20.y
mul r1.y, r1, c18.x
add r3.xy, r1, c5
dp4_pp r1.x, c2, c2
rsq_pp r1.x, r1.x
mul_pp r2.xyz, r1.x, c2
dp3_sat r2.x, v3, r2
dsy r1.xz, v4
mul r1.xz, r1, r1
add r1.z, r1.x, r1
add r2.w, r3.z, r3
rsq r1.x, r2.w
rsq r1.z, r1.z
rcp r2.w, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c20.x
dsx r1.w, r3.y
dsy r1.y, r3
mul r1.x, r2.w, c20
texldd r1, r3, s0, r1.zwzw, r1
mul r1, r1, c4
mul_pp r1, r1, r0
add_pp r2.x, r2, c20.z
mul_pp r0.y, r2.x, c3.w
mul_pp_sat r0.w, r0.y, c20
mov r0.x, c11
add r0.xyz, c3, r0.x
mad_sat r2.xyz, r0, r0.w, c0
add r3.xyz, -v1, c1
dp3 r0.w, r3, r3
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r3.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r3, r3
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c15.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
rcp r3.y, r0.y
mul r3.x, r0, c8
pow_sat r0, r3.x, c7.x
mul r0.y, r3, c13.x
add_sat r0.y, r0, -c12.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c14
mad r0.x, r0, r0.z, r0.y
mul_pp oC0.xyz, r1, r2
mul_pp oC0.w, r1, r0.x
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
ConstBuffer "$Globals" 272 // 196 used size, 17 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
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
eefiecedhfllbhhokniebdomifmhdjkefphgmahcabaaaaaakaanaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaadaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfaamaaaaeaaaaaaabeadaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
icbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaa
aeaaaaaaakbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaa
aaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlo
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
diphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaia
ebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
nlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadp
dcaaaaakicaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlm
abeaaaaachbgjidndcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaa
abaaaaaabkbabaiambaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjkcdoaaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaa
aaaaaaaaaiaaaaaaalaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaaf
ccaabaaaacaaaaaabkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaa
acaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
ahaaaaaaaaaaaaaipcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaa
ajaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaa
kgikcaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaia
ibaaaaaaaeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaafgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
aaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaa
agbjbaiaebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaa
jgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaal
bcaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaalaaaaaabacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaa
adaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaa
akaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaam
ecaabaaaabaaaaaackiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaia
ebaaaaaaaaaaaaaaalaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaa
abaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaa
egiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaalaaaaaadccaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
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
Vector 5 [_MainOffset]
Vector 6 [_DetailOffset]
Float 7 [_FalloffPow]
Float 8 [_FalloffScale]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_FadeDist]
Float 13 [_FadeScale]
Float 14 [_RimDist]
Float 15 [_RimDistSub]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 105 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c16, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c17, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c18, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c19, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c20, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.zw, v4.xyxy, c6.xyxy
mul r1.xy, r0.zwzw, c9.x
add r0.xy, v4.zyzw, c6
mul r0.xy, r0, c9.x
dsx r3.zw, v4.xyxz
abs r2.xy, v4
abs r2.z, v4
max r2.w, r2.x, r2.z
rcp r3.x, r2.w
min r2.w, r2.x, r2.z
mul r2.w, r2, r3.x
mul r3.x, r2.w, r2.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.x, c18.y, c18
mad r3.y, r0.z, r3.x, c18.w
add r0.xy, v4.zxzw, c6
mul r0.xy, r0, c9.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mad r3.y, r3, r3.x, c19.x
mad r2.y, r3, r3.x, c19
mad r2.y, r2, r3.x, c19.z
add_pp r1, -r0, c16.y
mul r2.y, r2, r2.w
mul r3.x, v2, c10
mul_sat r2.w, r3.x, c17
mad_pp r0, r2.w, r1, r0
mul r3.zw, r3, r3
add r1.x, r2, -r2.z
add r1.y, -r2, c19.w
cmp r1.w, -r1.x, r2.y, r1.y
abs r1.x, v4.y
add r2.x, -r1.w, c16.z
add r1.z, -r1.x, c16.y
mad r1.y, r1.x, c17.x, c17
mad r1.y, r1, r1.x, c16.w
rsq r1.z, r1.z
cmp r1.w, v4.z, r1, r2.x
mad r1.x, r1.y, r1, c17.z
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, v4.y, c16, c16.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c17.w, r1
mad r1.y, r1.x, c16.z, r1
cmp r1.z, v4.x, r1.w, -r1.w
mad r1.x, r1.z, c20, c20.y
mul r1.y, r1, c18.x
add r3.xy, r1, c5
dp4 r1.x, c2, c2
rsq r1.x, r1.x
mul r2.xyz, r1.x, c2
dp3_sat r2.x, v3, r2
dsy r1.xz, v4
mul r1.xz, r1, r1
add r1.z, r1.x, r1
add r2.w, r3.z, r3
rsq r1.x, r2.w
rsq r1.z, r1.z
rcp r2.w, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c20.x
dsx r1.w, r3.y
dsy r1.y, r3
mul r1.x, r2.w, c20
texldd r1, r3, s0, r1.zwzw, r1
mul r1, r1, c4
mul_pp r1, r1, r0
add_pp r2.x, r2, c20.z
mul_pp r0.y, r2.x, c3.w
mul_pp_sat r0.w, r0.y, c20
mov r0.x, c11
add r0.xyz, c3, r0.x
mad_sat r2.xyz, r0, r0.w, c0
add r3.xyz, -v1, c1
dp3 r0.w, r3, r3
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r3.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r3, r3
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c15.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
rcp r3.y, r0.y
mul r3.x, r0, c8
pow_sat r0, r3.x, c7.x
mul r0.y, r3, c13.x
add_sat r0.y, r0, -c12.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c14
mad r0.x, r0, r0.z, r0.y
mul_pp oC0.xyz, r1, r2
mul_pp oC0.w, r1, r0.x
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
ConstBuffer "$Globals" 272 // 196 used size, 17 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
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
eefiecedhjgblbdndefhfhlkhknaaologajhhkliabaaaaaalianaaaaadaaaaaa
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
fdeieefcfaamaaaaeaaaaaaabeadaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaajaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaakaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
ajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
akaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
alaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaa
afaaaaaaagiacaaaaaaaaaaaalaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
Vector 5 [_MainOffset]
Vector 6 [_DetailOffset]
Float 7 [_FalloffPow]
Float 8 [_FalloffScale]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_FadeDist]
Float 13 [_FadeScale]
Float 14 [_RimDist]
Float 15 [_RimDistSub]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 105 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c16, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c17, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c18, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c19, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c20, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.zw, v4.xyxy, c6.xyxy
mul r1.xy, r0.zwzw, c9.x
add r0.xy, v4.zyzw, c6
mul r0.xy, r0, c9.x
dsx r3.zw, v4.xyxz
abs r2.xy, v4
abs r2.z, v4
max r2.w, r2.x, r2.z
rcp r3.x, r2.w
min r2.w, r2.x, r2.z
mul r2.w, r2, r3.x
mul r3.x, r2.w, r2.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.x, c18.y, c18
mad r3.y, r0.z, r3.x, c18.w
add r0.xy, v4.zxzw, c6
mul r0.xy, r0, c9.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mad r3.y, r3, r3.x, c19.x
mad r2.y, r3, r3.x, c19
mad r2.y, r2, r3.x, c19.z
add_pp r1, -r0, c16.y
mul r2.y, r2, r2.w
mul r3.x, v2, c10
mul_sat r2.w, r3.x, c17
mad_pp r0, r2.w, r1, r0
mul r3.zw, r3, r3
add r1.x, r2, -r2.z
add r1.y, -r2, c19.w
cmp r1.w, -r1.x, r2.y, r1.y
abs r1.x, v4.y
add r2.x, -r1.w, c16.z
add r1.z, -r1.x, c16.y
mad r1.y, r1.x, c17.x, c17
mad r1.y, r1, r1.x, c16.w
rsq r1.z, r1.z
cmp r1.w, v4.z, r1, r2.x
mad r1.x, r1.y, r1, c17.z
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, v4.y, c16, c16.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c17.w, r1
mad r1.y, r1.x, c16.z, r1
cmp r1.z, v4.x, r1.w, -r1.w
mad r1.x, r1.z, c20, c20.y
mul r1.y, r1, c18.x
add r3.xy, r1, c5
dp4 r1.x, c2, c2
rsq r1.x, r1.x
mul r2.xyz, r1.x, c2
dp3_sat r2.x, v3, r2
dsy r1.xz, v4
mul r1.xz, r1, r1
add r1.z, r1.x, r1
add r2.w, r3.z, r3
rsq r1.x, r2.w
rsq r1.z, r1.z
rcp r2.w, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c20.x
dsx r1.w, r3.y
dsy r1.y, r3
mul r1.x, r2.w, c20
texldd r1, r3, s0, r1.zwzw, r1
mul r1, r1, c4
mul_pp r1, r1, r0
add_pp r2.x, r2, c20.z
mul_pp r0.y, r2.x, c3.w
mul_pp_sat r0.w, r0.y, c20
mov r0.x, c11
add r0.xyz, c3, r0.x
mad_sat r2.xyz, r0, r0.w, c0
add r3.xyz, -v1, c1
dp3 r0.w, r3, r3
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r3.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r3, r3
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c15.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
rcp r3.y, r0.y
mul r3.x, r0, c8
pow_sat r0, r3.x, c7.x
mul r0.y, r3, c13.x
add_sat r0.y, r0, -c12.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c14
mad r0.x, r0, r0.z, r0.y
mul_pp oC0.xyz, r1, r2
mul_pp oC0.w, r1, r0.x
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
ConstBuffer "$Globals" 272 // 196 used size, 17 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
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
eefiecedhjgblbdndefhfhlkhknaaologajhhkliabaaaaaalianaaaaadaaaaaa
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
fdeieefcfaamaaaaeaaaaaaabeadaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaajaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaakaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
ajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
akaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
alaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaa
afaaaaaaagiacaaaaaaaaaaaalaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
Vector 5 [_MainOffset]
Vector 6 [_DetailOffset]
Float 7 [_FalloffPow]
Float 8 [_FalloffScale]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_FadeDist]
Float 13 [_FadeScale]
Float 14 [_RimDist]
Float 15 [_RimDistSub]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 105 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c16, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c17, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c18, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c19, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c20, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.zw, v4.xyxy, c6.xyxy
mul r1.xy, r0.zwzw, c9.x
add r0.xy, v4.zyzw, c6
mul r0.xy, r0, c9.x
dsx r3.zw, v4.xyxz
abs r2.xy, v4
abs r2.z, v4
max r2.w, r2.x, r2.z
rcp r3.x, r2.w
min r2.w, r2.x, r2.z
mul r2.w, r2, r3.x
mul r3.x, r2.w, r2.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.x, c18.y, c18
mad r3.y, r0.z, r3.x, c18.w
add r0.xy, v4.zxzw, c6
mul r0.xy, r0, c9.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mad r3.y, r3, r3.x, c19.x
mad r2.y, r3, r3.x, c19
mad r2.y, r2, r3.x, c19.z
add_pp r1, -r0, c16.y
mul r2.y, r2, r2.w
mul r3.x, v2, c10
mul_sat r2.w, r3.x, c17
mad_pp r0, r2.w, r1, r0
mul r3.zw, r3, r3
add r1.x, r2, -r2.z
add r1.y, -r2, c19.w
cmp r1.w, -r1.x, r2.y, r1.y
abs r1.x, v4.y
add r2.x, -r1.w, c16.z
add r1.z, -r1.x, c16.y
mad r1.y, r1.x, c17.x, c17
mad r1.y, r1, r1.x, c16.w
rsq r1.z, r1.z
cmp r1.w, v4.z, r1, r2.x
mad r1.x, r1.y, r1, c17.z
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, v4.y, c16, c16.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c17.w, r1
mad r1.y, r1.x, c16.z, r1
cmp r1.z, v4.x, r1.w, -r1.w
mad r1.x, r1.z, c20, c20.y
mul r1.y, r1, c18.x
add r3.xy, r1, c5
dp4_pp r1.x, c2, c2
rsq_pp r1.x, r1.x
mul_pp r2.xyz, r1.x, c2
dp3_sat r2.x, v3, r2
dsy r1.xz, v4
mul r1.xz, r1, r1
add r1.z, r1.x, r1
add r2.w, r3.z, r3
rsq r1.x, r2.w
rsq r1.z, r1.z
rcp r2.w, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c20.x
dsx r1.w, r3.y
dsy r1.y, r3
mul r1.x, r2.w, c20
texldd r1, r3, s0, r1.zwzw, r1
mul r1, r1, c4
mul_pp r1, r1, r0
add_pp r2.x, r2, c20.z
mul_pp r0.y, r2.x, c3.w
mul_pp_sat r0.w, r0.y, c20
mov r0.x, c11
add r0.xyz, c3, r0.x
mad_sat r2.xyz, r0, r0.w, c0
add r3.xyz, -v1, c1
dp3 r0.w, r3, r3
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r3.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r3, r3
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c15.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
rcp r3.y, r0.y
mul r3.x, r0, c8
pow_sat r0, r3.x, c7.x
mul r0.y, r3, c13.x
add_sat r0.y, r0, -c12.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c14
mad r0.x, r0, r0.z, r0.y
mul_pp oC0.xyz, r1, r2
mul_pp oC0.w, r1, r0.x
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 272 // 196 used size, 17 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
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
eefiecednolhkhbhjoigcbclbkenndgdbdhljkpfabaaaaaakaanaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfaamaaaaeaaaaaaabeadaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
icbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaa
aeaaaaaaakbabaiaibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaa
aaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlo
dcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
diphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaajicaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaia
ebaaaaaaaeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
nlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadp
dcaaaaakicaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlm
abeaaaaachbgjidndcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaa
abaaaaaabkbabaiambaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjkcdoaaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaa
aaaaaaaaaiaaaaaaalaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaaf
ccaabaaaacaaaaaabkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaa
aeaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaa
acaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
ahaaaaaaaaaaaaaipcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaa
ajaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaa
kgikcaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaia
ibaaaaaaaeaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaafgbfbaiaibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
aaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaa
agbjbaiaebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaa
jgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaal
bcaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaalaaaaaabacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaa
adaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaa
akaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaam
ecaabaaaabaaaaaackiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaia
ebaaaaaaaaaaaaaaalaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaa
abaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaa
egiccaaaaaaaaaaaafaaaaaaagiacaaaaaaaaaaaalaaaaaadccaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
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
Vector 5 [_MainOffset]
Vector 6 [_DetailOffset]
Float 7 [_FalloffPow]
Float 8 [_FalloffScale]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_FadeDist]
Float 13 [_FadeScale]
Float 14 [_RimDist]
Float 15 [_RimDistSub]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 105 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c16, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c17, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c18, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c19, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c20, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.zw, v4.xyxy, c6.xyxy
mul r1.xy, r0.zwzw, c9.x
add r0.xy, v4.zyzw, c6
mul r0.xy, r0, c9.x
dsx r3.zw, v4.xyxz
abs r2.xy, v4
abs r2.z, v4
max r2.w, r2.x, r2.z
rcp r3.x, r2.w
min r2.w, r2.x, r2.z
mul r2.w, r2, r3.x
mul r3.x, r2.w, r2.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.x, c18.y, c18
mad r3.y, r0.z, r3.x, c18.w
add r0.xy, v4.zxzw, c6
mul r0.xy, r0, c9.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mad r3.y, r3, r3.x, c19.x
mad r2.y, r3, r3.x, c19
mad r2.y, r2, r3.x, c19.z
add_pp r1, -r0, c16.y
mul r2.y, r2, r2.w
mul r3.x, v2, c10
mul_sat r2.w, r3.x, c17
mad_pp r0, r2.w, r1, r0
mul r3.zw, r3, r3
add r1.x, r2, -r2.z
add r1.y, -r2, c19.w
cmp r1.w, -r1.x, r2.y, r1.y
abs r1.x, v4.y
add r2.x, -r1.w, c16.z
add r1.z, -r1.x, c16.y
mad r1.y, r1.x, c17.x, c17
mad r1.y, r1, r1.x, c16.w
rsq r1.z, r1.z
cmp r1.w, v4.z, r1, r2.x
mad r1.x, r1.y, r1, c17.z
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, v4.y, c16, c16.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c17.w, r1
mad r1.y, r1.x, c16.z, r1
cmp r1.z, v4.x, r1.w, -r1.w
mad r1.x, r1.z, c20, c20.y
mul r1.y, r1, c18.x
add r3.xy, r1, c5
dp4_pp r1.x, c2, c2
rsq_pp r1.x, r1.x
mul_pp r2.xyz, r1.x, c2
dp3_sat r2.x, v3, r2
dsy r1.xz, v4
mul r1.xz, r1, r1
add r1.z, r1.x, r1
add r2.w, r3.z, r3
rsq r1.x, r2.w
rsq r1.z, r1.z
rcp r2.w, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c20.x
dsx r1.w, r3.y
dsy r1.y, r3
mul r1.x, r2.w, c20
texldd r1, r3, s0, r1.zwzw, r1
mul r1, r1, c4
mul_pp r1, r1, r0
add_pp r2.x, r2, c20.z
mul_pp r0.y, r2.x, c3.w
mul_pp_sat r0.w, r0.y, c20
mov r0.x, c11
add r0.xyz, c3, r0.x
mad_sat r2.xyz, r0, r0.w, c0
add r3.xyz, -v1, c1
dp3 r0.w, r3, r3
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r3.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r3, r3
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c15.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
rcp r3.y, r0.y
mul r3.x, r0, c8
pow_sat r0, r3.x, c7.x
mul r0.y, r3, c13.x
add_sat r0.y, r0, -c12.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c14
mad r0.x, r0, r0.z, r0.y
mul_pp oC0.xyz, r1, r2
mul_pp oC0.w, r1, r0.x
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 336 // 260 used size, 18 vars
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Vector 192 [_MainOffset] 4
Vector 208 [_DetailOffset] 4
Float 224 [_FalloffPow]
Float 228 [_FalloffScale]
Float 232 [_DetailScale]
Float 236 [_DetailDist]
Float 240 [_MinLight]
Float 244 [_FadeDist]
Float 248 [_FadeScale]
Float 252 [_RimDist]
Float 256 [_RimDistSub]
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
eefiecedgjmoaomjgefcoeomomcijinagocjinjiabaaaaaalianaaaaadaaaaaa
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
fdeieefcfaamaaaaeaaaaaaabeadaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaamaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaanaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaaoaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
anaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
aoaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
aoaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaabaaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaapaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaaoaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaaoaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaapaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
apaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaajaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaa
ajaaaaaaagiacaaaaaaaaaaaapaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
Vector 5 [_MainOffset]
Vector 6 [_DetailOffset]
Float 7 [_FalloffPow]
Float 8 [_FalloffScale]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_FadeDist]
Float 13 [_FadeScale]
Float 14 [_RimDist]
Float 15 [_RimDistSub]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 105 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c16, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c17, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c18, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c19, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c20, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.zw, v4.xyxy, c6.xyxy
mul r1.xy, r0.zwzw, c9.x
add r0.xy, v4.zyzw, c6
mul r0.xy, r0, c9.x
dsx r3.zw, v4.xyxz
abs r2.xy, v4
abs r2.z, v4
max r2.w, r2.x, r2.z
rcp r3.x, r2.w
min r2.w, r2.x, r2.z
mul r2.w, r2, r3.x
mul r3.x, r2.w, r2.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.x, c18.y, c18
mad r3.y, r0.z, r3.x, c18.w
add r0.xy, v4.zxzw, c6
mul r0.xy, r0, c9.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mad r3.y, r3, r3.x, c19.x
mad r2.y, r3, r3.x, c19
mad r2.y, r2, r3.x, c19.z
add_pp r1, -r0, c16.y
mul r2.y, r2, r2.w
mul r3.x, v2, c10
mul_sat r2.w, r3.x, c17
mad_pp r0, r2.w, r1, r0
mul r3.zw, r3, r3
add r1.x, r2, -r2.z
add r1.y, -r2, c19.w
cmp r1.w, -r1.x, r2.y, r1.y
abs r1.x, v4.y
add r2.x, -r1.w, c16.z
add r1.z, -r1.x, c16.y
mad r1.y, r1.x, c17.x, c17
mad r1.y, r1, r1.x, c16.w
rsq r1.z, r1.z
cmp r1.w, v4.z, r1, r2.x
mad r1.x, r1.y, r1, c17.z
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, v4.y, c16, c16.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c17.w, r1
mad r1.y, r1.x, c16.z, r1
cmp r1.z, v4.x, r1.w, -r1.w
mad r1.x, r1.z, c20, c20.y
mul r1.y, r1, c18.x
add r3.xy, r1, c5
dp4 r1.x, c2, c2
rsq r1.x, r1.x
mul r2.xyz, r1.x, c2
dp3_sat r2.x, v3, r2
dsy r1.xz, v4
mul r1.xz, r1, r1
add r1.z, r1.x, r1
add r2.w, r3.z, r3
rsq r1.x, r2.w
rsq r1.z, r1.z
rcp r2.w, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c20.x
dsx r1.w, r3.y
dsy r1.y, r3
mul r1.x, r2.w, c20
texldd r1, r3, s0, r1.zwzw, r1
mul r1, r1, c4
mul_pp r1, r1, r0
add_pp r2.x, r2, c20.z
mul_pp r0.y, r2.x, c3.w
mul_pp_sat r0.w, r0.y, c20
mov r0.x, c11
add r0.xyz, c3, r0.x
mad_sat r2.xyz, r0, r0.w, c0
add r3.xyz, -v1, c1
dp3 r0.w, r3, r3
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r3.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r3, r3
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c15.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
rcp r3.y, r0.y
mul r3.x, r0, c8
pow_sat r0, r3.x, c7.x
mul r0.y, r3, c13.x
add_sat r0.y, r0, -c12.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c14
mad r0.x, r0, r0.z, r0.y
mul_pp oC0.xyz, r1, r2
mul_pp oC0.w, r1, r0.x
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
ConstBuffer "$Globals" 272 // 196 used size, 17 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
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
eefiecedkagojadcjfompfigechfifpfbmpeggdbabaaaaaalianaaaaadaaaaaa
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
fdeieefcfaamaaaaeaaaaaaabeadaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaajaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaakaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
ajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
akaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
alaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaa
afaaaaaaagiacaaaaaaaaaaaalaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
Vector 5 [_MainOffset]
Vector 6 [_DetailOffset]
Float 7 [_FalloffPow]
Float 8 [_FalloffScale]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_FadeDist]
Float 13 [_FadeScale]
Float 14 [_RimDist]
Float 15 [_RimDistSub]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 105 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c16, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c17, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c18, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c19, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c20, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.zw, v4.xyxy, c6.xyxy
mul r1.xy, r0.zwzw, c9.x
add r0.xy, v4.zyzw, c6
mul r0.xy, r0, c9.x
dsx r3.zw, v4.xyxz
abs r2.xy, v4
abs r2.z, v4
max r2.w, r2.x, r2.z
rcp r3.x, r2.w
min r2.w, r2.x, r2.z
mul r2.w, r2, r3.x
mul r3.x, r2.w, r2.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.x, c18.y, c18
mad r3.y, r0.z, r3.x, c18.w
add r0.xy, v4.zxzw, c6
mul r0.xy, r0, c9.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mad r3.y, r3, r3.x, c19.x
mad r2.y, r3, r3.x, c19
mad r2.y, r2, r3.x, c19.z
add_pp r1, -r0, c16.y
mul r2.y, r2, r2.w
mul r3.x, v2, c10
mul_sat r2.w, r3.x, c17
mad_pp r0, r2.w, r1, r0
mul r3.zw, r3, r3
add r1.x, r2, -r2.z
add r1.y, -r2, c19.w
cmp r1.w, -r1.x, r2.y, r1.y
abs r1.x, v4.y
add r2.x, -r1.w, c16.z
add r1.z, -r1.x, c16.y
mad r1.y, r1.x, c17.x, c17
mad r1.y, r1, r1.x, c16.w
rsq r1.z, r1.z
cmp r1.w, v4.z, r1, r2.x
mad r1.x, r1.y, r1, c17.z
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, v4.y, c16, c16.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c17.w, r1
mad r1.y, r1.x, c16.z, r1
cmp r1.z, v4.x, r1.w, -r1.w
mad r1.x, r1.z, c20, c20.y
mul r1.y, r1, c18.x
add r3.xy, r1, c5
dp4 r1.x, c2, c2
rsq r1.x, r1.x
mul r2.xyz, r1.x, c2
dp3_sat r2.x, v3, r2
dsy r1.xz, v4
mul r1.xz, r1, r1
add r1.z, r1.x, r1
add r2.w, r3.z, r3
rsq r1.x, r2.w
rsq r1.z, r1.z
rcp r2.w, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c20.x
dsx r1.w, r3.y
dsy r1.y, r3
mul r1.x, r2.w, c20
texldd r1, r3, s0, r1.zwzw, r1
mul r1, r1, c4
mul_pp r1, r1, r0
add_pp r2.x, r2, c20.z
mul_pp r0.y, r2.x, c3.w
mul_pp_sat r0.w, r0.y, c20
mov r0.x, c11
add r0.xyz, c3, r0.x
mad_sat r2.xyz, r0, r0.w, c0
add r3.xyz, -v1, c1
dp3 r0.w, r3, r3
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r3.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r3, r3
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c15.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
rcp r3.y, r0.y
mul r3.x, r0, c8
pow_sat r0, r3.x, c7.x
mul r0.y, r3, c13.x
add_sat r0.y, r0, -c12.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c14
mad r0.x, r0, r0.z, r0.y
mul_pp oC0.xyz, r1, r2
mul_pp oC0.w, r1, r0.x
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
ConstBuffer "$Globals" 272 // 196 used size, 17 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
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
eefiecedkagojadcjfompfigechfifpfbmpeggdbabaaaaaalianaaaaadaaaaaa
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
fdeieefcfaamaaaaeaaaaaaabeadaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaajaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaakaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
ajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
akaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
alaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaa
afaaaaaaagiacaaaaaaaaaaaalaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
Vector 5 [_MainOffset]
Vector 6 [_DetailOffset]
Float 7 [_FalloffPow]
Float 8 [_FalloffScale]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_FadeDist]
Float 13 [_FadeScale]
Float 14 [_RimDist]
Float 15 [_RimDistSub]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 105 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c16, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c17, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c18, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c19, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c20, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.zw, v4.xyxy, c6.xyxy
mul r1.xy, r0.zwzw, c9.x
add r0.xy, v4.zyzw, c6
mul r0.xy, r0, c9.x
dsx r3.zw, v4.xyxz
abs r2.xy, v4
abs r2.z, v4
max r2.w, r2.x, r2.z
rcp r3.x, r2.w
min r2.w, r2.x, r2.z
mul r2.w, r2, r3.x
mul r3.x, r2.w, r2.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.x, c18.y, c18
mad r3.y, r0.z, r3.x, c18.w
add r0.xy, v4.zxzw, c6
mul r0.xy, r0, c9.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mad r3.y, r3, r3.x, c19.x
mad r2.y, r3, r3.x, c19
mad r2.y, r2, r3.x, c19.z
add_pp r1, -r0, c16.y
mul r2.y, r2, r2.w
mul r3.x, v2, c10
mul_sat r2.w, r3.x, c17
mad_pp r0, r2.w, r1, r0
mul r3.zw, r3, r3
add r1.x, r2, -r2.z
add r1.y, -r2, c19.w
cmp r1.w, -r1.x, r2.y, r1.y
abs r1.x, v4.y
add r2.x, -r1.w, c16.z
add r1.z, -r1.x, c16.y
mad r1.y, r1.x, c17.x, c17
mad r1.y, r1, r1.x, c16.w
rsq r1.z, r1.z
cmp r1.w, v4.z, r1, r2.x
mad r1.x, r1.y, r1, c17.z
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, v4.y, c16, c16.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c17.w, r1
mad r1.y, r1.x, c16.z, r1
cmp r1.z, v4.x, r1.w, -r1.w
mad r1.x, r1.z, c20, c20.y
mul r1.y, r1, c18.x
add r3.xy, r1, c5
dp4 r1.x, c2, c2
rsq r1.x, r1.x
mul r2.xyz, r1.x, c2
dp3_sat r2.x, v3, r2
dsy r1.xz, v4
mul r1.xz, r1, r1
add r1.z, r1.x, r1
add r2.w, r3.z, r3
rsq r1.x, r2.w
rsq r1.z, r1.z
rcp r2.w, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c20.x
dsx r1.w, r3.y
dsy r1.y, r3
mul r1.x, r2.w, c20
texldd r1, r3, s0, r1.zwzw, r1
mul r1, r1, c4
mul_pp r1, r1, r0
add_pp r2.x, r2, c20.z
mul_pp r0.y, r2.x, c3.w
mul_pp_sat r0.w, r0.y, c20
mov r0.x, c11
add r0.xyz, c3, r0.x
mad_sat r2.xyz, r0, r0.w, c0
add r3.xyz, -v1, c1
dp3 r0.w, r3, r3
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r3.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r3, r3
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c15.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
rcp r3.y, r0.y
mul r3.x, r0, c8
pow_sat r0, r3.x, c7.x
mul r0.y, r3, c13.x
add_sat r0.y, r0, -c12.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c14
mad r0.x, r0, r0.z, r0.y
mul_pp oC0.xyz, r1, r2
mul_pp oC0.w, r1, r0.x
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 336 // 260 used size, 18 vars
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Vector 192 [_MainOffset] 4
Vector 208 [_DetailOffset] 4
Float 224 [_FalloffPow]
Float 228 [_FalloffScale]
Float 232 [_DetailScale]
Float 236 [_DetailDist]
Float 240 [_MinLight]
Float 244 [_FadeDist]
Float 248 [_FadeScale]
Float 252 [_RimDist]
Float 256 [_RimDistSub]
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
eefiecedhdnmembbclajindkgijongaieigaoiakabaaaaaalianaaaaadaaaaaa
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
fdeieefcfaamaaaaeaaaaaaabeadaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaamaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaanaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaaoaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
anaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
aoaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
aoaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaabaaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaapaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaaoaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaaoaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaapaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
apaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaajaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaa
ajaaaaaaagiacaaaaaaaaaaaapaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
Vector 5 [_MainOffset]
Vector 6 [_DetailOffset]
Float 7 [_FalloffPow]
Float 8 [_FalloffScale]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_FadeDist]
Float 13 [_FadeScale]
Float 14 [_RimDist]
Float 15 [_RimDistSub]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 105 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c16, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c17, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c18, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c19, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c20, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.zw, v4.xyxy, c6.xyxy
mul r1.xy, r0.zwzw, c9.x
add r0.xy, v4.zyzw, c6
mul r0.xy, r0, c9.x
dsx r3.zw, v4.xyxz
abs r2.xy, v4
abs r2.z, v4
max r2.w, r2.x, r2.z
rcp r3.x, r2.w
min r2.w, r2.x, r2.z
mul r2.w, r2, r3.x
mul r3.x, r2.w, r2.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.x, c18.y, c18
mad r3.y, r0.z, r3.x, c18.w
add r0.xy, v4.zxzw, c6
mul r0.xy, r0, c9.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mad r3.y, r3, r3.x, c19.x
mad r2.y, r3, r3.x, c19
mad r2.y, r2, r3.x, c19.z
add_pp r1, -r0, c16.y
mul r2.y, r2, r2.w
mul r3.x, v2, c10
mul_sat r2.w, r3.x, c17
mad_pp r0, r2.w, r1, r0
mul r3.zw, r3, r3
add r1.x, r2, -r2.z
add r1.y, -r2, c19.w
cmp r1.w, -r1.x, r2.y, r1.y
abs r1.x, v4.y
add r2.x, -r1.w, c16.z
add r1.z, -r1.x, c16.y
mad r1.y, r1.x, c17.x, c17
mad r1.y, r1, r1.x, c16.w
rsq r1.z, r1.z
cmp r1.w, v4.z, r1, r2.x
mad r1.x, r1.y, r1, c17.z
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, v4.y, c16, c16.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c17.w, r1
mad r1.y, r1.x, c16.z, r1
cmp r1.z, v4.x, r1.w, -r1.w
mad r1.x, r1.z, c20, c20.y
mul r1.y, r1, c18.x
add r3.xy, r1, c5
dp4 r1.x, c2, c2
rsq r1.x, r1.x
mul r2.xyz, r1.x, c2
dp3_sat r2.x, v3, r2
dsy r1.xz, v4
mul r1.xz, r1, r1
add r1.z, r1.x, r1
add r2.w, r3.z, r3
rsq r1.x, r2.w
rsq r1.z, r1.z
rcp r2.w, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c20.x
dsx r1.w, r3.y
dsy r1.y, r3
mul r1.x, r2.w, c20
texldd r1, r3, s0, r1.zwzw, r1
mul r1, r1, c4
mul_pp r1, r1, r0
add_pp r2.x, r2, c20.z
mul_pp r0.y, r2.x, c3.w
mul_pp_sat r0.w, r0.y, c20
mov r0.x, c11
add r0.xyz, c3, r0.x
mad_sat r2.xyz, r0, r0.w, c0
add r3.xyz, -v1, c1
dp3 r0.w, r3, r3
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r3.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r3, r3
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c15.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
rcp r3.y, r0.y
mul r3.x, r0, c8
pow_sat r0, r3.x, c7.x
mul r0.y, r3, c13.x
add_sat r0.y, r0, -c12.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c14
mad r0.x, r0, r0.z, r0.y
mul_pp oC0.xyz, r1, r2
mul_pp oC0.w, r1, r0.x
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
ConstBuffer "$Globals" 336 // 260 used size, 18 vars
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Vector 192 [_MainOffset] 4
Vector 208 [_DetailOffset] 4
Float 224 [_FalloffPow]
Float 228 [_FalloffScale]
Float 232 [_DetailScale]
Float 236 [_DetailDist]
Float 240 [_MinLight]
Float 244 [_FadeDist]
Float 248 [_FadeScale]
Float 252 [_RimDist]
Float 256 [_RimDistSub]
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
eefiecedhdnmembbclajindkgijongaieigaoiakabaaaaaalianaaaaadaaaaaa
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
fdeieefcfaamaaaaeaaaaaaabeadaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaamaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaanaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaaoaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
anaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
aoaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
aoaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaabaaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaapaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaaoaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaaoaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaapaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
apaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaajaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaa
ajaaaaaaagiacaaaaaaaaaaaapaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
Vector 5 [_MainOffset]
Vector 6 [_DetailOffset]
Float 7 [_FalloffPow]
Float 8 [_FalloffScale]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_FadeDist]
Float 13 [_FadeScale]
Float 14 [_RimDist]
Float 15 [_RimDistSub]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 105 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c16, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c17, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c18, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c19, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c20, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.zw, v4.xyxy, c6.xyxy
mul r1.xy, r0.zwzw, c9.x
add r0.xy, v4.zyzw, c6
mul r0.xy, r0, c9.x
dsx r3.zw, v4.xyxz
abs r2.xy, v4
abs r2.z, v4
max r2.w, r2.x, r2.z
rcp r3.x, r2.w
min r2.w, r2.x, r2.z
mul r2.w, r2, r3.x
mul r3.x, r2.w, r2.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.x, c18.y, c18
mad r3.y, r0.z, r3.x, c18.w
add r0.xy, v4.zxzw, c6
mul r0.xy, r0, c9.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mad r3.y, r3, r3.x, c19.x
mad r2.y, r3, r3.x, c19
mad r2.y, r2, r3.x, c19.z
add_pp r1, -r0, c16.y
mul r2.y, r2, r2.w
mul r3.x, v2, c10
mul_sat r2.w, r3.x, c17
mad_pp r0, r2.w, r1, r0
mul r3.zw, r3, r3
add r1.x, r2, -r2.z
add r1.y, -r2, c19.w
cmp r1.w, -r1.x, r2.y, r1.y
abs r1.x, v4.y
add r2.x, -r1.w, c16.z
add r1.z, -r1.x, c16.y
mad r1.y, r1.x, c17.x, c17
mad r1.y, r1, r1.x, c16.w
rsq r1.z, r1.z
cmp r1.w, v4.z, r1, r2.x
mad r1.x, r1.y, r1, c17.z
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, v4.y, c16, c16.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c17.w, r1
mad r1.y, r1.x, c16.z, r1
cmp r1.z, v4.x, r1.w, -r1.w
mad r1.x, r1.z, c20, c20.y
mul r1.y, r1, c18.x
add r3.xy, r1, c5
dp4 r1.x, c2, c2
rsq r1.x, r1.x
mul r2.xyz, r1.x, c2
dp3_sat r2.x, v3, r2
dsy r1.xz, v4
mul r1.xz, r1, r1
add r1.z, r1.x, r1
add r2.w, r3.z, r3
rsq r1.x, r2.w
rsq r1.z, r1.z
rcp r2.w, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c20.x
dsx r1.w, r3.y
dsy r1.y, r3
mul r1.x, r2.w, c20
texldd r1, r3, s0, r1.zwzw, r1
mul r1, r1, c4
mul_pp r1, r1, r0
add_pp r2.x, r2, c20.z
mul_pp r0.y, r2.x, c3.w
mul_pp_sat r0.w, r0.y, c20
mov r0.x, c11
add r0.xyz, c3, r0.x
mad_sat r2.xyz, r0, r0.w, c0
add r3.xyz, -v1, c1
dp3 r0.w, r3, r3
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r3.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r3, r3
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c15.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
rcp r3.y, r0.y
mul r3.x, r0, c8
pow_sat r0, r3.x, c7.x
mul r0.y, r3, c13.x
add_sat r0.y, r0, -c12.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c14
mad r0.x, r0, r0.z, r0.y
mul_pp oC0.xyz, r1, r2
mul_pp oC0.w, r1, r0.x
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 272 // 196 used size, 17 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
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
eefiecedkagojadcjfompfigechfifpfbmpeggdbabaaaaaalianaaaaadaaaaaa
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
fdeieefcfaamaaaaeaaaaaaabeadaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaajaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaakaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
ajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
akaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
alaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaa
afaaaaaaagiacaaaaaaaaaaaalaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
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
Vector 5 [_MainOffset]
Vector 6 [_DetailOffset]
Float 7 [_FalloffPow]
Float 8 [_FalloffScale]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_FadeDist]
Float 13 [_FadeScale]
Float 14 [_RimDist]
Float 15 [_RimDistSub]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 105 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c16, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c17, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c18, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c19, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c20, 0.15915494, 0.50000000, -0.01000214, 4.03944778
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
add r0.zw, v4.xyxy, c6.xyxy
mul r1.xy, r0.zwzw, c9.x
add r0.xy, v4.zyzw, c6
mul r0.xy, r0, c9.x
dsx r3.zw, v4.xyxz
abs r2.xy, v4
abs r2.z, v4
max r2.w, r2.x, r2.z
rcp r3.x, r2.w
min r2.w, r2.x, r2.z
mul r2.w, r2, r3.x
mul r3.x, r2.w, r2.w
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r0.z, r3.x, c18.y, c18
mad r3.y, r0.z, r3.x, c18.w
add r0.xy, v4.zxzw, c6
mul r0.xy, r0, c9.x
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mad r3.y, r3, r3.x, c19.x
mad r2.y, r3, r3.x, c19
mad r2.y, r2, r3.x, c19.z
add_pp r1, -r0, c16.y
mul r2.y, r2, r2.w
mul r3.x, v2, c10
mul_sat r2.w, r3.x, c17
mad_pp r0, r2.w, r1, r0
mul r3.zw, r3, r3
add r1.x, r2, -r2.z
add r1.y, -r2, c19.w
cmp r1.w, -r1.x, r2.y, r1.y
abs r1.x, v4.y
add r2.x, -r1.w, c16.z
add r1.z, -r1.x, c16.y
mad r1.y, r1.x, c17.x, c17
mad r1.y, r1, r1.x, c16.w
rsq r1.z, r1.z
cmp r1.w, v4.z, r1, r2.x
mad r1.x, r1.y, r1, c17.z
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, v4.y, c16, c16.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c17.w, r1
mad r1.y, r1.x, c16.z, r1
cmp r1.z, v4.x, r1.w, -r1.w
mad r1.x, r1.z, c20, c20.y
mul r1.y, r1, c18.x
add r3.xy, r1, c5
dp4 r1.x, c2, c2
rsq r1.x, r1.x
mul r2.xyz, r1.x, c2
dp3_sat r2.x, v3, r2
dsy r1.xz, v4
mul r1.xz, r1, r1
add r1.z, r1.x, r1
add r2.w, r3.z, r3
rsq r1.x, r2.w
rsq r1.z, r1.z
rcp r2.w, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c20.x
dsx r1.w, r3.y
dsy r1.y, r3
mul r1.x, r2.w, c20
texldd r1, r3, s0, r1.zwzw, r1
mul r1, r1, c4
mul_pp r1, r1, r0
add_pp r2.x, r2, c20.z
mul_pp r0.y, r2.x, c3.w
mul_pp_sat r0.w, r0.y, c20
mov r0.x, c11
add r0.xyz, c3, r0.x
mad_sat r2.xyz, r0, r0.w, c0
add r3.xyz, -v1, c1
dp3 r0.w, r3, r3
mov r0.xyz, v0
add r0.xyz, v1, -r0
dp3 r0.x, r0, r0
rsq r0.y, r0.w
add r3.xyz, -v0, c1
rsq r0.x, r0.x
dp3 r0.w, r3, r3
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r2.w, -r0.x, c15.x, r0.y
mov r0.xyz, v3
dp3_sat r0.x, v5, r0
rsq r0.y, r0.w
rcp r3.y, r0.y
mul r3.x, r0, c8
pow_sat r0, r3.x, c7.x
mul r0.y, r3, c13.x
add_sat r0.y, r0, -c12.x
add r0.z, r0.x, -r0.y
mul_sat r0.x, r2.w, c14
mad r0.x, r0, r0.z, r0.y
mul_pp oC0.xyz, r1, r2
mul_pp oC0.w, r1, r0.x
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 272 // 196 used size, 17 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_MainOffset] 4
Vector 144 [_DetailOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_MinLight]
Float 180 [_FadeDist]
Float 184 [_FadeScale]
Float 188 [_RimDist]
Float 192 [_RimDistSub]
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
eefiecedkagojadcjfompfigechfifpfbmpeggdbabaaaaaalianaaaaadaaaaaa
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
fdeieefcfaamaaaaeaaaaaaabeadaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadeaaaaajbcaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaia
ibaaaaaaaeaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaackbabaia
ibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
icaabaaaaaaaaaaackbabaiaibaaaaaaaeaaaaaaakbabaiaibaaaaaaaeaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaakgbjbaaaaeaaaaaakgbjbaiaebaaaaaaaeaaaaaa
abaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaa
aaaaaaaackbabaaaaeaaaaaaakbabaaaaeaaaaaadbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
ckbabaaaaeaaaaaaakbabaaaaeaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaabkbabaiaibaaaaaaaeaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaaaeaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaia
ibaaaaaaaeaaaaaaabeaaaaakeanmjdpaaaaaaaibcaabaaaabaaaaaabkbabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
aaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaa
alaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaaaaaaaaaagbibaaaaeaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaaaaaaaai
pcaabaaaabaaaaaaggbcbaaaaeaaaaaaegiecaaaaaaaaaaaajaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaakaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaidcaabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
ajaaaaaadiaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaakgikcaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaia
ebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaiaibaaaaaaaeaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaia
ibaaaaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpapcaaaaibcaabaaaadaaaaaapgbpbaaaabaaaaaapgipcaaaaaaaaaaa
akaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaiocaabaaaabaaaaaaagbjbaaaabaaaaaaagbjbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaa
bacaaaahccaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaadaaaaaadiaaaaai
ccaabaaaabaaaaaabkaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaddaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaajhcaabaaaacaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaamecaabaaaabaaaaaa
ckiacaaaaaaaaaaaalaaaaaackaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
alaaaaaaaaaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaa
afaaaaaaagiacaaaaaaaaaaaalaaaaaadccaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
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

#LINE 153

	
		}
		
	} 
	
}
}
