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
		_MinLight ("Minimum Light", Range(0,1)) = .1
		_FadeDist ("Fade Distance", Range(0,100)) = 10
		_FadeScale ("Fade Scale", Range(0,1)) = .002
		_RimDist ("Rim Distance", Range(0,100000)) = 1000
	}

SubShader {
		Tags {  "Queue"="Transparent"
	   			"RenderMode"="Transparent" }
		Lighting On
		Cull Off
	    ZWrite Off
		
		Blend SrcAlpha OneMinusSrcAlpha
		
			
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
Program "vp" {
// Vertex combos: 6
//   d3d9 - ALU: 42 to 47
//   d3d11 - ALU: 32 to 35, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
attribute vec4 TANGENT;

uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec3 p_2;
  p_2 = (tmpvar_1 - _WorldSpaceCameraPos);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_3 = TANGENT.xyz;
  tmpvar_4 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_5;
  tmpvar_5[0].x = tmpvar_3.x;
  tmpvar_5[0].y = tmpvar_4.x;
  tmpvar_5[0].z = gl_Normal.x;
  tmpvar_5[1].x = tmpvar_3.y;
  tmpvar_5[1].y = tmpvar_4.y;
  tmpvar_5[1].z = gl_Normal.y;
  tmpvar_5[2].x = tmpvar_3.z;
  tmpvar_5[2].y = tmpvar_4.z;
  tmpvar_5[2].z = gl_Normal.z;
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (tmpvar_5 * (((_World2Object * tmpvar_6).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  xlv_TEXCOORD4 = sqrt(dot (p_2, p_2));
  xlv_TEXCOORD5 = (tmpvar_5 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD6 = gl_LightModel.ambient.xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _BumpScale;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _BumpOffset;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
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
  vec4 tmpvar_16;
  tmpvar_16 = (texture2DGradARB (_MainTex, uv_2, tmpvar_15.xy, tmpvar_15.zw) * _Color);
  vec3 tmpvar_17;
  tmpvar_17 = abs(xlv_TEXCOORD1);
  vec4 tmpvar_18;
  tmpvar_18 = mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_17.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_17.yyyy);
  float tmpvar_19;
  tmpvar_19 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD4), 0.0, 1.0);
  vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_16.xyz * mix (tmpvar_18.xyz, vec3(1.0, 1.0, 1.0), vec3(tmpvar_19)));
  vec3 p_21;
  p_21 = (xlv_TEXCOORD2 - _WorldSpaceCameraPos);
  vec3 p_22;
  p_22 = (xlv_TEXCOORD3 - _WorldSpaceCameraPos);
  vec3 p_23;
  p_23 = (xlv_TEXCOORD2 - xlv_TEXCOORD3);
  vec3 normal_24;
  normal_24.xy = ((mix (mix (texture2D (_BumpMap, ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy)), texture2D (_BumpMap, ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy)), tmpvar_17.xxxx), texture2D (_BumpMap, ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy)), tmpvar_17.yyyy).wy * 2.0) - 1.0);
  normal_24.z = sqrt((1.0 - clamp (dot (normal_24.xy, normal_24.xy), 0.0, 1.0)));
  vec4 c_25;
  c_25.xyz = (tmpvar_20 * clamp ((_MinLight + (_LightColor0.xyz * (clamp (dot (mix (normal_24, vec3(0.0, 0.0, 1.0), vec3(tmpvar_19)), xlv_TEXCOORD5), 0.0, 1.0) * 2.0))), 0.0, 1.0));
  c_25.w = mix (0.0, min (tmpvar_16.w, mix (tmpvar_18.w, 1.0, tmpvar_19)), mix (clamp (((_FadeScale * sqrt(dot (p_21, p_21))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(normalize(xlv_TEXCOORD0).z), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((sqrt(dot (p_22, p_22)) - (1.2 * sqrt(dot (p_23, p_23)))), 0.0, 1.0)));
  c_1.w = c_25.w;
  c_1.xyz = (c_25.xyz + (tmpvar_20 * xlv_TEXCOORD6));
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 15 [unity_Scale]
"vs_3_0
; 42 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c14, r0
mov r0, c9
dp4 r4.y, c14, r0
dp3 r0.w, v0, v0
rsq r0.w, r0.w
mov r1.w, c16.x
mov r1.xyz, c13
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
mov r1, c8
dp4 r4.x, c14, r1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
add r1.xyz, -r0, c13
dp3 r1.x, r1, r1
mul o2.xyz, r0.w, v0
rsq r0.w, r1.x
dp3 o1.y, r2, r3
dp3 o6.y, r3, r4
dp3 o1.z, v2, r2
dp3 o1.x, r2, v1
dp3 o6.z, v2, r4
dp3 o6.x, v1, r4
mov o3.xyz, r0
rcp o5.x, r0.w
mov o7.xyz, c12
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o4.z, c6.w
mov o4.y, c5.w
mov o4.x, c4.w
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "UnityPerCamera" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 36 instructions, 2 temp regs, 0 temp arrays:
// ALU 32 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedndcpnfahkglnffbhicepphhldhiagmbfabaaaaaaemahaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaiahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
giafaaaaeaaaabaafkabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafjaaaaae
egiocaaaadaaaaaaafaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaaaaaaaaaaeaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
elaaaaaficcabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaaaaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaaaaaaaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
aaaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
abaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaabaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
aaaaaaaaegbcbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaaaaaaaaadgaaaaag
hccabaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
abaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
acaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaagaaaaaaegiccaaa
adaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_1.xyz;
  tmpvar_8 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_2.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_2.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_2.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (tmpvar_9 * (((_World2Object * tmpvar_11).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  xlv_TEXCOORD4 = sqrt(dot (p_6, p_6));
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
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
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = tmpvar_2;
  tmpvar_5 = 0.0;
  mediump float detailLevel_6;
  mediump vec4 normal_7;
  mediump vec4 detail_8;
  mediump vec4 normalZ_9;
  mediump vec4 normalY_10;
  mediump vec4 normalX_11;
  mediump vec4 detailZ_12;
  mediump vec4 detailY_13;
  mediump vec4 detailX_14;
  mediump vec4 main_15;
  highp vec2 uv_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_16.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD1.y);
  uv_16.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_16, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_15 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_14 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_13 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_12 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_11 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_10 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_9 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_12, detailX_14, tmpvar_43.xxxx);
  detail_8 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_8, detailY_13, tmpvar_43.yyyy);
  detail_8 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_9, normalX_11, tmpvar_43.xxxx);
  normal_7 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_7, normalY_10, tmpvar_43.yyyy);
  normal_7 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD4), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = min (main_15.w, mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD2 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD3 - _WorldSpaceCameraPos);
  highp vec3 p_53;
  p_53 = (xlv_TEXCOORD2 - xlv_TEXCOORD3);
  highp float tmpvar_54;
  tmpvar_54 = mix (0.0, tmpvar_50, mix (clamp (((_FadeScale * sqrt(dot (p_51, p_51))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(normalize(xlv_TEXCOORD0).z), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((sqrt(dot (p_52, p_52)) - (1.2 * sqrt(dot (p_53, p_53)))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_54;
  lowp vec3 tmpvar_55;
  lowp vec4 packednormal_56;
  packednormal_56 = normal_7;
  tmpvar_55 = ((packednormal_56.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_57;
  tmpvar_57 = mix (tmpvar_55, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_57;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_58;
  lightDir_58 = xlv_TEXCOORD5;
  mediump vec4 c_59;
  mediump float tmpvar_60;
  tmpvar_60 = clamp (dot (tmpvar_4, lightDir_58), 0.0, 1.0);
  highp vec3 tmpvar_61;
  tmpvar_61 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_60 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_62;
  tmpvar_62 = (tmpvar_3 * tmpvar_61);
  c_59.xyz = tmpvar_62;
  c_59.w = tmpvar_5;
  c_1 = c_59;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD6));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_1.xyz;
  tmpvar_8 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_2.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_2.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_2.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (tmpvar_9 * (((_World2Object * tmpvar_11).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  xlv_TEXCOORD4 = sqrt(dot (p_6, p_6));
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
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
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = tmpvar_2;
  tmpvar_5 = 0.0;
  mediump float detailLevel_6;
  mediump vec4 normal_7;
  mediump vec4 detail_8;
  mediump vec4 normalZ_9;
  mediump vec4 normalY_10;
  mediump vec4 normalX_11;
  mediump vec4 detailZ_12;
  mediump vec4 detailY_13;
  mediump vec4 detailX_14;
  mediump vec4 main_15;
  highp vec2 uv_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_16.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD1.y);
  uv_16.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_16, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_15 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_14 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_13 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_12 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_11 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_10 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_9 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_12, detailX_14, tmpvar_43.xxxx);
  detail_8 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_8, detailY_13, tmpvar_43.yyyy);
  detail_8 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_9, normalX_11, tmpvar_43.xxxx);
  normal_7 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_7, normalY_10, tmpvar_43.yyyy);
  normal_7 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD4), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = min (main_15.w, mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD2 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD3 - _WorldSpaceCameraPos);
  highp vec3 p_53;
  p_53 = (xlv_TEXCOORD2 - xlv_TEXCOORD3);
  highp float tmpvar_54;
  tmpvar_54 = mix (0.0, tmpvar_50, mix (clamp (((_FadeScale * sqrt(dot (p_51, p_51))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(normalize(xlv_TEXCOORD0).z), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((sqrt(dot (p_52, p_52)) - (1.2 * sqrt(dot (p_53, p_53)))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_54;
  lowp vec4 packednormal_55;
  packednormal_55 = normal_7;
  lowp vec3 normal_56;
  normal_56.xy = ((packednormal_55.wy * 2.0) - 1.0);
  normal_56.z = sqrt((1.0 - clamp (dot (normal_56.xy, normal_56.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_57;
  tmpvar_57 = mix (normal_56, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_57;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_58;
  lightDir_58 = xlv_TEXCOORD5;
  mediump vec4 c_59;
  mediump float tmpvar_60;
  tmpvar_60 = clamp (dot (tmpvar_4, lightDir_58), 0.0, 1.0);
  highp vec3 tmpvar_61;
  tmpvar_61 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_60 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_62;
  tmpvar_62 = (tmpvar_3 * tmpvar_61);
  c_59.xyz = tmpvar_62;
  c_59.w = tmpvar_5;
  c_1 = c_59;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD6));
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
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
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
#line 414
struct Input {
    highp vec3 nrm;
    highp vec3 viewDir;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
};
#line 477
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
    highp vec3 cust_nrm;
    highp vec3 cust_worldVert;
    highp vec3 cust_worldOrigin;
    highp float cust_viewDist;
    lowp vec3 lightDir;
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
#line 423
#line 444
#line 489
#line 510
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 423
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 427
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    #line 431
    o.nrm = normalize(v.vertex.xyz);
}
#line 489
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 493
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.cust_worldVert = customInputData.worldVert;
    o.cust_worldOrigin = customInputData.worldOrigin;
    #line 497
    o.cust_viewDist = customInputData.viewDist;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 501
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 505
    o.viewDir = viewDirForLight;
    o.vlight = glstate_lightmodel_ambient.xyz;
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp float xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out lowp vec3 xlv_TEXCOORD6;
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
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_nrm);
    xlv_TEXCOORD2 = vec3(xl_retval.cust_worldVert);
    xlv_TEXCOORD3 = vec3(xl_retval.cust_worldOrigin);
    xlv_TEXCOORD4 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD5 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD6 = vec3(xl_retval.vlight);
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
#line 414
struct Input {
    highp vec3 nrm;
    highp vec3 viewDir;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
};
#line 477
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
    highp vec3 cust_nrm;
    highp vec3 cust_worldVert;
    highp vec3 cust_worldOrigin;
    highp float cust_viewDist;
    lowp vec3 lightDir;
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
#line 423
#line 444
#line 489
#line 510
#line 406
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    #line 409
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    return c;
}
#line 433
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 435
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 439
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 444
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    #line 448
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 452
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((nrm.zy * _BumpScale) + _BumpOffset.xy));
    #line 456
    mediump vec4 normalY = texture( _BumpMap, ((nrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((nrm.xy * _BumpScale) + _BumpOffset.xy));
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    #line 460
    detail = mix( detail, detailY, vec4( nrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( nrm.x));
    normal = mix( normal, normalY, vec4( nrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 464
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Albedo = albedo;
    mediump float avg = min( main.w, mix( detail.w, 1.0, detailLevel));
    #line 468
    highp float rim = xll_saturate_f(abs(dot( normalize(IN.viewDir), o.Normal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.2 * distance( IN.worldVert, IN.worldOrigin))));
    #line 472
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    o.Alpha = mix( 0.0, avg, distAlpha);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 510
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    #line 514
    surfIN.worldVert = IN.cust_worldVert;
    surfIN.worldOrigin = IN.cust_worldOrigin;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.viewDir = IN.viewDir;
    #line 518
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 522
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = 1.0;
    #line 526
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp float xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in lowp vec3 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.cust_worldVert = vec3(xlv_TEXCOORD2);
    xlt_IN.cust_worldOrigin = vec3(xlv_TEXCOORD3);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD4);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD5);
    xlt_IN.vlight = vec3(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
attribute vec4 TANGENT;

uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec3 p_2;
  p_2 = (tmpvar_1 - _WorldSpaceCameraPos);
  vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  vec4 o_8;
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_3 * 0.5);
  vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (tmpvar_6 * (((_World2Object * tmpvar_7).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  xlv_TEXCOORD4 = sqrt(dot (p_2, p_2));
  xlv_TEXCOORD5 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD6 = gl_LightModel.ambient.xyz;
  xlv_TEXCOORD7 = o_8;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _BumpScale;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _BumpOffset;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
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
  vec4 tmpvar_16;
  tmpvar_16 = (texture2DGradARB (_MainTex, uv_2, tmpvar_15.xy, tmpvar_15.zw) * _Color);
  vec3 tmpvar_17;
  tmpvar_17 = abs(xlv_TEXCOORD1);
  vec4 tmpvar_18;
  tmpvar_18 = mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_17.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_17.yyyy);
  float tmpvar_19;
  tmpvar_19 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD4), 0.0, 1.0);
  vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_16.xyz * mix (tmpvar_18.xyz, vec3(1.0, 1.0, 1.0), vec3(tmpvar_19)));
  vec3 p_21;
  p_21 = (xlv_TEXCOORD2 - _WorldSpaceCameraPos);
  vec3 p_22;
  p_22 = (xlv_TEXCOORD3 - _WorldSpaceCameraPos);
  vec3 p_23;
  p_23 = (xlv_TEXCOORD2 - xlv_TEXCOORD3);
  vec3 normal_24;
  normal_24.xy = ((mix (mix (texture2D (_BumpMap, ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy)), texture2D (_BumpMap, ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy)), tmpvar_17.xxxx), texture2D (_BumpMap, ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy)), tmpvar_17.yyyy).wy * 2.0) - 1.0);
  normal_24.z = sqrt((1.0 - clamp (dot (normal_24.xy, normal_24.xy), 0.0, 1.0)));
  vec4 c_25;
  c_25.xyz = (tmpvar_20 * clamp ((_MinLight + (_LightColor0.xyz * ((clamp (dot (mix (normal_24, vec3(0.0, 0.0, 1.0), vec3(tmpvar_19)), xlv_TEXCOORD5), 0.0, 1.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x) * 2.0))), 0.0, 1.0));
  c_25.w = mix (0.0, min (tmpvar_16.w, mix (tmpvar_18.w, 1.0, tmpvar_19)), mix (clamp (((_FadeScale * sqrt(dot (p_21, p_21))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(normalize(xlv_TEXCOORD0).z), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((sqrt(dot (p_22, p_22)) - (1.2 * sqrt(dot (p_23, p_23)))), 0.0, 1.0)));
  c_1.w = c_25.w;
  c_1.xyz = (c_25.xyz + (tmpvar_20 * xlv_TEXCOORD6));
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 16 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 17 [unity_Scale]
"vs_3_0
; 47 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c18, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c16, r0
mov r0, c9
dp4 r4.y, c16, r0
mov r1.w, c18.x
mov r1.xyz, c13
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov o0, r0
mov o8.zw, r0
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c17.w, -v0
mov r1, c8
dp4 r4.x, c16, r1
mul r1.xyz, r0.xyww, c18.y
mul r1.y, r1, c14.x
dp3 r0.w, v0, v0
rsq r0.w, r0.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mad o8.xy, r1.z, c15.zwzw, r1
add r1.xyz, -r0, c13
dp3 r1.x, r1, r1
mul o2.xyz, r0.w, v0
rsq r0.w, r1.x
dp3 o1.y, r2, r3
dp3 o6.y, r3, r4
dp3 o1.z, v2, r2
dp3 o1.x, r2, v1
dp3 o6.z, v2, r4
dp3 o6.x, v1, r4
mov o3.xyz, r0
rcp o5.x, r0.w
mov o7.xyz, c12
mov o4.z, c6.w
mov o4.y, c5.w
mov o4.x, c4.w
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "UnityPerCamera" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 41 instructions, 3 temp regs, 0 temp arrays:
// ALU 35 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddpkldkoofnhelmmhgcmfmngimdlilamhabaaaaaapmahaaaaadaaaaaa
cmaaaaaapeaaaaaapeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheopiaaaaaaajaaaaaa
aiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcaaagaaaaeaaaabaa
iaabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafjaaaaaeegiocaaaadaaaaaa
afaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
aaaaaaaaaeaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaficcabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaaaaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaaaaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaaaaaaaaaaeaaaaaa
egacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
acaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaabaaaaaaegbcbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaabaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaaaaaaaaaegbcbaaa
aaaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaa
acaaaaaapgapbaaaabaaaaaaegbcbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaa
egiccaaaacaaaaaaapaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaa
aaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaabdaaaaaa
pgipcaaaabaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaaafaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaadgaaaaaghccabaaaagaaaaaaegiccaaaadaaaaaaaeaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaahaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaahaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_1.xyz;
  tmpvar_8 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_2.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_2.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_2.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (tmpvar_9 * (((_World2Object * tmpvar_11).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  xlv_TEXCOORD4 = sqrt(dot (p_6, p_6));
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
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
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = tmpvar_2;
  tmpvar_5 = 0.0;
  mediump float detailLevel_6;
  mediump vec4 normal_7;
  mediump vec4 detail_8;
  mediump vec4 normalZ_9;
  mediump vec4 normalY_10;
  mediump vec4 normalX_11;
  mediump vec4 detailZ_12;
  mediump vec4 detailY_13;
  mediump vec4 detailX_14;
  mediump vec4 main_15;
  highp vec2 uv_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_16.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD1.y);
  uv_16.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_16, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_15 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_14 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_13 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_12 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_11 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_10 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_9 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_12, detailX_14, tmpvar_43.xxxx);
  detail_8 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_8, detailY_13, tmpvar_43.yyyy);
  detail_8 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_9, normalX_11, tmpvar_43.xxxx);
  normal_7 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_7, normalY_10, tmpvar_43.yyyy);
  normal_7 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD4), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = min (main_15.w, mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD2 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD3 - _WorldSpaceCameraPos);
  highp vec3 p_53;
  p_53 = (xlv_TEXCOORD2 - xlv_TEXCOORD3);
  highp float tmpvar_54;
  tmpvar_54 = mix (0.0, tmpvar_50, mix (clamp (((_FadeScale * sqrt(dot (p_51, p_51))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(normalize(xlv_TEXCOORD0).z), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((sqrt(dot (p_52, p_52)) - (1.2 * sqrt(dot (p_53, p_53)))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_54;
  lowp vec3 tmpvar_55;
  lowp vec4 packednormal_56;
  packednormal_56 = normal_7;
  tmpvar_55 = ((packednormal_56.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_57;
  tmpvar_57 = mix (tmpvar_55, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_57;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_58;
  mediump float lightShadowDataX_59;
  highp float dist_60;
  lowp float tmpvar_61;
  tmpvar_61 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x;
  dist_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = _LightShadowData.x;
  lightShadowDataX_59 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = max (float((dist_60 > (xlv_TEXCOORD7.z / xlv_TEXCOORD7.w))), lightShadowDataX_59);
  tmpvar_58 = tmpvar_63;
  mediump vec3 lightDir_64;
  lightDir_64 = xlv_TEXCOORD5;
  mediump float atten_65;
  atten_65 = tmpvar_58;
  mediump vec4 c_66;
  mediump float tmpvar_67;
  tmpvar_67 = clamp (dot (tmpvar_4, lightDir_64), 0.0, 1.0);
  highp vec3 tmpvar_68;
  tmpvar_68 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_67 * atten_65) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_69;
  tmpvar_69 = (tmpvar_3 * tmpvar_68);
  c_66.xyz = tmpvar_69;
  c_66.w = tmpvar_5;
  c_1 = c_66;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD6));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_13;
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = (tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  xlv_TEXCOORD4 = sqrt(dot (p_6, p_6));
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = o_14;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
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
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = tmpvar_2;
  tmpvar_5 = 0.0;
  mediump float detailLevel_6;
  mediump vec4 normal_7;
  mediump vec4 detail_8;
  mediump vec4 normalZ_9;
  mediump vec4 normalY_10;
  mediump vec4 normalX_11;
  mediump vec4 detailZ_12;
  mediump vec4 detailY_13;
  mediump vec4 detailX_14;
  mediump vec4 main_15;
  highp vec2 uv_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_16.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD1.y);
  uv_16.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_16, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_15 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_14 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_13 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_12 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_11 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_10 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_9 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_12, detailX_14, tmpvar_43.xxxx);
  detail_8 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_8, detailY_13, tmpvar_43.yyyy);
  detail_8 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_9, normalX_11, tmpvar_43.xxxx);
  normal_7 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_7, normalY_10, tmpvar_43.yyyy);
  normal_7 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD4), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = min (main_15.w, mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD2 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD3 - _WorldSpaceCameraPos);
  highp vec3 p_53;
  p_53 = (xlv_TEXCOORD2 - xlv_TEXCOORD3);
  highp float tmpvar_54;
  tmpvar_54 = mix (0.0, tmpvar_50, mix (clamp (((_FadeScale * sqrt(dot (p_51, p_51))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(normalize(xlv_TEXCOORD0).z), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((sqrt(dot (p_52, p_52)) - (1.2 * sqrt(dot (p_53, p_53)))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_54;
  lowp vec4 packednormal_55;
  packednormal_55 = normal_7;
  lowp vec3 normal_56;
  normal_56.xy = ((packednormal_55.wy * 2.0) - 1.0);
  normal_56.z = sqrt((1.0 - clamp (dot (normal_56.xy, normal_56.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_57;
  tmpvar_57 = mix (normal_56, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_57;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_58;
  tmpvar_58 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x;
  mediump vec3 lightDir_59;
  lightDir_59 = xlv_TEXCOORD5;
  mediump float atten_60;
  atten_60 = tmpvar_58;
  mediump vec4 c_61;
  mediump float tmpvar_62;
  tmpvar_62 = clamp (dot (tmpvar_4, lightDir_59), 0.0, 1.0);
  highp vec3 tmpvar_63;
  tmpvar_63 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_62 * atten_60) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_64;
  tmpvar_64 = (tmpvar_3 * tmpvar_63);
  c_61.xyz = tmpvar_64;
  c_61.w = tmpvar_5;
  c_1 = c_61;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD6));
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
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
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
#line 422
struct Input {
    highp vec3 nrm;
    highp vec3 viewDir;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
};
#line 485
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
    highp vec3 cust_nrm;
    highp vec3 cust_worldVert;
    highp vec3 cust_worldOrigin;
    highp float cust_viewDist;
    lowp vec3 lightDir;
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
#line 431
#line 452
#line 498
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 431
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 435
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    #line 439
    o.nrm = normalize(v.vertex.xyz);
}
#line 498
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 502
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.cust_worldVert = customInputData.worldVert;
    o.cust_worldOrigin = customInputData.worldOrigin;
    #line 506
    o.cust_viewDist = customInputData.viewDist;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 510
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 514
    o.viewDir = viewDirForLight;
    o.vlight = glstate_lightmodel_ambient.xyz;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 518
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp float xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out lowp vec3 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
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
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_nrm);
    xlv_TEXCOORD2 = vec3(xl_retval.cust_worldVert);
    xlv_TEXCOORD3 = vec3(xl_retval.cust_worldOrigin);
    xlv_TEXCOORD4 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD5 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD6 = vec3(xl_retval.vlight);
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
#line 422
struct Input {
    highp vec3 nrm;
    highp vec3 viewDir;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
};
#line 485
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
    highp vec3 cust_nrm;
    highp vec3 cust_worldVert;
    highp vec3 cust_worldOrigin;
    highp float cust_viewDist;
    lowp vec3 lightDir;
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
#line 431
#line 452
#line 498
#line 414
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    #line 417
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    return c;
}
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
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 452
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    #line 456
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 460
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((nrm.zy * _BumpScale) + _BumpOffset.xy));
    #line 464
    mediump vec4 normalY = texture( _BumpMap, ((nrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((nrm.xy * _BumpScale) + _BumpOffset.xy));
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    #line 468
    detail = mix( detail, detailY, vec4( nrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( nrm.x));
    normal = mix( normal, normalY, vec4( nrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 472
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Albedo = albedo;
    mediump float avg = min( main.w, mix( detail.w, 1.0, detailLevel));
    #line 476
    highp float rim = xll_saturate_f(abs(dot( normalize(IN.viewDir), o.Normal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.2 * distance( IN.worldVert, IN.worldOrigin))));
    #line 480
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    o.Alpha = mix( 0.0, avg, distAlpha);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 520
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 522
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    surfIN.worldVert = IN.cust_worldVert;
    surfIN.worldOrigin = IN.cust_worldOrigin;
    #line 526
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 530
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 534
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    #line 538
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp float xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in lowp vec3 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.cust_worldVert = vec3(xlv_TEXCOORD2);
    xlt_IN.cust_worldOrigin = vec3(xlv_TEXCOORD3);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD4);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD5);
    xlt_IN.vlight = vec3(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
attribute vec4 TANGENT;

uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec3 p_2;
  p_2 = (tmpvar_1 - _WorldSpaceCameraPos);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_3 = TANGENT.xyz;
  tmpvar_4 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_5;
  tmpvar_5[0].x = tmpvar_3.x;
  tmpvar_5[0].y = tmpvar_4.x;
  tmpvar_5[0].z = gl_Normal.x;
  tmpvar_5[1].x = tmpvar_3.y;
  tmpvar_5[1].y = tmpvar_4.y;
  tmpvar_5[1].z = gl_Normal.y;
  tmpvar_5[2].x = tmpvar_3.z;
  tmpvar_5[2].y = tmpvar_4.z;
  tmpvar_5[2].z = gl_Normal.z;
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (tmpvar_5 * (((_World2Object * tmpvar_6).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  xlv_TEXCOORD4 = sqrt(dot (p_2, p_2));
  xlv_TEXCOORD5 = (tmpvar_5 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD6 = gl_LightModel.ambient.xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _BumpScale;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _BumpOffset;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
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
  vec4 tmpvar_16;
  tmpvar_16 = (texture2DGradARB (_MainTex, uv_2, tmpvar_15.xy, tmpvar_15.zw) * _Color);
  vec3 tmpvar_17;
  tmpvar_17 = abs(xlv_TEXCOORD1);
  vec4 tmpvar_18;
  tmpvar_18 = mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_17.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_17.yyyy);
  float tmpvar_19;
  tmpvar_19 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD4), 0.0, 1.0);
  vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_16.xyz * mix (tmpvar_18.xyz, vec3(1.0, 1.0, 1.0), vec3(tmpvar_19)));
  vec3 p_21;
  p_21 = (xlv_TEXCOORD2 - _WorldSpaceCameraPos);
  vec3 p_22;
  p_22 = (xlv_TEXCOORD3 - _WorldSpaceCameraPos);
  vec3 p_23;
  p_23 = (xlv_TEXCOORD2 - xlv_TEXCOORD3);
  vec3 normal_24;
  normal_24.xy = ((mix (mix (texture2D (_BumpMap, ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy)), texture2D (_BumpMap, ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy)), tmpvar_17.xxxx), texture2D (_BumpMap, ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy)), tmpvar_17.yyyy).wy * 2.0) - 1.0);
  normal_24.z = sqrt((1.0 - clamp (dot (normal_24.xy, normal_24.xy), 0.0, 1.0)));
  vec4 c_25;
  c_25.xyz = (tmpvar_20 * clamp ((_MinLight + (_LightColor0.xyz * (clamp (dot (mix (normal_24, vec3(0.0, 0.0, 1.0), vec3(tmpvar_19)), xlv_TEXCOORD5), 0.0, 1.0) * 2.0))), 0.0, 1.0));
  c_25.w = mix (0.0, min (tmpvar_16.w, mix (tmpvar_18.w, 1.0, tmpvar_19)), mix (clamp (((_FadeScale * sqrt(dot (p_21, p_21))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(normalize(xlv_TEXCOORD0).z), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((sqrt(dot (p_22, p_22)) - (1.2 * sqrt(dot (p_23, p_23)))), 0.0, 1.0)));
  c_1.w = c_25.w;
  c_1.xyz = (c_25.xyz + (tmpvar_20 * xlv_TEXCOORD6));
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 15 [unity_Scale]
"vs_3_0
; 42 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c14, r0
mov r0, c9
dp4 r4.y, c14, r0
dp3 r0.w, v0, v0
rsq r0.w, r0.w
mov r1.w, c16.x
mov r1.xyz, c13
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
mov r1, c8
dp4 r4.x, c14, r1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
add r1.xyz, -r0, c13
dp3 r1.x, r1, r1
mul o2.xyz, r0.w, v0
rsq r0.w, r1.x
dp3 o1.y, r2, r3
dp3 o6.y, r3, r4
dp3 o1.z, v2, r2
dp3 o1.x, r2, v1
dp3 o6.z, v2, r4
dp3 o6.x, v1, r4
mov o3.xyz, r0
rcp o5.x, r0.w
mov o7.xyz, c12
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
mov o4.z, c6.w
mov o4.y, c5.w
mov o4.x, c4.w
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "UnityPerCamera" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 36 instructions, 2 temp regs, 0 temp arrays:
// ALU 32 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedndcpnfahkglnffbhicepphhldhiagmbfabaaaaaaemahaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaiahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
giafaaaaeaaaabaafkabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafjaaaaae
egiocaaaadaaaaaaafaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaaaaaaaaaaeaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
elaaaaaficcabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaaaaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaaaaaaaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
aaaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
abaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaabaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
aaaaaaaaegbcbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaaaaaaaaadgaaaaag
hccabaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
abaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
acaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaagaaaaaaegiccaaa
adaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_1.xyz;
  tmpvar_8 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_2.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_2.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_2.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (tmpvar_9 * (((_World2Object * tmpvar_11).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  xlv_TEXCOORD4 = sqrt(dot (p_6, p_6));
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
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
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = tmpvar_2;
  tmpvar_5 = 0.0;
  mediump float detailLevel_6;
  mediump vec4 normal_7;
  mediump vec4 detail_8;
  mediump vec4 normalZ_9;
  mediump vec4 normalY_10;
  mediump vec4 normalX_11;
  mediump vec4 detailZ_12;
  mediump vec4 detailY_13;
  mediump vec4 detailX_14;
  mediump vec4 main_15;
  highp vec2 uv_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_16.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD1.y);
  uv_16.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_16, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_15 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_14 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_13 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_12 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_11 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_10 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_9 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_12, detailX_14, tmpvar_43.xxxx);
  detail_8 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_8, detailY_13, tmpvar_43.yyyy);
  detail_8 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_9, normalX_11, tmpvar_43.xxxx);
  normal_7 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_7, normalY_10, tmpvar_43.yyyy);
  normal_7 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD4), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = min (main_15.w, mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD2 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD3 - _WorldSpaceCameraPos);
  highp vec3 p_53;
  p_53 = (xlv_TEXCOORD2 - xlv_TEXCOORD3);
  highp float tmpvar_54;
  tmpvar_54 = mix (0.0, tmpvar_50, mix (clamp (((_FadeScale * sqrt(dot (p_51, p_51))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(normalize(xlv_TEXCOORD0).z), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((sqrt(dot (p_52, p_52)) - (1.2 * sqrt(dot (p_53, p_53)))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_54;
  lowp vec3 tmpvar_55;
  lowp vec4 packednormal_56;
  packednormal_56 = normal_7;
  tmpvar_55 = ((packednormal_56.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_57;
  tmpvar_57 = mix (tmpvar_55, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_57;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_58;
  lightDir_58 = xlv_TEXCOORD5;
  mediump vec4 c_59;
  mediump float tmpvar_60;
  tmpvar_60 = clamp (dot (tmpvar_4, lightDir_58), 0.0, 1.0);
  highp vec3 tmpvar_61;
  tmpvar_61 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_60 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_62;
  tmpvar_62 = (tmpvar_3 * tmpvar_61);
  c_59.xyz = tmpvar_62;
  c_59.w = tmpvar_5;
  c_1 = c_59;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD6));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_1.xyz;
  tmpvar_8 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_2.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_2.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_2.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (tmpvar_9 * (((_World2Object * tmpvar_11).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  xlv_TEXCOORD4 = sqrt(dot (p_6, p_6));
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
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
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = tmpvar_2;
  tmpvar_5 = 0.0;
  mediump float detailLevel_6;
  mediump vec4 normal_7;
  mediump vec4 detail_8;
  mediump vec4 normalZ_9;
  mediump vec4 normalY_10;
  mediump vec4 normalX_11;
  mediump vec4 detailZ_12;
  mediump vec4 detailY_13;
  mediump vec4 detailX_14;
  mediump vec4 main_15;
  highp vec2 uv_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_16.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD1.y);
  uv_16.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_16, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_15 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_14 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_13 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_12 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_11 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_10 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_9 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_12, detailX_14, tmpvar_43.xxxx);
  detail_8 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_8, detailY_13, tmpvar_43.yyyy);
  detail_8 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_9, normalX_11, tmpvar_43.xxxx);
  normal_7 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_7, normalY_10, tmpvar_43.yyyy);
  normal_7 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD4), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = min (main_15.w, mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD2 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD3 - _WorldSpaceCameraPos);
  highp vec3 p_53;
  p_53 = (xlv_TEXCOORD2 - xlv_TEXCOORD3);
  highp float tmpvar_54;
  tmpvar_54 = mix (0.0, tmpvar_50, mix (clamp (((_FadeScale * sqrt(dot (p_51, p_51))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(normalize(xlv_TEXCOORD0).z), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((sqrt(dot (p_52, p_52)) - (1.2 * sqrt(dot (p_53, p_53)))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_54;
  lowp vec4 packednormal_55;
  packednormal_55 = normal_7;
  lowp vec3 normal_56;
  normal_56.xy = ((packednormal_55.wy * 2.0) - 1.0);
  normal_56.z = sqrt((1.0 - clamp (dot (normal_56.xy, normal_56.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_57;
  tmpvar_57 = mix (normal_56, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_57;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_58;
  lightDir_58 = xlv_TEXCOORD5;
  mediump vec4 c_59;
  mediump float tmpvar_60;
  tmpvar_60 = clamp (dot (tmpvar_4, lightDir_58), 0.0, 1.0);
  highp vec3 tmpvar_61;
  tmpvar_61 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_60 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_62;
  tmpvar_62 = (tmpvar_3 * tmpvar_61);
  c_59.xyz = tmpvar_62;
  c_59.w = tmpvar_5;
  c_1 = c_59;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD6));
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
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
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
#line 414
struct Input {
    highp vec3 nrm;
    highp vec3 viewDir;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
};
#line 477
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
    highp vec3 cust_nrm;
    highp vec3 cust_worldVert;
    highp vec3 cust_worldOrigin;
    highp float cust_viewDist;
    lowp vec3 lightDir;
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
#line 423
#line 444
#line 489
#line 510
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 423
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 427
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    #line 431
    o.nrm = normalize(v.vertex.xyz);
}
#line 489
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 493
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.cust_worldVert = customInputData.worldVert;
    o.cust_worldOrigin = customInputData.worldOrigin;
    #line 497
    o.cust_viewDist = customInputData.viewDist;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 501
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 505
    o.viewDir = viewDirForLight;
    o.vlight = glstate_lightmodel_ambient.xyz;
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp float xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out lowp vec3 xlv_TEXCOORD6;
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
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_nrm);
    xlv_TEXCOORD2 = vec3(xl_retval.cust_worldVert);
    xlv_TEXCOORD3 = vec3(xl_retval.cust_worldOrigin);
    xlv_TEXCOORD4 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD5 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD6 = vec3(xl_retval.vlight);
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
#line 414
struct Input {
    highp vec3 nrm;
    highp vec3 viewDir;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
};
#line 477
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
    highp vec3 cust_nrm;
    highp vec3 cust_worldVert;
    highp vec3 cust_worldOrigin;
    highp float cust_viewDist;
    lowp vec3 lightDir;
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
#line 423
#line 444
#line 489
#line 510
#line 406
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    #line 409
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    return c;
}
#line 433
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 435
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 439
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 444
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    #line 448
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 452
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((nrm.zy * _BumpScale) + _BumpOffset.xy));
    #line 456
    mediump vec4 normalY = texture( _BumpMap, ((nrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((nrm.xy * _BumpScale) + _BumpOffset.xy));
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    #line 460
    detail = mix( detail, detailY, vec4( nrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( nrm.x));
    normal = mix( normal, normalY, vec4( nrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 464
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Albedo = albedo;
    mediump float avg = min( main.w, mix( detail.w, 1.0, detailLevel));
    #line 468
    highp float rim = xll_saturate_f(abs(dot( normalize(IN.viewDir), o.Normal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.2 * distance( IN.worldVert, IN.worldOrigin))));
    #line 472
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    o.Alpha = mix( 0.0, avg, distAlpha);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 510
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    #line 514
    surfIN.worldVert = IN.cust_worldVert;
    surfIN.worldOrigin = IN.cust_worldOrigin;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.viewDir = IN.viewDir;
    #line 518
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 522
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = 1.0;
    #line 526
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp float xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in lowp vec3 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.cust_worldVert = vec3(xlv_TEXCOORD2);
    xlt_IN.cust_worldOrigin = vec3(xlv_TEXCOORD3);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD4);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD5);
    xlt_IN.vlight = vec3(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
attribute vec4 TANGENT;

uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec3 p_2;
  p_2 = (tmpvar_1 - _WorldSpaceCameraPos);
  vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  vec4 o_8;
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_3 * 0.5);
  vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (tmpvar_6 * (((_World2Object * tmpvar_7).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  xlv_TEXCOORD4 = sqrt(dot (p_2, p_2));
  xlv_TEXCOORD5 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD6 = gl_LightModel.ambient.xyz;
  xlv_TEXCOORD7 = o_8;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeScale;
uniform float _FadeDist;
uniform float _MinLight;
uniform float _BumpScale;
uniform float _DetailDist;
uniform float _DetailScale;
uniform float _FalloffScale;
uniform float _FalloffPow;
uniform vec4 _BumpOffset;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
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
  vec4 tmpvar_16;
  tmpvar_16 = (texture2DGradARB (_MainTex, uv_2, tmpvar_15.xy, tmpvar_15.zw) * _Color);
  vec3 tmpvar_17;
  tmpvar_17 = abs(xlv_TEXCOORD1);
  vec4 tmpvar_18;
  tmpvar_18 = mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_17.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_17.yyyy);
  float tmpvar_19;
  tmpvar_19 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD4), 0.0, 1.0);
  vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_16.xyz * mix (tmpvar_18.xyz, vec3(1.0, 1.0, 1.0), vec3(tmpvar_19)));
  vec3 p_21;
  p_21 = (xlv_TEXCOORD2 - _WorldSpaceCameraPos);
  vec3 p_22;
  p_22 = (xlv_TEXCOORD3 - _WorldSpaceCameraPos);
  vec3 p_23;
  p_23 = (xlv_TEXCOORD2 - xlv_TEXCOORD3);
  vec3 normal_24;
  normal_24.xy = ((mix (mix (texture2D (_BumpMap, ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy)), texture2D (_BumpMap, ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy)), tmpvar_17.xxxx), texture2D (_BumpMap, ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy)), tmpvar_17.yyyy).wy * 2.0) - 1.0);
  normal_24.z = sqrt((1.0 - clamp (dot (normal_24.xy, normal_24.xy), 0.0, 1.0)));
  vec4 c_25;
  c_25.xyz = (tmpvar_20 * clamp ((_MinLight + (_LightColor0.xyz * ((clamp (dot (mix (normal_24, vec3(0.0, 0.0, 1.0), vec3(tmpvar_19)), xlv_TEXCOORD5), 0.0, 1.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x) * 2.0))), 0.0, 1.0));
  c_25.w = mix (0.0, min (tmpvar_16.w, mix (tmpvar_18.w, 1.0, tmpvar_19)), mix (clamp (((_FadeScale * sqrt(dot (p_21, p_21))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(normalize(xlv_TEXCOORD0).z), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((sqrt(dot (p_22, p_22)) - (1.2 * sqrt(dot (p_23, p_23)))), 0.0, 1.0)));
  c_1.w = c_25.w;
  c_1.xyz = (c_25.xyz + (tmpvar_20 * xlv_TEXCOORD6));
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 16 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 17 [unity_Scale]
"vs_3_0
; 47 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c18, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c16, r0
mov r0, c9
dp4 r4.y, c16, r0
mov r1.w, c18.x
mov r1.xyz, c13
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov o0, r0
mov o8.zw, r0
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c17.w, -v0
mov r1, c8
dp4 r4.x, c16, r1
mul r1.xyz, r0.xyww, c18.y
mul r1.y, r1, c14.x
dp3 r0.w, v0, v0
rsq r0.w, r0.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mad o8.xy, r1.z, c15.zwzw, r1
add r1.xyz, -r0, c13
dp3 r1.x, r1, r1
mul o2.xyz, r0.w, v0
rsq r0.w, r1.x
dp3 o1.y, r2, r3
dp3 o6.y, r3, r4
dp3 o1.z, v2, r2
dp3 o1.x, r2, v1
dp3 o6.z, v2, r4
dp3 o6.x, v1, r4
mov o3.xyz, r0
rcp o5.x, r0.w
mov o7.xyz, c12
mov o4.z, c6.w
mov o4.y, c5.w
mov o4.x, c4.w
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "UnityPerCamera" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 41 instructions, 3 temp regs, 0 temp arrays:
// ALU 35 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddpkldkoofnhelmmhgcmfmngimdlilamhabaaaaaapmahaaaaadaaaaaa
cmaaaaaapeaaaaaapeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheopiaaaaaaajaaaaaa
aiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaiahaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaomaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcaaagaaaaeaaaabaa
iaabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafjaaaaaeegiocaaaadaaaaaa
afaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
aaaaaaaaaeaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaficcabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaaaaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaaaaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaaaaaaaaaaeaaaaaa
egacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
acaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaabaaaaaaegbcbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaabaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaaaaaaaaaegbcbaaa
aaaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaa
acaaaaaapgapbaaaabaaaaaaegbcbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaa
egiccaaaacaaaaaaapaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaa
aaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaabdaaaaaa
pgipcaaaabaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaaafaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaadgaaaaaghccabaaaagaaaaaaegiccaaaadaaaaaaaeaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaahaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaahaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_1.xyz;
  tmpvar_8 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_2.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_2.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_2.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (tmpvar_9 * (((_World2Object * tmpvar_11).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  xlv_TEXCOORD4 = sqrt(dot (p_6, p_6));
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
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
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = tmpvar_2;
  tmpvar_5 = 0.0;
  mediump float detailLevel_6;
  mediump vec4 normal_7;
  mediump vec4 detail_8;
  mediump vec4 normalZ_9;
  mediump vec4 normalY_10;
  mediump vec4 normalX_11;
  mediump vec4 detailZ_12;
  mediump vec4 detailY_13;
  mediump vec4 detailX_14;
  mediump vec4 main_15;
  highp vec2 uv_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_16.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD1.y);
  uv_16.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_16, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_15 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_14 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_13 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_12 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_11 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_10 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_9 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_12, detailX_14, tmpvar_43.xxxx);
  detail_8 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_8, detailY_13, tmpvar_43.yyyy);
  detail_8 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_9, normalX_11, tmpvar_43.xxxx);
  normal_7 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_7, normalY_10, tmpvar_43.yyyy);
  normal_7 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD4), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = min (main_15.w, mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD2 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD3 - _WorldSpaceCameraPos);
  highp vec3 p_53;
  p_53 = (xlv_TEXCOORD2 - xlv_TEXCOORD3);
  highp float tmpvar_54;
  tmpvar_54 = mix (0.0, tmpvar_50, mix (clamp (((_FadeScale * sqrt(dot (p_51, p_51))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(normalize(xlv_TEXCOORD0).z), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((sqrt(dot (p_52, p_52)) - (1.2 * sqrt(dot (p_53, p_53)))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_54;
  lowp vec3 tmpvar_55;
  lowp vec4 packednormal_56;
  packednormal_56 = normal_7;
  tmpvar_55 = ((packednormal_56.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_57;
  tmpvar_57 = mix (tmpvar_55, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_57;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_58;
  mediump float lightShadowDataX_59;
  highp float dist_60;
  lowp float tmpvar_61;
  tmpvar_61 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x;
  dist_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = _LightShadowData.x;
  lightShadowDataX_59 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = max (float((dist_60 > (xlv_TEXCOORD7.z / xlv_TEXCOORD7.w))), lightShadowDataX_59);
  tmpvar_58 = tmpvar_63;
  mediump vec3 lightDir_64;
  lightDir_64 = xlv_TEXCOORD5;
  mediump float atten_65;
  atten_65 = tmpvar_58;
  mediump vec4 c_66;
  mediump float tmpvar_67;
  tmpvar_67 = clamp (dot (tmpvar_4, lightDir_64), 0.0, 1.0);
  highp vec3 tmpvar_68;
  tmpvar_68 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_67 * atten_65) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_69;
  tmpvar_69 = (tmpvar_3 * tmpvar_68);
  c_66.xyz = tmpvar_69;
  c_66.w = tmpvar_5;
  c_1 = c_66;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD6));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_13;
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = (tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  xlv_TEXCOORD4 = sqrt(dot (p_6, p_6));
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = o_14;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
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
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = tmpvar_2;
  tmpvar_5 = 0.0;
  mediump float detailLevel_6;
  mediump vec4 normal_7;
  mediump vec4 detail_8;
  mediump vec4 normalZ_9;
  mediump vec4 normalY_10;
  mediump vec4 normalX_11;
  mediump vec4 detailZ_12;
  mediump vec4 detailY_13;
  mediump vec4 detailX_14;
  mediump vec4 main_15;
  highp vec2 uv_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_16.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD1.y);
  uv_16.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_16, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_15 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_14 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_13 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_12 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_11 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_10 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_9 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_12, detailX_14, tmpvar_43.xxxx);
  detail_8 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_8, detailY_13, tmpvar_43.yyyy);
  detail_8 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_9, normalX_11, tmpvar_43.xxxx);
  normal_7 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_7, normalY_10, tmpvar_43.yyyy);
  normal_7 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD4), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = min (main_15.w, mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD2 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD3 - _WorldSpaceCameraPos);
  highp vec3 p_53;
  p_53 = (xlv_TEXCOORD2 - xlv_TEXCOORD3);
  highp float tmpvar_54;
  tmpvar_54 = mix (0.0, tmpvar_50, mix (clamp (((_FadeScale * sqrt(dot (p_51, p_51))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(normalize(xlv_TEXCOORD0).z), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((sqrt(dot (p_52, p_52)) - (1.2 * sqrt(dot (p_53, p_53)))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_54;
  lowp vec4 packednormal_55;
  packednormal_55 = normal_7;
  lowp vec3 normal_56;
  normal_56.xy = ((packednormal_55.wy * 2.0) - 1.0);
  normal_56.z = sqrt((1.0 - clamp (dot (normal_56.xy, normal_56.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_57;
  tmpvar_57 = mix (normal_56, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_57;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_58;
  tmpvar_58 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x;
  mediump vec3 lightDir_59;
  lightDir_59 = xlv_TEXCOORD5;
  mediump float atten_60;
  atten_60 = tmpvar_58;
  mediump vec4 c_61;
  mediump float tmpvar_62;
  tmpvar_62 = clamp (dot (tmpvar_4, lightDir_59), 0.0, 1.0);
  highp vec3 tmpvar_63;
  tmpvar_63 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_62 * atten_60) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_64;
  tmpvar_64 = (tmpvar_3 * tmpvar_63);
  c_61.xyz = tmpvar_64;
  c_61.w = tmpvar_5;
  c_1 = c_61;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD6));
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
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
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
#line 422
struct Input {
    highp vec3 nrm;
    highp vec3 viewDir;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
};
#line 485
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
    highp vec3 cust_nrm;
    highp vec3 cust_worldVert;
    highp vec3 cust_worldOrigin;
    highp float cust_viewDist;
    lowp vec3 lightDir;
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
#line 431
#line 452
#line 498
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 431
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 435
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    #line 439
    o.nrm = normalize(v.vertex.xyz);
}
#line 498
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 502
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.cust_worldVert = customInputData.worldVert;
    o.cust_worldOrigin = customInputData.worldOrigin;
    #line 506
    o.cust_viewDist = customInputData.viewDist;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 510
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 514
    o.viewDir = viewDirForLight;
    o.vlight = glstate_lightmodel_ambient.xyz;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 518
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp float xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out lowp vec3 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
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
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_nrm);
    xlv_TEXCOORD2 = vec3(xl_retval.cust_worldVert);
    xlv_TEXCOORD3 = vec3(xl_retval.cust_worldOrigin);
    xlv_TEXCOORD4 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD5 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD6 = vec3(xl_retval.vlight);
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
#line 422
struct Input {
    highp vec3 nrm;
    highp vec3 viewDir;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
};
#line 485
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
    highp vec3 cust_nrm;
    highp vec3 cust_worldVert;
    highp vec3 cust_worldOrigin;
    highp float cust_viewDist;
    lowp vec3 lightDir;
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
#line 431
#line 452
#line 498
#line 414
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    #line 417
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    return c;
}
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
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 452
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    #line 456
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 460
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((nrm.zy * _BumpScale) + _BumpOffset.xy));
    #line 464
    mediump vec4 normalY = texture( _BumpMap, ((nrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((nrm.xy * _BumpScale) + _BumpOffset.xy));
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    #line 468
    detail = mix( detail, detailY, vec4( nrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( nrm.x));
    normal = mix( normal, normalY, vec4( nrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 472
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Albedo = albedo;
    mediump float avg = min( main.w, mix( detail.w, 1.0, detailLevel));
    #line 476
    highp float rim = xll_saturate_f(abs(dot( normalize(IN.viewDir), o.Normal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.2 * distance( IN.worldVert, IN.worldOrigin))));
    #line 480
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    o.Alpha = mix( 0.0, avg, distAlpha);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 520
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 522
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    surfIN.worldVert = IN.cust_worldVert;
    surfIN.worldOrigin = IN.cust_worldOrigin;
    #line 526
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 530
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 534
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    #line 538
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp float xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in lowp vec3 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.cust_worldVert = vec3(xlv_TEXCOORD2);
    xlt_IN.cust_worldOrigin = vec3(xlv_TEXCOORD3);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD4);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD5);
    xlt_IN.vlight = vec3(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
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
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_1.xyz;
  tmpvar_8 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_2.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_2.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_2.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (tmpvar_9 * (((_World2Object * tmpvar_11).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  xlv_TEXCOORD4 = sqrt(dot (p_6, p_6));
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
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
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = tmpvar_2;
  tmpvar_5 = 0.0;
  mediump float detailLevel_6;
  mediump vec4 normal_7;
  mediump vec4 detail_8;
  mediump vec4 normalZ_9;
  mediump vec4 normalY_10;
  mediump vec4 normalX_11;
  mediump vec4 detailZ_12;
  mediump vec4 detailY_13;
  mediump vec4 detailX_14;
  mediump vec4 main_15;
  highp vec2 uv_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_16.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD1.y);
  uv_16.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_16, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_15 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_14 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_13 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_12 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_11 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_10 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_9 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_12, detailX_14, tmpvar_43.xxxx);
  detail_8 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_8, detailY_13, tmpvar_43.yyyy);
  detail_8 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_9, normalX_11, tmpvar_43.xxxx);
  normal_7 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_7, normalY_10, tmpvar_43.yyyy);
  normal_7 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD4), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = min (main_15.w, mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD2 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD3 - _WorldSpaceCameraPos);
  highp vec3 p_53;
  p_53 = (xlv_TEXCOORD2 - xlv_TEXCOORD3);
  highp float tmpvar_54;
  tmpvar_54 = mix (0.0, tmpvar_50, mix (clamp (((_FadeScale * sqrt(dot (p_51, p_51))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(normalize(xlv_TEXCOORD0).z), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((sqrt(dot (p_52, p_52)) - (1.2 * sqrt(dot (p_53, p_53)))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_54;
  lowp vec3 tmpvar_55;
  lowp vec4 packednormal_56;
  packednormal_56 = normal_7;
  tmpvar_55 = ((packednormal_56.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_57;
  tmpvar_57 = mix (tmpvar_55, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_57;
  tmpvar_2 = tmpvar_4;
  lowp float shadow_58;
  lowp float tmpvar_59;
  tmpvar_59 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD7.xyz);
  highp float tmpvar_60;
  tmpvar_60 = (_LightShadowData.x + (tmpvar_59 * (1.0 - _LightShadowData.x)));
  shadow_58 = tmpvar_60;
  mediump vec3 lightDir_61;
  lightDir_61 = xlv_TEXCOORD5;
  mediump float atten_62;
  atten_62 = shadow_58;
  mediump vec4 c_63;
  mediump float tmpvar_64;
  tmpvar_64 = clamp (dot (tmpvar_4, lightDir_61), 0.0, 1.0);
  highp vec3 tmpvar_65;
  tmpvar_65 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_64 * atten_62) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_66;
  tmpvar_66 = (tmpvar_3 * tmpvar_65);
  c_63.xyz = tmpvar_66;
  c_63.w = tmpvar_5;
  c_1 = c_63;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD6));
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
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
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
#line 422
struct Input {
    highp vec3 nrm;
    highp vec3 viewDir;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
};
#line 485
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
    highp vec3 cust_nrm;
    highp vec3 cust_worldVert;
    highp vec3 cust_worldOrigin;
    highp float cust_viewDist;
    lowp vec3 lightDir;
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
#line 431
#line 452
#line 498
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 431
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 435
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    #line 439
    o.nrm = normalize(v.vertex.xyz);
}
#line 498
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 502
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.cust_worldVert = customInputData.worldVert;
    o.cust_worldOrigin = customInputData.worldOrigin;
    #line 506
    o.cust_viewDist = customInputData.viewDist;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 510
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 514
    o.viewDir = viewDirForLight;
    o.vlight = glstate_lightmodel_ambient.xyz;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 518
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp float xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out lowp vec3 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
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
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_nrm);
    xlv_TEXCOORD2 = vec3(xl_retval.cust_worldVert);
    xlv_TEXCOORD3 = vec3(xl_retval.cust_worldOrigin);
    xlv_TEXCOORD4 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD5 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD6 = vec3(xl_retval.vlight);
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
#line 422
struct Input {
    highp vec3 nrm;
    highp vec3 viewDir;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
};
#line 485
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
    highp vec3 cust_nrm;
    highp vec3 cust_worldVert;
    highp vec3 cust_worldOrigin;
    highp float cust_viewDist;
    lowp vec3 lightDir;
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
#line 431
#line 452
#line 498
#line 414
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    #line 417
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    return c;
}
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
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 452
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    #line 456
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 460
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((nrm.zy * _BumpScale) + _BumpOffset.xy));
    #line 464
    mediump vec4 normalY = texture( _BumpMap, ((nrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((nrm.xy * _BumpScale) + _BumpOffset.xy));
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    #line 468
    detail = mix( detail, detailY, vec4( nrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( nrm.x));
    normal = mix( normal, normalY, vec4( nrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 472
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Albedo = albedo;
    mediump float avg = min( main.w, mix( detail.w, 1.0, detailLevel));
    #line 476
    highp float rim = xll_saturate_f(abs(dot( normalize(IN.viewDir), o.Normal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.2 * distance( IN.worldVert, IN.worldOrigin))));
    #line 480
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    o.Alpha = mix( 0.0, avg, distAlpha);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 520
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 522
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    surfIN.worldVert = IN.cust_worldVert;
    surfIN.worldOrigin = IN.cust_worldOrigin;
    #line 526
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 530
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 534
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    #line 538
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp float xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in lowp vec3 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.cust_worldVert = vec3(xlv_TEXCOORD2);
    xlt_IN.cust_worldOrigin = vec3(xlv_TEXCOORD3);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD4);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD5);
    xlt_IN.vlight = vec3(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
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
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_1.xyz;
  tmpvar_8 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_2.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_2.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_2.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (tmpvar_9 * (((_World2Object * tmpvar_11).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  xlv_TEXCOORD4 = sqrt(dot (p_6, p_6));
  xlv_TEXCOORD5 = tmpvar_3;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
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
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = tmpvar_2;
  tmpvar_5 = 0.0;
  mediump float detailLevel_6;
  mediump vec4 normal_7;
  mediump vec4 detail_8;
  mediump vec4 normalZ_9;
  mediump vec4 normalY_10;
  mediump vec4 normalX_11;
  mediump vec4 detailZ_12;
  mediump vec4 detailY_13;
  mediump vec4 detailX_14;
  mediump vec4 main_15;
  highp vec2 uv_16;
  highp float r_17;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_18;
    y_over_x_18 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_19;
    highp float x_20;
    x_20 = (y_over_x_18 * inversesqrt(((y_over_x_18 * y_over_x_18) + 1.0)));
    s_19 = (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))));
    r_17 = s_19;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_17 = (s_19 + 3.14159);
      } else {
        r_17 = (r_17 - 3.14159);
      };
    };
  } else {
    r_17 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_16.x = (0.5 + (0.159155 * r_17));
  highp float x_21;
  x_21 = -(xlv_TEXCOORD1.y);
  uv_16.y = (0.31831 * (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))));
  highp float r_22;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_23;
    y_over_x_23 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_24;
    highp float x_25;
    x_25 = (y_over_x_23 * inversesqrt(((y_over_x_23 * y_over_x_23) + 1.0)));
    s_24 = (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))));
    r_22 = s_24;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_22 = (s_24 + 3.14159);
      } else {
        r_22 = (r_22 - 3.14159);
      };
    };
  } else {
    r_22 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_26;
  tmpvar_26 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_29;
  tmpvar_29.x = (0.159155 * sqrt(dot (tmpvar_27, tmpvar_27)));
  tmpvar_29.y = dFdx(tmpvar_26);
  tmpvar_29.z = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_29.w = dFdy(tmpvar_26);
  lowp vec4 tmpvar_30;
  tmpvar_30 = (texture2DGradEXT (_MainTex, uv_16, tmpvar_29.xy, tmpvar_29.zw) * _Color);
  main_15 = tmpvar_30;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_31 = texture2D (_DetailTex, P_32);
  detailX_14 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_33 = texture2D (_DetailTex, P_34);
  detailY_13 = tmpvar_33;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_35 = texture2D (_DetailTex, P_36);
  detailZ_12 = tmpvar_35;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_37 = texture2D (_BumpMap, P_38);
  normalX_11 = tmpvar_37;
  lowp vec4 tmpvar_39;
  highp vec2 P_40;
  P_40 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_39 = texture2D (_BumpMap, P_40);
  normalY_10 = tmpvar_39;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_41 = texture2D (_BumpMap, P_42);
  normalZ_9 = tmpvar_41;
  highp vec3 tmpvar_43;
  tmpvar_43 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (detailZ_12, detailX_14, tmpvar_43.xxxx);
  detail_8 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detail_8, detailY_13, tmpvar_43.yyyy);
  detail_8 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (normalZ_9, normalX_11, tmpvar_43.xxxx);
  normal_7 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normal_7, normalY_10, tmpvar_43.yyyy);
  normal_7 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD4), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = min (main_15.w, mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD2 - _WorldSpaceCameraPos);
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD3 - _WorldSpaceCameraPos);
  highp vec3 p_53;
  p_53 = (xlv_TEXCOORD2 - xlv_TEXCOORD3);
  highp float tmpvar_54;
  tmpvar_54 = mix (0.0, tmpvar_50, mix (clamp (((_FadeScale * sqrt(dot (p_51, p_51))) - _FadeDist), 0.0, 1.0), clamp (pow ((_FalloffScale * clamp (abs(normalize(xlv_TEXCOORD0).z), 0.0, 1.0)), _FalloffPow), 0.0, 1.0), clamp ((sqrt(dot (p_52, p_52)) - (1.2 * sqrt(dot (p_53, p_53)))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_54;
  lowp vec3 tmpvar_55;
  lowp vec4 packednormal_56;
  packednormal_56 = normal_7;
  tmpvar_55 = ((packednormal_56.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_57;
  tmpvar_57 = mix (tmpvar_55, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_57;
  tmpvar_2 = tmpvar_4;
  lowp float shadow_58;
  lowp float tmpvar_59;
  tmpvar_59 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD7.xyz);
  highp float tmpvar_60;
  tmpvar_60 = (_LightShadowData.x + (tmpvar_59 * (1.0 - _LightShadowData.x)));
  shadow_58 = tmpvar_60;
  mediump vec3 lightDir_61;
  lightDir_61 = xlv_TEXCOORD5;
  mediump float atten_62;
  atten_62 = shadow_58;
  mediump vec4 c_63;
  mediump float tmpvar_64;
  tmpvar_64 = clamp (dot (tmpvar_4, lightDir_61), 0.0, 1.0);
  highp vec3 tmpvar_65;
  tmpvar_65 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_64 * atten_62) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_66;
  tmpvar_66 = (tmpvar_3 * tmpvar_65);
  c_63.xyz = tmpvar_66;
  c_63.w = tmpvar_5;
  c_1 = c_63;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD6));
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
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
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
#line 422
struct Input {
    highp vec3 nrm;
    highp vec3 viewDir;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
};
#line 485
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
    highp vec3 cust_nrm;
    highp vec3 cust_worldVert;
    highp vec3 cust_worldOrigin;
    highp float cust_viewDist;
    lowp vec3 lightDir;
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
#line 431
#line 452
#line 498
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 431
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 435
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.worldVert = vertexPos;
    o.worldOrigin = origin;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    #line 439
    o.nrm = normalize(v.vertex.xyz);
}
#line 498
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 502
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.cust_worldVert = customInputData.worldVert;
    o.cust_worldOrigin = customInputData.worldOrigin;
    #line 506
    o.cust_viewDist = customInputData.viewDist;
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 510
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 514
    o.viewDir = viewDirForLight;
    o.vlight = glstate_lightmodel_ambient.xyz;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 518
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp float xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out lowp vec3 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
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
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_nrm);
    xlv_TEXCOORD2 = vec3(xl_retval.cust_worldVert);
    xlv_TEXCOORD3 = vec3(xl_retval.cust_worldOrigin);
    xlv_TEXCOORD4 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD5 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD6 = vec3(xl_retval.vlight);
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
#line 422
struct Input {
    highp vec3 nrm;
    highp vec3 viewDir;
    highp vec3 worldVert;
    highp vec3 worldOrigin;
    highp float viewDist;
};
#line 485
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
    highp vec3 cust_nrm;
    highp vec3 cust_worldVert;
    highp vec3 cust_worldOrigin;
    highp float cust_viewDist;
    lowp vec3 lightDir;
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
#line 431
#line 452
#line 498
#line 414
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    #line 417
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    return c;
}
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
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 452
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    #line 456
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 460
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((nrm.zy * _BumpScale) + _BumpOffset.xy));
    #line 464
    mediump vec4 normalY = texture( _BumpMap, ((nrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((nrm.xy * _BumpScale) + _BumpOffset.xy));
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    #line 468
    detail = mix( detail, detailY, vec4( nrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( nrm.x));
    normal = mix( normal, normalY, vec4( nrm.y));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    #line 472
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Albedo = albedo;
    mediump float avg = min( main.w, mix( detail.w, 1.0, detailLevel));
    #line 476
    highp float rim = xll_saturate_f(abs(dot( normalize(IN.viewDir), o.Normal)));
    rim = xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow));
    highp float dist = distance( IN.worldVert, _WorldSpaceCameraPos);
    highp float distLerp = xll_saturate_f((distance( IN.worldOrigin, _WorldSpaceCameraPos) - (1.2 * distance( IN.worldVert, IN.worldOrigin))));
    #line 480
    highp float distFade = xll_saturate_f(((_FadeScale * dist) - _FadeDist));
    highp float distAlpha = mix( distFade, rim, distLerp);
    o.Alpha = mix( 0.0, avg, distAlpha);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 520
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 522
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    surfIN.worldVert = IN.cust_worldVert;
    surfIN.worldOrigin = IN.cust_worldOrigin;
    #line 526
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 530
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 534
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    #line 538
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp float xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in lowp vec3 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.cust_worldVert = vec3(xlv_TEXCOORD2);
    xlt_IN.cust_worldOrigin = vec3(xlv_TEXCOORD3);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD4);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD5);
    xlt_IN.vlight = vec3(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 2
//   d3d9 - ALU: 133 to 134, TEX: 9 to 10
//   d3d11 - ALU: 98 to 99, TEX: 6 to 7, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_DetailOffset]
Vector 4 [_BumpOffset]
Float 5 [_FalloffPow]
Float 6 [_FalloffScale]
Float 7 [_DetailScale]
Float 8 [_DetailDist]
Float 9 [_BumpScale]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_BumpMap] 2D
"ps_3_0
; 133 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c18, 1.20000005, 0, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.x
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
mul r0.xy, v1.zyzw, c7.x
add r1.xy, r0, c3
mul r0.zw, v1.xyxy, c7.x
mul r2.xy, v1.zxzw, c7.x
add r3.xy, r2, c3
add r0.xy, r0.zwzw, c3
abs r2.xy, v1
texld r0, r0, s1
texld r1, r1, s1
add_pp r1, r1, -r0
mad_pp r0, r2.x, r1, r0
texld r1, r3, s1
add_pp r1, r1, -r0
mad_pp r1, r2.y, r1, r0
mul r0.zw, v1.xyzy, c9.x
add r4.xy, r0.zwzw, c4
mul r0.xy, v1, c9.x
add r0.xy, r0, c4
texld r0.yw, r0, s2
texld r4.yw, r4, s2
add_pp r2.zw, r4.xyyw, -r0.xyyw
mad_pp r2.zw, r2.x, r2, r0.xyyw
abs r0.w, v1.z
mul r0.x, v4, c8
mul_sat r3.w, r0.x, c14
add_pp r3.xyz, -r1, c13.y
mul r0.xy, v1.zxzw, c9.x
add r0.xy, r0, c4
texld r4.yw, r0, s2
add_pp r0.xy, r4.ywzw, -r2.zwzw
mad_pp r0.xy, r2.y, r0, r2.zwzw
mad_pp r0.xy, r0.yxzw, c17.z, c17.w
mul_pp r2.zw, r0.xyxy, r0.xyxy
add_pp_sat r2.z, r2, r2.w
add_pp r2.z, -r2, c13.y
dsy r4.xy, v1
mad_pp r1.xyz, r3.w, r3, r1
max r0.z, r0.w, r2.x
rcp r3.x, r0.z
min r0.z, r0.w, r2.x
mul r3.x, r0.z, r3
mul r0.z, r3.x, r3.x
mad r2.y, r0.z, c15, c15.z
mad r2.y, r2, r0.z, c15.w
mad r2.y, r2, r0.z, c16.x
mad r2.y, r2, r0.z, c16
mad r2.y, r2, r0.z, c16.z
rsq_pp r2.z, r2.z
mul r2.y, r2, r3.x
rcp_pp r0.z, r2.z
add_pp r3.xyz, -r0, c13.xxyw
mad_pp r0.xyz, r3.w, r3, r0
dp3_pp_sat r0.x, r0, v5
mul_pp r0.xyz, r0.x, c1
add r2.z, -r2.y, c16.w
add r2.x, r0.w, -r2
cmp r2.x, -r2, r2.y, r2.z
add r2.y, -r2.x, c13.z
cmp r2.x, v1, r2, r2.y
cmp r2.w, v1.z, r2.x, -r2.x
mul_pp r2.xyz, r0, c14.w
add r0.y, -r0.w, c13
mad r0.x, r0.w, c14, c14.y
mad r0.x, r0.w, r0, c13.w
mad r0.x, r0.w, r0, c14.z
abs r0.w, -v1.y
mad r3.x, r2.w, c17, c17.y
add r3.y, -r0.w, c13
mad r2.w, r0, c14.x, c14.y
mad r2.w, r2, r0, c13
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.y, r0.x, r0
cmp r0.x, v1.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
rsq r3.y, r3.y
mad r0.w, r2, r0, c14.z
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v1.y, c13.x, c13.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c14.w, r2.w
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.xz, v1.xyyw
mul r4.zw, r0.xyxz, r0.xyxz
dsx r0.w, r0.y
mul r4.xy, r4, r4
add r0.x, r4.z, r4.w
add r0.z, r4.x, r4.y
rsq r0.z, r0.z
rsq r0.x, r0.x
rcp r0.x, r0.x
rcp r2.w, r0.z
mul r0.z, r0.x, c17.x
add_sat r2.xyz, r2, c10.x
dsy r0.y, r0
mul r0.x, r2.w, c17
texldd r0, r3, s0, r0.zwzw, r0
mul r0, r0, c2
mul_pp r0.xyz, r0, r1
mul r1.xyz, r0, r2
mad_pp oC0.xyz, r0, v6, r1
add_pp r2.x, -r1.w, c13.y
mad_pp r0.y, r3.w, r2.x, r1.w
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul r0.x, r0, v0.z
add r1.xyz, -v2, c0
min_pp r1.w, r0, r0.y
dp3 r0.y, r1, r1
abs_sat r0.x, r0
rsq r0.y, r0.y
mul r1.x, r0, c6
rcp r1.y, r0.y
pow_sat r0, r1.x, c5.x
mul r0.y, r1, c12.x
add_sat r0.w, r0.y, -c11.x
add r2.x, r0, -r0.w
add r0.xyz, -v3, c0
dp3 r0.y, r0, r0
mov r1.xyz, v2
add r1.xyz, v3, -r1
dp3 r0.x, r1, r1
rsq r0.y, r0.y
rsq r0.x, r0.x
rcp r0.y, r0.y
rcp r0.x, r0.x
mad_sat r0.x, -r0, c18, r0.y
mad r0.x, r0, r2, r0.w
mul_pp oC0.w, r0.x, r1
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 144 // 128 used size, 15 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Vector 64 [_DetailOffset] 4
Vector 80 [_BumpOffset] 4
Float 96 [_FalloffPow]
Float 100 [_FalloffScale]
Float 104 [_DetailScale]
Float 108 [_DetailDist]
Float 112 [_BumpScale]
Float 116 [_MinLight]
Float 120 [_FadeDist]
Float 124 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
// 107 instructions, 6 temp regs, 0 temp arrays:
// ALU 94 float, 0 int, 4 uint
// TEX 6 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedobcjmgjlbdiohcieacjglnegnieckginabaaaaaaambaaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefclmaoaaaaeaaaaaaakpadaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaadeaaaaajbcaabaaaaaaaaaaa
akbabaiaibaaaaaaacaaaaaackbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
ddaaaaajccaabaaaaaaaaaaaakbabaiaibaaaaaaacaaaaaackbabaiaibaaaaaa
acaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
ochgdidodcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaaaaaaaaaaakbabaiaibaaaaaa
acaaaaaackbabaiaibaaaaaaacaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaaagbcbaaa
acaaaaaaagbcbaiaebaaaaaaacaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaddaaaaahccaabaaaaaaaaaaaakbabaaaacaaaaaackbabaaa
acaaaaaadbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadeaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaackbabaaaacaaaaaa
bnaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaak
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdo
abeaaaaaaaaaaadpalaaaaafdcaabaaaabaaaaaaegbabaaaacaaaaaaapaaaaah
icaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaabaaaaaaagbebaaaacaaaaaaapaaaaah
icaabaaaaaaaaaaaogakbaaaabaaaaaaogakbaaaabaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaa
abeaaaaaidpjccdodbaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaacaaaaaa
bkbabaaaacaaaaaadcaaaabamcaabaaaabaaaaaafgbjbaiaibaaaaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaadagojjlmdagojjlmaceaaaaaaaaaaaaaaaaaaaaa
chbgjidnchbgjidndcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaafgbjbaia
ibaaaaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaiedefjloiedefjlodcaaaaan
mcaabaaaabaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaakeanmjdpkeanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaia
mbaaaaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaaf
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
acaaaaaakgikcaaaaaaaaaaaagaaaaaaegiecaaaaaaaaaaaaeaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaldcaabaaaadaaaaaaegbabaaaacaaaaaakgikcaaaaaaaaaaa
agaaaaaaegiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaa
agbabaiaibaaaaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaak
pcaabaaaabaaaaaafgbfbaiaibaaaaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaaaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaaaaaaajbcaabaaaadaaaaaadkiacaaa
aaaaaaaaagaaaaaadkiacaaaaaaaaaaaagaaaaaadicaaaahbcaabaaaadaaaaaa
akaabaaaadaaaaaadkbabaaaabaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaa
adaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaaaaaaaaa
egbcbaaaagaaaaaadcaaaaalpcaabaaaacaaaaaaggbcbaaaacaaaaaaagiacaaa
aaaaaaaaahaaaaaaegiecaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaal
fcaabaaaacaaaaaaagbbbaaaacaaaaaaagiacaaaaaaaaaaaahaaaaaaagibcaaa
aaaaaaaaafaaaaaaefaaaaajpcaabaaaafaaaaaaigaabaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaaaaaaaaaifcaabaaaacaaaaaapganbaaaaeaaaaaa
pganbaiaebaaaaaaafaaaaaadcaaaaakfcaabaaaacaaaaaaagbabaiaibaaaaaa
acaaaaaaagacbaaaacaaaaaapganbaaaafaaaaaaaaaaaaaikcaabaaaacaaaaaa
agaibaiaebaaaaaaacaaaaaapgahbaaaacaaaaaadcaaaaakdcaabaaaacaaaaaa
fgbfbaiaibaaaaaaacaaaaaangafbaaaacaaaaaaigaabaaaacaaaaaadcaaaaap
dcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
abaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaa
abaaaaaaaaaaaaalocaabaaaadaaaaaaagajbaiaebaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdcaaaaajhcaabaaaacaaaaaaagaabaaa
adaaaaaajgahbaaaadaaaaaaegacbaaaacaaaaaabacaaaahicaabaaaabaaaaaa
egacbaaaacaaaaaaegbcbaaaafaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaabaaaaaadccaaaalhcaabaaaacaaaaaaegiccaaaaaaaaaaa
abaaaaaapgapbaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaadcaaaaajhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaai
hcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaiaebaaaaaaaeaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafdcaabaaa
aaaaaaaaegaabaaaaaaaaaaadccaaaakbcaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaajkjjjjdpakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaa
egbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackbabaaaabaaaaaa
ddaaaaaiccaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaaagaaaaaa
cpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaaaaaaaaaagaaaaaabjaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaddaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaajhcaabaaaabaaaaaaegbcbaaaadaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadccaaaamecaabaaa
aaaaaaaadkiacaaaaaaaaaaaahaaaaaackaabaaaaaaaaaaackiacaiaebaaaaaa
aaaaaaaaahaaaaaaaaaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaadoaaaaab"
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
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_DetailOffset]
Vector 4 [_BumpOffset]
Float 5 [_FalloffPow]
Float 6 [_FalloffScale]
Float 7 [_DetailScale]
Float 8 [_DetailDist]
Float 9 [_BumpScale]
Float 10 [_MinLight]
Float 11 [_FadeDist]
Float 12 [_FadeScale]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"ps_3_0
; 134 ALU, 10 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c13, 0.00000000, 1.00000000, 3.14159298, -0.21211439
def c14, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, 2.00000000, -1.00000000
def c18, 1.20000005, 0, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.x
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
dcl_texcoord7 v7
mul r0.zw, v1.xyxy, c7.x
add r1.xy, r0.zwzw, c3
mul r0.xy, v1.zyzw, c7.x
add r0.xy, r0, c3
mul r3.xy, v1.zxzw, c7.x
texld r0, r0, s1
texld r1, r1, s1
add_pp r2, r0, -r1
abs r0.xy, v1
mad_pp r1, r0.x, r2, r1
add r3.xy, r3, c3
texld r2, r3, s1
add_pp r2, r2, -r1
mad_pp r2, r0.y, r2, r1
mul r0.z, v4.x, c8.x
mul_sat r1.w, r0.z, c14
add_pp r1.xyz, -r2, c13.y
mad_pp r1.xyz, r1.w, r1, r2
mul r0.zw, v1.xyzy, c9.x
add r4.xy, r0.zwzw, c4
mul r2.xy, v1.zxzw, c9.x
mul r3.xy, v1, c9.x
add r3.xy, r3, c4
texld r3.yw, r3, s2
texld r4.yw, r4, s2
add_pp r0.zw, r4.xyyw, -r3.xyyw
mad_pp r3.xy, r0.x, r0.zwzw, r3.ywzw
add r2.xy, r2, c4
texld r4.yw, r2, s2
add_pp r2.xy, r4.ywzw, -r3
mad_pp r2.xy, r0.y, r2, r3
abs r0.z, v1
max r0.y, r0.z, r0.x
mad_pp r2.xy, r2.yxzw, c17.z, c17.w
rcp r0.w, r0.y
min r0.y, r0.z, r0.x
mul r0.y, r0, r0.w
mul r0.w, r0.y, r0.y
mul_pp r3.xy, r2, r2
add_pp_sat r3.x, r3, r3.y
mad r2.z, r0.w, c15.y, c15
add_pp r3.x, -r3, c13.y
mad r2.z, r2, r0.w, c15.w
rsq_pp r3.y, r3.x
mad r3.x, r2.z, r0.w, c16
mad r3.w, r3.x, r0, c16.y
rcp_pp r2.z, r3.y
add_pp r3.xyz, -r2, c13.xxyw
mad_pp r2.xyz, r1.w, r3, r2
mad r0.w, r3, r0, c16.z
mul r0.y, r0.w, r0
dp3_pp_sat r2.x, r2, v5
add r0.w, -r0.y, c16
add r0.x, r0.z, -r0
cmp r0.y, -r0.x, r0, r0.w
texldp r0.x, v7, s3
mul_pp r2.x, r2, r0
add r0.w, -r0.y, c13.z
cmp r0.x, v1, r0.y, r0.w
abs r0.w, -v1.y
cmp r0.x, v1.z, r0, -r0
mad r3.x, r0, c17, c17.y
add r0.y, -r0.z, c13
mad r0.x, r0.z, c14, c14.y
mad r0.x, r0.z, r0, c13.w
add r3.z, -r0.w, c13.y
mad r3.y, r0.w, c14.x, c14
mad r3.y, r3, r0.w, c13.w
mul_pp r2.xyz, r2.x, c1
mul_pp r2.xyz, r2, c14.w
rsq r0.y, r0.y
rsq r3.z, r3.z
mad r0.x, r0.z, r0, c14.z
rcp r0.y, r0.y
mul r0.y, r0.x, r0
cmp r0.x, v1.z, c13, c13.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c14.w, r0.y
mad r0.w, r3.y, r0, c14.z
rcp r3.z, r3.z
mul r3.y, r0.w, r3.z
cmp r0.w, -v1.y, c13.x, c13.y
mul r3.z, r0.w, r3.y
mad r0.y, -r3.z, c14.w, r3
mad r0.z, r0.x, c13, r0
mad r0.x, r0.w, c13.z, r0.y
mul r0.y, r0.z, c15.x
mul r3.y, r0.x, c15.x
dsx r0.w, r0.y
dsx r3.zw, v1.xyxy
dsy r0.xz, v1.xyyw
mul r0.xz, r0, r0
add r0.z, r0.x, r0
mul r3.zw, r3, r3
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r0.x, r0.x
rcp r3.z, r0.z
mul r0.z, r0.x, c17.x
add_sat r2.xyz, r2, c10.x
dsy r0.y, r0
mul r0.x, r3.z, c17
texldd r0, r3, s0, r0.zwzw, r0
mul r0, r0, c2
mul_pp r0.xyz, r0, r1
mul r1.xyz, r0, r2
mad_pp oC0.xyz, r0, v6, r1
add_pp r2.x, -r2.w, c13.y
mad_pp r0.y, r1.w, r2.x, r2.w
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul r0.x, r0, v0.z
add r1.xyz, -v2, c0
min_pp r1.w, r0, r0.y
dp3 r0.y, r1, r1
abs_sat r0.x, r0
rsq r0.y, r0.y
mul r1.x, r0, c6
rcp r1.y, r0.y
pow_sat r0, r1.x, c5.x
mul r0.y, r1, c12.x
add_sat r0.w, r0.y, -c11.x
add r2.x, r0, -r0.w
add r0.xyz, -v3, c0
dp3 r0.y, r0, r0
mov r1.xyz, v2
add r1.xyz, v3, -r1
dp3 r0.x, r1, r1
rsq r0.y, r0.y
rsq r0.x, r0.x
rcp r0.y, r0.y
rcp r0.x, r0.x
mad_sat r0.x, -r0, c18, r0.y
mad r0.x, r0, r2, r0.w
mul_pp oC0.w, r0.x, r1
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 208 // 192 used size, 16 vars
Vector 16 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Vector 144 [_BumpOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 172 [_DetailDist]
Float 176 [_BumpScale]
Float 180 [_MinLight]
Float 184 [_FadeDist]
Float 188 [_FadeScale]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_DetailTex] 2D 2
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_ShadowMapTexture] 2D 0
// 109 instructions, 6 temp regs, 0 temp arrays:
// ALU 95 float, 0 int, 4 uint
// TEX 7 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedmgkcfkjiijgkjamccnhcbedbkhiioekhabaaaaaaimbaaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcceapaaaaeaaaaaaamjadaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadlcbabaaaahaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaadeaaaaajbcaabaaaaaaaaaaa
akbabaiaibaaaaaaacaaaaaackbabaiaibaaaaaaacaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
ddaaaaajccaabaaaaaaaaaaaakbabaiaibaaaaaaacaaaaaackbabaiaibaaaaaa
acaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
ochgdidodcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaaaaaaaaaaakbabaiaibaaaaaa
acaaaaaackbabaiaibaaaaaaacaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaaagbcbaaa
acaaaaaaagbcbaiaebaaaaaaacaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaddaaaaahccaabaaaaaaaaaaaakbabaaaacaaaaaackbabaaa
acaaaaaadbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadeaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaackbabaaaacaaaaaa
bnaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaak
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdo
abeaaaaaaaaaaadpalaaaaafdcaabaaaabaaaaaaegbabaaaacaaaaaaapaaaaah
icaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaidpjccdoamaaaaafmcaabaaaabaaaaaaagbebaaaacaaaaaaapaaaaah
icaabaaaaaaaaaaaogakbaaaabaaaaaaogakbaaaabaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaa
abeaaaaaidpjccdodbaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaaacaaaaaa
bkbabaaaacaaaaaadcaaaabamcaabaaaabaaaaaafgbjbaiaibaaaaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaadagojjlmdagojjlmaceaaaaaaaaaaaaaaaaaaaaa
chbgjidnchbgjidndcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaafgbjbaia
ibaaaaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaiedefjloiedefjlodcaaaaan
mcaabaaaabaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaakeanmjdpkeanmjdpaaaaaaalmcaabaaaacaaaaaafgbjbaia
mbaaaaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaaf
mcaabaaaacaaaaaakgaobaaaacaaaaaadiaaaaahdcaabaaaadaaaaaaogakbaaa
abaaaaaaogakbaaaacaaaaaadcaaaaapdcaabaaaadaaaaaaegaabaaaadaaaaaa
aceaaaaaaaaaaamaaaaaaamaaaaaaaaaaaaaaaaaaceaaaaanlapejeanlapejea
aaaaaaaaaaaaaaaaabaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaafgabbaaa
adaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaa
ckaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaackaabaaa
acaaaaaadkaabaaaaaaaaaaadiaaaaakgcaabaaaaaaaaaaapgaobaaaaaaaaaaa
aceaaaaaaaaaaaaaidpjkcdoidpjkcdoaaaaaaaaalaaaaafccaabaaaabaaaaaa
ckaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaackaabaaaaaaaaaaaejaaaaan
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
egaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegiocaaaaaaaaaaaahaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaa
acaaaaaakgikcaaaaaaaaaaaakaaaaaaegiecaaaaaaaaaaaaiaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaaldcaabaaaadaaaaaaegbabaaaacaaaaaakgikcaaaaaaaaaaa
akaaaaaaegiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaa
agbabaiaibaaaaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaak
pcaabaaaabaaaaaafgbfbaiaibaaaaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaaaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaaaaaaajbcaabaaaadaaaaaadkiacaaa
aaaaaaaaakaaaaaadkiacaaaaaaaaaaaakaaaaaadicaaaahbcaabaaaadaaaaaa
akaabaaaadaaaaaadkbabaaaabaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaa
adaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaaaaaaaaa
egbcbaaaagaaaaaadcaaaaalpcaabaaaacaaaaaaggbcbaaaacaaaaaaagiacaaa
aaaaaaaaalaaaaaaegiecaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaa
acaaaaaaogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaal
fcaabaaaacaaaaaaagbbbaaaacaaaaaaagiacaaaaaaaaaaaalaaaaaaagibcaaa
aaaaaaaaajaaaaaaefaaaaajpcaabaaaafaaaaaaigaabaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaadaaaaaaaaaaaaaifcaabaaaacaaaaaapganbaaaaeaaaaaa
pganbaiaebaaaaaaafaaaaaadcaaaaakfcaabaaaacaaaaaaagbabaiaibaaaaaa
acaaaaaaagacbaaaacaaaaaapganbaaaafaaaaaaaaaaaaaikcaabaaaacaaaaaa
agaibaiaebaaaaaaacaaaaaapgahbaaaacaaaaaadcaaaaakdcaabaaaacaaaaaa
fgbfbaiaibaaaaaaacaaaaaangafbaaaacaaaaaaigaabaaaacaaaaaadcaaaaap
dcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
abaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaa
abaaaaaaaaaaaaalocaabaaaadaaaaaaagajbaiaebaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdcaaaaajhcaabaaaacaaaaaaagaabaaa
adaaaaaajgahbaaaadaaaaaaegacbaaaacaaaaaabacaaaahicaabaaaabaaaaaa
egacbaaaacaaaaaaegbcbaaaafaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaa
ahaaaaaapgbpbaaaahaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaadaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaaabaaaaaapgapbaaa
abaaaaaaagaabaaaacaaaaaadccaaaalhcaabaaaacaaaaaaegiccaaaaaaaaaaa
abaaaaaapgapbaaaabaaaaaafgifcaaaaaaaaaaaalaaaaaadcaaaaajhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaai
hcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaiaebaaaaaaaeaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafdcaabaaa
aaaaaaaaegaabaaaaaaaaaaadccaaaakbcaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaajkjjjjdpakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaa
egbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackbabaaaabaaaaaa
ddaaaaaiccaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaa
cpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaddaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaajhcaabaaaabaaaaaaegbcbaaaadaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadccaaaamecaabaaa
aaaaaaaadkiacaaaaaaaaaaaalaaaaaackaabaaaaaaaaaaackiacaiaebaaaaaa
aaaaaaaaalaaaaaaaaaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaa
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

#LINE 129

	
	}
	
	 
	FallBack "Diffuse"
}
