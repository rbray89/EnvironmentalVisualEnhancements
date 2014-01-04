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
		_FadeDist ("Fade Distance", Range(0,1)) = .002
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
//   d3d9 - ALU: 46 to 52
//   d3d11 - ALU: 44 to 47, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
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
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec3 p_2;
  p_2 = (tmpvar_1 - _WorldSpaceCameraPos);
  vec3 p_3;
  p_3 = (tmpvar_1 - _WorldSpaceCameraPos);
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
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = clamp ((clamp ((0.0825 * sqrt(dot (p_3, p_3))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * gl_Normal.xyzz).xyz), -(normalize((tmpvar_1 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0);
  xlv_TEXCOORD3 = (_DetailDist * sqrt(dot (p_2, p_2)));
  xlv_TEXCOORD4 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD5 = gl_LightModel.ambient.xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeDist;
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
  tmpvar_19 = clamp ((2.0 * xlv_TEXCOORD3), 0.0, 1.0);
  vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_16.xyz * mix (tmpvar_18.xyz, vec3(1.0, 1.0, 1.0), vec3(tmpvar_19)));
  vec3 p_21;
  p_21 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 normal_22;
  normal_22.xy = ((mix (mix (texture2D (_BumpMap, ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy)), texture2D (_BumpMap, ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy)), tmpvar_17.xxxx), texture2D (_BumpMap, ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy)), tmpvar_17.yyyy).wy * 2.0) - 1.0);
  normal_22.z = sqrt((1.0 - clamp (dot (normal_22.xy, normal_22.xy), 0.0, 1.0)));
  vec4 c_23;
  c_23.xyz = (tmpvar_20 * clamp ((_MinLight + (_LightColor0.xyz * (clamp (dot (mix (normal_22, vec3(0.0, 0.0, 1.0), vec3(tmpvar_19)), xlv_TEXCOORD4), 0.0, 1.0) * 2.0))), 0.0, 1.0));
  c_23.w = mix (0.0, (tmpvar_16.w * mix (tmpvar_18.w, 1.0, tmpvar_19)), min (xlv_TEXCOORD2, clamp ((_FadeDist * sqrt(dot (p_21, p_21))), 0.0, 1.0)));
  c_1.w = c_23.w;
  c_1.xyz = (c_23.xyz + (tmpvar_20 * xlv_TEXCOORD5));
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
; 46 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c18, 0.08250000, 0.80000001, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
add r2.xyz, r1, -c13
dp3 r0.w, r2, r2
rsq r1.w, r0.w
mul r2.xyz, r1.w, r2
dp4 r0.z, v2.xyzz, c6
dp4 r0.x, v2.xyzz, c4
dp4 r0.y, v2.xyzz, c5
dp3 r2.w, r0, r0
rsq r0.w, r2.w
mul r0.xyz, r0.w, r0
dp3 r0.x, r0, -r2
mul r0.x, r0, c16
mul r2.w, r0.x, c18.y
mov r2.xyz, v1
pow_sat r0, r2.w, c15.x
mov r4, c9
dp4 r0.z, c14, r4
mov r3.xyz, v1
mul r2.xyz, v2.zxyw, r2.yzxw
mad r2.xyz, v2.yzxw, r3.zxyw, -r2
mov r3, c10
dp4 r0.w, c14, r3
mov r3, c8
dp4 r0.y, c14, r3
mul r2.xyz, r2, v1.w
dp3 o5.y, r0.yzww, r2
rcp r2.x, r1.w
mul_sat r1.w, r2.x, c18.x
add_sat o3.x, r1.w, r0
dp3 r0.x, v0, v0
rsq r0.x, r0.x
dp3 o5.z, v2, r0.yzww
dp3 o5.x, r0.yzww, v1
mov o1.xyz, r1
mul o2.xyz, r0.x, v0
mul o4.x, r2, c17
mov o6.xyz, c12
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
ConstBuffer "$Globals" 128 // 112 used size, 13 vars
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
// 47 instructions, 3 temp regs, 0 temp arrays:
// ALU 44 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhghdgdccichcpmdfokeknjdjmiafhihhabaaaaaafiaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaiahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcimagaaaaeaaaabaakdabaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabeaaaaaafjaaaaaeegiocaaaaeaaaaaa
afaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
iccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
giaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
hcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
dgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaadkaabaaa
aaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkiacaaaaaaaaaaaagaaaaaaabeaaaaamnmmemdpdiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
agaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaamdpfkidndiaaaaaiiccabaaaacaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaaddaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaaaaaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaahiccabaaa
abaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpbaaaaaahbcaabaaaaaaaaaaa
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

varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
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
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 p_7;
  p_7 = (tmpvar_5 - _WorldSpaceCameraPos);
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
  highp vec3 tmpvar_12;
  tmpvar_12 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = clamp ((clamp ((0.0825 * sqrt(dot (p_7, p_7))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_5 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0);
  xlv_TEXCOORD3 = (_DetailDist * sqrt(dot (p_6, p_6)));
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeDist;
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
  tmpvar_48 = clamp ((2.0 * xlv_TEXCOORD3), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (main_15.w * mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_52;
  tmpvar_52 = mix (0.0, tmpvar_50, min (xlv_TEXCOORD2, clamp ((_FadeDist * sqrt(dot (p_51, p_51))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_52;
  lowp vec3 tmpvar_53;
  lowp vec4 packednormal_54;
  packednormal_54 = normal_7;
  tmpvar_53 = ((packednormal_54.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_55;
  tmpvar_55 = mix (tmpvar_53, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_55;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_56;
  lightDir_56 = xlv_TEXCOORD4;
  mediump vec4 c_57;
  mediump float tmpvar_58;
  tmpvar_58 = clamp (dot (tmpvar_4, lightDir_56), 0.0, 1.0);
  highp vec3 tmpvar_59;
  tmpvar_59 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_58 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_3 * tmpvar_59);
  c_57.xyz = tmpvar_60;
  c_57.w = tmpvar_5;
  c_1 = c_57;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD5));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
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
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 p_7;
  p_7 = (tmpvar_5 - _WorldSpaceCameraPos);
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
  highp vec3 tmpvar_12;
  tmpvar_12 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = clamp ((clamp ((0.0825 * sqrt(dot (p_7, p_7))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_5 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0);
  xlv_TEXCOORD3 = (_DetailDist * sqrt(dot (p_6, p_6)));
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeDist;
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
  tmpvar_48 = clamp ((2.0 * xlv_TEXCOORD3), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (main_15.w * mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_52;
  tmpvar_52 = mix (0.0, tmpvar_50, min (xlv_TEXCOORD2, clamp ((_FadeDist * sqrt(dot (p_51, p_51))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_52;
  lowp vec4 packednormal_53;
  packednormal_53 = normal_7;
  lowp vec3 normal_54;
  normal_54.xy = ((packednormal_53.wy * 2.0) - 1.0);
  normal_54.z = sqrt((1.0 - clamp (dot (normal_54.xy, normal_54.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_55;
  tmpvar_55 = mix (normal_54, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_55;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_56;
  lightDir_56 = xlv_TEXCOORD4;
  mediump vec4 c_57;
  mediump float tmpvar_58;
  tmpvar_58 = clamp (dot (tmpvar_4, lightDir_56), 0.0, 1.0);
  highp vec3 tmpvar_59;
  tmpvar_59 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_58 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_3 * tmpvar_59);
  c_57.xyz = tmpvar_60;
  c_57.w = tmpvar_5;
  c_1 = c_57;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD5));
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
#line 412
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
    highp float rim;
    highp float viewDist;
};
#line 471
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
    highp vec3 cust_nrm;
    highp float cust_rim;
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
#line 420
#line 432
#line 482
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 420
void vert( inout appdata_full v, out Input o ) {
    highp vec3 normalDir = normalize((_Object2World * v.normal.xyzz).xyz);
    #line 424
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 viewVect = normalize((vertexPos - _WorldSpaceCameraPos));
    highp float dist = (_DetailDist * distance( vertexPos, _WorldSpaceCameraPos));
    o.viewDist = dist;
    #line 428
    o.rim = xll_saturate_f((xll_saturate_f((0.0825 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow))));
    o.worldPos = vertexPos;
    o.nrm = normalize(v.vertex.xyz);
}
#line 482
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 486
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.cust_rim = customInputData.rim;
    o.cust_viewDist = customInputData.viewDist;
    #line 490
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.worldPos = (_Object2World * v.vertex).xyz;
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 494
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    o.vlight = glstate_lightmodel_ambient.xyz;
    #line 499
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp float xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD2 = float(xl_retval.cust_rim);
    xlv_TEXCOORD3 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
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
#line 412
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
    highp float rim;
    highp float viewDist;
};
#line 471
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
    highp vec3 cust_nrm;
    highp float cust_rim;
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
#line 420
#line 432
#line 482
#line 404
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    #line 406
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    #line 410
    return c;
}
#line 432
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 436
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 440
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 443
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 445
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    #line 449
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    #line 453
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((nrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((nrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((nrm.xy * _BumpScale) + _BumpOffset.xy));
    #line 457
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( nrm.x));
    #line 461
    normal = mix( normal, normalY, vec4( nrm.y));
    mediump float detailLevel = xll_saturate_f((2.0 * IN.viewDist));
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    #line 465
    o.Albedo = albedo;
    mediump float avg = (main.w * mix( detail.w, 1.0, detailLevel));
    highp float distAlpha = xll_saturate_f((_FadeDist * distance( IN.worldPos, _WorldSpaceCameraPos)));
    o.Alpha = mix( 0.0, avg, min( IN.rim, distAlpha));
    #line 469
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 501
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 503
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    surfIN.rim = IN.cust_rim;
    surfIN.viewDist = IN.cust_viewDist;
    #line 507
    surfIN.worldPos = IN.worldPos;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 511
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 515
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    #line 519
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp float xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldPos = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.cust_rim = float(xlv_TEXCOORD2);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
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
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec3 p_2;
  p_2 = (tmpvar_1 - _WorldSpaceCameraPos);
  vec3 p_3;
  p_3 = (tmpvar_1 - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_5 = TANGENT.xyz;
  tmpvar_6 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = gl_Normal.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = gl_Normal.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = gl_Normal.z;
  vec4 o_8;
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_4 * 0.5);
  vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_4.zw;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = clamp ((clamp ((0.0825 * sqrt(dot (p_3, p_3))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * gl_Normal.xyzz).xyz), -(normalize((tmpvar_1 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0);
  xlv_TEXCOORD3 = (_DetailDist * sqrt(dot (p_2, p_2)));
  xlv_TEXCOORD4 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD5 = gl_LightModel.ambient.xyz;
  xlv_TEXCOORD6 = o_8;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeDist;
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
  tmpvar_19 = clamp ((2.0 * xlv_TEXCOORD3), 0.0, 1.0);
  vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_16.xyz * mix (tmpvar_18.xyz, vec3(1.0, 1.0, 1.0), vec3(tmpvar_19)));
  vec3 p_21;
  p_21 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 normal_22;
  normal_22.xy = ((mix (mix (texture2D (_BumpMap, ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy)), texture2D (_BumpMap, ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy)), tmpvar_17.xxxx), texture2D (_BumpMap, ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy)), tmpvar_17.yyyy).wy * 2.0) - 1.0);
  normal_22.z = sqrt((1.0 - clamp (dot (normal_22.xy, normal_22.xy), 0.0, 1.0)));
  vec4 c_23;
  c_23.xyz = (tmpvar_20 * clamp ((_MinLight + (_LightColor0.xyz * ((clamp (dot (mix (normal_22, vec3(0.0, 0.0, 1.0), vec3(tmpvar_19)), xlv_TEXCOORD4), 0.0, 1.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x) * 2.0))), 0.0, 1.0));
  c_23.w = mix (0.0, (tmpvar_16.w * mix (tmpvar_18.w, 1.0, tmpvar_19)), min (xlv_TEXCOORD2, clamp ((_FadeDist * sqrt(dot (p_21, p_21))), 0.0, 1.0)));
  c_1.w = c_23.w;
  c_1.xyz = (c_23.xyz + (tmpvar_20 * xlv_TEXCOORD5));
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
; 52 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c20, 0.08250000, 0.80000001, 0.50000000, 0
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
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
mov r0.y, r2.x
mul_sat r0.x, r1.w, c20
add_sat o3.x, r0, r0.y
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c20.z
mul r1.y, r1, c14.x
mov o0, r0
dp3 r0.x, v0, v0
rsq r0.x, r0.x
dp3 o5.y, r2.yzww, r4
dp3 o5.z, v2, r2.yzww
dp3 o5.x, r2.yzww, v1
mad o7.xy, r1.z, c15.zwzw, r1
mov o7.zw, r0
mov o1.xyz, r3
mul o2.xyz, r0.x, v0
mul o4.x, r1.w, c19
mov o6.xyz, c12
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "color" Color
ConstBuffer "$Globals" 192 // 176 used size, 14 vars
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
// 52 instructions, 4 temp regs, 0 temp arrays:
// ALU 47 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkboaanpdbnnchncjcjanoljcbehljfihabaaaaaaaiajaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaiahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
ceahaaaaeaaaabaamjabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabeaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
iccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaa
kgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajhcaabaaaadaaaaaa
egacbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaeeaaaaafbcaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaa
acaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaaiccaabaaaabaaaaaabkiacaaaaaaaaaaa
akaaaaaaabeaaaaamnmmemdpdiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaamdpfkidndiaaaaaiiccabaaaacaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaakaaaaaaddaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahiccabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpbaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaa
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

varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
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
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 p_7;
  p_7 = (tmpvar_5 - _WorldSpaceCameraPos);
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
  highp vec3 tmpvar_12;
  tmpvar_12 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = clamp ((clamp ((0.0825 * sqrt(dot (p_7, p_7))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_5 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0);
  xlv_TEXCOORD3 = (_DetailDist * sqrt(dot (p_6, p_6)));
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeDist;
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
  tmpvar_48 = clamp ((2.0 * xlv_TEXCOORD3), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (main_15.w * mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_52;
  tmpvar_52 = mix (0.0, tmpvar_50, min (xlv_TEXCOORD2, clamp ((_FadeDist * sqrt(dot (p_51, p_51))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_52;
  lowp vec3 tmpvar_53;
  lowp vec4 packednormal_54;
  packednormal_54 = normal_7;
  tmpvar_53 = ((packednormal_54.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_55;
  tmpvar_55 = mix (tmpvar_53, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_55;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_56;
  mediump float lightShadowDataX_57;
  highp float dist_58;
  lowp float tmpvar_59;
  tmpvar_59 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x;
  dist_58 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = _LightShadowData.x;
  lightShadowDataX_57 = tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = max (float((dist_58 > (xlv_TEXCOORD6.z / xlv_TEXCOORD6.w))), lightShadowDataX_57);
  tmpvar_56 = tmpvar_61;
  mediump vec3 lightDir_62;
  lightDir_62 = xlv_TEXCOORD4;
  mediump float atten_63;
  atten_63 = tmpvar_56;
  mediump vec4 c_64;
  mediump float tmpvar_65;
  tmpvar_65 = clamp (dot (tmpvar_4, lightDir_62), 0.0, 1.0);
  highp vec3 tmpvar_66;
  tmpvar_66 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_65 * atten_63) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_67;
  tmpvar_67 = (tmpvar_3 * tmpvar_66);
  c_64.xyz = tmpvar_67;
  c_64.w = tmpvar_5;
  c_1 = c_64;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD5));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
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
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 p_7;
  p_7 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_13;
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = clamp ((clamp ((0.0825 * sqrt(dot (p_7, p_7))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_5 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0);
  xlv_TEXCOORD3 = (_DetailDist * sqrt(dot (p_6, p_6)));
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = o_14;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeDist;
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
  tmpvar_48 = clamp ((2.0 * xlv_TEXCOORD3), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (main_15.w * mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_52;
  tmpvar_52 = mix (0.0, tmpvar_50, min (xlv_TEXCOORD2, clamp ((_FadeDist * sqrt(dot (p_51, p_51))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_52;
  lowp vec4 packednormal_53;
  packednormal_53 = normal_7;
  lowp vec3 normal_54;
  normal_54.xy = ((packednormal_53.wy * 2.0) - 1.0);
  normal_54.z = sqrt((1.0 - clamp (dot (normal_54.xy, normal_54.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_55;
  tmpvar_55 = mix (normal_54, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_55;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_56;
  tmpvar_56 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x;
  mediump vec3 lightDir_57;
  lightDir_57 = xlv_TEXCOORD4;
  mediump float atten_58;
  atten_58 = tmpvar_56;
  mediump vec4 c_59;
  mediump float tmpvar_60;
  tmpvar_60 = clamp (dot (tmpvar_4, lightDir_57), 0.0, 1.0);
  highp vec3 tmpvar_61;
  tmpvar_61 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_60 * atten_58) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_62;
  tmpvar_62 = (tmpvar_3 * tmpvar_61);
  c_59.xyz = tmpvar_62;
  c_59.w = tmpvar_5;
  c_1 = c_59;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD5));
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
#line 420
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
    highp float rim;
    highp float viewDist;
};
#line 479
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
    highp vec3 cust_nrm;
    highp float cust_rim;
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
#line 428
#line 440
#line 491
#line 511
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 428
void vert( inout appdata_full v, out Input o ) {
    highp vec3 normalDir = normalize((_Object2World * v.normal.xyzz).xyz);
    #line 432
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 viewVect = normalize((vertexPos - _WorldSpaceCameraPos));
    highp float dist = (_DetailDist * distance( vertexPos, _WorldSpaceCameraPos));
    o.viewDist = dist;
    #line 436
    o.rim = xll_saturate_f((xll_saturate_f((0.0825 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow))));
    o.worldPos = vertexPos;
    o.nrm = normalize(v.vertex.xyz);
}
#line 491
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 495
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.cust_rim = customInputData.rim;
    o.cust_viewDist = customInputData.viewDist;
    #line 499
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.worldPos = (_Object2World * v.vertex).xyz;
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 503
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    o.vlight = glstate_lightmodel_ambient.xyz;
    #line 507
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp float xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
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
    xlv_TEXCOORD2 = float(xl_retval.cust_rim);
    xlv_TEXCOORD3 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
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
#line 420
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
    highp float rim;
    highp float viewDist;
};
#line 479
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
    highp vec3 cust_nrm;
    highp float cust_rim;
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
#line 428
#line 440
#line 491
#line 511
#line 412
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    #line 414
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    #line 418
    return c;
}
#line 440
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 444
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 448
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 451
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 453
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    #line 457
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    #line 461
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((nrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((nrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((nrm.xy * _BumpScale) + _BumpOffset.xy));
    #line 465
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( nrm.x));
    #line 469
    normal = mix( normal, normalY, vec4( nrm.y));
    mediump float detailLevel = xll_saturate_f((2.0 * IN.viewDist));
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    #line 473
    o.Albedo = albedo;
    mediump float avg = (main.w * mix( detail.w, 1.0, detailLevel));
    highp float distAlpha = xll_saturate_f((_FadeDist * distance( IN.worldPos, _WorldSpaceCameraPos)));
    o.Alpha = mix( 0.0, avg, min( IN.rim, distAlpha));
    #line 477
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 511
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    #line 515
    surfIN.rim = IN.cust_rim;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.worldPos = IN.worldPos;
    SurfaceOutput o;
    #line 519
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 523
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 527
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp float xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldPos = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.cust_rim = float(xlv_TEXCOORD2);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
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
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec3 p_2;
  p_2 = (tmpvar_1 - _WorldSpaceCameraPos);
  vec3 p_3;
  p_3 = (tmpvar_1 - _WorldSpaceCameraPos);
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
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = clamp ((clamp ((0.0825 * sqrt(dot (p_3, p_3))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * gl_Normal.xyzz).xyz), -(normalize((tmpvar_1 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0);
  xlv_TEXCOORD3 = (_DetailDist * sqrt(dot (p_2, p_2)));
  xlv_TEXCOORD4 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD5 = gl_LightModel.ambient.xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeDist;
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
  tmpvar_19 = clamp ((2.0 * xlv_TEXCOORD3), 0.0, 1.0);
  vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_16.xyz * mix (tmpvar_18.xyz, vec3(1.0, 1.0, 1.0), vec3(tmpvar_19)));
  vec3 p_21;
  p_21 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 normal_22;
  normal_22.xy = ((mix (mix (texture2D (_BumpMap, ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy)), texture2D (_BumpMap, ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy)), tmpvar_17.xxxx), texture2D (_BumpMap, ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy)), tmpvar_17.yyyy).wy * 2.0) - 1.0);
  normal_22.z = sqrt((1.0 - clamp (dot (normal_22.xy, normal_22.xy), 0.0, 1.0)));
  vec4 c_23;
  c_23.xyz = (tmpvar_20 * clamp ((_MinLight + (_LightColor0.xyz * (clamp (dot (mix (normal_22, vec3(0.0, 0.0, 1.0), vec3(tmpvar_19)), xlv_TEXCOORD4), 0.0, 1.0) * 2.0))), 0.0, 1.0));
  c_23.w = mix (0.0, (tmpvar_16.w * mix (tmpvar_18.w, 1.0, tmpvar_19)), min (xlv_TEXCOORD2, clamp ((_FadeDist * sqrt(dot (p_21, p_21))), 0.0, 1.0)));
  c_1.w = c_23.w;
  c_1.xyz = (c_23.xyz + (tmpvar_20 * xlv_TEXCOORD5));
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
; 46 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c18, 0.08250000, 0.80000001, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
add r2.xyz, r1, -c13
dp3 r0.w, r2, r2
rsq r1.w, r0.w
mul r2.xyz, r1.w, r2
dp4 r0.z, v2.xyzz, c6
dp4 r0.x, v2.xyzz, c4
dp4 r0.y, v2.xyzz, c5
dp3 r2.w, r0, r0
rsq r0.w, r2.w
mul r0.xyz, r0.w, r0
dp3 r0.x, r0, -r2
mul r0.x, r0, c16
mul r2.w, r0.x, c18.y
mov r2.xyz, v1
pow_sat r0, r2.w, c15.x
mov r4, c9
dp4 r0.z, c14, r4
mov r3.xyz, v1
mul r2.xyz, v2.zxyw, r2.yzxw
mad r2.xyz, v2.yzxw, r3.zxyw, -r2
mov r3, c10
dp4 r0.w, c14, r3
mov r3, c8
dp4 r0.y, c14, r3
mul r2.xyz, r2, v1.w
dp3 o5.y, r0.yzww, r2
rcp r2.x, r1.w
mul_sat r1.w, r2.x, c18.x
add_sat o3.x, r1.w, r0
dp3 r0.x, v0, v0
rsq r0.x, r0.x
dp3 o5.z, v2, r0.yzww
dp3 o5.x, r0.yzww, v1
mov o1.xyz, r1
mul o2.xyz, r0.x, v0
mul o4.x, r2, c17
mov o6.xyz, c12
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
ConstBuffer "$Globals" 128 // 112 used size, 13 vars
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
// 47 instructions, 3 temp regs, 0 temp arrays:
// ALU 44 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhghdgdccichcpmdfokeknjdjmiafhihhabaaaaaafiaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaiahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcimagaaaaeaaaabaakdabaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabeaaaaaafjaaaaaeegiocaaaaeaaaaaa
afaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
iccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
giaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaapaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
hcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
dgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaadkaabaaa
aaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkiacaaaaaaaaaaaagaaaaaaabeaaaaamnmmemdpdiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
agaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaamdpfkidndiaaaaaiiccabaaaacaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaaddaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaaaaaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaahiccabaaa
abaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpbaaaaaahbcaabaaaaaaaaaaa
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

varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
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
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 p_7;
  p_7 = (tmpvar_5 - _WorldSpaceCameraPos);
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
  highp vec3 tmpvar_12;
  tmpvar_12 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = clamp ((clamp ((0.0825 * sqrt(dot (p_7, p_7))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_5 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0);
  xlv_TEXCOORD3 = (_DetailDist * sqrt(dot (p_6, p_6)));
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeDist;
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
  tmpvar_48 = clamp ((2.0 * xlv_TEXCOORD3), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (main_15.w * mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_52;
  tmpvar_52 = mix (0.0, tmpvar_50, min (xlv_TEXCOORD2, clamp ((_FadeDist * sqrt(dot (p_51, p_51))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_52;
  lowp vec3 tmpvar_53;
  lowp vec4 packednormal_54;
  packednormal_54 = normal_7;
  tmpvar_53 = ((packednormal_54.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_55;
  tmpvar_55 = mix (tmpvar_53, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_55;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_56;
  lightDir_56 = xlv_TEXCOORD4;
  mediump vec4 c_57;
  mediump float tmpvar_58;
  tmpvar_58 = clamp (dot (tmpvar_4, lightDir_56), 0.0, 1.0);
  highp vec3 tmpvar_59;
  tmpvar_59 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_58 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_3 * tmpvar_59);
  c_57.xyz = tmpvar_60;
  c_57.w = tmpvar_5;
  c_1 = c_57;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD5));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
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
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 p_7;
  p_7 = (tmpvar_5 - _WorldSpaceCameraPos);
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
  highp vec3 tmpvar_12;
  tmpvar_12 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = clamp ((clamp ((0.0825 * sqrt(dot (p_7, p_7))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_5 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0);
  xlv_TEXCOORD3 = (_DetailDist * sqrt(dot (p_6, p_6)));
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeDist;
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
  tmpvar_48 = clamp ((2.0 * xlv_TEXCOORD3), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (main_15.w * mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_52;
  tmpvar_52 = mix (0.0, tmpvar_50, min (xlv_TEXCOORD2, clamp ((_FadeDist * sqrt(dot (p_51, p_51))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_52;
  lowp vec4 packednormal_53;
  packednormal_53 = normal_7;
  lowp vec3 normal_54;
  normal_54.xy = ((packednormal_53.wy * 2.0) - 1.0);
  normal_54.z = sqrt((1.0 - clamp (dot (normal_54.xy, normal_54.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_55;
  tmpvar_55 = mix (normal_54, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_55;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_56;
  lightDir_56 = xlv_TEXCOORD4;
  mediump vec4 c_57;
  mediump float tmpvar_58;
  tmpvar_58 = clamp (dot (tmpvar_4, lightDir_56), 0.0, 1.0);
  highp vec3 tmpvar_59;
  tmpvar_59 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_58 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_3 * tmpvar_59);
  c_57.xyz = tmpvar_60;
  c_57.w = tmpvar_5;
  c_1 = c_57;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD5));
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
#line 412
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
    highp float rim;
    highp float viewDist;
};
#line 471
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
    highp vec3 cust_nrm;
    highp float cust_rim;
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
#line 420
#line 432
#line 482
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 420
void vert( inout appdata_full v, out Input o ) {
    highp vec3 normalDir = normalize((_Object2World * v.normal.xyzz).xyz);
    #line 424
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 viewVect = normalize((vertexPos - _WorldSpaceCameraPos));
    highp float dist = (_DetailDist * distance( vertexPos, _WorldSpaceCameraPos));
    o.viewDist = dist;
    #line 428
    o.rim = xll_saturate_f((xll_saturate_f((0.0825 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow))));
    o.worldPos = vertexPos;
    o.nrm = normalize(v.vertex.xyz);
}
#line 482
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 486
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.cust_rim = customInputData.rim;
    o.cust_viewDist = customInputData.viewDist;
    #line 490
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.worldPos = (_Object2World * v.vertex).xyz;
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 494
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    o.vlight = glstate_lightmodel_ambient.xyz;
    #line 499
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp float xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
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
    xlv_TEXCOORD2 = float(xl_retval.cust_rim);
    xlv_TEXCOORD3 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
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
#line 412
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
    highp float rim;
    highp float viewDist;
};
#line 471
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
    highp vec3 cust_nrm;
    highp float cust_rim;
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
#line 420
#line 432
#line 482
#line 404
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    #line 406
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    #line 410
    return c;
}
#line 432
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 436
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 440
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 443
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 445
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    #line 449
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    #line 453
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((nrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((nrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((nrm.xy * _BumpScale) + _BumpOffset.xy));
    #line 457
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( nrm.x));
    #line 461
    normal = mix( normal, normalY, vec4( nrm.y));
    mediump float detailLevel = xll_saturate_f((2.0 * IN.viewDist));
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    #line 465
    o.Albedo = albedo;
    mediump float avg = (main.w * mix( detail.w, 1.0, detailLevel));
    highp float distAlpha = xll_saturate_f((_FadeDist * distance( IN.worldPos, _WorldSpaceCameraPos)));
    o.Alpha = mix( 0.0, avg, min( IN.rim, distAlpha));
    #line 469
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 501
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 503
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    surfIN.rim = IN.cust_rim;
    surfIN.viewDist = IN.cust_viewDist;
    #line 507
    surfIN.worldPos = IN.worldPos;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 511
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 515
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    #line 519
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp float xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldPos = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.cust_rim = float(xlv_TEXCOORD2);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
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
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec3 p_2;
  p_2 = (tmpvar_1 - _WorldSpaceCameraPos);
  vec3 p_3;
  p_3 = (tmpvar_1 - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_5 = TANGENT.xyz;
  tmpvar_6 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = gl_Normal.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = gl_Normal.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = gl_Normal.z;
  vec4 o_8;
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_4 * 0.5);
  vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_4.zw;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = clamp ((clamp ((0.0825 * sqrt(dot (p_3, p_3))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * gl_Normal.xyzz).xyz), -(normalize((tmpvar_1 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0);
  xlv_TEXCOORD3 = (_DetailDist * sqrt(dot (p_2, p_2)));
  xlv_TEXCOORD4 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD5 = gl_LightModel.ambient.xyz;
  xlv_TEXCOORD6 = o_8;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
uniform float _FadeDist;
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
  tmpvar_19 = clamp ((2.0 * xlv_TEXCOORD3), 0.0, 1.0);
  vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_16.xyz * mix (tmpvar_18.xyz, vec3(1.0, 1.0, 1.0), vec3(tmpvar_19)));
  vec3 p_21;
  p_21 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  vec3 normal_22;
  normal_22.xy = ((mix (mix (texture2D (_BumpMap, ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy)), texture2D (_BumpMap, ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy)), tmpvar_17.xxxx), texture2D (_BumpMap, ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy)), tmpvar_17.yyyy).wy * 2.0) - 1.0);
  normal_22.z = sqrt((1.0 - clamp (dot (normal_22.xy, normal_22.xy), 0.0, 1.0)));
  vec4 c_23;
  c_23.xyz = (tmpvar_20 * clamp ((_MinLight + (_LightColor0.xyz * ((clamp (dot (mix (normal_22, vec3(0.0, 0.0, 1.0), vec3(tmpvar_19)), xlv_TEXCOORD4), 0.0, 1.0) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x) * 2.0))), 0.0, 1.0));
  c_23.w = mix (0.0, (tmpvar_16.w * mix (tmpvar_18.w, 1.0, tmpvar_19)), min (xlv_TEXCOORD2, clamp ((_FadeDist * sqrt(dot (p_21, p_21))), 0.0, 1.0)));
  c_1.w = c_23.w;
  c_1.xyz = (c_23.xyz + (tmpvar_20 * xlv_TEXCOORD5));
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
; 52 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c20, 0.08250000, 0.80000001, 0.50000000, 0
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
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
mov r0.y, r2.x
mul_sat r0.x, r1.w, c20
add_sat o3.x, r0, r0.y
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c20.z
mul r1.y, r1, c14.x
mov o0, r0
dp3 r0.x, v0, v0
rsq r0.x, r0.x
dp3 o5.y, r2.yzww, r4
dp3 o5.z, v2, r2.yzww
dp3 o5.x, r2.yzww, v1
mad o7.xy, r1.z, c15.zwzw, r1
mov o7.zw, r0
mov o1.xyz, r3
mul o2.xyz, r0.x, v0
mul o4.x, r1.w, c19
mov o6.xyz, c12
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "color" Color
ConstBuffer "$Globals" 192 // 176 used size, 14 vars
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
// 52 instructions, 4 temp regs, 0 temp arrays:
// ALU 47 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkboaanpdbnnchncjcjanoljcbehljfihabaaaaaaaiajaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaiahaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
ceahaaaaeaaaabaamjabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabeaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
iccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaa
kgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajhcaabaaaadaaaaaa
egacbaaaacaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaeeaaaaafbcaabaaaacaaaaaadkaabaaaabaaaaaaelaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaa
acaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaaiccaabaaaabaaaaaabkiacaaaaaaaaaaa
akaaaaaaabeaaaaamnmmemdpdiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaakaaaaaabjaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaamdpfkidndiaaaaaiiccabaaaacaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaakaaaaaaddaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahiccabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpbaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaa
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

varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
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
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 p_7;
  p_7 = (tmpvar_5 - _WorldSpaceCameraPos);
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
  highp vec3 tmpvar_12;
  tmpvar_12 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = clamp ((clamp ((0.0825 * sqrt(dot (p_7, p_7))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_5 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0);
  xlv_TEXCOORD3 = (_DetailDist * sqrt(dot (p_6, p_6)));
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeDist;
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
  tmpvar_48 = clamp ((2.0 * xlv_TEXCOORD3), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (main_15.w * mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_52;
  tmpvar_52 = mix (0.0, tmpvar_50, min (xlv_TEXCOORD2, clamp ((_FadeDist * sqrt(dot (p_51, p_51))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_52;
  lowp vec3 tmpvar_53;
  lowp vec4 packednormal_54;
  packednormal_54 = normal_7;
  tmpvar_53 = ((packednormal_54.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_55;
  tmpvar_55 = mix (tmpvar_53, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_55;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_56;
  mediump float lightShadowDataX_57;
  highp float dist_58;
  lowp float tmpvar_59;
  tmpvar_59 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x;
  dist_58 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = _LightShadowData.x;
  lightShadowDataX_57 = tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = max (float((dist_58 > (xlv_TEXCOORD6.z / xlv_TEXCOORD6.w))), lightShadowDataX_57);
  tmpvar_56 = tmpvar_61;
  mediump vec3 lightDir_62;
  lightDir_62 = xlv_TEXCOORD4;
  mediump float atten_63;
  atten_63 = tmpvar_56;
  mediump vec4 c_64;
  mediump float tmpvar_65;
  tmpvar_65 = clamp (dot (tmpvar_4, lightDir_62), 0.0, 1.0);
  highp vec3 tmpvar_66;
  tmpvar_66 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_65 * atten_63) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_67;
  tmpvar_67 = (tmpvar_3 * tmpvar_66);
  c_64.xyz = tmpvar_67;
  c_64.w = tmpvar_5;
  c_1 = c_64;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD5));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
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
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 p_7;
  p_7 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_13;
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = clamp ((clamp ((0.0825 * sqrt(dot (p_7, p_7))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_5 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0);
  xlv_TEXCOORD3 = (_DetailDist * sqrt(dot (p_6, p_6)));
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = o_14;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeDist;
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
  tmpvar_48 = clamp ((2.0 * xlv_TEXCOORD3), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (main_15.w * mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_52;
  tmpvar_52 = mix (0.0, tmpvar_50, min (xlv_TEXCOORD2, clamp ((_FadeDist * sqrt(dot (p_51, p_51))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_52;
  lowp vec4 packednormal_53;
  packednormal_53 = normal_7;
  lowp vec3 normal_54;
  normal_54.xy = ((packednormal_53.wy * 2.0) - 1.0);
  normal_54.z = sqrt((1.0 - clamp (dot (normal_54.xy, normal_54.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_55;
  tmpvar_55 = mix (normal_54, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_55;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_56;
  tmpvar_56 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x;
  mediump vec3 lightDir_57;
  lightDir_57 = xlv_TEXCOORD4;
  mediump float atten_58;
  atten_58 = tmpvar_56;
  mediump vec4 c_59;
  mediump float tmpvar_60;
  tmpvar_60 = clamp (dot (tmpvar_4, lightDir_57), 0.0, 1.0);
  highp vec3 tmpvar_61;
  tmpvar_61 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_60 * atten_58) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_62;
  tmpvar_62 = (tmpvar_3 * tmpvar_61);
  c_59.xyz = tmpvar_62;
  c_59.w = tmpvar_5;
  c_1 = c_59;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD5));
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
#line 420
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
    highp float rim;
    highp float viewDist;
};
#line 479
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
    highp vec3 cust_nrm;
    highp float cust_rim;
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
#line 428
#line 440
#line 491
#line 511
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 428
void vert( inout appdata_full v, out Input o ) {
    highp vec3 normalDir = normalize((_Object2World * v.normal.xyzz).xyz);
    #line 432
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 viewVect = normalize((vertexPos - _WorldSpaceCameraPos));
    highp float dist = (_DetailDist * distance( vertexPos, _WorldSpaceCameraPos));
    o.viewDist = dist;
    #line 436
    o.rim = xll_saturate_f((xll_saturate_f((0.0825 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow))));
    o.worldPos = vertexPos;
    o.nrm = normalize(v.vertex.xyz);
}
#line 491
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 495
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.cust_rim = customInputData.rim;
    o.cust_viewDist = customInputData.viewDist;
    #line 499
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.worldPos = (_Object2World * v.vertex).xyz;
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 503
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    o.vlight = glstate_lightmodel_ambient.xyz;
    #line 507
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp float xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
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
    xlv_TEXCOORD2 = float(xl_retval.cust_rim);
    xlv_TEXCOORD3 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
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
#line 420
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
    highp float rim;
    highp float viewDist;
};
#line 479
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
    highp vec3 cust_nrm;
    highp float cust_rim;
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
#line 428
#line 440
#line 491
#line 511
#line 412
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    #line 414
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    #line 418
    return c;
}
#line 440
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 444
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 448
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 451
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 453
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    #line 457
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    #line 461
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((nrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((nrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((nrm.xy * _BumpScale) + _BumpOffset.xy));
    #line 465
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( nrm.x));
    #line 469
    normal = mix( normal, normalY, vec4( nrm.y));
    mediump float detailLevel = xll_saturate_f((2.0 * IN.viewDist));
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    #line 473
    o.Albedo = albedo;
    mediump float avg = (main.w * mix( detail.w, 1.0, detailLevel));
    highp float distAlpha = xll_saturate_f((_FadeDist * distance( IN.worldPos, _WorldSpaceCameraPos)));
    o.Alpha = mix( 0.0, avg, min( IN.rim, distAlpha));
    #line 477
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 511
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    #line 515
    surfIN.rim = IN.cust_rim;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.worldPos = IN.worldPos;
    SurfaceOutput o;
    #line 519
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 523
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 527
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp float xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldPos = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.cust_rim = float(xlv_TEXCOORD2);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD6);
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
varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
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
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 p_7;
  p_7 = (tmpvar_5 - _WorldSpaceCameraPos);
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
  highp vec3 tmpvar_12;
  tmpvar_12 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = clamp ((clamp ((0.0825 * sqrt(dot (p_7, p_7))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_5 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0);
  xlv_TEXCOORD3 = (_DetailDist * sqrt(dot (p_6, p_6)));
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeDist;
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
  tmpvar_48 = clamp ((2.0 * xlv_TEXCOORD3), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (main_15.w * mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_52;
  tmpvar_52 = mix (0.0, tmpvar_50, min (xlv_TEXCOORD2, clamp ((_FadeDist * sqrt(dot (p_51, p_51))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_52;
  lowp vec3 tmpvar_53;
  lowp vec4 packednormal_54;
  packednormal_54 = normal_7;
  tmpvar_53 = ((packednormal_54.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_55;
  tmpvar_55 = mix (tmpvar_53, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_55;
  tmpvar_2 = tmpvar_4;
  lowp float shadow_56;
  lowp float tmpvar_57;
  tmpvar_57 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD6.xyz);
  highp float tmpvar_58;
  tmpvar_58 = (_LightShadowData.x + (tmpvar_57 * (1.0 - _LightShadowData.x)));
  shadow_56 = tmpvar_58;
  mediump vec3 lightDir_59;
  lightDir_59 = xlv_TEXCOORD4;
  mediump float atten_60;
  atten_60 = shadow_56;
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
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD5));
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
#line 420
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
    highp float rim;
    highp float viewDist;
};
#line 479
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
    highp vec3 cust_nrm;
    highp float cust_rim;
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
#line 428
#line 440
#line 491
#line 511
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 428
void vert( inout appdata_full v, out Input o ) {
    highp vec3 normalDir = normalize((_Object2World * v.normal.xyzz).xyz);
    #line 432
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 viewVect = normalize((vertexPos - _WorldSpaceCameraPos));
    highp float dist = (_DetailDist * distance( vertexPos, _WorldSpaceCameraPos));
    o.viewDist = dist;
    #line 436
    o.rim = xll_saturate_f((xll_saturate_f((0.0825 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow))));
    o.worldPos = vertexPos;
    o.nrm = normalize(v.vertex.xyz);
}
#line 491
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 495
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.cust_rim = customInputData.rim;
    o.cust_viewDist = customInputData.viewDist;
    #line 499
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.worldPos = (_Object2World * v.vertex).xyz;
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 503
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    o.vlight = glstate_lightmodel_ambient.xyz;
    #line 507
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp float xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
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
    xlv_TEXCOORD2 = float(xl_retval.cust_rim);
    xlv_TEXCOORD3 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
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
#line 420
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
    highp float rim;
    highp float viewDist;
};
#line 479
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
    highp vec3 cust_nrm;
    highp float cust_rim;
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
#line 428
#line 440
#line 491
#line 511
#line 412
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    #line 414
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    #line 418
    return c;
}
#line 440
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 444
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 448
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 451
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 453
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    #line 457
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    #line 461
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((nrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((nrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((nrm.xy * _BumpScale) + _BumpOffset.xy));
    #line 465
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( nrm.x));
    #line 469
    normal = mix( normal, normalY, vec4( nrm.y));
    mediump float detailLevel = xll_saturate_f((2.0 * IN.viewDist));
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    #line 473
    o.Albedo = albedo;
    mediump float avg = (main.w * mix( detail.w, 1.0, detailLevel));
    highp float distAlpha = xll_saturate_f((_FadeDist * distance( IN.worldPos, _WorldSpaceCameraPos)));
    o.Alpha = mix( 0.0, avg, min( IN.rim, distAlpha));
    #line 477
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 511
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    #line 515
    surfIN.rim = IN.cust_rim;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.worldPos = IN.worldPos;
    SurfaceOutput o;
    #line 519
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 523
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 527
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp float xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldPos = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.cust_rim = float(xlv_TEXCOORD2);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD6);
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
varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
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
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  highp vec3 p_7;
  p_7 = (tmpvar_5 - _WorldSpaceCameraPos);
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
  highp vec3 tmpvar_12;
  tmpvar_12 = glstate_lightmodel_ambient.xyz;
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = clamp ((clamp ((0.0825 * sqrt(dot (p_7, p_7))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_5 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0);
  xlv_TEXCOORD3 = (_DetailDist * sqrt(dot (p_6, p_6)));
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp float _FadeDist;
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
  tmpvar_48 = clamp ((2.0 * xlv_TEXCOORD3), 0.0, 1.0);
  detailLevel_6 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = (main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6)));
  tmpvar_3 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = (main_15.w * mix (detail_8.w, 1.0, detailLevel_6));
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 - _WorldSpaceCameraPos);
  highp float tmpvar_52;
  tmpvar_52 = mix (0.0, tmpvar_50, min (xlv_TEXCOORD2, clamp ((_FadeDist * sqrt(dot (p_51, p_51))), 0.0, 1.0)));
  tmpvar_5 = tmpvar_52;
  lowp vec3 tmpvar_53;
  lowp vec4 packednormal_54;
  packednormal_54 = normal_7;
  tmpvar_53 = ((packednormal_54.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_55;
  tmpvar_55 = mix (tmpvar_53, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_55;
  tmpvar_2 = tmpvar_4;
  lowp float shadow_56;
  lowp float tmpvar_57;
  tmpvar_57 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD6.xyz);
  highp float tmpvar_58;
  tmpvar_58 = (_LightShadowData.x + (tmpvar_57 * (1.0 - _LightShadowData.x)));
  shadow_56 = tmpvar_58;
  mediump vec3 lightDir_59;
  lightDir_59 = xlv_TEXCOORD4;
  mediump float atten_60;
  atten_60 = shadow_56;
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
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD5));
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
#line 420
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
    highp float rim;
    highp float viewDist;
};
#line 479
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
    highp vec3 cust_nrm;
    highp float cust_rim;
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
#line 428
#line 440
#line 491
#line 511
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 428
void vert( inout appdata_full v, out Input o ) {
    highp vec3 normalDir = normalize((_Object2World * v.normal.xyzz).xyz);
    #line 432
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    highp vec3 viewVect = normalize((vertexPos - _WorldSpaceCameraPos));
    highp float dist = (_DetailDist * distance( vertexPos, _WorldSpaceCameraPos));
    o.viewDist = dist;
    #line 436
    o.rim = xll_saturate_f((xll_saturate_f((0.0825 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow))));
    o.worldPos = vertexPos;
    o.nrm = normalize(v.vertex.xyz);
}
#line 491
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 495
    vert( v, customInputData);
    o.cust_nrm = customInputData.nrm;
    o.cust_rim = customInputData.rim;
    o.cust_viewDist = customInputData.viewDist;
    #line 499
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.worldPos = (_Object2World * v.vertex).xyz;
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 503
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    o.vlight = glstate_lightmodel_ambient.xyz;
    #line 507
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp float xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
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
    xlv_TEXCOORD2 = float(xl_retval.cust_rim);
    xlv_TEXCOORD3 = float(xl_retval.cust_viewDist);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
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
#line 420
struct Input {
    highp vec3 worldPos;
    highp vec3 nrm;
    highp float rim;
    highp float viewDist;
};
#line 479
struct v2f_surf {
    highp vec4 pos;
    highp vec3 worldPos;
    highp vec3 cust_nrm;
    highp float cust_rim;
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
#line 428
#line 440
#line 491
#line 511
#line 412
mediump vec4 LightingSimpleLambert( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    #line 414
    mediump float NdotL = xll_saturate_f(dot( s.Normal, lightDir));
    mediump vec4 c;
    c.xyz = (s.Albedo * xll_saturate_vf3((_MinLight + (_LightColor0.xyz * ((NdotL * atten) * 2.0)))));
    c.w = s.Alpha;
    #line 418
    return c;
}
#line 440
highp vec4 Derivatives( in highp vec3 pos ) {
    highp float lat = (0.159155 * atan( pos.y, pos.x));
    highp float lon = (0.31831 * acos(pos.z));
    #line 444
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xy)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xy)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 448
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 451
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 453
    highp vec3 nrm = IN.nrm;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( nrm.z, nrm.x)));
    uv.y = (0.31831 * acos((-nrm.y)));
    #line 457
    highp vec4 uvdd = Derivatives( nrm);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((nrm.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((nrm.zx * _DetailScale) + _DetailOffset.xy));
    #line 461
    mediump vec4 detailZ = texture( _DetailTex, ((nrm.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((nrm.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((nrm.zx * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalZ = texture( _BumpMap, ((nrm.xy * _BumpScale) + _BumpOffset.xy));
    #line 465
    nrm = abs(nrm);
    mediump vec4 detail = mix( detailZ, detailX, vec4( nrm.x));
    detail = mix( detail, detailY, vec4( nrm.y));
    mediump vec4 normal = mix( normalZ, normalX, vec4( nrm.x));
    #line 469
    normal = mix( normal, normalY, vec4( nrm.y));
    mediump float detailLevel = xll_saturate_f((2.0 * IN.viewDist));
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    o.Normal = vec3( 0.0, 0.0, 1.0);
    #line 473
    o.Albedo = albedo;
    mediump float avg = (main.w * mix( detail.w, 1.0, detailLevel));
    highp float distAlpha = xll_saturate_f((_FadeDist * distance( IN.worldPos, _WorldSpaceCameraPos)));
    o.Alpha = mix( 0.0, avg, min( IN.rim, distAlpha));
    #line 477
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 511
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.nrm = IN.cust_nrm;
    #line 515
    surfIN.rim = IN.cust_rim;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.worldPos = IN.worldPos;
    SurfaceOutput o;
    #line 519
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 523
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 527
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp float xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldPos = vec3(xlv_TEXCOORD0);
    xlt_IN.cust_nrm = vec3(xlv_TEXCOORD1);
    xlt_IN.cust_rim = float(xlv_TEXCOORD2);
    xlt_IN.cust_viewDist = float(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 2
//   d3d9 - ALU: 112 to 113, TEX: 9 to 10
//   d3d11 - ALU: 80 to 81, TEX: 6 to 7, FLOW: 1 to 1
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
Float 5 [_DetailScale]
Float 6 [_BumpScale]
Float 7 [_MinLight]
Float 8 [_FadeDist]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_BumpMap] 2D
"ps_3_0
; 112 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c9, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c10, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c11, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c12, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c13, 0.15915494, 0.50000000, 2.00000000, -1.00000000
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.x
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mul r0.xy, v1.zyzw, c5.x
add r1.xy, r0, c3
mul r0.zw, v1.xyxy, c5.x
mul r2.xy, v1.zxzw, c5.x
add r3.xy, r2, c3
add r0.xy, r0.zwzw, c3
abs r2.xy, v1
mul_sat r3.w, v3.x, c10.z
texld r0, r0, s1
texld r1, r1, s1
add_pp r1, r1, -r0
mad_pp r0, r2.x, r1, r0
texld r1, r3, s1
add_pp r1, r1, -r0
mad_pp r1, r2.y, r1, r0
add_pp r3.xyz, -r1, c9.y
mul r0.zw, v1.xyzy, c6.x
add r4.xy, r0.zwzw, c4
mul r0.xy, v1, c6.x
add r0.xy, r0, c4
texld r0.yw, r0, s2
texld r4.yw, r4, s2
add_pp r2.zw, r4.xyyw, -r0.xyyw
mad_pp r2.zw, r2.x, r2, r0.xyyw
abs r0.w, v1.z
mul r0.xy, v1.zxzw, c6.x
add r0.xy, r0, c4
texld r4.yw, r0, s2
add_pp r0.xy, r4.ywzw, -r2.zwzw
mad_pp r0.xy, r2.y, r0, r2.zwzw
mad_pp r0.xy, r0.yxzw, c13.z, c13.w
mul_pp r2.zw, r0.xyxy, r0.xyxy
add_pp_sat r2.z, r2, r2.w
add_pp r2.z, -r2, c9.y
dsy r4.xy, v1
mad_pp r1.xyz, r3.w, r3, r1
max r0.z, r0.w, r2.x
rcp r3.x, r0.z
min r0.z, r0.w, r2.x
mul r0.z, r0, r3.x
mul r3.x, r0.z, r0.z
mad r2.y, r3.x, c11, c11.z
mad r2.y, r2, r3.x, c11.w
mad r2.y, r2, r3.x, c12.x
mad r2.y, r2, r3.x, c12
mad r2.y, r2, r3.x, c12.z
mul r2.y, r2, r0.z
rsq_pp r2.z, r2.z
rcp_pp r0.z, r2.z
add r2.x, r0.w, -r2
add r2.z, -r2.y, c12.w
cmp r2.w, -r2.x, r2.y, r2.z
add_pp r2.xyz, -r0, c9.xxyw
mad_pp r0.xyz, r3.w, r2, r0
add r3.x, -r2.w, c10.w
dp3_pp_sat r0.y, r0, v4
cmp r2.x, v1, r2.w, r3
cmp r0.x, v1.z, r2, -r2
mul_pp r2.xyz, r0.y, c1
mad r3.x, r0, c13, c13.y
add r0.y, -r0.w, c9
mad r0.x, r0.w, c9.z, c9.w
mad r0.x, r0.w, r0, c10
mad r0.x, r0.w, r0, c10.y
abs r0.w, -v1.y
add r3.y, -r0.w, c9
mad r2.w, r0, c9.z, c9
mad r2.w, r2, r0, c10.x
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.y, r0.x, r0
cmp r0.x, v1.z, c9, c9.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c10, r0.y
rsq r3.y, r3.y
mad r0.w, r2, r0, c10.y
rcp r3.y, r3.y
mul r2.w, r0, r3.y
cmp r0.w, -v1.y, c9.x, c9.y
mul r3.y, r0.w, r2.w
mad r0.y, -r3, c10.z, r2.w
mad r0.z, r0.x, c10.w, r0
mad r0.x, r0.w, c10.w, r0.y
mul r0.y, r0.z, c11.x
mul r3.y, r0.x, c11.x
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
mul r0.z, r0.x, c13.x
mul_pp r2.xyz, r2, c10.z
dsy r0.y, r0
mul r0.x, r2.w, c13
texldd r0, r3, s0, r0.zwzw, r0
mul r0, r0, c2
mul_pp r0.xyz, r0, r1
add_sat r1.xyz, r2, c7.x
mul r1.xyz, r0, r1
mad_pp oC0.xyz, r0, v5, r1
add r2.xyz, -v0, c0
dp3 r2.x, r2, r2
rsq r0.x, r2.x
add_pp r0.y, -r1.w, c9
rcp r0.x, r0.x
mad_pp r0.y, r3.w, r0, r1.w
mul_sat r0.x, r0, c8
mul_pp r0.y, r0.w, r0
min r0.x, v2, r0
mul_pp oC0.w, r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 124 used size, 13 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Vector 64 [_DetailOffset] 4
Vector 80 [_BumpOffset] 4
Float 104 [_DetailScale]
Float 112 [_BumpScale]
Float 116 [_MinLight]
Float 120 [_FadeDist]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
// 89 instructions, 6 temp regs, 0 temp arrays:
// ALU 76 float, 0 int, 4 uint
// TEX 6 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfbljnmoagbbheohmhaepmebofikofefpabaaaaaamianaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaamaaaaeaaaaaaaceadaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacagaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaia
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
egiocaaaaaaaaaaaadaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegiecaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaldcaabaaaadaaaaaaegbabaaaacaaaaaakgikcaaaaaaaaaaaagaaaaaa
egiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaia
ibaaaaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaafgbfbaiaibaaaaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
aaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpaacaaaahbcaabaaaadaaaaaadkbabaaaacaaaaaa
dkbabaaaacaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaaaaaaaaaegbcbaaa
aeaaaaaadcaaaaalpcaabaaaacaaaaaaggbcbaaaacaaaaaaagiacaaaaaaaaaaa
ahaaaaaaegiecaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
ogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaalfcaabaaa
acaaaaaaagbbbaaaacaaaaaaagiacaaaaaaaaaaaahaaaaaaagibcaaaaaaaaaaa
afaaaaaaefaaaaajpcaabaaaafaaaaaaigaabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaaifcaabaaaacaaaaaapganbaaaaeaaaaaapganbaia
ebaaaaaaafaaaaaadcaaaaakfcaabaaaacaaaaaaagbabaiaibaaaaaaacaaaaaa
agacbaaaacaaaaaapganbaaaafaaaaaaaaaaaaaikcaabaaaacaaaaaaagaibaia
ebaaaaaaacaaaaaapgahbaaaacaaaaaadcaaaaakdcaabaaaacaaaaaafgbfbaia
ibaaaaaaacaaaaaangafbaaaacaaaaaaigaabaaaacaaaaaadcaaaaapdcaabaaa
acaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaa
egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaabaaaaaa
aaaaaaalocaabaaaadaaaaaaagajbaiaebaaaaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaiadpdcaaaaajhcaabaaaacaaaaaaagaabaaaadaaaaaa
jgahbaaaadaaaaaaegacbaaaacaaaaaabacaaaahicaabaaaabaaaaaaegacbaaa
acaaaaaaegbcbaaaadaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
dkaabaaaabaaaaaadccaaaalhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaa
pgapbaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckiacaaaaaaaaaaaahaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaadoaaaaab"
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
Float 5 [_DetailScale]
Float 6 [_BumpScale]
Float 7 [_MinLight]
Float 8 [_FadeDist]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"ps_3_0
; 113 ALU, 10 TEX
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
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.x
dcl_texcoord3 v3.x
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6
mul r0.zw, v1.xyxy, c5.x
add r1.xy, r0.zwzw, c3
mul r0.xy, v1.zyzw, c5.x
add r0.xy, r0, c3
mul r3.xy, v1.zxzw, c5.x
texld r0, r0, s1
texld r1, r1, s1
add_pp r2, r0, -r1
abs r0.xy, v1
mul r0.zw, v1.xyzy, c6.x
add r4.xy, r0.zwzw, c4
texld r4.yw, r4, s2
mad_pp r1, r0.x, r2, r1
add r3.xy, r3, c3
texld r2, r3, s1
add_pp r2, r2, -r1
mad_pp r2, r0.y, r2, r1
mul r3.xy, v1, c6.x
add r3.xy, r3, c4
texld r3.yw, r3, s2
add_pp r0.zw, r4.xyyw, -r3.xyyw
abs r4.x, v1.z
mad_pp r0.zw, r0.x, r0, r3.xyyw
add_pp r1.xyz, -r2, c9.y
mul_sat r1.w, v3.x, c10.z
mad_pp r1.xyz, r1.w, r1, r2
mul r2.xy, v1.zxzw, c6.x
add r2.xy, r2, c4
texld r3.yw, r2, s2
add_pp r2.xy, r3.ywzw, -r0.zwzw
mad_pp r0.zw, r0.y, r2.xyxy, r0
max r2.z, r4.x, r0.x
min r0.y, r4.x, r0.x
rcp r2.x, r2.z
mul r0.y, r0, r2.x
mul r3.x, r0.y, r0.y
mad_pp r2.xy, r0.wzzw, c13.z, c13.w
mul_pp r0.zw, r2.xyxy, r2.xyxy
add_pp_sat r0.w, r0.z, r0
mad r2.z, r3.x, c11.y, c11
mad r0.z, r2, r3.x, c11.w
mad r0.z, r0, r3.x, c12.x
mad r0.z, r0, r3.x, c12.y
mad r0.z, r0, r3.x, c12
mul r0.y, r0.z, r0
add_pp r0.w, -r0, c9.y
rsq_pp r0.w, r0.w
rcp_pp r2.z, r0.w
add_pp r3.xyz, -r2, c9.xxyw
mad_pp r2.xyz, r1.w, r3, r2
add r0.z, -r0.y, c12.w
add r0.x, r4, -r0
cmp r0.y, -r0.x, r0, r0.z
add r0.z, -r0.y, c10.w
cmp r0.y, v1.x, r0, r0.z
dp3_pp_sat r0.w, r2, v4
texldp r0.x, v6, s3
mul_pp r0.z, r0.w, r0.x
abs r0.w, -v1.y
cmp r0.x, v1.z, r0.y, -r0.y
mul_pp r2.xyz, r0.z, c1
mad r3.x, r0, c13, c13.y
add r3.z, -r0.w, c9.y
mad r3.y, r0.w, c9.z, c9.w
mad r3.y, r3, r0.w, c10.x
add r0.y, -r4.x, c9
mad r0.x, r4, c9.z, c9.w
rsq r0.y, r0.y
mad r0.x, r4, r0, c10
rsq r3.z, r3.z
mad r0.w, r3.y, r0, c10.y
rcp r3.z, r3.z
mul r3.y, r0.w, r3.z
cmp r0.w, -v1.y, c9.x, c9.y
mul r3.z, r0.w, r3.y
mad r0.x, r4, r0, c10.y
rcp r0.y, r0.y
mul r0.y, r0.x, r0
cmp r0.x, v1.z, c9, c9.y
mul r0.z, r0.x, r0.y
mad r0.z, -r0, c10, r0.y
mad r0.y, -r3.z, c10.z, r3
mad r0.z, r0.x, c10.w, r0
mad r0.x, r0.w, c10.w, r0.y
mul r0.y, r0.z, c11.x
mul r3.y, r0.x, c11.x
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
mul r0.z, r0.x, c13.x
mul_pp r2.xyz, r2, c10.z
dsy r0.y, r0
mul r0.x, r3.z, c13
texldd r0, r3, s0, r0.zwzw, r0
mul r0, r0, c2
mul_pp r0.xyz, r0, r1
add_sat r1.xyz, r2, c7.x
mul r1.xyz, r0, r1
mad_pp oC0.xyz, r0, v5, r1
add r2.xyz, -v0, c0
dp3 r2.x, r2, r2
rsq r0.x, r2.x
add_pp r0.y, -r2.w, c9
rcp r0.x, r0.x
mad_pp r0.y, r1.w, r0, r2.w
mul_sat r0.x, r0, c8
mul_pp r0.y, r0.w, r0
min r0.x, v2, r0
mul_pp oC0.w, r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 188 used size, 14 vars
Vector 16 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_DetailOffset] 4
Vector 144 [_BumpOffset] 4
Float 168 [_DetailScale]
Float 176 [_BumpScale]
Float 180 [_MinLight]
Float 184 [_FadeDist]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_DetailTex] 2D 2
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_ShadowMapTexture] 2D 0
// 91 instructions, 6 temp regs, 0 temp arrays:
// ALU 77 float, 0 int, 4 uint
// TEX 7 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedioflfgokgnahnhdnohmggklbnodbeamnabaaaaaaeiaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaafaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcpiamaaaaeaaaaaaadoadaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacagaaaaaadeaaaaajbcaabaaaaaaaaaaaakbabaia
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
egiocaaaaaaaaaaaahaaaaaadcaaaaalpcaabaaaabaaaaaaggbcbaaaacaaaaaa
kgikcaaaaaaaaaaaakaaaaaaegiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
dcaaaaaldcaabaaaadaaaaaaegbabaaaacaaaaaakgikcaaaaaaaaaaaakaaaaaa
egiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaagbabaia
ibaaaaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaafgbfbaiaibaaaaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
aaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpaacaaaahbcaabaaaadaaaaaadkbabaaaacaaaaaa
dkbabaaaacaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaaaaaaaaaegbcbaaa
aeaaaaaadcaaaaalpcaabaaaacaaaaaaggbcbaaaacaaaaaaagiacaaaaaaaaaaa
alaaaaaaegiecaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaacaaaaaa
ogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaalfcaabaaa
acaaaaaaagbbbaaaacaaaaaaagiacaaaaaaaaaaaalaaaaaaagibcaaaaaaaaaaa
ajaaaaaaefaaaaajpcaabaaaafaaaaaaigaabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaadaaaaaaaaaaaaaifcaabaaaacaaaaaapganbaaaaeaaaaaapganbaia
ebaaaaaaafaaaaaadcaaaaakfcaabaaaacaaaaaaagbabaiaibaaaaaaacaaaaaa
agacbaaaacaaaaaapganbaaaafaaaaaaaaaaaaaikcaabaaaacaaaaaaagaibaia
ebaaaaaaacaaaaaapgahbaaaacaaaaaadcaaaaakdcaabaaaacaaaaaafgbfbaia
ibaaaaaaacaaaaaangafbaaaacaaaaaaigaabaaaacaaaaaadcaaaaapdcaabaaa
acaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaa
egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaabaaaaaa
aaaaaaalocaabaaaadaaaaaaagajbaiaebaaaaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaiadpdcaaaaajhcaabaaaacaaaaaaagaabaaaadaaaaaa
jgahbaaaadaaaaaaegacbaaaacaaaaaabacaaaahicaabaaaabaaaaaaegacbaaa
acaaaaaaegbcbaaaadaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaafaaaaaa
pgbpbaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaaabaaaaaapgapbaaaabaaaaaa
agaabaaaacaaaaaadccaaaalhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaa
pgapbaaaabaaaaaafgifcaaaaaaaaaaaalaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckiacaaaaaaaaaaaalaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaadoaaaaab"
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

#LINE 119

	
	}
	
	 
	FallBack "Diffuse"
}
