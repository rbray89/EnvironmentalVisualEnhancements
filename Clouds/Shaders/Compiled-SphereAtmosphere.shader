Shader "Sphere/Atmosphere" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_Visibility ("Visibility", Float) = .0001
		_FalloffPow ("Falloff Power", Range(0,3)) = 2
		_FalloffScale ("Falloff Scale", Range(0,20)) = 3
		_FadeDist ("Fade Distance", Range(0,100)) = 10
		_FadeScale ("Fade Scale", Range(0,1)) = .002
		_RimDist ("Rim Distance", Range(0,1)) = 1
		_RimDistSub ("Rim Distance Sub", Range(0,2)) = 1.01
		_OceanRadius ("Ocean Radius", Float) = 63000
	}

Category {
	
	Tags { "Queue"="Overlay" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Mode Off}
	ZTest Off
	ColorMask RGB
	Cull Off Lighting On ZWrite Off
	
SubShader {
	Pass {

		Lighting On
		Tags { "LightMode"="ForwardBase"}
		
		Program "vp" {
// Vertex combos: 1
//   d3d9 - ALU: 39 to 39
//   d3d11 - ALU: 36 to 36, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying float xlv_TEXCOORD5;
varying float xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform mat4 _Object2World;


uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  vec3 p_9;
  p_9 = (tmpvar_4 - _WorldSpaceCameraPos);
  vec3 p_10;
  p_10 = (tmpvar_4 - tmpvar_3);
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD5 = (sqrt(dot (p_9, p_9)) - sqrt(dot (p_10, p_10)));
  xlv_TEXCOORD6 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD7 = (tmpvar_4 - _WorldSpaceCameraPos);
  xlv_TEXCOORD8 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying float xlv_TEXCOORD5;
varying float xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD0;
uniform float _OceanRadius;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _Color;
uniform vec4 _ZBufferParams;
void main ()
{
  float sphereDist_1;
  vec4 color_2;
  color_2 = _Color;
  float tmpvar_3;
  tmpvar_3 = min (xlv_TEXCOORD4, (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.w))));
  sphereDist_1 = xlv_TEXCOORD4;
  float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD7, xlv_TEXCOORD8);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (xlv_TEXCOORD7, xlv_TEXCOORD7) - (tmpvar_4 * tmpvar_4)));
  if (((tmpvar_5 <= _OceanRadius) && (tmpvar_4 >= 0.0))) {
    sphereDist_1 = (tmpvar_4 - sqrt((pow (_OceanRadius, 2.0) - pow (tmpvar_5, 2.0))));
  };
  float tmpvar_6;
  tmpvar_6 = (min (sphereDist_1, tmpvar_3) * _Visibility);
  color_2.w = (_Color.w * mix (tmpvar_6, min (tmpvar_6, clamp (pow ((_FalloffScale * clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD6), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), clamp (xlv_TEXCOORD5, 0.0, 1.0)));
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
"vs_3_0
; 39 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
dcl_texcoord8 o9
def c15, 0.50000000, 0, 0, 0
dcl_position0 v0
dp4 r0.w, v0, c7
mov r0.x, c8.w
dp4 r2.z, v0, c10
dp4 r2.y, v0, c9
dp4 r2.x, v0, c8
mov r0.z, c10.w
mov r0.y, c9.w
add r3.xyz, r2, -r0
dp3 r1.x, r3, r3
rsq r1.z, r1.x
mul o7.xyz, r1.z, r3
mov r1.w, r0
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r4.xyz, r1.xyww, c15.x
mul r3.y, r4, c13.x
mov r3.x, r4
mad o1.xy, r4.z, c14.zwzw, r3
add r4.xyz, -r0, c12
dp3 r2.w, r4, r4
rsq r3.w, r2.w
add r3.xyz, -r2, c12
dp3 r2.w, r3, r3
rsq r2.w, r2.w
mul r3.xyz, r2.w, r3
mov o3.xyz, r0
dp4 r0.x, v0, c2
rcp r1.z, r1.z
rcp r3.w, r3.w
add o6.x, r3.w, -r1.z
dp4 r1.z, v0, c6
mov o0, r1
mov o4.xyz, r3
mov o9.xyz, -r3
mov o2.xyz, r2
rcp o5.x, r2.w
mov o8.xyz, -r4
mov o1.z, -r0.x
mov o1.w, r0
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 42 instructions, 2 temp regs, 0 temp arrays:
// ALU 36 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhidkcpgffofpmdadjkaoelaelghlfngiabaaaaaafeahaaaaadaaaaaa
cmaaaaaajmaaaaaaleabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaaklklepfdeheo
baabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaaeabaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaaeabaaaaaeaaaaaaaaaaaaaa
adaaaaaaacaaaaaaaiahaaaaaeabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaaeabaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiahaaaaaeabaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaaeabaaaaagaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaaeabaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaaaeabaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiafaaaaeaaaabaa
ggabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadiccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaa
gfaaaaadhccabaaaahaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaaficcabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaah
dccabaaaabaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficcabaaaacaaaaaa
dkaabaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaahaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaa
aaaaaaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaagaaaaaaegacbaaa
abaaaaaaelaaaaafbcaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaaiiccabaaa
adaaaaaadkaabaiaebaaaaaaaaaaaaaaakaabaaaabaaaaaadgaaaaaghccabaaa
adaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaapaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  highp vec3 p_9;
  p_9 = (tmpvar_4 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_4 - tmpvar_3);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD5 = (sqrt(dot (p_9, p_9)) - sqrt(dot (p_10, p_10)));
  xlv_TEXCOORD6 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD7 = (tmpvar_4 - _WorldSpaceCameraPos);
  xlv_TEXCOORD8 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float sphereDist_2;
  highp float depth_3;
  mediump vec4 color_4;
  color_4 = _Color;
  lowp float tmpvar_5;
  tmpvar_5 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = min (xlv_TEXCOORD4, (1.0/(((_ZBufferParams.z * depth_3) + _ZBufferParams.w))));
  depth_3 = tmpvar_6;
  sphereDist_2 = xlv_TEXCOORD4;
  highp float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD7, xlv_TEXCOORD8);
  highp float tmpvar_8;
  tmpvar_8 = sqrt((dot (xlv_TEXCOORD7, xlv_TEXCOORD7) - (tmpvar_7 * tmpvar_7)));
  if (((tmpvar_8 <= _OceanRadius) && (tmpvar_7 >= 0.0))) {
    sphereDist_2 = (tmpvar_7 - sqrt((pow (_OceanRadius, 2.0) - pow (tmpvar_8, 2.0))));
  };
  highp float tmpvar_9;
  tmpvar_9 = (min (sphereDist_2, tmpvar_6) * _Visibility);
  depth_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (color_4.w * mix (tmpvar_9, min (tmpvar_9, clamp (pow ((_FalloffScale * clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD6), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), clamp (xlv_TEXCOORD5, 0.0, 1.0)));
  color_4.w = tmpvar_10;
  tmpvar_1 = color_4;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_6.xyw;
  highp vec3 p_9;
  p_9 = (tmpvar_4 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_4 - tmpvar_3);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD4 = sqrt(dot (p_5, p_5));
  xlv_TEXCOORD5 = (sqrt(dot (p_9, p_9)) - sqrt(dot (p_10, p_10)));
  xlv_TEXCOORD6 = normalize((tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD7 = (tmpvar_4 - _WorldSpaceCameraPos);
  xlv_TEXCOORD8 = normalize((tmpvar_3 - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _OceanRadius;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform highp float _Visibility;
uniform sampler2D _CameraDepthTexture;
uniform lowp vec4 _Color;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float sphereDist_2;
  highp float depth_3;
  mediump vec4 color_4;
  color_4 = _Color;
  lowp float tmpvar_5;
  tmpvar_5 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = min (xlv_TEXCOORD4, (1.0/(((_ZBufferParams.z * depth_3) + _ZBufferParams.w))));
  depth_3 = tmpvar_6;
  sphereDist_2 = xlv_TEXCOORD4;
  highp float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD7, xlv_TEXCOORD8);
  highp float tmpvar_8;
  tmpvar_8 = sqrt((dot (xlv_TEXCOORD7, xlv_TEXCOORD7) - (tmpvar_7 * tmpvar_7)));
  if (((tmpvar_8 <= _OceanRadius) && (tmpvar_7 >= 0.0))) {
    sphereDist_2 = (tmpvar_7 - sqrt((pow (_OceanRadius, 2.0) - pow (tmpvar_8, 2.0))));
  };
  highp float tmpvar_9;
  tmpvar_9 = (min (sphereDist_2, tmpvar_6) * _Visibility);
  depth_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (color_4.w * mix (tmpvar_9, min (tmpvar_9, clamp (pow ((_FalloffScale * clamp (pow ((_FalloffScale * clamp (dot (xlv_TEXCOORD3, xlv_TEXCOORD6), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), clamp (xlv_TEXCOORD5, 0.0, 1.0)));
  color_4.w = tmpvar_10;
  tmpvar_1 = color_4;
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
#line 408
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 worldNormal;
    highp vec3 L;
    highp vec3 camViewDir;
};
#line 401
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
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform sampler2D _CameraDepthTexture;
#line 393
uniform highp float _Visibility;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _FadeDist;
#line 397
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
uniform highp float _OceanRadius;
#line 422
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 87
highp vec3 WorldSpaceViewDir( in highp vec4 v ) {
    return (_WorldSpaceCameraPos.xyz - (_Object2World * v).xyz);
}
#line 422
v2f vert( in appdata_t v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 426
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    #line 430
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.viewDir = normalize(WorldSpaceViewDir( v.vertex));
    o.camViewDir = normalize((vertexPos - _WorldSpaceCameraPos));
    o.worldNormal = normalize((vertexPos - origin));
    #line 434
    o.scrPos = ComputeScreenPos( o.pos);
    o.altitude = (distance( origin, _WorldSpaceCameraPos) - distance( origin, vertexPos));
    o.L = (origin - _WorldSpaceCameraPos);
    o.scrPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    #line 438
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp float xlv_TEXCOORD4;
out highp float xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
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
    xlv_TEXCOORD0 = vec4(xl_retval.scrPos);
    xlv_TEXCOORD1 = vec3(xl_retval.worldVert);
    xlv_TEXCOORD2 = vec3(xl_retval.worldOrigin);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = float(xl_retval.viewDist);
    xlv_TEXCOORD5 = float(xl_retval.altitude);
    xlv_TEXCOORD6 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD7 = vec3(xl_retval.L);
    xlv_TEXCOORD8 = vec3(xl_retval.camViewDir);
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct v2f {
    highp vec4 pos;
    highp vec4 scrPos;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp vec3 viewDir;
    highp float viewDist;
    highp float altitude;
    highp vec3 worldNormal;
    highp vec3 L;
    highp vec3 camViewDir;
};
#line 401
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
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _Color;
uniform sampler2D _CameraDepthTexture;
#line 393
uniform highp float _Visibility;
uniform highp float _FalloffPow;
uniform highp float _FalloffScale;
uniform highp float _FadeDist;
#line 397
uniform highp float _FadeScale;
uniform highp float _RimDist;
uniform highp float _RimDistSub;
uniform highp float _OceanRadius;
#line 422
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 440
lowp vec4 frag( in v2f IN ) {
    #line 442
    mediump vec4 color = _Color;
    highp float depth = textureProj( _CameraDepthTexture, IN.scrPos).x;
    depth = min( IN.viewDist, LinearEyeDepth( depth));
    highp float sphereDist = IN.viewDist;
    #line 446
    highp float tc = dot( IN.L, IN.camViewDir);
    highp float d = sqrt((dot( IN.L, IN.L) - dot( tc, tc)));
    if (((d <= _OceanRadius) && (tc >= 0.0))){
        #line 450
        highp float tlc = sqrt((pow( _OceanRadius, 2.0) - pow( d, 2.0)));
        sphereDist = (tc - tlc);
    }
    depth = min( sphereDist, depth);
    #line 454
    highp float rim = xll_saturate_f(dot( IN.viewDir, IN.worldNormal));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((_RimDist * (distance( IN.worldOrigin, _WorldSpaceCameraPos) - (_RimDistSub * distance( IN.worldVert, IN.worldOrigin)))));
    #line 458
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    depth *= _Visibility;
    color.w *= mix( depth, min( depth, rim), xll_saturate_f(IN.altitude));
    #line 462
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp float xlv_TEXCOORD4;
in highp float xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
in highp vec3 xlv_TEXCOORD8;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.scrPos = vec4(xlv_TEXCOORD0);
    xlt_IN.worldVert = vec3(xlv_TEXCOORD1);
    xlt_IN.worldOrigin = vec3(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.viewDist = float(xlv_TEXCOORD4);
    xlt_IN.altitude = float(xlv_TEXCOORD5);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD6);
    xlt_IN.L = vec3(xlv_TEXCOORD7);
    xlt_IN.camViewDir = vec3(xlv_TEXCOORD8);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   d3d9 - ALU: 39 to 39, TEX: 1 to 1
//   d3d11 - ALU: 32 to 32, TEX: 1 to 1, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { }
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_Visibility]
Float 3 [_FalloffPow]
Float 4 [_FalloffScale]
Float 5 [_OceanRadius]
SetTexture 0 [_CameraDepthTexture] 2D
"ps_3_0
; 39 ALU, 1 TEX
dcl_2d s0
def c6, 1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.x
dcl_texcoord5 v5.x
dcl_texcoord6 v6.xyz
dcl_texcoord7 v7.xyz
dcl_texcoord8 v8.xyz
mov r1.xyz, v8
dp3 r1.y, v7, r1
dp3 r0.x, v7, v7
mad r0.x, -r1.y, r1.y, r0
rsq r0.x, r0.x
rcp r1.x, r0.x
mov r0.xyz, v6
dp3_sat r0.y, v3, r0
mul r0.w, r1.x, r1.x
mad r0.w, c5.x, c5.x, -r0
rsq r0.x, r0.w
mul r1.z, r0.y, c4.x
rcp r1.w, r0.x
pow_sat r0, r1.z, c3.x
add r0.y, -r1.x, c5.x
add r0.w, r1.y, -r1
cmp r0.z, r1.y, c6.x, c6.y
cmp r0.y, r0, c6.x, c6
mul_pp r0.y, r0, r0.z
cmp r1.y, -r0, v4.x, r0.w
mov r0.y, r0.x
texldp r1.x, v0, s0
mad r0.x, r1, c0.z, c0.w
rcp r1.x, r0.x
mul r1.z, r0.y, c4.x
pow_sat r0, r1.z, c3.x
min r0.y, v4.x, r1.x
mov r0.z, r0.x
min r0.y, r1, r0
mul r0.x, r0.y, c2
min r0.y, r0.x, r0.z
add r0.z, r0.y, -r0.x
mov_sat r0.y, v5.x
mad r0.x, r0.y, r0.z, r0
mul_pp oC0.w, r0.x, c1
mov_pp oC0.xyz, c1
"
}

SubProgram "d3d11 " {
Keywords { }
ConstBuffer "$Globals" 96 // 96 used size, 12 vars
Vector 48 [_Color] 4
Float 64 [_Visibility]
Float 68 [_FalloffPow]
Float 72 [_FalloffScale]
Float 92 [_OceanRadius]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_CameraDepthTexture] 2D 0
// 37 instructions, 2 temp regs, 0 temp arrays:
// ALU 31 float, 0 int, 1 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedmhhehhiakadbiipphfhmekcjcmlmjenmabaaaaaagiagaaaaadaaaaaa
cmaaaaaaeeabaaaahiabaaaaejfdeheobaabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaaeabaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaaeabaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaaaeabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaaeabaaaaafaaaaaaaaaaaaaa
adaaaaaaadaaaaaaaiaiaaaaaeabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahahaaaaaeabaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaaaeabaaaa
ahaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaaeabaaaaaiaaaaaaaaaaaaaa
adaaaaaaahaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiaeaaaa
eaaaaaaadkabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadicbabaaaacaaaaaagcbaaaad
icbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaabacaaaahbcaabaaaaaaaaaaaegbcbaaaaeaaaaaa
egbcbaaaafaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaa
aaaaaaaaaeaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaeaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaa
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpbaaaaaahccaabaaaaaaaaaaaegbcbaaa
agaaaaaaegbcbaaaagaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaagaaaaaa
egbcbaaaahaaaaaadcaaaaakccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
bnaaaaaiccaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaabkaabaaaaaaaaaaa
dcaaaaamicaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadkiacaaaaaaaaaaa
afaaaaaadkaabaiaebaaaaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaabnaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaa
abaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaacaaaaaa
aoaaaaahmcaabaaaaaaaaaaaagbebaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalecaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkbabaaaacaaaaaaddaaaaahccaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaaaaaaaaaaeaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
akiacaaaaaaaaaaaaeaaaaaaakaabaaaaaaaaaaadgcaaaafccaabaaaaaaaaaaa
dkbabaaaadaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaadaaaaaadgaaaaaghccabaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaadoaaaaab"
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

#LINE 126

	
		}
		
	} 
	
}
}
