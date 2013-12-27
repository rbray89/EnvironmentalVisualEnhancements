Shader "Sphere/UndersideCloud" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		_BumpMap ("Bumpmap", 2D) = "bump" {}
		_FalloffPow ("Falloff Power", Range(0,3)) = 1.8
		_FalloffScale ("Falloff Scale", Range(0,20)) = 10
		_DetailScale ("Detail Scale", Range(0,1000)) = 100
		_DetailOffset ("Detail Offset", Color) = (0,0,0,0)
		_BumpScale ("Bump Scale", Range(0,1000)) = 50
		_BumpOffset ("Bump offset", Color) = (0,0,0,0)
		_DetailDist ("Detail Distance", Range(0,1)) = 0.025
		_MinLight ("Minimum Light", Range(0,1)) = .18
	}

SubShader {
		Tags {  "Queue"="Transparent"
	   			"RenderMode"="Transparent" }
		Lighting On
		Cull Front
	    ZWrite Off
		
		Blend SrcAlpha OneMinusSrcAlpha
		
			
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
Program "vp" {
// Vertex combos: 6
//   d3d9 - ALU: 59 to 64
//   d3d11 - ALU: 51 to 54, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform float _DetailDist;
uniform float _FalloffScale;
uniform float _FalloffPow;

uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - tmpvar_2);
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_6;
  p_6 = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.x = clamp ((_DetailDist * sqrt(dot (p_6, p_6))), 0.0, 1.0);
  vec3 p_7;
  p_7 = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.y = (clamp ((sqrt(dot (p_4, p_4)) - (1.003 * sqrt(dot (p_5, p_5)))), 0.0, 1.0) * clamp ((clamp ((0.0825 * sqrt(dot (p_7, p_7))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * gl_Normal.xyzz).xyz), -(normalize((tmpvar_2 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
  vec3 tmpvar_8;
  vec3 tmpvar_9;
  tmpvar_8 = TANGENT.xyz;
  tmpvar_9 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = gl_Normal.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = gl_Normal.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = gl_Normal.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD3 = gl_LightModel.ambient.xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _MinLight;
uniform float _BumpScale;
uniform float _DetailScale;
uniform vec4 _BumpOffset;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
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
  vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_16.xyz * mix (tmpvar_18.xyz, vec3(1.0, 1.0, 1.0), xlv_TEXCOORD0.xxx));
  vec3 normal_20;
  normal_20.xy = ((mix (mix (texture2D (_BumpMap, ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy)), texture2D (_BumpMap, ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy)), tmpvar_17.xxxx), texture2D (_BumpMap, ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy)), tmpvar_17.yyyy).wy * 2.0) - 1.0);
  normal_20.z = sqrt((1.0 - clamp (dot (normal_20.xy, normal_20.xy), 0.0, 1.0)));
  vec4 c_21;
  c_21.xyz = (tmpvar_19 * clamp ((_MinLight + (_LightColor0.xyz * (clamp (dot (mix (normal_20, vec3(0.0, 0.0, 1.0), xlv_TEXCOORD0.xxx), xlv_TEXCOORD2), 0.0, 1.0) * 2.0))), 0.0, 1.0));
  c_21.w = mix (0.0, (mix (tmpvar_18.w, 1.0, xlv_TEXCOORD0.x) * tmpvar_16.w), xlv_TEXCOORD0.y);
  c_1.w = c_21.w;
  c_1.xyz = (c_21.xyz + (tmpvar_19 * xlv_TEXCOORD3));
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
Float 15 [_FalloffPow]
Float 16 [_FalloffScale]
Float 17 [_DetailDist]
"vs_3_0
; 59 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c18, 0.08250000, 0.80000001, 1.00300002, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dp4 r3.z, v0, c6
dp4 r3.x, v0, c4
dp4 r3.y, v0, c5
add r0.xyz, r3, -c13
dp3 r1.w, r0, r0
rsq r3.w, r1.w
mul r0.xyz, r3.w, r0
dp4 r1.z, v2.xyzz, c6
dp4 r1.x, v2.xyzz, c4
dp4 r1.y, v2.xyzz, c5
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
dp3 r0.x, r1, -r0
mul r0.x, r0, c16
mul r0.w, r0.x, c18.y
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
pow_sat r2, r0.w, c15.x
mov r0, c10
dp4 r2.w, c14, r0
mov r0, c9
dp4 r2.z, c14, r0
rcp r0.w, r3.w
mul r4.xyz, r1, v1.w
mov r1, c8
dp4 r2.y, c14, r1
mov r0.y, r2.x
mul_sat r0.x, r0.w, c18
add_sat r1.w, r0.x, r0.y
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r1.xyz, -r0, r3
add r0.xyz, -r0, c13
dp3 r0.y, r0, r0
dp3 r1.x, r1, r1
rsq r0.x, r1.x
rsq r0.y, r0.y
rcp r0.x, r0.x
rcp r0.y, r0.y
mad_sat r0.x, -r0.y, c18.z, r0
mul o1.y, r0.x, r1.w
dp3 r0.x, v0, v0
rsq r0.x, r0.x
dp3 o3.y, r2.yzww, r4
dp3 o3.z, v2, r2.yzww
dp3 o3.x, r2.yzww, v1
mul_sat o1.x, r0.w, c17
mul o2.xyz, r0.x, v0
mov o4.xyz, c12
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "color" Color
ConstBuffer "$Globals" 128 // 112 used size, 12 vars
Float 96 [_FalloffPow]
Float 100 [_FalloffScale]
Float 108 [_DetailDist]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 53 instructions, 3 temp regs, 0 temp arrays:
// ALU 51 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedejclpngkipepfipkhoaodiddghemanckabaaaaaaniaiaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdmahaaaaeaaaabaa
mpabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
beaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaa
kgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafccaabaaaabaaaaaa
akaabaaaabaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ocaabaaaabaaaaaafgafbaaaabaaaaaaagajbaaaacaaaaaabaaaaaaibcaabaaa
aaaaaaaaegacbaaaaaaaaaaajgahbaiaebaaaaaaabaaaaaadiaaaaaiccaabaaa
aaaaaaaabkiacaaaaaaaaaaaagaaaaaaabeaaaaamnmmemdpdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaagaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaamdpfkidndicaaaaibccabaaa
abaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaagaaaaaaddaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaakhcaabaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
kcaabaaaaaaaaaaafganbaaaaaaaaaaadccaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaabeaaaaaeogciadpdkaabaaaaaaaaaaadiaaaaahcccabaaa
abaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhccabaaaacaaaaaaagaabaaaaaaaaaaaegbcbaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaaeaaaaaaegiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _DetailDist;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform highp vec4 glstate_lightmodel_ambient;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_7 - tmpvar_6);
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = clamp ((_DetailDist * sqrt(dot (p_10, p_10))), 0.0, 1.0);
  highp vec3 p_11;
  p_11 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - (1.003 * sqrt(dot (p_9, p_9)))), 0.0, 1.0) * clamp ((clamp ((0.0825 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_1.xyz;
  tmpvar_13 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_2.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_2.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_2.z;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
uniform highp float _DetailScale;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
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
  tmpvar_48 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_51;
  tmpvar_51 = mix (0.0, tmpvar_50, xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_51;
  lowp vec3 tmpvar_52;
  lowp vec4 packednormal_53;
  packednormal_53 = normal_7;
  tmpvar_52 = ((packednormal_53.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_54;
  tmpvar_54 = mix (tmpvar_52, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_54;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_55;
  lightDir_55 = xlv_TEXCOORD2;
  mediump vec4 c_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (dot (tmpvar_4, lightDir_55), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_57 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_59;
  tmpvar_59 = (tmpvar_3 * tmpvar_58);
  c_56.xyz = tmpvar_59;
  c_56.w = tmpvar_5;
  c_1 = c_56;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD3));
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
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _DetailDist;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform highp vec4 glstate_lightmodel_ambient;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_7 - tmpvar_6);
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = clamp ((_DetailDist * sqrt(dot (p_10, p_10))), 0.0, 1.0);
  highp vec3 p_11;
  p_11 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - (1.003 * sqrt(dot (p_9, p_9)))), 0.0, 1.0) * clamp ((clamp ((0.0825 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_1.xyz;
  tmpvar_13 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_2.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_2.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_2.z;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
uniform highp float _DetailScale;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
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
  tmpvar_48 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_51;
  tmpvar_51 = mix (0.0, tmpvar_50, xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_51;
  lowp vec4 packednormal_52;
  packednormal_52 = normal_7;
  lowp vec3 normal_53;
  normal_53.xy = ((packednormal_52.wy * 2.0) - 1.0);
  normal_53.z = sqrt((1.0 - clamp (dot (normal_53.xy, normal_53.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_54;
  tmpvar_54 = mix (normal_53, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_54;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_55;
  lightDir_55 = xlv_TEXCOORD2;
  mediump vec4 c_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (dot (tmpvar_4, lightDir_55), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_57 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_59;
  tmpvar_59 = (tmpvar_3 * tmpvar_58);
  c_56.xyz = tmpvar_59;
  c_56.w = tmpvar_5;
  c_1 = c_56;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD3));
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
#line 411
struct Input {
    highp vec2 viewDist;
    highp vec3 viewDir;
    highp vec3 localPos;
};
#line 468
struct v2f_surf {
    highp vec4 pos;
    highp vec2 cust_viewDist;
    highp vec3 cust_localPos;
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
#line 418
#line 431
#line 477
#line 494
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 418
void vert( inout appdata_full v, out Input o ) {
    highp vec3 normalDir = normalize((_Object2World * v.normal.xyzz).xyz);
    #line 422
    highp vec3 modelCam = _WorldSpaceCameraPos;
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 viewVect = normalize((vertexPos - modelCam));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 426
    highp float diff = (distance( origin, vertexPos) - (1.003 * distance( origin, _WorldSpaceCameraPos)));
    o.viewDist.x = xll_saturate_f((_DetailDist * distance( vertexPos, _WorldSpaceCameraPos)));
    o.viewDist.y = (xll_saturate_f(diff) * xll_saturate_f((xll_saturate_f((0.0825 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow)))));
    o.localPos = normalize(v.vertex.xyz);
}
#line 477
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 481
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 485
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 489
    o.lightDir = lightDir;
    o.vlight = glstate_lightmodel_ambient.xyz;
    return o;
}

out highp vec2 xlv_TEXCOORD0;
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
    xlv_TEXCOORD0 = vec2(xl_retval.cust_viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
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
#line 411
struct Input {
    highp vec2 viewDist;
    highp vec3 viewDir;
    highp vec3 localPos;
};
#line 468
struct v2f_surf {
    highp vec4 pos;
    highp vec2 cust_viewDist;
    highp vec3 cust_localPos;
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
#line 418
#line 431
#line 477
#line 494
#line 403
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    #line 405
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    #line 409
    return c;
}
#line 431
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 435
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 439
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 442
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 444
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    #line 448
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    #line 452
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    #line 456
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    #line 460
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = IN.viewDist.x;
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Albedo = albedo;
    #line 464
    mediump float avg = (mix( detail.w, 1.0, detailLevel) * main.w);
    o.Alpha = mix( 0.0, avg, IN.viewDist.y);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 494
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    #line 498
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 502
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 506
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    #line 510
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_viewDist = vec2(xlv_TEXCOORD0);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
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
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform float _DetailDist;
uniform float _FalloffScale;
uniform float _FalloffPow;

uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - tmpvar_2);
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_6;
  p_6 = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.x = clamp ((_DetailDist * sqrt(dot (p_6, p_6))), 0.0, 1.0);
  vec3 p_7;
  p_7 = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.y = (clamp ((sqrt(dot (p_4, p_4)) - (1.003 * sqrt(dot (p_5, p_5)))), 0.0, 1.0) * clamp ((clamp ((0.0825 * sqrt(dot (p_7, p_7))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * gl_Normal.xyzz).xyz), -(normalize((tmpvar_2 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_9;
  vec3 tmpvar_10;
  tmpvar_9 = TANGENT.xyz;
  tmpvar_10 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = gl_Normal.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = gl_Normal.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = gl_Normal.z;
  vec4 o_12;
  vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_8 * 0.5);
  vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD3 = gl_LightModel.ambient.xyz;
  xlv_TEXCOORD4 = o_12;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _MinLight;
uniform float _BumpScale;
uniform float _DetailScale;
uniform vec4 _BumpOffset;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
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
  vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_16.xyz * mix (tmpvar_18.xyz, vec3(1.0, 1.0, 1.0), xlv_TEXCOORD0.xxx));
  vec3 normal_20;
  normal_20.xy = ((mix (mix (texture2D (_BumpMap, ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy)), texture2D (_BumpMap, ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy)), tmpvar_17.xxxx), texture2D (_BumpMap, ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy)), tmpvar_17.yyyy).wy * 2.0) - 1.0);
  normal_20.z = sqrt((1.0 - clamp (dot (normal_20.xy, normal_20.xy), 0.0, 1.0)));
  vec4 c_21;
  c_21.xyz = (tmpvar_19 * clamp ((_MinLight + (_LightColor0.xyz * ((clamp (dot (mix (normal_20, vec3(0.0, 0.0, 1.0), xlv_TEXCOORD0.xxx), xlv_TEXCOORD2), 0.0, 1.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x) * 2.0))), 0.0, 1.0));
  c_21.w = mix (0.0, (mix (tmpvar_18.w, 1.0, xlv_TEXCOORD0.x) * tmpvar_16.w), xlv_TEXCOORD0.y);
  c_1.w = c_21.w;
  c_1.xyz = (c_21.xyz + (tmpvar_19 * xlv_TEXCOORD3));
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
Float 17 [_FalloffPow]
Float 18 [_FalloffScale]
Float 19 [_DetailDist]
"vs_3_0
; 64 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c20, 0.08250000, 0.80000001, 1.00300002, 0.50000000
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dp4 r3.z, v0, c6
dp4 r3.x, v0, c4
dp4 r3.y, v0, c5
add r0.xyz, r3, -c13
dp3 r1.w, r0, r0
rsq r3.w, r1.w
mul r0.xyz, r3.w, r0
dp4 r1.z, v2.xyzz, c6
dp4 r1.x, v2.xyzz, c4
dp4 r1.y, v2.xyzz, c5
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
dp3 r0.x, r1, -r0
mul r0.x, r0, c18
mul r0.w, r0.x, c20.y
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
pow_sat r2, r0.w, c17.x
mov r0, c10
dp4 r2.w, c16, r0
mov r0, c9
dp4 r2.z, c16, r0
mul r4.xyz, r1, v1.w
mov r1, c8
dp4 r2.y, c16, r1
rcp r1.w, r3.w
mov r0.y, r2.x
mul_sat r0.x, r1.w, c20
add_sat r0.w, r0.x, r0.y
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r1.xyz, -r0, r3
add r0.xyz, -r0, c13
dp3 r0.y, r0, r0
dp3 r1.x, r1, r1
rsq r0.x, r1.x
rsq r0.y, r0.y
rcp r0.y, r0.y
rcp r0.x, r0.x
mad_sat r0.x, -r0.y, c20.z, r0
mul o1.y, r0.x, r0.w
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c20.w
mul r1.y, r1, c14.x
mov o0, r0
dp3 r0.x, v0, v0
rsq r0.x, r0.x
dp3 o3.y, r2.yzww, r4
dp3 o3.z, v2, r2.yzww
dp3 o3.x, r2.yzww, v1
mad o5.xy, r1.z, c15.zwzw, r1
mov o5.zw, r0
mul_sat o1.x, r1.w, c19
mul o2.xyz, r0.x, v0
mov o4.xyz, c12
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "color" Color
ConstBuffer "$Globals" 192 // 176 used size, 13 vars
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 172 [_DetailDist]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 58 instructions, 4 temp regs, 0 temp arrays:
// ALU 54 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmgnhigadhfndlfbjoelmggnniiilfahmabaaaaaaiiajaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcneahaaaaeaaaabaapfabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabeaaaaaafjaaaaae
egiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaakgbkbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaacaaaaaaaaaaaaajhcaabaaaadaaaaaaegacbaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaia
ebaaaaaaacaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaafccaabaaaacaaaaaaakaabaaaacaaaaaa
elaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahocaabaaaacaaaaaa
fgafbaaaacaaaaaaagajbaaaadaaaaaabaaaaaaibcaabaaaabaaaaaaegacbaaa
abaaaaaajgahbaiaebaaaaaaacaaaaaadiaaaaaiccaabaaaabaaaaaabkiacaaa
aaaaaaaaakaaaaaaabeaaaaamnmmemdpdiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaakaaaaaa
bjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
akaabaaaacaaaaaaabeaaaaamdpfkidndicaaaaibccabaaaabaaaaaaakaabaaa
acaaaaaadkiacaaaaaaaaaaaakaaaaaaddaaaaakdcaabaaaabaaaaaaegaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaaaaaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaakhcaabaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafkcaabaaaabaaaaaa
fganbaaaabaaaaaadccaaaakccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
abeaaaaaeogciadpdkaabaaaabaaaaaadiaaaaahcccabaaaabaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaa
egbcbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hccabaaaacaaaaaaagaabaaaabaaaaaaegbcbaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
acaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaa
baaaaaahcccabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
bccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaa
adaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadgaaaaaghccabaaaaeaaaaaa
egiccaaaaeaaaaaaaeaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _DetailDist;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform highp vec4 glstate_lightmodel_ambient;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_7 - tmpvar_6);
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = clamp ((_DetailDist * sqrt(dot (p_10, p_10))), 0.0, 1.0);
  highp vec3 p_11;
  p_11 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - (1.003 * sqrt(dot (p_9, p_9)))), 0.0, 1.0) * clamp ((clamp ((0.0825 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_1.xyz;
  tmpvar_13 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_2.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_2.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_2.z;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
uniform highp float _DetailScale;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
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
  tmpvar_48 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_51;
  tmpvar_51 = mix (0.0, tmpvar_50, xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_51;
  lowp vec3 tmpvar_52;
  lowp vec4 packednormal_53;
  packednormal_53 = normal_7;
  tmpvar_52 = ((packednormal_53.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_54;
  tmpvar_54 = mix (tmpvar_52, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_54;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_55;
  mediump float lightShadowDataX_56;
  highp float dist_57;
  lowp float tmpvar_58;
  tmpvar_58 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = _LightShadowData.x;
  lightShadowDataX_56 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = max (float((dist_57 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_56);
  tmpvar_55 = tmpvar_60;
  mediump vec3 lightDir_61;
  lightDir_61 = xlv_TEXCOORD2;
  mediump float atten_62;
  atten_62 = tmpvar_55;
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
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD3));
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
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _DetailDist;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform highp vec4 glstate_lightmodel_ambient;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_7 - tmpvar_6);
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = clamp ((_DetailDist * sqrt(dot (p_10, p_10))), 0.0, 1.0);
  highp vec3 p_11;
  p_11 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - (1.003 * sqrt(dot (p_9, p_9)))), 0.0, 1.0) * clamp ((clamp ((0.0825 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_13 = tmpvar_1.xyz;
  tmpvar_14 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0].x = tmpvar_13.x;
  tmpvar_15[0].y = tmpvar_14.x;
  tmpvar_15[0].z = tmpvar_2.x;
  tmpvar_15[1].x = tmpvar_13.y;
  tmpvar_15[1].y = tmpvar_14.y;
  tmpvar_15[1].z = tmpvar_2.y;
  tmpvar_15[2].x = tmpvar_13.z;
  tmpvar_15[2].y = tmpvar_14.z;
  tmpvar_15[2].z = tmpvar_2.z;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_17;
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_12.zw;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = o_18;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
uniform highp float _DetailScale;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
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
  tmpvar_48 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_51;
  tmpvar_51 = mix (0.0, tmpvar_50, xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_51;
  lowp vec4 packednormal_52;
  packednormal_52 = normal_7;
  lowp vec3 normal_53;
  normal_53.xy = ((packednormal_52.wy * 2.0) - 1.0);
  normal_53.z = sqrt((1.0 - clamp (dot (normal_53.xy, normal_53.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_54;
  tmpvar_54 = mix (normal_53, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_54;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_55;
  tmpvar_55 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  mediump vec3 lightDir_56;
  lightDir_56 = xlv_TEXCOORD2;
  mediump float atten_57;
  atten_57 = tmpvar_55;
  mediump vec4 c_58;
  mediump float tmpvar_59;
  tmpvar_59 = clamp (dot (tmpvar_4, lightDir_56), 0.0, 1.0);
  highp vec3 tmpvar_60;
  tmpvar_60 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_59 * atten_57) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_3 * tmpvar_60);
  c_58.xyz = tmpvar_61;
  c_58.w = tmpvar_5;
  c_1 = c_58;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD3));
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
#line 419
struct Input {
    highp vec2 viewDist;
    highp vec3 viewDir;
    highp vec3 localPos;
};
#line 476
struct v2f_surf {
    highp vec4 pos;
    highp vec2 cust_viewDist;
    highp vec3 cust_localPos;
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
#line 426
#line 439
#line 486
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 426
void vert( inout appdata_full v, out Input o ) {
    highp vec3 normalDir = normalize((_Object2World * v.normal.xyzz).xyz);
    #line 430
    highp vec3 modelCam = _WorldSpaceCameraPos;
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 viewVect = normalize((vertexPos - modelCam));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 434
    highp float diff = (distance( origin, vertexPos) - (1.003 * distance( origin, _WorldSpaceCameraPos)));
    o.viewDist.x = xll_saturate_f((_DetailDist * distance( vertexPos, _WorldSpaceCameraPos)));
    o.viewDist.y = (xll_saturate_f(diff) * xll_saturate_f((xll_saturate_f((0.0825 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow)))));
    o.localPos = normalize(v.vertex.xyz);
}
#line 486
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 490
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 494
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 498
    o.lightDir = lightDir;
    o.vlight = glstate_lightmodel_ambient.xyz;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 502
    return o;
}

out highp vec2 xlv_TEXCOORD0;
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
    xlv_TEXCOORD0 = vec2(xl_retval.cust_viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
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
#line 419
struct Input {
    highp vec2 viewDist;
    highp vec3 viewDir;
    highp vec3 localPos;
};
#line 476
struct v2f_surf {
    highp vec4 pos;
    highp vec2 cust_viewDist;
    highp vec3 cust_localPos;
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
#line 426
#line 439
#line 486
#line 411
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    #line 413
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    #line 417
    return c;
}
#line 439
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 443
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 447
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 450
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 452
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    #line 456
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    #line 460
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    #line 464
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    #line 468
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = IN.viewDist.x;
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Albedo = albedo;
    #line 472
    mediump float avg = (mix( detail.w, 1.0, detailLevel) * main.w);
    o.Alpha = mix( 0.0, avg, IN.viewDist.y);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 504
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 506
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 510
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 514
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 518
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_viewDist = vec2(xlv_TEXCOORD0);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
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
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform float _DetailDist;
uniform float _FalloffScale;
uniform float _FalloffPow;

uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - tmpvar_2);
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_6;
  p_6 = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.x = clamp ((_DetailDist * sqrt(dot (p_6, p_6))), 0.0, 1.0);
  vec3 p_7;
  p_7 = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.y = (clamp ((sqrt(dot (p_4, p_4)) - (1.003 * sqrt(dot (p_5, p_5)))), 0.0, 1.0) * clamp ((clamp ((0.0825 * sqrt(dot (p_7, p_7))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * gl_Normal.xyzz).xyz), -(normalize((tmpvar_2 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
  vec3 tmpvar_8;
  vec3 tmpvar_9;
  tmpvar_8 = TANGENT.xyz;
  tmpvar_9 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = gl_Normal.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = gl_Normal.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = gl_Normal.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD3 = gl_LightModel.ambient.xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _MinLight;
uniform float _BumpScale;
uniform float _DetailScale;
uniform vec4 _BumpOffset;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
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
  vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_16.xyz * mix (tmpvar_18.xyz, vec3(1.0, 1.0, 1.0), xlv_TEXCOORD0.xxx));
  vec3 normal_20;
  normal_20.xy = ((mix (mix (texture2D (_BumpMap, ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy)), texture2D (_BumpMap, ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy)), tmpvar_17.xxxx), texture2D (_BumpMap, ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy)), tmpvar_17.yyyy).wy * 2.0) - 1.0);
  normal_20.z = sqrt((1.0 - clamp (dot (normal_20.xy, normal_20.xy), 0.0, 1.0)));
  vec4 c_21;
  c_21.xyz = (tmpvar_19 * clamp ((_MinLight + (_LightColor0.xyz * (clamp (dot (mix (normal_20, vec3(0.0, 0.0, 1.0), xlv_TEXCOORD0.xxx), xlv_TEXCOORD2), 0.0, 1.0) * 2.0))), 0.0, 1.0));
  c_21.w = mix (0.0, (mix (tmpvar_18.w, 1.0, xlv_TEXCOORD0.x) * tmpvar_16.w), xlv_TEXCOORD0.y);
  c_1.w = c_21.w;
  c_1.xyz = (c_21.xyz + (tmpvar_19 * xlv_TEXCOORD3));
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
Float 15 [_FalloffPow]
Float 16 [_FalloffScale]
Float 17 [_DetailDist]
"vs_3_0
; 59 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c18, 0.08250000, 0.80000001, 1.00300002, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dp4 r3.z, v0, c6
dp4 r3.x, v0, c4
dp4 r3.y, v0, c5
add r0.xyz, r3, -c13
dp3 r1.w, r0, r0
rsq r3.w, r1.w
mul r0.xyz, r3.w, r0
dp4 r1.z, v2.xyzz, c6
dp4 r1.x, v2.xyzz, c4
dp4 r1.y, v2.xyzz, c5
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
dp3 r0.x, r1, -r0
mul r0.x, r0, c16
mul r0.w, r0.x, c18.y
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
pow_sat r2, r0.w, c15.x
mov r0, c10
dp4 r2.w, c14, r0
mov r0, c9
dp4 r2.z, c14, r0
rcp r0.w, r3.w
mul r4.xyz, r1, v1.w
mov r1, c8
dp4 r2.y, c14, r1
mov r0.y, r2.x
mul_sat r0.x, r0.w, c18
add_sat r1.w, r0.x, r0.y
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r1.xyz, -r0, r3
add r0.xyz, -r0, c13
dp3 r0.y, r0, r0
dp3 r1.x, r1, r1
rsq r0.x, r1.x
rsq r0.y, r0.y
rcp r0.x, r0.x
rcp r0.y, r0.y
mad_sat r0.x, -r0.y, c18.z, r0
mul o1.y, r0.x, r1.w
dp3 r0.x, v0, v0
rsq r0.x, r0.x
dp3 o3.y, r2.yzww, r4
dp3 o3.z, v2, r2.yzww
dp3 o3.x, r2.yzww, v1
mul_sat o1.x, r0.w, c17
mul o2.xyz, r0.x, v0
mov o4.xyz, c12
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "color" Color
ConstBuffer "$Globals" 128 // 112 used size, 12 vars
Float 96 [_FalloffPow]
Float 100 [_FalloffScale]
Float 108 [_DetailDist]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 53 instructions, 3 temp regs, 0 temp arrays:
// ALU 51 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedejclpngkipepfipkhoaodiddghemanckabaaaaaaniaiaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdmahaaaaeaaaabaa
mpabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
beaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaa
kgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafccaabaaaabaaaaaa
akaabaaaabaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ocaabaaaabaaaaaafgafbaaaabaaaaaaagajbaaaacaaaaaabaaaaaaibcaabaaa
aaaaaaaaegacbaaaaaaaaaaajgahbaiaebaaaaaaabaaaaaadiaaaaaiccaabaaa
aaaaaaaabkiacaaaaaaaaaaaagaaaaaaabeaaaaamnmmemdpdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaagaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaamdpfkidndicaaaaibccabaaa
abaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaagaaaaaaddaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaakhcaabaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
kcaabaaaaaaaaaaafganbaaaaaaaaaaadccaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaabeaaaaaeogciadpdkaabaaaaaaaaaaadiaaaaahcccabaaa
abaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhccabaaaacaaaaaaagaabaaaaaaaaaaaegbcbaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaaeaaaaaaegiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _DetailDist;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform highp vec4 glstate_lightmodel_ambient;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_7 - tmpvar_6);
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = clamp ((_DetailDist * sqrt(dot (p_10, p_10))), 0.0, 1.0);
  highp vec3 p_11;
  p_11 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - (1.003 * sqrt(dot (p_9, p_9)))), 0.0, 1.0) * clamp ((clamp ((0.0825 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_1.xyz;
  tmpvar_13 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_2.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_2.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_2.z;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
uniform highp float _DetailScale;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
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
  tmpvar_48 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_51;
  tmpvar_51 = mix (0.0, tmpvar_50, xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_51;
  lowp vec3 tmpvar_52;
  lowp vec4 packednormal_53;
  packednormal_53 = normal_7;
  tmpvar_52 = ((packednormal_53.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_54;
  tmpvar_54 = mix (tmpvar_52, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_54;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_55;
  lightDir_55 = xlv_TEXCOORD2;
  mediump vec4 c_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (dot (tmpvar_4, lightDir_55), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_57 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_59;
  tmpvar_59 = (tmpvar_3 * tmpvar_58);
  c_56.xyz = tmpvar_59;
  c_56.w = tmpvar_5;
  c_1 = c_56;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD3));
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
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _DetailDist;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform highp vec4 glstate_lightmodel_ambient;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_7 - tmpvar_6);
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = clamp ((_DetailDist * sqrt(dot (p_10, p_10))), 0.0, 1.0);
  highp vec3 p_11;
  p_11 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - (1.003 * sqrt(dot (p_9, p_9)))), 0.0, 1.0) * clamp ((clamp ((0.0825 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_1.xyz;
  tmpvar_13 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_2.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_2.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_2.z;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
uniform highp float _DetailScale;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
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
  tmpvar_48 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_51;
  tmpvar_51 = mix (0.0, tmpvar_50, xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_51;
  lowp vec4 packednormal_52;
  packednormal_52 = normal_7;
  lowp vec3 normal_53;
  normal_53.xy = ((packednormal_52.wy * 2.0) - 1.0);
  normal_53.z = sqrt((1.0 - clamp (dot (normal_53.xy, normal_53.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_54;
  tmpvar_54 = mix (normal_53, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_54;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_55;
  lightDir_55 = xlv_TEXCOORD2;
  mediump vec4 c_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp (dot (tmpvar_4, lightDir_55), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_57 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_59;
  tmpvar_59 = (tmpvar_3 * tmpvar_58);
  c_56.xyz = tmpvar_59;
  c_56.w = tmpvar_5;
  c_1 = c_56;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD3));
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
#line 411
struct Input {
    highp vec2 viewDist;
    highp vec3 viewDir;
    highp vec3 localPos;
};
#line 468
struct v2f_surf {
    highp vec4 pos;
    highp vec2 cust_viewDist;
    highp vec3 cust_localPos;
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
#line 418
#line 431
#line 477
#line 494
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 418
void vert( inout appdata_full v, out Input o ) {
    highp vec3 normalDir = normalize((_Object2World * v.normal.xyzz).xyz);
    #line 422
    highp vec3 modelCam = _WorldSpaceCameraPos;
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 viewVect = normalize((vertexPos - modelCam));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 426
    highp float diff = (distance( origin, vertexPos) - (1.003 * distance( origin, _WorldSpaceCameraPos)));
    o.viewDist.x = xll_saturate_f((_DetailDist * distance( vertexPos, _WorldSpaceCameraPos)));
    o.viewDist.y = (xll_saturate_f(diff) * xll_saturate_f((xll_saturate_f((0.0825 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow)))));
    o.localPos = normalize(v.vertex.xyz);
}
#line 477
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 481
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 485
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 489
    o.lightDir = lightDir;
    o.vlight = glstate_lightmodel_ambient.xyz;
    return o;
}

out highp vec2 xlv_TEXCOORD0;
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
    xlv_TEXCOORD0 = vec2(xl_retval.cust_viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
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
#line 411
struct Input {
    highp vec2 viewDist;
    highp vec3 viewDir;
    highp vec3 localPos;
};
#line 468
struct v2f_surf {
    highp vec4 pos;
    highp vec2 cust_viewDist;
    highp vec3 cust_localPos;
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
#line 418
#line 431
#line 477
#line 494
#line 403
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    #line 405
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    #line 409
    return c;
}
#line 431
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 435
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 439
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 442
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 444
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    #line 448
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    #line 452
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    #line 456
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    #line 460
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = IN.viewDist.x;
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Albedo = albedo;
    #line 464
    mediump float avg = (mix( detail.w, 1.0, detailLevel) * main.w);
    o.Alpha = mix( 0.0, avg, IN.viewDist.y);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 494
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    #line 498
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 502
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 506
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    #line 510
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_viewDist = vec2(xlv_TEXCOORD0);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
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
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform float _DetailDist;
uniform float _FalloffScale;
uniform float _FalloffPow;

uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec2 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_4;
  p_4 = (tmpvar_3 - tmpvar_2);
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_6;
  p_6 = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.x = clamp ((_DetailDist * sqrt(dot (p_6, p_6))), 0.0, 1.0);
  vec3 p_7;
  p_7 = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.y = (clamp ((sqrt(dot (p_4, p_4)) - (1.003 * sqrt(dot (p_5, p_5)))), 0.0, 1.0) * clamp ((clamp ((0.0825 * sqrt(dot (p_7, p_7))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * gl_Normal.xyzz).xyz), -(normalize((tmpvar_2 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_9;
  vec3 tmpvar_10;
  tmpvar_9 = TANGENT.xyz;
  tmpvar_10 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = gl_Normal.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = gl_Normal.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = gl_Normal.z;
  vec4 o_12;
  vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_8 * 0.5);
  vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD3 = gl_LightModel.ambient.xyz;
  xlv_TEXCOORD4 = o_12;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _MinLight;
uniform float _BumpScale;
uniform float _DetailScale;
uniform vec4 _BumpOffset;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
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
  vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_16.xyz * mix (tmpvar_18.xyz, vec3(1.0, 1.0, 1.0), xlv_TEXCOORD0.xxx));
  vec3 normal_20;
  normal_20.xy = ((mix (mix (texture2D (_BumpMap, ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy)), texture2D (_BumpMap, ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy)), tmpvar_17.xxxx), texture2D (_BumpMap, ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy)), tmpvar_17.yyyy).wy * 2.0) - 1.0);
  normal_20.z = sqrt((1.0 - clamp (dot (normal_20.xy, normal_20.xy), 0.0, 1.0)));
  vec4 c_21;
  c_21.xyz = (tmpvar_19 * clamp ((_MinLight + (_LightColor0.xyz * ((clamp (dot (mix (normal_20, vec3(0.0, 0.0, 1.0), xlv_TEXCOORD0.xxx), xlv_TEXCOORD2), 0.0, 1.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x) * 2.0))), 0.0, 1.0));
  c_21.w = mix (0.0, (mix (tmpvar_18.w, 1.0, xlv_TEXCOORD0.x) * tmpvar_16.w), xlv_TEXCOORD0.y);
  c_1.w = c_21.w;
  c_1.xyz = (c_21.xyz + (tmpvar_19 * xlv_TEXCOORD3));
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
Float 17 [_FalloffPow]
Float 18 [_FalloffScale]
Float 19 [_DetailDist]
"vs_3_0
; 64 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c20, 0.08250000, 0.80000001, 1.00300002, 0.50000000
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dp4 r3.z, v0, c6
dp4 r3.x, v0, c4
dp4 r3.y, v0, c5
add r0.xyz, r3, -c13
dp3 r1.w, r0, r0
rsq r3.w, r1.w
mul r0.xyz, r3.w, r0
dp4 r1.z, v2.xyzz, c6
dp4 r1.x, v2.xyzz, c4
dp4 r1.y, v2.xyzz, c5
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
dp3 r0.x, r1, -r0
mul r0.x, r0, c18
mul r0.w, r0.x, c20.y
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
pow_sat r2, r0.w, c17.x
mov r0, c10
dp4 r2.w, c16, r0
mov r0, c9
dp4 r2.z, c16, r0
mul r4.xyz, r1, v1.w
mov r1, c8
dp4 r2.y, c16, r1
rcp r1.w, r3.w
mov r0.y, r2.x
mul_sat r0.x, r1.w, c20
add_sat r0.w, r0.x, r0.y
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r1.xyz, -r0, r3
add r0.xyz, -r0, c13
dp3 r0.y, r0, r0
dp3 r1.x, r1, r1
rsq r0.x, r1.x
rsq r0.y, r0.y
rcp r0.y, r0.y
rcp r0.x, r0.x
mad_sat r0.x, -r0.y, c20.z, r0
mul o1.y, r0.x, r0.w
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c20.w
mul r1.y, r1, c14.x
mov o0, r0
dp3 r0.x, v0, v0
rsq r0.x, r0.x
dp3 o3.y, r2.yzww, r4
dp3 o3.z, v2, r2.yzww
dp3 o3.x, r2.yzww, v1
mad o5.xy, r1.z, c15.zwzw, r1
mov o5.zw, r0
mul_sat o1.x, r1.w, c19
mul o2.xyz, r0.x, v0
mov o4.xyz, c12
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "color" Color
ConstBuffer "$Globals" 192 // 176 used size, 13 vars
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 172 [_DetailDist]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 58 instructions, 4 temp regs, 0 temp arrays:
// ALU 54 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmgnhigadhfndlfbjoelmggnniiilfahmabaaaaaaiiajaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcneahaaaaeaaaabaapfabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabeaaaaaafjaaaaae
egiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaakgbkbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaacaaaaaaaaaaaaajhcaabaaaadaaaaaaegacbaaaacaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaia
ebaaaaaaacaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaafccaabaaaacaaaaaaakaabaaaacaaaaaa
elaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahocaabaaaacaaaaaa
fgafbaaaacaaaaaaagajbaaaadaaaaaabaaaaaaibcaabaaaabaaaaaaegacbaaa
abaaaaaajgahbaiaebaaaaaaacaaaaaadiaaaaaiccaabaaaabaaaaaabkiacaaa
aaaaaaaaakaaaaaaabeaaaaamnmmemdpdiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaakaaaaaa
bjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
akaabaaaacaaaaaaabeaaaaamdpfkidndicaaaaibccabaaaabaaaaaaakaabaaa
acaaaaaadkiacaaaaaaaaaaaakaaaaaaddaaaaakdcaabaaaabaaaaaaegaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaaaaaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaakhcaabaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafkcaabaaaabaaaaaa
fganbaaaabaaaaaadccaaaakccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
abeaaaaaeogciadpdkaabaaaabaaaaaadiaaaaahcccabaaaabaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaa
egbcbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hccabaaaacaaaaaaagaabaaaabaaaaaaegbcbaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
acaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaa
baaaaaahcccabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
bccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaa
adaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadgaaaaaghccabaaaaeaaaaaa
egiccaaaaeaaaaaaaeaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _DetailDist;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform highp vec4 glstate_lightmodel_ambient;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_7 - tmpvar_6);
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = clamp ((_DetailDist * sqrt(dot (p_10, p_10))), 0.0, 1.0);
  highp vec3 p_11;
  p_11 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - (1.003 * sqrt(dot (p_9, p_9)))), 0.0, 1.0) * clamp ((clamp ((0.0825 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_1.xyz;
  tmpvar_13 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_2.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_2.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_2.z;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
uniform highp float _DetailScale;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
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
  tmpvar_48 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_51;
  tmpvar_51 = mix (0.0, tmpvar_50, xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_51;
  lowp vec3 tmpvar_52;
  lowp vec4 packednormal_53;
  packednormal_53 = normal_7;
  tmpvar_52 = ((packednormal_53.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_54;
  tmpvar_54 = mix (tmpvar_52, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_54;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_55;
  mediump float lightShadowDataX_56;
  highp float dist_57;
  lowp float tmpvar_58;
  tmpvar_58 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = _LightShadowData.x;
  lightShadowDataX_56 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = max (float((dist_57 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_56);
  tmpvar_55 = tmpvar_60;
  mediump vec3 lightDir_61;
  lightDir_61 = xlv_TEXCOORD2;
  mediump float atten_62;
  atten_62 = tmpvar_55;
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
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD3));
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
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _DetailDist;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform highp vec4 glstate_lightmodel_ambient;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_7 - tmpvar_6);
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = clamp ((_DetailDist * sqrt(dot (p_10, p_10))), 0.0, 1.0);
  highp vec3 p_11;
  p_11 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - (1.003 * sqrt(dot (p_9, p_9)))), 0.0, 1.0) * clamp ((clamp ((0.0825 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_13 = tmpvar_1.xyz;
  tmpvar_14 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0].x = tmpvar_13.x;
  tmpvar_15[0].y = tmpvar_14.x;
  tmpvar_15[0].z = tmpvar_2.x;
  tmpvar_15[1].x = tmpvar_13.y;
  tmpvar_15[1].y = tmpvar_14.y;
  tmpvar_15[1].z = tmpvar_2.y;
  tmpvar_15[2].x = tmpvar_13.z;
  tmpvar_15[2].y = tmpvar_14.z;
  tmpvar_15[2].z = tmpvar_2.z;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_17;
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_12.zw;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = o_18;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
uniform highp float _DetailScale;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
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
  tmpvar_48 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_51;
  tmpvar_51 = mix (0.0, tmpvar_50, xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_51;
  lowp vec4 packednormal_52;
  packednormal_52 = normal_7;
  lowp vec3 normal_53;
  normal_53.xy = ((packednormal_52.wy * 2.0) - 1.0);
  normal_53.z = sqrt((1.0 - clamp (dot (normal_53.xy, normal_53.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_54;
  tmpvar_54 = mix (normal_53, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_54;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_55;
  tmpvar_55 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  mediump vec3 lightDir_56;
  lightDir_56 = xlv_TEXCOORD2;
  mediump float atten_57;
  atten_57 = tmpvar_55;
  mediump vec4 c_58;
  mediump float tmpvar_59;
  tmpvar_59 = clamp (dot (tmpvar_4, lightDir_56), 0.0, 1.0);
  highp vec3 tmpvar_60;
  tmpvar_60 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_59 * atten_57) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_3 * tmpvar_60);
  c_58.xyz = tmpvar_61;
  c_58.w = tmpvar_5;
  c_1 = c_58;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD3));
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
#line 419
struct Input {
    highp vec2 viewDist;
    highp vec3 viewDir;
    highp vec3 localPos;
};
#line 476
struct v2f_surf {
    highp vec4 pos;
    highp vec2 cust_viewDist;
    highp vec3 cust_localPos;
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
#line 426
#line 439
#line 486
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 426
void vert( inout appdata_full v, out Input o ) {
    highp vec3 normalDir = normalize((_Object2World * v.normal.xyzz).xyz);
    #line 430
    highp vec3 modelCam = _WorldSpaceCameraPos;
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 viewVect = normalize((vertexPos - modelCam));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 434
    highp float diff = (distance( origin, vertexPos) - (1.003 * distance( origin, _WorldSpaceCameraPos)));
    o.viewDist.x = xll_saturate_f((_DetailDist * distance( vertexPos, _WorldSpaceCameraPos)));
    o.viewDist.y = (xll_saturate_f(diff) * xll_saturate_f((xll_saturate_f((0.0825 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow)))));
    o.localPos = normalize(v.vertex.xyz);
}
#line 486
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 490
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 494
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 498
    o.lightDir = lightDir;
    o.vlight = glstate_lightmodel_ambient.xyz;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 502
    return o;
}

out highp vec2 xlv_TEXCOORD0;
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
    xlv_TEXCOORD0 = vec2(xl_retval.cust_viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
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
#line 419
struct Input {
    highp vec2 viewDist;
    highp vec3 viewDir;
    highp vec3 localPos;
};
#line 476
struct v2f_surf {
    highp vec4 pos;
    highp vec2 cust_viewDist;
    highp vec3 cust_localPos;
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
#line 426
#line 439
#line 486
#line 411
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    #line 413
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    #line 417
    return c;
}
#line 439
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 443
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 447
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 450
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 452
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    #line 456
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    #line 460
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    #line 464
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    #line 468
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = IN.viewDist.x;
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Albedo = albedo;
    #line 472
    mediump float avg = (mix( detail.w, 1.0, detailLevel) * main.w);
    o.Alpha = mix( 0.0, avg, IN.viewDist.y);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 504
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 506
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 510
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 514
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 518
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_viewDist = vec2(xlv_TEXCOORD0);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
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
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _DetailDist;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform highp vec4 glstate_lightmodel_ambient;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_7 - tmpvar_6);
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = clamp ((_DetailDist * sqrt(dot (p_10, p_10))), 0.0, 1.0);
  highp vec3 p_11;
  p_11 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - (1.003 * sqrt(dot (p_9, p_9)))), 0.0, 1.0) * clamp ((clamp ((0.0825 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_1.xyz;
  tmpvar_13 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_2.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_2.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_2.z;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
uniform highp float _DetailScale;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
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
  tmpvar_48 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_51;
  tmpvar_51 = mix (0.0, tmpvar_50, xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_51;
  lowp vec3 tmpvar_52;
  lowp vec4 packednormal_53;
  packednormal_53 = normal_7;
  tmpvar_52 = ((packednormal_53.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_54;
  tmpvar_54 = mix (tmpvar_52, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_54;
  tmpvar_2 = tmpvar_4;
  lowp float shadow_55;
  lowp float tmpvar_56;
  tmpvar_56 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_57;
  tmpvar_57 = (_LightShadowData.x + (tmpvar_56 * (1.0 - _LightShadowData.x)));
  shadow_55 = tmpvar_57;
  mediump vec3 lightDir_58;
  lightDir_58 = xlv_TEXCOORD2;
  mediump float atten_59;
  atten_59 = shadow_55;
  mediump vec4 c_60;
  mediump float tmpvar_61;
  tmpvar_61 = clamp (dot (tmpvar_4, lightDir_58), 0.0, 1.0);
  highp vec3 tmpvar_62;
  tmpvar_62 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_61 * atten_59) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_63;
  tmpvar_63 = (tmpvar_3 * tmpvar_62);
  c_60.xyz = tmpvar_63;
  c_60.w = tmpvar_5;
  c_1 = c_60;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD3));
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
#line 419
struct Input {
    highp vec2 viewDist;
    highp vec3 viewDir;
    highp vec3 localPos;
};
#line 476
struct v2f_surf {
    highp vec4 pos;
    highp vec2 cust_viewDist;
    highp vec3 cust_localPos;
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
#line 426
#line 439
#line 486
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 426
void vert( inout appdata_full v, out Input o ) {
    highp vec3 normalDir = normalize((_Object2World * v.normal.xyzz).xyz);
    #line 430
    highp vec3 modelCam = _WorldSpaceCameraPos;
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 viewVect = normalize((vertexPos - modelCam));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 434
    highp float diff = (distance( origin, vertexPos) - (1.003 * distance( origin, _WorldSpaceCameraPos)));
    o.viewDist.x = xll_saturate_f((_DetailDist * distance( vertexPos, _WorldSpaceCameraPos)));
    o.viewDist.y = (xll_saturate_f(diff) * xll_saturate_f((xll_saturate_f((0.0825 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow)))));
    o.localPos = normalize(v.vertex.xyz);
}
#line 486
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 490
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 494
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 498
    o.lightDir = lightDir;
    o.vlight = glstate_lightmodel_ambient.xyz;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 502
    return o;
}

out highp vec2 xlv_TEXCOORD0;
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
    xlv_TEXCOORD0 = vec2(xl_retval.cust_viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
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
#line 419
struct Input {
    highp vec2 viewDist;
    highp vec3 viewDir;
    highp vec3 localPos;
};
#line 476
struct v2f_surf {
    highp vec4 pos;
    highp vec2 cust_viewDist;
    highp vec3 cust_localPos;
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
#line 426
#line 439
#line 486
#line 411
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    #line 413
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    #line 417
    return c;
}
#line 439
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 443
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 447
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 450
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 452
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    #line 456
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    #line 460
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    #line 464
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    #line 468
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = IN.viewDist.x;
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Albedo = albedo;
    #line 472
    mediump float avg = (mix( detail.w, 1.0, detailLevel) * main.w);
    o.Alpha = mix( 0.0, avg, IN.viewDist.y);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 504
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 506
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 510
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 514
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 518
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_viewDist = vec2(xlv_TEXCOORD0);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
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
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _DetailDist;
uniform highp float _FalloffScale;
uniform highp float _FalloffPow;
uniform highp vec4 glstate_lightmodel_ambient;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_7 - tmpvar_6);
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = clamp ((_DetailDist * sqrt(dot (p_10, p_10))), 0.0, 1.0);
  highp vec3 p_11;
  p_11 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - (1.003 * sqrt(dot (p_9, p_9)))), 0.0, 1.0) * clamp ((clamp ((0.0825 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_1.xyz;
  tmpvar_13 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_2.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_2.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_2.z;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
uniform highp float _DetailScale;
uniform lowp vec4 _BumpOffset;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
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
  tmpvar_48 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_51;
  tmpvar_51 = mix (0.0, tmpvar_50, xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_51;
  lowp vec3 tmpvar_52;
  lowp vec4 packednormal_53;
  packednormal_53 = normal_7;
  tmpvar_52 = ((packednormal_53.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_54;
  tmpvar_54 = mix (tmpvar_52, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_54;
  tmpvar_2 = tmpvar_4;
  lowp float shadow_55;
  lowp float tmpvar_56;
  tmpvar_56 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_57;
  tmpvar_57 = (_LightShadowData.x + (tmpvar_56 * (1.0 - _LightShadowData.x)));
  shadow_55 = tmpvar_57;
  mediump vec3 lightDir_58;
  lightDir_58 = xlv_TEXCOORD2;
  mediump float atten_59;
  atten_59 = shadow_55;
  mediump vec4 c_60;
  mediump float tmpvar_61;
  tmpvar_61 = clamp (dot (tmpvar_4, lightDir_58), 0.0, 1.0);
  highp vec3 tmpvar_62;
  tmpvar_62 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_61 * atten_59) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_63;
  tmpvar_63 = (tmpvar_3 * tmpvar_62);
  c_60.xyz = tmpvar_63;
  c_60.w = tmpvar_5;
  c_1 = c_60;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD3));
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
#line 419
struct Input {
    highp vec2 viewDist;
    highp vec3 viewDir;
    highp vec3 localPos;
};
#line 476
struct v2f_surf {
    highp vec4 pos;
    highp vec2 cust_viewDist;
    highp vec3 cust_localPos;
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
#line 426
#line 439
#line 486
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 426
void vert( inout appdata_full v, out Input o ) {
    highp vec3 normalDir = normalize((_Object2World * v.normal.xyzz).xyz);
    #line 430
    highp vec3 modelCam = _WorldSpaceCameraPos;
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 viewVect = normalize((vertexPos - modelCam));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    #line 434
    highp float diff = (distance( origin, vertexPos) - (1.003 * distance( origin, _WorldSpaceCameraPos)));
    o.viewDist.x = xll_saturate_f((_DetailDist * distance( vertexPos, _WorldSpaceCameraPos)));
    o.viewDist.y = (xll_saturate_f(diff) * xll_saturate_f((xll_saturate_f((0.0825 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow)))));
    o.localPos = normalize(v.vertex.xyz);
}
#line 486
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 490
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 494
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 498
    o.lightDir = lightDir;
    o.vlight = glstate_lightmodel_ambient.xyz;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 502
    return o;
}

out highp vec2 xlv_TEXCOORD0;
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
    xlv_TEXCOORD0 = vec2(xl_retval.cust_viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
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
#line 419
struct Input {
    highp vec2 viewDist;
    highp vec3 viewDir;
    highp vec3 localPos;
};
#line 476
struct v2f_surf {
    highp vec4 pos;
    highp vec2 cust_viewDist;
    highp vec3 cust_localPos;
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
#line 426
#line 439
#line 486
#line 411
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    #line 413
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    #line 417
    return c;
}
#line 439
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 443
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 447
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 450
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 452
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    #line 456
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    #line 460
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    #line 464
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    #line 468
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = IN.viewDist.x;
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Albedo = albedo;
    #line 472
    mediump float avg = (mix( detail.w, 1.0, detailLevel) * main.w);
    o.Alpha = mix( 0.0, avg, IN.viewDist.y);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 504
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 506
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 510
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 514
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 518
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_viewDist = vec2(xlv_TEXCOORD0);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
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
//   d3d9 - ALU: 105 to 106, TEX: 9 to 10
//   d3d11 - ALU: 74 to 77, TEX: 6 to 7, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_DetailOffset]
Vector 3 [_BumpOffset]
Float 4 [_DetailScale]
Float 5 [_BumpScale]
Float 6 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_BumpMap] 2D
"ps_3_0
; 105 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c7, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c8, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c9, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c10, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c11, 0.15915494, 0.50000000, 2.00000000, -1.00000000
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
mul r0.xy, v1.zyzw, c4.x
add r1.xy, r0, c2
mul r0.zw, v1.xyxy, c4.x
add r0.xy, r0.zwzw, c2
mul r2.xy, v1.zxzw, c4.x
abs r2.zw, v1.xyxy
texld r0, r0, s1
texld r1, r1, s1
add_pp r1, r1, -r0
mad_pp r0, r2.z, r1, r0
add r2.xy, r2, c2
texld r1, r2, s1
add_pp r1, r1, -r0
mad_pp r0, r2.w, r1, r0
add_pp r1.xyz, -r0, c7.y
mad_pp r0.xyz, v0.x, r1, r0
mul r1.zw, v1.xyxy, c5.x
add r2.xy, r1.zwzw, c3
mul r1.xy, v1.zyzw, c5.x
add r1.xy, r1, c3
texld r3.yw, r2, s2
texld r1.yw, r1, s2
add_pp r1.xy, r1.ywzw, -r3.ywzw
abs r1.w, v1.z
mad_pp r2.xy, r2.z, r1, r3.ywzw
max r1.z, r1.w, r2
rcp r3.x, r1.z
min r1.z, r1.w, r2
mul r1.z, r1, r3.x
mul r1.xy, v1.zxzw, c5.x
add r1.xy, r1, c3
texld r3.yw, r1, s2
add_pp r1.xy, r3.ywzw, -r2
mul r3.x, r1.z, r1.z
mad_pp r1.xy, r2.w, r1, r2
mad r3.y, r3.x, c9, c9.z
mad r2.x, r3.y, r3, c9.w
mad r2.w, r2.x, r3.x, c10.x
mad_pp r1.xy, r1.yxzw, c11.z, c11.w
mul_pp r2.xy, r1, r1
add_pp_sat r2.y, r2.x, r2
mad r2.w, r2, r3.x, c10.y
mad r2.x, r2.w, r3, c10.z
mul r2.x, r2, r1.z
add_pp r2.y, -r2, c7
rsq_pp r3.x, r2.y
add r1.z, r1.w, -r2
add r2.y, -r2.x, c10.w
cmp r2.w, -r1.z, r2.x, r2.y
rcp_pp r1.z, r3.x
add_pp r2.xyz, -r1, c7.xxyw
mad_pp r1.xyz, v0.x, r2, r1
dp3_pp_sat r3.z, r1, v2
add r3.x, -r2.w, c8.w
cmp r2.w, v1.x, r2, r3.x
cmp r2.x, v1.z, r2.w, -r2.w
add r1.y, -r1.w, c7
mad r1.x, r1.w, c7.z, c7.w
mad r1.x, r1.w, r1, c8
mad r1.x, r1.w, r1, c8.y
abs r1.w, -v1.y
add r2.z, -r1.w, c7.y
mad r2.y, r1.w, c7.z, c7.w
mad r2.y, r2, r1.w, c8.x
rsq r1.y, r1.y
rcp r1.y, r1.y
mul r1.y, r1.x, r1
cmp r1.x, v1.z, c7, c7.y
mul r1.z, r1.x, r1.y
mad r1.z, -r1, c8, r1.y
rsq r2.z, r2.z
dsy r3.xy, v1
mad r1.w, r2.y, r1, c8.y
rcp r2.z, r2.z
mul r2.y, r1.w, r2.z
cmp r1.w, -v1.y, c7.x, c7.y
mul r2.z, r1.w, r2.y
mad r1.y, -r2.z, c8.z, r2
mad r1.z, r1.x, c8.w, r1
mad r1.x, r1.w, c8.w, r1.y
mul r1.y, r1.z, c9.x
dsx r1.w, r1.y
dsx r2.zw, v1.xyxy
mul r3.xy, r3, r3
add r1.z, r3.x, r3.y
mul r2.y, r1.x, c9.x
mul r2.zw, r2, r2
add r1.x, r2.z, r2.w
rsq r1.z, r1.z
rsq r1.x, r1.x
rcp r2.z, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c11.x
mad r2.x, r2, c11, c11.y
mul r1.x, r2.z, c11
dsy r1.y, r1
texldd r1, r2, s0, r1.zwzw, r1
mul r1, r1, c1
mul_pp r0.xyz, r1, r0
mul_pp r2.xyz, r3.z, c0
mul_pp r1.xyz, r2, c8.z
add_pp r2.x, -r0.w, c7.y
add_sat r1.xyz, r1, c6.x
mad_pp r0.w, v0.x, r2.x, r0
mul r1.xyz, r0, r1
mul_pp r0.w, r1, r0
mad_pp oC0.xyz, r0, v3, r1
mul_pp oC0.w, v0.y, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 120 used size, 12 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Vector 64 [_DetailOffset] 4
Vector 80 [_BumpOffset] 4
Float 104 [_DetailScale]
Float 112 [_BumpScale]
Float 116 [_MinLight]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
// 83 instructions, 5 temp regs, 0 temp arrays:
// ALU 70 float, 0 int, 4 uint
// TEX 6 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedhejmekcidfkobfiijmcedopjdbneammeabaaaaaameamaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefclmalaaaaeaaaaaaaopacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaadeaaaaajbcaabaaa
aaaaaaaaakbabaiaibaaaaaaacaaaaaackbabaiaibaaaaaaacaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaaddaaaaajccaabaaaaaaaaaaaakbabaiaibaaaaaaacaaaaaackbabaia
ibaaaaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaa
dgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaaaaaaaaaaakbabaia
ibaaaaaaacaaaaaackbabaiaibaaaaaaacaaaaaaabaaaaahecaabaaaaaaaaaaa
dkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaa
agbcbaaaacaaaaaaagbcbaiaebaaaaaaacaaaaaaabaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaaaaaaaaaaakbabaaaacaaaaaa
ckbabaaaacaaaaaadbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaaakbabaaaacaaaaaackbabaaa
acaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
idpjccdoabeaaaaaaaaaaadpalaaaaafdcaabaaaabaaaaaaegbabaaaacaaaaaa
apaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaelaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaa
aaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaaabaaaaaaagbebaaaacaaaaaa
apaaaaahicaabaaaaaaaaaaaogakbaaaabaaaaaaogakbaaaabaaaaaaelaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaa
aaaaaaaaabeaaaaaidpjccdodbaaaaaiicaabaaaaaaaaaaabkbabaiaebaaaaaa
acaaaaaabkbabaaaacaaaaaadcaaaabamcaabaaaabaaaaaafgbjbaiaibaaaaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaadagojjlmdagojjlmaceaaaaaaaaaaaaa
aaaaaaaachbgjidnchbgjidndcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaa
fgbjbaiaibaaaaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaiedefjloiedefjlo
dcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaakeanmjdpkeanmjdpaaaaaaalmcaabaaaacaaaaaa
fgbjbaiambaaaaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaiadp
elaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaadiaaaaahdcaabaaaadaaaaaa
ogakbaaaabaaaaaaogakbaaaacaaaaaadcaaaaapdcaabaaaadaaaaaaegaabaaa
adaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaaaaaaaaaaaaaceaaaaanlapejea
nlapejeaaaaaaaaaaaaaaaaaabaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaa
fgabbaaaadaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaa
acaaaaaackaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaabaaaaaa
ckaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaakgcaabaaaaaaaaaaapgaobaaa
aaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdoaaaaaaaaalaaaaafccaabaaa
abaaaaaackaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaackaabaaaaaaaaaaa
ejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaadcaaaaalpcaabaaaabaaaaaa
ggbcbaaaacaaaaaakgikcaaaaaaaaaaaagaaaaaaegiecaaaaaaaaaaaaeaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaaegbabaaaacaaaaaakgikcaaa
aaaaaaaaagaaaaaaegiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaa
egaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaa
acaaaaaaagbabaiaibaaaaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdcaaaaajpcaabaaaabaaaaaa
agbabaaaabaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaaaaaaaaaegbcbaaaaeaaaaaadcaaaaalpcaabaaaacaaaaaaggbcbaaa
acaaaaaaagiacaaaaaaaaaaaahaaaaaaegiecaaaaaaaaaaaafaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaalfcaabaaaacaaaaaaagbbbaaaacaaaaaaagiacaaaaaaaaaaa
ahaaaaaaagibcaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaaaeaaaaaaigaabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaaifcaabaaaacaaaaaa
pganbaaaadaaaaaapganbaiaebaaaaaaaeaaaaaadcaaaaakfcaabaaaacaaaaaa
agbabaiaibaaaaaaacaaaaaaagacbaaaacaaaaaapganbaaaaeaaaaaaaaaaaaai
kcaabaaaacaaaaaaagaibaiaebaaaaaaacaaaaaapgahbaaaacaaaaaadcaaaaak
dcaabaaaacaaaaaafgbfbaiaibaaaaaaacaaaaaangafbaaaacaaaaaaigaabaaa
acaaaaaadcaaaaapdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaadkaabaaaabaaaaaaaaaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaadcaaaaajhcaabaaa
acaaaaaaagbabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabacaaaah
icaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaadaaaaaaaaaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadccaaaalhcaabaaaacaaaaaa
egiccaaaaaaaaaaaabaaaaaapgapbaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaaaabaaaaaa
doaaaaab"
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
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_DetailOffset]
Vector 3 [_BumpOffset]
Float 4 [_DetailScale]
Float 5 [_BumpScale]
Float 6 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"ps_3_0
; 106 ALU, 10 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c7, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c8, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c9, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c10, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c11, 0.15915494, 0.50000000, 2.00000000, -1.00000000
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
mul r0.xy, v1.zyzw, c4.x
add r1.xy, r0, c2
mul r0.zw, v1.xyxy, c4.x
add r0.xy, r0.zwzw, c2
mul r2.xy, v1.zxzw, c4.x
abs r2.zw, v1.xyxy
texld r0, r0, s1
texld r1, r1, s1
add_pp r1, r1, -r0
mad_pp r0, r2.z, r1, r0
add r2.xy, r2, c2
texld r1, r2, s1
add_pp r1, r1, -r0
mad_pp r0, r2.w, r1, r0
add_pp r3.xyz, -r0, c7.y
mul r1.zw, v1.xyzy, c5.x
add r2.xy, r1.zwzw, c3
mul r1.xy, v1, c5.x
add r1.xy, r1, c3
texld r1.yw, r1, s2
texld r4.yw, r2, s2
add_pp r2.xy, r4.ywzw, -r1.ywzw
mad_pp r2.xy, r2.z, r2, r1.ywzw
abs r1.w, v1.z
mul r1.xy, v1.zxzw, c5.x
mad_pp r0.xyz, v0.x, r3, r0
max r1.z, r1.w, r2
add r1.xy, r1, c3
texld r3.yw, r1, s2
add_pp r1.xy, r3.ywzw, -r2
mad_pp r1.xy, r2.w, r1, r2
mad_pp r1.xy, r1.yxzw, c11.z, c11.w
mul_pp r2.xy, r1, r1
rcp r3.x, r1.z
min r1.z, r1.w, r2
mul r3.x, r1.z, r3
mul r1.z, r3.x, r3.x
mad r2.w, r1.z, c9.y, c9.z
add_pp_sat r2.y, r2.x, r2
mad r2.w, r2, r1.z, c9
mad r2.x, r2.w, r1.z, c10
mad r2.x, r2, r1.z, c10.y
add_pp r2.y, -r2, c7
mad r2.x, r2, r1.z, c10.z
rsq_pp r2.y, r2.y
rcp_pp r1.z, r2.y
mul r2.y, r2.x, r3.x
add_pp r3.xyz, -r1, c7.xxyw
mad_pp r1.xyz, v0.x, r3, r1
dp3_pp_sat r1.z, r1, v2
texldp r1.x, v4, s3
mul_pp r3.z, r1, r1.x
mad r1.x, r1.w, c7.z, c7.w
mad r1.x, r1.w, r1, c8
dsy r3.xy, v1
add r2.w, -r2.y, c10
add r2.x, r1.w, -r2.z
cmp r2.x, -r2, r2.y, r2.w
add r2.y, -r2.x, c8.w
cmp r1.y, v1.x, r2.x, r2
cmp r1.y, v1.z, r1, -r1
mad r2.x, r1.y, c11, c11.y
add r1.y, -r1.w, c7
mad r1.x, r1.w, r1, c8.y
abs r1.w, -v1.y
add r2.z, -r1.w, c7.y
mad r2.y, r1.w, c7.z, c7.w
mad r2.y, r2, r1.w, c8.x
rsq r1.y, r1.y
rcp r1.y, r1.y
mul r1.y, r1.x, r1
cmp r1.x, v1.z, c7, c7.y
mul r1.z, r1.x, r1.y
mad r1.z, -r1, c8, r1.y
rsq r2.z, r2.z
mad r1.w, r2.y, r1, c8.y
rcp r2.z, r2.z
mul r2.y, r1.w, r2.z
cmp r1.w, -v1.y, c7.x, c7.y
mul r2.z, r1.w, r2.y
mad r1.y, -r2.z, c8.z, r2
mad r1.z, r1.x, c8.w, r1
mad r1.x, r1.w, c8.w, r1.y
mul r1.y, r1.z, c9.x
dsx r1.w, r1.y
dsx r2.zw, v1.xyxy
mul r3.xy, r3, r3
add r1.z, r3.x, r3.y
mul r2.y, r1.x, c9.x
mul r2.zw, r2, r2
add r1.x, r2.z, r2.w
rsq r1.z, r1.z
rsq r1.x, r1.x
rcp r2.z, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c11.x
mul r1.x, r2.z, c11
dsy r1.y, r1
texldd r1, r2, s0, r1.zwzw, r1
mul r1, r1, c1
mul_pp r0.xyz, r1, r0
mul_pp r2.xyz, r3.z, c0
mul_pp r1.xyz, r2, c8.z
add_pp r2.x, -r0.w, c7.y
add_sat r1.xyz, r1, c6.x
mad_pp r0.w, v0.x, r2.x, r0
mul r1.xyz, r0, r1
mul_pp r0.w, r1, r0
mad_pp oC0.xyz, r0, v3, r1
mul_pp oC0.w, v0.y, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 184 used size, 13 vars
Vector 16 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Vector 144 [_BumpOffset] 4
Float 168 [_DetailScale]
Float 176 [_BumpScale]
Float 180 [_MinLight]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_DetailTex] 2D 2
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_ShadowMapTexture] 2D 0
// 87 instructions, 5 temp regs, 0 temp arrays:
// ALU 72 float, 0 int, 5 uint
// TEX 7 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedlcjpdldiibcefnaabcjlfejafjhinepkabaaaaaahaanaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfaamaaaa
eaaaaaaabeadaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaadcaaaaalpcaabaaa
aaaaaaaaggbcbaaaacaaaaaaagiacaaaaaaaaaaaalaaaaaaegiecaaaaaaaaaaa
ajaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaogakbaaaaaaaaaaaeghobaaa
acaaaaaaaagabaaaadaaaaaadcaaaaalfcaabaaaaaaaaaaaagbbbaaaacaaaaaa
agiacaaaaaaaaaaaalaaaaaaagibcaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaa
acaaaaaaigaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaaaaaaaaai
fcaabaaaaaaaaaaapganbaaaabaaaaaapganbaiaebaaaaaaacaaaaaadcaaaaak
fcaabaaaaaaaaaaaagbabaiaibaaaaaaacaaaaaaagacbaaaaaaaaaaapganbaaa
acaaaaaaaaaaaaaikcaabaaaaaaaaaaaagaibaiaebaaaaaaaaaaaaaapgahbaaa
aaaaaaaadcaaaaakdcaabaaaaaaaaaaafgbfbaiaibaaaaaaacaaaaaangafbaaa
aaaaaaaaigaabaaaaaaaaaaadcaaaaapdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaa
aaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaalhcaabaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaa
dcaaaaajhcaabaaaaaaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaa
aoaaaaahgcaabaaaaaaaaaaaagbbbaaaafaaaaaapgbpbaaaafaaaaaaefaaaaaj
pcaabaaaabaaaaaajgafbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaa
apaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaaagaabaaaabaaaaaadccaaaal
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaagaabaaaaaaaaaaafgifcaaa
aaaaaaaaalaaaaaadeaaaaajicaabaaaaaaaaaaaakbabaiaibaaaaaaacaaaaaa
ckbabaiaibaaaaaaacaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaddaaaaajbcaabaaaabaaaaaa
akbabaiaibaaaaaaacaaaaaackbabaiaibaaaaaaacaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajccaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaochgdidodcaaaaajccaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaebnkjlodcaaaaaj
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaadiphhpdp
diaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaaj
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaajecaabaaaabaaaaaaakbabaiaibaaaaaaacaaaaaackbabaiaibaaaaaa
acaaaaaaabaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaadbaaaaaidcaabaaaabaaaaaaigbabaaaacaaaaaaigbabaiaebaaaaaa
acaaaaaaabaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejma
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaddaaaaah
bcaabaaaabaaaaaaakbabaaaacaaaaaackbabaaaacaaaaaadbaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaadeaaaaahecaabaaa
abaaaaaaakbabaaaacaaaaaackbabaaaacaaaaaabnaaaaaiecaabaaaabaaaaaa
ckaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaaabaaaaahbcaabaaaabaaaaaa
ckaabaaaabaaaaaaakaabaaaabaaaaaadhaaaaakicaabaaaaaaaaaaaakaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajbcaabaaa
acaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaaf
fcaabaaaabaaaaaaagbbbaaaacaaaaaaapaaaaahicaabaaaaaaaaaaaigaabaaa
abaaaaaaigaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahbcaabaaaadaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaaf
fcaabaaaabaaaaaaagbbbaaaacaaaaaaapaaaaahicaabaaaaaaaaaaaigaabaaa
abaaaaaaigaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahbcaabaaaaeaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdodbaaaaai
icaabaaaaaaaaaaabkbabaiaebaaaaaaacaaaaaabkbabaaaacaaaaaadcaaaaba
fcaabaaaabaaaaaafgbgbaiaibaaaaaaacaaaaaaaceaaaaadagojjlmaaaaaaaa
dagojjlmaaaaaaaaaceaaaaachbgjidnaaaaaaaachbgjidnaaaaaaaadcaaaaan
fcaabaaaabaaaaaaagacbaaaabaaaaaafgbgbaiaibaaaaaaacaaaaaaaceaaaaa
iedefjloaaaaaaaaiedefjloaaaaaaaadcaaaaanfcaabaaaabaaaaaaagacbaaa
abaaaaaafgbgbaiaibaaaaaaacaaaaaaaceaaaaakeanmjdpaaaaaaaakeanmjdp
aaaaaaaaaaaaaaalmcaabaaaacaaaaaafgbjbaiambaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaa
acaaaaaadiaaaaahmcaabaaaadaaaaaaagaibaaaabaaaaaakgaobaaaacaaaaaa
dcaaaaapmcaabaaaadaaaaaakgaobaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaamaaaaaaamaaceaaaaaaaaaaaaaaaaaaaaanlapejeanlapejeaabaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaadaaaaaaabaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaadkaabaaaadaaaaaadcaaaaajccaabaaaabaaaaaa
ckaabaaaabaaaaaadkaabaaaacaaaaaabkaabaaaabaaaaaadcaaaaajicaabaaa
aaaaaaaaakaabaaaabaaaaaackaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaah
ccaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjkcdodiaaaaahicaabaaa
aaaaaaaabkaabaaaabaaaaaaabeaaaaaidpjkcdoalaaaaafccaabaaaadaaaaaa
dkaabaaaaaaaaaaaamaaaaafccaabaaaaeaaaaaadkaabaaaaaaaaaaaejaaaaan
pcaabaaaabaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
egaabaaaadaaaaaaegaabaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaaahaaaaaadcaaaaalpcaabaaaacaaaaaaggbcbaaa
acaaaaaakgikcaaaaaaaaaaaakaaaaaaegiecaaaaaaaaaaaaiaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaaldcaabaaaaeaaaaaaegbabaaaacaaaaaakgikcaaaaaaaaaaa
akaaaaaaegiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaadaaaaaa
egaobaaaadaaaaaaegaobaiaebaaaaaaaeaaaaaadcaaaaakpcaabaaaadaaaaaa
agbabaiaibaaaaaaacaaaaaaegaobaaaadaaaaaaegaobaaaaeaaaaaaaaaaaaai
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaak
pcaabaaaacaaaaaafgbfbaiaibaaaaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaaaaaaaaalpcaabaaaadaaaaaaegaobaiaebaaaaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdcaaaaajpcaabaaaacaaaaaaagbabaaa
abaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
abaaaaaaegbcbaaaaeaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
abaaaaaabkbabaaaabaaaaaadoaaaaab"
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

#LINE 115

	
	}
	
	 
	FallBack "Diffuse"
}
