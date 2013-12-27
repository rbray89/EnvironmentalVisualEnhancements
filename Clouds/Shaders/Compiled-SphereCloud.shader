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
	}

SubShader {
		Tags {  "Queue"="Transparent"
	   			"RenderMode"="Transparent" }
		Lighting On
		Cull Back
	    ZWrite Off
		
		Blend SrcAlpha OneMinusSrcAlpha
		
			
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
Program "vp" {
// Vertex combos: 6
//   d3d9 - ALU: 51 to 56
//   d3d11 - ALU: 40 to 43, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform float _DetailDist;

uniform vec4 unity_Scale;
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
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.x = (_DetailDist * sqrt(dot (p_4, p_4)));
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_6;
  p_6 = (tmpvar_3 - tmpvar_2);
  tmpvar_1.y = clamp ((sqrt(dot (p_5, p_5)) - (1.00025 * sqrt(dot (p_6, p_6)))), 0.0, 1.0);
  vec3 tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_7 = TANGENT.xyz;
  tmpvar_8 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = gl_Normal.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = gl_Normal.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = gl_Normal.z;
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (tmpvar_9 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD3 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD4 = gl_LightModel.ambient.xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _MinLight;
uniform float _BumpScale;
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
void main ()
{
  vec4 c_1;
  vec2 uv_2;
  float r_3;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD2.z / xlv_TEXCOORD2.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD2.z) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD2.y);
  uv_2.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD2.y / xlv_TEXCOORD2.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD2.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD2.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD2.z))) * (1.5708 + (abs(xlv_TEXCOORD2.z) * (-0.214602 + (abs(xlv_TEXCOORD2.z) * (0.0865667 + (abs(xlv_TEXCOORD2.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD2.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD2.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec4 tmpvar_16;
  tmpvar_16 = (texture2DGradARB (_MainTex, uv_2, tmpvar_15.xy, tmpvar_15.zw) * _Color);
  vec3 tmpvar_17;
  tmpvar_17 = abs(xlv_TEXCOORD2);
  vec4 tmpvar_18;
  tmpvar_18 = mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD2.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD2.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_17.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD2.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_17.yyyy);
  float tmpvar_19;
  tmpvar_19 = clamp ((2.0 * xlv_TEXCOORD1.x), 0.0, 1.0);
  vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_16.xyz * mix (tmpvar_18.xyz, vec3(1.0, 1.0, 1.0), vec3(tmpvar_19)));
  vec3 normal_21;
  normal_21.xy = ((mix (mix (texture2D (_BumpMap, ((xlv_TEXCOORD2.xy * _BumpScale) + _BumpOffset.xy)), texture2D (_BumpMap, ((xlv_TEXCOORD2.zy * _BumpScale) + _BumpOffset.xy)), tmpvar_17.xxxx), texture2D (_BumpMap, ((xlv_TEXCOORD2.zx * _BumpScale) + _BumpOffset.xy)), tmpvar_17.yyyy).wy * 2.0) - 1.0);
  normal_21.z = sqrt((1.0 - clamp (dot (normal_21.xy, normal_21.xy), 0.0, 1.0)));
  vec4 c_22;
  c_22.xyz = (tmpvar_20 * clamp ((_MinLight + (_LightColor0.xyz * (clamp (dot (mix (normal_21, vec3(0.0, 0.0, 1.0), vec3(tmpvar_19)), xlv_TEXCOORD3), 0.0, 1.0) * 2.0))), 0.0, 1.0));
  c_22.w = mix (0.0, (tmpvar_16.w * mix (tmpvar_18.w, 1.0, tmpvar_19)), (xlv_TEXCOORD1.y * clamp (((1.0 - xlv_TEXCOORD1.y) + clamp (pow ((_FalloffScale * clamp (normalize(xlv_TEXCOORD0).z, 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), 0.0, 1.0)));
  c_1.w = c_22.w;
  c_1.xyz = (c_22.xyz + (tmpvar_20 * xlv_TEXCOORD4));
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
Float 16 [_DetailDist]
"vs_3_0
; 51 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c17, 1.00000000, 1.00024998, 0, 0
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
mov r1.w, c17.x
mov r1.xyz, c13
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
mov r1, c8
dp4 r4.x, c14, r1
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp3 o1.y, r2, r3
dp3 o1.z, v2, r2
dp3 o1.x, r2, v1
add r2.xyz, -r0, c13
add r0.xyz, r1, -r0
dp3 r0.x, r0, r0
dp3 r0.w, r2, r2
rsq r0.y, r0.w
rsq r0.x, r0.x
rcp r0.y, r0.y
rcp r0.x, r0.x
mad_sat o2.y, -r0.x, c17, r0
add r0.xyz, -r1, c13
dp3 r0.x, r0, r0
rsq r0.x, r0.x
dp3 r0.y, v0, v0
rcp r0.x, r0.x
rsq r0.y, r0.y
dp3 o4.y, r3, r4
dp3 o4.z, v2, r4
dp3 o4.x, v1, r4
mul o2.x, r0, c16
mul o3.xyz, r0.y, v0
mov o5.xyz, c12
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
Float 108 [_DetailDist]
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
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 42 instructions, 3 temp regs, 0 temp arrays:
// ALU 40 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhholcncdoadlmcjpmaeeeblcbmfchepmabaaaaaanmahaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcciagaaaaeaaaabaaikabaaaafjaaaaae
egiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafjaaaaae
egiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
adaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaa
aaaaaaaabaaaaaahcccabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbccabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
eccabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
egiccaaaadaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaibccabaaaacaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaagaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadccaaaakcccabaaaacaaaaaaakaabaia
ebaaaaaaabaaaaaaabeaaaaadbaiiadpdkaabaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaa
aaaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaafaaaaaaegiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _DetailDist;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = (_DetailDist * sqrt(dot (p_8, p_8)));
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_7 - tmpvar_6);
  tmpvar_5.y = clamp ((sqrt(dot (p_9, p_9)) - (1.00025 * sqrt(dot (p_10, p_10)))), 0.0, 1.0);
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_1.xyz;
  tmpvar_12 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_2.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_2.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (tmpvar_13 * (((_World2Object * tmpvar_15).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
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
  mediump float rim_6;
  mediump float detailLevel_7;
  mediump vec4 normal_8;
  mediump vec4 detail_9;
  mediump vec4 normalZ_10;
  mediump vec4 normalY_11;
  mediump vec4 normalX_12;
  mediump vec4 detailZ_13;
  mediump vec4 detailY_14;
  mediump vec4 detailX_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  highp float r_18;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.z)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD2.z / xlv_TEXCOORD2.x);
    float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.z >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD2.z) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_18));
  highp float x_22;
  x_22 = -(xlv_TEXCOORD2.y);
  uv_17.y = (0.31831 * (1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD2.y / xlv_TEXCOORD2.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD2.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD2.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD2.z))) * (1.5708 + (abs(xlv_TEXCOORD2.z) * (-0.214602 + (abs(xlv_TEXCOORD2.z) * (0.0865667 + (abs(xlv_TEXCOORD2.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD2.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD2.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = (texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw) * _Color);
  main_16 = tmpvar_31;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = ((xlv_TEXCOORD2.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_32 = texture2D (_DetailTex, P_33);
  detailX_15 = tmpvar_32;
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = ((xlv_TEXCOORD2.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_34 = texture2D (_DetailTex, P_35);
  detailY_14 = tmpvar_34;
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = ((xlv_TEXCOORD2.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_36 = texture2D (_DetailTex, P_37);
  detailZ_13 = tmpvar_36;
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = ((xlv_TEXCOORD2.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_38 = texture2D (_BumpMap, P_39);
  normalX_12 = tmpvar_38;
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = ((xlv_TEXCOORD2.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_40 = texture2D (_BumpMap, P_41);
  normalY_11 = tmpvar_40;
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = ((xlv_TEXCOORD2.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_42 = texture2D (_BumpMap, P_43);
  normalZ_10 = tmpvar_42;
  highp vec3 tmpvar_44;
  tmpvar_44 = abs(xlv_TEXCOORD2);
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detailZ_13, detailX_15, tmpvar_44.xxxx);
  detail_9 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (detail_9, detailY_14, tmpvar_44.yyyy);
  detail_9 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normalZ_10, normalX_12, tmpvar_44.xxxx);
  normal_8 = tmpvar_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = mix (normal_8, normalY_11, tmpvar_44.yyyy);
  normal_8 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp ((2.0 * xlv_TEXCOORD1.x), 0.0, 1.0);
  detailLevel_7 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = (main_16.xyz * mix (detail_9.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_7)));
  tmpvar_3 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = (main_16.w * mix (detail_9.w, 1.0, detailLevel_7));
  highp float tmpvar_52;
  tmpvar_52 = clamp (normalize(xlv_TEXCOORD0).z, 0.0, 1.0);
  rim_6 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_51, (xlv_TEXCOORD1.y * clamp (((1.0 - xlv_TEXCOORD1.y) + clamp (pow ((_FalloffScale * rim_6), _FalloffPow), 0.0, 1.0)), 0.0, 1.0)));
  tmpvar_5 = tmpvar_53;
  lowp vec3 tmpvar_54;
  lowp vec4 packednormal_55;
  packednormal_55 = normal_8;
  tmpvar_54 = ((packednormal_55.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_56;
  tmpvar_56 = mix (tmpvar_54, vec3(0.0, 0.0, 1.0), vec3(detailLevel_7));
  tmpvar_4 = tmpvar_56;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_57;
  lightDir_57 = xlv_TEXCOORD3;
  mediump vec4 c_58;
  mediump float tmpvar_59;
  tmpvar_59 = clamp (dot (tmpvar_4, lightDir_57), 0.0, 1.0);
  highp vec3 tmpvar_60;
  tmpvar_60 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_59 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_3 * tmpvar_60);
  c_58.xyz = tmpvar_61;
  c_58.w = tmpvar_5;
  c_1 = c_58;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD4));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _DetailDist;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = (_DetailDist * sqrt(dot (p_8, p_8)));
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_7 - tmpvar_6);
  tmpvar_5.y = clamp ((sqrt(dot (p_9, p_9)) - (1.00025 * sqrt(dot (p_10, p_10)))), 0.0, 1.0);
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_1.xyz;
  tmpvar_12 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_2.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_2.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (tmpvar_13 * (((_World2Object * tmpvar_15).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
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
  mediump float rim_6;
  mediump float detailLevel_7;
  mediump vec4 normal_8;
  mediump vec4 detail_9;
  mediump vec4 normalZ_10;
  mediump vec4 normalY_11;
  mediump vec4 normalX_12;
  mediump vec4 detailZ_13;
  mediump vec4 detailY_14;
  mediump vec4 detailX_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  highp float r_18;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.z)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD2.z / xlv_TEXCOORD2.x);
    float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.z >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD2.z) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_18));
  highp float x_22;
  x_22 = -(xlv_TEXCOORD2.y);
  uv_17.y = (0.31831 * (1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD2.y / xlv_TEXCOORD2.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD2.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD2.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD2.z))) * (1.5708 + (abs(xlv_TEXCOORD2.z) * (-0.214602 + (abs(xlv_TEXCOORD2.z) * (0.0865667 + (abs(xlv_TEXCOORD2.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD2.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD2.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = (texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw) * _Color);
  main_16 = tmpvar_31;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = ((xlv_TEXCOORD2.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_32 = texture2D (_DetailTex, P_33);
  detailX_15 = tmpvar_32;
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = ((xlv_TEXCOORD2.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_34 = texture2D (_DetailTex, P_35);
  detailY_14 = tmpvar_34;
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = ((xlv_TEXCOORD2.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_36 = texture2D (_DetailTex, P_37);
  detailZ_13 = tmpvar_36;
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = ((xlv_TEXCOORD2.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_38 = texture2D (_BumpMap, P_39);
  normalX_12 = tmpvar_38;
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = ((xlv_TEXCOORD2.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_40 = texture2D (_BumpMap, P_41);
  normalY_11 = tmpvar_40;
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = ((xlv_TEXCOORD2.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_42 = texture2D (_BumpMap, P_43);
  normalZ_10 = tmpvar_42;
  highp vec3 tmpvar_44;
  tmpvar_44 = abs(xlv_TEXCOORD2);
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detailZ_13, detailX_15, tmpvar_44.xxxx);
  detail_9 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (detail_9, detailY_14, tmpvar_44.yyyy);
  detail_9 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normalZ_10, normalX_12, tmpvar_44.xxxx);
  normal_8 = tmpvar_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = mix (normal_8, normalY_11, tmpvar_44.yyyy);
  normal_8 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp ((2.0 * xlv_TEXCOORD1.x), 0.0, 1.0);
  detailLevel_7 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = (main_16.xyz * mix (detail_9.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_7)));
  tmpvar_3 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = (main_16.w * mix (detail_9.w, 1.0, detailLevel_7));
  highp float tmpvar_52;
  tmpvar_52 = clamp (normalize(xlv_TEXCOORD0).z, 0.0, 1.0);
  rim_6 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_51, (xlv_TEXCOORD1.y * clamp (((1.0 - xlv_TEXCOORD1.y) + clamp (pow ((_FalloffScale * rim_6), _FalloffPow), 0.0, 1.0)), 0.0, 1.0)));
  tmpvar_5 = tmpvar_53;
  lowp vec4 packednormal_54;
  packednormal_54 = normal_8;
  lowp vec3 normal_55;
  normal_55.xy = ((packednormal_54.wy * 2.0) - 1.0);
  normal_55.z = sqrt((1.0 - clamp (dot (normal_55.xy, normal_55.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_56;
  tmpvar_56 = mix (normal_55, vec3(0.0, 0.0, 1.0), vec3(detailLevel_7));
  tmpvar_4 = tmpvar_56;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_57;
  lightDir_57 = xlv_TEXCOORD3;
  mediump vec4 c_58;
  mediump float tmpvar_59;
  tmpvar_59 = clamp (dot (tmpvar_4, lightDir_57), 0.0, 1.0);
  highp vec3 tmpvar_60;
  tmpvar_60 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_59 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_3 * tmpvar_60);
  c_58.xyz = tmpvar_61;
  c_58.w = tmpvar_5;
  c_1 = c_58;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD4));
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
#line 467
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
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
#line 439
#line 477
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
#line 418
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 422
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float diff = (_DetailDist * distance( vertexPos, _WorldSpaceCameraPos));
    o.viewDist.x = diff;
    o.viewDist.y = xll_saturate_f((distance( origin, _WorldSpaceCameraPos) - (1.00025 * distance( origin, vertexPos))));
    #line 426
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
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o.vlight = glstate_lightmodel_ambient.xyz;
    #line 494
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
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
    xlv_TEXCOORD1 = vec2(xl_retval.cust_viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD3 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD4 = vec3(xl_retval.vlight);
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
#line 467
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
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
#line 439
#line 477
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
#line 428
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 430
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 434
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
#line 439
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    #line 443
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 447
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    #line 451
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    #line 455
    detail = mix( detail, detailY, vec4( pos.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = xll_saturate_f((2.0 * IN.viewDist.x));
    #line 459
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Albedo = albedo;
    mediump float avg = (main.w * mix( detail.w, 1.0, detailLevel));
    #line 463
    mediump float rim = xll_saturate_f(dot( normalize(IN.viewDir), o.Normal));
    o.Alpha = mix( 0.0, avg, (IN.viewDist.y * xll_saturate_f(((1.0 - IN.viewDist.y) + xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow))))));
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 496
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 498
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.localPos = IN.cust_localPos;
    surfIN.viewDir = IN.viewDir;
    #line 502
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 506
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = 1.0;
    #line 510
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_viewDist = vec2(xlv_TEXCOORD1);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD2);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD3);
    xlt_IN.vlight = vec3(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform float _DetailDist;

uniform vec4 unity_Scale;
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
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.x = (_DetailDist * sqrt(dot (p_4, p_4)));
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_6;
  p_6 = (tmpvar_3 - tmpvar_2);
  tmpvar_1.y = clamp ((sqrt(dot (p_5, p_5)) - (1.00025 * sqrt(dot (p_6, p_6)))), 0.0, 1.0);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
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
  vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  vec4 o_12;
  vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_7 * 0.5);
  vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = (tmpvar_10 * (((_World2Object * tmpvar_11).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD3 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD4 = gl_LightModel.ambient.xyz;
  xlv_TEXCOORD5 = o_12;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _MinLight;
uniform float _BumpScale;
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
void main ()
{
  vec4 c_1;
  vec2 uv_2;
  float r_3;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD2.z / xlv_TEXCOORD2.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD2.z) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD2.y);
  uv_2.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD2.y / xlv_TEXCOORD2.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD2.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD2.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD2.z))) * (1.5708 + (abs(xlv_TEXCOORD2.z) * (-0.214602 + (abs(xlv_TEXCOORD2.z) * (0.0865667 + (abs(xlv_TEXCOORD2.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD2.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD2.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec4 tmpvar_16;
  tmpvar_16 = (texture2DGradARB (_MainTex, uv_2, tmpvar_15.xy, tmpvar_15.zw) * _Color);
  vec3 tmpvar_17;
  tmpvar_17 = abs(xlv_TEXCOORD2);
  vec4 tmpvar_18;
  tmpvar_18 = mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD2.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD2.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_17.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD2.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_17.yyyy);
  float tmpvar_19;
  tmpvar_19 = clamp ((2.0 * xlv_TEXCOORD1.x), 0.0, 1.0);
  vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_16.xyz * mix (tmpvar_18.xyz, vec3(1.0, 1.0, 1.0), vec3(tmpvar_19)));
  vec3 normal_21;
  normal_21.xy = ((mix (mix (texture2D (_BumpMap, ((xlv_TEXCOORD2.xy * _BumpScale) + _BumpOffset.xy)), texture2D (_BumpMap, ((xlv_TEXCOORD2.zy * _BumpScale) + _BumpOffset.xy)), tmpvar_17.xxxx), texture2D (_BumpMap, ((xlv_TEXCOORD2.zx * _BumpScale) + _BumpOffset.xy)), tmpvar_17.yyyy).wy * 2.0) - 1.0);
  normal_21.z = sqrt((1.0 - clamp (dot (normal_21.xy, normal_21.xy), 0.0, 1.0)));
  vec4 c_22;
  c_22.xyz = (tmpvar_20 * clamp ((_MinLight + (_LightColor0.xyz * ((clamp (dot (mix (normal_21, vec3(0.0, 0.0, 1.0), vec3(tmpvar_19)), xlv_TEXCOORD3), 0.0, 1.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x) * 2.0))), 0.0, 1.0));
  c_22.w = mix (0.0, (tmpvar_16.w * mix (tmpvar_18.w, 1.0, tmpvar_19)), (xlv_TEXCOORD1.y * clamp (((1.0 - xlv_TEXCOORD1.y) + clamp (pow ((_FalloffScale * clamp (normalize(xlv_TEXCOORD0).z, 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), 0.0, 1.0)));
  c_1.w = c_22.w;
  c_1.xyz = (c_22.xyz + (tmpvar_20 * xlv_TEXCOORD4));
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
Float 18 [_DetailDist]
"vs_3_0
; 56 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c19, 1.00000000, 1.00024998, 0.50000000, 0
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
mov r1.w, c19.x
mov r1.xyz, c13
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c17.w, -v0
mov r1, c8
dp4 r4.x, c16, r1
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp3 o1.y, r2, r3
dp3 o1.z, v2, r2
dp3 o1.x, r2, v1
add r2.xyz, -r0, c13
add r0.xyz, r1, -r0
dp3 r0.x, r0, r0
dp3 r0.w, r2, r2
rsq r0.y, r0.w
rsq r0.x, r0.x
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad_sat o2.y, -r0.x, c19, r0
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c19.z
mov o0, r0
mul r2.y, r2, c14.x
add r1.xyz, -r1, c13
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp3 r0.y, v0, v0
rcp r0.x, r0.x
rsq r0.y, r0.y
dp3 o4.y, r3, r4
dp3 o4.z, v2, r4
dp3 o4.x, v1, r4
mad o6.xy, r2.z, c15.zwzw, r2
mov o6.zw, r0
mul o2.x, r0, c18
mul o3.xyz, r0.y, v0
mov o5.xyz, c12
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "color" Color
ConstBuffer "$Globals" 192 // 176 used size, 13 vars
Float 172 [_DetailDist]
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
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 47 instructions, 4 temp regs, 0 temp arrays:
// ALU 43 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedgphmmfjjokppmnejikfpihjbmnjbbcekabaaaaaaimaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcmaagaaaaeaaaabaalaabaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafjaaaaaeegiocaaaaeaaaaaa
afaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
acaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaa
acaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaa
abaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaabaaaaaa
egbcbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaajhcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaaegiccaaaadaaaaaa
apaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaaibccabaaa
acaaaaaaakaabaaaacaaaaaadkiacaaaaaaaaaaaakaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadccaaaakcccabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaa
abeaaaaadbaiiadpdkaabaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaa
aaaaaaaaegbcbaaaaaaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhccabaaaadaaaaaapgapbaaaabaaaaaaegbcbaaaaaaaaaaadiaaaaaj
hcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
acaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
eccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadgaaaaaghccabaaa
afaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
agaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _DetailDist;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = (_DetailDist * sqrt(dot (p_8, p_8)));
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_7 - tmpvar_6);
  tmpvar_5.y = clamp ((sqrt(dot (p_9, p_9)) - (1.00025 * sqrt(dot (p_10, p_10)))), 0.0, 1.0);
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_1.xyz;
  tmpvar_12 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_2.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_2.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (tmpvar_13 * (((_World2Object * tmpvar_15).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
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
  mediump float rim_6;
  mediump float detailLevel_7;
  mediump vec4 normal_8;
  mediump vec4 detail_9;
  mediump vec4 normalZ_10;
  mediump vec4 normalY_11;
  mediump vec4 normalX_12;
  mediump vec4 detailZ_13;
  mediump vec4 detailY_14;
  mediump vec4 detailX_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  highp float r_18;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.z)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD2.z / xlv_TEXCOORD2.x);
    float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.z >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD2.z) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_18));
  highp float x_22;
  x_22 = -(xlv_TEXCOORD2.y);
  uv_17.y = (0.31831 * (1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD2.y / xlv_TEXCOORD2.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD2.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD2.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD2.z))) * (1.5708 + (abs(xlv_TEXCOORD2.z) * (-0.214602 + (abs(xlv_TEXCOORD2.z) * (0.0865667 + (abs(xlv_TEXCOORD2.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD2.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD2.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = (texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw) * _Color);
  main_16 = tmpvar_31;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = ((xlv_TEXCOORD2.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_32 = texture2D (_DetailTex, P_33);
  detailX_15 = tmpvar_32;
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = ((xlv_TEXCOORD2.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_34 = texture2D (_DetailTex, P_35);
  detailY_14 = tmpvar_34;
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = ((xlv_TEXCOORD2.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_36 = texture2D (_DetailTex, P_37);
  detailZ_13 = tmpvar_36;
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = ((xlv_TEXCOORD2.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_38 = texture2D (_BumpMap, P_39);
  normalX_12 = tmpvar_38;
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = ((xlv_TEXCOORD2.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_40 = texture2D (_BumpMap, P_41);
  normalY_11 = tmpvar_40;
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = ((xlv_TEXCOORD2.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_42 = texture2D (_BumpMap, P_43);
  normalZ_10 = tmpvar_42;
  highp vec3 tmpvar_44;
  tmpvar_44 = abs(xlv_TEXCOORD2);
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detailZ_13, detailX_15, tmpvar_44.xxxx);
  detail_9 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (detail_9, detailY_14, tmpvar_44.yyyy);
  detail_9 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normalZ_10, normalX_12, tmpvar_44.xxxx);
  normal_8 = tmpvar_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = mix (normal_8, normalY_11, tmpvar_44.yyyy);
  normal_8 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp ((2.0 * xlv_TEXCOORD1.x), 0.0, 1.0);
  detailLevel_7 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = (main_16.xyz * mix (detail_9.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_7)));
  tmpvar_3 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = (main_16.w * mix (detail_9.w, 1.0, detailLevel_7));
  highp float tmpvar_52;
  tmpvar_52 = clamp (normalize(xlv_TEXCOORD0).z, 0.0, 1.0);
  rim_6 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_51, (xlv_TEXCOORD1.y * clamp (((1.0 - xlv_TEXCOORD1.y) + clamp (pow ((_FalloffScale * rim_6), _FalloffPow), 0.0, 1.0)), 0.0, 1.0)));
  tmpvar_5 = tmpvar_53;
  lowp vec3 tmpvar_54;
  lowp vec4 packednormal_55;
  packednormal_55 = normal_8;
  tmpvar_54 = ((packednormal_55.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_56;
  tmpvar_56 = mix (tmpvar_54, vec3(0.0, 0.0, 1.0), vec3(detailLevel_7));
  tmpvar_4 = tmpvar_56;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_57;
  mediump float lightShadowDataX_58;
  highp float dist_59;
  lowp float tmpvar_60;
  tmpvar_60 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  dist_59 = tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = _LightShadowData.x;
  lightShadowDataX_58 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = max (float((dist_59 > (xlv_TEXCOORD5.z / xlv_TEXCOORD5.w))), lightShadowDataX_58);
  tmpvar_57 = tmpvar_62;
  mediump vec3 lightDir_63;
  lightDir_63 = xlv_TEXCOORD3;
  mediump float atten_64;
  atten_64 = tmpvar_57;
  mediump vec4 c_65;
  mediump float tmpvar_66;
  tmpvar_66 = clamp (dot (tmpvar_4, lightDir_63), 0.0, 1.0);
  highp vec3 tmpvar_67;
  tmpvar_67 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_66 * atten_64) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_68;
  tmpvar_68 = (tmpvar_3 * tmpvar_67);
  c_65.xyz = tmpvar_68;
  c_65.w = tmpvar_5;
  c_1 = c_65;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD4));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _DetailDist;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = (_DetailDist * sqrt(dot (p_8, p_8)));
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_7 - tmpvar_6);
  tmpvar_5.y = clamp ((sqrt(dot (p_9, p_9)) - (1.00025 * sqrt(dot (p_10, p_10)))), 0.0, 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (glstate_matrix_mvp * _glesVertex);
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
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_17;
  tmpvar_17 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_17;
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_11.zw;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = (tmpvar_14 * (((_World2Object * tmpvar_16).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = o_18;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
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
  mediump float rim_6;
  mediump float detailLevel_7;
  mediump vec4 normal_8;
  mediump vec4 detail_9;
  mediump vec4 normalZ_10;
  mediump vec4 normalY_11;
  mediump vec4 normalX_12;
  mediump vec4 detailZ_13;
  mediump vec4 detailY_14;
  mediump vec4 detailX_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  highp float r_18;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.z)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD2.z / xlv_TEXCOORD2.x);
    float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.z >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD2.z) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_18));
  highp float x_22;
  x_22 = -(xlv_TEXCOORD2.y);
  uv_17.y = (0.31831 * (1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD2.y / xlv_TEXCOORD2.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD2.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD2.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD2.z))) * (1.5708 + (abs(xlv_TEXCOORD2.z) * (-0.214602 + (abs(xlv_TEXCOORD2.z) * (0.0865667 + (abs(xlv_TEXCOORD2.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD2.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD2.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = (texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw) * _Color);
  main_16 = tmpvar_31;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = ((xlv_TEXCOORD2.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_32 = texture2D (_DetailTex, P_33);
  detailX_15 = tmpvar_32;
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = ((xlv_TEXCOORD2.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_34 = texture2D (_DetailTex, P_35);
  detailY_14 = tmpvar_34;
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = ((xlv_TEXCOORD2.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_36 = texture2D (_DetailTex, P_37);
  detailZ_13 = tmpvar_36;
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = ((xlv_TEXCOORD2.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_38 = texture2D (_BumpMap, P_39);
  normalX_12 = tmpvar_38;
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = ((xlv_TEXCOORD2.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_40 = texture2D (_BumpMap, P_41);
  normalY_11 = tmpvar_40;
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = ((xlv_TEXCOORD2.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_42 = texture2D (_BumpMap, P_43);
  normalZ_10 = tmpvar_42;
  highp vec3 tmpvar_44;
  tmpvar_44 = abs(xlv_TEXCOORD2);
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detailZ_13, detailX_15, tmpvar_44.xxxx);
  detail_9 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (detail_9, detailY_14, tmpvar_44.yyyy);
  detail_9 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normalZ_10, normalX_12, tmpvar_44.xxxx);
  normal_8 = tmpvar_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = mix (normal_8, normalY_11, tmpvar_44.yyyy);
  normal_8 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp ((2.0 * xlv_TEXCOORD1.x), 0.0, 1.0);
  detailLevel_7 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = (main_16.xyz * mix (detail_9.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_7)));
  tmpvar_3 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = (main_16.w * mix (detail_9.w, 1.0, detailLevel_7));
  highp float tmpvar_52;
  tmpvar_52 = clamp (normalize(xlv_TEXCOORD0).z, 0.0, 1.0);
  rim_6 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_51, (xlv_TEXCOORD1.y * clamp (((1.0 - xlv_TEXCOORD1.y) + clamp (pow ((_FalloffScale * rim_6), _FalloffPow), 0.0, 1.0)), 0.0, 1.0)));
  tmpvar_5 = tmpvar_53;
  lowp vec4 packednormal_54;
  packednormal_54 = normal_8;
  lowp vec3 normal_55;
  normal_55.xy = ((packednormal_54.wy * 2.0) - 1.0);
  normal_55.z = sqrt((1.0 - clamp (dot (normal_55.xy, normal_55.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_56;
  tmpvar_56 = mix (normal_55, vec3(0.0, 0.0, 1.0), vec3(detailLevel_7));
  tmpvar_4 = tmpvar_56;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_57;
  tmpvar_57 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  mediump vec3 lightDir_58;
  lightDir_58 = xlv_TEXCOORD3;
  mediump float atten_59;
  atten_59 = tmpvar_57;
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
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD4));
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
#line 475
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
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
#line 447
#line 486
#line 506
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
#line 426
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 430
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float diff = (_DetailDist * distance( vertexPos, _WorldSpaceCameraPos));
    o.viewDist.x = diff;
    o.viewDist.y = xll_saturate_f((distance( origin, _WorldSpaceCameraPos) - (1.00025 * distance( origin, vertexPos))));
    #line 434
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
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o.vlight = glstate_lightmodel_ambient.xyz;
    #line 502
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
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
    xlv_TEXCOORD1 = vec2(xl_retval.cust_viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD3 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD4 = vec3(xl_retval.vlight);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
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
#line 475
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
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
#line 447
#line 486
#line 506
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
#line 436
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 438
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 442
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
#line 447
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    #line 451
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 455
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    #line 459
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    #line 463
    detail = mix( detail, detailY, vec4( pos.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = xll_saturate_f((2.0 * IN.viewDist.x));
    #line 467
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Albedo = albedo;
    mediump float avg = (main.w * mix( detail.w, 1.0, detailLevel));
    #line 471
    mediump float rim = xll_saturate_f(dot( normalize(IN.viewDir), o.Normal));
    o.Alpha = mix( 0.0, avg, (IN.viewDist.y * xll_saturate_f(((1.0 - IN.viewDist.y) + xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow))))));
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 506
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    #line 510
    surfIN.localPos = IN.cust_localPos;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 514
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 518
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    #line 522
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_viewDist = vec2(xlv_TEXCOORD1);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD2);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD3);
    xlt_IN.vlight = vec3(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform float _DetailDist;

uniform vec4 unity_Scale;
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
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.x = (_DetailDist * sqrt(dot (p_4, p_4)));
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_6;
  p_6 = (tmpvar_3 - tmpvar_2);
  tmpvar_1.y = clamp ((sqrt(dot (p_5, p_5)) - (1.00025 * sqrt(dot (p_6, p_6)))), 0.0, 1.0);
  vec3 tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_7 = TANGENT.xyz;
  tmpvar_8 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = gl_Normal.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = gl_Normal.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = gl_Normal.z;
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (tmpvar_9 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD3 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD4 = gl_LightModel.ambient.xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _MinLight;
uniform float _BumpScale;
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
void main ()
{
  vec4 c_1;
  vec2 uv_2;
  float r_3;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD2.z / xlv_TEXCOORD2.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD2.z) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD2.y);
  uv_2.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD2.y / xlv_TEXCOORD2.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD2.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD2.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD2.z))) * (1.5708 + (abs(xlv_TEXCOORD2.z) * (-0.214602 + (abs(xlv_TEXCOORD2.z) * (0.0865667 + (abs(xlv_TEXCOORD2.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD2.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD2.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec4 tmpvar_16;
  tmpvar_16 = (texture2DGradARB (_MainTex, uv_2, tmpvar_15.xy, tmpvar_15.zw) * _Color);
  vec3 tmpvar_17;
  tmpvar_17 = abs(xlv_TEXCOORD2);
  vec4 tmpvar_18;
  tmpvar_18 = mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD2.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD2.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_17.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD2.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_17.yyyy);
  float tmpvar_19;
  tmpvar_19 = clamp ((2.0 * xlv_TEXCOORD1.x), 0.0, 1.0);
  vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_16.xyz * mix (tmpvar_18.xyz, vec3(1.0, 1.0, 1.0), vec3(tmpvar_19)));
  vec3 normal_21;
  normal_21.xy = ((mix (mix (texture2D (_BumpMap, ((xlv_TEXCOORD2.xy * _BumpScale) + _BumpOffset.xy)), texture2D (_BumpMap, ((xlv_TEXCOORD2.zy * _BumpScale) + _BumpOffset.xy)), tmpvar_17.xxxx), texture2D (_BumpMap, ((xlv_TEXCOORD2.zx * _BumpScale) + _BumpOffset.xy)), tmpvar_17.yyyy).wy * 2.0) - 1.0);
  normal_21.z = sqrt((1.0 - clamp (dot (normal_21.xy, normal_21.xy), 0.0, 1.0)));
  vec4 c_22;
  c_22.xyz = (tmpvar_20 * clamp ((_MinLight + (_LightColor0.xyz * (clamp (dot (mix (normal_21, vec3(0.0, 0.0, 1.0), vec3(tmpvar_19)), xlv_TEXCOORD3), 0.0, 1.0) * 2.0))), 0.0, 1.0));
  c_22.w = mix (0.0, (tmpvar_16.w * mix (tmpvar_18.w, 1.0, tmpvar_19)), (xlv_TEXCOORD1.y * clamp (((1.0 - xlv_TEXCOORD1.y) + clamp (pow ((_FalloffScale * clamp (normalize(xlv_TEXCOORD0).z, 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), 0.0, 1.0)));
  c_1.w = c_22.w;
  c_1.xyz = (c_22.xyz + (tmpvar_20 * xlv_TEXCOORD4));
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
Float 16 [_DetailDist]
"vs_3_0
; 51 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c17, 1.00000000, 1.00024998, 0, 0
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
mov r1.w, c17.x
mov r1.xyz, c13
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
mov r1, c8
dp4 r4.x, c14, r1
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp3 o1.y, r2, r3
dp3 o1.z, v2, r2
dp3 o1.x, r2, v1
add r2.xyz, -r0, c13
add r0.xyz, r1, -r0
dp3 r0.x, r0, r0
dp3 r0.w, r2, r2
rsq r0.y, r0.w
rsq r0.x, r0.x
rcp r0.y, r0.y
rcp r0.x, r0.x
mad_sat o2.y, -r0.x, c17, r0
add r0.xyz, -r1, c13
dp3 r0.x, r0, r0
rsq r0.x, r0.x
dp3 r0.y, v0, v0
rcp r0.x, r0.x
rsq r0.y, r0.y
dp3 o4.y, r3, r4
dp3 o4.z, v2, r4
dp3 o4.x, v1, r4
mul o2.x, r0, c16
mul o3.xyz, r0.y, v0
mov o5.xyz, c12
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
Float 108 [_DetailDist]
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
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 42 instructions, 3 temp regs, 0 temp arrays:
// ALU 40 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhholcncdoadlmcjpmaeeeblcbmfchepmabaaaaaanmahaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcciagaaaaeaaaabaaikabaaaafjaaaaae
egiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafjaaaaae
egiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
adaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaa
aaaaaaaabaaaaaahcccabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbccabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
eccabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
egiccaaaadaaaaaaapaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaibccabaaaacaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaagaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadccaaaakcccabaaaacaaaaaaakaabaia
ebaaaaaaabaaaaaaabeaaaaadbaiiadpdkaabaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaa
aaaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
dgaaaaaghccabaaaafaaaaaaegiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _DetailDist;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = (_DetailDist * sqrt(dot (p_8, p_8)));
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_7 - tmpvar_6);
  tmpvar_5.y = clamp ((sqrt(dot (p_9, p_9)) - (1.00025 * sqrt(dot (p_10, p_10)))), 0.0, 1.0);
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_1.xyz;
  tmpvar_12 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_2.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_2.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (tmpvar_13 * (((_World2Object * tmpvar_15).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
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
  mediump float rim_6;
  mediump float detailLevel_7;
  mediump vec4 normal_8;
  mediump vec4 detail_9;
  mediump vec4 normalZ_10;
  mediump vec4 normalY_11;
  mediump vec4 normalX_12;
  mediump vec4 detailZ_13;
  mediump vec4 detailY_14;
  mediump vec4 detailX_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  highp float r_18;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.z)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD2.z / xlv_TEXCOORD2.x);
    float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.z >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD2.z) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_18));
  highp float x_22;
  x_22 = -(xlv_TEXCOORD2.y);
  uv_17.y = (0.31831 * (1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD2.y / xlv_TEXCOORD2.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD2.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD2.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD2.z))) * (1.5708 + (abs(xlv_TEXCOORD2.z) * (-0.214602 + (abs(xlv_TEXCOORD2.z) * (0.0865667 + (abs(xlv_TEXCOORD2.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD2.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD2.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = (texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw) * _Color);
  main_16 = tmpvar_31;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = ((xlv_TEXCOORD2.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_32 = texture2D (_DetailTex, P_33);
  detailX_15 = tmpvar_32;
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = ((xlv_TEXCOORD2.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_34 = texture2D (_DetailTex, P_35);
  detailY_14 = tmpvar_34;
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = ((xlv_TEXCOORD2.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_36 = texture2D (_DetailTex, P_37);
  detailZ_13 = tmpvar_36;
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = ((xlv_TEXCOORD2.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_38 = texture2D (_BumpMap, P_39);
  normalX_12 = tmpvar_38;
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = ((xlv_TEXCOORD2.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_40 = texture2D (_BumpMap, P_41);
  normalY_11 = tmpvar_40;
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = ((xlv_TEXCOORD2.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_42 = texture2D (_BumpMap, P_43);
  normalZ_10 = tmpvar_42;
  highp vec3 tmpvar_44;
  tmpvar_44 = abs(xlv_TEXCOORD2);
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detailZ_13, detailX_15, tmpvar_44.xxxx);
  detail_9 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (detail_9, detailY_14, tmpvar_44.yyyy);
  detail_9 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normalZ_10, normalX_12, tmpvar_44.xxxx);
  normal_8 = tmpvar_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = mix (normal_8, normalY_11, tmpvar_44.yyyy);
  normal_8 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp ((2.0 * xlv_TEXCOORD1.x), 0.0, 1.0);
  detailLevel_7 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = (main_16.xyz * mix (detail_9.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_7)));
  tmpvar_3 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = (main_16.w * mix (detail_9.w, 1.0, detailLevel_7));
  highp float tmpvar_52;
  tmpvar_52 = clamp (normalize(xlv_TEXCOORD0).z, 0.0, 1.0);
  rim_6 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_51, (xlv_TEXCOORD1.y * clamp (((1.0 - xlv_TEXCOORD1.y) + clamp (pow ((_FalloffScale * rim_6), _FalloffPow), 0.0, 1.0)), 0.0, 1.0)));
  tmpvar_5 = tmpvar_53;
  lowp vec3 tmpvar_54;
  lowp vec4 packednormal_55;
  packednormal_55 = normal_8;
  tmpvar_54 = ((packednormal_55.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_56;
  tmpvar_56 = mix (tmpvar_54, vec3(0.0, 0.0, 1.0), vec3(detailLevel_7));
  tmpvar_4 = tmpvar_56;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_57;
  lightDir_57 = xlv_TEXCOORD3;
  mediump vec4 c_58;
  mediump float tmpvar_59;
  tmpvar_59 = clamp (dot (tmpvar_4, lightDir_57), 0.0, 1.0);
  highp vec3 tmpvar_60;
  tmpvar_60 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_59 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_3 * tmpvar_60);
  c_58.xyz = tmpvar_61;
  c_58.w = tmpvar_5;
  c_1 = c_58;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD4));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _DetailDist;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = (_DetailDist * sqrt(dot (p_8, p_8)));
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_7 - tmpvar_6);
  tmpvar_5.y = clamp ((sqrt(dot (p_9, p_9)) - (1.00025 * sqrt(dot (p_10, p_10)))), 0.0, 1.0);
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_1.xyz;
  tmpvar_12 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_2.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_2.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (tmpvar_13 * (((_World2Object * tmpvar_15).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
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
  mediump float rim_6;
  mediump float detailLevel_7;
  mediump vec4 normal_8;
  mediump vec4 detail_9;
  mediump vec4 normalZ_10;
  mediump vec4 normalY_11;
  mediump vec4 normalX_12;
  mediump vec4 detailZ_13;
  mediump vec4 detailY_14;
  mediump vec4 detailX_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  highp float r_18;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.z)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD2.z / xlv_TEXCOORD2.x);
    float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.z >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD2.z) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_18));
  highp float x_22;
  x_22 = -(xlv_TEXCOORD2.y);
  uv_17.y = (0.31831 * (1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD2.y / xlv_TEXCOORD2.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD2.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD2.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD2.z))) * (1.5708 + (abs(xlv_TEXCOORD2.z) * (-0.214602 + (abs(xlv_TEXCOORD2.z) * (0.0865667 + (abs(xlv_TEXCOORD2.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD2.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD2.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = (texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw) * _Color);
  main_16 = tmpvar_31;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = ((xlv_TEXCOORD2.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_32 = texture2D (_DetailTex, P_33);
  detailX_15 = tmpvar_32;
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = ((xlv_TEXCOORD2.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_34 = texture2D (_DetailTex, P_35);
  detailY_14 = tmpvar_34;
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = ((xlv_TEXCOORD2.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_36 = texture2D (_DetailTex, P_37);
  detailZ_13 = tmpvar_36;
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = ((xlv_TEXCOORD2.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_38 = texture2D (_BumpMap, P_39);
  normalX_12 = tmpvar_38;
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = ((xlv_TEXCOORD2.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_40 = texture2D (_BumpMap, P_41);
  normalY_11 = tmpvar_40;
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = ((xlv_TEXCOORD2.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_42 = texture2D (_BumpMap, P_43);
  normalZ_10 = tmpvar_42;
  highp vec3 tmpvar_44;
  tmpvar_44 = abs(xlv_TEXCOORD2);
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detailZ_13, detailX_15, tmpvar_44.xxxx);
  detail_9 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (detail_9, detailY_14, tmpvar_44.yyyy);
  detail_9 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normalZ_10, normalX_12, tmpvar_44.xxxx);
  normal_8 = tmpvar_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = mix (normal_8, normalY_11, tmpvar_44.yyyy);
  normal_8 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp ((2.0 * xlv_TEXCOORD1.x), 0.0, 1.0);
  detailLevel_7 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = (main_16.xyz * mix (detail_9.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_7)));
  tmpvar_3 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = (main_16.w * mix (detail_9.w, 1.0, detailLevel_7));
  highp float tmpvar_52;
  tmpvar_52 = clamp (normalize(xlv_TEXCOORD0).z, 0.0, 1.0);
  rim_6 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_51, (xlv_TEXCOORD1.y * clamp (((1.0 - xlv_TEXCOORD1.y) + clamp (pow ((_FalloffScale * rim_6), _FalloffPow), 0.0, 1.0)), 0.0, 1.0)));
  tmpvar_5 = tmpvar_53;
  lowp vec4 packednormal_54;
  packednormal_54 = normal_8;
  lowp vec3 normal_55;
  normal_55.xy = ((packednormal_54.wy * 2.0) - 1.0);
  normal_55.z = sqrt((1.0 - clamp (dot (normal_55.xy, normal_55.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_56;
  tmpvar_56 = mix (normal_55, vec3(0.0, 0.0, 1.0), vec3(detailLevel_7));
  tmpvar_4 = tmpvar_56;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_57;
  lightDir_57 = xlv_TEXCOORD3;
  mediump vec4 c_58;
  mediump float tmpvar_59;
  tmpvar_59 = clamp (dot (tmpvar_4, lightDir_57), 0.0, 1.0);
  highp vec3 tmpvar_60;
  tmpvar_60 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_59 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_3 * tmpvar_60);
  c_58.xyz = tmpvar_61;
  c_58.w = tmpvar_5;
  c_1 = c_58;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD4));
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
#line 467
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
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
#line 439
#line 477
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
#line 418
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 422
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float diff = (_DetailDist * distance( vertexPos, _WorldSpaceCameraPos));
    o.viewDist.x = diff;
    o.viewDist.y = xll_saturate_f((distance( origin, _WorldSpaceCameraPos) - (1.00025 * distance( origin, vertexPos))));
    #line 426
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
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o.vlight = glstate_lightmodel_ambient.xyz;
    #line 494
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
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
    xlv_TEXCOORD1 = vec2(xl_retval.cust_viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD3 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD4 = vec3(xl_retval.vlight);
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
#line 467
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
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
#line 439
#line 477
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
#line 428
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 430
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 434
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
#line 439
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    #line 443
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 447
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    #line 451
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    #line 455
    detail = mix( detail, detailY, vec4( pos.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = xll_saturate_f((2.0 * IN.viewDist.x));
    #line 459
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Albedo = albedo;
    mediump float avg = (main.w * mix( detail.w, 1.0, detailLevel));
    #line 463
    mediump float rim = xll_saturate_f(dot( normalize(IN.viewDir), o.Normal));
    o.Alpha = mix( 0.0, avg, (IN.viewDist.y * xll_saturate_f(((1.0 - IN.viewDist.y) + xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow))))));
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 496
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 498
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.localPos = IN.cust_localPos;
    surfIN.viewDir = IN.viewDir;
    #line 502
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 506
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = 1.0;
    #line 510
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_viewDist = vec2(xlv_TEXCOORD1);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD2);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD3);
    xlt_IN.vlight = vec3(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform float _DetailDist;

uniform vec4 unity_Scale;
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
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.x = (_DetailDist * sqrt(dot (p_4, p_4)));
  vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 p_6;
  p_6 = (tmpvar_3 - tmpvar_2);
  tmpvar_1.y = clamp ((sqrt(dot (p_5, p_5)) - (1.00025 * sqrt(dot (p_6, p_6)))), 0.0, 1.0);
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewProjectionMatrix * gl_Vertex);
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
  vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  vec4 o_12;
  vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_7 * 0.5);
  vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = (tmpvar_10 * (((_World2Object * tmpvar_11).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD3 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD4 = gl_LightModel.ambient.xyz;
  xlv_TEXCOORD5 = o_12;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _MinLight;
uniform float _BumpScale;
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
void main ()
{
  vec4 c_1;
  vec2 uv_2;
  float r_3;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD2.z / xlv_TEXCOORD2.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD2.z) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD2.y);
  uv_2.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD2.y / xlv_TEXCOORD2.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD2.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD2.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD2.z))) * (1.5708 + (abs(xlv_TEXCOORD2.z) * (-0.214602 + (abs(xlv_TEXCOORD2.z) * (0.0865667 + (abs(xlv_TEXCOORD2.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD2.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD2.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec4 tmpvar_16;
  tmpvar_16 = (texture2DGradARB (_MainTex, uv_2, tmpvar_15.xy, tmpvar_15.zw) * _Color);
  vec3 tmpvar_17;
  tmpvar_17 = abs(xlv_TEXCOORD2);
  vec4 tmpvar_18;
  tmpvar_18 = mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD2.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD2.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_17.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD2.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_17.yyyy);
  float tmpvar_19;
  tmpvar_19 = clamp ((2.0 * xlv_TEXCOORD1.x), 0.0, 1.0);
  vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_16.xyz * mix (tmpvar_18.xyz, vec3(1.0, 1.0, 1.0), vec3(tmpvar_19)));
  vec3 normal_21;
  normal_21.xy = ((mix (mix (texture2D (_BumpMap, ((xlv_TEXCOORD2.xy * _BumpScale) + _BumpOffset.xy)), texture2D (_BumpMap, ((xlv_TEXCOORD2.zy * _BumpScale) + _BumpOffset.xy)), tmpvar_17.xxxx), texture2D (_BumpMap, ((xlv_TEXCOORD2.zx * _BumpScale) + _BumpOffset.xy)), tmpvar_17.yyyy).wy * 2.0) - 1.0);
  normal_21.z = sqrt((1.0 - clamp (dot (normal_21.xy, normal_21.xy), 0.0, 1.0)));
  vec4 c_22;
  c_22.xyz = (tmpvar_20 * clamp ((_MinLight + (_LightColor0.xyz * ((clamp (dot (mix (normal_21, vec3(0.0, 0.0, 1.0), vec3(tmpvar_19)), xlv_TEXCOORD3), 0.0, 1.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x) * 2.0))), 0.0, 1.0));
  c_22.w = mix (0.0, (tmpvar_16.w * mix (tmpvar_18.w, 1.0, tmpvar_19)), (xlv_TEXCOORD1.y * clamp (((1.0 - xlv_TEXCOORD1.y) + clamp (pow ((_FalloffScale * clamp (normalize(xlv_TEXCOORD0).z, 0.0, 1.0)), _FalloffPow), 0.0, 1.0)), 0.0, 1.0)));
  c_1.w = c_22.w;
  c_1.xyz = (c_22.xyz + (tmpvar_20 * xlv_TEXCOORD4));
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
Float 18 [_DetailDist]
"vs_3_0
; 56 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c19, 1.00000000, 1.00024998, 0.50000000, 0
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
mov r1.w, c19.x
mov r1.xyz, c13
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c17.w, -v0
mov r1, c8
dp4 r4.x, c16, r1
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp3 o1.y, r2, r3
dp3 o1.z, v2, r2
dp3 o1.x, r2, v1
add r2.xyz, -r0, c13
add r0.xyz, r1, -r0
dp3 r0.x, r0, r0
dp3 r0.w, r2, r2
rsq r0.y, r0.w
rsq r0.x, r0.x
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
rcp r0.y, r0.y
rcp r0.x, r0.x
mad_sat o2.y, -r0.x, c19, r0
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c19.z
mov o0, r0
mul r2.y, r2, c14.x
add r1.xyz, -r1, c13
dp3 r0.x, r1, r1
rsq r0.x, r0.x
dp3 r0.y, v0, v0
rcp r0.x, r0.x
rsq r0.y, r0.y
dp3 o4.y, r3, r4
dp3 o4.z, v2, r4
dp3 o4.x, v1, r4
mad o6.xy, r2.z, c15.zwzw, r2
mov o6.zw, r0
mul o2.x, r0, c18
mul o3.xyz, r0.y, v0
mov o5.xyz, c12
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "color" Color
ConstBuffer "$Globals" 192 // 176 used size, 13 vars
Float 172 [_DetailDist]
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
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 47 instructions, 4 temp regs, 0 temp arrays:
// ALU 43 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedgphmmfjjokppmnejikfpihjbmnjbbcekabaaaaaaimaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcmaagaaaaeaaaabaalaabaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafjaaaaaeegiocaaaaeaaaaaa
afaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
acaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaa
acaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaa
abaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaabaaaaaa
egbcbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaajhcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaaegiccaaaadaaaaaa
apaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaaibccabaaa
acaaaaaaakaabaaaacaaaaaadkiacaaaaaaaaaaaakaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadccaaaakcccabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaa
abeaaaaadbaiiadpdkaabaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaa
aaaaaaaaegbcbaaaaaaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhccabaaaadaaaaaapgapbaaaabaaaaaaegbcbaaaaaaaaaaadiaaaaaj
hcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
acaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
eccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadgaaaaaghccabaaa
afaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
agaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _DetailDist;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = (_DetailDist * sqrt(dot (p_8, p_8)));
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_7 - tmpvar_6);
  tmpvar_5.y = clamp ((sqrt(dot (p_9, p_9)) - (1.00025 * sqrt(dot (p_10, p_10)))), 0.0, 1.0);
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_1.xyz;
  tmpvar_12 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_2.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_2.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (tmpvar_13 * (((_World2Object * tmpvar_15).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
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
  mediump float rim_6;
  mediump float detailLevel_7;
  mediump vec4 normal_8;
  mediump vec4 detail_9;
  mediump vec4 normalZ_10;
  mediump vec4 normalY_11;
  mediump vec4 normalX_12;
  mediump vec4 detailZ_13;
  mediump vec4 detailY_14;
  mediump vec4 detailX_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  highp float r_18;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.z)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD2.z / xlv_TEXCOORD2.x);
    float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.z >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD2.z) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_18));
  highp float x_22;
  x_22 = -(xlv_TEXCOORD2.y);
  uv_17.y = (0.31831 * (1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD2.y / xlv_TEXCOORD2.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD2.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD2.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD2.z))) * (1.5708 + (abs(xlv_TEXCOORD2.z) * (-0.214602 + (abs(xlv_TEXCOORD2.z) * (0.0865667 + (abs(xlv_TEXCOORD2.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD2.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD2.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = (texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw) * _Color);
  main_16 = tmpvar_31;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = ((xlv_TEXCOORD2.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_32 = texture2D (_DetailTex, P_33);
  detailX_15 = tmpvar_32;
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = ((xlv_TEXCOORD2.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_34 = texture2D (_DetailTex, P_35);
  detailY_14 = tmpvar_34;
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = ((xlv_TEXCOORD2.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_36 = texture2D (_DetailTex, P_37);
  detailZ_13 = tmpvar_36;
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = ((xlv_TEXCOORD2.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_38 = texture2D (_BumpMap, P_39);
  normalX_12 = tmpvar_38;
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = ((xlv_TEXCOORD2.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_40 = texture2D (_BumpMap, P_41);
  normalY_11 = tmpvar_40;
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = ((xlv_TEXCOORD2.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_42 = texture2D (_BumpMap, P_43);
  normalZ_10 = tmpvar_42;
  highp vec3 tmpvar_44;
  tmpvar_44 = abs(xlv_TEXCOORD2);
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detailZ_13, detailX_15, tmpvar_44.xxxx);
  detail_9 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (detail_9, detailY_14, tmpvar_44.yyyy);
  detail_9 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normalZ_10, normalX_12, tmpvar_44.xxxx);
  normal_8 = tmpvar_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = mix (normal_8, normalY_11, tmpvar_44.yyyy);
  normal_8 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp ((2.0 * xlv_TEXCOORD1.x), 0.0, 1.0);
  detailLevel_7 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = (main_16.xyz * mix (detail_9.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_7)));
  tmpvar_3 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = (main_16.w * mix (detail_9.w, 1.0, detailLevel_7));
  highp float tmpvar_52;
  tmpvar_52 = clamp (normalize(xlv_TEXCOORD0).z, 0.0, 1.0);
  rim_6 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_51, (xlv_TEXCOORD1.y * clamp (((1.0 - xlv_TEXCOORD1.y) + clamp (pow ((_FalloffScale * rim_6), _FalloffPow), 0.0, 1.0)), 0.0, 1.0)));
  tmpvar_5 = tmpvar_53;
  lowp vec3 tmpvar_54;
  lowp vec4 packednormal_55;
  packednormal_55 = normal_8;
  tmpvar_54 = ((packednormal_55.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_56;
  tmpvar_56 = mix (tmpvar_54, vec3(0.0, 0.0, 1.0), vec3(detailLevel_7));
  tmpvar_4 = tmpvar_56;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_57;
  mediump float lightShadowDataX_58;
  highp float dist_59;
  lowp float tmpvar_60;
  tmpvar_60 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  dist_59 = tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = _LightShadowData.x;
  lightShadowDataX_58 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = max (float((dist_59 > (xlv_TEXCOORD5.z / xlv_TEXCOORD5.w))), lightShadowDataX_58);
  tmpvar_57 = tmpvar_62;
  mediump vec3 lightDir_63;
  lightDir_63 = xlv_TEXCOORD3;
  mediump float atten_64;
  atten_64 = tmpvar_57;
  mediump vec4 c_65;
  mediump float tmpvar_66;
  tmpvar_66 = clamp (dot (tmpvar_4, lightDir_63), 0.0, 1.0);
  highp vec3 tmpvar_67;
  tmpvar_67 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_66 * atten_64) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_68;
  tmpvar_68 = (tmpvar_3 * tmpvar_67);
  c_65.xyz = tmpvar_68;
  c_65.w = tmpvar_5;
  c_1 = c_65;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD4));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _DetailDist;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = (_DetailDist * sqrt(dot (p_8, p_8)));
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_7 - tmpvar_6);
  tmpvar_5.y = clamp ((sqrt(dot (p_9, p_9)) - (1.00025 * sqrt(dot (p_10, p_10)))), 0.0, 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = (glstate_matrix_mvp * _glesVertex);
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
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_17;
  tmpvar_17 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_17;
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_11.zw;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = (tmpvar_14 * (((_World2Object * tmpvar_16).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = o_18;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
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
  mediump float rim_6;
  mediump float detailLevel_7;
  mediump vec4 normal_8;
  mediump vec4 detail_9;
  mediump vec4 normalZ_10;
  mediump vec4 normalY_11;
  mediump vec4 normalX_12;
  mediump vec4 detailZ_13;
  mediump vec4 detailY_14;
  mediump vec4 detailX_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  highp float r_18;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.z)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD2.z / xlv_TEXCOORD2.x);
    float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.z >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD2.z) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_18));
  highp float x_22;
  x_22 = -(xlv_TEXCOORD2.y);
  uv_17.y = (0.31831 * (1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD2.y / xlv_TEXCOORD2.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD2.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD2.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD2.z))) * (1.5708 + (abs(xlv_TEXCOORD2.z) * (-0.214602 + (abs(xlv_TEXCOORD2.z) * (0.0865667 + (abs(xlv_TEXCOORD2.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD2.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD2.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = (texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw) * _Color);
  main_16 = tmpvar_31;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = ((xlv_TEXCOORD2.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_32 = texture2D (_DetailTex, P_33);
  detailX_15 = tmpvar_32;
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = ((xlv_TEXCOORD2.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_34 = texture2D (_DetailTex, P_35);
  detailY_14 = tmpvar_34;
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = ((xlv_TEXCOORD2.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_36 = texture2D (_DetailTex, P_37);
  detailZ_13 = tmpvar_36;
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = ((xlv_TEXCOORD2.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_38 = texture2D (_BumpMap, P_39);
  normalX_12 = tmpvar_38;
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = ((xlv_TEXCOORD2.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_40 = texture2D (_BumpMap, P_41);
  normalY_11 = tmpvar_40;
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = ((xlv_TEXCOORD2.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_42 = texture2D (_BumpMap, P_43);
  normalZ_10 = tmpvar_42;
  highp vec3 tmpvar_44;
  tmpvar_44 = abs(xlv_TEXCOORD2);
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detailZ_13, detailX_15, tmpvar_44.xxxx);
  detail_9 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (detail_9, detailY_14, tmpvar_44.yyyy);
  detail_9 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normalZ_10, normalX_12, tmpvar_44.xxxx);
  normal_8 = tmpvar_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = mix (normal_8, normalY_11, tmpvar_44.yyyy);
  normal_8 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp ((2.0 * xlv_TEXCOORD1.x), 0.0, 1.0);
  detailLevel_7 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = (main_16.xyz * mix (detail_9.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_7)));
  tmpvar_3 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = (main_16.w * mix (detail_9.w, 1.0, detailLevel_7));
  highp float tmpvar_52;
  tmpvar_52 = clamp (normalize(xlv_TEXCOORD0).z, 0.0, 1.0);
  rim_6 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_51, (xlv_TEXCOORD1.y * clamp (((1.0 - xlv_TEXCOORD1.y) + clamp (pow ((_FalloffScale * rim_6), _FalloffPow), 0.0, 1.0)), 0.0, 1.0)));
  tmpvar_5 = tmpvar_53;
  lowp vec4 packednormal_54;
  packednormal_54 = normal_8;
  lowp vec3 normal_55;
  normal_55.xy = ((packednormal_54.wy * 2.0) - 1.0);
  normal_55.z = sqrt((1.0 - clamp (dot (normal_55.xy, normal_55.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_56;
  tmpvar_56 = mix (normal_55, vec3(0.0, 0.0, 1.0), vec3(detailLevel_7));
  tmpvar_4 = tmpvar_56;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_57;
  tmpvar_57 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  mediump vec3 lightDir_58;
  lightDir_58 = xlv_TEXCOORD3;
  mediump float atten_59;
  atten_59 = tmpvar_57;
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
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD4));
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
#line 475
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
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
#line 447
#line 486
#line 506
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
#line 426
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 430
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float diff = (_DetailDist * distance( vertexPos, _WorldSpaceCameraPos));
    o.viewDist.x = diff;
    o.viewDist.y = xll_saturate_f((distance( origin, _WorldSpaceCameraPos) - (1.00025 * distance( origin, vertexPos))));
    #line 434
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
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o.vlight = glstate_lightmodel_ambient.xyz;
    #line 502
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
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
    xlv_TEXCOORD1 = vec2(xl_retval.cust_viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD3 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD4 = vec3(xl_retval.vlight);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
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
#line 475
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
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
#line 447
#line 486
#line 506
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
#line 436
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 438
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 442
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
#line 447
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    #line 451
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 455
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    #line 459
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    #line 463
    detail = mix( detail, detailY, vec4( pos.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = xll_saturate_f((2.0 * IN.viewDist.x));
    #line 467
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Albedo = albedo;
    mediump float avg = (main.w * mix( detail.w, 1.0, detailLevel));
    #line 471
    mediump float rim = xll_saturate_f(dot( normalize(IN.viewDir), o.Normal));
    o.Alpha = mix( 0.0, avg, (IN.viewDist.y * xll_saturate_f(((1.0 - IN.viewDist.y) + xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow))))));
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 506
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    #line 510
    surfIN.localPos = IN.cust_localPos;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 514
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 518
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    #line 522
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_viewDist = vec2(xlv_TEXCOORD1);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD2);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD3);
    xlt_IN.vlight = vec3(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
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
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _DetailDist;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = (_DetailDist * sqrt(dot (p_8, p_8)));
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_7 - tmpvar_6);
  tmpvar_5.y = clamp ((sqrt(dot (p_9, p_9)) - (1.00025 * sqrt(dot (p_10, p_10)))), 0.0, 1.0);
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_1.xyz;
  tmpvar_12 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_2.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_2.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (tmpvar_13 * (((_World2Object * tmpvar_15).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
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
  mediump float rim_6;
  mediump float detailLevel_7;
  mediump vec4 normal_8;
  mediump vec4 detail_9;
  mediump vec4 normalZ_10;
  mediump vec4 normalY_11;
  mediump vec4 normalX_12;
  mediump vec4 detailZ_13;
  mediump vec4 detailY_14;
  mediump vec4 detailX_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  highp float r_18;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.z)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD2.z / xlv_TEXCOORD2.x);
    float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.z >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD2.z) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_18));
  highp float x_22;
  x_22 = -(xlv_TEXCOORD2.y);
  uv_17.y = (0.31831 * (1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD2.y / xlv_TEXCOORD2.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD2.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD2.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD2.z))) * (1.5708 + (abs(xlv_TEXCOORD2.z) * (-0.214602 + (abs(xlv_TEXCOORD2.z) * (0.0865667 + (abs(xlv_TEXCOORD2.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD2.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD2.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = (texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw) * _Color);
  main_16 = tmpvar_31;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = ((xlv_TEXCOORD2.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_32 = texture2D (_DetailTex, P_33);
  detailX_15 = tmpvar_32;
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = ((xlv_TEXCOORD2.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_34 = texture2D (_DetailTex, P_35);
  detailY_14 = tmpvar_34;
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = ((xlv_TEXCOORD2.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_36 = texture2D (_DetailTex, P_37);
  detailZ_13 = tmpvar_36;
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = ((xlv_TEXCOORD2.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_38 = texture2D (_BumpMap, P_39);
  normalX_12 = tmpvar_38;
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = ((xlv_TEXCOORD2.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_40 = texture2D (_BumpMap, P_41);
  normalY_11 = tmpvar_40;
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = ((xlv_TEXCOORD2.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_42 = texture2D (_BumpMap, P_43);
  normalZ_10 = tmpvar_42;
  highp vec3 tmpvar_44;
  tmpvar_44 = abs(xlv_TEXCOORD2);
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detailZ_13, detailX_15, tmpvar_44.xxxx);
  detail_9 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (detail_9, detailY_14, tmpvar_44.yyyy);
  detail_9 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normalZ_10, normalX_12, tmpvar_44.xxxx);
  normal_8 = tmpvar_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = mix (normal_8, normalY_11, tmpvar_44.yyyy);
  normal_8 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp ((2.0 * xlv_TEXCOORD1.x), 0.0, 1.0);
  detailLevel_7 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = (main_16.xyz * mix (detail_9.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_7)));
  tmpvar_3 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = (main_16.w * mix (detail_9.w, 1.0, detailLevel_7));
  highp float tmpvar_52;
  tmpvar_52 = clamp (normalize(xlv_TEXCOORD0).z, 0.0, 1.0);
  rim_6 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_51, (xlv_TEXCOORD1.y * clamp (((1.0 - xlv_TEXCOORD1.y) + clamp (pow ((_FalloffScale * rim_6), _FalloffPow), 0.0, 1.0)), 0.0, 1.0)));
  tmpvar_5 = tmpvar_53;
  lowp vec3 tmpvar_54;
  lowp vec4 packednormal_55;
  packednormal_55 = normal_8;
  tmpvar_54 = ((packednormal_55.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_56;
  tmpvar_56 = mix (tmpvar_54, vec3(0.0, 0.0, 1.0), vec3(detailLevel_7));
  tmpvar_4 = tmpvar_56;
  tmpvar_2 = tmpvar_4;
  lowp float shadow_57;
  lowp float tmpvar_58;
  tmpvar_58 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD5.xyz);
  highp float tmpvar_59;
  tmpvar_59 = (_LightShadowData.x + (tmpvar_58 * (1.0 - _LightShadowData.x)));
  shadow_57 = tmpvar_59;
  mediump vec3 lightDir_60;
  lightDir_60 = xlv_TEXCOORD3;
  mediump float atten_61;
  atten_61 = shadow_57;
  mediump vec4 c_62;
  mediump float tmpvar_63;
  tmpvar_63 = clamp (dot (tmpvar_4, lightDir_60), 0.0, 1.0);
  highp vec3 tmpvar_64;
  tmpvar_64 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_63 * atten_61) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_65;
  tmpvar_65 = (tmpvar_3 * tmpvar_64);
  c_62.xyz = tmpvar_65;
  c_62.w = tmpvar_5;
  c_1 = c_62;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD4));
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
#line 475
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
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
#line 447
#line 486
#line 506
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
#line 426
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 430
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float diff = (_DetailDist * distance( vertexPos, _WorldSpaceCameraPos));
    o.viewDist.x = diff;
    o.viewDist.y = xll_saturate_f((distance( origin, _WorldSpaceCameraPos) - (1.00025 * distance( origin, vertexPos))));
    #line 434
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
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o.vlight = glstate_lightmodel_ambient.xyz;
    #line 502
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
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
    xlv_TEXCOORD1 = vec2(xl_retval.cust_viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD3 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD4 = vec3(xl_retval.vlight);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
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
#line 475
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
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
#line 447
#line 486
#line 506
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
#line 436
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 438
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 442
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
#line 447
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    #line 451
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 455
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    #line 459
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    #line 463
    detail = mix( detail, detailY, vec4( pos.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = xll_saturate_f((2.0 * IN.viewDist.x));
    #line 467
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Albedo = albedo;
    mediump float avg = (main.w * mix( detail.w, 1.0, detailLevel));
    #line 471
    mediump float rim = xll_saturate_f(dot( normalize(IN.viewDir), o.Normal));
    o.Alpha = mix( 0.0, avg, (IN.viewDist.y * xll_saturate_f(((1.0 - IN.viewDist.y) + xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow))))));
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 506
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    #line 510
    surfIN.localPos = IN.cust_localPos;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 514
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 518
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    #line 522
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_viewDist = vec2(xlv_TEXCOORD1);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD2);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD3);
    xlt_IN.vlight = vec3(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
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
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _DetailDist;
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
  highp vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_8;
  p_8 = (tmpvar_6 - _WorldSpaceCameraPos);
  tmpvar_5.x = (_DetailDist * sqrt(dot (p_8, p_8)));
  highp vec3 p_9;
  p_9 = (tmpvar_7 - _WorldSpaceCameraPos);
  highp vec3 p_10;
  p_10 = (tmpvar_7 - tmpvar_6);
  tmpvar_5.y = clamp ((sqrt(dot (p_9, p_9)) - (1.00025 * sqrt(dot (p_10, p_10)))), 0.0, 1.0);
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_1.xyz;
  tmpvar_12 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_2.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_2.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (tmpvar_13 * (((_World2Object * tmpvar_15).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _MinLight;
uniform highp float _BumpScale;
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
  mediump float rim_6;
  mediump float detailLevel_7;
  mediump vec4 normal_8;
  mediump vec4 detail_9;
  mediump vec4 normalZ_10;
  mediump vec4 normalY_11;
  mediump vec4 normalX_12;
  mediump vec4 detailZ_13;
  mediump vec4 detailY_14;
  mediump vec4 detailX_15;
  mediump vec4 main_16;
  highp vec2 uv_17;
  highp float r_18;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.z)))) {
    highp float y_over_x_19;
    y_over_x_19 = (xlv_TEXCOORD2.z / xlv_TEXCOORD2.x);
    float s_20;
    highp float x_21;
    x_21 = (y_over_x_19 * inversesqrt(((y_over_x_19 * y_over_x_19) + 1.0)));
    s_20 = (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))));
    r_18 = s_20;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.z >= 0.0)) {
        r_18 = (s_20 + 3.14159);
      } else {
        r_18 = (r_18 - 3.14159);
      };
    };
  } else {
    r_18 = (sign(xlv_TEXCOORD2.z) * 1.5708);
  };
  uv_17.x = (0.5 + (0.159155 * r_18));
  highp float x_22;
  x_22 = -(xlv_TEXCOORD2.y);
  uv_17.y = (0.31831 * (1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))));
  highp float r_23;
  if ((abs(xlv_TEXCOORD2.x) > (1e-08 * abs(xlv_TEXCOORD2.y)))) {
    highp float y_over_x_24;
    y_over_x_24 = (xlv_TEXCOORD2.y / xlv_TEXCOORD2.x);
    highp float s_25;
    highp float x_26;
    x_26 = (y_over_x_24 * inversesqrt(((y_over_x_24 * y_over_x_24) + 1.0)));
    s_25 = (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))));
    r_23 = s_25;
    if ((xlv_TEXCOORD2.x < 0.0)) {
      if ((xlv_TEXCOORD2.y >= 0.0)) {
        r_23 = (s_25 + 3.14159);
      } else {
        r_23 = (r_23 - 3.14159);
      };
    };
  } else {
    r_23 = (sign(xlv_TEXCOORD2.y) * 1.5708);
  };
  highp float tmpvar_27;
  tmpvar_27 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD2.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD2.z))) * (1.5708 + (abs(xlv_TEXCOORD2.z) * (-0.214602 + (abs(xlv_TEXCOORD2.z) * (0.0865667 + (abs(xlv_TEXCOORD2.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD2.xy);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD2.xy);
  highp vec4 tmpvar_30;
  tmpvar_30.x = (0.159155 * sqrt(dot (tmpvar_28, tmpvar_28)));
  tmpvar_30.y = dFdx(tmpvar_27);
  tmpvar_30.z = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_30.w = dFdy(tmpvar_27);
  lowp vec4 tmpvar_31;
  tmpvar_31 = (texture2DGradEXT (_MainTex, uv_17, tmpvar_30.xy, tmpvar_30.zw) * _Color);
  main_16 = tmpvar_31;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = ((xlv_TEXCOORD2.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_32 = texture2D (_DetailTex, P_33);
  detailX_15 = tmpvar_32;
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = ((xlv_TEXCOORD2.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_34 = texture2D (_DetailTex, P_35);
  detailY_14 = tmpvar_34;
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = ((xlv_TEXCOORD2.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_36 = texture2D (_DetailTex, P_37);
  detailZ_13 = tmpvar_36;
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = ((xlv_TEXCOORD2.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_38 = texture2D (_BumpMap, P_39);
  normalX_12 = tmpvar_38;
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = ((xlv_TEXCOORD2.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_40 = texture2D (_BumpMap, P_41);
  normalY_11 = tmpvar_40;
  lowp vec4 tmpvar_42;
  highp vec2 P_43;
  P_43 = ((xlv_TEXCOORD2.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_42 = texture2D (_BumpMap, P_43);
  normalZ_10 = tmpvar_42;
  highp vec3 tmpvar_44;
  tmpvar_44 = abs(xlv_TEXCOORD2);
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (detailZ_13, detailX_15, tmpvar_44.xxxx);
  detail_9 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = mix (detail_9, detailY_14, tmpvar_44.yyyy);
  detail_9 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = mix (normalZ_10, normalX_12, tmpvar_44.xxxx);
  normal_8 = tmpvar_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = mix (normal_8, normalY_11, tmpvar_44.yyyy);
  normal_8 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp ((2.0 * xlv_TEXCOORD1.x), 0.0, 1.0);
  detailLevel_7 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = (main_16.xyz * mix (detail_9.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_7)));
  tmpvar_3 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = (main_16.w * mix (detail_9.w, 1.0, detailLevel_7));
  highp float tmpvar_52;
  tmpvar_52 = clamp (normalize(xlv_TEXCOORD0).z, 0.0, 1.0);
  rim_6 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = mix (0.0, tmpvar_51, (xlv_TEXCOORD1.y * clamp (((1.0 - xlv_TEXCOORD1.y) + clamp (pow ((_FalloffScale * rim_6), _FalloffPow), 0.0, 1.0)), 0.0, 1.0)));
  tmpvar_5 = tmpvar_53;
  lowp vec3 tmpvar_54;
  lowp vec4 packednormal_55;
  packednormal_55 = normal_8;
  tmpvar_54 = ((packednormal_55.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_56;
  tmpvar_56 = mix (tmpvar_54, vec3(0.0, 0.0, 1.0), vec3(detailLevel_7));
  tmpvar_4 = tmpvar_56;
  tmpvar_2 = tmpvar_4;
  lowp float shadow_57;
  lowp float tmpvar_58;
  tmpvar_58 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD5.xyz);
  highp float tmpvar_59;
  tmpvar_59 = (_LightShadowData.x + (tmpvar_58 * (1.0 - _LightShadowData.x)));
  shadow_57 = tmpvar_59;
  mediump vec3 lightDir_60;
  lightDir_60 = xlv_TEXCOORD3;
  mediump float atten_61;
  atten_61 = shadow_57;
  mediump vec4 c_62;
  mediump float tmpvar_63;
  tmpvar_63 = clamp (dot (tmpvar_4, lightDir_60), 0.0, 1.0);
  highp vec3 tmpvar_64;
  tmpvar_64 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_63 * atten_61) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_65;
  tmpvar_65 = (tmpvar_3 * tmpvar_64);
  c_62.xyz = tmpvar_65;
  c_62.w = tmpvar_5;
  c_1 = c_62;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD4));
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
#line 475
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
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
#line 447
#line 486
#line 506
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
#line 426
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 430
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float diff = (_DetailDist * distance( vertexPos, _WorldSpaceCameraPos));
    o.viewDist.x = diff;
    o.viewDist.y = xll_saturate_f((distance( origin, _WorldSpaceCameraPos) - (1.00025 * distance( origin, vertexPos))));
    #line 434
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
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o.vlight = glstate_lightmodel_ambient.xyz;
    #line 502
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
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
    xlv_TEXCOORD1 = vec2(xl_retval.cust_viewDist);
    xlv_TEXCOORD2 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD3 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD4 = vec3(xl_retval.vlight);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
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
#line 475
struct v2f_surf {
    highp vec4 pos;
    highp vec3 viewDir;
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
#line 447
#line 486
#line 506
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
#line 436
highp vec4 Derivatives( in highp vec3 pos ) {
    #line 438
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    #line 442
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
#line 447
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    #line 451
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 455
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    #line 459
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    #line 463
    detail = mix( detail, detailY, vec4( pos.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = xll_saturate_f((2.0 * IN.viewDist.x));
    #line 467
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    o.Albedo = albedo;
    mediump float avg = (main.w * mix( detail.w, 1.0, detailLevel));
    #line 471
    mediump float rim = xll_saturate_f(dot( normalize(IN.viewDir), o.Normal));
    o.Alpha = mix( 0.0, avg, (IN.viewDist.y * xll_saturate_f(((1.0 - IN.viewDist.y) + xll_saturate_f(pow( (_FalloffScale * rim), _FalloffPow))))));
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 506
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    #line 510
    surfIN.localPos = IN.cust_localPos;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 514
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 518
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    #line 522
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_viewDist = vec2(xlv_TEXCOORD1);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD2);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD3);
    xlt_IN.vlight = vec3(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 2
//   d3d9 - ALU: 117 to 118, TEX: 9 to 10
//   d3d11 - ALU: 86 to 87, TEX: 6 to 7, FLOW: 1 to 1
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
Float 4 [_FalloffPow]
Float 5 [_FalloffScale]
Float 6 [_DetailScale]
Float 7 [_BumpScale]
Float 8 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_BumpMap] 2D
"ps_3_0
; 117 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c9, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c10, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c11, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c12, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c13, 0.15915494, 0.50000000, 2.00000000, -1.00000000
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
mul r0.zw, v2.xyxy, c6.x
add r1.xy, r0.zwzw, c2
mul r0.xy, v2.zyzw, c6.x
add r0.xy, r0, c2
mul r3.xy, v2.zxzw, c6.x
texld r0, r0, s1
texld r1, r1, s1
add_pp r2, r0, -r1
abs r0.xy, v2
mad_pp r1, r0.x, r2, r1
add r3.xy, r3, c2
texld r2, r3, s1
add_pp r2, r2, -r1
mad_pp r2, r0.y, r2, r1
add_pp r1.xyz, -r2, c9.y
mul_sat r1.w, v1.x, c10.z
mad_pp r1.xyz, r1.w, r1, r2
mul r2.xy, v2.zyzw, c7.x
add r3.xy, r2, c3
mul r0.zw, v2.xyxy, c7.x
add r2.xy, r0.zwzw, c3
abs r0.w, v2.z
texld r3.yw, r3, s2
texld r4.yw, r2, s2
add_pp r2.xy, r3.ywzw, -r4.ywzw
mad_pp r3.xy, r0.x, r2, r4.ywzw
max r0.z, r0.w, r0.x
rcp r2.x, r0.z
min r0.z, r0.w, r0.x
mul r0.z, r0, r2.x
mul r2.z, r0, r0
mad r3.z, r2, c11.y, c11
mul r2.xy, v2.zxzw, c7.x
add r2.xy, r2, c3
texld r4.yw, r2, s2
add_pp r2.xy, r4.ywzw, -r3
mad_pp r2.xy, r0.y, r2, r3
mad r3.z, r3, r2, c11.w
mad r0.y, r3.z, r2.z, c12.x
mad_pp r2.xy, r2.yxzw, c13.z, c13.w
mad r0.y, r0, r2.z, c12
mad r0.y, r0, r2.z, c12.z
mul r0.y, r0, r0.z
mul_pp r3.xy, r2, r2
add_pp_sat r2.z, r3.x, r3.y
add r0.z, -r0.y, c12.w
add r0.x, r0.w, -r0
cmp r0.x, -r0, r0.y, r0.z
add_pp r2.z, -r2, c9.y
rsq_pp r0.z, r2.z
add r0.y, -r0.x, c10.w
cmp r3.x, v2, r0, r0.y
rcp_pp r2.z, r0.z
add_pp r0.xyz, -r2, c9.xxyw
mad_pp r2.xyz, r1.w, r0, r2
add r0.y, -r0.w, c9
mad r0.x, r0.w, c9.z, c9.w
mad r0.x, r0.w, r0, c10
mad r0.x, r0.w, r0, c10.y
abs r0.w, -v2.y
add r3.z, -r0.w, c9.y
mad r3.y, r0.w, c9.z, c9.w
mad r3.y, r3, r0.w, c10.x
cmp r3.x, v2.z, r3, -r3
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.y, r0.x, r0
cmp r0.x, v2.z, c9, c9.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c10, r0.y
rsq r3.z, r3.z
mad r0.w, r3.y, r0, c10.y
rcp r3.z, r3.z
mul r3.y, r0.w, r3.z
cmp r0.w, -v2.y, c9.x, c9.y
mul r3.z, r0.w, r3.y
mad r0.y, -r3.z, c10.z, r3
mad r0.z, r0.x, c10.w, r0
mad r0.x, r0.w, c10.w, r0.y
mul r0.y, r0.z, c11.x
mul r3.y, r0.x, c11.x
dsx r0.w, r0.y
dsx r3.zw, v2.xyxy
mul r3.zw, r3, r3
dsy r0.xz, v2.xyyw
mul r0.xz, r0, r0
add r0.z, r0.x, r0
add r3.z, r3, r3.w
rsq r0.x, r3.z
rsq r0.z, r0.z
rcp r3.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c13.x
mad r3.x, r3, c13, c13.y
mul r0.x, r3.z, c13
dsy r0.y, r0
texldd r0, r3, s0, r0.zwzw, r0
mul r0, r0, c1
mul_pp r0.xyz, r0, r1
dp3_pp_sat r2.x, r2, v3
mul_pp r1.xyz, r2.x, c0
dp3 r2.x, v0, v0
mul_pp r1.xyz, r1, c10.z
rsq r2.x, r2.x
add_sat r1.xyz, r1, c8.x
mul r1.xyz, r0, r1
mad_pp oC0.xyz, r0, v4, r1
add_pp r0.x, -r2.w, c9.y
mad_pp r0.z, r1.w, r0.x, r2.w
mul_sat r2.x, r2, v0.z
mul r2.x, r2, c5
pow_sat r3, r2.x, c4.x
mov r0.y, r3.x
add r0.x, -v1.y, c9.y
add_sat r0.x, r0, r0.y
mul_pp r0.y, r0.w, r0.z
mul r0.x, v1.y, r0
mul_pp oC0.w, r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 120 used size, 12 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Vector 64 [_DetailOffset] 4
Vector 80 [_BumpOffset] 4
Float 96 [_FalloffPow]
Float 100 [_FalloffScale]
Float 104 [_DetailScale]
Float 112 [_BumpScale]
Float 116 [_MinLight]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
// 95 instructions, 6 temp regs, 0 temp arrays:
// ALU 82 float, 0 int, 4 uint
// TEX 6 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkbcipkbjnljafcipdaingpagcbefgcmpabaaaaaacmaoaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcamanaaaa
eaaaaaaaedadaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaadeaaaaaj
bcaabaaaaaaaaaaaakbabaiaibaaaaaaadaaaaaackbabaiaibaaaaaaadaaaaaa
aoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
akaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaaakbabaiaibaaaaaaadaaaaaa
ckbabaiaibaaaaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdm
abeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaaaaaaaaaa
akbabaiaibaaaaaaadaaaaaackbabaiaibaaaaaaadaaaaaaabaaaaahecaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaaigcaabaaa
aaaaaaaaagbcbaaaadaaaaaaagbcbaiaebaaaaaaadaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaaaaaaaaaaakbabaaa
adaaaaaackbabaaaadaaaaaadbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaaakbabaaaadaaaaaa
ckbabaaaadaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaa
aaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaafdcaabaaaabaaaaaaegbabaaa
adaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaa
elaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaaabaaaaaaagbebaaa
adaaaaaaapaaaaahicaabaaaaaaaaaaaogakbaaaabaaaaaaogakbaaaabaaaaaa
elaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaa
dkaabaaaaaaaaaaaabeaaaaaidpjccdodbaaaaaiicaabaaaaaaaaaaabkbabaia
ebaaaaaaadaaaaaabkbabaaaadaaaaaadcaaaabamcaabaaaabaaaaaafgbjbaia
ibaaaaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaadagojjlmdagojjlmaceaaaaa
aaaaaaaaaaaaaaaachbgjidnchbgjidndcaaaaanmcaabaaaabaaaaaakgaobaaa
abaaaaaafgbjbaiaibaaaaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaiedefjlo
iedefjlodcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaakeanmjdpkeanmjdpaaaaaaalmcaabaaa
acaaaaaafgbjbaiambaaaaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadp
aaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaadiaaaaahdcaabaaa
adaaaaaaogakbaaaabaaaaaaogakbaaaacaaaaaadcaaaaapdcaabaaaadaaaaaa
egaabaaaadaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaaaaaaaaaaaaaceaaaaa
nlapejeanlapejeaaaaaaaaaaaaaaaaaabaaaaahmcaabaaaaaaaaaaakgaobaaa
aaaaaaaafgabbaaaadaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaaabaaaaaa
dkaabaaaacaaaaaackaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaa
abaaaaaackaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaakgcaabaaaaaaaaaaa
pgaobaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdoaaaaaaaaalaaaaaf
ccaabaaaabaaaaaackaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaackaabaaa
aaaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaadcaaaaalpcaabaaa
abaaaaaaggbcbaaaadaaaaaakgikcaaaaaaaaaaaagaaaaaaegiecaaaaaaaaaaa
aeaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaaegbabaaaadaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaai
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaak
pcaabaaaacaaaaaaagbabaiaibaaaaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaa
acaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaaadaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaacaaaahbcaabaaa
adaaaaaaakbabaaaacaaaaaaakbabaaaacaaaaaadcaaaaajpcaabaaaabaaaaaa
agaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaaaaaaaaaegbcbaaaafaaaaaadcaaaaalpcaabaaaacaaaaaaggbcbaaa
adaaaaaaagiacaaaaaaaaaaaahaaaaaaegiecaaaaaaaaaaaafaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaalfcaabaaaacaaaaaaagbbbaaaadaaaaaaagiacaaaaaaaaaaa
ahaaaaaaagibcaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaaafaaaaaaigaabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaaifcaabaaaacaaaaaa
pganbaaaaeaaaaaapganbaiaebaaaaaaafaaaaaadcaaaaakfcaabaaaacaaaaaa
agbabaiaibaaaaaaadaaaaaaagacbaaaacaaaaaapganbaaaafaaaaaaaaaaaaai
kcaabaaaacaaaaaaagaibaiaebaaaaaaacaaaaaapgahbaaaacaaaaaadcaaaaak
dcaabaaaacaaaaaafgbfbaiaibaaaaaaadaaaaaangafbaaaacaaaaaaigaabaaa
acaaaaaadcaaaaapdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaadkaabaaaabaaaaaaaaaaaaalocaabaaaadaaaaaaagajbaiaebaaaaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdcaaaaajhcaabaaa
acaaaaaaagaabaaaadaaaaaajgahbaaaadaaaaaaegacbaaaacaaaaaabacaaaah
icaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaaeaaaaaaaaaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadccaaaalhcaabaaaacaaaaaa
egiccaaaaaaaaaaaabaaaaaapgapbaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackbabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaagaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
agaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiccaabaaaaaaaaaaa
bkbabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpaacaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkbabaaaacaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaa
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
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_DetailOffset]
Vector 3 [_BumpOffset]
Float 4 [_FalloffPow]
Float 5 [_FalloffScale]
Float 6 [_DetailScale]
Float 7 [_BumpScale]
Float 8 [_MinLight]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"ps_3_0
; 118 ALU, 10 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c9, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c10, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c11, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c12, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c13, 0.15915494, 0.50000000, 2.00000000, -1.00000000
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5
mul r0.xy, v2.zyzw, c6.x
add r1.xy, r0, c2
mul r0.zw, v2.xyxy, c6.x
add r0.xy, r0.zwzw, c2
mul r2.xy, v2.zxzw, c6.x
abs r2.zw, v2.xyxy
abs r3.z, v2
mul_sat r3.x, v1, c10.z
texld r0, r0, s1
texld r1, r1, s1
add_pp r1, r1, -r0
mad_pp r0, r2.z, r1, r0
add r2.xy, r2, c2
texld r1, r2, s1
add_pp r1, r1, -r0
mad_pp r0, r2.w, r1, r0
add_pp r1.xyz, -r0, c9.y
mad_pp r0.xyz, r3.x, r1, r0
mul r1.zw, v2.xyzy, c7.x
add r2.xy, r1.zwzw, c3
mul r1.xy, v2, c7.x
add r1.xy, r1, c3
texld r1.yw, r1, s2
texld r3.yw, r2, s2
add_pp r2.xy, r3.ywzw, -r1.ywzw
mad_pp r1.zw, r2.z, r2.xyxy, r1.xyyw
max r2.x, r3.z, r2.z
rcp r2.y, r2.x
min r2.x, r3.z, r2.z
mul r2.x, r2, r2.y
mul r1.xy, v2.zxzw, c7.x
add r1.xy, r1, c3
texld r3.yw, r1, s2
add_pp r1.xy, r3.ywzw, -r1.zwzw
mul r2.y, r2.x, r2.x
mad_pp r1.xy, r2.w, r1, r1.zwzw
mad r3.y, r2, c11, c11.z
mad r1.z, r3.y, r2.y, c11.w
mad r2.w, r1.z, r2.y, c12.x
mad_pp r1.xy, r1.yxzw, c13.z, c13.w
mul_pp r1.zw, r1.xyxy, r1.xyxy
mad r2.w, r2, r2.y, c12.y
add_pp_sat r1.w, r1.z, r1
mad r1.z, r2.w, r2.y, c12
add_pp r2.y, -r1.w, c9
mul r1.w, r1.z, r2.x
add r1.z, r3, -r2
add r2.x, -r1.w, c12.w
cmp r1.w, -r1.z, r1, r2.x
add r2.w, -r1, c10
cmp r1.w, v2.x, r1, r2
rsq_pp r2.y, r2.y
rcp_pp r1.z, r2.y
add_pp r2.xyz, -r1, c9.xxyw
mad_pp r1.xyz, r3.x, r2, r1
dp3_pp_sat r3.y, r1, v3
cmp r1.w, v2.z, r1, -r1
mad r2.x, r1.w, c13, c13.y
abs r1.w, -v2.y
add r1.y, -r3.z, c9
mad r1.x, r3.z, c9.z, c9.w
mad r1.x, r3.z, r1, c10
mad r1.x, r3.z, r1, c10.y
add r2.z, -r1.w, c9.y
mad r2.y, r1.w, c9.z, c9.w
mad r2.y, r2, r1.w, c10.x
rsq r1.y, r1.y
rcp r1.y, r1.y
mul r1.y, r1.x, r1
cmp r1.x, v2.z, c9, c9.y
mul r1.z, r1.x, r1.y
mad r1.z, -r1, c10, r1.y
rsq r2.z, r2.z
dsy r3.zw, v2.xyxy
mad r1.w, r2.y, r1, c10.y
rcp r2.z, r2.z
mul r2.y, r1.w, r2.z
cmp r1.w, -v2.y, c9.x, c9.y
mul r2.z, r1.w, r2.y
mad r1.y, -r2.z, c10.z, r2
mad r1.z, r1.x, c10.w, r1
mad r1.x, r1.w, c10.w, r1.y
mul r1.y, r1.z, c11.x
dsx r1.w, r1.y
dsx r2.zw, v2.xyxy
mul r3.zw, r3, r3
add r1.z, r3, r3.w
mul r2.zw, r2, r2
mul r2.y, r1.x, c11.x
add r1.x, r2.z, r2.w
rsq r1.z, r1.z
rsq r1.x, r1.x
rcp r2.z, r1.z
rcp r1.x, r1.x
mul r1.z, r1.x, c13.x
mul r1.x, r2.z, c13
dsy r1.y, r1
texldd r1, r2, s0, r1.zwzw, r1
mul r1, r1, c1
texldp r4.x, v5, s3
mul_pp r0.xyz, r1, r0
mul_pp r2.x, r3.y, r4
mul_pp r1.xyz, r2.x, c0
dp3 r2.x, v0, v0
mul_pp r1.xyz, r1, c10.z
rsq r2.x, r2.x
mul_sat r2.x, r2, v0.z
add_sat r1.xyz, r1, c8.x
mul r1.xyz, r0, r1
mad_pp oC0.xyz, r0, v4, r1
add_pp r0.x, -r0.w, c9.y
mad_pp r0.z, r3.x, r0.x, r0.w
mul r3.y, r2.x, c5.x
pow_sat r2, r3.y, c4.x
mov r0.y, r2.x
add r0.x, -v1.y, c9.y
add_sat r0.x, r0, r0.y
mul_pp r0.y, r1.w, r0.z
mul r0.x, v1.y, r0
mul_pp oC0.w, r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 184 used size, 13 vars
Vector 16 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Vector 144 [_BumpOffset] 4
Float 160 [_FalloffPow]
Float 164 [_FalloffScale]
Float 168 [_DetailScale]
Float 176 [_BumpScale]
Float 180 [_MinLight]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_DetailTex] 2D 2
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_ShadowMapTexture] 2D 0
// 97 instructions, 6 temp regs, 0 temp arrays:
// ALU 83 float, 0 int, 4 uint
// TEX 7 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecededjpmckmpiponmlclhhonbhcjjmgnhnaabaaaaaakmaoaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcheanaaaaeaaaaaaafnadaaaa
fjaaaaaeegiocaaaaaaaaaaaamaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaad
lcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaadeaaaaaj
bcaabaaaaaaaaaaaakbabaiaibaaaaaaadaaaaaackbabaiaibaaaaaaadaaaaaa
aoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
akaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaaakbabaiaibaaaaaaadaaaaaa
ckbabaiaibaaaaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaafpkokkdm
abeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaaaaaaaaaa
akbabaiaibaaaaaaadaaaaaackbabaiaibaaaaaaadaaaaaaabaaaaahecaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaaigcaabaaa
aaaaaaaaagbcbaaaadaaaaaaagbcbaiaebaaaaaaadaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaaaaaaaaaaakbabaaa
adaaaaaackbabaaaadaaaaaadbaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaaakbabaaaadaaaaaa
ckbabaaaadaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaa
aaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaafdcaabaaaabaaaaaaegbabaaa
adaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaa
elaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaaabaaaaaaagbebaaa
adaaaaaaapaaaaahicaabaaaaaaaaaaaogakbaaaabaaaaaaogakbaaaabaaaaaa
elaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaa
dkaabaaaaaaaaaaaabeaaaaaidpjccdodbaaaaaiicaabaaaaaaaaaaabkbabaia
ebaaaaaaadaaaaaabkbabaaaadaaaaaadcaaaabamcaabaaaabaaaaaafgbjbaia
ibaaaaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaadagojjlmdagojjlmaceaaaaa
aaaaaaaaaaaaaaaachbgjidnchbgjidndcaaaaanmcaabaaaabaaaaaakgaobaaa
abaaaaaafgbjbaiaibaaaaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaiedefjlo
iedefjlodcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaafgbjbaiaibaaaaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaakeanmjdpkeanmjdpaaaaaaalmcaabaaa
acaaaaaafgbjbaiambaaaaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadp
aaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaadiaaaaahdcaabaaa
adaaaaaaogakbaaaabaaaaaaogakbaaaacaaaaaadcaaaaapdcaabaaaadaaaaaa
egaabaaaadaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaaaaaaaaaaaaaceaaaaa
nlapejeanlapejeaaaaaaaaaaaaaaaaaabaaaaahmcaabaaaaaaaaaaakgaobaaa
aaaaaaaafgabbaaaadaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaaabaaaaaa
dkaabaaaacaaaaaackaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaa
abaaaaaackaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaakgcaabaaaaaaaaaaa
pgaobaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdoaaaaaaaaalaaaaaf
ccaabaaaabaaaaaackaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaackaabaaa
aaaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaadcaaaaalpcaabaaa
abaaaaaaggbcbaaaadaaaaaakgikcaaaaaaaaaaaakaaaaaaegiecaaaaaaaaaaa
aiaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaaldcaabaaaadaaaaaaegbabaaaadaaaaaa
kgikcaaaaaaaaaaaakaaaaaaegiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaai
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaak
pcaabaaaacaaaaaaagbabaiaibaaaaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaa
acaaaaaadcaaaaakpcaabaaaabaaaaaafgbfbaiaibaaaaaaadaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaaaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaacaaaahbcaabaaa
adaaaaaaakbabaaaacaaaaaaakbabaaaacaaaaaadcaaaaajpcaabaaaabaaaaaa
agaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaaaaaaaaaegbcbaaaafaaaaaadcaaaaalpcaabaaaacaaaaaaggbcbaaa
adaaaaaaagiacaaaaaaaaaaaalaaaaaaegiecaaaaaaaaaaaajaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaa
efaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
adaaaaaadcaaaaalfcaabaaaacaaaaaaagbbbaaaadaaaaaaagiacaaaaaaaaaaa
alaaaaaaagibcaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaafaaaaaaigaabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaaaaaaaaaifcaabaaaacaaaaaa
pganbaaaaeaaaaaapganbaiaebaaaaaaafaaaaaadcaaaaakfcaabaaaacaaaaaa
agbabaiaibaaaaaaadaaaaaaagacbaaaacaaaaaapganbaaaafaaaaaaaaaaaaai
kcaabaaaacaaaaaaagaibaiaebaaaaaaacaaaaaapgahbaaaacaaaaaadcaaaaak
dcaabaaaacaaaaaafgbfbaiaibaaaaaaadaaaaaangafbaaaacaaaaaaigaabaaa
acaaaaaadcaaaaapdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaadkaabaaaabaaaaaaaaaaaaalocaabaaaadaaaaaaagajbaiaebaaaaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdcaaaaajhcaabaaa
acaaaaaaagaabaaaadaaaaaajgahbaaaadaaaaaaegacbaaaacaaaaaabacaaaah
icaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaaeaaaaaaaoaaaaahdcaabaaa
acaaaaaaegbabaaaagaaaaaapgbpbaaaagaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaa
abaaaaaapgapbaaaabaaaaaaagaabaaaacaaaaaadccaaaalhcaabaaaacaaaaaa
egiccaaaaaaaaaaaabaaaaaapgapbaaaabaaaaaafgifcaaaaaaaaaaaalaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackbabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaakaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
akaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiccaabaaaaaaaaaaa
bkbabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpaacaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkbabaaaacaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaa
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

#LINE 114

	
	}
	
	 
	FallBack "Diffuse"
}
