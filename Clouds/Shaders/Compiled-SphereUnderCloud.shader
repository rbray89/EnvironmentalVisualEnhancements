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
//   opengl - ALU: 63 to 68
//   d3d9 - ALU: 59 to 64
//   d3d11 - ALU: 51 to 54, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Vector 2 [_WorldSpaceCameraPos]
Vector 3 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Float 4 [_FalloffPow]
Float 17 [_FalloffScale]
Float 18 [_DetailDist]
"3.0-!!ARBvp1.0
# 63 ALU
PARAM c[19] = { { 0, 1, 0.085000001, 0.80000001 },
		state.lightmodel.ambient,
		program.local[2..12],
		state.matrix.mvp,
		program.local[17..18] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R3.xyz, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
ADD R2.xyz, R0, -c[2];
DP3 R2.w, R2, R2;
DP4 R1.z, vertex.normal.xyzz, c[7];
DP4 R1.x, vertex.normal.xyzz, c[5];
DP4 R1.y, vertex.normal.xyzz, c[6];
DP3 R0.w, R1, R1;
RSQ R1.w, R0.w;
RSQ R0.w, R2.w;
MUL R2.xyz, R0.w, R2;
MUL R1.xyz, R1.w, R1;
DP3 R1.w, R1, -R2;
MUL R1.xyz, vertex.normal.zxyw, R3.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R3.zxyw, -R1;
MUL R2.w, R1, c[17].x;
MOV R1, c[3];
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
MUL R2.xyz, R2, vertex.attrib[14].w;
MUL R1.x, R2.w, c[0].w;
POW R1.y, R1.x, c[4].x;
RCP R0.w, R0.w;
MUL R1.x, R0.w, c[0].z;
MIN R1.y, R1, c[0];
MIN R1.x, R1, c[0].y;
MAX R1.y, R1, c[0].x;
MAX R1.x, R1, c[0];
ADD R1.w, R1.x, R1.y;
MOV R1.x, c[5].w;
MOV R1.z, c[7].w;
MOV R1.y, c[6].w;
ADD R0.xyz, R0, -R1;
DP3 R0.x, R0, R0;
DP3 result.texcoord[2].y, R3, R2;
ADD R2.xyz, -R1, c[2];
DP3 R1.x, R2, R2;
RSQ R0.y, R1.x;
RSQ R0.x, R0.x;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
ADD R0.x, R0, -R0.y;
MIN R0.y, R1.w, c[0];
MIN R0.x, R0, c[0].y;
MAX R0.y, R0, c[0].x;
MAX R0.x, R0, c[0];
MUL result.texcoord[0].y, R0.x, R0;
MUL R0.x, R0.w, c[18];
DP3 R0.y, vertex.position, vertex.position;
MIN R0.x, R0, c[0].y;
RSQ R0.y, R0.y;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
MAX result.texcoord[0].x, R0, c[0];
MUL result.texcoord[1].xyz, R0.y, vertex.position;
MOV result.texcoord[3].xyz, c[1];
DP4 result.position.w, vertex.position, c[16];
DP4 result.position.z, vertex.position, c[15];
DP4 result.position.y, vertex.position, c[14];
DP4 result.position.x, vertex.position, c[13];
END
# 63 instructions, 4 R-regs
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
def c18, 0.08500000, 0.80000001, 0, 0
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
add r1.xyz, -r0, c13
add r0.xyz, r3, -r0
dp3 r0.x, r0, r0
dp3 r1.x, r1, r1
rsq r0.y, r1.x
rsq r0.x, r0.x
rcp r0.y, r0.y
rcp r0.x, r0.x
add_sat r0.x, r0, -r0.y
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
eefiecedmehehmoagfcfchcgjjkfabpbmeopebpjabaaaaaanaaiaaaaadaaaaaa
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
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdeahaaaaeaaaabaa
mnabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
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
ccaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaahlbekodndicaaaaibccabaaa
abaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaagaaaaaaddaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaakhcaabaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
kcaabaaaaaaaaaaafganbaaaaaaaaaaaaacaaaaiccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahcccabaaaabaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaa
egbcbaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hccabaaaacaaaaaaagaabaaaaaaaaaaaegbcbaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
adaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaaeaaaaaa
egiccaaaaeaaaaaaaeaaaaaadoaaaaab"
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
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - sqrt(dot (p_9, p_9))), 0.0, 1.0) * clamp ((clamp ((0.085 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
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
    highp float s_19;
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
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2D (_MainTex, uv_16) * _Color);
  main_15 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_14 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_13 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_12 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_29 = texture2D (_BumpMap, P_30);
  normalX_11 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_31 = texture2D (_BumpMap, P_32);
  normalY_10 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_33 = texture2D (_BumpMap, P_34);
  normalZ_9 = tmpvar_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_36;
  tmpvar_36 = mix (detailZ_12, detailX_14, tmpvar_35.xxxx);
  detail_8 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = mix (detail_8, detailY_13, tmpvar_35.yyyy);
  detail_8 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = mix (normalZ_9, normalX_11, tmpvar_35.xxxx);
  normal_7 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (normal_7, normalY_10, tmpvar_35.yyyy);
  normal_7 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41 = ((main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6))) * _Color.xyz);
  tmpvar_3 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_43;
  tmpvar_43 = (tmpvar_42 * xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_43;
  lowp vec3 tmpvar_44;
  lowp vec4 packednormal_45;
  packednormal_45 = normal_7;
  tmpvar_44 = ((packednormal_45.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_46;
  tmpvar_46 = mix (tmpvar_44, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_46;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_47;
  lightDir_47 = xlv_TEXCOORD2;
  mediump vec4 c_48;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (dot (tmpvar_4, lightDir_47), 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_49 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_3 * tmpvar_50);
  c_48.xyz = tmpvar_51;
  c_48.w = tmpvar_5;
  c_1 = c_48;
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
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - sqrt(dot (p_9, p_9))), 0.0, 1.0) * clamp ((clamp ((0.085 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
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
    highp float s_19;
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
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2D (_MainTex, uv_16) * _Color);
  main_15 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_14 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_13 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_12 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_29 = texture2D (_BumpMap, P_30);
  normalX_11 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_31 = texture2D (_BumpMap, P_32);
  normalY_10 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_33 = texture2D (_BumpMap, P_34);
  normalZ_9 = tmpvar_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_36;
  tmpvar_36 = mix (detailZ_12, detailX_14, tmpvar_35.xxxx);
  detail_8 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = mix (detail_8, detailY_13, tmpvar_35.yyyy);
  detail_8 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = mix (normalZ_9, normalX_11, tmpvar_35.xxxx);
  normal_7 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (normal_7, normalY_10, tmpvar_35.yyyy);
  normal_7 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41 = ((main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6))) * _Color.xyz);
  tmpvar_3 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_43;
  tmpvar_43 = (tmpvar_42 * xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_43;
  lowp vec4 packednormal_44;
  packednormal_44 = normal_7;
  lowp vec3 normal_45;
  normal_45.xy = ((packednormal_44.wy * 2.0) - 1.0);
  normal_45.z = sqrt((1.0 - clamp (dot (normal_45.xy, normal_45.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_46;
  tmpvar_46 = mix (normal_45, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_46;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_47;
  lightDir_47 = xlv_TEXCOORD2;
  mediump vec4 c_48;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (dot (tmpvar_4, lightDir_47), 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_49 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_3 * tmpvar_50);
  c_48.xyz = tmpvar_51;
  c_48.w = tmpvar_5;
  c_1 = c_48;
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
#line 456
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
#line 465
#line 482
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
    highp float diff = (distance( origin, vertexPos) - distance( origin, _WorldSpaceCameraPos));
    o.viewDist.x = xll_saturate_f((_DetailDist * distance( vertexPos, _WorldSpaceCameraPos)));
    o.viewDist.y = (xll_saturate_f(diff) * xll_saturate_f((xll_saturate_f((0.085 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow)))));
    o.localPos = normalize(v.vertex.xyz);
}
#line 465
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 469
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 473
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 477
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
#line 456
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
#line 465
#line 482
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
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 431
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    #line 435
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    mediump vec4 main = (texture( _MainTex, uv) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    #line 439
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    #line 443
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    #line 447
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = IN.viewDist.x;
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    #line 451
    o.Albedo = (albedo * vec3( _Color));
    mediump float avg = (mix( detail.w, 1.0, detailLevel) * main.w);
    o.Alpha = (avg * IN.viewDist.y);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 482
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    #line 486
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 490
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 494
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    #line 498
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
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Vector 2 [_WorldSpaceCameraPos]
Vector 3 [_ProjectionParams]
Vector 4 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Float 17 [_FalloffPow]
Float 18 [_FalloffScale]
Float 19 [_DetailDist]
"3.0-!!ARBvp1.0
# 68 ALU
PARAM c[21] = { { 0, 1, 0.085000001, 0.80000001 },
		state.lightmodel.ambient,
		program.local[2..12],
		state.matrix.mvp,
		program.local[17..19],
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R3.xyz, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
ADD R2.xyz, R0, -c[2];
DP3 R2.w, R2, R2;
DP4 R1.z, vertex.normal.xyzz, c[7];
DP4 R1.x, vertex.normal.xyzz, c[5];
DP4 R1.y, vertex.normal.xyzz, c[6];
DP3 R0.w, R1, R1;
RSQ R1.w, R0.w;
RSQ R0.w, R2.w;
MUL R1.xyz, R1.w, R1;
MUL R2.xyz, R0.w, R2;
DP3 R1.w, R1, -R2;
MUL R1.xyz, vertex.normal.zxyw, R3.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R3.zxyw, -R1;
MUL R2.w, R1, c[18].x;
MOV R1, c[4];
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
RCP R1.w, R0.w;
MUL R2.xyz, R2, vertex.attrib[14].w;
MUL R1.x, R2.w, c[0].w;
POW R1.x, R1.x, c[17].x;
MUL R0.w, R1, c[0].z;
MIN R1.x, R1, c[0].y;
MIN R0.w, R0, c[0].y;
MOV R1.z, c[7].w;
MOV R1.y, c[6].w;
MAX R1.x, R1, c[0];
MAX R0.w, R0, c[0].x;
ADD R0.w, R0, R1.x;
MOV R1.x, c[5].w;
ADD R0.xyz, R0, -R1;
DP3 R0.x, R0, R0;
DP3 result.texcoord[2].y, R3, R2;
ADD R2.xyz, -R1, c[2];
DP3 R1.x, R2, R2;
RSQ R0.y, R1.x;
RSQ R0.x, R0.x;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
ADD R0.x, R0, -R0.y;
MIN R0.y, R0.w, c[0];
MIN R0.x, R0, c[0].y;
DP4 R0.w, vertex.position, c[16];
DP4 R0.z, vertex.position, c[15];
MAX R0.y, R0, c[0].x;
MAX R0.x, R0, c[0];
MUL result.texcoord[0].y, R0.x, R0;
DP4 R0.x, vertex.position, c[13];
DP4 R0.y, vertex.position, c[14];
MUL R1.xyz, R0.xyww, c[20].x;
MOV result.position, R0;
MUL R1.y, R1, c[3].x;
MUL R0.x, R1.w, c[19];
DP3 R0.y, vertex.position, vertex.position;
MIN R0.x, R0, c[0].y;
RSQ R0.y, R0.y;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.texcoord[4].zw, R0;
MAX result.texcoord[0].x, R0, c[0];
MUL result.texcoord[1].xyz, R0.y, vertex.position;
MOV result.texcoord[3].xyz, c[1];
END
# 68 instructions, 4 R-regs
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
def c20, 0.08500000, 0.80000001, 0.50000000, 0
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
add r1.xyz, -r0, c13
add r0.xyz, r3, -r0
dp3 r0.x, r0, r0
dp3 r1.x, r1, r1
rsq r0.y, r1.x
rsq r0.x, r0.x
rcp r0.y, r0.y
rcp r0.x, r0.x
add_sat r0.x, r0, -r0.y
mul o1.y, r0.x, r0.w
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c20.z
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
eefiecedpmnnffnglbkjmadgklklblianogdemnlabaaaaaaiaajaaaaadaaaaaa
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
feeffiedepepfceeaaklklklfdeieefcmmahaaaaeaaaabaapdabaaaafjaaaaae
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
akaabaaaacaaaaaaabeaaaaahlbekodndicaaaaibccabaaaabaaaaaaakaabaaa
acaaaaaadkiacaaaaaaaaaaaakaaaaaaddaaaaakdcaabaaaabaaaaaaegaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaaaaaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaakhcaabaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafkcaabaaaabaaaaaa
fganbaaaabaaaaaaaacaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahcccabaaaabaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaa
eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhccabaaaacaaaaaa
agaabaaaabaaaaaaegbcbaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaa
acaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaa
bdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaa
adaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaadaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaaaeaaaaaa
aeaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
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
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - sqrt(dot (p_9, p_9))), 0.0, 1.0) * clamp ((clamp ((0.085 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
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
    highp float s_19;
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
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2D (_MainTex, uv_16) * _Color);
  main_15 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_14 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_13 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_12 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_29 = texture2D (_BumpMap, P_30);
  normalX_11 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_31 = texture2D (_BumpMap, P_32);
  normalY_10 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_33 = texture2D (_BumpMap, P_34);
  normalZ_9 = tmpvar_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_36;
  tmpvar_36 = mix (detailZ_12, detailX_14, tmpvar_35.xxxx);
  detail_8 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = mix (detail_8, detailY_13, tmpvar_35.yyyy);
  detail_8 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = mix (normalZ_9, normalX_11, tmpvar_35.xxxx);
  normal_7 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (normal_7, normalY_10, tmpvar_35.yyyy);
  normal_7 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41 = ((main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6))) * _Color.xyz);
  tmpvar_3 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_43;
  tmpvar_43 = (tmpvar_42 * xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_43;
  lowp vec3 tmpvar_44;
  lowp vec4 packednormal_45;
  packednormal_45 = normal_7;
  tmpvar_44 = ((packednormal_45.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_46;
  tmpvar_46 = mix (tmpvar_44, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_46;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_47;
  mediump float lightShadowDataX_48;
  highp float dist_49;
  lowp float tmpvar_50;
  tmpvar_50 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_49 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = _LightShadowData.x;
  lightShadowDataX_48 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = max (float((dist_49 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_48);
  tmpvar_47 = tmpvar_52;
  mediump vec3 lightDir_53;
  lightDir_53 = xlv_TEXCOORD2;
  mediump float atten_54;
  atten_54 = tmpvar_47;
  mediump vec4 c_55;
  mediump float tmpvar_56;
  tmpvar_56 = clamp (dot (tmpvar_4, lightDir_53), 0.0, 1.0);
  highp vec3 tmpvar_57;
  tmpvar_57 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_56 * atten_54) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_58;
  tmpvar_58 = (tmpvar_3 * tmpvar_57);
  c_55.xyz = tmpvar_58;
  c_55.w = tmpvar_5;
  c_1 = c_55;
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
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - sqrt(dot (p_9, p_9))), 0.0, 1.0) * clamp ((clamp ((0.085 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
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
    highp float s_19;
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
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2D (_MainTex, uv_16) * _Color);
  main_15 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_14 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_13 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_12 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_29 = texture2D (_BumpMap, P_30);
  normalX_11 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_31 = texture2D (_BumpMap, P_32);
  normalY_10 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_33 = texture2D (_BumpMap, P_34);
  normalZ_9 = tmpvar_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_36;
  tmpvar_36 = mix (detailZ_12, detailX_14, tmpvar_35.xxxx);
  detail_8 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = mix (detail_8, detailY_13, tmpvar_35.yyyy);
  detail_8 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = mix (normalZ_9, normalX_11, tmpvar_35.xxxx);
  normal_7 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (normal_7, normalY_10, tmpvar_35.yyyy);
  normal_7 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41 = ((main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6))) * _Color.xyz);
  tmpvar_3 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_43;
  tmpvar_43 = (tmpvar_42 * xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_43;
  lowp vec4 packednormal_44;
  packednormal_44 = normal_7;
  lowp vec3 normal_45;
  normal_45.xy = ((packednormal_44.wy * 2.0) - 1.0);
  normal_45.z = sqrt((1.0 - clamp (dot (normal_45.xy, normal_45.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_46;
  tmpvar_46 = mix (normal_45, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_46;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_47;
  tmpvar_47 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  mediump vec3 lightDir_48;
  lightDir_48 = xlv_TEXCOORD2;
  mediump float atten_49;
  atten_49 = tmpvar_47;
  mediump vec4 c_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (dot (tmpvar_4, lightDir_48), 0.0, 1.0);
  highp vec3 tmpvar_52;
  tmpvar_52 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_51 * atten_49) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_53;
  tmpvar_53 = (tmpvar_3 * tmpvar_52);
  c_50.xyz = tmpvar_53;
  c_50.w = tmpvar_5;
  c_1 = c_50;
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
#line 464
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
#line 474
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
    highp float diff = (distance( origin, vertexPos) - distance( origin, _WorldSpaceCameraPos));
    o.viewDist.x = xll_saturate_f((_DetailDist * distance( vertexPos, _WorldSpaceCameraPos)));
    o.viewDist.y = (xll_saturate_f(diff) * xll_saturate_f((xll_saturate_f((0.085 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow)))));
    o.localPos = normalize(v.vertex.xyz);
}
#line 474
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 478
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 482
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 486
    o.lightDir = lightDir;
    o.vlight = glstate_lightmodel_ambient.xyz;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 490
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
#line 464
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
#line 474
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
    mediump vec4 main = (texture( _MainTex, uv) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    #line 447
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    #line 451
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    #line 455
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = IN.viewDist.x;
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    #line 459
    o.Albedo = (albedo * vec3( _Color));
    mediump float avg = (mix( detail.w, 1.0, detailLevel) * main.w);
    o.Alpha = (avg * IN.viewDist.y);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 492
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 494
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 498
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 502
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 506
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
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Vector 2 [_WorldSpaceCameraPos]
Vector 3 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Float 4 [_FalloffPow]
Float 17 [_FalloffScale]
Float 18 [_DetailDist]
"3.0-!!ARBvp1.0
# 63 ALU
PARAM c[19] = { { 0, 1, 0.085000001, 0.80000001 },
		state.lightmodel.ambient,
		program.local[2..12],
		state.matrix.mvp,
		program.local[17..18] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R3.xyz, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
ADD R2.xyz, R0, -c[2];
DP3 R2.w, R2, R2;
DP4 R1.z, vertex.normal.xyzz, c[7];
DP4 R1.x, vertex.normal.xyzz, c[5];
DP4 R1.y, vertex.normal.xyzz, c[6];
DP3 R0.w, R1, R1;
RSQ R1.w, R0.w;
RSQ R0.w, R2.w;
MUL R2.xyz, R0.w, R2;
MUL R1.xyz, R1.w, R1;
DP3 R1.w, R1, -R2;
MUL R1.xyz, vertex.normal.zxyw, R3.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R3.zxyw, -R1;
MUL R2.w, R1, c[17].x;
MOV R1, c[3];
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
MUL R2.xyz, R2, vertex.attrib[14].w;
MUL R1.x, R2.w, c[0].w;
POW R1.y, R1.x, c[4].x;
RCP R0.w, R0.w;
MUL R1.x, R0.w, c[0].z;
MIN R1.y, R1, c[0];
MIN R1.x, R1, c[0].y;
MAX R1.y, R1, c[0].x;
MAX R1.x, R1, c[0];
ADD R1.w, R1.x, R1.y;
MOV R1.x, c[5].w;
MOV R1.z, c[7].w;
MOV R1.y, c[6].w;
ADD R0.xyz, R0, -R1;
DP3 R0.x, R0, R0;
DP3 result.texcoord[2].y, R3, R2;
ADD R2.xyz, -R1, c[2];
DP3 R1.x, R2, R2;
RSQ R0.y, R1.x;
RSQ R0.x, R0.x;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
ADD R0.x, R0, -R0.y;
MIN R0.y, R1.w, c[0];
MIN R0.x, R0, c[0].y;
MAX R0.y, R0, c[0].x;
MAX R0.x, R0, c[0];
MUL result.texcoord[0].y, R0.x, R0;
MUL R0.x, R0.w, c[18];
DP3 R0.y, vertex.position, vertex.position;
MIN R0.x, R0, c[0].y;
RSQ R0.y, R0.y;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
MAX result.texcoord[0].x, R0, c[0];
MUL result.texcoord[1].xyz, R0.y, vertex.position;
MOV result.texcoord[3].xyz, c[1];
DP4 result.position.w, vertex.position, c[16];
DP4 result.position.z, vertex.position, c[15];
DP4 result.position.y, vertex.position, c[14];
DP4 result.position.x, vertex.position, c[13];
END
# 63 instructions, 4 R-regs
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
def c18, 0.08500000, 0.80000001, 0, 0
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
add r1.xyz, -r0, c13
add r0.xyz, r3, -r0
dp3 r0.x, r0, r0
dp3 r1.x, r1, r1
rsq r0.y, r1.x
rsq r0.x, r0.x
rcp r0.y, r0.y
rcp r0.x, r0.x
add_sat r0.x, r0, -r0.y
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
eefiecedmehehmoagfcfchcgjjkfabpbmeopebpjabaaaaaanaaiaaaaadaaaaaa
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
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdeahaaaaeaaaabaa
mnabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
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
ccaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaahlbekodndicaaaaibccabaaa
abaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaagaaaaaaddaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaddaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaakhcaabaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
kcaabaaaaaaaaaaafganbaaaaaaaaaaaaacaaaaiccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahcccabaaaabaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaa
egbcbaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hccabaaaacaaaaaaagaabaaaaaaaaaaaegbcbaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
adaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaaeaaaaaa
egiccaaaaeaaaaaaaeaaaaaadoaaaaab"
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
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - sqrt(dot (p_9, p_9))), 0.0, 1.0) * clamp ((clamp ((0.085 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
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
    highp float s_19;
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
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2D (_MainTex, uv_16) * _Color);
  main_15 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_14 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_13 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_12 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_29 = texture2D (_BumpMap, P_30);
  normalX_11 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_31 = texture2D (_BumpMap, P_32);
  normalY_10 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_33 = texture2D (_BumpMap, P_34);
  normalZ_9 = tmpvar_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_36;
  tmpvar_36 = mix (detailZ_12, detailX_14, tmpvar_35.xxxx);
  detail_8 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = mix (detail_8, detailY_13, tmpvar_35.yyyy);
  detail_8 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = mix (normalZ_9, normalX_11, tmpvar_35.xxxx);
  normal_7 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (normal_7, normalY_10, tmpvar_35.yyyy);
  normal_7 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41 = ((main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6))) * _Color.xyz);
  tmpvar_3 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_43;
  tmpvar_43 = (tmpvar_42 * xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_43;
  lowp vec3 tmpvar_44;
  lowp vec4 packednormal_45;
  packednormal_45 = normal_7;
  tmpvar_44 = ((packednormal_45.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_46;
  tmpvar_46 = mix (tmpvar_44, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_46;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_47;
  lightDir_47 = xlv_TEXCOORD2;
  mediump vec4 c_48;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (dot (tmpvar_4, lightDir_47), 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_49 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_3 * tmpvar_50);
  c_48.xyz = tmpvar_51;
  c_48.w = tmpvar_5;
  c_1 = c_48;
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
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - sqrt(dot (p_9, p_9))), 0.0, 1.0) * clamp ((clamp ((0.085 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
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
    highp float s_19;
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
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2D (_MainTex, uv_16) * _Color);
  main_15 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_14 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_13 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_12 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_29 = texture2D (_BumpMap, P_30);
  normalX_11 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_31 = texture2D (_BumpMap, P_32);
  normalY_10 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_33 = texture2D (_BumpMap, P_34);
  normalZ_9 = tmpvar_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_36;
  tmpvar_36 = mix (detailZ_12, detailX_14, tmpvar_35.xxxx);
  detail_8 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = mix (detail_8, detailY_13, tmpvar_35.yyyy);
  detail_8 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = mix (normalZ_9, normalX_11, tmpvar_35.xxxx);
  normal_7 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (normal_7, normalY_10, tmpvar_35.yyyy);
  normal_7 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41 = ((main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6))) * _Color.xyz);
  tmpvar_3 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_43;
  tmpvar_43 = (tmpvar_42 * xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_43;
  lowp vec4 packednormal_44;
  packednormal_44 = normal_7;
  lowp vec3 normal_45;
  normal_45.xy = ((packednormal_44.wy * 2.0) - 1.0);
  normal_45.z = sqrt((1.0 - clamp (dot (normal_45.xy, normal_45.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_46;
  tmpvar_46 = mix (normal_45, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_46;
  tmpvar_2 = tmpvar_4;
  mediump vec3 lightDir_47;
  lightDir_47 = xlv_TEXCOORD2;
  mediump vec4 c_48;
  mediump float tmpvar_49;
  tmpvar_49 = clamp (dot (tmpvar_4, lightDir_47), 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = clamp ((_MinLight + (_LightColor0.xyz * (tmpvar_49 * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_3 * tmpvar_50);
  c_48.xyz = tmpvar_51;
  c_48.w = tmpvar_5;
  c_1 = c_48;
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
#line 456
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
#line 465
#line 482
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
    highp float diff = (distance( origin, vertexPos) - distance( origin, _WorldSpaceCameraPos));
    o.viewDist.x = xll_saturate_f((_DetailDist * distance( vertexPos, _WorldSpaceCameraPos)));
    o.viewDist.y = (xll_saturate_f(diff) * xll_saturate_f((xll_saturate_f((0.085 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow)))));
    o.localPos = normalize(v.vertex.xyz);
}
#line 465
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 469
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 473
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 477
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
#line 456
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
#line 465
#line 482
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
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 431
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    #line 435
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    mediump vec4 main = (texture( _MainTex, uv) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    #line 439
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    #line 443
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    #line 447
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = IN.viewDist.x;
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    #line 451
    o.Albedo = (albedo * vec3( _Color));
    mediump float avg = (mix( detail.w, 1.0, detailLevel) * main.w);
    o.Alpha = (avg * IN.viewDist.y);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 482
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    #line 486
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 490
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 494
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    c = LightingSimpleLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    #line 498
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
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Vector 2 [_WorldSpaceCameraPos]
Vector 3 [_ProjectionParams]
Vector 4 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Float 17 [_FalloffPow]
Float 18 [_FalloffScale]
Float 19 [_DetailDist]
"3.0-!!ARBvp1.0
# 68 ALU
PARAM c[21] = { { 0, 1, 0.085000001, 0.80000001 },
		state.lightmodel.ambient,
		program.local[2..12],
		state.matrix.mvp,
		program.local[17..19],
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R3.xyz, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
ADD R2.xyz, R0, -c[2];
DP3 R2.w, R2, R2;
DP4 R1.z, vertex.normal.xyzz, c[7];
DP4 R1.x, vertex.normal.xyzz, c[5];
DP4 R1.y, vertex.normal.xyzz, c[6];
DP3 R0.w, R1, R1;
RSQ R1.w, R0.w;
RSQ R0.w, R2.w;
MUL R1.xyz, R1.w, R1;
MUL R2.xyz, R0.w, R2;
DP3 R1.w, R1, -R2;
MUL R1.xyz, vertex.normal.zxyw, R3.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R3.zxyw, -R1;
MUL R2.w, R1, c[18].x;
MOV R1, c[4];
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
RCP R1.w, R0.w;
MUL R2.xyz, R2, vertex.attrib[14].w;
MUL R1.x, R2.w, c[0].w;
POW R1.x, R1.x, c[17].x;
MUL R0.w, R1, c[0].z;
MIN R1.x, R1, c[0].y;
MIN R0.w, R0, c[0].y;
MOV R1.z, c[7].w;
MOV R1.y, c[6].w;
MAX R1.x, R1, c[0];
MAX R0.w, R0, c[0].x;
ADD R0.w, R0, R1.x;
MOV R1.x, c[5].w;
ADD R0.xyz, R0, -R1;
DP3 R0.x, R0, R0;
DP3 result.texcoord[2].y, R3, R2;
ADD R2.xyz, -R1, c[2];
DP3 R1.x, R2, R2;
RSQ R0.y, R1.x;
RSQ R0.x, R0.x;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
ADD R0.x, R0, -R0.y;
MIN R0.y, R0.w, c[0];
MIN R0.x, R0, c[0].y;
DP4 R0.w, vertex.position, c[16];
DP4 R0.z, vertex.position, c[15];
MAX R0.y, R0, c[0].x;
MAX R0.x, R0, c[0];
MUL result.texcoord[0].y, R0.x, R0;
DP4 R0.x, vertex.position, c[13];
DP4 R0.y, vertex.position, c[14];
MUL R1.xyz, R0.xyww, c[20].x;
MOV result.position, R0;
MUL R1.y, R1, c[3].x;
MUL R0.x, R1.w, c[19];
DP3 R0.y, vertex.position, vertex.position;
MIN R0.x, R0, c[0].y;
RSQ R0.y, R0.y;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.texcoord[4].zw, R0;
MAX result.texcoord[0].x, R0, c[0];
MUL result.texcoord[1].xyz, R0.y, vertex.position;
MOV result.texcoord[3].xyz, c[1];
END
# 68 instructions, 4 R-regs
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
def c20, 0.08500000, 0.80000001, 0.50000000, 0
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
add r1.xyz, -r0, c13
add r0.xyz, r3, -r0
dp3 r0.x, r0, r0
dp3 r1.x, r1, r1
rsq r0.y, r1.x
rsq r0.x, r0.x
rcp r0.y, r0.y
rcp r0.x, r0.x
add_sat r0.x, r0, -r0.y
mul o1.y, r0.x, r0.w
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c20.z
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
eefiecedpmnnffnglbkjmadgklklblianogdemnlabaaaaaaiaajaaaaadaaaaaa
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
feeffiedepepfceeaaklklklfdeieefcmmahaaaaeaaaabaapdabaaaafjaaaaae
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
akaabaaaacaaaaaaabeaaaaahlbekodndicaaaaibccabaaaabaaaaaaakaabaaa
acaaaaaadkiacaaaaaaaaaaaakaaaaaaddaaaaakdcaabaaaabaaaaaaegaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaaaaaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaaddaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaakhcaabaaaacaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafkcaabaaaabaaaaaa
fganbaaaabaaaaaaaacaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahcccabaaaabaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaa
eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhccabaaaacaaaaaa
agaabaaaabaaaaaaegbcbaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaa
acaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaa
bdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaa
adaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaadaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaaaeaaaaaa
aeaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
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
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - sqrt(dot (p_9, p_9))), 0.0, 1.0) * clamp ((clamp ((0.085 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
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
    highp float s_19;
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
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2D (_MainTex, uv_16) * _Color);
  main_15 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_14 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_13 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_12 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_29 = texture2D (_BumpMap, P_30);
  normalX_11 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_31 = texture2D (_BumpMap, P_32);
  normalY_10 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_33 = texture2D (_BumpMap, P_34);
  normalZ_9 = tmpvar_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_36;
  tmpvar_36 = mix (detailZ_12, detailX_14, tmpvar_35.xxxx);
  detail_8 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = mix (detail_8, detailY_13, tmpvar_35.yyyy);
  detail_8 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = mix (normalZ_9, normalX_11, tmpvar_35.xxxx);
  normal_7 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (normal_7, normalY_10, tmpvar_35.yyyy);
  normal_7 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41 = ((main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6))) * _Color.xyz);
  tmpvar_3 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_43;
  tmpvar_43 = (tmpvar_42 * xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_43;
  lowp vec3 tmpvar_44;
  lowp vec4 packednormal_45;
  packednormal_45 = normal_7;
  tmpvar_44 = ((packednormal_45.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_46;
  tmpvar_46 = mix (tmpvar_44, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_46;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_47;
  mediump float lightShadowDataX_48;
  highp float dist_49;
  lowp float tmpvar_50;
  tmpvar_50 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_49 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = _LightShadowData.x;
  lightShadowDataX_48 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = max (float((dist_49 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_48);
  tmpvar_47 = tmpvar_52;
  mediump vec3 lightDir_53;
  lightDir_53 = xlv_TEXCOORD2;
  mediump float atten_54;
  atten_54 = tmpvar_47;
  mediump vec4 c_55;
  mediump float tmpvar_56;
  tmpvar_56 = clamp (dot (tmpvar_4, lightDir_53), 0.0, 1.0);
  highp vec3 tmpvar_57;
  tmpvar_57 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_56 * atten_54) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_58;
  tmpvar_58 = (tmpvar_3 * tmpvar_57);
  c_55.xyz = tmpvar_58;
  c_55.w = tmpvar_5;
  c_1 = c_55;
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
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - sqrt(dot (p_9, p_9))), 0.0, 1.0) * clamp ((clamp ((0.085 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
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
    highp float s_19;
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
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2D (_MainTex, uv_16) * _Color);
  main_15 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_14 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_13 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_12 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_29 = texture2D (_BumpMap, P_30);
  normalX_11 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_31 = texture2D (_BumpMap, P_32);
  normalY_10 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_33 = texture2D (_BumpMap, P_34);
  normalZ_9 = tmpvar_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_36;
  tmpvar_36 = mix (detailZ_12, detailX_14, tmpvar_35.xxxx);
  detail_8 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = mix (detail_8, detailY_13, tmpvar_35.yyyy);
  detail_8 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = mix (normalZ_9, normalX_11, tmpvar_35.xxxx);
  normal_7 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (normal_7, normalY_10, tmpvar_35.yyyy);
  normal_7 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41 = ((main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6))) * _Color.xyz);
  tmpvar_3 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_43;
  tmpvar_43 = (tmpvar_42 * xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_43;
  lowp vec4 packednormal_44;
  packednormal_44 = normal_7;
  lowp vec3 normal_45;
  normal_45.xy = ((packednormal_44.wy * 2.0) - 1.0);
  normal_45.z = sqrt((1.0 - clamp (dot (normal_45.xy, normal_45.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_46;
  tmpvar_46 = mix (normal_45, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_46;
  tmpvar_2 = tmpvar_4;
  lowp float tmpvar_47;
  tmpvar_47 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  mediump vec3 lightDir_48;
  lightDir_48 = xlv_TEXCOORD2;
  mediump float atten_49;
  atten_49 = tmpvar_47;
  mediump vec4 c_50;
  mediump float tmpvar_51;
  tmpvar_51 = clamp (dot (tmpvar_4, lightDir_48), 0.0, 1.0);
  highp vec3 tmpvar_52;
  tmpvar_52 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_51 * atten_49) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_53;
  tmpvar_53 = (tmpvar_3 * tmpvar_52);
  c_50.xyz = tmpvar_53;
  c_50.w = tmpvar_5;
  c_1 = c_50;
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
#line 464
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
#line 474
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
    highp float diff = (distance( origin, vertexPos) - distance( origin, _WorldSpaceCameraPos));
    o.viewDist.x = xll_saturate_f((_DetailDist * distance( vertexPos, _WorldSpaceCameraPos)));
    o.viewDist.y = (xll_saturate_f(diff) * xll_saturate_f((xll_saturate_f((0.085 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow)))));
    o.localPos = normalize(v.vertex.xyz);
}
#line 474
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 478
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 482
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 486
    o.lightDir = lightDir;
    o.vlight = glstate_lightmodel_ambient.xyz;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 490
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
#line 464
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
#line 474
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
    mediump vec4 main = (texture( _MainTex, uv) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    #line 447
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    #line 451
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    #line 455
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = IN.viewDist.x;
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    #line 459
    o.Albedo = (albedo * vec3( _Color));
    mediump float avg = (mix( detail.w, 1.0, detailLevel) * main.w);
    o.Alpha = (avg * IN.viewDist.y);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 492
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 494
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 498
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 502
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 506
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
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - sqrt(dot (p_9, p_9))), 0.0, 1.0) * clamp ((clamp ((0.085 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
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
    highp float s_19;
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
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2D (_MainTex, uv_16) * _Color);
  main_15 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_14 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_13 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_12 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_29 = texture2D (_BumpMap, P_30);
  normalX_11 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_31 = texture2D (_BumpMap, P_32);
  normalY_10 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_33 = texture2D (_BumpMap, P_34);
  normalZ_9 = tmpvar_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_36;
  tmpvar_36 = mix (detailZ_12, detailX_14, tmpvar_35.xxxx);
  detail_8 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = mix (detail_8, detailY_13, tmpvar_35.yyyy);
  detail_8 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = mix (normalZ_9, normalX_11, tmpvar_35.xxxx);
  normal_7 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (normal_7, normalY_10, tmpvar_35.yyyy);
  normal_7 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41 = ((main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6))) * _Color.xyz);
  tmpvar_3 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_43;
  tmpvar_43 = (tmpvar_42 * xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_43;
  lowp vec3 tmpvar_44;
  lowp vec4 packednormal_45;
  packednormal_45 = normal_7;
  tmpvar_44 = ((packednormal_45.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_46;
  tmpvar_46 = mix (tmpvar_44, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_46;
  tmpvar_2 = tmpvar_4;
  lowp float shadow_47;
  lowp float tmpvar_48;
  tmpvar_48 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_49;
  tmpvar_49 = (_LightShadowData.x + (tmpvar_48 * (1.0 - _LightShadowData.x)));
  shadow_47 = tmpvar_49;
  mediump vec3 lightDir_50;
  lightDir_50 = xlv_TEXCOORD2;
  mediump float atten_51;
  atten_51 = shadow_47;
  mediump vec4 c_52;
  mediump float tmpvar_53;
  tmpvar_53 = clamp (dot (tmpvar_4, lightDir_50), 0.0, 1.0);
  highp vec3 tmpvar_54;
  tmpvar_54 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_53 * atten_51) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_55;
  tmpvar_55 = (tmpvar_3 * tmpvar_54);
  c_52.xyz = tmpvar_55;
  c_52.w = tmpvar_5;
  c_1 = c_52;
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
#line 464
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
#line 474
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
    highp float diff = (distance( origin, vertexPos) - distance( origin, _WorldSpaceCameraPos));
    o.viewDist.x = xll_saturate_f((_DetailDist * distance( vertexPos, _WorldSpaceCameraPos)));
    o.viewDist.y = (xll_saturate_f(diff) * xll_saturate_f((xll_saturate_f((0.085 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow)))));
    o.localPos = normalize(v.vertex.xyz);
}
#line 474
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 478
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 482
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 486
    o.lightDir = lightDir;
    o.vlight = glstate_lightmodel_ambient.xyz;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 490
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
#line 464
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
#line 474
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
    mediump vec4 main = (texture( _MainTex, uv) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    #line 447
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    #line 451
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    #line 455
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = IN.viewDist.x;
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    #line 459
    o.Albedo = (albedo * vec3( _Color));
    mediump float avg = (mix( detail.w, 1.0, detailLevel) * main.w);
    o.Alpha = (avg * IN.viewDist.y);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 492
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 494
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 498
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 502
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 506
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
  tmpvar_5.y = (clamp ((sqrt(dot (p_8, p_8)) - sqrt(dot (p_9, p_9))), 0.0, 1.0) * clamp ((clamp ((0.085 * sqrt(dot (p_11, p_11))), 0.0, 1.0) + clamp (pow (((0.8 * _FalloffScale) * dot (normalize((_Object2World * tmpvar_2.xyzz).xyz), -(normalize((tmpvar_6 - _WorldSpaceCameraPos))))), _FalloffPow), 0.0, 1.0)), 0.0, 1.0));
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
    highp float s_19;
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
  lowp vec4 tmpvar_22;
  tmpvar_22 = (texture2D (_MainTex, uv_16) * _Color);
  main_15 = tmpvar_22;
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_23 = texture2D (_DetailTex, P_24);
  detailX_14 = tmpvar_23;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_25 = texture2D (_DetailTex, P_26);
  detailY_13 = tmpvar_25;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_27 = texture2D (_DetailTex, P_28);
  detailZ_12 = tmpvar_27;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = ((xlv_TEXCOORD1.zy * _BumpScale) + _BumpOffset.xy);
  tmpvar_29 = texture2D (_BumpMap, P_30);
  normalX_11 = tmpvar_29;
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = ((xlv_TEXCOORD1.zx * _BumpScale) + _BumpOffset.xy);
  tmpvar_31 = texture2D (_BumpMap, P_32);
  normalY_10 = tmpvar_31;
  lowp vec4 tmpvar_33;
  highp vec2 P_34;
  P_34 = ((xlv_TEXCOORD1.xy * _BumpScale) + _BumpOffset.xy);
  tmpvar_33 = texture2D (_BumpMap, P_34);
  normalZ_9 = tmpvar_33;
  highp vec3 tmpvar_35;
  tmpvar_35 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_36;
  tmpvar_36 = mix (detailZ_12, detailX_14, tmpvar_35.xxxx);
  detail_8 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = mix (detail_8, detailY_13, tmpvar_35.yyyy);
  detail_8 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = mix (normalZ_9, normalX_11, tmpvar_35.xxxx);
  normal_7 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = mix (normal_7, normalY_10, tmpvar_35.yyyy);
  normal_7 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = xlv_TEXCOORD0.x;
  detailLevel_6 = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41 = ((main_15.xyz * mix (detail_8.xyz, vec3(1.0, 1.0, 1.0), vec3(detailLevel_6))) * _Color.xyz);
  tmpvar_3 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = (mix (detail_8.w, 1.0, detailLevel_6) * main_15.w);
  highp float tmpvar_43;
  tmpvar_43 = (tmpvar_42 * xlv_TEXCOORD0.y);
  tmpvar_5 = tmpvar_43;
  lowp vec3 tmpvar_44;
  lowp vec4 packednormal_45;
  packednormal_45 = normal_7;
  tmpvar_44 = ((packednormal_45.xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_46;
  tmpvar_46 = mix (tmpvar_44, vec3(0.0, 0.0, 1.0), vec3(detailLevel_6));
  tmpvar_4 = tmpvar_46;
  tmpvar_2 = tmpvar_4;
  lowp float shadow_47;
  lowp float tmpvar_48;
  tmpvar_48 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_49;
  tmpvar_49 = (_LightShadowData.x + (tmpvar_48 * (1.0 - _LightShadowData.x)));
  shadow_47 = tmpvar_49;
  mediump vec3 lightDir_50;
  lightDir_50 = xlv_TEXCOORD2;
  mediump float atten_51;
  atten_51 = shadow_47;
  mediump vec4 c_52;
  mediump float tmpvar_53;
  tmpvar_53 = clamp (dot (tmpvar_4, lightDir_50), 0.0, 1.0);
  highp vec3 tmpvar_54;
  tmpvar_54 = clamp ((_MinLight + (_LightColor0.xyz * ((tmpvar_53 * atten_51) * 2.0))), 0.0, 1.0);
  lowp vec3 tmpvar_55;
  tmpvar_55 = (tmpvar_3 * tmpvar_54);
  c_52.xyz = tmpvar_55;
  c_52.w = tmpvar_5;
  c_1 = c_52;
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
#line 464
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
#line 474
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
    highp float diff = (distance( origin, vertexPos) - distance( origin, _WorldSpaceCameraPos));
    o.viewDist.x = xll_saturate_f((_DetailDist * distance( vertexPos, _WorldSpaceCameraPos)));
    o.viewDist.y = (xll_saturate_f(diff) * xll_saturate_f((xll_saturate_f((0.085 * distance( vertexPos, _WorldSpaceCameraPos))) + xll_saturate_f(pow( ((0.8 * _FalloffScale) * dot( normalDir, (-viewVect))), _FalloffPow)))));
    o.localPos = normalize(v.vertex.xyz);
}
#line 474
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 478
    vert( v, customInputData);
    o.cust_viewDist = customInputData.viewDist;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 482
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 486
    o.lightDir = lightDir;
    o.vlight = glstate_lightmodel_ambient.xyz;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 490
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
#line 464
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
#line 474
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
    mediump vec4 main = (texture( _MainTex, uv) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    #line 447
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 normalX = texture( _BumpMap, ((pos.zy * _BumpScale) + _BumpOffset.xy));
    mediump vec4 normalY = texture( _BumpMap, ((pos.zx * _BumpScale) + _BumpOffset.xy));
    #line 451
    mediump vec4 normalZ = texture( _BumpMap, ((pos.xy * _BumpScale) + _BumpOffset.xy));
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    #line 455
    mediump vec4 normal = mix( normalZ, normalX, vec4( pos.x));
    normal = mix( normal, normalY, vec4( pos.y));
    mediump float detailLevel = IN.viewDist.x;
    mediump vec3 albedo = (main.xyz * mix( detail.xyz, vec3( 1.0), vec3( detailLevel)));
    #line 459
    o.Albedo = (albedo * vec3( _Color));
    mediump float avg = (mix( detail.w, 1.0, detailLevel) * main.w);
    o.Alpha = (avg * IN.viewDist.y);
    o.Normal = mix( UnpackNormal( normal), vec3( 0.0, 0.0, 1.0), vec3( detailLevel));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 492
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 494
    Input surfIN;
    surfIN.viewDist = IN.cust_viewDist;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 498
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 502
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 506
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
//   opengl - ALU: 83 to 85, TEX: 7 to 8
//   d3d9 - ALU: 76 to 77, TEX: 7 to 8
//   d3d11 - ALU: 64 to 65, TEX: 7 to 8, FLOW: 1 to 1
SubProgram "opengl " {
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
"3.0-!!ARBfp1.0
# 83 ALU, 7 TEX
PARAM c[12] = { program.local[0..6],
		{ 0, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 1, 2 },
		{ 0.31830987, -0.01348047, 0.05747731, 0.1212391 },
		{ 0.1956359, 0.33299461, 0.99999559, 1.570796 },
		{ 0.15915494, 0.5, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R2.xy, fragment.texcoord[1].zxzw, c[4].x;
ADD R2.zw, R2.xyxy, c[2].xyxy;
MUL R0.xy, fragment.texcoord[1].zyzw, c[4].x;
ADD R0.xy, R0, c[2];
MUL R0.zw, fragment.texcoord[1].xyxy, c[4].x;
ABS R2.xy, fragment.texcoord[1];
TEX R1, R0, texture[1], 2D;
ADD R0.zw, R0, c[2].xyxy;
TEX R0, R0.zwzw, texture[1], 2D;
ADD R1, R1, -R0;
MAD R0, R2.x, R1, R0;
TEX R1, R2.zwzw, texture[1], 2D;
ADD R1, R1, -R0;
MAD R0, R2.y, R1, R0;
ADD R1.xyz, -R0, c[8].z;
MAD R0.xyz, fragment.texcoord[0].x, R1, R0;
MUL R1.zw, fragment.texcoord[1].xyxy, c[5].x;
ADD R1.zw, R1, c[3].xyxy;
MUL R1.xy, fragment.texcoord[1].zyzw, c[5].x;
TEX R3.yw, R1.zwzw, texture[2], 2D;
ADD R1.xy, R1, c[3];
TEX R1.yw, R1, texture[2], 2D;
ADD R1.xy, R1.ywzw, -R3.ywzw;
MUL R2.zw, fragment.texcoord[1].xyzx, c[5].x;
MAD R1.xy, R2.x, R1, R3.ywzw;
ADD R1.zw, R2, c[3].xyxy;
TEX R3.yw, R1.zwzw, texture[2], 2D;
ABS R1.w, fragment.texcoord[1].z;
ADD R2.zw, R3.xyyw, -R1.xyxy;
MAD R1.xy, R2.y, R2.zwzw, R1;
MAD R1.xy, R1.yxzw, c[8].w, -c[8].z;
MUL R2.zw, R1.xyxy, R1.xyxy;
MAX R1.z, R1.w, R2.x;
ADD_SAT R2.z, R2, R2.w;
RCP R2.y, R1.z;
MIN R1.z, R1.w, R2.x;
MUL R2.y, R1.z, R2;
MUL R3.x, R2.y, R2.y;
MAD R1.z, R3.x, c[9].y, c[9];
MAD R1.z, R1, R3.x, -c[9].w;
ADD R2.z, -R2, c[8];
MAD R1.z, R1, R3.x, c[10].x;
RSQ R2.w, R2.z;
MAD R2.z, R1, R3.x, -c[10].y;
MAD R2.z, R2, R3.x, c[10];
RCP R1.z, R2.w;
ADD R3.xyz, -R1, c[11].zzww;
MAD R3.xyz, fragment.texcoord[0].x, R3, R1;
MUL R2.y, R2.z, R2;
ABS R1.z, -fragment.texcoord[1].y;
ADD R1.x, R1.w, -R2;
ADD R1.y, -R2, c[10].w;
CMP R1.x, -R1, R1.y, R2.y;
ADD R1.y, -R1.x, c[7];
ADD R2.x, -R1.z, c[8].z;
MAD R1.w, R1.z, c[7].z, c[7];
MAD R1.w, R1, R1.z, -c[8].x;
RSQ R2.x, R2.x;
CMP R1.y, fragment.texcoord[1].x, R1, R1.x;
MAD R1.z, R1.w, R1, c[8].y;
RCP R2.x, R2.x;
MUL R1.w, R1.z, R2.x;
SLT R1.z, -fragment.texcoord[1].y, c[7].x;
MUL R2.x, R1.z, R1.w;
MAD R1.x, -R2, c[8].w, R1.w;
CMP R1.w, fragment.texcoord[1].z, -R1.y, R1.y;
MAD R1.y, R1.z, c[7], R1.x;
DP3_SAT R2.x, R3, fragment.texcoord[2];
MAD R1.x, R1.w, c[11], c[11].y;
MUL R1.y, R1, c[9].x;
TEX R1, R1, texture[0], 2D;
MUL R1, R1, c[1];
MUL R1.xyz, R1, R0;
MUL R0.xyz, R2.x, c[0];
MUL R0.xyz, R0, c[8].w;
ADD R2.x, -R0.w, c[8].z;
MAD R0.w, fragment.texcoord[0].x, R2.x, R0;
MUL R0.w, R1, R0;
MUL R1.xyz, R1, c[1];
ADD_SAT R0.xyz, R0, c[6].x;
MUL R0.xyz, R1, R0;
MAD result.color.xyz, R1, fragment.texcoord[3], R0;
MUL result.color.w, fragment.texcoord[0].y, R0;
END
# 83 instructions, 4 R-regs
"
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
; 76 ALU, 7 TEX
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
mul r0.zw, v1.xyzy, c4.x
add r1.xy, r0.zwzw, c2
mul r0.xy, v1, c4.x
add r0.xy, r0, c2
mul r3.xy, v1.zxzw, c4.x
texld r1, r1, s1
texld r0, r0, s1
add_pp r2, r1, -r0
abs r1.xy, v1
mad_pp r0, r1.x, r2, r0
add r3.xy, r3, c2
texld r2, r3, s1
add_pp r2, r2, -r0
mad_pp r0, r1.y, r2, r0
add_pp r2.xyz, -r0, c7.y
mad_pp r0.xyz, v0.x, r2, r0
mul r2.zw, v1.xyzy, c5.x
add r3.xy, r2.zwzw, c3
mul r2.xy, v1, c5.x
add r2.xy, r2, c3
texld r2.yw, r2, s2
texld r3.yw, r3, s2
add_pp r3.zw, r3.xyyw, -r2.xyyw
mul r1.zw, v1.xyzx, c5.x
add r3.xy, r1.zwzw, c3
mad_pp r2.xy, r1.x, r3.zwzw, r2.ywzw
abs r1.z, v1
texld r3.yw, r3, s2
add_pp r2.zw, r3.xyyw, -r2.xyxy
mad_pp r2.xy, r1.y, r2.zwzw, r2
max r1.w, r1.z, r1.x
mad_pp r2.xy, r2.yxzw, c11.z, c11.w
mul_pp r2.zw, r2.xyxy, r2.xyxy
add_pp_sat r2.z, r2, r2.w
rcp r1.y, r1.w
min r1.w, r1.z, r1.x
mul r1.y, r1.w, r1
mul r1.w, r1.y, r1.y
mad r3.x, r1.w, c9.y, c9.z
mad r2.w, r3.x, r1, c9
mad r2.w, r2, r1, c10.x
mad r2.w, r2, r1, c10.y
mad r1.w, r2, r1, c10.z
mul r1.y, r1.w, r1
add_pp r2.z, -r2, c7.y
rsq_pp r2.z, r2.z
rcp_pp r2.z, r2.z
add_pp r3.xyz, -r2, c7.xxyw
mad_pp r2.xyz, v0.x, r3, r2
abs r2.w, -v1.y
add r1.x, r1.z, -r1
add r1.w, -r1.y, c10
cmp r1.x, -r1, r1.y, r1.w
add r1.y, -r1.x, c8.w
cmp r1.x, v1, r1, r1.y
add r1.z, -r2.w, c7.y
mad r1.w, r2, c7.z, c7
mad r1.w, r1, r2, c8.x
mad r1.w, r1, r2, c8.y
rsq r1.z, r1.z
rcp r1.z, r1.z
cmp r1.x, v1.z, r1, -r1
mul r1.w, r1, r1.z
cmp r2.w, -v1.y, c7.x, c7.y
mul r1.z, r2.w, r1.w
mad r1.y, -r1.z, c8.z, r1.w
mad r1.y, r2.w, c8.w, r1
dp3_pp_sat r2.x, r2, v2
mad r1.x, r1, c11, c11.y
mul r1.y, r1, c9.x
texld r1, r1, s0
mul r1, r1, c1
mul_pp r0.xyz, r1, r0
mul_pp r1.xyz, r2.x, c0
mul_pp r1.xyz, r1, c8.z
add_pp r2.x, -r0.w, c7.y
mad_pp r0.w, v0.x, r2.x, r0
mul_pp r0.w, r1, r0
mul_pp r0.xyz, r0, c1
add_sat r1.xyz, r1, c6.x
mul r1.xyz, r0, r1
mad_pp oC0.xyz, r0, v3, r1
mul oC0.w, v0.y, r0
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
// 73 instructions, 5 temp regs, 0 temp arrays:
// ALU 60 float, 0 int, 4 uint
// TEX 7 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedcckfpcidnmmnnefebmmmhffpppfpfklpabaaaaaagialaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcgaakaaaaeaaaaaaajiacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaadcaaaaalpcaabaaa
aaaaaaaaggbcbaaaacaaaaaaagiacaaaaaaaaaaaahaaaaaaegiecaaaaaaaaaaa
afaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaogakbaaaaaaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadcaaaaalfcaabaaaaaaaaaaaagbbbaaaacaaaaaa
agiacaaaaaaaaaaaahaaaaaaagibcaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaa
acaaaaaaigaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaai
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
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaal
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaagaabaaaaaaaaaaafgifcaaa
aaaaaaaaahaaaaaadeaaaaajicaabaaaaaaaaaaaakbabaiaibaaaaaaacaaaaaa
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
abaaaaaadbaaaaaibcaabaaaabaaaaaaakbabaaaacaaaaaaakbabaiaebaaaaaa
acaaaaaaabaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejma
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaddaaaaah
bcaabaaaabaaaaaaakbabaaaacaaaaaackbabaaaacaaaaaadbaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaadeaaaaahccaabaaa
abaaaaaaakbabaaaacaaaaaackbabaaaacaaaaaabnaaaaaiccaabaaaabaaaaaa
bkaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadhaaaaakicaabaaaaaaaaaaaakaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaak
icaabaaaaaaaaaaabkbabaiaibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaa
chbgjidndcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaa
acaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkbabaiaibaaaaaaacaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaabaaaaaa
bkbabaiambaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaama
abeaaaaanlapejeadbaaaaaibcaabaaaacaaaaaabkbabaiaebaaaaaaacaaaaaa
bkbabaaaacaaaaaaabaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
acaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
idpjkcdoefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaa
aaaaaaaaadaaaaaadcaaaaalpcaabaaaacaaaaaaggbcbaaaacaaaaaakgikcaaa
aaaaaaaaagaaaaaaegiecaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaa
egaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
dcaabaaaaeaaaaaaegbabaaaacaaaaaakgikcaaaaaaaaaaaagaaaaaaegiacaaa
aaaaaaaaaeaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaadaaaaaaegaobaaaadaaaaaa
egaobaiaebaaaaaaaeaaaaaadcaaaaakpcaabaaaadaaaaaaagbabaiaibaaaaaa
acaaaaaaegaobaaaadaaaaaaegaobaaaaeaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaa
fgbfbaiaibaaaaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaal
pcaabaaaadaaaaaaegaobaiaebaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdcaaaaajpcaabaaaacaaaaaaagbabaaaabaaaaaaegaobaaa
adaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaadaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaabaaaaaabkbabaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegbcbaaaaeaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaadoaaaaab"
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
"3.0-!!ARBfp1.0
# 85 ALU, 8 TEX
PARAM c[12] = { program.local[0..6],
		{ 0, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 1, 2 },
		{ 0.31830987, -0.01348047, 0.05747731, 0.1212391 },
		{ 0.1956359, 0.33299461, 0.99999559, 1.570796 },
		{ 0.15915494, 0.5, 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R2.xy, fragment.texcoord[1].zxzw, c[4].x;
ADD R2.zw, R2.xyxy, c[2].xyxy;
MUL R0.xy, fragment.texcoord[1].zyzw, c[4].x;
ADD R0.xy, R0, c[2];
MUL R0.zw, fragment.texcoord[1].xyxy, c[4].x;
ABS R2.xy, fragment.texcoord[1];
TEX R1, R0, texture[1], 2D;
ADD R0.zw, R0, c[2].xyxy;
TEX R0, R0.zwzw, texture[1], 2D;
ADD R1, R1, -R0;
MAD R0, R2.x, R1, R0;
TEX R1, R2.zwzw, texture[1], 2D;
ADD R1, R1, -R0;
MAD R0, R2.y, R1, R0;
ADD R1.xyz, -R0, c[8].z;
MAD R0.xyz, fragment.texcoord[0].x, R1, R0;
MUL R1.zw, fragment.texcoord[1].xyxy, c[5].x;
ADD R1.zw, R1, c[3].xyxy;
MUL R1.xy, fragment.texcoord[1].zyzw, c[5].x;
TEX R3.yw, R1.zwzw, texture[2], 2D;
ADD R1.xy, R1, c[3];
TEX R1.yw, R1, texture[2], 2D;
ADD R1.xy, R1.ywzw, -R3.ywzw;
MUL R2.zw, fragment.texcoord[1].xyzx, c[5].x;
ADD R1.zw, R2, c[3].xyxy;
MAD R1.xy, R2.x, R1, R3.ywzw;
TEX R3.yw, R1.zwzw, texture[2], 2D;
ADD R1.zw, R3.xyyw, -R1.xyxy;
MAD R1.xy, R2.y, R1.zwzw, R1;
ABS R2.z, fragment.texcoord[1];
MAX R1.z, R2, R2.x;
RCP R1.w, R1.z;
MIN R1.z, R2, R2.x;
MUL R2.y, R1.z, R1.w;
MAD R1.xy, R1.yxzw, c[8].w, -c[8].z;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R1.w, R1.z, R1;
MUL R2.w, R2.y, R2.y;
ADD R1.w, -R1, c[8].z;
MAD R1.z, R2.w, c[9].y, c[9];
RSQ R3.x, R1.w;
MAD R1.z, R1, R2.w, -c[9].w;
MAD R1.w, R1.z, R2, c[10].x;
RCP R1.z, R3.x;
MAD R1.w, R1, R2, -c[10].y;
ADD R3.xyz, -R1, c[11].zzww;
MAD R1.w, R1, R2, c[10].z;
MAD R1.xyz, fragment.texcoord[0].x, R3, R1;
MUL R1.w, R1, R2.y;
DP3_SAT R2.y, R1, fragment.texcoord[2];
ABS R1.z, -fragment.texcoord[1].y;
ADD R1.x, R2.z, -R2;
ADD R1.y, -R1.w, c[10].w;
CMP R1.x, -R1, R1.y, R1.w;
ADD R1.y, -R1.x, c[7];
ADD R2.x, -R1.z, c[8].z;
MAD R1.w, R1.z, c[7].z, c[7];
MAD R1.w, R1, R1.z, -c[8].x;
RSQ R2.x, R2.x;
CMP R1.y, fragment.texcoord[1].x, R1, R1.x;
MAD R1.z, R1.w, R1, c[8].y;
RCP R2.x, R2.x;
MUL R1.w, R1.z, R2.x;
SLT R1.z, -fragment.texcoord[1].y, c[7].x;
MUL R2.x, R1.z, R1.w;
MAD R1.x, -R2, c[8].w, R1.w;
CMP R1.w, fragment.texcoord[1].z, -R1.y, R1.y;
MAD R1.y, R1.z, c[7], R1.x;
TXP R2.x, fragment.texcoord[4], texture[3], 2D;
MUL R2.x, R2.y, R2;
MAD R1.x, R1.w, c[11], c[11].y;
MUL R1.y, R1, c[9].x;
TEX R1, R1, texture[0], 2D;
MUL R1, R1, c[1];
MUL R1.xyz, R1, R0;
MUL R0.xyz, R2.x, c[0];
MUL R0.xyz, R0, c[8].w;
ADD R2.x, -R0.w, c[8].z;
MAD R0.w, fragment.texcoord[0].x, R2.x, R0;
MUL R0.w, R1, R0;
MUL R1.xyz, R1, c[1];
ADD_SAT R0.xyz, R0, c[6].x;
MUL R0.xyz, R1, R0;
MAD result.color.xyz, R1, fragment.texcoord[3], R0;
MUL result.color.w, fragment.texcoord[0].y, R0;
END
# 85 instructions, 4 R-regs
"
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
; 77 ALU, 8 TEX
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
mul r0.zw, v1.xyzy, c4.x
add r1.xy, r0.zwzw, c2
mul r0.xy, v1, c4.x
add r0.xy, r0, c2
mul r3.xy, v1.zxzw, c4.x
texld r1, r1, s1
texld r0, r0, s1
add_pp r2, r1, -r0
abs r1.xy, v1
mad_pp r0, r1.x, r2, r0
add r3.xy, r3, c2
texld r2, r3, s1
add_pp r2, r2, -r0
mad_pp r0, r1.y, r2, r0
add_pp r2.xyz, -r0, c7.y
mad_pp r0.xyz, v0.x, r2, r0
mul r2.zw, v1.xyzy, c5.x
add r3.xy, r2.zwzw, c3
mul r2.xy, v1, c5.x
add r2.xy, r2, c3
texld r2.yw, r2, s2
texld r3.yw, r3, s2
add_pp r3.zw, r3.xyyw, -r2.xyyw
mul r1.zw, v1.xyzx, c5.x
add r3.xy, r1.zwzw, c3
mad_pp r2.xy, r1.x, r3.zwzw, r2.ywzw
abs r1.z, v1
texld r3.yw, r3, s2
add_pp r2.zw, r3.xyyw, -r2.xyxy
mad_pp r2.xy, r1.y, r2.zwzw, r2
max r1.y, r1.z, r1.x
min r1.w, r1.z, r1.x
mad_pp r2.xy, r2.yxzw, c11.z, c11.w
mul_pp r2.zw, r2.xyxy, r2.xyxy
add_pp_sat r2.z, r2, r2.w
rcp r1.y, r1.y
mul r1.y, r1.w, r1
mul r1.w, r1.y, r1.y
mad r2.w, r1, c9.y, c9.z
mad r2.w, r2, r1, c9
mad r2.w, r2, r1, c10.x
add_pp r2.z, -r2, c7.y
rsq_pp r2.z, r2.z
rcp_pp r2.z, r2.z
mad r2.w, r2, r1, c10.y
add_pp r3.xyz, -r2, c7.xxyw
mad_pp r2.xyz, v0.x, r3, r2
dp3_pp_sat r2.y, r2, v2
mad r1.w, r2, r1, c10.z
mul r1.w, r1, r1.y
abs r2.x, -v1.y
add r1.x, r1.z, -r1
add r1.y, -r1.w, c10.w
cmp r1.x, -r1, r1.w, r1.y
add r1.y, -r1.x, c8.w
cmp r1.x, v1, r1, r1.y
add r1.z, -r2.x, c7.y
mad r1.w, r2.x, c7.z, c7
mad r1.w, r1, r2.x, c8.x
mad r1.w, r1, r2.x, c8.y
rsq r1.z, r1.z
rcp r1.z, r1.z
cmp r1.x, v1.z, r1, -r1
mul r1.w, r1, r1.z
cmp r2.x, -v1.y, c7, c7.y
mul r1.z, r2.x, r1.w
mad r1.y, -r1.z, c8.z, r1.w
mad r1.y, r2.x, c8.w, r1
texldp r2.x, v4, s3
mul_pp r2.x, r2.y, r2
mad r1.x, r1, c11, c11.y
mul r1.y, r1, c9.x
texld r1, r1, s0
mul r1, r1, c1
mul_pp r0.xyz, r1, r0
mul_pp r1.xyz, r2.x, c0
mul_pp r1.xyz, r1, c8.z
add_pp r2.x, -r0.w, c7.y
mad_pp r0.w, v0.x, r2.x, r0
mul_pp r0.w, r1, r0
mul_pp r0.xyz, r0, c1
add_sat r1.xyz, r1, c6.x
mul r1.xyz, r0, r1
mad_pp oC0.xyz, r0, v3, r1
mul oC0.w, v0.y, r0
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
// 75 instructions, 5 temp regs, 0 temp arrays:
// ALU 61 float, 0 int, 4 uint
// TEX 8 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedgbglobemacibbiijcggbgejdflilalmeabaaaaaaoialaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmiakaaaa
eaaaaaaalcacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafkaaaaadaagabaaa
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
abaaaaaadbaaaaaibcaabaaaabaaaaaaakbabaaaacaaaaaaakbabaiaebaaaaaa
acaaaaaaabaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejma
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaddaaaaah
bcaabaaaabaaaaaaakbabaaaacaaaaaackbabaaaacaaaaaadbaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaadeaaaaahccaabaaa
abaaaaaaakbabaaaacaaaaaackbabaaaacaaaaaabnaaaaaiccaabaaaabaaaaaa
bkaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadhaaaaakicaabaaaaaaaaaaaakaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaak
icaabaaaaaaaaaaabkbabaiaibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaa
chbgjidndcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaabkbabaiaibaaaaaa
acaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkbabaiaibaaaaaaacaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaabaaaaaa
bkbabaiambaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaama
abeaaaaanlapejeadbaaaaaibcaabaaaacaaaaaabkbabaiaebaaaaaaacaaaaaa
bkbabaaaacaaaaaaabaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
acaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
idpjkcdoefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaa
aaaaaaaaahaaaaaadcaaaaalpcaabaaaacaaaaaaggbcbaaaacaaaaaakgikcaaa
aaaaaaaaakaaaaaaegiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaa
egaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaal
dcaabaaaaeaaaaaaegbabaaaacaaaaaakgikcaaaaaaaaaaaakaaaaaaegiacaaa
aaaaaaaaaiaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaadaaaaaaegaobaaaadaaaaaa
egaobaiaebaaaaaaaeaaaaaadcaaaaakpcaabaaaadaaaaaaagbabaiaibaaaaaa
acaaaaaaegaobaaaadaaaaaaegaobaaaaeaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaakpcaabaaaacaaaaaa
fgbfbaiaibaaaaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaaaaaaaal
pcaabaaaadaaaaaaegaobaiaebaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdcaaaaajpcaabaaaacaaaaaaagbabaaaabaaaaaaegaobaaa
adaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaabaaaaaabkbabaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegbcbaaaaeaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaadoaaaaab"
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

#LINE 100

	
	}
	
	 
	FallBack "Diffuse"
}
