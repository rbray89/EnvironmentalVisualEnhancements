Shader "CloudParticle" {
Properties {
	_TopTex ("Particle Texture", 2D) = "white" {}
	_LeftTex ("Particle Texture", 2D) = "white" {}
	_FrontTex ("Particle Texture", 2D) = "white" {}
	_InvFade ("Soft Particles Factor", Range(0.01,3.0)) = 1.0
	_DistFade ("Distance Fade", Range(0,1)) = 1.0
	_LightScatter ("Light Scatter", Range(0,1)) = 0.55 
	_MinLight ("Minimum Light", Range(0,1)) = .5
	_WorldNorm ("World Normal", Vector) = (0,1,0,1)
	_Color ("Color Tint", Color) = (1,1,1,1)
}

Category {
	
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Mode Global}
	AlphaTest Greater .01
	ColorMask RGB
	Cull Off Lighting On ZWrite Off
	
	SubShader {
		Pass {
			
			Lighting On
			Tags { "LightMode"="ForwardBase"}
			
			Program "vp" {
// Vertex combos: 15
//   opengl - ALU: 94 to 94
//   d3d9 - ALU: 86 to 86
//   d3d11 - ALU: 52 to 52, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_Object2World]
Float 14 [_DistFade]
"3.0-!!ARBvp1.0
# 94 ALU
PARAM c[16] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[3];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
DP4 R4.x, R2, c[1];
DP4 R4.y, R2, c[2];
MOV R1.w, vertex.position;
DP4 R4.w, R2, c[4];
DP4 R4.z, R2, c[3];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R4.zw, R0.xyxy, -c[0].z;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0].z;
ADD R3.w, R0.x, -R0.y;
SLT R0.z, c[0].x, -R3.x;
SLT R0.w, -R3.x, c[0].x;
ADD R0.w, R0.z, -R0;
MUL R0.z, R4, R0.w;
MUL R1.x, R0.w, R3.w;
SLT R0.y, R0.z, c[0].x;
SLT R0.x, c[0], R0.z;
ADD R0.x, R0, -R0.y;
MUL R0.y, R3, R1.x;
MUL R0.x, R0, R0.w;
MAD R0.x, R3.z, R0, R0.y;
MOV R0.yw, R1;
DP4 R1.x, R0, c[1];
DP4 R1.z, R0, c[2];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[15].x;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[0].w;
SLT R0.y, R1.x, c[0].x;
SLT R0.x, c[0], R1;
ADD R0.z, R0.x, -R0.y;
SLT R0.y, -R3.z, c[0].x;
SLT R0.x, c[0], -R3.z;
ADD R0.x, R0, -R0.y;
MUL R0.w, R3, R0.x;
MUL R0.z, R0.x, R0;
MUL R0.w, R3.y, R0;
MAD R1.z, R3.x, R0, R0.w;
SLT R0.x, c[0], -R3.y;
SLT R0.y, -R3, c[0].x;
ADD R0.y, R0.x, -R0;
MUL R0.x, R4.z, R0.y;
SLT R0.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R0.w;
MUL R0.w, R3, R0.y;
MUL R0.y, R0.z, R0;
MUL R3.w, R3.z, R0;
MOV R0.zw, R1.xyyw;
MAD R0.y, R3.x, R0, R3.w;
DP4 R4.z, R0, c[1];
DP4 R4.w, R0, c[2];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[15].x;
ADD result.texcoord[2].xy, R0, c[0].w;
DP4 R0.z, R1, c[1];
DP4 R0.w, R1, c[2];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[15].x;
ADD result.texcoord[3].xy, R0.zwzw, c[0].w;
DP4 R1.x, R2, c[9];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[13];
DP3 R0.x, R0, R0;
RSQ R0.x, R0.x;
RCP R0.w, R0.x;
DP4 R1.z, R2, c[11];
DP4 R1.y, R2, c[10];
ADD R0.xyz, -R1, c[13];
MUL R1.x, R0.w, c[14];
DP3 R0.w, R0, R0;
MIN R1.x, R1, c[0].z;
RSQ R0.w, R0.w;
MAX R1.x, R1, c[0];
MUL result.texcoord[4].xyz, R0.w, R0;
MUL result.color.w, vertex.color, R1.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 94 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"vs_3_0
; 86 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c14, 0.00000000, 2.00000000, -1.00000000, 0
def c15, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mov r2.w, v0
mov r2.xyz, c14.x
dp4 r4.x, r2, c0
dp4 r4.y, r2, c1
mov r1.w, v0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r0, r4, v0
mad r4.zw, v2.xyxy, c14.y, c14.z
mov r1.y, r4.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r4.w, -r4.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r4.w, r4.w
sub r3.w, r0.y, r0.z
mul r0.z, r4, r0.x
mul r1.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r1
dp4 r1.z, r0, c1
dp4 r1.x, r0, c0
add r0.xy, -r4, r1.xzzw
slt r0.z, r3, -r3
slt r0.w, -r3.z, r3.z
sub r4.w, r0, r0.z
mul r1.x, r4.z, r4.w
mad o3.xy, r0, c15.x, c15.y
slt r0.x, -r1, r1
slt r0.y, r1.x, -r1.x
sub r0.y, r0.x, r0
sub r0.x, r0.z, r0.w
mul r0.z, r0.x, r0.y
mul r0.w, r3, r0.x
mul r0.w, r3.y, r0
mad r1.z, r3.x, r0, r0.w
slt r0.x, r3.y, -r3.y
slt r0.y, -r3, r3
sub r0.y, r0.x, r0
mul r0.x, r4.z, r0.y
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r3, r0.y
mul r0.y, r0.z, r0
mul r3.w, r3.z, r0
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r4, r4.zwzw
mad o4.xy, r0, c15.x, c15.y
dp4 r0.z, r1, c0
dp4 r0.w, r1, c1
add r0.zw, -r4.xyxy, r0
mad o5.xy, r0.zwzw, c15.x, c15.y
dp4 r1.x, r2, c8
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c12
dp3 r0.w, r0, r0
add r0.xyz, -r1, c12
rsq r0.w, r0.w
dp3 r1.x, r0, r0
rcp r0.w, r0.w
rsq r1.x, r1.x
mul_sat r0.w, r0, c13.x
mul o6.xyz, r1.x, r0
mul o1.w, v1, r0
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176 // 152 used size, 11 vars
Float 148 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 63 instructions, 5 temp regs, 0 temp arrays:
// ALU 44 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedpmopgfjbelogjmflpakeaohjldclpaebabaaaaaagaakaaaaadaaaaaa
cmaaaaaajmaaaaaaiiabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
oeaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaankaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaankaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaankaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaankaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaankaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaankaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefcnaaiaaaaeaaaabaadeacaaaafjaaaaaeegiocaaa
aaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaabaaaaaaafjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacafaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaa
apaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahiccabaaaabaaaaaa
akaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaa
abaaaaaadgaaaaagbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaadgaaaaag
ccaabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaacaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaa
dbaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaai
aanaaaaahcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaaf
hcaabaaaadaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaa
aaaaaaaaegacbaaaadaaaaaaclaaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaa
diaaaaahkcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaak
mcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaa
aaaaaaaadbaaaaakdcaabaaaaeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaa
acaaaaaaagaebaaaaeaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaa
abaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaa
dcaaaaajdcaabaaaabaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaa
adaaaaaadiaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaacaaaaaa
afaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaaaeaaaaaapgapbaaa
aaaaaaaafganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaa
agaaaaaafgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaa
fganbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaa
acaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaa
acaaaaaaaeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaa
aaaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaa
dcaaaaapdccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaah
ccaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
acaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaa
dbaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaacaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaa
abaaaaaaboaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
aaaaaaaacgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.w = _glesVertex.w;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_modelview0 * tmpvar_6);
  vec4 v_8;
  v_8.x = glstate_matrix_modelview0[0].z;
  v_8.y = glstate_matrix_modelview0[1].z;
  v_8.z = glstate_matrix_modelview0[2].z;
  v_8.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_12;
  tmpvar_12.z = 0.0;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = tmpvar_11.y;
  tmpvar_12.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_12.zyw;
  XZv_2.yzw = tmpvar_12.zyw;
  XYv_1.yzw = tmpvar_12.yzw;
  ZYv_3.z = (tmpvar_11.x * sign(-(tmpvar_9.x)));
  XZv_2.x = (tmpvar_11.x * sign(-(tmpvar_9.y)));
  XYv_1.x = (tmpvar_11.x * sign(tmpvar_9.z));
  ZYv_3.x = ((sign(-(tmpvar_9.x)) * sign(ZYv_3.z)) * tmpvar_9.z);
  XZv_2.y = ((sign(-(tmpvar_9.y)) * sign(XZv_2.x)) * tmpvar_9.x);
  XYv_1.z = ((sign(-(tmpvar_9.z)) * sign(XYv_1.x)) * tmpvar_9.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_9.x)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_9.y)) * sign(tmpvar_11.y)) * tmpvar_9.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_9.z)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_13;
  p_13 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((_DistFade * sqrt(dot (p_13, p_13))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_14);
  gl_Position = (glstate_matrix_projection * (tmpvar_7 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_10).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp float atten_5;
  highp vec3 lightColor_6;
  mediump vec4 ztex_7;
  mediump float zval_8;
  mediump vec4 ytex_9;
  mediump float yval_10;
  mediump vec4 xtex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = xlv_TEXCOORD0.y;
  yval_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_9 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = xlv_TEXCOORD0.z;
  zval_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_7 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_11, ytex_9, vec4(yval_10)), ztex_7, vec4(zval_8)));
  lowp vec3 tmpvar_18;
  tmpvar_18 = _LightColor0.xyz;
  lightColor_6 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_LightTexture0, vec2(tmpvar_19)).w;
  atten_5 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (_WorldNorm, tmpvar_21), 0.0, 1.0);
  WNL_4 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp (((_MinLight + lightColor_6) * clamp ((_LightColor0.w * ((tmpvar_23 * atten_5) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_24;
  color_2.xyz = (tmpvar_17.xyz * baseLight_3);
  color_2.w = tmpvar_17.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.w = _glesVertex.w;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_modelview0 * tmpvar_6);
  vec4 v_8;
  v_8.x = glstate_matrix_modelview0[0].z;
  v_8.y = glstate_matrix_modelview0[1].z;
  v_8.z = glstate_matrix_modelview0[2].z;
  v_8.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_12;
  tmpvar_12.z = 0.0;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = tmpvar_11.y;
  tmpvar_12.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_12.zyw;
  XZv_2.yzw = tmpvar_12.zyw;
  XYv_1.yzw = tmpvar_12.yzw;
  ZYv_3.z = (tmpvar_11.x * sign(-(tmpvar_9.x)));
  XZv_2.x = (tmpvar_11.x * sign(-(tmpvar_9.y)));
  XYv_1.x = (tmpvar_11.x * sign(tmpvar_9.z));
  ZYv_3.x = ((sign(-(tmpvar_9.x)) * sign(ZYv_3.z)) * tmpvar_9.z);
  XZv_2.y = ((sign(-(tmpvar_9.y)) * sign(XZv_2.x)) * tmpvar_9.x);
  XYv_1.z = ((sign(-(tmpvar_9.z)) * sign(XYv_1.x)) * tmpvar_9.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_9.x)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_9.y)) * sign(tmpvar_11.y)) * tmpvar_9.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_9.z)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_13;
  p_13 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((_DistFade * sqrt(dot (p_13, p_13))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_14);
  gl_Position = (glstate_matrix_projection * (tmpvar_7 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_10).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp float atten_5;
  highp vec3 lightColor_6;
  mediump vec4 ztex_7;
  mediump float zval_8;
  mediump vec4 ytex_9;
  mediump float yval_10;
  mediump vec4 xtex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = xlv_TEXCOORD0.y;
  yval_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_9 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = xlv_TEXCOORD0.z;
  zval_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_7 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_11, ytex_9, vec4(yval_10)), ztex_7, vec4(zval_8)));
  lowp vec3 tmpvar_18;
  tmpvar_18 = _LightColor0.xyz;
  lightColor_6 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_LightTexture0, vec2(tmpvar_19)).w;
  atten_5 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (_WorldNorm, tmpvar_21), 0.0, 1.0);
  WNL_4 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp (((_MinLight + lightColor_6) * clamp ((_LightColor0.w * ((tmpvar_23 * atten_5) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_24;
  color_2.xyz = (tmpvar_17.xyz * baseLight_3);
  color_2.w = tmpvar_17.w;
  tmpvar_1 = color_2;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
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
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec3 _LightCoord;
};
#line 405
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 395
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 399
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 403
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 424
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 425
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 428
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 432
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 436
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 440
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 444
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 448
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 452
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    #line 456
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval._LightCoord);
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec3 _LightCoord;
};
#line 405
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 395
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 399
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 403
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 424
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 459
lowp vec4 frag( in v2f i ) {
    #line 461
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 465
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
    #line 469
    highp vec3 lightColor = _LightColor0.xyz;
    highp vec3 lightDir = vec3( _WorldSpaceLightPos0);
    highp float atten = (texture( _LightTexture0, vec2( dot( i._LightCoord, i._LightCoord))).w * 1.0);
    highp float NL = xll_saturate_f((0.5 * (1.0 + dot( i.projPos, lightDir))));
    #line 473
    highp float lightIntensity = xll_saturate_f((_LightColor0.w * ((NL * atten) * 4.0)));
    highp float lightScatter = xll_saturate_f((1.0 - ((lightIntensity * _LightScatter) * prev.w)));
    mediump float WNL = xll_saturate_f(dot( _WorldNorm, vec4( lightDir, 0.0)));
    mediump float diff = ((WNL - 0.01) / 0.99);
    #line 477
    lightIntensity = xll_saturate_f((_LightColor0.w * ((diff * atten) * 4.0)));
    mediump vec3 baseLight = xll_saturate_vf3(((_MinLight + lightColor) * lightIntensity));
    mediump vec4 color;
    color.xyz = (prev.xyz * baseLight);
    #line 481
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_i.projPos = vec3(xlv_TEXCOORD4);
    xlt_i._LightCoord = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_Object2World]
Float 14 [_DistFade]
"3.0-!!ARBvp1.0
# 94 ALU
PARAM c[16] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[3];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
DP4 R4.x, R2, c[1];
DP4 R4.y, R2, c[2];
MOV R1.w, vertex.position;
DP4 R4.w, R2, c[4];
DP4 R4.z, R2, c[3];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R4.zw, R0.xyxy, -c[0].z;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0].z;
ADD R3.w, R0.x, -R0.y;
SLT R0.z, c[0].x, -R3.x;
SLT R0.w, -R3.x, c[0].x;
ADD R0.w, R0.z, -R0;
MUL R0.z, R4, R0.w;
MUL R1.x, R0.w, R3.w;
SLT R0.y, R0.z, c[0].x;
SLT R0.x, c[0], R0.z;
ADD R0.x, R0, -R0.y;
MUL R0.y, R3, R1.x;
MUL R0.x, R0, R0.w;
MAD R0.x, R3.z, R0, R0.y;
MOV R0.yw, R1;
DP4 R1.x, R0, c[1];
DP4 R1.z, R0, c[2];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[15].x;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[0].w;
SLT R0.y, R1.x, c[0].x;
SLT R0.x, c[0], R1;
ADD R0.z, R0.x, -R0.y;
SLT R0.y, -R3.z, c[0].x;
SLT R0.x, c[0], -R3.z;
ADD R0.x, R0, -R0.y;
MUL R0.w, R3, R0.x;
MUL R0.z, R0.x, R0;
MUL R0.w, R3.y, R0;
MAD R1.z, R3.x, R0, R0.w;
SLT R0.x, c[0], -R3.y;
SLT R0.y, -R3, c[0].x;
ADD R0.y, R0.x, -R0;
MUL R0.x, R4.z, R0.y;
SLT R0.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R0.w;
MUL R0.w, R3, R0.y;
MUL R0.y, R0.z, R0;
MUL R3.w, R3.z, R0;
MOV R0.zw, R1.xyyw;
MAD R0.y, R3.x, R0, R3.w;
DP4 R4.z, R0, c[1];
DP4 R4.w, R0, c[2];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[15].x;
ADD result.texcoord[2].xy, R0, c[0].w;
DP4 R0.z, R1, c[1];
DP4 R0.w, R1, c[2];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[15].x;
ADD result.texcoord[3].xy, R0.zwzw, c[0].w;
DP4 R1.x, R2, c[9];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[13];
DP3 R0.x, R0, R0;
RSQ R0.x, R0.x;
RCP R0.w, R0.x;
DP4 R1.z, R2, c[11];
DP4 R1.y, R2, c[10];
ADD R0.xyz, -R1, c[13];
MUL R1.x, R0.w, c[14];
DP3 R0.w, R0, R0;
MIN R1.x, R1, c[0].z;
RSQ R0.w, R0.w;
MAX R1.x, R1, c[0];
MUL result.texcoord[4].xyz, R0.w, R0;
MUL result.color.w, vertex.color, R1.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 94 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"vs_3_0
; 86 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c14, 0.00000000, 2.00000000, -1.00000000, 0
def c15, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mov r2.w, v0
mov r2.xyz, c14.x
dp4 r4.x, r2, c0
dp4 r4.y, r2, c1
mov r1.w, v0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r0, r4, v0
mad r4.zw, v2.xyxy, c14.y, c14.z
mov r1.y, r4.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r4.w, -r4.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r4.w, r4.w
sub r3.w, r0.y, r0.z
mul r0.z, r4, r0.x
mul r1.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r1
dp4 r1.z, r0, c1
dp4 r1.x, r0, c0
add r0.xy, -r4, r1.xzzw
slt r0.z, r3, -r3
slt r0.w, -r3.z, r3.z
sub r4.w, r0, r0.z
mul r1.x, r4.z, r4.w
mad o3.xy, r0, c15.x, c15.y
slt r0.x, -r1, r1
slt r0.y, r1.x, -r1.x
sub r0.y, r0.x, r0
sub r0.x, r0.z, r0.w
mul r0.z, r0.x, r0.y
mul r0.w, r3, r0.x
mul r0.w, r3.y, r0
mad r1.z, r3.x, r0, r0.w
slt r0.x, r3.y, -r3.y
slt r0.y, -r3, r3
sub r0.y, r0.x, r0
mul r0.x, r4.z, r0.y
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r3, r0.y
mul r0.y, r0.z, r0
mul r3.w, r3.z, r0
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r4, r4.zwzw
mad o4.xy, r0, c15.x, c15.y
dp4 r0.z, r1, c0
dp4 r0.w, r1, c1
add r0.zw, -r4.xyxy, r0
mad o5.xy, r0.zwzw, c15.x, c15.y
dp4 r1.x, r2, c8
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c12
dp3 r0.w, r0, r0
add r0.xyz, -r1, c12
rsq r0.w, r0.w
dp3 r1.x, r0, r0
rcp r0.w, r0.w
rsq r1.x, r1.x
mul_sat r0.w, r0, c13.x
mul o6.xyz, r1.x, r0
mul o1.w, v1, r0
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 112 // 88 used size, 10 vars
Float 84 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 63 instructions, 5 temp regs, 0 temp arrays:
// ALU 44 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbilojappecnejieokmbleknobblckcbcabaaaaaaeiakaaaaadaaaaaa
cmaaaaaajmaaaaaahaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
mmaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaamcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaamcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaamcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaamcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaamcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcnaaiaaaaeaaaabaadeacaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaabaaaaaaafjaaaaaeegiocaaaadaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaa
adaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
afaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaahaaaaaapgbpbaaa
aaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
egiccaaaacaaaaaaapaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadicaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaafaaaaaadiaaaaah
iccabaaaabaaaaaaakaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaa
abaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaadgaaaaagccaabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadgaaaaag
ecaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaadbaaaaalhcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaa
acaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaa
bkaabaaaacaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaaabeaaaaa
aaaaaaaaboaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaa
abaaaaaacgaaaaaiaanaaaaahcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaaclaaaaafhcaabaaaadaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaa
adaaaaaajgafbaaaaaaaaaaaegacbaaaadaaaaaaclaaaaafkcaabaaaaaaaaaaa
agaebaaaabaaaaaadiaaaaahkcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaa
acaaaaaadbaaaaakmcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaafganbaaaaaaaaaaadbaaaaakdcaabaaaaeaaaaaangafbaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaacaaaaaa
kgaobaiaebaaaaaaacaaaaaaagaebaaaaeaaaaaacgaaaaaiaanaaaaadcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaabaaaaaa
egaabaaaabaaaaaadcaaaaajdcaabaaaabaaaaaaegaabaaaabaaaaaacgakbaaa
aaaaaaaaegaabaaaadaaaaaadiaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaa
agiecaaaacaaaaaaafaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaa
aeaaaaaapgapbaaaaaaaaaaafganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaa
agiecaaaacaaaaaaagaaaaaafgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaap
mccabaaaadaaaaaafganbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdp
jkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaa
abaaaaaafgafbaaaacaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaakgcaabaaa
acaaaaaaagibcaaaacaaaaaaaeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaa
dcaaaaakkcaabaaaaaaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaaaaaaaaaa
fgajbaaaacaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaa
jkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaai
ccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaacaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaa
bkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaacaaaaaaaeaaaaaafgafbaaa
aaaaaaaangafbaaaabaaaaaaboaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaadkaabaaaaaaaaaaacgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaabaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
adaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaacaaaaaaagaaaaaaagaabaaa
aaaaaaaaegaabaaaabaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.w = _glesVertex.w;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_modelview0 * tmpvar_5);
  vec4 v_7;
  v_7.x = glstate_matrix_modelview0[0].z;
  v_7.y = glstate_matrix_modelview0[1].z;
  v_7.z = glstate_matrix_modelview0[2].z;
  v_7.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(v_7.xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_9.w = _glesVertex.w;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11.z = 0.0;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = tmpvar_10.y;
  tmpvar_11.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_11.zyw;
  XZv_2.yzw = tmpvar_11.zyw;
  XYv_1.yzw = tmpvar_11.yzw;
  ZYv_3.z = (tmpvar_10.x * sign(-(tmpvar_8.x)));
  XZv_2.x = (tmpvar_10.x * sign(-(tmpvar_8.y)));
  XYv_1.x = (tmpvar_10.x * sign(tmpvar_8.z));
  ZYv_3.x = ((sign(-(tmpvar_8.x)) * sign(ZYv_3.z)) * tmpvar_8.z);
  XZv_2.y = ((sign(-(tmpvar_8.y)) * sign(XZv_2.x)) * tmpvar_8.x);
  XYv_1.z = ((sign(-(tmpvar_8.z)) * sign(XYv_1.x)) * tmpvar_8.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_8.x)) * sign(tmpvar_10.y)) * tmpvar_8.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_8.y)) * sign(tmpvar_10.y)) * tmpvar_8.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_8.z)) * sign(tmpvar_10.y)) * tmpvar_8.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_12;
  p_12 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((_DistFade * sqrt(dot (p_12, p_12))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_13);
  gl_Position = (glstate_matrix_projection * (tmpvar_6 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_8);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_6.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_6.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_6.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_9).xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightDir_5;
  highp vec3 lightColor_6;
  mediump vec4 ztex_7;
  mediump float zval_8;
  mediump vec4 ytex_9;
  mediump float yval_10;
  mediump vec4 xtex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = xlv_TEXCOORD0.y;
  yval_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_9 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = xlv_TEXCOORD0.z;
  zval_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_7 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_11, ytex_9, vec4(yval_10)), ztex_7, vec4(zval_8)));
  lowp vec3 tmpvar_18;
  tmpvar_18 = _LightColor0.xyz;
  lightColor_6 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = lightDir_5;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (_WorldNorm, tmpvar_20), 0.0, 1.0);
  WNL_4 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp (((_MinLight + lightColor_6) * clamp ((_LightColor0.w * (tmpvar_22 * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_23;
  color_2.xyz = (tmpvar_17.xyz * baseLight_3);
  color_2.w = tmpvar_17.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.w = _glesVertex.w;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_modelview0 * tmpvar_5);
  vec4 v_7;
  v_7.x = glstate_matrix_modelview0[0].z;
  v_7.y = glstate_matrix_modelview0[1].z;
  v_7.z = glstate_matrix_modelview0[2].z;
  v_7.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(v_7.xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_9.w = _glesVertex.w;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11.z = 0.0;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = tmpvar_10.y;
  tmpvar_11.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_11.zyw;
  XZv_2.yzw = tmpvar_11.zyw;
  XYv_1.yzw = tmpvar_11.yzw;
  ZYv_3.z = (tmpvar_10.x * sign(-(tmpvar_8.x)));
  XZv_2.x = (tmpvar_10.x * sign(-(tmpvar_8.y)));
  XYv_1.x = (tmpvar_10.x * sign(tmpvar_8.z));
  ZYv_3.x = ((sign(-(tmpvar_8.x)) * sign(ZYv_3.z)) * tmpvar_8.z);
  XZv_2.y = ((sign(-(tmpvar_8.y)) * sign(XZv_2.x)) * tmpvar_8.x);
  XYv_1.z = ((sign(-(tmpvar_8.z)) * sign(XYv_1.x)) * tmpvar_8.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_8.x)) * sign(tmpvar_10.y)) * tmpvar_8.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_8.y)) * sign(tmpvar_10.y)) * tmpvar_8.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_8.z)) * sign(tmpvar_10.y)) * tmpvar_8.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_12;
  p_12 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((_DistFade * sqrt(dot (p_12, p_12))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_13);
  gl_Position = (glstate_matrix_projection * (tmpvar_6 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_8);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_6.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_6.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_6.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_9).xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightDir_5;
  highp vec3 lightColor_6;
  mediump vec4 ztex_7;
  mediump float zval_8;
  mediump vec4 ytex_9;
  mediump float yval_10;
  mediump vec4 xtex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = xlv_TEXCOORD0.y;
  yval_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_9 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = xlv_TEXCOORD0.z;
  zval_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_7 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_11, ytex_9, vec4(yval_10)), ztex_7, vec4(zval_8)));
  lowp vec3 tmpvar_18;
  tmpvar_18 = _LightColor0.xyz;
  lightColor_6 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = lightDir_5;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (_WorldNorm, tmpvar_20), 0.0, 1.0);
  WNL_4 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp (((_MinLight + lightColor_6) * clamp ((_LightColor0.w * (tmpvar_22 * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_23;
  color_2.xyz = (tmpvar_17.xyz * baseLight_3);
  color_2.w = tmpvar_17.w;
  tmpvar_1 = color_2;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
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
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
};
#line 403
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 393
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 397
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 401
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 421
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 422
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 425
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 429
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 433
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 437
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 441
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 445
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 449
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    #line 453
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
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
#line 410
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
};
#line 403
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 393
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 397
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 401
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 421
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 456
lowp vec4 frag( in v2f i ) {
    #line 458
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 462
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
    #line 466
    highp vec3 lightColor = _LightColor0.xyz;
    highp vec3 lightDir = vec3( _WorldSpaceLightPos0);
    highp float atten = 1.0;
    highp float NL = xll_saturate_f((0.5 * (1.0 + dot( i.projPos, lightDir))));
    #line 470
    highp float lightIntensity = xll_saturate_f((_LightColor0.w * ((NL * atten) * 4.0)));
    highp float lightScatter = xll_saturate_f((1.0 - ((lightIntensity * _LightScatter) * prev.w)));
    mediump float WNL = xll_saturate_f(dot( _WorldNorm, vec4( lightDir, 0.0)));
    mediump float diff = ((WNL - 0.01) / 0.99);
    #line 474
    lightIntensity = xll_saturate_f((_LightColor0.w * ((diff * atten) * 4.0)));
    mediump vec3 baseLight = xll_saturate_vf3(((_MinLight + lightColor) * lightIntensity));
    mediump vec4 color;
    color.xyz = (prev.xyz * baseLight);
    #line 478
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_i.projPos = vec3(xlv_TEXCOORD4);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_Object2World]
Float 14 [_DistFade]
"3.0-!!ARBvp1.0
# 94 ALU
PARAM c[16] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[3];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
DP4 R4.x, R2, c[1];
DP4 R4.y, R2, c[2];
MOV R1.w, vertex.position;
DP4 R4.w, R2, c[4];
DP4 R4.z, R2, c[3];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R4.zw, R0.xyxy, -c[0].z;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0].z;
ADD R3.w, R0.x, -R0.y;
SLT R0.z, c[0].x, -R3.x;
SLT R0.w, -R3.x, c[0].x;
ADD R0.w, R0.z, -R0;
MUL R0.z, R4, R0.w;
MUL R1.x, R0.w, R3.w;
SLT R0.y, R0.z, c[0].x;
SLT R0.x, c[0], R0.z;
ADD R0.x, R0, -R0.y;
MUL R0.y, R3, R1.x;
MUL R0.x, R0, R0.w;
MAD R0.x, R3.z, R0, R0.y;
MOV R0.yw, R1;
DP4 R1.x, R0, c[1];
DP4 R1.z, R0, c[2];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[15].x;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[0].w;
SLT R0.y, R1.x, c[0].x;
SLT R0.x, c[0], R1;
ADD R0.z, R0.x, -R0.y;
SLT R0.y, -R3.z, c[0].x;
SLT R0.x, c[0], -R3.z;
ADD R0.x, R0, -R0.y;
MUL R0.w, R3, R0.x;
MUL R0.z, R0.x, R0;
MUL R0.w, R3.y, R0;
MAD R1.z, R3.x, R0, R0.w;
SLT R0.x, c[0], -R3.y;
SLT R0.y, -R3, c[0].x;
ADD R0.y, R0.x, -R0;
MUL R0.x, R4.z, R0.y;
SLT R0.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R0.w;
MUL R0.w, R3, R0.y;
MUL R0.y, R0.z, R0;
MUL R3.w, R3.z, R0;
MOV R0.zw, R1.xyyw;
MAD R0.y, R3.x, R0, R3.w;
DP4 R4.z, R0, c[1];
DP4 R4.w, R0, c[2];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[15].x;
ADD result.texcoord[2].xy, R0, c[0].w;
DP4 R0.z, R1, c[1];
DP4 R0.w, R1, c[2];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[15].x;
ADD result.texcoord[3].xy, R0.zwzw, c[0].w;
DP4 R1.x, R2, c[9];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[13];
DP3 R0.x, R0, R0;
RSQ R0.x, R0.x;
RCP R0.w, R0.x;
DP4 R1.z, R2, c[11];
DP4 R1.y, R2, c[10];
ADD R0.xyz, -R1, c[13];
MUL R1.x, R0.w, c[14];
DP3 R0.w, R0, R0;
MIN R1.x, R1, c[0].z;
RSQ R0.w, R0.w;
MAX R1.x, R1, c[0];
MUL result.texcoord[4].xyz, R0.w, R0;
MUL result.color.w, vertex.color, R1.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 94 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"vs_3_0
; 86 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c14, 0.00000000, 2.00000000, -1.00000000, 0
def c15, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mov r2.w, v0
mov r2.xyz, c14.x
dp4 r4.x, r2, c0
dp4 r4.y, r2, c1
mov r1.w, v0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r0, r4, v0
mad r4.zw, v2.xyxy, c14.y, c14.z
mov r1.y, r4.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r4.w, -r4.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r4.w, r4.w
sub r3.w, r0.y, r0.z
mul r0.z, r4, r0.x
mul r1.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r1
dp4 r1.z, r0, c1
dp4 r1.x, r0, c0
add r0.xy, -r4, r1.xzzw
slt r0.z, r3, -r3
slt r0.w, -r3.z, r3.z
sub r4.w, r0, r0.z
mul r1.x, r4.z, r4.w
mad o3.xy, r0, c15.x, c15.y
slt r0.x, -r1, r1
slt r0.y, r1.x, -r1.x
sub r0.y, r0.x, r0
sub r0.x, r0.z, r0.w
mul r0.z, r0.x, r0.y
mul r0.w, r3, r0.x
mul r0.w, r3.y, r0
mad r1.z, r3.x, r0, r0.w
slt r0.x, r3.y, -r3.y
slt r0.y, -r3, r3
sub r0.y, r0.x, r0
mul r0.x, r4.z, r0.y
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r3, r0.y
mul r0.y, r0.z, r0
mul r3.w, r3.z, r0
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r4, r4.zwzw
mad o4.xy, r0, c15.x, c15.y
dp4 r0.z, r1, c0
dp4 r0.w, r1, c1
add r0.zw, -r4.xyxy, r0
mad o5.xy, r0.zwzw, c15.x, c15.y
dp4 r1.x, r2, c8
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c12
dp3 r0.w, r0, r0
add r0.xyz, -r1, c12
rsq r0.w, r0.w
dp3 r1.x, r0, r0
rcp r0.w, r0.w
rsq r1.x, r1.x
mul_sat r0.w, r0, c13.x
mul o6.xyz, r1.x, r0
mul o1.w, v1, r0
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176 // 152 used size, 11 vars
Float 148 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 63 instructions, 5 temp regs, 0 temp arrays:
// ALU 44 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedjakpiplefackdbdcddlpiplgpeadclgpabaaaaaagaakaaaaadaaaaaa
cmaaaaaajmaaaaaaiiabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
oeaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaankaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaankaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaankaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaankaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaankaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaankaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefcnaaiaaaaeaaaabaadeacaaaafjaaaaaeegiocaaa
aaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaabaaaaaaafjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacafaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaa
apaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahiccabaaaabaaaaaa
akaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaa
abaaaaaadgaaaaagbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaadgaaaaag
ccaabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaacaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaa
dbaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaai
aanaaaaahcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaaf
hcaabaaaadaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaa
aaaaaaaaegacbaaaadaaaaaaclaaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaa
diaaaaahkcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaak
mcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaa
aaaaaaaadbaaaaakdcaabaaaaeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaa
acaaaaaaagaebaaaaeaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaa
abaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaa
dcaaaaajdcaabaaaabaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaa
adaaaaaadiaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaacaaaaaa
afaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaaaeaaaaaapgapbaaa
aaaaaaaafganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaa
agaaaaaafgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaa
fganbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaa
acaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaa
acaaaaaaaeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaa
aaaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaa
dcaaaaapdccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaah
ccaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
acaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaa
dbaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaacaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaa
abaaaaaaboaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
aaaaaaaacgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.w = _glesVertex.w;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_modelview0 * tmpvar_6);
  vec4 v_8;
  v_8.x = glstate_matrix_modelview0[0].z;
  v_8.y = glstate_matrix_modelview0[1].z;
  v_8.z = glstate_matrix_modelview0[2].z;
  v_8.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_12;
  tmpvar_12.z = 0.0;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = tmpvar_11.y;
  tmpvar_12.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_12.zyw;
  XZv_2.yzw = tmpvar_12.zyw;
  XYv_1.yzw = tmpvar_12.yzw;
  ZYv_3.z = (tmpvar_11.x * sign(-(tmpvar_9.x)));
  XZv_2.x = (tmpvar_11.x * sign(-(tmpvar_9.y)));
  XYv_1.x = (tmpvar_11.x * sign(tmpvar_9.z));
  ZYv_3.x = ((sign(-(tmpvar_9.x)) * sign(ZYv_3.z)) * tmpvar_9.z);
  XZv_2.y = ((sign(-(tmpvar_9.y)) * sign(XZv_2.x)) * tmpvar_9.x);
  XYv_1.z = ((sign(-(tmpvar_9.z)) * sign(XYv_1.x)) * tmpvar_9.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_9.x)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_9.y)) * sign(tmpvar_11.y)) * tmpvar_9.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_9.z)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_13;
  p_13 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((_DistFade * sqrt(dot (p_13, p_13))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_14);
  gl_Position = (glstate_matrix_projection * (tmpvar_7 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_10).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightColor_5;
  mediump vec4 ztex_6;
  mediump float zval_7;
  mediump vec4 ytex_8;
  mediump float yval_9;
  mediump vec4 xtex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.y;
  yval_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.z;
  zval_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_10, ytex_8, vec4(yval_9)), ztex_6, vec4(zval_7)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  lightColor_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) + 0.5);
  tmpvar_18 = texture2D (_LightTexture0, P_19);
  highp float tmpvar_20;
  tmpvar_20 = dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20));
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_23;
  tmpvar_23 = clamp (dot (_WorldNorm, tmpvar_22), 0.0, 1.0);
  WNL_4 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_25;
  tmpvar_25 = clamp (((_MinLight + lightColor_5) * clamp ((_LightColor0.w * ((tmpvar_24 * ((float((xlv_TEXCOORD5.z > 0.0)) * tmpvar_18.w) * tmpvar_21.w)) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_25;
  color_2.xyz = (tmpvar_16.xyz * baseLight_3);
  color_2.w = tmpvar_16.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.w = _glesVertex.w;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_modelview0 * tmpvar_6);
  vec4 v_8;
  v_8.x = glstate_matrix_modelview0[0].z;
  v_8.y = glstate_matrix_modelview0[1].z;
  v_8.z = glstate_matrix_modelview0[2].z;
  v_8.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_12;
  tmpvar_12.z = 0.0;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = tmpvar_11.y;
  tmpvar_12.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_12.zyw;
  XZv_2.yzw = tmpvar_12.zyw;
  XYv_1.yzw = tmpvar_12.yzw;
  ZYv_3.z = (tmpvar_11.x * sign(-(tmpvar_9.x)));
  XZv_2.x = (tmpvar_11.x * sign(-(tmpvar_9.y)));
  XYv_1.x = (tmpvar_11.x * sign(tmpvar_9.z));
  ZYv_3.x = ((sign(-(tmpvar_9.x)) * sign(ZYv_3.z)) * tmpvar_9.z);
  XZv_2.y = ((sign(-(tmpvar_9.y)) * sign(XZv_2.x)) * tmpvar_9.x);
  XYv_1.z = ((sign(-(tmpvar_9.z)) * sign(XYv_1.x)) * tmpvar_9.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_9.x)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_9.y)) * sign(tmpvar_11.y)) * tmpvar_9.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_9.z)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_13;
  p_13 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((_DistFade * sqrt(dot (p_13, p_13))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_14);
  gl_Position = (glstate_matrix_projection * (tmpvar_7 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_10).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightColor_5;
  mediump vec4 ztex_6;
  mediump float zval_7;
  mediump vec4 ytex_8;
  mediump float yval_9;
  mediump vec4 xtex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.y;
  yval_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.z;
  zval_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_10, ytex_8, vec4(yval_9)), ztex_6, vec4(zval_7)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  lightColor_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) + 0.5);
  tmpvar_18 = texture2D (_LightTexture0, P_19);
  highp float tmpvar_20;
  tmpvar_20 = dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20));
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_23;
  tmpvar_23 = clamp (dot (_WorldNorm, tmpvar_22), 0.0, 1.0);
  WNL_4 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_25;
  tmpvar_25 = clamp (((_MinLight + lightColor_5) * clamp ((_LightColor0.w * ((tmpvar_24 * ((float((xlv_TEXCOORD5.z > 0.0)) * tmpvar_18.w) * tmpvar_21.w)) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_25;
  color_2.xyz = (tmpvar_16.xyz * baseLight_3);
  color_2.w = tmpvar_16.w;
  tmpvar_1 = color_2;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
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
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec4 _LightCoord;
};
#line 414
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 404
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 408
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 412
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 433
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 434
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 437
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 441
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 445
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 449
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 453
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 457
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 461
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    #line 465
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec4(xl_retval._LightCoord);
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec4 _LightCoord;
};
#line 414
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 404
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 408
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 412
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 433
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 322
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    #line 324
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 318
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    #line 320
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 468
lowp vec4 frag( in v2f i ) {
    #line 470
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 474
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
    #line 478
    highp vec3 lightColor = _LightColor0.xyz;
    highp vec3 lightDir = vec3( _WorldSpaceLightPos0);
    highp float atten = (((float((i._LightCoord.z > 0.0)) * UnitySpotCookie( i._LightCoord)) * UnitySpotAttenuate( i._LightCoord.xyz)) * 1.0);
    highp float NL = xll_saturate_f((0.5 * (1.0 + dot( i.projPos, lightDir))));
    #line 482
    highp float lightIntensity = xll_saturate_f((_LightColor0.w * ((NL * atten) * 4.0)));
    highp float lightScatter = xll_saturate_f((1.0 - ((lightIntensity * _LightScatter) * prev.w)));
    mediump float WNL = xll_saturate_f(dot( _WorldNorm, vec4( lightDir, 0.0)));
    mediump float diff = ((WNL - 0.01) / 0.99);
    #line 486
    lightIntensity = xll_saturate_f((_LightColor0.w * ((diff * atten) * 4.0)));
    mediump vec3 baseLight = xll_saturate_vf3(((_MinLight + lightColor) * lightIntensity));
    mediump vec4 color;
    color.xyz = (prev.xyz * baseLight);
    #line 490
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_i.projPos = vec3(xlv_TEXCOORD4);
    xlt_i._LightCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_Object2World]
Float 14 [_DistFade]
"3.0-!!ARBvp1.0
# 94 ALU
PARAM c[16] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[3];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
DP4 R4.x, R2, c[1];
DP4 R4.y, R2, c[2];
MOV R1.w, vertex.position;
DP4 R4.w, R2, c[4];
DP4 R4.z, R2, c[3];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R4.zw, R0.xyxy, -c[0].z;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0].z;
ADD R3.w, R0.x, -R0.y;
SLT R0.z, c[0].x, -R3.x;
SLT R0.w, -R3.x, c[0].x;
ADD R0.w, R0.z, -R0;
MUL R0.z, R4, R0.w;
MUL R1.x, R0.w, R3.w;
SLT R0.y, R0.z, c[0].x;
SLT R0.x, c[0], R0.z;
ADD R0.x, R0, -R0.y;
MUL R0.y, R3, R1.x;
MUL R0.x, R0, R0.w;
MAD R0.x, R3.z, R0, R0.y;
MOV R0.yw, R1;
DP4 R1.x, R0, c[1];
DP4 R1.z, R0, c[2];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[15].x;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[0].w;
SLT R0.y, R1.x, c[0].x;
SLT R0.x, c[0], R1;
ADD R0.z, R0.x, -R0.y;
SLT R0.y, -R3.z, c[0].x;
SLT R0.x, c[0], -R3.z;
ADD R0.x, R0, -R0.y;
MUL R0.w, R3, R0.x;
MUL R0.z, R0.x, R0;
MUL R0.w, R3.y, R0;
MAD R1.z, R3.x, R0, R0.w;
SLT R0.x, c[0], -R3.y;
SLT R0.y, -R3, c[0].x;
ADD R0.y, R0.x, -R0;
MUL R0.x, R4.z, R0.y;
SLT R0.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R0.w;
MUL R0.w, R3, R0.y;
MUL R0.y, R0.z, R0;
MUL R3.w, R3.z, R0;
MOV R0.zw, R1.xyyw;
MAD R0.y, R3.x, R0, R3.w;
DP4 R4.z, R0, c[1];
DP4 R4.w, R0, c[2];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[15].x;
ADD result.texcoord[2].xy, R0, c[0].w;
DP4 R0.z, R1, c[1];
DP4 R0.w, R1, c[2];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[15].x;
ADD result.texcoord[3].xy, R0.zwzw, c[0].w;
DP4 R1.x, R2, c[9];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[13];
DP3 R0.x, R0, R0;
RSQ R0.x, R0.x;
RCP R0.w, R0.x;
DP4 R1.z, R2, c[11];
DP4 R1.y, R2, c[10];
ADD R0.xyz, -R1, c[13];
MUL R1.x, R0.w, c[14];
DP3 R0.w, R0, R0;
MIN R1.x, R1, c[0].z;
RSQ R0.w, R0.w;
MAX R1.x, R1, c[0];
MUL result.texcoord[4].xyz, R0.w, R0;
MUL result.color.w, vertex.color, R1.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 94 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"vs_3_0
; 86 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c14, 0.00000000, 2.00000000, -1.00000000, 0
def c15, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mov r2.w, v0
mov r2.xyz, c14.x
dp4 r4.x, r2, c0
dp4 r4.y, r2, c1
mov r1.w, v0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r0, r4, v0
mad r4.zw, v2.xyxy, c14.y, c14.z
mov r1.y, r4.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r4.w, -r4.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r4.w, r4.w
sub r3.w, r0.y, r0.z
mul r0.z, r4, r0.x
mul r1.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r1
dp4 r1.z, r0, c1
dp4 r1.x, r0, c0
add r0.xy, -r4, r1.xzzw
slt r0.z, r3, -r3
slt r0.w, -r3.z, r3.z
sub r4.w, r0, r0.z
mul r1.x, r4.z, r4.w
mad o3.xy, r0, c15.x, c15.y
slt r0.x, -r1, r1
slt r0.y, r1.x, -r1.x
sub r0.y, r0.x, r0
sub r0.x, r0.z, r0.w
mul r0.z, r0.x, r0.y
mul r0.w, r3, r0.x
mul r0.w, r3.y, r0
mad r1.z, r3.x, r0, r0.w
slt r0.x, r3.y, -r3.y
slt r0.y, -r3, r3
sub r0.y, r0.x, r0
mul r0.x, r4.z, r0.y
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r3, r0.y
mul r0.y, r0.z, r0
mul r3.w, r3.z, r0
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r4, r4.zwzw
mad o4.xy, r0, c15.x, c15.y
dp4 r0.z, r1, c0
dp4 r0.w, r1, c1
add r0.zw, -r4.xyxy, r0
mad o5.xy, r0.zwzw, c15.x, c15.y
dp4 r1.x, r2, c8
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c12
dp3 r0.w, r0, r0
add r0.xyz, -r1, c12
rsq r0.w, r0.w
dp3 r1.x, r0, r0
rcp r0.w, r0.w
rsq r1.x, r1.x
mul_sat r0.w, r0, c13.x
mul o6.xyz, r1.x, r0
mul o1.w, v1, r0
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176 // 152 used size, 11 vars
Float 148 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 63 instructions, 5 temp regs, 0 temp arrays:
// ALU 44 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedpmopgfjbelogjmflpakeaohjldclpaebabaaaaaagaakaaaaadaaaaaa
cmaaaaaajmaaaaaaiiabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
oeaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaankaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaankaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaankaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaankaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaankaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaankaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefcnaaiaaaaeaaaabaadeacaaaafjaaaaaeegiocaaa
aaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaabaaaaaaafjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacafaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaa
apaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahiccabaaaabaaaaaa
akaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaa
abaaaaaadgaaaaagbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaadgaaaaag
ccaabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaacaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaa
dbaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaai
aanaaaaahcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaaf
hcaabaaaadaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaa
aaaaaaaaegacbaaaadaaaaaaclaaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaa
diaaaaahkcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaak
mcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaa
aaaaaaaadbaaaaakdcaabaaaaeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaa
acaaaaaaagaebaaaaeaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaa
abaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaa
dcaaaaajdcaabaaaabaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaa
adaaaaaadiaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaacaaaaaa
afaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaaaeaaaaaapgapbaaa
aaaaaaaafganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaa
agaaaaaafgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaa
fganbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaa
acaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaa
acaaaaaaaeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaa
aaaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaa
dcaaaaapdccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaah
ccaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
acaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaa
dbaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaacaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaa
abaaaaaaboaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
aaaaaaaacgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.w = _glesVertex.w;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_modelview0 * tmpvar_6);
  vec4 v_8;
  v_8.x = glstate_matrix_modelview0[0].z;
  v_8.y = glstate_matrix_modelview0[1].z;
  v_8.z = glstate_matrix_modelview0[2].z;
  v_8.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_12;
  tmpvar_12.z = 0.0;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = tmpvar_11.y;
  tmpvar_12.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_12.zyw;
  XZv_2.yzw = tmpvar_12.zyw;
  XYv_1.yzw = tmpvar_12.yzw;
  ZYv_3.z = (tmpvar_11.x * sign(-(tmpvar_9.x)));
  XZv_2.x = (tmpvar_11.x * sign(-(tmpvar_9.y)));
  XYv_1.x = (tmpvar_11.x * sign(tmpvar_9.z));
  ZYv_3.x = ((sign(-(tmpvar_9.x)) * sign(ZYv_3.z)) * tmpvar_9.z);
  XZv_2.y = ((sign(-(tmpvar_9.y)) * sign(XZv_2.x)) * tmpvar_9.x);
  XYv_1.z = ((sign(-(tmpvar_9.z)) * sign(XYv_1.x)) * tmpvar_9.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_9.x)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_9.y)) * sign(tmpvar_11.y)) * tmpvar_9.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_9.z)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_13;
  p_13 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((_DistFade * sqrt(dot (p_13, p_13))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_14);
  gl_Position = (glstate_matrix_projection * (tmpvar_7 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_10).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp float atten_5;
  highp vec3 lightColor_6;
  mediump vec4 ztex_7;
  mediump float zval_8;
  mediump vec4 ytex_9;
  mediump float yval_10;
  mediump vec4 xtex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = xlv_TEXCOORD0.y;
  yval_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_9 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = xlv_TEXCOORD0.z;
  zval_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_7 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_11, ytex_9, vec4(yval_10)), ztex_7, vec4(zval_8)));
  lowp vec3 tmpvar_18;
  tmpvar_18 = _LightColor0.xyz;
  lightColor_6 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  lowp float tmpvar_20;
  tmpvar_20 = (texture2D (_LightTextureB0, vec2(tmpvar_19)).w * textureCube (_LightTexture0, xlv_TEXCOORD5).w);
  atten_5 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (_WorldNorm, tmpvar_21), 0.0, 1.0);
  WNL_4 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp (((_MinLight + lightColor_6) * clamp ((_LightColor0.w * ((tmpvar_23 * atten_5) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_24;
  color_2.xyz = (tmpvar_17.xyz * baseLight_3);
  color_2.w = tmpvar_17.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.w = _glesVertex.w;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_modelview0 * tmpvar_6);
  vec4 v_8;
  v_8.x = glstate_matrix_modelview0[0].z;
  v_8.y = glstate_matrix_modelview0[1].z;
  v_8.z = glstate_matrix_modelview0[2].z;
  v_8.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_12;
  tmpvar_12.z = 0.0;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = tmpvar_11.y;
  tmpvar_12.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_12.zyw;
  XZv_2.yzw = tmpvar_12.zyw;
  XYv_1.yzw = tmpvar_12.yzw;
  ZYv_3.z = (tmpvar_11.x * sign(-(tmpvar_9.x)));
  XZv_2.x = (tmpvar_11.x * sign(-(tmpvar_9.y)));
  XYv_1.x = (tmpvar_11.x * sign(tmpvar_9.z));
  ZYv_3.x = ((sign(-(tmpvar_9.x)) * sign(ZYv_3.z)) * tmpvar_9.z);
  XZv_2.y = ((sign(-(tmpvar_9.y)) * sign(XZv_2.x)) * tmpvar_9.x);
  XYv_1.z = ((sign(-(tmpvar_9.z)) * sign(XYv_1.x)) * tmpvar_9.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_9.x)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_9.y)) * sign(tmpvar_11.y)) * tmpvar_9.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_9.z)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_13;
  p_13 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((_DistFade * sqrt(dot (p_13, p_13))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_14);
  gl_Position = (glstate_matrix_projection * (tmpvar_7 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_10).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp float atten_5;
  highp vec3 lightColor_6;
  mediump vec4 ztex_7;
  mediump float zval_8;
  mediump vec4 ytex_9;
  mediump float yval_10;
  mediump vec4 xtex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = xlv_TEXCOORD0.y;
  yval_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_9 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = xlv_TEXCOORD0.z;
  zval_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_7 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_11, ytex_9, vec4(yval_10)), ztex_7, vec4(zval_8)));
  lowp vec3 tmpvar_18;
  tmpvar_18 = _LightColor0.xyz;
  lightColor_6 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  lowp float tmpvar_20;
  tmpvar_20 = (texture2D (_LightTextureB0, vec2(tmpvar_19)).w * textureCube (_LightTexture0, xlv_TEXCOORD5).w);
  atten_5 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (_WorldNorm, tmpvar_21), 0.0, 1.0);
  WNL_4 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp (((_MinLight + lightColor_6) * clamp ((_LightColor0.w * ((tmpvar_23 * atten_5) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_24;
  color_2.xyz = (tmpvar_17.xyz * baseLight_3);
  color_2.w = tmpvar_17.w;
  tmpvar_1 = color_2;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
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
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec3 _LightCoord;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 396
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 400
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 404
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 425
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 426
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 429
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 433
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 437
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 441
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 445
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 449
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 453
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    #line 457
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval._LightCoord);
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec3 _LightCoord;
};
#line 406
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 396
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 400
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 404
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 425
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 460
lowp vec4 frag( in v2f i ) {
    #line 462
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 466
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
    #line 470
    highp vec3 lightColor = _LightColor0.xyz;
    highp vec3 lightDir = vec3( _WorldSpaceLightPos0);
    highp float atten = ((texture( _LightTextureB0, vec2( dot( i._LightCoord, i._LightCoord))).w * texture( _LightTexture0, i._LightCoord).w) * 1.0);
    highp float NL = xll_saturate_f((0.5 * (1.0 + dot( i.projPos, lightDir))));
    #line 474
    highp float lightIntensity = xll_saturate_f((_LightColor0.w * ((NL * atten) * 4.0)));
    highp float lightScatter = xll_saturate_f((1.0 - ((lightIntensity * _LightScatter) * prev.w)));
    mediump float WNL = xll_saturate_f(dot( _WorldNorm, vec4( lightDir, 0.0)));
    mediump float diff = ((WNL - 0.01) / 0.99);
    #line 478
    lightIntensity = xll_saturate_f((_LightColor0.w * ((diff * atten) * 4.0)));
    mediump vec3 baseLight = xll_saturate_vf3(((_MinLight + lightColor) * lightIntensity));
    mediump vec4 color;
    color.xyz = (prev.xyz * baseLight);
    #line 482
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_i.projPos = vec3(xlv_TEXCOORD4);
    xlt_i._LightCoord = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_Object2World]
Float 14 [_DistFade]
"3.0-!!ARBvp1.0
# 94 ALU
PARAM c[16] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[3];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
DP4 R4.x, R2, c[1];
DP4 R4.y, R2, c[2];
MOV R1.w, vertex.position;
DP4 R4.w, R2, c[4];
DP4 R4.z, R2, c[3];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R4.zw, R0.xyxy, -c[0].z;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0].z;
ADD R3.w, R0.x, -R0.y;
SLT R0.z, c[0].x, -R3.x;
SLT R0.w, -R3.x, c[0].x;
ADD R0.w, R0.z, -R0;
MUL R0.z, R4, R0.w;
MUL R1.x, R0.w, R3.w;
SLT R0.y, R0.z, c[0].x;
SLT R0.x, c[0], R0.z;
ADD R0.x, R0, -R0.y;
MUL R0.y, R3, R1.x;
MUL R0.x, R0, R0.w;
MAD R0.x, R3.z, R0, R0.y;
MOV R0.yw, R1;
DP4 R1.x, R0, c[1];
DP4 R1.z, R0, c[2];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[15].x;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[0].w;
SLT R0.y, R1.x, c[0].x;
SLT R0.x, c[0], R1;
ADD R0.z, R0.x, -R0.y;
SLT R0.y, -R3.z, c[0].x;
SLT R0.x, c[0], -R3.z;
ADD R0.x, R0, -R0.y;
MUL R0.w, R3, R0.x;
MUL R0.z, R0.x, R0;
MUL R0.w, R3.y, R0;
MAD R1.z, R3.x, R0, R0.w;
SLT R0.x, c[0], -R3.y;
SLT R0.y, -R3, c[0].x;
ADD R0.y, R0.x, -R0;
MUL R0.x, R4.z, R0.y;
SLT R0.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R0.w;
MUL R0.w, R3, R0.y;
MUL R0.y, R0.z, R0;
MUL R3.w, R3.z, R0;
MOV R0.zw, R1.xyyw;
MAD R0.y, R3.x, R0, R3.w;
DP4 R4.z, R0, c[1];
DP4 R4.w, R0, c[2];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[15].x;
ADD result.texcoord[2].xy, R0, c[0].w;
DP4 R0.z, R1, c[1];
DP4 R0.w, R1, c[2];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[15].x;
ADD result.texcoord[3].xy, R0.zwzw, c[0].w;
DP4 R1.x, R2, c[9];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[13];
DP3 R0.x, R0, R0;
RSQ R0.x, R0.x;
RCP R0.w, R0.x;
DP4 R1.z, R2, c[11];
DP4 R1.y, R2, c[10];
ADD R0.xyz, -R1, c[13];
MUL R1.x, R0.w, c[14];
DP3 R0.w, R0, R0;
MIN R1.x, R1, c[0].z;
RSQ R0.w, R0.w;
MAX R1.x, R1, c[0];
MUL result.texcoord[4].xyz, R0.w, R0;
MUL result.color.w, vertex.color, R1.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 94 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"vs_3_0
; 86 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c14, 0.00000000, 2.00000000, -1.00000000, 0
def c15, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mov r2.w, v0
mov r2.xyz, c14.x
dp4 r4.x, r2, c0
dp4 r4.y, r2, c1
mov r1.w, v0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r0, r4, v0
mad r4.zw, v2.xyxy, c14.y, c14.z
mov r1.y, r4.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r4.w, -r4.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r4.w, r4.w
sub r3.w, r0.y, r0.z
mul r0.z, r4, r0.x
mul r1.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r1
dp4 r1.z, r0, c1
dp4 r1.x, r0, c0
add r0.xy, -r4, r1.xzzw
slt r0.z, r3, -r3
slt r0.w, -r3.z, r3.z
sub r4.w, r0, r0.z
mul r1.x, r4.z, r4.w
mad o3.xy, r0, c15.x, c15.y
slt r0.x, -r1, r1
slt r0.y, r1.x, -r1.x
sub r0.y, r0.x, r0
sub r0.x, r0.z, r0.w
mul r0.z, r0.x, r0.y
mul r0.w, r3, r0.x
mul r0.w, r3.y, r0
mad r1.z, r3.x, r0, r0.w
slt r0.x, r3.y, -r3.y
slt r0.y, -r3, r3
sub r0.y, r0.x, r0
mul r0.x, r4.z, r0.y
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r3, r0.y
mul r0.y, r0.z, r0
mul r3.w, r3.z, r0
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r4, r4.zwzw
mad o4.xy, r0, c15.x, c15.y
dp4 r0.z, r1, c0
dp4 r0.w, r1, c1
add r0.zw, -r4.xyxy, r0
mad o5.xy, r0.zwzw, c15.x, c15.y
dp4 r1.x, r2, c8
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c12
dp3 r0.w, r0, r0
add r0.xyz, -r1, c12
rsq r0.w, r0.w
dp3 r1.x, r0, r0
rcp r0.w, r0.w
rsq r1.x, r1.x
mul_sat r0.w, r0, c13.x
mul o6.xyz, r1.x, r0
mul o1.w, v1, r0
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176 // 152 used size, 11 vars
Float 148 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 63 instructions, 5 temp regs, 0 temp arrays:
// ALU 44 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedecpeblefkdochjckoebddigaglnofgdoabaaaaaagaakaaaaadaaaaaa
cmaaaaaajmaaaaaaiiabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
oeaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaankaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaankaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaankaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaankaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaankaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaamapaaaankaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefcnaaiaaaaeaaaabaadeacaaaafjaaaaaeegiocaaa
aaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaabaaaaaaafjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacafaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaa
apaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahiccabaaaabaaaaaa
akaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaa
abaaaaaadgaaaaagbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaadgaaaaag
ccaabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaacaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaa
dbaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaai
aanaaaaahcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaaf
hcaabaaaadaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaa
aaaaaaaaegacbaaaadaaaaaaclaaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaa
diaaaaahkcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaak
mcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaa
aaaaaaaadbaaaaakdcaabaaaaeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaa
acaaaaaaagaebaaaaeaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaa
abaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaa
dcaaaaajdcaabaaaabaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaa
adaaaaaadiaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaacaaaaaa
afaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaaaeaaaaaapgapbaaa
aaaaaaaafganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaa
agaaaaaafgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaa
fganbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaa
acaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaa
acaaaaaaaeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaa
aaaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaa
dcaaaaapdccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaah
ccaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
acaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaa
dbaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaacaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaa
abaaaaaaboaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
aaaaaaaacgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.w = _glesVertex.w;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_modelview0 * tmpvar_6);
  vec4 v_8;
  v_8.x = glstate_matrix_modelview0[0].z;
  v_8.y = glstate_matrix_modelview0[1].z;
  v_8.z = glstate_matrix_modelview0[2].z;
  v_8.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_12;
  tmpvar_12.z = 0.0;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = tmpvar_11.y;
  tmpvar_12.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_12.zyw;
  XZv_2.yzw = tmpvar_12.zyw;
  XYv_1.yzw = tmpvar_12.yzw;
  ZYv_3.z = (tmpvar_11.x * sign(-(tmpvar_9.x)));
  XZv_2.x = (tmpvar_11.x * sign(-(tmpvar_9.y)));
  XYv_1.x = (tmpvar_11.x * sign(tmpvar_9.z));
  ZYv_3.x = ((sign(-(tmpvar_9.x)) * sign(ZYv_3.z)) * tmpvar_9.z);
  XZv_2.y = ((sign(-(tmpvar_9.y)) * sign(XZv_2.x)) * tmpvar_9.x);
  XYv_1.z = ((sign(-(tmpvar_9.z)) * sign(XYv_1.x)) * tmpvar_9.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_9.x)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_9.y)) * sign(tmpvar_11.y)) * tmpvar_9.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_9.z)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_13;
  p_13 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((_DistFade * sqrt(dot (p_13, p_13))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_14);
  gl_Position = (glstate_matrix_projection * (tmpvar_7 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_10).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp float atten_5;
  highp vec3 lightDir_6;
  highp vec3 lightColor_7;
  mediump vec4 ztex_8;
  mediump float zval_9;
  mediump vec4 ytex_10;
  mediump float yval_11;
  mediump vec4 xtex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.y;
  yval_11 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = xlv_TEXCOORD0.z;
  zval_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_8 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_12, ytex_10, vec4(yval_11)), ztex_8, vec4(zval_9)));
  lowp vec3 tmpvar_19;
  tmpvar_19 = _LightColor0.xyz;
  lightColor_7 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_LightTexture0, xlv_TEXCOORD5).w;
  atten_5 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = lightDir_6;
  highp float tmpvar_23;
  tmpvar_23 = clamp (dot (_WorldNorm, tmpvar_22), 0.0, 1.0);
  WNL_4 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_25;
  tmpvar_25 = clamp (((_MinLight + lightColor_7) * clamp ((_LightColor0.w * ((tmpvar_24 * atten_5) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_25;
  color_2.xyz = (tmpvar_18.xyz * baseLight_3);
  color_2.w = tmpvar_18.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.w = _glesVertex.w;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_modelview0 * tmpvar_6);
  vec4 v_8;
  v_8.x = glstate_matrix_modelview0[0].z;
  v_8.y = glstate_matrix_modelview0[1].z;
  v_8.z = glstate_matrix_modelview0[2].z;
  v_8.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_12;
  tmpvar_12.z = 0.0;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = tmpvar_11.y;
  tmpvar_12.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_12.zyw;
  XZv_2.yzw = tmpvar_12.zyw;
  XYv_1.yzw = tmpvar_12.yzw;
  ZYv_3.z = (tmpvar_11.x * sign(-(tmpvar_9.x)));
  XZv_2.x = (tmpvar_11.x * sign(-(tmpvar_9.y)));
  XYv_1.x = (tmpvar_11.x * sign(tmpvar_9.z));
  ZYv_3.x = ((sign(-(tmpvar_9.x)) * sign(ZYv_3.z)) * tmpvar_9.z);
  XZv_2.y = ((sign(-(tmpvar_9.y)) * sign(XZv_2.x)) * tmpvar_9.x);
  XYv_1.z = ((sign(-(tmpvar_9.z)) * sign(XYv_1.x)) * tmpvar_9.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_9.x)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_9.y)) * sign(tmpvar_11.y)) * tmpvar_9.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_9.z)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_13;
  p_13 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((_DistFade * sqrt(dot (p_13, p_13))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_14);
  gl_Position = (glstate_matrix_projection * (tmpvar_7 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_10).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp float atten_5;
  highp vec3 lightDir_6;
  highp vec3 lightColor_7;
  mediump vec4 ztex_8;
  mediump float zval_9;
  mediump vec4 ytex_10;
  mediump float yval_11;
  mediump vec4 xtex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.y;
  yval_11 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = xlv_TEXCOORD0.z;
  zval_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_8 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_12, ytex_10, vec4(yval_11)), ztex_8, vec4(zval_9)));
  lowp vec3 tmpvar_19;
  tmpvar_19 = _LightColor0.xyz;
  lightColor_7 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_LightTexture0, xlv_TEXCOORD5).w;
  atten_5 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = lightDir_6;
  highp float tmpvar_23;
  tmpvar_23 = clamp (dot (_WorldNorm, tmpvar_22), 0.0, 1.0);
  WNL_4 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_25;
  tmpvar_25 = clamp (((_MinLight + lightColor_7) * clamp ((_LightColor0.w * ((tmpvar_24 * atten_5) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_25;
  color_2.xyz = (tmpvar_18.xyz * baseLight_3);
  color_2.w = tmpvar_18.w;
  tmpvar_1 = color_2;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
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
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec2 _LightCoord;
};
#line 405
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 395
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 399
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 403
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 424
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 425
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 428
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 432
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 436
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 440
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 444
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 448
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 452
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    #line 456
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec2(xl_retval._LightCoord);
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec2 _LightCoord;
};
#line 405
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 395
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 399
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 403
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 424
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 459
lowp vec4 frag( in v2f i ) {
    #line 461
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 465
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
    #line 469
    highp vec3 lightColor = _LightColor0.xyz;
    highp vec3 lightDir = vec3( _WorldSpaceLightPos0);
    highp float atten = (texture( _LightTexture0, i._LightCoord).w * 1.0);
    highp float NL = xll_saturate_f((0.5 * (1.0 + dot( i.projPos, lightDir))));
    #line 473
    highp float lightIntensity = xll_saturate_f((_LightColor0.w * ((NL * atten) * 4.0)));
    highp float lightScatter = xll_saturate_f((1.0 - ((lightIntensity * _LightScatter) * prev.w)));
    mediump float WNL = xll_saturate_f(dot( _WorldNorm, vec4( lightDir, 0.0)));
    mediump float diff = ((WNL - 0.01) / 0.99);
    #line 477
    lightIntensity = xll_saturate_f((_LightColor0.w * ((diff * atten) * 4.0)));
    mediump vec3 baseLight = xll_saturate_vf3(((_MinLight + lightColor) * lightIntensity));
    mediump vec4 color;
    color.xyz = (prev.xyz * baseLight);
    #line 481
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_i.projPos = vec3(xlv_TEXCOORD4);
    xlt_i._LightCoord = vec2(xlv_TEXCOORD5);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_Object2World]
Float 14 [_DistFade]
"3.0-!!ARBvp1.0
# 94 ALU
PARAM c[16] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[3];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
DP4 R4.x, R2, c[1];
DP4 R4.y, R2, c[2];
MOV R1.w, vertex.position;
DP4 R4.w, R2, c[4];
DP4 R4.z, R2, c[3];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R4.zw, R0.xyxy, -c[0].z;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0].z;
ADD R3.w, R0.x, -R0.y;
SLT R0.z, c[0].x, -R3.x;
SLT R0.w, -R3.x, c[0].x;
ADD R0.w, R0.z, -R0;
MUL R0.z, R4, R0.w;
MUL R1.x, R0.w, R3.w;
SLT R0.y, R0.z, c[0].x;
SLT R0.x, c[0], R0.z;
ADD R0.x, R0, -R0.y;
MUL R0.y, R3, R1.x;
MUL R0.x, R0, R0.w;
MAD R0.x, R3.z, R0, R0.y;
MOV R0.yw, R1;
DP4 R1.x, R0, c[1];
DP4 R1.z, R0, c[2];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[15].x;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[0].w;
SLT R0.y, R1.x, c[0].x;
SLT R0.x, c[0], R1;
ADD R0.z, R0.x, -R0.y;
SLT R0.y, -R3.z, c[0].x;
SLT R0.x, c[0], -R3.z;
ADD R0.x, R0, -R0.y;
MUL R0.w, R3, R0.x;
MUL R0.z, R0.x, R0;
MUL R0.w, R3.y, R0;
MAD R1.z, R3.x, R0, R0.w;
SLT R0.x, c[0], -R3.y;
SLT R0.y, -R3, c[0].x;
ADD R0.y, R0.x, -R0;
MUL R0.x, R4.z, R0.y;
SLT R0.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R0.w;
MUL R0.w, R3, R0.y;
MUL R0.y, R0.z, R0;
MUL R3.w, R3.z, R0;
MOV R0.zw, R1.xyyw;
MAD R0.y, R3.x, R0, R3.w;
DP4 R4.z, R0, c[1];
DP4 R4.w, R0, c[2];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[15].x;
ADD result.texcoord[2].xy, R0, c[0].w;
DP4 R0.z, R1, c[1];
DP4 R0.w, R1, c[2];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[15].x;
ADD result.texcoord[3].xy, R0.zwzw, c[0].w;
DP4 R1.x, R2, c[9];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[13];
DP3 R0.x, R0, R0;
RSQ R0.x, R0.x;
RCP R0.w, R0.x;
DP4 R1.z, R2, c[11];
DP4 R1.y, R2, c[10];
ADD R0.xyz, -R1, c[13];
MUL R1.x, R0.w, c[14];
DP3 R0.w, R0, R0;
MIN R1.x, R1, c[0].z;
RSQ R0.w, R0.w;
MAX R1.x, R1, c[0];
MUL result.texcoord[4].xyz, R0.w, R0;
MUL result.color.w, vertex.color, R1.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 94 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"vs_3_0
; 86 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c14, 0.00000000, 2.00000000, -1.00000000, 0
def c15, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mov r2.w, v0
mov r2.xyz, c14.x
dp4 r4.x, r2, c0
dp4 r4.y, r2, c1
mov r1.w, v0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r0, r4, v0
mad r4.zw, v2.xyxy, c14.y, c14.z
mov r1.y, r4.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r4.w, -r4.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r4.w, r4.w
sub r3.w, r0.y, r0.z
mul r0.z, r4, r0.x
mul r1.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r1
dp4 r1.z, r0, c1
dp4 r1.x, r0, c0
add r0.xy, -r4, r1.xzzw
slt r0.z, r3, -r3
slt r0.w, -r3.z, r3.z
sub r4.w, r0, r0.z
mul r1.x, r4.z, r4.w
mad o3.xy, r0, c15.x, c15.y
slt r0.x, -r1, r1
slt r0.y, r1.x, -r1.x
sub r0.y, r0.x, r0
sub r0.x, r0.z, r0.w
mul r0.z, r0.x, r0.y
mul r0.w, r3, r0.x
mul r0.w, r3.y, r0
mad r1.z, r3.x, r0, r0.w
slt r0.x, r3.y, -r3.y
slt r0.y, -r3, r3
sub r0.y, r0.x, r0
mul r0.x, r4.z, r0.y
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r3, r0.y
mul r0.y, r0.z, r0
mul r3.w, r3.z, r0
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r4, r4.zwzw
mad o4.xy, r0, c15.x, c15.y
dp4 r0.z, r1, c0
dp4 r0.w, r1, c1
add r0.zw, -r4.xyxy, r0
mad o5.xy, r0.zwzw, c15.x, c15.y
dp4 r1.x, r2, c8
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c12
dp3 r0.w, r0, r0
add r0.xyz, -r1, c12
rsq r0.w, r0.w
dp3 r1.x, r0, r0
rcp r0.w, r0.w
rsq r1.x, r1.x
mul_sat r0.w, r0, c13.x
mul o6.xyz, r1.x, r0
mul o1.w, v1, r0
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176 // 152 used size, 11 vars
Float 148 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 63 instructions, 5 temp regs, 0 temp arrays:
// ALU 44 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbnmehebjnpggkjnpkikdagcakhjbkjkgabaaaaaahiakaaaaadaaaaaa
cmaaaaaajmaaaaaakaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
pmaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaapcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaapcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaapcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaapcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaapcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaapcaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaapcaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcnaaiaaaaeaaaabaadeacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaa
fjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaajaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaa
abaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaa
egacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaa
adaaaaaaclaaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaa
aaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaak
dcaabaaaaeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaa
aeaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaa
acaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaa
abaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaai
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaacaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
acaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaacaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
acaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaacaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = _glesVertex.w;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_modelview0 * tmpvar_7);
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_13.zyw;
  XZv_2.yzw = tmpvar_13.zyw;
  XYv_1.yzw = tmpvar_13.yzw;
  ZYv_3.z = (tmpvar_12.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_12.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_12.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_12.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_14;
  p_14 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_15);
  gl_Position = (glstate_matrix_projection * (tmpvar_8 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightColor_5;
  mediump vec4 ztex_6;
  mediump float zval_7;
  mediump vec4 ytex_8;
  mediump float yval_9;
  mediump vec4 xtex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.y;
  yval_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.z;
  zval_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_10, ytex_8, vec4(yval_9)), ztex_6, vec4(zval_7)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  lightColor_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) + 0.5);
  tmpvar_19 = texture2D (_LightTexture0, P_20);
  highp float tmpvar_21;
  tmpvar_21 = dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_LightTextureB0, vec2(tmpvar_21));
  lowp float tmpvar_23;
  mediump float shadow_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6);
  highp float tmpvar_26;
  if ((tmpvar_25.x < (xlv_TEXCOORD6.z / xlv_TEXCOORD6.w))) {
    tmpvar_26 = _LightShadowData.x;
  } else {
    tmpvar_26 = 1.0;
  };
  shadow_24 = tmpvar_26;
  tmpvar_23 = shadow_24;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = tmpvar_18;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (_WorldNorm, tmpvar_27), 0.0, 1.0);
  WNL_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp (((_MinLight + lightColor_5) * clamp ((_LightColor0.w * ((tmpvar_29 * (((float((xlv_TEXCOORD5.z > 0.0)) * tmpvar_19.w) * tmpvar_22.w) * tmpvar_23)) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_30;
  color_2.xyz = (tmpvar_16.xyz * baseLight_3);
  color_2.w = tmpvar_16.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = _glesVertex.w;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_modelview0 * tmpvar_7);
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_13.zyw;
  XZv_2.yzw = tmpvar_13.zyw;
  XYv_1.yzw = tmpvar_13.yzw;
  ZYv_3.z = (tmpvar_12.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_12.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_12.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_12.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_14;
  p_14 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_15);
  gl_Position = (glstate_matrix_projection * (tmpvar_8 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightColor_5;
  mediump vec4 ztex_6;
  mediump float zval_7;
  mediump vec4 ytex_8;
  mediump float yval_9;
  mediump vec4 xtex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.y;
  yval_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.z;
  zval_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_10, ytex_8, vec4(yval_9)), ztex_6, vec4(zval_7)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  lightColor_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) + 0.5);
  tmpvar_19 = texture2D (_LightTexture0, P_20);
  highp float tmpvar_21;
  tmpvar_21 = dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_LightTextureB0, vec2(tmpvar_21));
  lowp float tmpvar_23;
  mediump float shadow_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6);
  highp float tmpvar_26;
  if ((tmpvar_25.x < (xlv_TEXCOORD6.z / xlv_TEXCOORD6.w))) {
    tmpvar_26 = _LightShadowData.x;
  } else {
    tmpvar_26 = 1.0;
  };
  shadow_24 = tmpvar_26;
  tmpvar_23 = shadow_24;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = tmpvar_18;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (_WorldNorm, tmpvar_27), 0.0, 1.0);
  WNL_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp (((_MinLight + lightColor_5) * clamp ((_LightColor0.w * ((tmpvar_29 * (((float((xlv_TEXCOORD5.z > 0.0)) * tmpvar_19.w) * tmpvar_22.w) * tmpvar_23)) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_30;
  color_2.xyz = (tmpvar_16.xyz * baseLight_3);
  color_2.w = tmpvar_16.w;
  tmpvar_1 = color_2;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
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
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 420
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 410
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 414
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 418
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 440
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 441
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 444
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 448
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 452
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 456
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 460
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 464
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 468
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    #line 472
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD6 = vec4(xl_retval._ShadowCoord);
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 420
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 410
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 414
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 418
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 440
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 328
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 324
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 316
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    mediump float shadow = (( (textureProj( _ShadowMapTexture, shadowCoord).x < (shadowCoord.z / shadowCoord.w)) ) ? ( _LightShadowData.x ) : ( 1.0 ));
    #line 319
    return shadow;
}
#line 475
lowp vec4 frag( in v2f i ) {
    #line 477
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 481
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
    #line 485
    highp vec3 lightColor = _LightColor0.xyz;
    highp vec3 lightDir = vec3( _WorldSpaceLightPos0);
    highp float atten = (((float((i._LightCoord.z > 0.0)) * UnitySpotCookie( i._LightCoord)) * UnitySpotAttenuate( i._LightCoord.xyz)) * unitySampleShadow( i._ShadowCoord));
    highp float NL = xll_saturate_f((0.5 * (1.0 + dot( i.projPos, lightDir))));
    #line 489
    highp float lightIntensity = xll_saturate_f((_LightColor0.w * ((NL * atten) * 4.0)));
    highp float lightScatter = xll_saturate_f((1.0 - ((lightIntensity * _LightScatter) * prev.w)));
    mediump float WNL = xll_saturate_f(dot( _WorldNorm, vec4( lightDir, 0.0)));
    mediump float diff = ((WNL - 0.01) / 0.99);
    #line 493
    lightIntensity = xll_saturate_f((_LightColor0.w * ((diff * atten) * 4.0)));
    mediump vec3 baseLight = xll_saturate_vf3(((_MinLight + lightColor) * lightIntensity));
    mediump vec4 color;
    color.xyz = (prev.xyz * baseLight);
    #line 497
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_i.projPos = vec3(xlv_TEXCOORD4);
    xlt_i._LightCoord = vec4(xlv_TEXCOORD5);
    xlt_i._ShadowCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_Object2World]
Float 14 [_DistFade]
"3.0-!!ARBvp1.0
# 94 ALU
PARAM c[16] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[3];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
DP4 R4.x, R2, c[1];
DP4 R4.y, R2, c[2];
MOV R1.w, vertex.position;
DP4 R4.w, R2, c[4];
DP4 R4.z, R2, c[3];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R4.zw, R0.xyxy, -c[0].z;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0].z;
ADD R3.w, R0.x, -R0.y;
SLT R0.z, c[0].x, -R3.x;
SLT R0.w, -R3.x, c[0].x;
ADD R0.w, R0.z, -R0;
MUL R0.z, R4, R0.w;
MUL R1.x, R0.w, R3.w;
SLT R0.y, R0.z, c[0].x;
SLT R0.x, c[0], R0.z;
ADD R0.x, R0, -R0.y;
MUL R0.y, R3, R1.x;
MUL R0.x, R0, R0.w;
MAD R0.x, R3.z, R0, R0.y;
MOV R0.yw, R1;
DP4 R1.x, R0, c[1];
DP4 R1.z, R0, c[2];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[15].x;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[0].w;
SLT R0.y, R1.x, c[0].x;
SLT R0.x, c[0], R1;
ADD R0.z, R0.x, -R0.y;
SLT R0.y, -R3.z, c[0].x;
SLT R0.x, c[0], -R3.z;
ADD R0.x, R0, -R0.y;
MUL R0.w, R3, R0.x;
MUL R0.z, R0.x, R0;
MUL R0.w, R3.y, R0;
MAD R1.z, R3.x, R0, R0.w;
SLT R0.x, c[0], -R3.y;
SLT R0.y, -R3, c[0].x;
ADD R0.y, R0.x, -R0;
MUL R0.x, R4.z, R0.y;
SLT R0.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R0.w;
MUL R0.w, R3, R0.y;
MUL R0.y, R0.z, R0;
MUL R3.w, R3.z, R0;
MOV R0.zw, R1.xyyw;
MAD R0.y, R3.x, R0, R3.w;
DP4 R4.z, R0, c[1];
DP4 R4.w, R0, c[2];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[15].x;
ADD result.texcoord[2].xy, R0, c[0].w;
DP4 R0.z, R1, c[1];
DP4 R0.w, R1, c[2];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[15].x;
ADD result.texcoord[3].xy, R0.zwzw, c[0].w;
DP4 R1.x, R2, c[9];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[13];
DP3 R0.x, R0, R0;
RSQ R0.x, R0.x;
RCP R0.w, R0.x;
DP4 R1.z, R2, c[11];
DP4 R1.y, R2, c[10];
ADD R0.xyz, -R1, c[13];
MUL R1.x, R0.w, c[14];
DP3 R0.w, R0, R0;
MIN R1.x, R1, c[0].z;
RSQ R0.w, R0.w;
MAX R1.x, R1, c[0];
MUL result.texcoord[4].xyz, R0.w, R0;
MUL result.color.w, vertex.color, R1.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 94 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"vs_3_0
; 86 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c14, 0.00000000, 2.00000000, -1.00000000, 0
def c15, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mov r2.w, v0
mov r2.xyz, c14.x
dp4 r4.x, r2, c0
dp4 r4.y, r2, c1
mov r1.w, v0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r0, r4, v0
mad r4.zw, v2.xyxy, c14.y, c14.z
mov r1.y, r4.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r4.w, -r4.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r4.w, r4.w
sub r3.w, r0.y, r0.z
mul r0.z, r4, r0.x
mul r1.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r1
dp4 r1.z, r0, c1
dp4 r1.x, r0, c0
add r0.xy, -r4, r1.xzzw
slt r0.z, r3, -r3
slt r0.w, -r3.z, r3.z
sub r4.w, r0, r0.z
mul r1.x, r4.z, r4.w
mad o3.xy, r0, c15.x, c15.y
slt r0.x, -r1, r1
slt r0.y, r1.x, -r1.x
sub r0.y, r0.x, r0
sub r0.x, r0.z, r0.w
mul r0.z, r0.x, r0.y
mul r0.w, r3, r0.x
mul r0.w, r3.y, r0
mad r1.z, r3.x, r0, r0.w
slt r0.x, r3.y, -r3.y
slt r0.y, -r3, r3
sub r0.y, r0.x, r0
mul r0.x, r4.z, r0.y
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r3, r0.y
mul r0.y, r0.z, r0
mul r3.w, r3.z, r0
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r4, r4.zwzw
mad o4.xy, r0, c15.x, c15.y
dp4 r0.z, r1, c0
dp4 r0.w, r1, c1
add r0.zw, -r4.xyxy, r0
mad o5.xy, r0.zwzw, c15.x, c15.y
dp4 r1.x, r2, c8
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c12
dp3 r0.w, r0, r0
add r0.xyz, -r1, c12
rsq r0.w, r0.w
dp3 r1.x, r0, r0
rcp r0.w, r0.w
rsq r1.x, r1.x
mul_sat r0.w, r0, c13.x
mul o6.xyz, r1.x, r0
mul o1.w, v1, r0
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176 // 152 used size, 11 vars
Float 148 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 63 instructions, 5 temp regs, 0 temp arrays:
// ALU 44 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbnmehebjnpggkjnpkikdagcakhjbkjkgabaaaaaahiakaaaaadaaaaaa
cmaaaaaajmaaaaaakaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
pmaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaapcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaapcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaapcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaapcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaapcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaapcaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaapcaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcnaaiaaaaeaaaabaadeacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaa
fjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaajaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaa
abaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaa
egacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaa
adaaaaaaclaaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaa
aaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaak
dcaabaaaaeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaa
aeaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaa
acaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaa
abaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaai
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaacaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
acaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaacaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
acaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaacaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = _glesVertex.w;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_modelview0 * tmpvar_7);
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_13.zyw;
  XZv_2.yzw = tmpvar_13.zyw;
  XYv_1.yzw = tmpvar_13.yzw;
  ZYv_3.z = (tmpvar_12.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_12.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_12.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_12.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_14;
  p_14 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_15);
  gl_Position = (glstate_matrix_projection * (tmpvar_8 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightColor_5;
  mediump vec4 ztex_6;
  mediump float zval_7;
  mediump vec4 ytex_8;
  mediump float yval_9;
  mediump vec4 xtex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.y;
  yval_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.z;
  zval_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_10, ytex_8, vec4(yval_9)), ztex_6, vec4(zval_7)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  lightColor_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) + 0.5);
  tmpvar_18 = texture2D (_LightTexture0, P_19);
  highp float tmpvar_20;
  tmpvar_20 = dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20));
  lowp float tmpvar_22;
  mediump float shadow_23;
  lowp float tmpvar_24;
  tmpvar_24 = shadow2DProjEXT (_ShadowMapTexture, xlv_TEXCOORD6);
  shadow_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = (_LightShadowData.x + (shadow_23 * (1.0 - _LightShadowData.x)));
  shadow_23 = tmpvar_25;
  tmpvar_22 = shadow_23;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 0.0;
  tmpvar_26.xyz = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (_WorldNorm, tmpvar_26), 0.0, 1.0);
  WNL_4 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp (((_MinLight + lightColor_5) * clamp ((_LightColor0.w * ((tmpvar_28 * (((float((xlv_TEXCOORD5.z > 0.0)) * tmpvar_18.w) * tmpvar_21.w) * tmpvar_22)) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_29;
  color_2.xyz = (tmpvar_16.xyz * baseLight_3);
  color_2.w = tmpvar_16.w;
  tmpvar_1 = color_2;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
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
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 421
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 411
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 415
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 419
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 441
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 442
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 445
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 449
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 453
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 457
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 461
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 465
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 469
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    #line 473
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD6 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2Dproj(mediump sampler2DShadow s, vec4 coord) { return textureProj (s, coord); }
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 421
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 411
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 415
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 419
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 441
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 329
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    #line 331
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 325
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    #line 327
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 316
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    mediump float shadow = xll_shadow2Dproj( _ShadowMapTexture, shadowCoord);
    #line 319
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 476
lowp vec4 frag( in v2f i ) {
    #line 478
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 482
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
    #line 486
    highp vec3 lightColor = _LightColor0.xyz;
    highp vec3 lightDir = vec3( _WorldSpaceLightPos0);
    highp float atten = (((float((i._LightCoord.z > 0.0)) * UnitySpotCookie( i._LightCoord)) * UnitySpotAttenuate( i._LightCoord.xyz)) * unitySampleShadow( i._ShadowCoord));
    highp float NL = xll_saturate_f((0.5 * (1.0 + dot( i.projPos, lightDir))));
    #line 490
    highp float lightIntensity = xll_saturate_f((_LightColor0.w * ((NL * atten) * 4.0)));
    highp float lightScatter = xll_saturate_f((1.0 - ((lightIntensity * _LightScatter) * prev.w)));
    mediump float WNL = xll_saturate_f(dot( _WorldNorm, vec4( lightDir, 0.0)));
    mediump float diff = ((WNL - 0.01) / 0.99);
    #line 494
    lightIntensity = xll_saturate_f((_LightColor0.w * ((diff * atten) * 4.0)));
    mediump vec3 baseLight = xll_saturate_vf3(((_MinLight + lightColor) * lightIntensity));
    mediump vec4 color;
    color.xyz = (prev.xyz * baseLight);
    #line 498
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_i.projPos = vec3(xlv_TEXCOORD4);
    xlt_i._LightCoord = vec4(xlv_TEXCOORD5);
    xlt_i._ShadowCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_Object2World]
Float 14 [_DistFade]
"3.0-!!ARBvp1.0
# 94 ALU
PARAM c[16] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[3];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
DP4 R4.x, R2, c[1];
DP4 R4.y, R2, c[2];
MOV R1.w, vertex.position;
DP4 R4.w, R2, c[4];
DP4 R4.z, R2, c[3];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R4.zw, R0.xyxy, -c[0].z;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0].z;
ADD R3.w, R0.x, -R0.y;
SLT R0.z, c[0].x, -R3.x;
SLT R0.w, -R3.x, c[0].x;
ADD R0.w, R0.z, -R0;
MUL R0.z, R4, R0.w;
MUL R1.x, R0.w, R3.w;
SLT R0.y, R0.z, c[0].x;
SLT R0.x, c[0], R0.z;
ADD R0.x, R0, -R0.y;
MUL R0.y, R3, R1.x;
MUL R0.x, R0, R0.w;
MAD R0.x, R3.z, R0, R0.y;
MOV R0.yw, R1;
DP4 R1.x, R0, c[1];
DP4 R1.z, R0, c[2];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[15].x;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[0].w;
SLT R0.y, R1.x, c[0].x;
SLT R0.x, c[0], R1;
ADD R0.z, R0.x, -R0.y;
SLT R0.y, -R3.z, c[0].x;
SLT R0.x, c[0], -R3.z;
ADD R0.x, R0, -R0.y;
MUL R0.w, R3, R0.x;
MUL R0.z, R0.x, R0;
MUL R0.w, R3.y, R0;
MAD R1.z, R3.x, R0, R0.w;
SLT R0.x, c[0], -R3.y;
SLT R0.y, -R3, c[0].x;
ADD R0.y, R0.x, -R0;
MUL R0.x, R4.z, R0.y;
SLT R0.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R0.w;
MUL R0.w, R3, R0.y;
MUL R0.y, R0.z, R0;
MUL R3.w, R3.z, R0;
MOV R0.zw, R1.xyyw;
MAD R0.y, R3.x, R0, R3.w;
DP4 R4.z, R0, c[1];
DP4 R4.w, R0, c[2];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[15].x;
ADD result.texcoord[2].xy, R0, c[0].w;
DP4 R0.z, R1, c[1];
DP4 R0.w, R1, c[2];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[15].x;
ADD result.texcoord[3].xy, R0.zwzw, c[0].w;
DP4 R1.x, R2, c[9];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[13];
DP3 R0.x, R0, R0;
RSQ R0.x, R0.x;
RCP R0.w, R0.x;
DP4 R1.z, R2, c[11];
DP4 R1.y, R2, c[10];
ADD R0.xyz, -R1, c[13];
MUL R1.x, R0.w, c[14];
DP3 R0.w, R0, R0;
MIN R1.x, R1, c[0].z;
RSQ R0.w, R0.w;
MAX R1.x, R1, c[0];
MUL result.texcoord[4].xyz, R0.w, R0;
MUL result.color.w, vertex.color, R1.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 94 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"vs_3_0
; 86 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c14, 0.00000000, 2.00000000, -1.00000000, 0
def c15, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mov r2.w, v0
mov r2.xyz, c14.x
dp4 r4.x, r2, c0
dp4 r4.y, r2, c1
mov r1.w, v0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r0, r4, v0
mad r4.zw, v2.xyxy, c14.y, c14.z
mov r1.y, r4.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r4.w, -r4.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r4.w, r4.w
sub r3.w, r0.y, r0.z
mul r0.z, r4, r0.x
mul r1.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r1
dp4 r1.z, r0, c1
dp4 r1.x, r0, c0
add r0.xy, -r4, r1.xzzw
slt r0.z, r3, -r3
slt r0.w, -r3.z, r3.z
sub r4.w, r0, r0.z
mul r1.x, r4.z, r4.w
mad o3.xy, r0, c15.x, c15.y
slt r0.x, -r1, r1
slt r0.y, r1.x, -r1.x
sub r0.y, r0.x, r0
sub r0.x, r0.z, r0.w
mul r0.z, r0.x, r0.y
mul r0.w, r3, r0.x
mul r0.w, r3.y, r0
mad r1.z, r3.x, r0, r0.w
slt r0.x, r3.y, -r3.y
slt r0.y, -r3, r3
sub r0.y, r0.x, r0
mul r0.x, r4.z, r0.y
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r3, r0.y
mul r0.y, r0.z, r0
mul r3.w, r3.z, r0
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r4, r4.zwzw
mad o4.xy, r0, c15.x, c15.y
dp4 r0.z, r1, c0
dp4 r0.w, r1, c1
add r0.zw, -r4.xyxy, r0
mad o5.xy, r0.zwzw, c15.x, c15.y
dp4 r1.x, r2, c8
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c12
dp3 r0.w, r0, r0
add r0.xyz, -r1, c12
rsq r0.w, r0.w
dp3 r1.x, r0, r0
rcp r0.w, r0.w
rsq r1.x, r1.x
mul_sat r0.w, r0, c13.x
mul o6.xyz, r1.x, r0
mul o1.w, v1, r0
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176 // 152 used size, 11 vars
Float 148 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 63 instructions, 5 temp regs, 0 temp arrays:
// ALU 44 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedjakpiplefackdbdcddlpiplgpeadclgpabaaaaaagaakaaaaadaaaaaa
cmaaaaaajmaaaaaaiiabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
oeaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaankaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaankaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaankaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaankaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaankaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaankaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefcnaaiaaaaeaaaabaadeacaaaafjaaaaaeegiocaaa
aaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaabaaaaaaafjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacafaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaa
apaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahiccabaaaabaaaaaa
akaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaa
abaaaaaadgaaaaagbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaadgaaaaag
ccaabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaacaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaa
dbaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaai
aanaaaaahcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaaf
hcaabaaaadaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaa
aaaaaaaaegacbaaaadaaaaaaclaaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaa
diaaaaahkcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaak
mcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaa
aaaaaaaadbaaaaakdcaabaaaaeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaa
acaaaaaaagaebaaaaeaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaa
abaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaa
dcaaaaajdcaabaaaabaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaa
adaaaaaadiaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaacaaaaaa
afaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaaaeaaaaaapgapbaaa
aaaaaaaafganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaa
agaaaaaafgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaa
fganbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaa
acaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaa
acaaaaaaaeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaa
aaaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaa
dcaaaaapdccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaah
ccaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
acaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaa
dbaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaacaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaa
abaaaaaaboaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
aaaaaaaacgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.w = _glesVertex.w;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_modelview0 * tmpvar_6);
  vec4 v_8;
  v_8.x = glstate_matrix_modelview0[0].z;
  v_8.y = glstate_matrix_modelview0[1].z;
  v_8.z = glstate_matrix_modelview0[2].z;
  v_8.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_12;
  tmpvar_12.z = 0.0;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = tmpvar_11.y;
  tmpvar_12.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_12.zyw;
  XZv_2.yzw = tmpvar_12.zyw;
  XYv_1.yzw = tmpvar_12.yzw;
  ZYv_3.z = (tmpvar_11.x * sign(-(tmpvar_9.x)));
  XZv_2.x = (tmpvar_11.x * sign(-(tmpvar_9.y)));
  XYv_1.x = (tmpvar_11.x * sign(tmpvar_9.z));
  ZYv_3.x = ((sign(-(tmpvar_9.x)) * sign(ZYv_3.z)) * tmpvar_9.z);
  XZv_2.y = ((sign(-(tmpvar_9.y)) * sign(XZv_2.x)) * tmpvar_9.x);
  XYv_1.z = ((sign(-(tmpvar_9.z)) * sign(XYv_1.x)) * tmpvar_9.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_9.x)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_9.y)) * sign(tmpvar_11.y)) * tmpvar_9.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_9.z)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_13;
  p_13 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((_DistFade * sqrt(dot (p_13, p_13))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_14);
  gl_Position = (glstate_matrix_projection * (tmpvar_7 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_10).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp float atten_5;
  highp vec3 lightDir_6;
  highp vec3 lightColor_7;
  mediump vec4 ztex_8;
  mediump float zval_9;
  mediump vec4 ytex_10;
  mediump float yval_11;
  mediump vec4 xtex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.y;
  yval_11 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = xlv_TEXCOORD0.z;
  zval_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_8 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_12, ytex_10, vec4(yval_11)), ztex_8, vec4(zval_9)));
  lowp vec3 tmpvar_19;
  tmpvar_19 = _LightColor0.xyz;
  lightColor_7 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_20;
  lowp float tmpvar_21;
  mediump float lightShadowDataX_22;
  highp float dist_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  dist_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = _LightShadowData.x;
  lightShadowDataX_22 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = max (float((dist_23 > (xlv_TEXCOORD5.z / xlv_TEXCOORD5.w))), lightShadowDataX_22);
  tmpvar_21 = tmpvar_26;
  atten_5 = tmpvar_21;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = lightDir_6;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (_WorldNorm, tmpvar_27), 0.0, 1.0);
  WNL_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp (((_MinLight + lightColor_7) * clamp ((_LightColor0.w * ((tmpvar_29 * atten_5) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_30;
  color_2.xyz = (tmpvar_18.xyz * baseLight_3);
  color_2.w = tmpvar_18.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.w = _glesVertex.w;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_modelview0 * tmpvar_6);
  vec4 v_8;
  v_8.x = glstate_matrix_modelview0[0].z;
  v_8.y = glstate_matrix_modelview0[1].z;
  v_8.z = glstate_matrix_modelview0[2].z;
  v_8.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_12;
  tmpvar_12.z = 0.0;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = tmpvar_11.y;
  tmpvar_12.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_12.zyw;
  XZv_2.yzw = tmpvar_12.zyw;
  XYv_1.yzw = tmpvar_12.yzw;
  ZYv_3.z = (tmpvar_11.x * sign(-(tmpvar_9.x)));
  XZv_2.x = (tmpvar_11.x * sign(-(tmpvar_9.y)));
  XYv_1.x = (tmpvar_11.x * sign(tmpvar_9.z));
  ZYv_3.x = ((sign(-(tmpvar_9.x)) * sign(ZYv_3.z)) * tmpvar_9.z);
  XZv_2.y = ((sign(-(tmpvar_9.y)) * sign(XZv_2.x)) * tmpvar_9.x);
  XYv_1.z = ((sign(-(tmpvar_9.z)) * sign(XYv_1.x)) * tmpvar_9.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_9.x)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_9.y)) * sign(tmpvar_11.y)) * tmpvar_9.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_9.z)) * sign(tmpvar_11.y)) * tmpvar_9.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_13;
  p_13 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((_DistFade * sqrt(dot (p_13, p_13))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_14);
  gl_Position = (glstate_matrix_projection * (tmpvar_7 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_10).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp float atten_5;
  highp vec3 lightDir_6;
  highp vec3 lightColor_7;
  mediump vec4 ztex_8;
  mediump float zval_9;
  mediump vec4 ytex_10;
  mediump float yval_11;
  mediump vec4 xtex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.y;
  yval_11 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = xlv_TEXCOORD0.z;
  zval_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_8 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_12, ytex_10, vec4(yval_11)), ztex_8, vec4(zval_9)));
  lowp vec3 tmpvar_19;
  tmpvar_19 = _LightColor0.xyz;
  lightColor_7 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  atten_5 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = lightDir_6;
  highp float tmpvar_23;
  tmpvar_23 = clamp (dot (_WorldNorm, tmpvar_22), 0.0, 1.0);
  WNL_4 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_25;
  tmpvar_25 = clamp (((_MinLight + lightColor_7) * clamp ((_LightColor0.w * ((tmpvar_24 * atten_5) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_25;
  color_2.xyz = (tmpvar_18.xyz * baseLight_3);
  color_2.w = tmpvar_18.w;
  tmpvar_1 = color_2;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
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
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec4 _ShadowCoord;
};
#line 411
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 401
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 405
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 409
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 430
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 431
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 434
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 438
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 442
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 446
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 450
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 454
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 458
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    #line 462
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec4 _ShadowCoord;
};
#line 411
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 401
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 405
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 409
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 430
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 465
lowp vec4 frag( in v2f i ) {
    #line 467
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 471
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
    #line 475
    highp vec3 lightColor = _LightColor0.xyz;
    highp vec3 lightDir = vec3( _WorldSpaceLightPos0);
    highp float atten = unitySampleShadow( i._ShadowCoord);
    highp float NL = xll_saturate_f((0.5 * (1.0 + dot( i.projPos, lightDir))));
    #line 479
    highp float lightIntensity = xll_saturate_f((_LightColor0.w * ((NL * atten) * 4.0)));
    highp float lightScatter = xll_saturate_f((1.0 - ((lightIntensity * _LightScatter) * prev.w)));
    mediump float WNL = xll_saturate_f(dot( _WorldNorm, vec4( lightDir, 0.0)));
    mediump float diff = ((WNL - 0.01) / 0.99);
    #line 483
    lightIntensity = xll_saturate_f((_LightColor0.w * ((diff * atten) * 4.0)));
    mediump vec3 baseLight = xll_saturate_vf3(((_MinLight + lightColor) * lightIntensity));
    mediump vec4 color;
    color.xyz = (prev.xyz * baseLight);
    #line 487
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_i.projPos = vec3(xlv_TEXCOORD4);
    xlt_i._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_Object2World]
Float 14 [_DistFade]
"3.0-!!ARBvp1.0
# 94 ALU
PARAM c[16] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[3];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
DP4 R4.x, R2, c[1];
DP4 R4.y, R2, c[2];
MOV R1.w, vertex.position;
DP4 R4.w, R2, c[4];
DP4 R4.z, R2, c[3];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R4.zw, R0.xyxy, -c[0].z;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0].z;
ADD R3.w, R0.x, -R0.y;
SLT R0.z, c[0].x, -R3.x;
SLT R0.w, -R3.x, c[0].x;
ADD R0.w, R0.z, -R0;
MUL R0.z, R4, R0.w;
MUL R1.x, R0.w, R3.w;
SLT R0.y, R0.z, c[0].x;
SLT R0.x, c[0], R0.z;
ADD R0.x, R0, -R0.y;
MUL R0.y, R3, R1.x;
MUL R0.x, R0, R0.w;
MAD R0.x, R3.z, R0, R0.y;
MOV R0.yw, R1;
DP4 R1.x, R0, c[1];
DP4 R1.z, R0, c[2];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[15].x;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[0].w;
SLT R0.y, R1.x, c[0].x;
SLT R0.x, c[0], R1;
ADD R0.z, R0.x, -R0.y;
SLT R0.y, -R3.z, c[0].x;
SLT R0.x, c[0], -R3.z;
ADD R0.x, R0, -R0.y;
MUL R0.w, R3, R0.x;
MUL R0.z, R0.x, R0;
MUL R0.w, R3.y, R0;
MAD R1.z, R3.x, R0, R0.w;
SLT R0.x, c[0], -R3.y;
SLT R0.y, -R3, c[0].x;
ADD R0.y, R0.x, -R0;
MUL R0.x, R4.z, R0.y;
SLT R0.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R0.w;
MUL R0.w, R3, R0.y;
MUL R0.y, R0.z, R0;
MUL R3.w, R3.z, R0;
MOV R0.zw, R1.xyyw;
MAD R0.y, R3.x, R0, R3.w;
DP4 R4.z, R0, c[1];
DP4 R4.w, R0, c[2];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[15].x;
ADD result.texcoord[2].xy, R0, c[0].w;
DP4 R0.z, R1, c[1];
DP4 R0.w, R1, c[2];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[15].x;
ADD result.texcoord[3].xy, R0.zwzw, c[0].w;
DP4 R1.x, R2, c[9];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[13];
DP3 R0.x, R0, R0;
RSQ R0.x, R0.x;
RCP R0.w, R0.x;
DP4 R1.z, R2, c[11];
DP4 R1.y, R2, c[10];
ADD R0.xyz, -R1, c[13];
MUL R1.x, R0.w, c[14];
DP3 R0.w, R0, R0;
MIN R1.x, R1, c[0].z;
RSQ R0.w, R0.w;
MAX R1.x, R1, c[0];
MUL result.texcoord[4].xyz, R0.w, R0;
MUL result.color.w, vertex.color, R1.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 94 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"vs_3_0
; 86 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c14, 0.00000000, 2.00000000, -1.00000000, 0
def c15, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mov r2.w, v0
mov r2.xyz, c14.x
dp4 r4.x, r2, c0
dp4 r4.y, r2, c1
mov r1.w, v0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r0, r4, v0
mad r4.zw, v2.xyxy, c14.y, c14.z
mov r1.y, r4.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r4.w, -r4.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r4.w, r4.w
sub r3.w, r0.y, r0.z
mul r0.z, r4, r0.x
mul r1.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r1
dp4 r1.z, r0, c1
dp4 r1.x, r0, c0
add r0.xy, -r4, r1.xzzw
slt r0.z, r3, -r3
slt r0.w, -r3.z, r3.z
sub r4.w, r0, r0.z
mul r1.x, r4.z, r4.w
mad o3.xy, r0, c15.x, c15.y
slt r0.x, -r1, r1
slt r0.y, r1.x, -r1.x
sub r0.y, r0.x, r0
sub r0.x, r0.z, r0.w
mul r0.z, r0.x, r0.y
mul r0.w, r3, r0.x
mul r0.w, r3.y, r0
mad r1.z, r3.x, r0, r0.w
slt r0.x, r3.y, -r3.y
slt r0.y, -r3, r3
sub r0.y, r0.x, r0
mul r0.x, r4.z, r0.y
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r3, r0.y
mul r0.y, r0.z, r0
mul r3.w, r3.z, r0
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r4, r4.zwzw
mad o4.xy, r0, c15.x, c15.y
dp4 r0.z, r1, c0
dp4 r0.w, r1, c1
add r0.zw, -r4.xyxy, r0
mad o5.xy, r0.zwzw, c15.x, c15.y
dp4 r1.x, r2, c8
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c12
dp3 r0.w, r0, r0
add r0.xyz, -r1, c12
rsq r0.w, r0.w
dp3 r1.x, r0, r0
rcp r0.w, r0.w
rsq r1.x, r1.x
mul_sat r0.w, r0, c13.x
mul o6.xyz, r1.x, r0
mul o1.w, v1, r0
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 240 // 216 used size, 12 vars
Float 212 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 63 instructions, 5 temp regs, 0 temp arrays:
// ALU 44 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedldbeichpohhmoadljmfkadbfgkhfabihabaaaaaahiakaaaaadaaaaaa
cmaaaaaajmaaaaaakaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
pmaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaapcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaapcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaapcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaapcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaapcaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaamapaaaapcaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaapcaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcnaaiaaaaeaaaabaadeacaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaa
fjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaanaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaa
abaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaa
egacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaa
adaaaaaaclaaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaa
aaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaak
dcaabaaaaeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaa
aeaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaa
acaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaa
abaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaai
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaacaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
acaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaacaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
acaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaacaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = _glesVertex.w;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_modelview0 * tmpvar_7);
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_13.zyw;
  XZv_2.yzw = tmpvar_13.zyw;
  XYv_1.yzw = tmpvar_13.yzw;
  ZYv_3.z = (tmpvar_12.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_12.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_12.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_12.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_14;
  p_14 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_15);
  gl_Position = (glstate_matrix_projection * (tmpvar_8 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp float atten_5;
  highp vec3 lightDir_6;
  highp vec3 lightColor_7;
  mediump vec4 ztex_8;
  mediump float zval_9;
  mediump vec4 ytex_10;
  mediump float yval_11;
  mediump vec4 xtex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.y;
  yval_11 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = xlv_TEXCOORD0.z;
  zval_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_8 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_12, ytex_10, vec4(yval_11)), ztex_8, vec4(zval_9)));
  lowp vec3 tmpvar_19;
  tmpvar_19 = _LightColor0.xyz;
  lightColor_7 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_20;
  lowp float tmpvar_21;
  mediump float lightShadowDataX_22;
  highp float dist_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x;
  dist_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = _LightShadowData.x;
  lightShadowDataX_22 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = max (float((dist_23 > (xlv_TEXCOORD6.z / xlv_TEXCOORD6.w))), lightShadowDataX_22);
  tmpvar_21 = tmpvar_26;
  lowp float tmpvar_27;
  tmpvar_27 = (texture2D (_LightTexture0, xlv_TEXCOORD5).w * tmpvar_21);
  atten_5 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.xyz = lightDir_6;
  highp float tmpvar_29;
  tmpvar_29 = clamp (dot (_WorldNorm, tmpvar_28), 0.0, 1.0);
  WNL_4 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_31;
  tmpvar_31 = clamp (((_MinLight + lightColor_7) * clamp ((_LightColor0.w * ((tmpvar_30 * atten_5) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_31;
  color_2.xyz = (tmpvar_18.xyz * baseLight_3);
  color_2.w = tmpvar_18.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = _glesVertex.w;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_modelview0 * tmpvar_7);
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_13.zyw;
  XZv_2.yzw = tmpvar_13.zyw;
  XYv_1.yzw = tmpvar_13.yzw;
  ZYv_3.z = (tmpvar_12.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_12.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_12.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_12.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_14;
  p_14 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_15);
  gl_Position = (glstate_matrix_projection * (tmpvar_8 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp float atten_5;
  highp vec3 lightDir_6;
  highp vec3 lightColor_7;
  mediump vec4 ztex_8;
  mediump float zval_9;
  mediump vec4 ytex_10;
  mediump float yval_11;
  mediump vec4 xtex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.y;
  yval_11 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = xlv_TEXCOORD0.z;
  zval_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_8 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_12, ytex_10, vec4(yval_11)), ztex_8, vec4(zval_9)));
  lowp vec3 tmpvar_19;
  tmpvar_19 = _LightColor0.xyz;
  lightColor_7 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = (texture2D (_LightTexture0, xlv_TEXCOORD5).w * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x);
  atten_5 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = lightDir_6;
  highp float tmpvar_23;
  tmpvar_23 = clamp (dot (_WorldNorm, tmpvar_22), 0.0, 1.0);
  WNL_4 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_25;
  tmpvar_25 = clamp (((_MinLight + lightColor_7) * clamp ((_LightColor0.w * ((tmpvar_24 * atten_5) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_25;
  color_2.xyz = (tmpvar_18.xyz * baseLight_3);
  color_2.w = tmpvar_18.w;
  tmpvar_1 = color_2;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
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
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec2 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 413
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 403
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 407
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 411
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 433
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 434
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 437
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 441
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 445
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 449
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 453
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 457
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 461
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    #line 465
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec2(xl_retval._LightCoord);
    xlv_TEXCOORD6 = vec4(xl_retval._ShadowCoord);
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec2 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 413
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 403
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 407
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 411
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 433
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 468
lowp vec4 frag( in v2f i ) {
    #line 470
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 474
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
    #line 478
    highp vec3 lightColor = _LightColor0.xyz;
    highp vec3 lightDir = vec3( _WorldSpaceLightPos0);
    highp float atten = (texture( _LightTexture0, i._LightCoord).w * unitySampleShadow( i._ShadowCoord));
    highp float NL = xll_saturate_f((0.5 * (1.0 + dot( i.projPos, lightDir))));
    #line 482
    highp float lightIntensity = xll_saturate_f((_LightColor0.w * ((NL * atten) * 4.0)));
    highp float lightScatter = xll_saturate_f((1.0 - ((lightIntensity * _LightScatter) * prev.w)));
    mediump float WNL = xll_saturate_f(dot( _WorldNorm, vec4( lightDir, 0.0)));
    mediump float diff = ((WNL - 0.01) / 0.99);
    #line 486
    lightIntensity = xll_saturate_f((_LightColor0.w * ((diff * atten) * 4.0)));
    mediump vec3 baseLight = xll_saturate_vf3(((_MinLight + lightColor) * lightIntensity));
    mediump vec4 color;
    color.xyz = (prev.xyz * baseLight);
    #line 490
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_i.projPos = vec3(xlv_TEXCOORD4);
    xlt_i._LightCoord = vec2(xlv_TEXCOORD5);
    xlt_i._ShadowCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_Object2World]
Float 14 [_DistFade]
"3.0-!!ARBvp1.0
# 94 ALU
PARAM c[16] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[3];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
DP4 R4.x, R2, c[1];
DP4 R4.y, R2, c[2];
MOV R1.w, vertex.position;
DP4 R4.w, R2, c[4];
DP4 R4.z, R2, c[3];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R4.zw, R0.xyxy, -c[0].z;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0].z;
ADD R3.w, R0.x, -R0.y;
SLT R0.z, c[0].x, -R3.x;
SLT R0.w, -R3.x, c[0].x;
ADD R0.w, R0.z, -R0;
MUL R0.z, R4, R0.w;
MUL R1.x, R0.w, R3.w;
SLT R0.y, R0.z, c[0].x;
SLT R0.x, c[0], R0.z;
ADD R0.x, R0, -R0.y;
MUL R0.y, R3, R1.x;
MUL R0.x, R0, R0.w;
MAD R0.x, R3.z, R0, R0.y;
MOV R0.yw, R1;
DP4 R1.x, R0, c[1];
DP4 R1.z, R0, c[2];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[15].x;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[0].w;
SLT R0.y, R1.x, c[0].x;
SLT R0.x, c[0], R1;
ADD R0.z, R0.x, -R0.y;
SLT R0.y, -R3.z, c[0].x;
SLT R0.x, c[0], -R3.z;
ADD R0.x, R0, -R0.y;
MUL R0.w, R3, R0.x;
MUL R0.z, R0.x, R0;
MUL R0.w, R3.y, R0;
MAD R1.z, R3.x, R0, R0.w;
SLT R0.x, c[0], -R3.y;
SLT R0.y, -R3, c[0].x;
ADD R0.y, R0.x, -R0;
MUL R0.x, R4.z, R0.y;
SLT R0.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R0.w;
MUL R0.w, R3, R0.y;
MUL R0.y, R0.z, R0;
MUL R3.w, R3.z, R0;
MOV R0.zw, R1.xyyw;
MAD R0.y, R3.x, R0, R3.w;
DP4 R4.z, R0, c[1];
DP4 R4.w, R0, c[2];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[15].x;
ADD result.texcoord[2].xy, R0, c[0].w;
DP4 R0.z, R1, c[1];
DP4 R0.w, R1, c[2];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[15].x;
ADD result.texcoord[3].xy, R0.zwzw, c[0].w;
DP4 R1.x, R2, c[9];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[13];
DP3 R0.x, R0, R0;
RSQ R0.x, R0.x;
RCP R0.w, R0.x;
DP4 R1.z, R2, c[11];
DP4 R1.y, R2, c[10];
ADD R0.xyz, -R1, c[13];
MUL R1.x, R0.w, c[14];
DP3 R0.w, R0, R0;
MIN R1.x, R1, c[0].z;
RSQ R0.w, R0.w;
MAX R1.x, R1, c[0];
MUL result.texcoord[4].xyz, R0.w, R0;
MUL result.color.w, vertex.color, R1.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 94 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"vs_3_0
; 86 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c14, 0.00000000, 2.00000000, -1.00000000, 0
def c15, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mov r2.w, v0
mov r2.xyz, c14.x
dp4 r4.x, r2, c0
dp4 r4.y, r2, c1
mov r1.w, v0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r0, r4, v0
mad r4.zw, v2.xyxy, c14.y, c14.z
mov r1.y, r4.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r4.w, -r4.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r4.w, r4.w
sub r3.w, r0.y, r0.z
mul r0.z, r4, r0.x
mul r1.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r1
dp4 r1.z, r0, c1
dp4 r1.x, r0, c0
add r0.xy, -r4, r1.xzzw
slt r0.z, r3, -r3
slt r0.w, -r3.z, r3.z
sub r4.w, r0, r0.z
mul r1.x, r4.z, r4.w
mad o3.xy, r0, c15.x, c15.y
slt r0.x, -r1, r1
slt r0.y, r1.x, -r1.x
sub r0.y, r0.x, r0
sub r0.x, r0.z, r0.w
mul r0.z, r0.x, r0.y
mul r0.w, r3, r0.x
mul r0.w, r3.y, r0
mad r1.z, r3.x, r0, r0.w
slt r0.x, r3.y, -r3.y
slt r0.y, -r3, r3
sub r0.y, r0.x, r0
mul r0.x, r4.z, r0.y
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r3, r0.y
mul r0.y, r0.z, r0
mul r3.w, r3.z, r0
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r4, r4.zwzw
mad o4.xy, r0, c15.x, c15.y
dp4 r0.z, r1, c0
dp4 r0.w, r1, c1
add r0.zw, -r4.xyxy, r0
mad o5.xy, r0.zwzw, c15.x, c15.y
dp4 r1.x, r2, c8
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c12
dp3 r0.w, r0, r0
add r0.xyz, -r1, c12
rsq r0.w, r0.w
dp3 r1.x, r0, r0
rcp r0.w, r0.w
rsq r1.x, r1.x
mul_sat r0.w, r0, c13.x
mul o6.xyz, r1.x, r0
mul o1.w, v1, r0
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176 // 152 used size, 11 vars
Float 148 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 63 instructions, 5 temp regs, 0 temp arrays:
// ALU 44 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddbbdfgneahodhanbfeccgcpfmeamgdhiabaaaaaahiakaaaaadaaaaaa
cmaaaaaajmaaaaaakaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
pmaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaapcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaapcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaapcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaapcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaapcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaapcaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaapcaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcnaaiaaaaeaaaabaadeacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaa
fjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaajaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaa
abaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaa
egacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaa
adaaaaaaclaaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaa
aaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaak
dcaabaaaaeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaa
aeaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaa
acaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaa
abaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaai
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaacaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
acaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaacaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
acaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaacaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = _glesVertex.w;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_modelview0 * tmpvar_7);
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_13.zyw;
  XZv_2.yzw = tmpvar_13.zyw;
  XYv_1.yzw = tmpvar_13.yzw;
  ZYv_3.z = (tmpvar_12.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_12.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_12.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_12.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_14;
  p_14 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_15);
  gl_Position = (glstate_matrix_projection * (tmpvar_8 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightColor_5;
  mediump vec4 ztex_6;
  mediump float zval_7;
  mediump vec4 ytex_8;
  mediump float yval_9;
  mediump vec4 xtex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.y;
  yval_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.z;
  zval_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_10, ytex_8, vec4(yval_9)), ztex_6, vec4(zval_7)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  lightColor_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_LightTexture0, vec2(tmpvar_19));
  highp float tmpvar_21;
  tmpvar_21 = ((sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = textureCube (_ShadowMapTexture, xlv_TEXCOORD6);
  packDist_22 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (packDist_22, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_25;
  if ((tmpvar_24 < tmpvar_21)) {
    tmpvar_25 = _LightShadowData.x;
  } else {
    tmpvar_25 = 1.0;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.w = 0.0;
  tmpvar_26.xyz = tmpvar_18;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (_WorldNorm, tmpvar_26), 0.0, 1.0);
  WNL_4 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp (((_MinLight + lightColor_5) * clamp ((_LightColor0.w * ((tmpvar_28 * (tmpvar_20.w * tmpvar_25)) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_29;
  color_2.xyz = (tmpvar_16.xyz * baseLight_3);
  color_2.w = tmpvar_16.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = _glesVertex.w;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_modelview0 * tmpvar_7);
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_13.zyw;
  XZv_2.yzw = tmpvar_13.zyw;
  XYv_1.yzw = tmpvar_13.yzw;
  ZYv_3.z = (tmpvar_12.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_12.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_12.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_12.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_14;
  p_14 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_15);
  gl_Position = (glstate_matrix_projection * (tmpvar_8 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightColor_5;
  mediump vec4 ztex_6;
  mediump float zval_7;
  mediump vec4 ytex_8;
  mediump float yval_9;
  mediump vec4 xtex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.y;
  yval_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.z;
  zval_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_10, ytex_8, vec4(yval_9)), ztex_6, vec4(zval_7)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  lightColor_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_LightTexture0, vec2(tmpvar_19));
  highp float tmpvar_21;
  tmpvar_21 = ((sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = textureCube (_ShadowMapTexture, xlv_TEXCOORD6);
  packDist_22 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (packDist_22, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_25;
  if ((tmpvar_24 < tmpvar_21)) {
    tmpvar_25 = _LightShadowData.x;
  } else {
    tmpvar_25 = 1.0;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.w = 0.0;
  tmpvar_26.xyz = tmpvar_18;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (_WorldNorm, tmpvar_26), 0.0, 1.0);
  WNL_4 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_29;
  tmpvar_29 = clamp (((_MinLight + lightColor_5) * clamp ((_LightColor0.w * ((tmpvar_28 * (tmpvar_20.w * tmpvar_25)) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_29;
  color_2.xyz = (tmpvar_16.xyz * baseLight_3);
  color_2.w = tmpvar_16.w;
  tmpvar_1 = color_2;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
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
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 418
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 408
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 412
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 416
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 438
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 439
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 442
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 446
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 450
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 454
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 458
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 462
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 466
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    #line 470
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD6 = vec3(xl_retval._ShadowCoord);
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 418
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 408
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 412
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 416
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 438
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 316
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 319
    return DecodeFloatRGBA( packDist);
}
#line 321
highp float unityCubeShadow( in highp vec3 vec ) {
    #line 323
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    highp float dist = SampleCubeDistance( vec);
    return (( (dist < mydist) ) ? ( _LightShadowData.x ) : ( 1.0 ));
}
#line 473
lowp vec4 frag( in v2f i ) {
    #line 475
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 479
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
    #line 483
    highp vec3 lightColor = _LightColor0.xyz;
    highp vec3 lightDir = vec3( _WorldSpaceLightPos0);
    highp float atten = (texture( _LightTexture0, vec2( dot( i._LightCoord, i._LightCoord))).w * unityCubeShadow( i._ShadowCoord));
    highp float NL = xll_saturate_f((0.5 * (1.0 + dot( i.projPos, lightDir))));
    #line 487
    highp float lightIntensity = xll_saturate_f((_LightColor0.w * ((NL * atten) * 4.0)));
    highp float lightScatter = xll_saturate_f((1.0 - ((lightIntensity * _LightScatter) * prev.w)));
    mediump float WNL = xll_saturate_f(dot( _WorldNorm, vec4( lightDir, 0.0)));
    mediump float diff = ((WNL - 0.01) / 0.99);
    #line 491
    lightIntensity = xll_saturate_f((_LightColor0.w * ((diff * atten) * 4.0)));
    mediump vec3 baseLight = xll_saturate_vf3(((_MinLight + lightColor) * lightIntensity));
    mediump vec4 color;
    color.xyz = (prev.xyz * baseLight);
    #line 495
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_i.projPos = vec3(xlv_TEXCOORD4);
    xlt_i._LightCoord = vec3(xlv_TEXCOORD5);
    xlt_i._ShadowCoord = vec3(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_Object2World]
Float 14 [_DistFade]
"3.0-!!ARBvp1.0
# 94 ALU
PARAM c[16] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[3];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
DP4 R4.x, R2, c[1];
DP4 R4.y, R2, c[2];
MOV R1.w, vertex.position;
DP4 R4.w, R2, c[4];
DP4 R4.z, R2, c[3];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R4.zw, R0.xyxy, -c[0].z;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0].z;
ADD R3.w, R0.x, -R0.y;
SLT R0.z, c[0].x, -R3.x;
SLT R0.w, -R3.x, c[0].x;
ADD R0.w, R0.z, -R0;
MUL R0.z, R4, R0.w;
MUL R1.x, R0.w, R3.w;
SLT R0.y, R0.z, c[0].x;
SLT R0.x, c[0], R0.z;
ADD R0.x, R0, -R0.y;
MUL R0.y, R3, R1.x;
MUL R0.x, R0, R0.w;
MAD R0.x, R3.z, R0, R0.y;
MOV R0.yw, R1;
DP4 R1.x, R0, c[1];
DP4 R1.z, R0, c[2];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[15].x;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[0].w;
SLT R0.y, R1.x, c[0].x;
SLT R0.x, c[0], R1;
ADD R0.z, R0.x, -R0.y;
SLT R0.y, -R3.z, c[0].x;
SLT R0.x, c[0], -R3.z;
ADD R0.x, R0, -R0.y;
MUL R0.w, R3, R0.x;
MUL R0.z, R0.x, R0;
MUL R0.w, R3.y, R0;
MAD R1.z, R3.x, R0, R0.w;
SLT R0.x, c[0], -R3.y;
SLT R0.y, -R3, c[0].x;
ADD R0.y, R0.x, -R0;
MUL R0.x, R4.z, R0.y;
SLT R0.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R0.w;
MUL R0.w, R3, R0.y;
MUL R0.y, R0.z, R0;
MUL R3.w, R3.z, R0;
MOV R0.zw, R1.xyyw;
MAD R0.y, R3.x, R0, R3.w;
DP4 R4.z, R0, c[1];
DP4 R4.w, R0, c[2];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[15].x;
ADD result.texcoord[2].xy, R0, c[0].w;
DP4 R0.z, R1, c[1];
DP4 R0.w, R1, c[2];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[15].x;
ADD result.texcoord[3].xy, R0.zwzw, c[0].w;
DP4 R1.x, R2, c[9];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[13];
DP3 R0.x, R0, R0;
RSQ R0.x, R0.x;
RCP R0.w, R0.x;
DP4 R1.z, R2, c[11];
DP4 R1.y, R2, c[10];
ADD R0.xyz, -R1, c[13];
MUL R1.x, R0.w, c[14];
DP3 R0.w, R0, R0;
MIN R1.x, R1, c[0].z;
RSQ R0.w, R0.w;
MAX R1.x, R1, c[0];
MUL result.texcoord[4].xyz, R0.w, R0;
MUL result.color.w, vertex.color, R1.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 94 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"vs_3_0
; 86 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c14, 0.00000000, 2.00000000, -1.00000000, 0
def c15, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mov r2.w, v0
mov r2.xyz, c14.x
dp4 r4.x, r2, c0
dp4 r4.y, r2, c1
mov r1.w, v0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r0, r4, v0
mad r4.zw, v2.xyxy, c14.y, c14.z
mov r1.y, r4.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r4.w, -r4.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r4.w, r4.w
sub r3.w, r0.y, r0.z
mul r0.z, r4, r0.x
mul r1.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r1
dp4 r1.z, r0, c1
dp4 r1.x, r0, c0
add r0.xy, -r4, r1.xzzw
slt r0.z, r3, -r3
slt r0.w, -r3.z, r3.z
sub r4.w, r0, r0.z
mul r1.x, r4.z, r4.w
mad o3.xy, r0, c15.x, c15.y
slt r0.x, -r1, r1
slt r0.y, r1.x, -r1.x
sub r0.y, r0.x, r0
sub r0.x, r0.z, r0.w
mul r0.z, r0.x, r0.y
mul r0.w, r3, r0.x
mul r0.w, r3.y, r0
mad r1.z, r3.x, r0, r0.w
slt r0.x, r3.y, -r3.y
slt r0.y, -r3, r3
sub r0.y, r0.x, r0
mul r0.x, r4.z, r0.y
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r3, r0.y
mul r0.y, r0.z, r0
mul r3.w, r3.z, r0
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r4, r4.zwzw
mad o4.xy, r0, c15.x, c15.y
dp4 r0.z, r1, c0
dp4 r0.w, r1, c1
add r0.zw, -r4.xyxy, r0
mad o5.xy, r0.zwzw, c15.x, c15.y
dp4 r1.x, r2, c8
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c12
dp3 r0.w, r0, r0
add r0.xyz, -r1, c12
rsq r0.w, r0.w
dp3 r1.x, r0, r0
rcp r0.w, r0.w
rsq r1.x, r1.x
mul_sat r0.w, r0, c13.x
mul o6.xyz, r1.x, r0
mul o1.w, v1, r0
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176 // 152 used size, 11 vars
Float 148 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 63 instructions, 5 temp regs, 0 temp arrays:
// ALU 44 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddbbdfgneahodhanbfeccgcpfmeamgdhiabaaaaaahiakaaaaadaaaaaa
cmaaaaaajmaaaaaakaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
pmaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaapcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaapcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaapcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaapcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaapcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaapcaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaapcaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcnaaiaaaaeaaaabaadeacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaa
fjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaajaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaa
abaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaa
egacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaa
adaaaaaaclaaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaa
aaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaak
dcaabaaaaeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaa
aeaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaa
acaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaa
abaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaai
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaacaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
acaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaacaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
acaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaacaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = _glesVertex.w;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_modelview0 * tmpvar_7);
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_13.zyw;
  XZv_2.yzw = tmpvar_13.zyw;
  XYv_1.yzw = tmpvar_13.yzw;
  ZYv_3.z = (tmpvar_12.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_12.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_12.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_12.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_14;
  p_14 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_15);
  gl_Position = (glstate_matrix_projection * (tmpvar_8 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightColor_5;
  mediump vec4 ztex_6;
  mediump float zval_7;
  mediump vec4 ytex_8;
  mediump float yval_9;
  mediump vec4 xtex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.y;
  yval_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.z;
  zval_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_10, ytex_8, vec4(yval_9)), ztex_6, vec4(zval_7)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  lightColor_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_LightTextureB0, vec2(tmpvar_19));
  lowp vec4 tmpvar_21;
  tmpvar_21 = textureCube (_LightTexture0, xlv_TEXCOORD5);
  highp float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_ShadowMapTexture, xlv_TEXCOORD6);
  packDist_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (packDist_23, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_26;
  if ((tmpvar_25 < tmpvar_22)) {
    tmpvar_26 = _LightShadowData.x;
  } else {
    tmpvar_26 = 1.0;
  };
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = tmpvar_18;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (_WorldNorm, tmpvar_27), 0.0, 1.0);
  WNL_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp (((_MinLight + lightColor_5) * clamp ((_LightColor0.w * ((tmpvar_29 * ((tmpvar_20.w * tmpvar_21.w) * tmpvar_26)) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_30;
  color_2.xyz = (tmpvar_16.xyz * baseLight_3);
  color_2.w = tmpvar_16.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = _glesVertex.w;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_modelview0 * tmpvar_7);
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_13.zyw;
  XZv_2.yzw = tmpvar_13.zyw;
  XYv_1.yzw = tmpvar_13.yzw;
  ZYv_3.z = (tmpvar_12.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_12.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_12.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_12.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_14;
  p_14 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_15);
  gl_Position = (glstate_matrix_projection * (tmpvar_8 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightColor_5;
  mediump vec4 ztex_6;
  mediump float zval_7;
  mediump vec4 ytex_8;
  mediump float yval_9;
  mediump vec4 xtex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.y;
  yval_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.z;
  zval_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_10, ytex_8, vec4(yval_9)), ztex_6, vec4(zval_7)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  lightColor_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_LightTextureB0, vec2(tmpvar_19));
  lowp vec4 tmpvar_21;
  tmpvar_21 = textureCube (_LightTexture0, xlv_TEXCOORD5);
  highp float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = textureCube (_ShadowMapTexture, xlv_TEXCOORD6);
  packDist_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (packDist_23, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_26;
  if ((tmpvar_25 < tmpvar_22)) {
    tmpvar_26 = _LightShadowData.x;
  } else {
    tmpvar_26 = 1.0;
  };
  highp vec4 tmpvar_27;
  tmpvar_27.w = 0.0;
  tmpvar_27.xyz = tmpvar_18;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (_WorldNorm, tmpvar_27), 0.0, 1.0);
  WNL_4 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_30;
  tmpvar_30 = clamp (((_MinLight + lightColor_5) * clamp ((_LightColor0.w * ((tmpvar_29 * ((tmpvar_20.w * tmpvar_21.w) * tmpvar_26)) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_30;
  color_2.xyz = (tmpvar_16.xyz * baseLight_3);
  color_2.w = tmpvar_16.w;
  tmpvar_1 = color_2;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
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
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 419
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 409
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 413
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 417
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 439
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 440
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 443
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 447
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 451
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 455
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 459
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 463
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 467
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    #line 471
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD6 = vec3(xl_retval._ShadowCoord);
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 419
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 409
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 413
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 417
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 439
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 316
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 319
    return DecodeFloatRGBA( packDist);
}
#line 321
highp float unityCubeShadow( in highp vec3 vec ) {
    #line 323
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    highp float dist = SampleCubeDistance( vec);
    return (( (dist < mydist) ) ? ( _LightShadowData.x ) : ( 1.0 ));
}
#line 474
lowp vec4 frag( in v2f i ) {
    #line 476
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 480
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
    #line 484
    highp vec3 lightColor = _LightColor0.xyz;
    highp vec3 lightDir = vec3( _WorldSpaceLightPos0);
    highp float atten = ((texture( _LightTextureB0, vec2( dot( i._LightCoord, i._LightCoord))).w * texture( _LightTexture0, i._LightCoord).w) * unityCubeShadow( i._ShadowCoord));
    highp float NL = xll_saturate_f((0.5 * (1.0 + dot( i.projPos, lightDir))));
    #line 488
    highp float lightIntensity = xll_saturate_f((_LightColor0.w * ((NL * atten) * 4.0)));
    highp float lightScatter = xll_saturate_f((1.0 - ((lightIntensity * _LightScatter) * prev.w)));
    mediump float WNL = xll_saturate_f(dot( _WorldNorm, vec4( lightDir, 0.0)));
    mediump float diff = ((WNL - 0.01) / 0.99);
    #line 492
    lightIntensity = xll_saturate_f((_LightColor0.w * ((diff * atten) * 4.0)));
    mediump vec3 baseLight = xll_saturate_vf3(((_MinLight + lightColor) * lightIntensity));
    mediump vec4 color;
    color.xyz = (prev.xyz * baseLight);
    #line 496
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_i.projPos = vec3(xlv_TEXCOORD4);
    xlt_i._LightCoord = vec3(xlv_TEXCOORD5);
    xlt_i._ShadowCoord = vec3(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_Object2World]
Float 14 [_DistFade]
"3.0-!!ARBvp1.0
# 94 ALU
PARAM c[16] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[3];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
DP4 R4.x, R2, c[1];
DP4 R4.y, R2, c[2];
MOV R1.w, vertex.position;
DP4 R4.w, R2, c[4];
DP4 R4.z, R2, c[3];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R4.zw, R0.xyxy, -c[0].z;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0].z;
ADD R3.w, R0.x, -R0.y;
SLT R0.z, c[0].x, -R3.x;
SLT R0.w, -R3.x, c[0].x;
ADD R0.w, R0.z, -R0;
MUL R0.z, R4, R0.w;
MUL R1.x, R0.w, R3.w;
SLT R0.y, R0.z, c[0].x;
SLT R0.x, c[0], R0.z;
ADD R0.x, R0, -R0.y;
MUL R0.y, R3, R1.x;
MUL R0.x, R0, R0.w;
MAD R0.x, R3.z, R0, R0.y;
MOV R0.yw, R1;
DP4 R1.x, R0, c[1];
DP4 R1.z, R0, c[2];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[15].x;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[0].w;
SLT R0.y, R1.x, c[0].x;
SLT R0.x, c[0], R1;
ADD R0.z, R0.x, -R0.y;
SLT R0.y, -R3.z, c[0].x;
SLT R0.x, c[0], -R3.z;
ADD R0.x, R0, -R0.y;
MUL R0.w, R3, R0.x;
MUL R0.z, R0.x, R0;
MUL R0.w, R3.y, R0;
MAD R1.z, R3.x, R0, R0.w;
SLT R0.x, c[0], -R3.y;
SLT R0.y, -R3, c[0].x;
ADD R0.y, R0.x, -R0;
MUL R0.x, R4.z, R0.y;
SLT R0.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R0.w;
MUL R0.w, R3, R0.y;
MUL R0.y, R0.z, R0;
MUL R3.w, R3.z, R0;
MOV R0.zw, R1.xyyw;
MAD R0.y, R3.x, R0, R3.w;
DP4 R4.z, R0, c[1];
DP4 R4.w, R0, c[2];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[15].x;
ADD result.texcoord[2].xy, R0, c[0].w;
DP4 R0.z, R1, c[1];
DP4 R0.w, R1, c[2];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[15].x;
ADD result.texcoord[3].xy, R0.zwzw, c[0].w;
DP4 R1.x, R2, c[9];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[13];
DP3 R0.x, R0, R0;
RSQ R0.x, R0.x;
RCP R0.w, R0.x;
DP4 R1.z, R2, c[11];
DP4 R1.y, R2, c[10];
ADD R0.xyz, -R1, c[13];
MUL R1.x, R0.w, c[14];
DP3 R0.w, R0, R0;
MIN R1.x, R1, c[0].z;
RSQ R0.w, R0.w;
MAX R1.x, R1, c[0];
MUL result.texcoord[4].xyz, R0.w, R0;
MUL result.color.w, vertex.color, R1.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 94 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"vs_3_0
; 86 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c14, 0.00000000, 2.00000000, -1.00000000, 0
def c15, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mov r2.w, v0
mov r2.xyz, c14.x
dp4 r4.x, r2, c0
dp4 r4.y, r2, c1
mov r1.w, v0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r0, r4, v0
mad r4.zw, v2.xyxy, c14.y, c14.z
mov r1.y, r4.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r4.w, -r4.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r4.w, r4.w
sub r3.w, r0.y, r0.z
mul r0.z, r4, r0.x
mul r1.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r1
dp4 r1.z, r0, c1
dp4 r1.x, r0, c0
add r0.xy, -r4, r1.xzzw
slt r0.z, r3, -r3
slt r0.w, -r3.z, r3.z
sub r4.w, r0, r0.z
mul r1.x, r4.z, r4.w
mad o3.xy, r0, c15.x, c15.y
slt r0.x, -r1, r1
slt r0.y, r1.x, -r1.x
sub r0.y, r0.x, r0
sub r0.x, r0.z, r0.w
mul r0.z, r0.x, r0.y
mul r0.w, r3, r0.x
mul r0.w, r3.y, r0
mad r1.z, r3.x, r0, r0.w
slt r0.x, r3.y, -r3.y
slt r0.y, -r3, r3
sub r0.y, r0.x, r0
mul r0.x, r4.z, r0.y
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r3, r0.y
mul r0.y, r0.z, r0
mul r3.w, r3.z, r0
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r4, r4.zwzw
mad o4.xy, r0, c15.x, c15.y
dp4 r0.z, r1, c0
dp4 r0.w, r1, c1
add r0.zw, -r4.xyxy, r0
mad o5.xy, r0.zwzw, c15.x, c15.y
dp4 r1.x, r2, c8
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c12
dp3 r0.w, r0, r0
add r0.xyz, -r1, c12
rsq r0.w, r0.w
dp3 r1.x, r0, r0
rcp r0.w, r0.w
rsq r1.x, r1.x
mul_sat r0.w, r0, c13.x
mul o6.xyz, r1.x, r0
mul o1.w, v1, r0
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 240 // 216 used size, 12 vars
Float 212 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 63 instructions, 5 temp regs, 0 temp arrays:
// ALU 44 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbebenelpclgcdealmoejgjnpgeoncfghabaaaaaahiakaaaaadaaaaaa
cmaaaaaajmaaaaaakaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
pmaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaapcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaapcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaapcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaapcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaapcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaapcaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaapcaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcnaaiaaaaeaaaabaadeacaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaa
fjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaanaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaa
abaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaa
egacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaa
adaaaaaaclaaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaa
aaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaak
dcaabaaaaeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaa
aeaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaa
acaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaa
abaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaai
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaacaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
acaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaacaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
acaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaacaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = _glesVertex.w;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_modelview0 * tmpvar_7);
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_13.zyw;
  XZv_2.yzw = tmpvar_13.zyw;
  XYv_1.yzw = tmpvar_13.yzw;
  ZYv_3.z = (tmpvar_12.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_12.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_12.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_12.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_14;
  p_14 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_15);
  gl_Position = (glstate_matrix_projection * (tmpvar_8 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightColor_5;
  mediump vec4 ztex_6;
  mediump float zval_7;
  mediump vec4 ytex_8;
  mediump float yval_9;
  mediump vec4 xtex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.y;
  yval_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.z;
  zval_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_10, ytex_8, vec4(yval_9)), ztex_6, vec4(zval_7)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  lightColor_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) + 0.5);
  tmpvar_19 = texture2D (_LightTexture0, P_20);
  highp float tmpvar_21;
  tmpvar_21 = dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_LightTextureB0, vec2(tmpvar_21));
  lowp float tmpvar_23;
  mediump vec4 shadows_24;
  highp vec4 shadowVals_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD6.xyz / xlv_TEXCOORD6.w);
  highp vec2 P_27;
  P_27 = (tmpvar_26.xy + _ShadowOffsets[0].xy);
  lowp float tmpvar_28;
  tmpvar_28 = texture2D (_ShadowMapTexture, P_27).x;
  shadowVals_25.x = tmpvar_28;
  highp vec2 P_29;
  P_29 = (tmpvar_26.xy + _ShadowOffsets[1].xy);
  lowp float tmpvar_30;
  tmpvar_30 = texture2D (_ShadowMapTexture, P_29).x;
  shadowVals_25.y = tmpvar_30;
  highp vec2 P_31;
  P_31 = (tmpvar_26.xy + _ShadowOffsets[2].xy);
  lowp float tmpvar_32;
  tmpvar_32 = texture2D (_ShadowMapTexture, P_31).x;
  shadowVals_25.z = tmpvar_32;
  highp vec2 P_33;
  P_33 = (tmpvar_26.xy + _ShadowOffsets[3].xy);
  lowp float tmpvar_34;
  tmpvar_34 = texture2D (_ShadowMapTexture, P_33).x;
  shadowVals_25.w = tmpvar_34;
  bvec4 tmpvar_35;
  tmpvar_35 = lessThan (shadowVals_25, tmpvar_26.zzzz);
  highp vec4 tmpvar_36;
  tmpvar_36 = _LightShadowData.xxxx;
  highp float tmpvar_37;
  if (tmpvar_35.x) {
    tmpvar_37 = tmpvar_36.x;
  } else {
    tmpvar_37 = 1.0;
  };
  highp float tmpvar_38;
  if (tmpvar_35.y) {
    tmpvar_38 = tmpvar_36.y;
  } else {
    tmpvar_38 = 1.0;
  };
  highp float tmpvar_39;
  if (tmpvar_35.z) {
    tmpvar_39 = tmpvar_36.z;
  } else {
    tmpvar_39 = 1.0;
  };
  highp float tmpvar_40;
  if (tmpvar_35.w) {
    tmpvar_40 = tmpvar_36.w;
  } else {
    tmpvar_40 = 1.0;
  };
  highp vec4 tmpvar_41;
  tmpvar_41.x = tmpvar_37;
  tmpvar_41.y = tmpvar_38;
  tmpvar_41.z = tmpvar_39;
  tmpvar_41.w = tmpvar_40;
  shadows_24 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = dot (shadows_24, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_23 = tmpvar_42;
  highp vec4 tmpvar_43;
  tmpvar_43.w = 0.0;
  tmpvar_43.xyz = tmpvar_18;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (_WorldNorm, tmpvar_43), 0.0, 1.0);
  WNL_4 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp (((_MinLight + lightColor_5) * clamp ((_LightColor0.w * ((tmpvar_45 * (((float((xlv_TEXCOORD5.z > 0.0)) * tmpvar_19.w) * tmpvar_22.w) * tmpvar_23)) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_46;
  color_2.xyz = (tmpvar_16.xyz * baseLight_3);
  color_2.w = tmpvar_16.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = _glesVertex.w;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_modelview0 * tmpvar_7);
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_13.zyw;
  XZv_2.yzw = tmpvar_13.zyw;
  XYv_1.yzw = tmpvar_13.yzw;
  ZYv_3.z = (tmpvar_12.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_12.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_12.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_12.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_14;
  p_14 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_15);
  gl_Position = (glstate_matrix_projection * (tmpvar_8 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightColor_5;
  mediump vec4 ztex_6;
  mediump float zval_7;
  mediump vec4 ytex_8;
  mediump float yval_9;
  mediump vec4 xtex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.y;
  yval_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.z;
  zval_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_10, ytex_8, vec4(yval_9)), ztex_6, vec4(zval_7)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  lightColor_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) + 0.5);
  tmpvar_19 = texture2D (_LightTexture0, P_20);
  highp float tmpvar_21;
  tmpvar_21 = dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_LightTextureB0, vec2(tmpvar_21));
  lowp float tmpvar_23;
  mediump vec4 shadows_24;
  highp vec4 shadowVals_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD6.xyz / xlv_TEXCOORD6.w);
  highp vec2 P_27;
  P_27 = (tmpvar_26.xy + _ShadowOffsets[0].xy);
  lowp float tmpvar_28;
  tmpvar_28 = texture2D (_ShadowMapTexture, P_27).x;
  shadowVals_25.x = tmpvar_28;
  highp vec2 P_29;
  P_29 = (tmpvar_26.xy + _ShadowOffsets[1].xy);
  lowp float tmpvar_30;
  tmpvar_30 = texture2D (_ShadowMapTexture, P_29).x;
  shadowVals_25.y = tmpvar_30;
  highp vec2 P_31;
  P_31 = (tmpvar_26.xy + _ShadowOffsets[2].xy);
  lowp float tmpvar_32;
  tmpvar_32 = texture2D (_ShadowMapTexture, P_31).x;
  shadowVals_25.z = tmpvar_32;
  highp vec2 P_33;
  P_33 = (tmpvar_26.xy + _ShadowOffsets[3].xy);
  lowp float tmpvar_34;
  tmpvar_34 = texture2D (_ShadowMapTexture, P_33).x;
  shadowVals_25.w = tmpvar_34;
  bvec4 tmpvar_35;
  tmpvar_35 = lessThan (shadowVals_25, tmpvar_26.zzzz);
  highp vec4 tmpvar_36;
  tmpvar_36 = _LightShadowData.xxxx;
  highp float tmpvar_37;
  if (tmpvar_35.x) {
    tmpvar_37 = tmpvar_36.x;
  } else {
    tmpvar_37 = 1.0;
  };
  highp float tmpvar_38;
  if (tmpvar_35.y) {
    tmpvar_38 = tmpvar_36.y;
  } else {
    tmpvar_38 = 1.0;
  };
  highp float tmpvar_39;
  if (tmpvar_35.z) {
    tmpvar_39 = tmpvar_36.z;
  } else {
    tmpvar_39 = 1.0;
  };
  highp float tmpvar_40;
  if (tmpvar_35.w) {
    tmpvar_40 = tmpvar_36.w;
  } else {
    tmpvar_40 = 1.0;
  };
  highp vec4 tmpvar_41;
  tmpvar_41.x = tmpvar_37;
  tmpvar_41.y = tmpvar_38;
  tmpvar_41.z = tmpvar_39;
  tmpvar_41.w = tmpvar_40;
  shadows_24 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = dot (shadows_24, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_23 = tmpvar_42;
  highp vec4 tmpvar_43;
  tmpvar_43.w = 0.0;
  tmpvar_43.xyz = tmpvar_18;
  highp float tmpvar_44;
  tmpvar_44 = clamp (dot (_WorldNorm, tmpvar_43), 0.0, 1.0);
  WNL_4 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_46;
  tmpvar_46 = clamp (((_MinLight + lightColor_5) * clamp ((_LightColor0.w * ((tmpvar_45 * (((float((xlv_TEXCOORD5.z > 0.0)) * tmpvar_19.w) * tmpvar_22.w) * tmpvar_23)) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_46;
  color_2.xyz = (tmpvar_16.xyz * baseLight_3);
  color_2.w = tmpvar_16.w;
  tmpvar_1 = color_2;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
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
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 428
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 418
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 422
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 426
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 448
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 449
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 452
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 456
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 460
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 464
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 468
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 472
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 476
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    #line 480
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD6 = vec4(xl_retval._ShadowCoord);
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
vec2 xll_vecTSel_vb2_vf2_vf2 (bvec2 a, vec2 b, vec2 c) {
  return vec2 (a.x ? b.x : c.x, a.y ? b.y : c.y);
}
vec3 xll_vecTSel_vb3_vf3_vf3 (bvec3 a, vec3 b, vec3 c) {
  return vec3 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z);
}
vec4 xll_vecTSel_vb4_vf4_vf4 (bvec4 a, vec4 b, vec4 c) {
  return vec4 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z, a.w ? b.w : c.w);
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 428
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 418
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 422
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 426
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 448
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 336
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 332
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp vec3 coord = (shadowCoord.xyz / shadowCoord.w);
    highp vec4 shadowVals;
    shadowVals.x = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[0].xy)).x;
    shadowVals.y = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[1].xy)).x;
    #line 323
    shadowVals.z = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[2].xy)).x;
    shadowVals.w = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[3].xy)).x;
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, coord.zzzz), vec4( _LightShadowData.xxxx), vec4( 1.0));
    mediump float shadow = dot( shadows, vec4( 0.25));
    #line 327
    return shadow;
}
#line 483
lowp vec4 frag( in v2f i ) {
    #line 485
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 489
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
    #line 493
    highp vec3 lightColor = _LightColor0.xyz;
    highp vec3 lightDir = vec3( _WorldSpaceLightPos0);
    highp float atten = (((float((i._LightCoord.z > 0.0)) * UnitySpotCookie( i._LightCoord)) * UnitySpotAttenuate( i._LightCoord.xyz)) * unitySampleShadow( i._ShadowCoord));
    highp float NL = xll_saturate_f((0.5 * (1.0 + dot( i.projPos, lightDir))));
    #line 497
    highp float lightIntensity = xll_saturate_f((_LightColor0.w * ((NL * atten) * 4.0)));
    highp float lightScatter = xll_saturate_f((1.0 - ((lightIntensity * _LightScatter) * prev.w)));
    mediump float WNL = xll_saturate_f(dot( _WorldNorm, vec4( lightDir, 0.0)));
    mediump float diff = ((WNL - 0.01) / 0.99);
    #line 501
    lightIntensity = xll_saturate_f((_LightColor0.w * ((diff * atten) * 4.0)));
    mediump vec3 baseLight = xll_saturate_vf3(((_MinLight + lightColor) * lightIntensity));
    mediump vec4 color;
    color.xyz = (prev.xyz * baseLight);
    #line 505
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_i.projPos = vec3(xlv_TEXCOORD4);
    xlt_i._LightCoord = vec4(xlv_TEXCOORD5);
    xlt_i._ShadowCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_Object2World]
Float 14 [_DistFade]
"3.0-!!ARBvp1.0
# 94 ALU
PARAM c[16] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[3];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
DP4 R4.x, R2, c[1];
DP4 R4.y, R2, c[2];
MOV R1.w, vertex.position;
DP4 R4.w, R2, c[4];
DP4 R4.z, R2, c[3];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R4.zw, R0.xyxy, -c[0].z;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0].z;
ADD R3.w, R0.x, -R0.y;
SLT R0.z, c[0].x, -R3.x;
SLT R0.w, -R3.x, c[0].x;
ADD R0.w, R0.z, -R0;
MUL R0.z, R4, R0.w;
MUL R1.x, R0.w, R3.w;
SLT R0.y, R0.z, c[0].x;
SLT R0.x, c[0], R0.z;
ADD R0.x, R0, -R0.y;
MUL R0.y, R3, R1.x;
MUL R0.x, R0, R0.w;
MAD R0.x, R3.z, R0, R0.y;
MOV R0.yw, R1;
DP4 R1.x, R0, c[1];
DP4 R1.z, R0, c[2];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[15].x;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[0].w;
SLT R0.y, R1.x, c[0].x;
SLT R0.x, c[0], R1;
ADD R0.z, R0.x, -R0.y;
SLT R0.y, -R3.z, c[0].x;
SLT R0.x, c[0], -R3.z;
ADD R0.x, R0, -R0.y;
MUL R0.w, R3, R0.x;
MUL R0.z, R0.x, R0;
MUL R0.w, R3.y, R0;
MAD R1.z, R3.x, R0, R0.w;
SLT R0.x, c[0], -R3.y;
SLT R0.y, -R3, c[0].x;
ADD R0.y, R0.x, -R0;
MUL R0.x, R4.z, R0.y;
SLT R0.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R0.w;
MUL R0.w, R3, R0.y;
MUL R0.y, R0.z, R0;
MUL R3.w, R3.z, R0;
MOV R0.zw, R1.xyyw;
MAD R0.y, R3.x, R0, R3.w;
DP4 R4.z, R0, c[1];
DP4 R4.w, R0, c[2];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[15].x;
ADD result.texcoord[2].xy, R0, c[0].w;
DP4 R0.z, R1, c[1];
DP4 R0.w, R1, c[2];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[15].x;
ADD result.texcoord[3].xy, R0.zwzw, c[0].w;
DP4 R1.x, R2, c[9];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[13];
DP3 R0.x, R0, R0;
RSQ R0.x, R0.x;
RCP R0.w, R0.x;
DP4 R1.z, R2, c[11];
DP4 R1.y, R2, c[10];
ADD R0.xyz, -R1, c[13];
MUL R1.x, R0.w, c[14];
DP3 R0.w, R0, R0;
MIN R1.x, R1, c[0].z;
RSQ R0.w, R0.w;
MAX R1.x, R1, c[0];
MUL result.texcoord[4].xyz, R0.w, R0;
MUL result.color.w, vertex.color, R1.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 94 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"vs_3_0
; 86 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c14, 0.00000000, 2.00000000, -1.00000000, 0
def c15, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mov r2.w, v0
mov r2.xyz, c14.x
dp4 r4.x, r2, c0
dp4 r4.y, r2, c1
mov r1.w, v0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r0, r4, v0
mad r4.zw, v2.xyxy, c14.y, c14.z
mov r1.y, r4.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r4.w, -r4.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r4.w, r4.w
sub r3.w, r0.y, r0.z
mul r0.z, r4, r0.x
mul r1.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r1
dp4 r1.z, r0, c1
dp4 r1.x, r0, c0
add r0.xy, -r4, r1.xzzw
slt r0.z, r3, -r3
slt r0.w, -r3.z, r3.z
sub r4.w, r0, r0.z
mul r1.x, r4.z, r4.w
mad o3.xy, r0, c15.x, c15.y
slt r0.x, -r1, r1
slt r0.y, r1.x, -r1.x
sub r0.y, r0.x, r0
sub r0.x, r0.z, r0.w
mul r0.z, r0.x, r0.y
mul r0.w, r3, r0.x
mul r0.w, r3.y, r0
mad r1.z, r3.x, r0, r0.w
slt r0.x, r3.y, -r3.y
slt r0.y, -r3, r3
sub r0.y, r0.x, r0
mul r0.x, r4.z, r0.y
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r3, r0.y
mul r0.y, r0.z, r0
mul r3.w, r3.z, r0
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r4, r4.zwzw
mad o4.xy, r0, c15.x, c15.y
dp4 r0.z, r1, c0
dp4 r0.w, r1, c1
add r0.zw, -r4.xyxy, r0
mad o5.xy, r0.zwzw, c15.x, c15.y
dp4 r1.x, r2, c8
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c12
dp3 r0.w, r0, r0
add r0.xyz, -r1, c12
rsq r0.w, r0.w
dp3 r1.x, r0, r0
rcp r0.w, r0.w
rsq r1.x, r1.x
mul_sat r0.w, r0, c13.x
mul o6.xyz, r1.x, r0
mul o1.w, v1, r0
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 240 // 216 used size, 12 vars
Float 212 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 63 instructions, 5 temp regs, 0 temp arrays:
// ALU 44 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbebenelpclgcdealmoejgjnpgeoncfghabaaaaaahiakaaaaadaaaaaa
cmaaaaaajmaaaaaakaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
pmaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaapcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaapcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaapcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaapcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaapcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaapcaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapapaaaapcaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcnaaiaaaaeaaaabaadeacaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaa
fjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaanaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaa
abaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaa
egacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaa
adaaaaaaclaaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaa
aaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaak
dcaabaaaaeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaa
aeaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaa
acaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaa
abaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaai
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaacaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
acaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaacaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
acaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaacaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = _glesVertex.w;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_modelview0 * tmpvar_7);
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_13.zyw;
  XZv_2.yzw = tmpvar_13.zyw;
  XYv_1.yzw = tmpvar_13.yzw;
  ZYv_3.z = (tmpvar_12.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_12.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_12.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_12.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_14;
  p_14 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_15);
  gl_Position = (glstate_matrix_projection * (tmpvar_8 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightColor_5;
  mediump vec4 ztex_6;
  mediump float zval_7;
  mediump vec4 ytex_8;
  mediump float yval_9;
  mediump vec4 xtex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.y;
  yval_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.z;
  zval_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_10, ytex_8, vec4(yval_9)), ztex_6, vec4(zval_7)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  lightColor_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) + 0.5);
  tmpvar_18 = texture2D (_LightTexture0, P_19);
  highp float tmpvar_20;
  tmpvar_20 = dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20));
  lowp float tmpvar_22;
  mediump vec4 shadows_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = (xlv_TEXCOORD6.xyz / xlv_TEXCOORD6.w);
  highp vec3 coord_25;
  coord_25 = (tmpvar_24 + _ShadowOffsets[0].xyz);
  lowp float tmpvar_26;
  tmpvar_26 = shadow2DEXT (_ShadowMapTexture, coord_25);
  shadows_23.x = tmpvar_26;
  highp vec3 coord_27;
  coord_27 = (tmpvar_24 + _ShadowOffsets[1].xyz);
  lowp float tmpvar_28;
  tmpvar_28 = shadow2DEXT (_ShadowMapTexture, coord_27);
  shadows_23.y = tmpvar_28;
  highp vec3 coord_29;
  coord_29 = (tmpvar_24 + _ShadowOffsets[2].xyz);
  lowp float tmpvar_30;
  tmpvar_30 = shadow2DEXT (_ShadowMapTexture, coord_29);
  shadows_23.z = tmpvar_30;
  highp vec3 coord_31;
  coord_31 = (tmpvar_24 + _ShadowOffsets[3].xyz);
  lowp float tmpvar_32;
  tmpvar_32 = shadow2DEXT (_ShadowMapTexture, coord_31);
  shadows_23.w = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33 = (_LightShadowData.xxxx + (shadows_23 * (1.0 - _LightShadowData.xxxx)));
  shadows_23 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = dot (shadows_23, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_22 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_36;
  tmpvar_36 = clamp (dot (_WorldNorm, tmpvar_35), 0.0, 1.0);
  WNL_4 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_38;
  tmpvar_38 = clamp (((_MinLight + lightColor_5) * clamp ((_LightColor0.w * ((tmpvar_37 * (((float((xlv_TEXCOORD5.z > 0.0)) * tmpvar_18.w) * tmpvar_21.w) * tmpvar_22)) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_38;
  color_2.xyz = (tmpvar_16.xyz * baseLight_3);
  color_2.w = tmpvar_16.w;
  tmpvar_1 = color_2;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
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
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 428
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 418
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 422
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 426
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 448
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 449
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 452
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 456
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 460
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 464
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 468
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 472
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 476
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    #line 480
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD6 = vec4(xl_retval._ShadowCoord);
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 428
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 418
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 422
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 426
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 448
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 336
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 332
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 317
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 319
    highp vec3 coord = (shadowCoord.xyz / shadowCoord.w);
    mediump vec4 shadows;
    shadows.x = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[0])).xyz);
    shadows.y = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[1])).xyz);
    #line 323
    shadows.z = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[2])).xyz);
    shadows.w = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[3])).xyz);
    shadows = (_LightShadowData.xxxx + (shadows * (1.0 - _LightShadowData.xxxx)));
    mediump float shadow = dot( shadows, vec4( 0.25));
    #line 327
    return shadow;
}
#line 483
lowp vec4 frag( in v2f i ) {
    #line 485
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 489
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
    #line 493
    highp vec3 lightColor = _LightColor0.xyz;
    highp vec3 lightDir = vec3( _WorldSpaceLightPos0);
    highp float atten = (((float((i._LightCoord.z > 0.0)) * UnitySpotCookie( i._LightCoord)) * UnitySpotAttenuate( i._LightCoord.xyz)) * unitySampleShadow( i._ShadowCoord));
    highp float NL = xll_saturate_f((0.5 * (1.0 + dot( i.projPos, lightDir))));
    #line 497
    highp float lightIntensity = xll_saturate_f((_LightColor0.w * ((NL * atten) * 4.0)));
    highp float lightScatter = xll_saturate_f((1.0 - ((lightIntensity * _LightScatter) * prev.w)));
    mediump float WNL = xll_saturate_f(dot( _WorldNorm, vec4( lightDir, 0.0)));
    mediump float diff = ((WNL - 0.01) / 0.99);
    #line 501
    lightIntensity = xll_saturate_f((_LightColor0.w * ((diff * atten) * 4.0)));
    mediump vec3 baseLight = xll_saturate_vf3(((_MinLight + lightColor) * lightIntensity));
    mediump vec4 color;
    color.xyz = (prev.xyz * baseLight);
    #line 505
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_i.projPos = vec3(xlv_TEXCOORD4);
    xlt_i._LightCoord = vec4(xlv_TEXCOORD5);
    xlt_i._ShadowCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_Object2World]
Float 14 [_DistFade]
"3.0-!!ARBvp1.0
# 94 ALU
PARAM c[16] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[3];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
DP4 R4.x, R2, c[1];
DP4 R4.y, R2, c[2];
MOV R1.w, vertex.position;
DP4 R4.w, R2, c[4];
DP4 R4.z, R2, c[3];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R4.zw, R0.xyxy, -c[0].z;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0].z;
ADD R3.w, R0.x, -R0.y;
SLT R0.z, c[0].x, -R3.x;
SLT R0.w, -R3.x, c[0].x;
ADD R0.w, R0.z, -R0;
MUL R0.z, R4, R0.w;
MUL R1.x, R0.w, R3.w;
SLT R0.y, R0.z, c[0].x;
SLT R0.x, c[0], R0.z;
ADD R0.x, R0, -R0.y;
MUL R0.y, R3, R1.x;
MUL R0.x, R0, R0.w;
MAD R0.x, R3.z, R0, R0.y;
MOV R0.yw, R1;
DP4 R1.x, R0, c[1];
DP4 R1.z, R0, c[2];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[15].x;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[0].w;
SLT R0.y, R1.x, c[0].x;
SLT R0.x, c[0], R1;
ADD R0.z, R0.x, -R0.y;
SLT R0.y, -R3.z, c[0].x;
SLT R0.x, c[0], -R3.z;
ADD R0.x, R0, -R0.y;
MUL R0.w, R3, R0.x;
MUL R0.z, R0.x, R0;
MUL R0.w, R3.y, R0;
MAD R1.z, R3.x, R0, R0.w;
SLT R0.x, c[0], -R3.y;
SLT R0.y, -R3, c[0].x;
ADD R0.y, R0.x, -R0;
MUL R0.x, R4.z, R0.y;
SLT R0.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R0.w;
MUL R0.w, R3, R0.y;
MUL R0.y, R0.z, R0;
MUL R3.w, R3.z, R0;
MOV R0.zw, R1.xyyw;
MAD R0.y, R3.x, R0, R3.w;
DP4 R4.z, R0, c[1];
DP4 R4.w, R0, c[2];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[15].x;
ADD result.texcoord[2].xy, R0, c[0].w;
DP4 R0.z, R1, c[1];
DP4 R0.w, R1, c[2];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[15].x;
ADD result.texcoord[3].xy, R0.zwzw, c[0].w;
DP4 R1.x, R2, c[9];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[13];
DP3 R0.x, R0, R0;
RSQ R0.x, R0.x;
RCP R0.w, R0.x;
DP4 R1.z, R2, c[11];
DP4 R1.y, R2, c[10];
ADD R0.xyz, -R1, c[13];
MUL R1.x, R0.w, c[14];
DP3 R0.w, R0, R0;
MIN R1.x, R1, c[0].z;
RSQ R0.w, R0.w;
MAX R1.x, R1, c[0];
MUL result.texcoord[4].xyz, R0.w, R0;
MUL result.color.w, vertex.color, R1.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 94 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"vs_3_0
; 86 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c14, 0.00000000, 2.00000000, -1.00000000, 0
def c15, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mov r2.w, v0
mov r2.xyz, c14.x
dp4 r4.x, r2, c0
dp4 r4.y, r2, c1
mov r1.w, v0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r0, r4, v0
mad r4.zw, v2.xyxy, c14.y, c14.z
mov r1.y, r4.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r4.w, -r4.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r4.w, r4.w
sub r3.w, r0.y, r0.z
mul r0.z, r4, r0.x
mul r1.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r1
dp4 r1.z, r0, c1
dp4 r1.x, r0, c0
add r0.xy, -r4, r1.xzzw
slt r0.z, r3, -r3
slt r0.w, -r3.z, r3.z
sub r4.w, r0, r0.z
mul r1.x, r4.z, r4.w
mad o3.xy, r0, c15.x, c15.y
slt r0.x, -r1, r1
slt r0.y, r1.x, -r1.x
sub r0.y, r0.x, r0
sub r0.x, r0.z, r0.w
mul r0.z, r0.x, r0.y
mul r0.w, r3, r0.x
mul r0.w, r3.y, r0
mad r1.z, r3.x, r0, r0.w
slt r0.x, r3.y, -r3.y
slt r0.y, -r3, r3
sub r0.y, r0.x, r0
mul r0.x, r4.z, r0.y
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r3, r0.y
mul r0.y, r0.z, r0
mul r3.w, r3.z, r0
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r4, r4.zwzw
mad o4.xy, r0, c15.x, c15.y
dp4 r0.z, r1, c0
dp4 r0.w, r1, c1
add r0.zw, -r4.xyxy, r0
mad o5.xy, r0.zwzw, c15.x, c15.y
dp4 r1.x, r2, c8
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c12
dp3 r0.w, r0, r0
add r0.xyz, -r1, c12
rsq r0.w, r0.w
dp3 r1.x, r0, r0
rcp r0.w, r0.w
rsq r1.x, r1.x
mul_sat r0.w, r0, c13.x
mul o6.xyz, r1.x, r0
mul o1.w, v1, r0
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176 // 152 used size, 11 vars
Float 148 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 63 instructions, 5 temp regs, 0 temp arrays:
// ALU 44 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddbbdfgneahodhanbfeccgcpfmeamgdhiabaaaaaahiakaaaaadaaaaaa
cmaaaaaajmaaaaaakaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
pmaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaapcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaapcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaapcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaapcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaapcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaapcaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaapcaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcnaaiaaaaeaaaabaadeacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaa
fjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaajaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaa
abaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaa
egacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaa
adaaaaaaclaaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaa
aaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaak
dcaabaaaaeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaa
aeaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaa
acaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaa
abaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaai
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaacaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
acaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaacaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
acaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaacaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = _glesVertex.w;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_modelview0 * tmpvar_7);
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_13.zyw;
  XZv_2.yzw = tmpvar_13.zyw;
  XYv_1.yzw = tmpvar_13.yzw;
  ZYv_3.z = (tmpvar_12.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_12.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_12.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_12.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_14;
  p_14 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_15);
  gl_Position = (glstate_matrix_projection * (tmpvar_8 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightColor_5;
  mediump vec4 ztex_6;
  mediump float zval_7;
  mediump vec4 ytex_8;
  mediump float yval_9;
  mediump vec4 xtex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.y;
  yval_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.z;
  zval_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_10, ytex_8, vec4(yval_9)), ztex_6, vec4(zval_7)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  lightColor_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_LightTexture0, vec2(tmpvar_19));
  highp float tmpvar_21;
  mediump vec4 shadows_22;
  highp vec4 shadowVals_23;
  highp float tmpvar_24;
  tmpvar_24 = ((sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_25;
  vec_25 = (xlv_TEXCOORD6 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = textureCube (_ShadowMapTexture, vec_25);
  packDist_26 = tmpvar_27;
  shadowVals_23.x = dot (packDist_26, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_28;
  vec_28 = (xlv_TEXCOORD6 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = textureCube (_ShadowMapTexture, vec_28);
  packDist_29 = tmpvar_30;
  shadowVals_23.y = dot (packDist_29, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_31;
  vec_31 = (xlv_TEXCOORD6 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = textureCube (_ShadowMapTexture, vec_31);
  packDist_32 = tmpvar_33;
  shadowVals_23.z = dot (packDist_32, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_34;
  vec_34 = (xlv_TEXCOORD6 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = textureCube (_ShadowMapTexture, vec_34);
  packDist_35 = tmpvar_36;
  shadowVals_23.w = dot (packDist_35, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_37;
  tmpvar_37 = lessThan (shadowVals_23, vec4(tmpvar_24));
  highp vec4 tmpvar_38;
  tmpvar_38 = _LightShadowData.xxxx;
  highp float tmpvar_39;
  if (tmpvar_37.x) {
    tmpvar_39 = tmpvar_38.x;
  } else {
    tmpvar_39 = 1.0;
  };
  highp float tmpvar_40;
  if (tmpvar_37.y) {
    tmpvar_40 = tmpvar_38.y;
  } else {
    tmpvar_40 = 1.0;
  };
  highp float tmpvar_41;
  if (tmpvar_37.z) {
    tmpvar_41 = tmpvar_38.z;
  } else {
    tmpvar_41 = 1.0;
  };
  highp float tmpvar_42;
  if (tmpvar_37.w) {
    tmpvar_42 = tmpvar_38.w;
  } else {
    tmpvar_42 = 1.0;
  };
  highp vec4 tmpvar_43;
  tmpvar_43.x = tmpvar_39;
  tmpvar_43.y = tmpvar_40;
  tmpvar_43.z = tmpvar_41;
  tmpvar_43.w = tmpvar_42;
  shadows_22 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = dot (shadows_22, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_21 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = tmpvar_18;
  highp float tmpvar_46;
  tmpvar_46 = clamp (dot (_WorldNorm, tmpvar_45), 0.0, 1.0);
  WNL_4 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_48;
  tmpvar_48 = clamp (((_MinLight + lightColor_5) * clamp ((_LightColor0.w * ((tmpvar_47 * (tmpvar_20.w * tmpvar_21)) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_48;
  color_2.xyz = (tmpvar_16.xyz * baseLight_3);
  color_2.w = tmpvar_16.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = _glesVertex.w;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_modelview0 * tmpvar_7);
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_13.zyw;
  XZv_2.yzw = tmpvar_13.zyw;
  XYv_1.yzw = tmpvar_13.yzw;
  ZYv_3.z = (tmpvar_12.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_12.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_12.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_12.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_14;
  p_14 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_15);
  gl_Position = (glstate_matrix_projection * (tmpvar_8 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightColor_5;
  mediump vec4 ztex_6;
  mediump float zval_7;
  mediump vec4 ytex_8;
  mediump float yval_9;
  mediump vec4 xtex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.y;
  yval_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.z;
  zval_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_10, ytex_8, vec4(yval_9)), ztex_6, vec4(zval_7)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  lightColor_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_LightTexture0, vec2(tmpvar_19));
  highp float tmpvar_21;
  mediump vec4 shadows_22;
  highp vec4 shadowVals_23;
  highp float tmpvar_24;
  tmpvar_24 = ((sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_25;
  vec_25 = (xlv_TEXCOORD6 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = textureCube (_ShadowMapTexture, vec_25);
  packDist_26 = tmpvar_27;
  shadowVals_23.x = dot (packDist_26, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_28;
  vec_28 = (xlv_TEXCOORD6 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = textureCube (_ShadowMapTexture, vec_28);
  packDist_29 = tmpvar_30;
  shadowVals_23.y = dot (packDist_29, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_31;
  vec_31 = (xlv_TEXCOORD6 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = textureCube (_ShadowMapTexture, vec_31);
  packDist_32 = tmpvar_33;
  shadowVals_23.z = dot (packDist_32, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_34;
  vec_34 = (xlv_TEXCOORD6 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = textureCube (_ShadowMapTexture, vec_34);
  packDist_35 = tmpvar_36;
  shadowVals_23.w = dot (packDist_35, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_37;
  tmpvar_37 = lessThan (shadowVals_23, vec4(tmpvar_24));
  highp vec4 tmpvar_38;
  tmpvar_38 = _LightShadowData.xxxx;
  highp float tmpvar_39;
  if (tmpvar_37.x) {
    tmpvar_39 = tmpvar_38.x;
  } else {
    tmpvar_39 = 1.0;
  };
  highp float tmpvar_40;
  if (tmpvar_37.y) {
    tmpvar_40 = tmpvar_38.y;
  } else {
    tmpvar_40 = 1.0;
  };
  highp float tmpvar_41;
  if (tmpvar_37.z) {
    tmpvar_41 = tmpvar_38.z;
  } else {
    tmpvar_41 = 1.0;
  };
  highp float tmpvar_42;
  if (tmpvar_37.w) {
    tmpvar_42 = tmpvar_38.w;
  } else {
    tmpvar_42 = 1.0;
  };
  highp vec4 tmpvar_43;
  tmpvar_43.x = tmpvar_39;
  tmpvar_43.y = tmpvar_40;
  tmpvar_43.z = tmpvar_41;
  tmpvar_43.w = tmpvar_42;
  shadows_22 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = dot (shadows_22, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_21 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = tmpvar_18;
  highp float tmpvar_46;
  tmpvar_46 = clamp (dot (_WorldNorm, tmpvar_45), 0.0, 1.0);
  WNL_4 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_48;
  tmpvar_48 = clamp (((_MinLight + lightColor_5) * clamp ((_LightColor0.w * ((tmpvar_47 * (tmpvar_20.w * tmpvar_21)) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_48;
  color_2.xyz = (tmpvar_16.xyz * baseLight_3);
  color_2.w = tmpvar_16.w;
  tmpvar_1 = color_2;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
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
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 424
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 414
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 418
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 422
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 444
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 445
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 448
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 452
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 456
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 460
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 464
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 468
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 472
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    #line 476
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD6 = vec3(xl_retval._ShadowCoord);
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
vec2 xll_vecTSel_vb2_vf2_vf2 (bvec2 a, vec2 b, vec2 c) {
  return vec2 (a.x ? b.x : c.x, a.y ? b.y : c.y);
}
vec3 xll_vecTSel_vb3_vf3_vf3 (bvec3 a, vec3 b, vec3 c) {
  return vec3 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z);
}
vec4 xll_vecTSel_vb4_vf4_vf4 (bvec4 a, vec4 b, vec4 c) {
  return vec4 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z, a.w ? b.w : c.w);
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 424
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 414
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 418
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 422
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 444
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 316
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 319
    return DecodeFloatRGBA( packDist);
}
#line 321
highp float unityCubeShadow( in highp vec3 vec ) {
    #line 323
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    highp float z = 0.0078125;
    highp vec4 shadowVals;
    #line 327
    shadowVals.x = SampleCubeDistance( (vec + vec3( z, z, z)));
    shadowVals.y = SampleCubeDistance( (vec + vec3( (-z), (-z), z)));
    shadowVals.z = SampleCubeDistance( (vec + vec3( (-z), z, (-z))));
    shadowVals.w = SampleCubeDistance( (vec + vec3( z, (-z), (-z))));
    #line 331
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, vec4( mydist)), vec4( _LightShadowData.xxxx), vec4( 1.0));
    return dot( shadows, vec4( 0.25));
}
#line 479
lowp vec4 frag( in v2f i ) {
    #line 481
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 485
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
    #line 489
    highp vec3 lightColor = _LightColor0.xyz;
    highp vec3 lightDir = vec3( _WorldSpaceLightPos0);
    highp float atten = (texture( _LightTexture0, vec2( dot( i._LightCoord, i._LightCoord))).w * unityCubeShadow( i._ShadowCoord));
    highp float NL = xll_saturate_f((0.5 * (1.0 + dot( i.projPos, lightDir))));
    #line 493
    highp float lightIntensity = xll_saturate_f((_LightColor0.w * ((NL * atten) * 4.0)));
    highp float lightScatter = xll_saturate_f((1.0 - ((lightIntensity * _LightScatter) * prev.w)));
    mediump float WNL = xll_saturate_f(dot( _WorldNorm, vec4( lightDir, 0.0)));
    mediump float diff = ((WNL - 0.01) / 0.99);
    #line 497
    lightIntensity = xll_saturate_f((_LightColor0.w * ((diff * atten) * 4.0)));
    mediump vec3 baseLight = xll_saturate_vf3(((_MinLight + lightColor) * lightIntensity));
    mediump vec4 color;
    color.xyz = (prev.xyz * baseLight);
    #line 501
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_i.projPos = vec3(xlv_TEXCOORD4);
    xlt_i._LightCoord = vec3(xlv_TEXCOORD5);
    xlt_i._ShadowCoord = vec3(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_Object2World]
Float 14 [_DistFade]
"3.0-!!ARBvp1.0
# 94 ALU
PARAM c[16] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[3];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
DP4 R4.x, R2, c[1];
DP4 R4.y, R2, c[2];
MOV R1.w, vertex.position;
DP4 R4.w, R2, c[4];
DP4 R4.z, R2, c[3];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R4.zw, R0.xyxy, -c[0].z;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0].z;
ADD R3.w, R0.x, -R0.y;
SLT R0.z, c[0].x, -R3.x;
SLT R0.w, -R3.x, c[0].x;
ADD R0.w, R0.z, -R0;
MUL R0.z, R4, R0.w;
MUL R1.x, R0.w, R3.w;
SLT R0.y, R0.z, c[0].x;
SLT R0.x, c[0], R0.z;
ADD R0.x, R0, -R0.y;
MUL R0.y, R3, R1.x;
MUL R0.x, R0, R0.w;
MAD R0.x, R3.z, R0, R0.y;
MOV R0.yw, R1;
DP4 R1.x, R0, c[1];
DP4 R1.z, R0, c[2];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[15].x;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[0].w;
SLT R0.y, R1.x, c[0].x;
SLT R0.x, c[0], R1;
ADD R0.z, R0.x, -R0.y;
SLT R0.y, -R3.z, c[0].x;
SLT R0.x, c[0], -R3.z;
ADD R0.x, R0, -R0.y;
MUL R0.w, R3, R0.x;
MUL R0.z, R0.x, R0;
MUL R0.w, R3.y, R0;
MAD R1.z, R3.x, R0, R0.w;
SLT R0.x, c[0], -R3.y;
SLT R0.y, -R3, c[0].x;
ADD R0.y, R0.x, -R0;
MUL R0.x, R4.z, R0.y;
SLT R0.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R0.w;
MUL R0.w, R3, R0.y;
MUL R0.y, R0.z, R0;
MUL R3.w, R3.z, R0;
MOV R0.zw, R1.xyyw;
MAD R0.y, R3.x, R0, R3.w;
DP4 R4.z, R0, c[1];
DP4 R4.w, R0, c[2];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[15].x;
ADD result.texcoord[2].xy, R0, c[0].w;
DP4 R0.z, R1, c[1];
DP4 R0.w, R1, c[2];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[15].x;
ADD result.texcoord[3].xy, R0.zwzw, c[0].w;
DP4 R1.x, R2, c[9];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[13];
DP3 R0.x, R0, R0;
RSQ R0.x, R0.x;
RCP R0.w, R0.x;
DP4 R1.z, R2, c[11];
DP4 R1.y, R2, c[10];
ADD R0.xyz, -R1, c[13];
MUL R1.x, R0.w, c[14];
DP3 R0.w, R0, R0;
MIN R1.x, R1, c[0].z;
RSQ R0.w, R0.w;
MAX R1.x, R1, c[0];
MUL result.texcoord[4].xyz, R0.w, R0;
MUL result.color.w, vertex.color, R1.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 94 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"vs_3_0
; 86 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
def c14, 0.00000000, 2.00000000, -1.00000000, 0
def c15, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mov r2.w, v0
mov r2.xyz, c14.x
dp4 r4.x, r2, c0
dp4 r4.y, r2, c1
mov r1.w, v0
dp4 r4.w, r2, c3
dp4 r4.z, r2, c2
add r0, r4, v0
mad r4.zw, v2.xyxy, c14.y, c14.z
mov r1.y, r4.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r4.w, -r4.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r4.w, r4.w
sub r3.w, r0.y, r0.z
mul r0.z, r4, r0.x
mul r1.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r1
dp4 r1.z, r0, c1
dp4 r1.x, r0, c0
add r0.xy, -r4, r1.xzzw
slt r0.z, r3, -r3
slt r0.w, -r3.z, r3.z
sub r4.w, r0, r0.z
mul r1.x, r4.z, r4.w
mad o3.xy, r0, c15.x, c15.y
slt r0.x, -r1, r1
slt r0.y, r1.x, -r1.x
sub r0.y, r0.x, r0
sub r0.x, r0.z, r0.w
mul r0.z, r0.x, r0.y
mul r0.w, r3, r0.x
mul r0.w, r3.y, r0
mad r1.z, r3.x, r0, r0.w
slt r0.x, r3.y, -r3.y
slt r0.y, -r3, r3
sub r0.y, r0.x, r0
mul r0.x, r4.z, r0.y
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r3, r0.y
mul r0.y, r0.z, r0
mul r3.w, r3.z, r0
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r4, r4.zwzw
mad o4.xy, r0, c15.x, c15.y
dp4 r0.z, r1, c0
dp4 r0.w, r1, c1
add r0.zw, -r4.xyxy, r0
mad o5.xy, r0.zwzw, c15.x, c15.y
dp4 r1.x, r2, c8
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c12
dp3 r0.w, r0, r0
add r0.xyz, -r1, c12
rsq r0.w, r0.w
dp3 r1.x, r0, r0
rcp r0.w, r0.w
rsq r1.x, r1.x
mul_sat r0.w, r0, c13.x
mul o6.xyz, r1.x, r0
mul o1.w, v1, r0
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176 // 152 used size, 11 vars
Float 148 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 63 instructions, 5 temp regs, 0 temp arrays:
// ALU 44 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddbbdfgneahodhanbfeccgcpfmeamgdhiabaaaaaahiakaaaaadaaaaaa
cmaaaaaajmaaaaaakaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
pmaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaapcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaapcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaapcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaapcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaapcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaapcaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahapaaaapcaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcnaaiaaaaeaaaabaadeacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaa
fjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaajaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaacaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaa
abaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaa
egacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaa
adaaaaaaclaaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaa
aaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaak
dcaabaaaaeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaa
aeaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaa
acaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaa
abaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaai
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaacaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
acaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaacaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
acaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaacaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = _glesVertex.w;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_modelview0 * tmpvar_7);
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_13.zyw;
  XZv_2.yzw = tmpvar_13.zyw;
  XYv_1.yzw = tmpvar_13.yzw;
  ZYv_3.z = (tmpvar_12.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_12.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_12.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_12.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_14;
  p_14 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_15);
  gl_Position = (glstate_matrix_projection * (tmpvar_8 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightColor_5;
  mediump vec4 ztex_6;
  mediump float zval_7;
  mediump vec4 ytex_8;
  mediump float yval_9;
  mediump vec4 xtex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.y;
  yval_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.z;
  zval_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_10, ytex_8, vec4(yval_9)), ztex_6, vec4(zval_7)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  lightColor_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_LightTextureB0, vec2(tmpvar_19));
  lowp vec4 tmpvar_21;
  tmpvar_21 = textureCube (_LightTexture0, xlv_TEXCOORD5);
  highp float tmpvar_22;
  mediump vec4 shadows_23;
  highp vec4 shadowVals_24;
  highp float tmpvar_25;
  tmpvar_25 = ((sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_26;
  vec_26 = (xlv_TEXCOORD6 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = textureCube (_ShadowMapTexture, vec_26);
  packDist_27 = tmpvar_28;
  shadowVals_24.x = dot (packDist_27, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_29;
  vec_29 = (xlv_TEXCOORD6 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_ShadowMapTexture, vec_29);
  packDist_30 = tmpvar_31;
  shadowVals_24.y = dot (packDist_30, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_32;
  vec_32 = (xlv_TEXCOORD6 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_33;
  lowp vec4 tmpvar_34;
  tmpvar_34 = textureCube (_ShadowMapTexture, vec_32);
  packDist_33 = tmpvar_34;
  shadowVals_24.z = dot (packDist_33, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_35;
  vec_35 = (xlv_TEXCOORD6 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = textureCube (_ShadowMapTexture, vec_35);
  packDist_36 = tmpvar_37;
  shadowVals_24.w = dot (packDist_36, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_38;
  tmpvar_38 = lessThan (shadowVals_24, vec4(tmpvar_25));
  highp vec4 tmpvar_39;
  tmpvar_39 = _LightShadowData.xxxx;
  highp float tmpvar_40;
  if (tmpvar_38.x) {
    tmpvar_40 = tmpvar_39.x;
  } else {
    tmpvar_40 = 1.0;
  };
  highp float tmpvar_41;
  if (tmpvar_38.y) {
    tmpvar_41 = tmpvar_39.y;
  } else {
    tmpvar_41 = 1.0;
  };
  highp float tmpvar_42;
  if (tmpvar_38.z) {
    tmpvar_42 = tmpvar_39.z;
  } else {
    tmpvar_42 = 1.0;
  };
  highp float tmpvar_43;
  if (tmpvar_38.w) {
    tmpvar_43 = tmpvar_39.w;
  } else {
    tmpvar_43 = 1.0;
  };
  highp vec4 tmpvar_44;
  tmpvar_44.x = tmpvar_40;
  tmpvar_44.y = tmpvar_41;
  tmpvar_44.z = tmpvar_42;
  tmpvar_44.w = tmpvar_43;
  shadows_23 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = dot (shadows_23, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_22 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = tmpvar_18;
  highp float tmpvar_47;
  tmpvar_47 = clamp (dot (_WorldNorm, tmpvar_46), 0.0, 1.0);
  WNL_4 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_49;
  tmpvar_49 = clamp (((_MinLight + lightColor_5) * clamp ((_LightColor0.w * ((tmpvar_48 * ((tmpvar_20.w * tmpvar_21.w) * tmpvar_22)) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_49;
  color_2.xyz = (tmpvar_16.xyz * baseLight_3);
  color_2.w = tmpvar_16.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  lowp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = _glesVertex.w;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_modelview0 * tmpvar_7);
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_13.zyw;
  XZv_2.yzw = tmpvar_13.zyw;
  XYv_1.yzw = tmpvar_13.yzw;
  ZYv_3.z = (tmpvar_12.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_12.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_12.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_12.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_12.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_14;
  p_14 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_15);
  gl_Position = (glstate_matrix_projection * (tmpvar_8 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp vec4 _WorldNorm;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump vec3 baseLight_3;
  mediump float WNL_4;
  highp vec3 lightColor_5;
  mediump vec4 ztex_6;
  mediump float zval_7;
  mediump vec4 ytex_8;
  mediump float yval_9;
  mediump vec4 xtex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.y;
  yval_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD0.z;
  zval_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_10, ytex_8, vec4(yval_9)), ztex_6, vec4(zval_7)));
  lowp vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  lightColor_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  highp float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD5, xlv_TEXCOORD5);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_LightTextureB0, vec2(tmpvar_19));
  lowp vec4 tmpvar_21;
  tmpvar_21 = textureCube (_LightTexture0, xlv_TEXCOORD5);
  highp float tmpvar_22;
  mediump vec4 shadows_23;
  highp vec4 shadowVals_24;
  highp float tmpvar_25;
  tmpvar_25 = ((sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_26;
  vec_26 = (xlv_TEXCOORD6 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = textureCube (_ShadowMapTexture, vec_26);
  packDist_27 = tmpvar_28;
  shadowVals_24.x = dot (packDist_27, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_29;
  vec_29 = (xlv_TEXCOORD6 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_ShadowMapTexture, vec_29);
  packDist_30 = tmpvar_31;
  shadowVals_24.y = dot (packDist_30, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_32;
  vec_32 = (xlv_TEXCOORD6 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_33;
  lowp vec4 tmpvar_34;
  tmpvar_34 = textureCube (_ShadowMapTexture, vec_32);
  packDist_33 = tmpvar_34;
  shadowVals_24.z = dot (packDist_33, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_35;
  vec_35 = (xlv_TEXCOORD6 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = textureCube (_ShadowMapTexture, vec_35);
  packDist_36 = tmpvar_37;
  shadowVals_24.w = dot (packDist_36, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_38;
  tmpvar_38 = lessThan (shadowVals_24, vec4(tmpvar_25));
  highp vec4 tmpvar_39;
  tmpvar_39 = _LightShadowData.xxxx;
  highp float tmpvar_40;
  if (tmpvar_38.x) {
    tmpvar_40 = tmpvar_39.x;
  } else {
    tmpvar_40 = 1.0;
  };
  highp float tmpvar_41;
  if (tmpvar_38.y) {
    tmpvar_41 = tmpvar_39.y;
  } else {
    tmpvar_41 = 1.0;
  };
  highp float tmpvar_42;
  if (tmpvar_38.z) {
    tmpvar_42 = tmpvar_39.z;
  } else {
    tmpvar_42 = 1.0;
  };
  highp float tmpvar_43;
  if (tmpvar_38.w) {
    tmpvar_43 = tmpvar_39.w;
  } else {
    tmpvar_43 = 1.0;
  };
  highp vec4 tmpvar_44;
  tmpvar_44.x = tmpvar_40;
  tmpvar_44.y = tmpvar_41;
  tmpvar_44.z = tmpvar_42;
  tmpvar_44.w = tmpvar_43;
  shadows_23 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = dot (shadows_23, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_22 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = tmpvar_18;
  highp float tmpvar_47;
  tmpvar_47 = clamp (dot (_WorldNorm, tmpvar_46), 0.0, 1.0);
  WNL_4 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = ((WNL_4 - 0.01) / 0.99);
  highp vec3 tmpvar_49;
  tmpvar_49 = clamp (((_MinLight + lightColor_5) * clamp ((_LightColor0.w * ((tmpvar_48 * ((tmpvar_20.w * tmpvar_21.w) * tmpvar_22)) * 4.0)), 0.0, 1.0)), 0.0, 1.0);
  baseLight_3 = tmpvar_49;
  color_2.xyz = (tmpvar_16.xyz * baseLight_3);
  color_2.w = tmpvar_16.w;
  tmpvar_1 = color_2;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
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
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 425
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 415
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 419
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 423
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 445
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 446
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 449
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 453
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 457
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 461
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 465
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 469
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 473
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    #line 477
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD6 = vec3(xl_retval._ShadowCoord);
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
vec2 xll_vecTSel_vb2_vf2_vf2 (bvec2 a, vec2 b, vec2 c) {
  return vec2 (a.x ? b.x : c.x, a.y ? b.y : c.y);
}
vec3 xll_vecTSel_vb3_vf3_vf3 (bvec3 a, vec3 b, vec3 c) {
  return vec3 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z);
}
vec4 xll_vecTSel_vb4_vf4_vf4 (bvec4 a, vec4 b, vec4 c) {
  return vec4 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z, a.w ? b.w : c.w);
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
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 425
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
#line 415
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
#line 419
uniform lowp vec4 _Color;
uniform highp vec4 _WorldNorm;
uniform highp float _InvFade;
uniform highp float _DistFade;
#line 423
uniform highp float _LightScatter;
uniform highp float _MinLight;
#line 445
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 316
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 319
    return DecodeFloatRGBA( packDist);
}
#line 321
highp float unityCubeShadow( in highp vec3 vec ) {
    #line 323
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    highp float z = 0.0078125;
    highp vec4 shadowVals;
    #line 327
    shadowVals.x = SampleCubeDistance( (vec + vec3( z, z, z)));
    shadowVals.y = SampleCubeDistance( (vec + vec3( (-z), (-z), z)));
    shadowVals.z = SampleCubeDistance( (vec + vec3( (-z), z, (-z))));
    shadowVals.w = SampleCubeDistance( (vec + vec3( z, (-z), (-z))));
    #line 331
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, vec4( mydist)), vec4( _LightShadowData.xxxx), vec4( 1.0));
    return dot( shadows, vec4( 0.25));
}
#line 480
lowp vec4 frag( in v2f i ) {
    #line 482
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 486
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
    #line 490
    highp vec3 lightColor = _LightColor0.xyz;
    highp vec3 lightDir = vec3( _WorldSpaceLightPos0);
    highp float atten = ((texture( _LightTextureB0, vec2( dot( i._LightCoord, i._LightCoord))).w * texture( _LightTexture0, i._LightCoord).w) * unityCubeShadow( i._ShadowCoord));
    highp float NL = xll_saturate_f((0.5 * (1.0 + dot( i.projPos, lightDir))));
    #line 494
    highp float lightIntensity = xll_saturate_f((_LightColor0.w * ((NL * atten) * 4.0)));
    highp float lightScatter = xll_saturate_f((1.0 - ((lightIntensity * _LightScatter) * prev.w)));
    mediump float WNL = xll_saturate_f(dot( _WorldNorm, vec4( lightDir, 0.0)));
    mediump float diff = ((WNL - 0.01) / 0.99);
    #line 498
    lightIntensity = xll_saturate_f((_LightColor0.w * ((diff * atten) * 4.0)));
    mediump vec3 baseLight = xll_saturate_vf3(((_MinLight + lightColor) * lightIntensity));
    mediump vec4 color;
    color.xyz = (prev.xyz * baseLight);
    #line 502
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_i.projPos = vec3(xlv_TEXCOORD4);
    xlt_i._LightCoord = vec3(xlv_TEXCOORD5);
    xlt_i._ShadowCoord = vec3(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 15
//   opengl - ALU: 21 to 47, TEX: 3 to 9
//   d3d9 - ALU: 18 to 38, TEX: 3 to 9
//   d3d11 - ALU: 14 to 33, TEX: 3 to 9, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_WorldNorm]
Float 4 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 24 ALU, 4 TEX
PARAM c[6] = { program.local[0..4],
		{ 0.95019531, 0.010002136, 1.0098619, 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[2];
MUL R0, R0, R1;
DP3 R1.y, fragment.texcoord[5], fragment.texcoord[5];
MUL R0, R0, c[5].x;
MOV R2.xyz, c[0];
DP3_SAT R1.x, R2, c[3];
ADD R1.x, R1, -c[5].y;
TEX R1.w, R1.y, texture[3], 2D;
MUL R1.x, R1, c[5].z;
MUL R1.x, R1, R1.w;
MUL R1.w, R1.x, c[1];
MOV R1.xyz, c[1];
MUL_SAT R1.w, R1, c[5];
ADD R1.xyz, R1, c[4].x;
MUL_SAT R1.xyz, R1, R1.w;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 24 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_WorldNorm]
Float 4 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 20 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c5, 0.95019531, -0.01000214, 1.00986195, 4.00000000
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v6.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c2
mul_pp r1, r0, r1
mov r2.xyz, c3
dp3_sat r0.y, c0, r2
dp3 r0.x, v6, v6
add_pp r0.y, r0, c5
texld r0.x, r0.x, s3
mul_pp r0.y, r0, c5.z
mul r2.x, r0.y, r0
mul_pp r0, r1, c5.x
mul r1.y, r2.x, c1.w
mul_sat r1.w, r1.y, c5
mov r1.x, c4
add r1.xyz, c1, r1.x
mul_sat r1.xyz, r1, r1.w
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 160 used size, 11 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_WorldNorm] 4
Float 156 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_LeftTex] 2D 2
SetTexture 1 [_TopTex] 2D 1
SetTexture 2 [_FrontTex] 2D 3
SetTexture 3 [_LightTexture0] 2D 0
// 23 instructions, 3 temp regs, 0 temp arrays:
// ALU 17 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkackinkmcdkfcjgbiocjpnkafefbpfkeabaaaaaaaiafaaaaadaaaaaa
cmaaaaaabiabaaaaemabaaaaejfdeheooeaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaankaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaankaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaankaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaankaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaankaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaankaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcleadaaaaeaaaaaaaonaaaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadgcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaad
dcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaabacaaaajbcaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaa
egiccaaaabaaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
pnekibdpbaaaaaahccaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaa
efaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeadicaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaaaaaaaaaj
ocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaajaaaaaa
dicaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaa
acaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaa
acaaaaaaaagabaaaadaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaa
abaaaaaaegiocaaaaaaaaaaaahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaddddhddpddddhddpddddhddpddddhddpdiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaab"
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
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_WorldNorm]
Float 4 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 21 ALU, 3 TEX
PARAM c[6] = { program.local[0..4],
		{ 0.95019531, 0.010002136, 1.0098619, 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R2.xyz, c[0];
DP3_SAT R2.x, R2, c[3];
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R0, fragment.texcoord[0].y, R0, R1;
TEX R1, fragment.texcoord[3], texture[2], 2D;
ADD R1, R1, -R0;
MAD R0, fragment.texcoord[0].z, R1, R0;
MUL R1, fragment.color.primary, c[2];
MUL R0, R1, R0;
MUL R0, R0, c[5].x;
ADD R2.x, R2, -c[5].y;
MUL R1.x, R2, c[5].z;
MUL R1.w, R1.x, c[1];
MOV R1.xyz, c[1];
MUL_SAT R1.w, R1, c[5];
ADD R1.xyz, R1, c[4].x;
MUL_SAT R1.xyz, R1, R1.w;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 21 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_WorldNorm]
Float 4 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_3_0
; 18 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c5, 0.95019531, -0.01000214, 1.00986195, 4.00000000
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
mov r2.xyz, c3
dp3_sat r2.x, c0, r2
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r0, v1.y, r0, r1
texld r1, v4, s2
add_pp r1, r1, -r0
mad_pp r0, v1.z, r1, r0
mul_pp r1, v0, c2
mul_pp r0, r1, r0
mul_pp r0, r0, c5.x
add_pp r2.x, r2, c5.y
mul_pp r1.x, r2, c5.z
mul r1.y, r1.x, c1.w
mul_sat r1.w, r1.y, c5
mov r1.x, c4
add r1.xyz, c1, r1.x
mul_sat r1.xyz, r1, r1.w
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
ConstBuffer "$Globals" 112 // 96 used size, 10 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Vector 64 [_WorldNorm] 4
Float 92 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 19 instructions, 3 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedapdmbaepcooeefdcdcfjfdojpegamifdabaaaaaafaaeaaaaadaaaaaa
cmaaaaaaaaabaaaadeabaaaaejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaamcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaamcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaamcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaamcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaamcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbeadaaaaeaaaaaaa
mfaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
mcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaabacaaaajbcaabaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
egiccaaaabaaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
pnekibeadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
abaaaaaaaaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaapgipcaaa
aaaaaaaaafaaaaaadicaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
aeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaa
kgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaa
acaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaddddhddpddddhddpddddhddpddddhddpdiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadoaaaaab"
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
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_WorldNorm]
Float 4 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 30 ALU, 5 TEX
PARAM c[7] = { program.local[0..4],
		{ 0.95019531, 0.010002136, 1.0098619, 0 },
		{ 0.5, 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[1], texture[0], 2D;
TEX R1, fragment.texcoord[2], texture[1], 2D;
ADD R1, R1, -R0;
MAD R0, fragment.texcoord[0].y, R1, R0;
TEX R1, fragment.texcoord[3], texture[2], 2D;
ADD R1, R1, -R0;
MAD R0, fragment.texcoord[0].z, R1, R0;
MOV R1.xyz, c[0];
DP3_SAT R1.y, R1, c[3];
MUL R2, fragment.color.primary, c[2];
MUL R0, R2, R0;
MUL R0, R0, c[5].x;
DP3 R1.w, fragment.texcoord[5], fragment.texcoord[5];
ADD R1.z, R1.y, -c[5].y;
RCP R1.x, fragment.texcoord[5].w;
MAD R1.xy, fragment.texcoord[5], R1.x, c[6].x;
TEX R2.w, R1, texture[3], 2D;
SLT R1.x, c[5].w, fragment.texcoord[5].z;
TEX R1.w, R1.w, texture[4], 2D;
MUL R1.x, R1, R2.w;
MUL R1.x, R1, R1.w;
MUL R1.y, R1.z, c[5].z;
MUL R1.x, R1.y, R1;
MUL R1.w, R1.x, c[1];
MOV R1.xyz, c[1];
MUL_SAT R1.w, R1, c[6].y;
ADD R1.xyz, R1, c[4].x;
MUL_SAT R1.xyz, R1, R1.w;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 30 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_WorldNorm]
Float 4 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
"ps_3_0
; 25 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c5, 0.95019531, -0.01000214, 1.00986195, 0.50000000
def c6, 0.00000000, 1.00000000, 4.00000000, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v6
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c2
mul_pp r1, r0, r1
mov r2.xyz, c3
dp3_sat r0.x, c0, r2
add_pp r0.y, r0.x, c5
rcp r0.z, v6.w
mad r2.xy, v6, r0.z, c5.w
dp3 r0.x, v6, v6
texld r0.w, r2, s3
cmp r0.z, -v6, c6.x, c6.y
mul_pp r0.z, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.z, r0, r0.x
mul_pp r0.x, r0.y, c5.z
mul r2.x, r0, r0.z
mul_pp r0, r1, c5.x
mul r1.y, r2.x, c1.w
mul_sat r1.w, r1.y, c6.z
mov r1.x, c4
add r1.xyz, c1, r1.x
mul_sat r1.xyz, r1, r1.w
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 160 used size, 11 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_WorldNorm] 4
Float 156 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_LeftTex] 2D 3
SetTexture 1 [_TopTex] 2D 2
SetTexture 2 [_FrontTex] 2D 4
SetTexture 3 [_LightTexture0] 2D 0
SetTexture 4 [_LightTextureB0] 2D 1
// 30 instructions, 3 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 1 uint
// TEX 5 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfpbnmdpkgnhkcjnpipgkpjnfpdmmejamabaaaaaapmafaaaaadaaaaaa
cmaaaaaabiabaaaaemabaaaaejfdeheooeaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaankaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaankaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaankaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaankaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaankaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaankaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefckiaeaaaaeaaaaaaackabaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadgcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaaddcbabaaa
aeaaaaaagcbaaaadpcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaagaaaaaapgbpbaaaagaaaaaa
aaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckbabaaaagaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaaj
pcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaabacaaaaj
ccaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegiccaaaabaaaaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiaeadicaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaafaaaaaaaaaaaaajocaabaaaaaaaaaaaagijcaaa
aaaaaaaaafaaaaaapgipcaaaaaaaaaaaajaaaaaadicaaaahhcaabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
ahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
diaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaddddhddpddddhddp
ddddhddpddddhddpdiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
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
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_WorldNorm]
Float 4 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 26 ALU, 5 TEX
PARAM c[6] = { program.local[0..4],
		{ 0.95019531, 0.010002136, 1.0098619, 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[1], texture[0], 2D;
TEX R1, fragment.texcoord[2], texture[1], 2D;
ADD R1, R1, -R0;
MAD R0, fragment.texcoord[0].y, R1, R0;
TEX R1, fragment.texcoord[3], texture[2], 2D;
ADD R1, R1, -R0;
MAD R0, fragment.texcoord[0].z, R1, R0;
MOV R1.xyz, c[0];
MUL R2, fragment.color.primary, c[2];
MUL R2, R2, R0;
DP3_SAT R1.x, R1, c[3];
ADD R0.y, R1.x, -c[5];
DP3 R0.x, fragment.texcoord[5], fragment.texcoord[5];
TEX R1.w, R0.x, texture[3], 2D;
TEX R0.w, fragment.texcoord[5], texture[4], CUBE;
MUL R0.x, R1.w, R0.w;
MUL R0.y, R0, c[5].z;
MUL R1.x, R0.y, R0;
MUL R1.w, R1.x, c[1];
MUL R0, R2, c[5].x;
MOV R1.xyz, c[1];
MUL_SAT R1.w, R1, c[5];
ADD R1.xyz, R1, c[4].x;
MUL_SAT R1.xyz, R1, R1.w;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 26 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_WorldNorm]
Float 4 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"ps_3_0
; 21 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
def c5, 0.95019531, -0.01000214, 1.00986195, 4.00000000
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v6.xyz
mov r2.xyz, c3
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c2
mul_pp r1, r0, r1
dp3_sat r2.x, c0, r2
dp3 r0.x, v6, v6
add_pp r0.y, r2.x, c5
texld r0.w, v6, s4
texld r0.x, r0.x, s3
mul r0.z, r0.x, r0.w
mul_pp r0.x, r0.y, c5.z
mul r2.x, r0, r0.z
mul_pp r0, r1, c5.x
mul r1.y, r2.x, c1.w
mul_sat r1.w, r1.y, c5
mov r1.x, c4
add r1.xyz, c1, r1.x
mul_sat r1.xyz, r1, r1.w
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 160 used size, 11 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_WorldNorm] 4
Float 156 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_LeftTex] 2D 3
SetTexture 1 [_TopTex] 2D 2
SetTexture 2 [_FrontTex] 2D 4
SetTexture 3 [_LightTextureB0] 2D 1
SetTexture 4 [_LightTexture0] CUBE 0
// 25 instructions, 3 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 5 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjcigljicclcjfhimnlbbkjcjpnbdeempabaaaaaageafaaaaadaaaaaa
cmaaaaaabiabaaaaemabaaaaejfdeheooeaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaankaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaankaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaankaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaankaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaankaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaankaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbaaeaaaaeaaaaaaaaeabaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaaeaahabaaa
aeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadgcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaaddcbabaaa
aeaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaa
efaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbcbaaaagaaaaaaeghobaaaaeaaaaaa
aagabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
abaaaaaabacaaaajccaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegiccaaa
abaaaaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeadicaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaaaaaaaaajocaabaaa
aaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaajaaaaaadicaaaah
hcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaa
aagabaaaaeaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
ddddhddpddddhddpddddhddpddddhddpdiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
doaaaaab"
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
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_WorldNorm]
Float 4 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 23 ALU, 4 TEX
PARAM c[6] = { program.local[0..4],
		{ 0.95019531, 0.010002136, 1.0098619, 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R2.xyz, c[0];
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[2];
MUL R1, R0, R1;
DP3_SAT R2.x, R2, c[3];
ADD R0.x, R2, -c[5].y;
TEX R0.w, fragment.texcoord[5], texture[3], 2D;
MUL R0.x, R0, c[5].z;
MUL R2.x, R0, R0.w;
MUL R0, R1, c[5].x;
MUL R1.w, R2.x, c[1];
MOV R1.xyz, c[1];
MUL_SAT R1.w, R1, c[5];
ADD R1.xyz, R1, c[4].x;
MUL_SAT R1.xyz, R1, R1.w;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 23 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_WorldNorm]
Float 4 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 19 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c5, 0.95019531, -0.01000214, 1.00986195, 4.00000000
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v6.xy
mov r2.xyz, c3
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c2
mul_pp r1, r0, r1
dp3_sat r2.x, c0, r2
add_pp r0.x, r2, c5.y
texld r0.w, v6, s3
mul_pp r0.x, r0, c5.z
mul r2.x, r0, r0.w
mul_pp r0, r1, c5.x
mul r1.y, r2.x, c1.w
mul_sat r1.w, r1.y, c5
mov r1.x, c4
add r1.xyz, c1, r1.x
mul_sat r1.xyz, r1, r1.w
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 160 used size, 11 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_WorldNorm] 4
Float 156 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_LeftTex] 2D 2
SetTexture 1 [_TopTex] 2D 1
SetTexture 2 [_FrontTex] 2D 3
SetTexture 3 [_LightTexture0] 2D 0
// 22 instructions, 3 temp regs, 0 temp arrays:
// ALU 16 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfgablbegnidililidolpgdjhmnododgiabaaaaaaomaeaaaaadaaaaaa
cmaaaaaabiabaaaaemabaaaaejfdeheooeaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaankaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaankaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaankaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaankaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaankaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
amamaaaankaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcjiadaaaaeaaaaaaaogaaaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadgcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaad
dcbabaaaaeaaaaaagcbaaaadmcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaabacaaaajbcaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaa
egiccaaaabaaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
pnekibdpefaaaaajpcaabaaaabaaaaaaogbkbaaaaeaaaaaaeghobaaaadaaaaaa
aagabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaea
dicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
aaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaa
ajaaaaaadicaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaia
ebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaia
ebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaa
egbobaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaadiaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaddddhddpddddhddpddddhddpddddhddpdiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaab"
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
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Vector 4 [_WorldNorm]
Float 5 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 36 ALU, 6 TEX
PARAM c[8] = { program.local[0..5],
		{ 0.95019531, 0.010002136, 1.0098619, 0 },
		{ 0.5, 1, 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[1], texture[0], 2D;
TEX R1, fragment.texcoord[2], texture[1], 2D;
ADD R1, R1, -R0;
MAD R0, fragment.texcoord[0].y, R1, R0;
TEX R1, fragment.texcoord[3], texture[2], 2D;
ADD R1, R1, -R0;
MAD R0, fragment.texcoord[0].z, R1, R0;
MOV R1.xyz, c[0];
DP3_SAT R1.x, R1, c[4];
DP3 R1.y, fragment.texcoord[5], fragment.texcoord[5];
MUL R2, fragment.color.primary, c[3];
MUL R2, R2, R0;
ADD R0.z, R1.x, -c[6].y;
TEX R1.w, R1.y, texture[4], 2D;
RCP R0.y, fragment.texcoord[6].w;
TXP R0.x, fragment.texcoord[6], texture[5], 2D;
MAD R0.x, -fragment.texcoord[6].z, R0.y, R0;
MOV R0.w, c[7].y;
CMP R1.x, R0, c[1], R0.w;
RCP R0.y, fragment.texcoord[5].w;
MAD R0.xy, fragment.texcoord[5], R0.y, c[7].x;
TEX R0.w, R0, texture[3], 2D;
SLT R0.x, c[6].w, fragment.texcoord[5].z;
MUL R0.x, R0, R0.w;
MUL R0.x, R0, R1.w;
MUL R0.x, R0, R1;
MUL R0.y, R0.z, c[6].z;
MUL R1.x, R0.y, R0;
MUL R1.w, R1.x, c[2];
MUL R0, R2, c[6].x;
MOV R1.xyz, c[2];
MUL_SAT R1.w, R1, c[7].z;
ADD R1.xyz, R1, c[5].x;
MUL_SAT R1.xyz, R1, R1.w;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 36 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Vector 4 [_WorldNorm]
Float 5 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"ps_3_0
; 30 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c6, 0.95019531, -0.01000214, 1.00986195, 0.50000000
def c7, 0.00000000, 1.00000000, 4.00000000, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v6
dcl_texcoord6 v7
mov r2.xyz, c4
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c3
mul_pp r1, r0, r1
dp3_sat r2.x, c0, r2
add_pp r0.y, r2.x, c6
texldp r0.x, v7, s5
rcp r0.z, v7.w
mad r0.z, -v7, r0, r0.x
mov r0.w, c1.x
rcp r0.x, v6.w
mad r2.xy, v6, r0.x, c6.w
cmp r0.z, r0, c7.y, r0.w
texld r0.w, r2, s3
cmp r2.x, -v6.z, c7, c7.y
dp3 r0.x, v6, v6
mul_pp r0.w, r2.x, r0
texld r0.x, r0.x, s4
mul_pp r0.x, r0.w, r0
mul_pp r0.z, r0.x, r0
mul_pp r0.x, r0.y, c6.z
mul r2.x, r0, r0.z
mul_pp r0, r1, c6.x
mul r1.y, r2.x, c2.w
mul_sat r1.w, r1.y, c7.z
mov r1.x, c5
add r1.xyz, c2, r1.x
mul_sat r1.xyz, r1, r1.w
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
ConstBuffer "$Globals" 176 // 160 used size, 11 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_WorldNorm] 4
Float 156 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityShadows" 416 // 400 used size, 8 vars
Vector 384 [_LightShadowData] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityShadows" 2
SetTexture 0 [_LeftTex] 2D 4
SetTexture 1 [_TopTex] 2D 3
SetTexture 2 [_FrontTex] 2D 5
SetTexture 3 [_LightTexture0] 2D 1
SetTexture 4 [_LightTextureB0] 2D 2
SetTexture 5 [_ShadowMapTexture] 2D 0
// 35 instructions, 3 temp regs, 0 temp arrays:
// ALU 25 float, 0 int, 1 uint
// TEX 6 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecediblmkcepcacfcjakkgfhgnnicbhagbkaabaaaaaaomagaaaaadaaaaaa
cmaaaaaadaabaaaageabaaaaejfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaapcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaapcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaapcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaapcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaapcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaapcaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapapaaaapcaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefciaafaaaaeaaaaaaagaabaaaafjaaaaaeegiocaaaaaaaaaaa
akaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaa
fkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaae
aahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadgcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaad
dcbabaaaaeaaaaaagcbaaaadpcbabaaaagaaaaaagcbaaaadpcbabaaaahaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaagaaaaaapgbpbaaaagaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadbaaaaah
bcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaagaaaaaaabaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
agaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaa
eghobaaaaeaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaabaaaaaaaoaaaaahocaabaaaaaaaaaaaagbjbaaaahaaaaaa
pgbpbaaaahaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaaaaaaaaaaeghobaaa
afaaaaaaaagabaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaa
dkaabaaaaaaaaaaadhaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
acaaaaaabiaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaabacaaaajccaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaaegiccaaaabaaaaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaapnekibdpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaea
dicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
aaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaa
ajaaaaaadicaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaeaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaia
ebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaa
eghobaaaacaaaaaaaagabaaaafaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaia
ebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaa
egbobaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaadiaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaddddhddpddddhddpddddhddpddddhddpdiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaab"
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
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Vector 4 [_WorldNorm]
Float 5 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 35 ALU, 6 TEX
OPTION ARB_fragment_program_shadow;
PARAM c[8] = { program.local[0..5],
		{ 0.95019531, 0.010002136, 1.0098619, 0 },
		{ 0.5, 1, 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[1], texture[0], 2D;
TEX R1, fragment.texcoord[2], texture[1], 2D;
ADD R1, R1, -R0;
MAD R0, fragment.texcoord[0].y, R1, R0;
TEX R1, fragment.texcoord[3], texture[2], 2D;
ADD R1, R1, -R0;
MAD R0, fragment.texcoord[0].z, R1, R0;
MOV R1.xyz, c[0];
DP3_SAT R1.x, R1, c[4];
DP3 R1.y, fragment.texcoord[5], fragment.texcoord[5];
MUL R2, fragment.color.primary, c[3];
MUL R2, R2, R0;
MOV R0.x, c[7].y;
ADD R0.y, R0.x, -c[1].x;
ADD R0.z, R1.x, -c[6].y;
TXP R0.x, fragment.texcoord[6], texture[5], SHADOW2D;
MAD R1.x, R0, R0.y, c[1];
RCP R0.w, fragment.texcoord[5].w;
MAD R0.xy, fragment.texcoord[5], R0.w, c[7].x;
TEX R0.w, R0, texture[3], 2D;
SLT R0.x, c[6].w, fragment.texcoord[5].z;
TEX R1.w, R1.y, texture[4], 2D;
MUL R0.x, R0, R0.w;
MUL R0.x, R0, R1.w;
MUL R0.x, R0, R1;
MUL R0.y, R0.z, c[6].z;
MUL R1.x, R0.y, R0;
MUL R1.w, R1.x, c[2];
MUL R0, R2, c[6].x;
MOV R1.xyz, c[2];
MUL_SAT R1.w, R1, c[7].z;
ADD R1.xyz, R1, c[5].x;
MUL_SAT R1.xyz, R1, R1.w;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 35 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Vector 4 [_WorldNorm]
Float 5 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"ps_3_0
; 29 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c6, 0.95019531, -0.01000214, 1.00986195, 0.50000000
def c7, 0.00000000, 1.00000000, 4.00000000, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v6
dcl_texcoord6 v7
mov r2.xyz, c4
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c3
mul_pp r1, r0, r1
dp3_sat r2.x, c0, r2
mov r0.x, c1
add r0.z, c7.y, -r0.x
texldp r0.x, v7, s5
mad r0.z, r0.x, r0, c1.x
dp3 r0.x, v6, v6
add_pp r0.y, r2.x, c6
rcp r0.w, v6.w
mad r2.xy, v6, r0.w, c6.w
texld r0.w, r2, s3
cmp r2.x, -v6.z, c7, c7.y
mul_pp r0.w, r2.x, r0
texld r0.x, r0.x, s4
mul_pp r0.x, r0.w, r0
mul_pp r0.z, r0.x, r0
mul_pp r0.x, r0.y, c6.z
mul r2.x, r0, r0.z
mul_pp r0, r1, c6.x
mul r1.y, r2.x, c2.w
mul_sat r1.w, r1.y, c7.z
mov r1.x, c5
add r1.xyz, c2, r1.x
mul_sat r1.xyz, r1, r1.w
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
ConstBuffer "$Globals" 176 // 160 used size, 11 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_WorldNorm] 4
Float 156 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityShadows" 416 // 400 used size, 8 vars
Vector 384 [_LightShadowData] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityShadows" 2
SetTexture 0 [_LeftTex] 2D 4
SetTexture 1 [_TopTex] 2D 3
SetTexture 2 [_FrontTex] 2D 5
SetTexture 3 [_LightTexture0] 2D 1
SetTexture 4 [_LightTextureB0] 2D 2
SetTexture 5 [_ShadowMapTexture] 2D 0
// 35 instructions, 3 temp regs, 0 temp arrays:
// ALU 26 float, 0 int, 1 uint
// TEX 5 (0 load, 1 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddbhjgphlppmficialhcoknejmnjffbeeabaaaaaapmagaaaaadaaaaaa
cmaaaaaadaabaaaageabaaaaejfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaapcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaapcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaapcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaapcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaapcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaapcaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapapaaaapcaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcjaafaaaaeaaaaaaageabaaaafjaaaaaeegiocaaaaaaaaaaa
akaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bjaaaaaafkaiaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaa
fkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaae
aahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadgcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaad
dcbabaaaaeaaaaaagcbaaaadpcbabaaaagaaaaaagcbaaaadpcbabaaaahaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaagaaaaaapgbpbaaaagaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadbaaaaah
bcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaagaaaaaaabaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
agaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaa
eghobaaaaeaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaabaaaaaaaoaaaaahocaabaaaaaaaaaaaagbjbaaaahaaaaaa
pgbpbaaaahaaaaaaehaaaaalccaabaaaaaaaaaaajgafbaaaaaaaaaaaaghabaaa
afaaaaaaaagabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaa
akiacaiaebaaaaaaacaaaaaabiaaaaaaabeaaaaaaaaaiadpdcaaaaakccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaacaaaaaabiaaaaaa
diaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaabacaaaaj
ccaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegiccaaaabaaaaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiaeadicaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaafaaaaaaaaaaaaajocaabaaaaaaaaaaaagijcaaa
aaaaaaaaafaaaaaapgipcaaaaaaaaaaaajaaaaaadicaaaahhcaabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaeaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaafaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
ahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
diaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaddddhddpddddhddp
ddddhddpddddhddpdiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
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
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_WorldNorm]
Float 4 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 23 ALU, 4 TEX
PARAM c[6] = { program.local[0..4],
		{ 0.95019531, 0.010002136, 1.0098619, 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R2.xyz, c[0];
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[2];
MUL R1, R0, R1;
DP3_SAT R2.x, R2, c[3];
ADD R0.y, R2.x, -c[5];
TXP R0.x, fragment.texcoord[5], texture[3], 2D;
MUL R0.y, R0, c[5].z;
MUL R2.x, R0.y, R0;
MUL R0, R1, c[5].x;
MUL R1.w, R2.x, c[1];
MOV R1.xyz, c[1];
MUL_SAT R1.w, R1, c[5];
ADD R1.xyz, R1, c[4].x;
MUL_SAT R1.xyz, R1, R1.w;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 23 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_WorldNorm]
Float 4 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"ps_3_0
; 19 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c5, 0.95019531, -0.01000214, 1.00986195, 4.00000000
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v6
mov r2.xyz, c3
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c2
mul_pp r1, r0, r1
dp3_sat r2.x, c0, r2
add_pp r0.y, r2.x, c5
texldp r0.x, v6, s3
mul_pp r0.y, r0, c5.z
mul r2.x, r0.y, r0
mul_pp r0, r1, c5.x
mul r1.y, r2.x, c1.w
mul_sat r1.w, r1.y, c5
mov r1.x, c4
add r1.xyz, c1, r1.x
mul_sat r1.xyz, r1, r1.w
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 176 // 160 used size, 11 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_WorldNorm] 4
Float 156 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_LeftTex] 2D 2
SetTexture 1 [_TopTex] 2D 1
SetTexture 2 [_FrontTex] 2D 3
SetTexture 3 [_ShadowMapTexture] 2D 0
// 23 instructions, 3 temp regs, 0 temp arrays:
// ALU 17 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedildenbnioohfpbofkeiladjinkkgbekaabaaaaaaaiafaaaaadaaaaaa
cmaaaaaabiabaaaaemabaaaaejfdeheooeaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaankaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaankaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaankaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaankaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaankaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaankaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcleadaaaaeaaaaaaaonaaaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadgcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaad
dcbabaaaaeaaaaaagcbaaaadlcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaabacaaaajbcaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaa
egiccaaaabaaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
pnekibdpaoaaaaahgcaabaaaaaaaaaaaagbbbaaaagaaaaaapgbpbaaaagaaaaaa
efaaaaajpcaabaaaabaaaaaajgafbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeadicaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaaaaaaaaaj
ocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaajaaaaaa
dicaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaa
acaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaa
acaaaaaaaagabaaaadaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaa
abaaaaaaegiocaaaaaaaaaaaahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaddddhddpddddhddpddddhddpddddhddpdiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaab"
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
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_WorldNorm]
Float 4 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 25 ALU, 5 TEX
PARAM c[6] = { program.local[0..4],
		{ 0.95019531, 0.010002136, 1.0098619, 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R2.xyz, c[0];
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[2];
MUL R1, R0, R1;
DP3_SAT R2.x, R2, c[3];
ADD R0.y, R2.x, -c[5];
TXP R0.x, fragment.texcoord[6], texture[3], 2D;
TEX R0.w, fragment.texcoord[5], texture[4], 2D;
MUL R0.z, R0.w, R0.x;
MUL R0.x, R0.y, c[5].z;
MUL R2.x, R0, R0.z;
MUL R0, R1, c[5].x;
MUL R1.w, R2.x, c[1];
MOV R1.xyz, c[1];
MUL_SAT R1.w, R1, c[5];
ADD R1.xyz, R1, c[4].x;
MUL_SAT R1.xyz, R1, R1.w;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 25 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_WorldNorm]
Float 4 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [_LightTexture0] 2D
"ps_3_0
; 20 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c5, 0.95019531, -0.01000214, 1.00986195, 4.00000000
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v6.xy
dcl_texcoord6 v7
mov r2.xyz, c3
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c2
mul_pp r1, r0, r1
dp3_sat r2.x, c0, r2
add_pp r0.y, r2.x, c5
texldp r0.x, v7, s3
texld r0.w, v6, s4
mul r0.z, r0.w, r0.x
mul_pp r0.x, r0.y, c5.z
mul r2.x, r0, r0.z
mul_pp r0, r1, c5.x
mul r1.y, r2.x, c1.w
mul_sat r1.w, r1.y, c5
mov r1.x, c4
add r1.xyz, c1, r1.x
mul_sat r1.xyz, r1, r1.w
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 240 // 224 used size, 12 vars
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Vector 192 [_WorldNorm] 4
Float 220 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_LeftTex] 2D 3
SetTexture 1 [_TopTex] 2D 2
SetTexture 2 [_FrontTex] 2D 4
SetTexture 3 [_LightTexture0] 2D 1
SetTexture 4 [_ShadowMapTexture] 2D 0
// 25 instructions, 3 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 5 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedhidafgchkakkmpnhicfkiemnpjlgbpipabaaaaaaiiafaaaaadaaaaaa
cmaaaaaadaabaaaageabaaaaejfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaapcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaapcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaapcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaapcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaapcaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
amamaaaapcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaaaaaapcaaaaaa
agaaaaaaaaaaaaaaadaaaaaaagaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcbmaeaaaaeaaaaaaaahabaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
adaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaa
adaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaad
mcbabaaaaeaaaaaagcbaaaadlcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaagaaaaaapgbpbaaa
agaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaeaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaaeaaaaaaeghobaaa
adaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaabaaaaaabacaaaajccaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaa
egiccaaaabaaaaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeadicaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaaaaaaaaj
ocaabaaaaaaaaaaaagijcaaaaaaaaaaaajaaaaaapgipcaaaaaaaaaaaanaaaaaa
dicaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
adaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaa
acaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaa
acaaaaaaaagabaaaaeaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaa
abaaaaaaegiocaaaaaaaaaaaalaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaddddhddpddddhddpddddhddpddddhddpdiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaab"
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
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightPositionRange]
Vector 2 [_LightShadowData]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_WorldNorm]
Float 6 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 34 ALU, 5 TEX
PARAM c[10] = { program.local[0..6],
		{ 0.95019531, 0.010002136, 1.0098619, 0.97000003 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
DP3 R2.x, fragment.texcoord[6], fragment.texcoord[6];
RSQ R2.x, R2.x;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[4];
MUL R1, R0, R1;
TEX R0, fragment.texcoord[6], texture[3], CUBE;
DP4 R0.y, R0, c[8];
RCP R2.x, R2.x;
MUL R0.x, R2, c[1].w;
MAD R2.x, -R0, c[7].w, R0.y;
MOV R0.xyz, c[0];
DP3_SAT R0.x, R0, c[5];
MOV R0.w, c[8].x;
ADD R0.x, R0, -c[7].y;
CMP R2.x, R2, c[2], R0.w;
DP3 R0.y, fragment.texcoord[5], fragment.texcoord[5];
TEX R0.w, R0.y, texture[4], 2D;
MUL R0.y, R0.w, R2.x;
MUL R0.x, R0, c[7].z;
MUL R2.x, R0, R0.y;
MUL R0, R1, c[7].x;
MUL R1.w, R2.x, c[3];
MOV R1.xyz, c[3];
MUL_SAT R1.w, R1, c[9].x;
ADD R1.xyz, R1, c[6].x;
MUL_SAT R1.xyz, R1, R1.w;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 34 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightPositionRange]
Vector 2 [_LightShadowData]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_WorldNorm]
Float 6 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] 2D
"ps_3_0
; 29 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
def c7, 0.95019531, -0.01000214, 1.00986195, 0.97000003
def c8, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c9, 4.00000000, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v6.xyz
dcl_texcoord6 v7.xyz
dp3 r2.x, v7, v7
rsq r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c4
mul_pp r1, r0, r1
texld r0, v7, s3
dp4 r0.y, r0, c8
rcp r2.x, r2.x
mul r0.x, r2, c1.w
mad r0.w, -r0.x, c7, r0.y
mov r0.xyz, c5
dp3_sat r0.y, c0, r0
mov r2.x, c2
dp3 r0.x, v6, v6
cmp r0.w, r0, c8.x, r2.x
texld r0.x, r0.x, s4
mul r0.z, r0.x, r0.w
add_pp r0.y, r0, c7
mul_pp r0.x, r0.y, c7.z
mul r2.x, r0, r0.z
mul_pp r0, r1, c7.x
mul r1.y, r2.x, c3.w
mul_sat r1.w, r1.y, c9.x
mov r1.x, c6
add r1.xyz, c3, r1.x
mul_sat r1.xyz, r1, r1.w
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
ConstBuffer "$Globals" 176 // 160 used size, 11 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_WorldNorm] 4
Float 156 [_MinLight]
ConstBuffer "UnityLighting" 720 // 32 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
Vector 16 [_LightPositionRange] 4
ConstBuffer "UnityShadows" 416 // 400 used size, 8 vars
Vector 384 [_LightShadowData] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityShadows" 2
SetTexture 0 [_LeftTex] 2D 3
SetTexture 1 [_TopTex] 2D 2
SetTexture 2 [_FrontTex] 2D 4
SetTexture 3 [_LightTexture0] 2D 1
SetTexture 4 [_ShadowMapTexture] CUBE 0
// 32 instructions, 3 temp regs, 0 temp arrays:
// ALU 24 float, 0 int, 0 uint
// TEX 5 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedcmkgknbcajpgdnhkfjgdcamcckmnmfhmabaaaaaahaagaaaaadaaaaaa
cmaaaaaadaabaaaageabaaaaejfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaapcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaapcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaapcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaapcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaapcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaapcaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaapcaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcaeafaaaaeaaaaaaaebabaaaafjaaaaaeegiocaaaaaaaaaaa
akaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaaacaaaaaa
bjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
fidaaaaeaahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
gcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaa
ahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaahaaaaaaegbcbaaaahaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
omfbhidpefaaaaajpcaabaaaabaaaaaaegbcbaaaahaaaaaaeghobaaaaeaaaaaa
aagabaaaaaaaaaaabbaaaaakccaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaiadpibiaiadlicabibdhimpinfdbdbaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaacaaaaaabiaaaaaaabeaaaaaaaaaiadpbaaaaaahccaabaaaaaaaaaaa
egbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaa
aaaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaabaaaaaabacaaaajccaabaaaaaaaaaaaegiccaaa
aaaaaaaaaiaaaaaaegiccaaaabaaaaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiaeadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaaaaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaa
aaaaaaaaajaaaaaadicaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
aeaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaa
kgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaa
acaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaddddhddpddddhddpddddhddpddddhddpdiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadoaaaaab"
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
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightPositionRange]
Vector 2 [_LightShadowData]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_WorldNorm]
Float 6 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 36 ALU, 6 TEX
PARAM c[10] = { program.local[0..6],
		{ 0.95019531, 0.010002136, 1.0098619, 0.97000003 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
DP3 R2.x, fragment.texcoord[6], fragment.texcoord[6];
RSQ R2.x, R2.x;
TEX R0, fragment.texcoord[1], texture[0], 2D;
TEX R1, fragment.texcoord[2], texture[1], 2D;
ADD R1, R1, -R0;
MAD R0, fragment.texcoord[0].y, R1, R0;
TEX R1, fragment.texcoord[3], texture[2], 2D;
ADD R1, R1, -R0;
MAD R0, fragment.texcoord[0].z, R1, R0;
MUL R1, fragment.color.primary, c[4];
MUL R1, R1, R0;
TEX R0, fragment.texcoord[6], texture[3], CUBE;
DP4 R0.x, R0, c[8];
RCP R2.x, R2.x;
MUL R0.y, R2.x, c[1].w;
MAD R0.w, -R0.y, c[7], R0.x;
MOV R0.xyz, c[0];
DP3_SAT R0.y, R0, c[5];
ADD R0.z, R0.y, -c[7].y;
MOV R2.x, c[8];
CMP R0.x, R0.w, c[2], R2;
DP3 R0.y, fragment.texcoord[5], fragment.texcoord[5];
TEX R0.w, fragment.texcoord[5], texture[5], CUBE;
TEX R2.w, R0.y, texture[4], 2D;
MUL R0.y, R2.w, R0.w;
MUL R0.x, R0.y, R0;
MUL R0.y, R0.z, c[7].z;
MUL R2.x, R0.y, R0;
MUL R0, R1, c[7].x;
MUL R1.w, R2.x, c[3];
MOV R1.xyz, c[3];
MUL_SAT R1.w, R1, c[9].x;
ADD R1.xyz, R1, c[6].x;
MUL_SAT R1.xyz, R1, R1.w;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 36 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightPositionRange]
Vector 2 [_LightShadowData]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_WorldNorm]
Float 6 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"ps_3_0
; 30 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
dcl_cube s5
def c7, 0.95019531, -0.01000214, 1.00986195, 0.97000003
def c8, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c9, 4.00000000, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v6.xyz
dcl_texcoord6 v7.xyz
dp3 r2.x, v7, v7
rsq r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c4
mul_pp r1, r0, r1
texld r0, v7, s3
dp4 r0.y, r0, c8
rcp r2.x, r2.x
mul r0.x, r2, c1.w
mad r0.w, -r0.x, c7, r0.y
mov r0.xyz, c5
dp3_sat r0.x, c0, r0
add_pp r0.y, r0.x, c7
mov r2.x, c2
cmp r0.z, r0.w, c8.x, r2.x
dp3 r0.x, v6, v6
texld r0.w, v6, s5
texld r0.x, r0.x, s4
mul r0.x, r0, r0.w
mul r0.z, r0.x, r0
mul_pp r0.x, r0.y, c7.z
mul r2.x, r0, r0.z
mul_pp r0, r1, c7.x
mul r1.y, r2.x, c3.w
mul_sat r1.w, r1.y, c9.x
mov r1.x, c6
add r1.xyz, c3, r1.x
mul_sat r1.xyz, r1, r1.w
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
ConstBuffer "$Globals" 176 // 160 used size, 11 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_WorldNorm] 4
Float 156 [_MinLight]
ConstBuffer "UnityLighting" 720 // 32 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
Vector 16 [_LightPositionRange] 4
ConstBuffer "UnityShadows" 416 // 400 used size, 8 vars
Vector 384 [_LightShadowData] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityShadows" 2
SetTexture 0 [_LeftTex] 2D 4
SetTexture 1 [_TopTex] 2D 3
SetTexture 2 [_FrontTex] 2D 5
SetTexture 3 [_LightTextureB0] 2D 2
SetTexture 4 [_LightTexture0] CUBE 1
SetTexture 5 [_ShadowMapTexture] CUBE 0
// 34 instructions, 3 temp regs, 0 temp arrays:
// ALU 25 float, 0 int, 0 uint
// TEX 6 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedohogofhehjolnhamfpodilikceljhkhoabaaaaaammagaaaaadaaaaaa
cmaaaaaadaabaaaageabaaaaejfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaapcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaapcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaapcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaapcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaapcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaapcaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaapcaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcgaafaaaaeaaaaaaafiabaaaafjaaaaaeegiocaaaaaaaaaaa
akaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaaacaaaaaa
bjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaa
fkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaaffffaaaafidaaaae
aahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadgcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaad
dcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaaahaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaahaaaaaaegbcbaaaahaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaomfbhidp
efaaaaajpcaabaaaabaaaaaaegbcbaaaahaaaaaaeghobaaaafaaaaaaaagabaaa
aaaaaaaabbaaaaakccaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaiadp
ibiaiadlicabibdhimpinfdbdbaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
acaaaaaabiaaaaaaabeaaaaaaaaaiadpbaaaaaahccaabaaaaaaaaaaaegbcbaaa
agaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaa
eghobaaaadaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaa
agaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabacaaaajccaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaaegiccaaaabaaaaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaapnekibdpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaea
dicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
aaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaa
ajaaaaaadicaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaeaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaia
ebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaa
eghobaaaacaaaaaaaagabaaaafaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaia
ebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaa
egbobaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaadiaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaddddhddpddddhddpddddhddpddddhddpdiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaab"
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
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightShadowData]
Vector 2 [_ShadowOffsets0]
Vector 3 [_ShadowOffsets1]
Vector 4 [_ShadowOffsets2]
Vector 5 [_ShadowOffsets3]
Vector 6 [_LightColor0]
Vector 7 [_Color]
Vector 8 [_WorldNorm]
Float 9 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 47 ALU, 9 TEX
PARAM c[12] = { program.local[0..9],
		{ 0.95019531, 0.010002136, 1.0098619, 0 },
		{ 0.5, 1, 0.25, 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
RCP R2.x, fragment.texcoord[6].w;
MAD R2.zw, fragment.texcoord[6].xyxy, R2.x, c[5].xyxy;
TEX R0, fragment.texcoord[1], texture[0], 2D;
TEX R1, fragment.texcoord[2], texture[1], 2D;
ADD R1, R1, -R0;
MAD R0, fragment.texcoord[0].y, R1, R0;
TEX R1, fragment.texcoord[3], texture[2], 2D;
ADD R1, R1, -R0;
MAD R0, fragment.texcoord[0].z, R1, R0;
MUL R1, fragment.color.primary, c[7];
MUL R0, R1, R0;
TEX R1.x, R2.zwzw, texture[5], 2D;
MUL R0, R0, c[10].x;
MAD R2.zw, fragment.texcoord[6].xyxy, R2.x, c[4].xyxy;
MOV R1.w, R1.x;
TEX R1.x, R2.zwzw, texture[5], 2D;
MAD R2.zw, fragment.texcoord[6].xyxy, R2.x, c[3].xyxy;
MOV R1.z, R1.x;
TEX R1.x, R2.zwzw, texture[5], 2D;
MAD R2.zw, fragment.texcoord[6].xyxy, R2.x, c[2].xyxy;
MOV R1.y, R1.x;
TEX R1.x, R2.zwzw, texture[5], 2D;
MOV R2.y, c[11];
MAD R1, -fragment.texcoord[6].z, R2.x, R1;
CMP R1, R1, c[1].x, R2.y;
DP4 R1.z, R1, c[11].z;
MOV R2.xyz, c[0];
DP3_SAT R1.y, R2, c[8];
DP3 R1.w, fragment.texcoord[5], fragment.texcoord[5];
ADD R2.x, R1.y, -c[10].y;
RCP R1.x, fragment.texcoord[5].w;
MAD R1.xy, fragment.texcoord[5], R1.x, c[11].x;
TEX R2.w, R1, texture[3], 2D;
SLT R1.x, c[10].w, fragment.texcoord[5].z;
TEX R1.w, R1.w, texture[4], 2D;
MUL R1.x, R1, R2.w;
MUL R1.x, R1, R1.w;
MUL R1.x, R1, R1.z;
MUL R1.y, R2.x, c[10].z;
MUL R1.x, R1.y, R1;
MUL R1.w, R1.x, c[6];
MOV R1.xyz, c[6];
MUL_SAT R1.w, R1, c[11];
ADD R1.xyz, R1, c[9].x;
MUL_SAT R1.xyz, R1, R1.w;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 47 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightShadowData]
Vector 2 [_ShadowOffsets0]
Vector 3 [_ShadowOffsets1]
Vector 4 [_ShadowOffsets2]
Vector 5 [_ShadowOffsets3]
Vector 6 [_LightColor0]
Vector 7 [_Color]
Vector 8 [_WorldNorm]
Float 9 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"ps_3_0
; 38 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c10, 0.95019531, -0.01000214, 1.00986195, 0.50000000
def c11, 0.00000000, 1.00000000, 0.25000000, 4.00000000
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v6
dcl_texcoord6 v7
rcp r2.z, v7.w
mad r2.xy, v7, r2.z, c5
texld r0, v2, s0
texld r1, v3, s1
add_pp r1, r1, -r0
mad_pp r0, v1.y, r1, r0
texld r1, v4, s2
add_pp r1, r1, -r0
mad_pp r0, v1.z, r1, r0
mul_pp r1, v0, c7
mul_pp r0, r1, r0
texld r1.x, r2, s5
mul_pp r0, r0, c10.x
mad r2.xy, v7, r2.z, c4
mov r1.w, r1.x
texld r1.x, r2, s5
mad r2.xy, v7, r2.z, c3
mov r1.z, r1.x
texld r1.x, r2, s5
mad r2.xy, v7, r2.z, c2
mov r1.y, r1.x
texld r1.x, r2, s5
mov r2.x, c1
mad r1, -v7.z, r2.z, r1
cmp r1, r1, c11.y, r2.x
dp4_pp r1.z, r1, c11.z
mov r2.xyz, c8
dp3_sat r1.y, c0, r2
add_pp r2.y, r1, c10
rcp r1.x, v6.w
mad r1.xy, v6, r1.x, c10.w
texld r1.w, r1, s3
dp3 r2.x, v6, v6
cmp r1.y, -v6.z, c11.x, c11
mul_pp r1.y, r1, r1.w
texld r1.x, r2.x, s4
mul_pp r1.x, r1.y, r1
mul_pp r1.x, r1, r1.z
mul_pp r1.y, r2, c10.z
mul r1.x, r1.y, r1
mul r1.x, r1, c6.w
mul_sat r1.w, r1.x, c11
mov r1.y, c9.x
add r1.xyz, c6, r1.y
mul_sat r1.xyz, r1, r1.w
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 240 // 224 used size, 12 vars
Vector 16 [_ShadowOffsets0] 4
Vector 32 [_ShadowOffsets1] 4
Vector 48 [_ShadowOffsets2] 4
Vector 64 [_ShadowOffsets3] 4
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Vector 192 [_WorldNorm] 4
Float 220 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityShadows" 416 // 400 used size, 8 vars
Vector 384 [_LightShadowData] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityShadows" 2
SetTexture 0 [_LeftTex] 2D 4
SetTexture 1 [_TopTex] 2D 3
SetTexture 2 [_FrontTex] 2D 5
SetTexture 3 [_LightTexture0] 2D 1
SetTexture 4 [_LightTextureB0] 2D 2
SetTexture 5 [_ShadowMapTexture] 2D 0
// 46 instructions, 3 temp regs, 0 temp arrays:
// ALU 30 float, 0 int, 1 uint
// TEX 9 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecednomeciohfnfcjgnpoochabpgldlcfcipabaaaaaaeiaiaaaaadaaaaaa
cmaaaaaadaabaaaageabaaaaejfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaapcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaapcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaapcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaapcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaapcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaapcaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapapaaaapcaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcnmagaaaaeaaaaaaalhabaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaa
fkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaae
aahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadgcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaad
dcbabaaaaeaaaaaagcbaaaadpcbabaaaagaaaaaagcbaaaadpcbabaaaahaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahhcaabaaaaaaaaaaa
egbcbaaaahaaaaaapgbpbaaaahaaaaaaaaaaaaaidcaabaaaabaaaaaaegaabaaa
aaaaaaaaegiacaaaaaaaaaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaaaaaaaaaidcaabaaaacaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaadgaaaaafccaabaaa
abaaaaaaakaabaaaacaaaaaaaaaaaaaidcaabaaaacaaaaaaegaabaaaaaaaaaaa
egiacaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaafaaaaaaaagabaaaaaaaaaaadgaaaaafecaabaaaabaaaaaaakaabaaa
acaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaa
aeaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaafaaaaaa
aagabaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaakaabaaaacaaaaaadbaaaaah
pcaabaaaaaaaaaaaegaobaaaabaaaaaakgakbaaaaaaaaaaadhaaaaanpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaagiacaaaacaaaaaabiaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpbbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaiadoaoaaaaahgcaabaaaaaaaaaaa
agbbbaaaagaaaaaapgbpbaaaagaaaaaaaaaaaaakgcaabaaaaaaaaaaafgagbaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaaaaefaaaaajpcaabaaa
abaaaaaajgafbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadbaaaaah
ccaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaagaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
dkaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaa
agaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaakgakbaaaaaaaaaaa
eghobaaaaeaaaaaaaagabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaabacaaaajccaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaa
egiccaaaabaaaaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeadicaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaaaaaaaaj
ocaabaaaaaaaaaaaagijcaaaaaaaaaaaajaaaaaapgipcaaaaaaaaaaaanaaaaaa
dicaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aeaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaa
acaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaa
acaaaaaaaagabaaaafaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaa
abaaaaaaegiocaaaaaaaaaaaalaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaddddhddpddddhddpddddhddpddddhddpdiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaab"
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
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightShadowData]
Vector 2 [_ShadowOffsets0]
Vector 3 [_ShadowOffsets1]
Vector 4 [_ShadowOffsets2]
Vector 5 [_ShadowOffsets3]
Vector 6 [_LightColor0]
Vector 7 [_Color]
Vector 8 [_WorldNorm]
Float 9 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 47 ALU, 9 TEX
OPTION ARB_fragment_program_shadow;
PARAM c[12] = { program.local[0..9],
		{ 0.95019531, 0.010002136, 1.0098619, 0 },
		{ 0.5, 1, 0.25, 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
RCP R3.x, fragment.texcoord[6].w;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R2, fragment.texcoord[0].z, R0, R1;
MUL R1, fragment.color.primary, c[7];
MUL R2, R1, R2;
MAD R0.xyz, fragment.texcoord[6], R3.x, c[5];
TEX R0.x, R0, texture[5], SHADOW2D;
MOV R0.w, R0.x;
MAD R0.xyz, fragment.texcoord[6], R3.x, c[4];
TEX R0.x, R0, texture[5], SHADOW2D;
MAD R1.xyz, fragment.texcoord[6], R3.x, c[3];
TEX R1.x, R1, texture[5], SHADOW2D;
MOV R0.z, R0.x;
MOV R0.y, R1.x;
MOV R0.x, c[11].y;
ADD R1.w, R0.x, -c[1].x;
MAD R1.xyz, fragment.texcoord[6], R3.x, c[2];
TEX R0.x, R1, texture[5], SHADOW2D;
MAD R0, R0, R1.w, c[1].x;
DP4 R0.z, R0, c[11].z;
MOV R1.xyz, c[0];
DP3_SAT R0.x, R1, c[8];
DP3 R1.y, fragment.texcoord[5], fragment.texcoord[5];
ADD R1.x, R0, -c[10].y;
RCP R0.y, fragment.texcoord[5].w;
MAD R0.xy, fragment.texcoord[5], R0.y, c[11].x;
TEX R0.w, R0, texture[3], 2D;
SLT R0.x, c[10].w, fragment.texcoord[5].z;
TEX R1.w, R1.y, texture[4], 2D;
MUL R0.x, R0, R0.w;
MUL R0.x, R0, R1.w;
MUL R0.y, R0.x, R0.z;
MUL R0.x, R1, c[10].z;
MUL R1.x, R0, R0.y;
MUL R1.w, R1.x, c[6];
MUL R0, R2, c[10].x;
MOV R1.xyz, c[6];
MUL_SAT R1.w, R1, c[11];
ADD R1.xyz, R1, c[9].x;
MUL_SAT R1.xyz, R1, R1.w;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 47 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightShadowData]
Vector 2 [_ShadowOffsets0]
Vector 3 [_ShadowOffsets1]
Vector 4 [_ShadowOffsets2]
Vector 5 [_ShadowOffsets3]
Vector 6 [_LightColor0]
Vector 7 [_Color]
Vector 8 [_WorldNorm]
Float 9 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"ps_3_0
; 38 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c10, 0.95019531, -0.01000214, 1.00986195, 0.50000000
def c11, 0.00000000, 1.00000000, 0.25000000, 4.00000000
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v6
dcl_texcoord6 v7
rcp r3.x, v7.w
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r2, v1.z, r0, r1
mul_pp r1, v0, c7
mul_pp r2, r1, r2
mad r0.xyz, v7, r3.x, c5
texld r0.x, r0, s5
mov_pp r0.w, r0.x
mad r0.xyz, v7, r3.x, c4
texld r0.x, r0, s5
mad r1.xyz, v7, r3.x, c3
texld r1.x, r1, s5
mov_pp r0.z, r0.x
mov_pp r0.y, r1.x
mov r0.x, c1
add r1.w, c11.y, -r0.x
mad r1.xyz, v7, r3.x, c2
texld r0.x, r1, s5
mad r0, r0, r1.w, c1.x
dp4_pp r0.y, r0, c11.z
mov r1.xyz, c8
dp3_sat r0.x, c0, r1
add_pp r0.z, r0.x, c10.y
rcp r0.w, v6.w
mad r1.xy, v6, r0.w, c10.w
texld r0.w, r1, s3
cmp r1.x, -v6.z, c11, c11.y
dp3 r0.x, v6, v6
mul_pp r0.w, r1.x, r0
texld r0.x, r0.x, s4
mul_pp r0.x, r0.w, r0
mul_pp r0.y, r0.x, r0
mul_pp r0.x, r0.z, c10.z
mul r1.x, r0, r0.y
mul r1.y, r1.x, c6.w
mul_pp r0, r2, c10.x
mul_sat r1.w, r1.y, c11
mov r1.x, c9
add r1.xyz, c6, r1.x
mul_sat r1.xyz, r1, r1.w
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
ConstBuffer "$Globals" 240 // 224 used size, 12 vars
Vector 16 [_ShadowOffsets0] 4
Vector 32 [_ShadowOffsets1] 4
Vector 48 [_ShadowOffsets2] 4
Vector 64 [_ShadowOffsets3] 4
Vector 144 [_LightColor0] 4
Vector 176 [_Color] 4
Vector 192 [_WorldNorm] 4
Float 220 [_MinLight]
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityShadows" 416 // 400 used size, 8 vars
Vector 384 [_LightShadowData] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityShadows" 2
SetTexture 0 [_LeftTex] 2D 4
SetTexture 1 [_TopTex] 2D 3
SetTexture 2 [_FrontTex] 2D 5
SetTexture 3 [_LightTexture0] 2D 1
SetTexture 4 [_LightTextureB0] 2D 2
SetTexture 5 [_ShadowMapTexture] 2D 0
// 43 instructions, 3 temp regs, 0 temp arrays:
// ALU 31 float, 0 int, 1 uint
// TEX 5 (0 load, 4 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedbkpkhfeedgafahgloiojjaddgldpcclbabaaaaaaciaiaaaaadaaaaaa
cmaaaaaadaabaaaageabaaaaejfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaapcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaapcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaapcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaapcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaapcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaapcaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapapaaaapcaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefclmagaaaaeaaaaaaakpabaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bjaaaaaafkaiaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaa
fkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaae
aahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadgcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaad
dcbabaaaaeaaaaaagcbaaaadpcbabaaaagaaaaaagcbaaaadpcbabaaaahaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaajbcaabaaaaaaaaaaa
akiacaiaebaaaaaaacaaaaaabiaaaaaaabeaaaaaaaaaiadpaoaaaaahocaabaaa
aaaaaaaaagbjbaaaahaaaaaapgbpbaaaahaaaaaaaaaaaaaihcaabaaaabaaaaaa
jgahbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaehaaaaalbcaabaaaabaaaaaa
egaabaaaabaaaaaaaghabaaaafaaaaaaaagabaaaaaaaaaaackaabaaaabaaaaaa
aaaaaaaihcaabaaaacaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaa
ehaaaaalccaabaaaabaaaaaaegaabaaaacaaaaaaaghabaaaafaaaaaaaagabaaa
aaaaaaaackaabaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaajgahbaaaaaaaaaaa
egiccaaaaaaaaaaaadaaaaaaaaaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agijcaaaaaaaaaaaaeaaaaaaehaaaaalicaabaaaabaaaaaajgafbaaaaaaaaaaa
aghabaaaafaaaaaaaagabaaaaaaaaaaadkaabaaaaaaaaaaaehaaaaalecaabaaa
abaaaaaaegaabaaaacaaaaaaaghabaaaafaaaaaaaagabaaaaaaaaaaackaabaaa
acaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaaagaabaaaaaaaaaaa
agiacaaaacaaaaaabiaaaaaabbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaiadoaoaaaaahgcaabaaaaaaaaaaa
agbbbaaaagaaaaaapgbpbaaaagaaaaaaaaaaaaakgcaabaaaaaaaaaaafgagbaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaaaaefaaaaajpcaabaaa
abaaaaaajgafbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadbaaaaah
ccaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaagaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
dkaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaa
agaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaakgakbaaaaaaaaaaa
eghobaaaaeaaaaaaaagabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaabacaaaajccaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaa
egiccaaaabaaaaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeadicaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaaaaaaaaj
ocaabaaaaaaaaaaaagijcaaaaaaaaaaaajaaaaaapgipcaaaaaaaaaaaanaaaaaa
dicaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aeaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaa
acaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaa
acaaaaaaaagabaaaafaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaa
abaaaaaaegiocaaaaaaaaaaaalaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaddddhddpddddhddpddddhddpddddhddpdiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaab"
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
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightPositionRange]
Vector 2 [_LightShadowData]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_WorldNorm]
Float 6 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 45 ALU, 8 TEX
PARAM c[11] = { program.local[0..6],
		{ 0.95019531, 0.010002136, 1.0098619, 0.97000003 },
		{ 0.0078125, -0.0078125, 1, 0.25 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R2, R0, -R1;
MAD R2, fragment.texcoord[0].z, R2, R1;
MUL R1, fragment.color.primary, c[4];
MUL R2, R1, R2;
ADD R0.xyz, fragment.texcoord[6], c[8].xyyw;
TEX R0, R0, texture[3], CUBE;
DP4 R3.w, R0, c[9];
ADD R0.xyz, fragment.texcoord[6], c[8].yxyw;
TEX R0, R0, texture[3], CUBE;
DP4 R3.z, R0, c[9];
ADD R1.xyz, fragment.texcoord[6], c[8].yyxw;
TEX R1, R1, texture[3], CUBE;
DP4 R3.y, R1, c[9];
ADD R0.xyz, fragment.texcoord[6], c[8].x;
TEX R0, R0, texture[3], CUBE;
DP3 R1.x, fragment.texcoord[6], fragment.texcoord[6];
RSQ R1.x, R1.x;
DP4 R3.x, R0, c[9];
RCP R0.x, R1.x;
MUL R0.x, R0, c[1].w;
MOV R1.x, c[8].z;
MAD R0, -R0.x, c[7].w, R3;
CMP R0, R0, c[2].x, R1.x;
DP4 R0.z, R0, c[8].w;
MOV R1.xyz, c[0];
DP3_SAT R0.x, R1, c[5];
DP3 R0.y, fragment.texcoord[5], fragment.texcoord[5];
TEX R0.w, R0.y, texture[4], 2D;
ADD R0.x, R0, -c[7].y;
MUL R0.y, R0.w, R0.z;
MUL R0.x, R0, c[7].z;
MUL R1.x, R0, R0.y;
MUL R1.w, R1.x, c[3];
MUL R0, R2, c[7].x;
MOV R1.xyz, c[3];
MUL_SAT R1.w, R1, c[10].x;
ADD R1.xyz, R1, c[6].x;
MUL_SAT R1.xyz, R1, R1.w;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 45 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightPositionRange]
Vector 2 [_LightShadowData]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_WorldNorm]
Float 6 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] 2D
"ps_3_0
; 37 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
def c7, 0.95019531, -0.01000214, 1.00986195, 0.00781250
def c8, 0.00781250, -0.00781250, 0.97000003, 1.00000000
def c9, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c10, 0.25000000, 4.00000000, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v6.xyz
dcl_texcoord6 v7.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r2, r0, -r1
mad_pp r2, v1.z, r2, r1
mul_pp r1, v0, c4
mul_pp r2, r1, r2
add r0.xyz, v7, c8.xyyw
texld r0, r0, s3
dp4 r3.w, r0, c9
add r0.xyz, v7, c8.yxyw
texld r0, r0, s3
dp4 r3.z, r0, c9
add r1.xyz, v7, c8.yyxw
texld r1, r1, s3
dp4 r3.y, r1, c9
add r0.xyz, v7, c7.w
texld r0, r0, s3
dp3 r1.x, v7, v7
rsq r1.x, r1.x
dp4 r3.x, r0, c9
rcp r0.x, r1.x
mul r0.x, r0, c1.w
mov r1.x, c2
mad r0, -r0.x, c8.z, r3
cmp r0, r0, c8.w, r1.x
dp4_pp r0.z, r0, c10.x
mov r1.xyz, c5
dp3_sat r0.y, c0, r1
dp3 r0.x, v6, v6
texld r0.x, r0.x, s4
mul r0.z, r0.x, r0
add_pp r0.y, r0, c7
mul_pp r0.x, r0.y, c7.z
mul r1.x, r0, r0.z
mul r1.y, r1.x, c3.w
mul_pp r0, r2, c7.x
mul_sat r1.w, r1.y, c10.y
mov r1.x, c6
add r1.xyz, c3, r1.x
mul_sat r1.xyz, r1, r1.w
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 176 // 160 used size, 11 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_WorldNorm] 4
Float 156 [_MinLight]
ConstBuffer "UnityLighting" 720 // 32 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
Vector 16 [_LightPositionRange] 4
ConstBuffer "UnityShadows" 416 // 400 used size, 8 vars
Vector 384 [_LightShadowData] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityShadows" 2
SetTexture 0 [_LeftTex] 2D 3
SetTexture 1 [_TopTex] 2D 2
SetTexture 2 [_FrontTex] 2D 4
SetTexture 3 [_LightTexture0] 2D 1
SetTexture 4 [_ShadowMapTexture] CUBE 0
// 43 instructions, 3 temp regs, 0 temp arrays:
// ALU 32 float, 0 int, 0 uint
// TEX 8 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfdnpohfbgjimapgpbomopnagfjpcbjbbabaaaaaaciaiaaaaadaaaaaa
cmaaaaaadaabaaaageabaaaaejfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaapcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaapcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaapcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaapcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaapcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaapcaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaapcaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefclmagaaaaeaaaaaaakpabaaaafjaaaaaeegiocaaaaaaaaaaa
akaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaaacaaaaaa
bjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
fidaaaaeaahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
gcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaa
ahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaahaaaaaaegbcbaaaahaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
omfbhidpaaaaaaakocaabaaaaaaaaaaaagbjbaaaahaaaaaaaceaaaaaaaaaaaaa
aaaaaadmaaaaaadmaaaaaadmefaaaaajpcaabaaaabaaaaaajgahbaaaaaaaaaaa
eghobaaaaeaaaaaaaagabaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaiadpibiaiadlicabibdhimpinfdbaaaaaaakocaabaaa
aaaaaaaaagbjbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaalmaaaaaalmaaaaaadm
efaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaa
aaaaaaaabbaaaaakccaabaaaabaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaiadp
ibiaiadlicabibdhimpinfdbaaaaaaakocaabaaaaaaaaaaaagbjbaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaaalmaaaaaadmaaaaaalmefaaaaajpcaabaaaacaaaaaa
jgahbaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaaaaaaaaaabbaaaaakecaabaaa
abaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaiadpibiaiadlicabibdhimpinfdb
aaaaaaakocaabaaaaaaaaaaaagbjbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaadm
aaaaaalmaaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaa
aeaaaaaaaagabaaaaaaaaaaabbaaaaakicaabaaaabaaaaaaegaobaaaacaaaaaa
aceaaaaaaaaaiadpibiaiadlicabibdhimpinfdbdbaaaaahpcaabaaaaaaaaaaa
egaobaaaabaaaaaaagaabaaaaaaaaaaadhaaaaanpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaagiacaaaacaaaaaabiaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiado
aaaaiadoaaaaiadoaaaaiadobaaaaaahccaabaaaaaaaaaaaegbcbaaaagaaaaaa
egbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaa
adaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaabaaaaaabacaaaajccaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaa
egiccaaaabaaaaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeadicaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaaaaaaaaaj
ocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaajaaaaaa
dicaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
adaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaa
acaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaa
acaaaaaaaagabaaaaeaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaa
abaaaaaaegiocaaaaaaaaaaaahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaddddhddpddddhddpddddhddpddddhddpdiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaab"
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
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightPositionRange]
Vector 2 [_LightShadowData]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_WorldNorm]
Float 6 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 47 ALU, 9 TEX
PARAM c[11] = { program.local[0..6],
		{ 0.95019531, 0.010002136, 1.0098619, 0.97000003 },
		{ 0.0078125, -0.0078125, 1, 0.25 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R2, R0, -R1;
MAD R2, fragment.texcoord[0].z, R2, R1;
MUL R1, fragment.color.primary, c[4];
MUL R2, R1, R2;
ADD R0.xyz, fragment.texcoord[6], c[8].xyyw;
TEX R0, R0, texture[3], CUBE;
DP4 R3.w, R0, c[9];
ADD R0.xyz, fragment.texcoord[6], c[8].yxyw;
TEX R0, R0, texture[3], CUBE;
DP4 R3.z, R0, c[9];
ADD R1.xyz, fragment.texcoord[6], c[8].yyxw;
TEX R1, R1, texture[3], CUBE;
DP4 R3.y, R1, c[9];
DP3 R0.w, fragment.texcoord[6], fragment.texcoord[6];
RSQ R1.x, R0.w;
ADD R0.xyz, fragment.texcoord[6], c[8].x;
TEX R0, R0, texture[3], CUBE;
RCP R1.x, R1.x;
DP4 R3.x, R0, c[9];
MUL R0.x, R1, c[1].w;
MOV R1.xyz, c[0];
DP3_SAT R1.x, R1, c[5];
MOV R1.w, c[8].z;
MAD R0, -R0.x, c[7].w, R3;
CMP R0, R0, c[2].x, R1.w;
DP4 R0.z, R0, c[8].w;
ADD R0.x, R1, -c[7].y;
DP3 R0.y, fragment.texcoord[5], fragment.texcoord[5];
TEX R1.w, R0.y, texture[4], 2D;
TEX R0.w, fragment.texcoord[5], texture[5], CUBE;
MUL R0.y, R1.w, R0.w;
MUL R0.y, R0, R0.z;
MUL R0.x, R0, c[7].z;
MUL R1.x, R0, R0.y;
MUL R1.w, R1.x, c[3];
MUL R0, R2, c[7].x;
MOV R1.xyz, c[3];
MUL_SAT R1.w, R1, c[10].x;
ADD R1.xyz, R1, c[6].x;
MUL_SAT R1.xyz, R1, R1.w;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 47 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightPositionRange]
Vector 2 [_LightShadowData]
Vector 3 [_LightColor0]
Vector 4 [_Color]
Vector 5 [_WorldNorm]
Float 6 [_MinLight]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"ps_3_0
; 38 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
dcl_cube s5
def c7, 0.95019531, -0.01000214, 1.00986195, 0.00781250
def c8, 0.00781250, -0.00781250, 0.97000003, 1.00000000
def c9, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c10, 0.25000000, 4.00000000, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v6.xyz
dcl_texcoord6 v7.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r2, r0, -r1
mad_pp r2, v1.z, r2, r1
mul_pp r1, v0, c4
mul_pp r2, r1, r2
add r0.xyz, v7, c8.xyyw
texld r0, r0, s3
dp4 r3.w, r0, c9
add r0.xyz, v7, c8.yxyw
texld r0, r0, s3
dp4 r3.z, r0, c9
add r1.xyz, v7, c8.yyxw
texld r1, r1, s3
dp4 r3.y, r1, c9
dp3 r0.w, v7, v7
rsq r1.x, r0.w
add r0.xyz, v7, c7.w
texld r0, r0, s3
rcp r1.x, r1.x
dp4 r3.x, r0, c9
mul r0.x, r1, c1.w
mov r1.xyz, c5
dp3_sat r1.x, c0, r1
mov r1.w, c2.x
mad r0, -r0.x, c8.z, r3
cmp r0, r0, c8.w, r1.w
dp4_pp r0.z, r0, c10.x
dp3 r0.x, v6, v6
add_pp r0.y, r1.x, c7
texld r0.w, v6, s5
texld r0.x, r0.x, s4
mul r0.x, r0, r0.w
mul r0.z, r0.x, r0
mul_pp r0.x, r0.y, c7.z
mul r1.x, r0, r0.z
mul r1.y, r1.x, c3.w
mul_pp r0, r2, c7.x
mul_sat r1.w, r1.y, c10.y
mov r1.x, c6
add r1.xyz, c3, r1.x
mul_sat r1.xyz, r1, r1.w
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 176 // 160 used size, 11 vars
Vector 80 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_WorldNorm] 4
Float 156 [_MinLight]
ConstBuffer "UnityLighting" 720 // 32 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
Vector 16 [_LightPositionRange] 4
ConstBuffer "UnityShadows" 416 // 400 used size, 8 vars
Vector 384 [_LightShadowData] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityShadows" 2
SetTexture 0 [_LeftTex] 2D 4
SetTexture 1 [_TopTex] 2D 3
SetTexture 2 [_FrontTex] 2D 5
SetTexture 3 [_LightTextureB0] 2D 2
SetTexture 4 [_LightTexture0] CUBE 1
SetTexture 5 [_ShadowMapTexture] CUBE 0
// 45 instructions, 3 temp regs, 0 temp arrays:
// ALU 33 float, 0 int, 0 uint
// TEX 9 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedbjhfgdhnkkjkgkjbgenpehbpdbhlnhnlabaaaaaaieaiaaaaadaaaaaa
cmaaaaaadaabaaaageabaaaaejfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaapcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaapcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaapcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaapcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaapcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaapcaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaapcaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcbiahaaaaeaaaaaaamgabaaaafjaaaaaeegiocaaaaaaaaaaa
akaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaafjaaaaaeegiocaaaacaaaaaa
bjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaa
fkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaaffffaaaafidaaaae
aahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadgcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaad
dcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaaahaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaahaaaaaaegbcbaaaahaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaomfbhidp
aaaaaaakocaabaaaaaaaaaaaagbjbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaadm
aaaaaadmaaaaaadmefaaaaajpcaabaaaabaaaaaajgahbaaaaaaaaaaaeghobaaa
afaaaaaaaagabaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaaaaiadpibiaiadlicabibdhimpinfdbaaaaaaakocaabaaaaaaaaaaa
agbjbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaalmaaaaaalmaaaaaadmefaaaaaj
pcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaa
bbaaaaakccaabaaaabaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaiadpibiaiadl
icabibdhimpinfdbaaaaaaakocaabaaaaaaaaaaaagbjbaaaahaaaaaaaceaaaaa
aaaaaaaaaaaaaalmaaaaaadmaaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaa
aaaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaabbaaaaakecaabaaaabaaaaaa
egaobaaaacaaaaaaaceaaaaaaaaaiadpibiaiadlicabibdhimpinfdbaaaaaaak
ocaabaaaaaaaaaaaagbjbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaadmaaaaaalm
aaaaaalmefaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaaafaaaaaa
aagabaaaaaaaaaaabbaaaaakicaabaaaabaaaaaaegaobaaaacaaaaaaaceaaaaa
aaaaiadpibiaiadlicabibdhimpinfdbdbaaaaahpcaabaaaaaaaaaaaegaobaaa
abaaaaaaagaabaaaaaaaaaaadhaaaaanpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
agiacaaaacaaaaaabiaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiado
aaaaiadoaaaaiadobaaaaaahccaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaa
agaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaadaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaaagaaaaaaeghobaaa
aeaaaaaaaagabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaa
dkaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaabacaaaajccaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegiccaaa
abaaaaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeadicaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaaaaaaaaajocaabaaa
aaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaajaaaaaadicaaaah
hcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaeaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaa
aagabaaaafaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadiaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
ddddhddpddddhddpddddhddpddddhddpdiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
doaaaaab"
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