Shader "CloudParticle" {
Properties {
	_TopTex ("Particle Texture", 2D) = "white" {}
	_LeftTex ("Particle Texture", 2D) = "white" {}
	_FrontTex ("Particle Texture", 2D) = "white" {}
	_Color ("Color Tint", Color) = (1,1,1,1)
}

Category {
	
	Lighting On
	ZWrite Off
	Cull Off
	Blend OneMinusDstColor One
	Tags { 
	"Queue"="Transparent" 
	"IgnoreProjector"="True" 
	"RenderType"="Transparent" 
	}

	SubShader {
		Pass {
		
			Program "vp" {
// Vertex combos: 1
//   opengl - ALU: 67 to 67
//   d3d9 - ALU: 66 to 66
//   d3d11 - ALU: 37 to 37, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 37 to 37, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_World2Object]
Vector 14 [unity_Scale]
"!!ARBvp1.0
# 67 ALU
PARAM c[15] = { { 0, 1, 2, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R1.xyz, c[13];
MOV R1.w, c[0].y;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MUL R0.xyz, R0, c[14].w;
ADD R0.xyz, R0, -c[0].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R3.xyz, R0.w, R0;
MUL R1.xy, vertex.texcoord[0], c[0].z;
SLT R0.x, c[0], -R3;
SLT R0.y, -R3.x, c[0].x;
ADD R0.w, R0.x, -R0.y;
ADD R0.xy, R1, -c[0].y;
SLT R1.x, R1, c[0].y;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R1.x;
SLT R1.x, c[0], R0.y;
SLT R1.y, R1, c[0];
ADD R3.w, R1.x, -R1.y;
MUL R1.y, R0.w, R3.w;
MUL R1.x, R0.w, R0.z;
MUL R2.x, R3.y, R1.y;
MOV R0.w, vertex.position;
MOV R1.yzw, R0.xyxw;
MAD R1.x, R3.z, R1, R2;
DP4 R2.y, R1, c[2];
DP4 R2.x, R1, c[1];
MOV R1.w, vertex.position;
MOV R1.xyz, c[0].x;
DP4 R4.y, R1, c[2];
DP4 R4.x, R1, c[1];
ADD R2.xy, -R4, R2;
SLT R2.w, -R3.y, c[0].x;
SLT R2.z, c[0].x, -R3.y;
ADD R2.z, R2, -R2.w;
ADD result.texcoord[1].xy, R2, c[0].w;
MUL R2.x, R3.w, R2.z;
MUL R2.y, R0.z, R2.z;
MUL R4.z, R3, R2.x;
MAD R2.y, R3.x, R2, R4.z;
MOV R2.xzw, R0.xyyw;
DP4 R4.w, R2, c[2];
SLT R4.z, c[0].x, -R3;
SLT R5.x, -R3.z, c[0];
ADD R5.x, R4.z, -R5;
DP4 R4.z, R2, c[1];
ADD R2.xy, -R4, R4.zwzw;
MUL R2.z, R3.w, R5.x;
ADD result.texcoord[2].xy, R2, c[0].w;
MUL R2.z, R3.y, R2;
MUL R0.z, R0, R5.x;
MAD R0.z, R3.x, R0, R2;
DP4 R2.x, R0, c[1];
DP4 R2.y, R0, c[2];
ADD R0.xy, -R4, R2;
DP4 R4.z, R1, c[3];
DP4 R4.w, R1, c[4];
ADD R1, R4, vertex.position;
ADD result.texcoord[3].xy, R0, c[0].w;
DP4 result.position.w, R1, c[8];
DP4 result.position.z, R1, c[7];
DP4 result.position.y, R1, c[6];
DP4 result.position.x, R1, c[5];
MUL result.texcoord[0].xyz, R3, R3;
MOV result.color, vertex.color;
END
# 67 instructions, 6 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_World2Object]
Vector 13 [unity_Scale]
"vs_2_0
; 66 ALU
def c14, 0.00000000, 1.00000000, -0.00000000, 0.50000000
def c15, 2.00000000, -1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r1.xyz, c12
mov r1.w, c14.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mul r0.xyz, r0, c13.w
add r0.xyz, r0, c14.z
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r3.xyz, r0.w, r0
mad r0.xy, v2, c15.x, c15.y
slt r1.x, r0, -r0
slt r1.y, r0, -r0
slt r0.z, r3.x, -r3.x
slt r0.w, -r3.x, r3.x
sub r0.w, r0.z, r0
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r1.x
slt r1.x, -r0.y, r0.y
sub r3.w, r1.x, r1.y
mul r1.y, r0.w, r3.w
mul r1.x, r0.w, r0.z
mul r2.x, r3.y, r1.y
mov r0.w, v0
mov r1.yzw, r0.xyxw
mad r1.x, r3.z, r1, r2
dp4 r2.y, r1, c1
dp4 r2.x, r1, c0
mov r1.w, v0
mov r1.xyz, c14.x
dp4 r4.y, r1, c1
dp4 r4.x, r1, c0
add r2.xy, -r4, r2
slt r2.w, -r3.y, r3.y
slt r2.z, r3.y, -r3.y
sub r2.z, r2, r2.w
add oT1.xy, r2, c14.w
mul r2.x, r3.w, r2.z
mul r2.y, r0.z, r2.z
mul r4.z, r3, r2.x
mad r2.y, r3.x, r2, r4.z
mov r2.xzw, r0.xyyw
dp4 r4.w, r2, c1
slt r4.z, r3, -r3
slt r5.x, -r3.z, r3.z
sub r5.x, r4.z, r5
dp4 r4.z, r2, c0
add r2.xy, -r4, r4.zwzw
mul r2.z, r3.w, r5.x
add oT2.xy, r2, c14.w
mul r2.z, r3.y, r2
mul r0.z, r0, r5.x
mad r0.z, r3.x, r0, r2
dp4 r2.x, r0, c0
dp4 r2.y, r0, c1
add r0.xy, -r4, r2
dp4 r4.z, r1, c2
dp4 r4.w, r1, c3
add r1, r4, v0
add oT3.xy, r0, c14.w
dp4 oPos.w, r1, c7
dp4 oPos.z, r1, c6
dp4 oPos.y, r1, c5
dp4 oPos.x, r1, c4
mul oT0.xyz, r3, r3
mov oD0, v1
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
BindCB "UnityPerFrame" 2
// 41 instructions, 5 temp regs, 0 temp arrays:
// ALU 33 float, 4 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedakelbdncebbiibdojdlmplhlhenkhfnlabaaaaaajmahaaaaadaaaaaa
cmaaaaaajmaaaaaafiabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
leaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaakkaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaakkaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcdmagaaaa
eaaaabaaipabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaa
abaaaaaabfaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaa
abaaaaaadiaaaaajpcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaacgiecaaa
abaaaaaabbaaaaaadcaaaaalpcaabaaaaaaaaaaacgiecaaaabaaaaaabaaaaaaa
agiacaaaaaaaaaaaaeaaaaaaegaobaaaaaaaaaaadcaaaaalpcaabaaaaaaaaaaa
cgiecaaaabaaaaaabcaaaaaakgikcaaaaaaaaaaaaeaaaaaaegaobaaaaaaaaaaa
aaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaacgiecaaaabaaaaaabdaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaapgipcaaaabaaaaaabeaaaaaa
baaaaaahbcaabaaaabaaaaaaigadbaaaaaaaaaaaigadbaaaaaaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaaacaaaaaaogaibaaaaaaaaaaa
ogaibaaaaaaaaaaadbaaaaalpcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaogaibaiaebaaaaaaaaaaaaaadbaaaaalpcaabaaaacaaaaaa
ogaibaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaappcaabaaaacaaaaaaagbfbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdbaaaaak
pcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaa
acaaaaaadbaaaaakpcaabaaaaeaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaipcaabaaaadaaaaaaegaobaiaebaaaaaa
adaaaaaaegaobaaaaeaaaaaacgaaaaaiaanaaaaapcaabaaaaeaaaaaaegaobaaa
abaaaaaaegaobaaaadaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaajgafbaaa
abaaaaaapgapbaaaadaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaa
claaaaafpcaabaaaadaaaaaaegaobaaaaeaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaaaaaaaaaegaobaaaadaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaa
abaaaaaamgaabaaaaaaaaaaajgafbaaaadaaaaaaaaaaaaahecaabaaaaaaaaaaa
dkaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaa
acaaaaaaegiacaaaabaaaaaaaeaaaaaadcaaaaakjcaabaaaaaaaaaaaagiecaaa
abaaaaaaafaaaaaaagaabaaaaaaaaaaaagaebaaaabaaaaaadcaaaaakjcaabaaa
aaaaaaaaagiecaaaabaaaaaaagaaaaaakgaobaaaacaaaaaaagambaaaaaaaaaaa
aaaaaaakmccabaaaadaaaaaaagambaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaijcaabaaaaaaaaaaapgapbaaaacaaaaaaagiecaaa
abaaaaaaafaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaabaaaaaaaeaaaaaa
kgakbaaaaaaaaaaamgaabaaaaaaaaaaadcaaaaakfcaabaaaaaaaaaaaagibcaaa
abaaaaaaaeaaaaaafgafbaaaacaaaaaaagadbaaaaaaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaegaabaaaacaaaaaaegaabaaaabaaaaaa
aaaaaaakdccabaaaadaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaabaaaaaaagaaaaaa
fgafbaaaaaaaaaaaigaabaaaaaaaaaaaaaaaaaakdccabaaaaeaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
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
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_4.w = _glesVertex.w;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_modelview0 * tmpvar_4);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((_World2Object * tmpvar_6).xyz * unity_Scale.w));
  highp vec2 tmpvar_8;
  tmpvar_8 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_9;
  tmpvar_9.z = 0.0;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = tmpvar_8.y;
  tmpvar_9.w = _glesVertex.w;
  ZYv_3.yzw = tmpvar_9.yxw;
  XZv_2.xzw = tmpvar_9.xyw;
  XYv_1.xyw = tmpvar_9.xyw;
  ZYv_3.x = ((sign(-(tmpvar_7.x)) * sign(tmpvar_8.x)) * tmpvar_7.z);
  XZv_2.y = ((sign(-(tmpvar_7.y)) * sign(tmpvar_8.x)) * tmpvar_7.x);
  XYv_1.z = ((sign(-(tmpvar_7.z)) * sign(tmpvar_8.x)) * tmpvar_7.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_7.x)) * sign(tmpvar_8.y)) * tmpvar_7.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_7.y)) * sign(tmpvar_8.y)) * tmpvar_7.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_7.z)) * sign(tmpvar_8.y)) * tmpvar_7.y));
  gl_Position = (glstate_matrix_projection * (tmpvar_5 + _glesVertex));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = pow (tmpvar_7, vec3(2.0, 2.0, 2.0));
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_5.xy));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_5.xy));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_5.xy));
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 prev_2;
  mediump vec4 ztex_3;
  mediump float zval_4;
  mediump vec4 ytex_5;
  mediump float yval_6;
  mediump vec4 xtex_7;
  mediump float xval_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD0.x;
  xval_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_7 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD0.y;
  yval_6 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = xlv_TEXCOORD0.z;
  zval_4 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_3 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = ((_Color * xlv_COLOR) * (((xtex_7 * xval_8) + (ytex_5 * yval_6)) + (ztex_3 * zval_4)));
  prev_2.w = tmpvar_15.w;
  prev_2.xyz = (tmpvar_15.xyz * tmpvar_15.w);
  tmpvar_1 = prev_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
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
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_4.w = _glesVertex.w;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_modelview0 * tmpvar_4);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((_World2Object * tmpvar_6).xyz * unity_Scale.w));
  highp vec2 tmpvar_8;
  tmpvar_8 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_9;
  tmpvar_9.z = 0.0;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = tmpvar_8.y;
  tmpvar_9.w = _glesVertex.w;
  ZYv_3.yzw = tmpvar_9.yxw;
  XZv_2.xzw = tmpvar_9.xyw;
  XYv_1.xyw = tmpvar_9.xyw;
  ZYv_3.x = ((sign(-(tmpvar_7.x)) * sign(tmpvar_8.x)) * tmpvar_7.z);
  XZv_2.y = ((sign(-(tmpvar_7.y)) * sign(tmpvar_8.x)) * tmpvar_7.x);
  XYv_1.z = ((sign(-(tmpvar_7.z)) * sign(tmpvar_8.x)) * tmpvar_7.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_7.x)) * sign(tmpvar_8.y)) * tmpvar_7.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_7.y)) * sign(tmpvar_8.y)) * tmpvar_7.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_7.z)) * sign(tmpvar_8.y)) * tmpvar_7.y));
  gl_Position = (glstate_matrix_projection * (tmpvar_5 + _glesVertex));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = pow (tmpvar_7, vec3(2.0, 2.0, 2.0));
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_5.xy));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_5.xy));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_5.xy));
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 prev_2;
  mediump vec4 ztex_3;
  mediump float zval_4;
  mediump vec4 ytex_5;
  mediump float yval_6;
  mediump vec4 xtex_7;
  mediump float xval_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD0.x;
  xval_8 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_7 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD0.y;
  yval_6 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = xlv_TEXCOORD0.z;
  zval_4 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_3 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = ((_Color * xlv_COLOR) * (((xtex_7 * xval_8) + (ytex_5 * yval_6)) + (ztex_3 * zval_4)));
  prev_2.w = tmpvar_15.w;
  prev_2.xyz = (tmpvar_15.xyz * tmpvar_15.w);
  tmpvar_1 = prev_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "flash " {
Keywords { }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_World2Object]
Vector 13 [unity_Scale]
"agal_vs
c14 0.0 1.0 -0.0 0.5
c15 2.0 -1.0 0.0 0.0
[bc]
aaaaaaaaabaaahacamaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, c12
aaaaaaaaabaaaiacaoaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r1.w, c14.y
bdaaaaaaaaaaaeacabaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r0.z, r1, c10
bdaaaaaaaaaaabacabaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r0.x, r1, c8
bdaaaaaaaaaaacacabaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r0.y, r1, c9
adaaaaaaaaaaahacaaaaaakeacaaaaaaanaaaappabaaaaaa mul r0.xyz, r0.xyzz, c13.w
abaaaaaaaaaaahacaaaaaakeacaaaaaaaoaaaakkabaaaaaa add r0.xyz, r0.xyzz, c14.z
bcaaaaaaaaaaaiacaaaaaakeacaaaaaaaaaaaakeacaaaaaa dp3 r0.w, r0.xyzz, r0.xyzz
akaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r0.w, r0.w
adaaaaaaadaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r3.xyz, r0.w, r0.xyzz
adaaaaaaaaaaadacadaaaaoeaaaaaaaaapaaaaaaabaaaaaa mul r0.xy, a3, c15.x
abaaaaaaaaaaadacaaaaaafeacaaaaaaapaaaaffabaaaaaa add r0.xy, r0.xyyy, c15.y
bfaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.x, r0.x
ckaaaaaaabaaabacaaaaaaaaacaaaaaaabaaaaaaacaaaaaa slt r1.x, r0.x, r1.x
bfaaaaaaabaaacacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r1.y, r0.y
ckaaaaaaabaaacacaaaaaaffacaaaaaaabaaaaffacaaaaaa slt r1.y, r0.y, r1.y
bfaaaaaaacaaabacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2.x, r3.x
ckaaaaaaaaaaaeacadaaaaaaacaaaaaaacaaaaaaacaaaaaa slt r0.z, r3.x, r2.x
bfaaaaaaaeaaabacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r3.x
ckaaaaaaaaaaaiacaeaaaaaaacaaaaaaadaaaaaaacaaaaaa slt r0.w, r4.x, r3.x
acaaaaaaaaaaaiacaaaaaakkacaaaaaaaaaaaappacaaaaaa sub r0.w, r0.z, r0.w
bfaaaaaaafaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r5.x, r0.x
ckaaaaaaaaaaaeacafaaaaaaacaaaaaaaaaaaaaaacaaaaaa slt r0.z, r5.x, r0.x
acaaaaaaaaaaaeacaaaaaakkacaaaaaaabaaaaaaacaaaaaa sub r0.z, r0.z, r1.x
bfaaaaaaafaaacacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r5.y, r0.y
ckaaaaaaabaaabacafaaaaffacaaaaaaaaaaaaffacaaaaaa slt r1.x, r5.y, r0.y
acaaaaaaadaaaiacabaaaaaaacaaaaaaabaaaaffacaaaaaa sub r3.w, r1.x, r1.y
adaaaaaaabaaacacaaaaaappacaaaaaaadaaaappacaaaaaa mul r1.y, r0.w, r3.w
adaaaaaaabaaabacaaaaaappacaaaaaaaaaaaakkacaaaaaa mul r1.x, r0.w, r0.z
adaaaaaaacaaabacadaaaaffacaaaaaaabaaaaffacaaaaaa mul r2.x, r3.y, r1.y
aaaaaaaaaaaaaiacaaaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.w, a0
aaaaaaaaabaaaoacaaaaaamhacaaaaaaaaaaaaaaaaaaaaaa mov r1.yzw, r0.wyxw
adaaaaaaabaaabacadaaaakkacaaaaaaabaaaaaaacaaaaaa mul r1.x, r3.z, r1.x
abaaaaaaabaaabacabaaaaaaacaaaaaaacaaaaaaacaaaaaa add r1.x, r1.x, r2.x
bdaaaaaaacaaacacabaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r2.y, r1, c1
bdaaaaaaacaaabacabaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r2.x, r1, c0
aaaaaaaaabaaaiacaaaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r1.w, a0
aaaaaaaaabaaahacaoaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, c14.x
bdaaaaaaaeaaacacabaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r4.y, r1, c1
bdaaaaaaaeaaabacabaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r4.x, r1, c0
bfaaaaaaagaaadacaeaaaafeacaaaaaaaaaaaaaaaaaaaaaa neg r6.xy, r4.xyyy
abaaaaaaacaaadacagaaaafeacaaaaaaacaaaafeacaaaaaa add r2.xy, r6.xyyy, r2.xyyy
bfaaaaaaagaaacacadaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r6.y, r3.y
ckaaaaaaacaaaiacagaaaaffacaaaaaaadaaaaffacaaaaaa slt r2.w, r6.y, r3.y
bfaaaaaaagaaacacadaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r6.y, r3.y
ckaaaaaaacaaaeacadaaaaffacaaaaaaagaaaaffacaaaaaa slt r2.z, r3.y, r6.y
acaaaaaaacaaaeacacaaaakkacaaaaaaacaaaappacaaaaaa sub r2.z, r2.z, r2.w
abaaaaaaabaaadaeacaaaafeacaaaaaaaoaaaappabaaaaaa add v1.xy, r2.xyyy, c14.w
adaaaaaaacaaabacadaaaappacaaaaaaacaaaakkacaaaaaa mul r2.x, r3.w, r2.z
adaaaaaaacaaacacaaaaaakkacaaaaaaacaaaakkacaaaaaa mul r2.y, r0.z, r2.z
adaaaaaaaeaaaeacadaaaakkacaaaaaaacaaaaaaacaaaaaa mul r4.z, r3.z, r2.x
adaaaaaaacaaacacadaaaaaaacaaaaaaacaaaaffacaaaaaa mul r2.y, r3.x, r2.y
abaaaaaaacaaacacacaaaaffacaaaaaaaeaaaakkacaaaaaa add r2.y, r2.y, r4.z
aaaaaaaaacaaanacaaaaaanmacaaaaaaaaaaaaaaaaaaaaaa mov r2.xzw, r0.xwyw
bdaaaaaaaeaaaiacacaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r4.w, r2, c1
bfaaaaaaaeaaaeacadaaaakkacaaaaaaaaaaaaaaaaaaaaaa neg r4.z, r3.z
ckaaaaaaaeaaaeacadaaaakkacaaaaaaaeaaaakkacaaaaaa slt r4.z, r3.z, r4.z
bfaaaaaaagaaaeacadaaaakkacaaaaaaaaaaaaaaaaaaaaaa neg r6.z, r3.z
ckaaaaaaafaaabacagaaaakkacaaaaaaadaaaakkacaaaaaa slt r5.x, r6.z, r3.z
acaaaaaaafaaabacaeaaaakkacaaaaaaafaaaaaaacaaaaaa sub r5.x, r4.z, r5.x
bdaaaaaaaeaaaeacacaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r4.z, r2, c0
bfaaaaaaacaaadacaeaaaafeacaaaaaaaaaaaaaaaaaaaaaa neg r2.xy, r4.xyyy
abaaaaaaacaaadacacaaaafeacaaaaaaaeaaaapoacaaaaaa add r2.xy, r2.xyyy, r4.zwww
adaaaaaaacaaaeacadaaaappacaaaaaaafaaaaaaacaaaaaa mul r2.z, r3.w, r5.x
abaaaaaaacaaadaeacaaaafeacaaaaaaaoaaaappabaaaaaa add v2.xy, r2.xyyy, c14.w
adaaaaaaacaaaeacadaaaaffacaaaaaaacaaaakkacaaaaaa mul r2.z, r3.y, r2.z
adaaaaaaaaaaaeacaaaaaakkacaaaaaaafaaaaaaacaaaaaa mul r0.z, r0.z, r5.x
adaaaaaaaaaaaeacadaaaaaaacaaaaaaaaaaaakkacaaaaaa mul r0.z, r3.x, r0.z
abaaaaaaaaaaaeacaaaaaakkacaaaaaaacaaaakkacaaaaaa add r0.z, r0.z, r2.z
bdaaaaaaacaaabacaaaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r2.x, r0, c0
bdaaaaaaacaaacacaaaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r2.y, r0, c1
bfaaaaaaaaaaadacaeaaaafeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xy, r4.xyyy
abaaaaaaaaaaadacaaaaaafeacaaaaaaacaaaafeacaaaaaa add r0.xy, r0.xyyy, r2.xyyy
bdaaaaaaaeaaaeacabaaaaoeacaaaaaaacaaaaoeabaaaaaa dp4 r4.z, r1, c2
bdaaaaaaaeaaaiacabaaaaoeacaaaaaaadaaaaoeabaaaaaa dp4 r4.w, r1, c3
abaaaaaaabaaapacaeaaaaoeacaaaaaaaaaaaaoeaaaaaaaa add r1, r4, a0
abaaaaaaadaaadaeaaaaaafeacaaaaaaaoaaaappabaaaaaa add v3.xy, r0.xyyy, c14.w
bdaaaaaaaaaaaiadabaaaaoeacaaaaaaahaaaaoeabaaaaaa dp4 o0.w, r1, c7
bdaaaaaaaaaaaeadabaaaaoeacaaaaaaagaaaaoeabaaaaaa dp4 o0.z, r1, c6
bdaaaaaaaaaaacadabaaaaoeacaaaaaaafaaaaoeabaaaaaa dp4 o0.y, r1, c5
bdaaaaaaaaaaabadabaaaaoeacaaaaaaaeaaaaoeabaaaaaa dp4 o0.x, r1, c4
adaaaaaaaaaaahaeadaaaakeacaaaaaaadaaaakeacaaaaaa mul v0.xyz, r3.xyzz, r3.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
aaaaaaaaacaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, c0
aaaaaaaaadaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.zw, c0
"
}

SubProgram "d3d11_9x " {
Keywords { }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
BindCB "UnityPerFrame" 2
// 41 instructions, 5 temp regs, 0 temp arrays:
// ALU 33 float, 4 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefieceddffgbgjlgcapjbfdhbollaoophflgadhabaaaaaaaaalaaaaaeaaaaaa
daaaaaaajaadaaaaneajaaaaeeakaaaaebgpgodjfiadaaaafiadaaaaaaacpopp
aaadaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaaeaa
abaaabaaaaaaaaaaabaaaeaaaeaaacaaaaaaaaaaabaabaaaafaaagaaaaaaaaaa
acaaaaaaaeaaalaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafapaaapkaaaaaaaea
aaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjaabaaaaacaaaaahiaabaaoekaafaaaaad
abaaapiaaaaaffiaahaaeckaaeaaaaaeabaaapiaagaaeckaaaaaaaiaabaaoeia
aeaaaaaeaaaaapiaaiaaeckaaaaakkiaabaaoeiaacaaaaadaaaaapiaaaaaoeia
ajaaeckaafaaaaadaaaaapiaaaaaoeiaakaappkaaiaaaaadabaaabiaaaaapiia
aaaapiiaahaaaaacabaaabiaabaaaaiaafaaaaadaaaaapiaaaaaoeiaabaaaaia
afaaaaadabaaahoaaaaamoiaaaaamoiaamaaaaadabaaapiaaaaaioiaaaaaioib
amaaaaadacaaapiaaaaaioibaaaaioiaacaaaaadabaaapiaabaaoeiaacaaoeib
aeaaaaaeacaaapiaacaafajaapaaaakaapaaffkaamaaaaadadaaapiaacaanfib
acaanfiaamaaaaadaeaaapiaacaanfiaacaanfibacaaaaadadaaapiaadaaoeia
aeaaoeibafaaaaadaeaaapiaabaaoeiaadaaoeiaafaaaaadabaaadiaabaaojia
adaappiaafaaaaadadaaapiaaaaaoeiaaeaaoeiaaeaaaaaeaaaaadiaabaaoeia
aaaaomiaadaaojiaacaaaaadaaaaaeiaadaappiaadaaaaiaafaaaaadabaaadia
acaappiaadaaoekaaeaaaaaeaaaaamiaacaaeekaaaaakkiaabaaeeiaaeaaaaae
abaaadiaacaaoekaacaaffiaabaaoeiaaeaaaaaeabaaadiaaeaaoekaaaaaffia
abaaoeiaacaaaaadadaaadoaabaaoeiaapaakkkaaeaaaaaeaaaaagiaaeaanaka
acaanaiaaaaapiiaacaaaaadacaaadoaaaaaojiaapaakkkaafaaaaadaaaaagia
acaaffiaacaanakaaeaaaaaeaaaaadiaadaaobkaaaaaaaiaaaaaogiaaeaaaaae
aaaaadiaaeaaobkaacaaoliaaaaaoeiaacaaaaadacaaamoaaaaaeeiaapaakkka
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoejaafaaaaadabaaapiaaaaaffia
amaaoekaaeaaaaaeabaaapiaalaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapia
anaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaapiaaoaaoekaaaaappiaabaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacaaaaapoaabaaoejappppaaaafdeieefcdmagaaaaeaaaabaaipabaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
giaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaahaaaaaa
pgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
acaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgapbaaaaaaaaaaa
egaobaaaabaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaadiaaaaaj
pcaabaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaacgiecaaaabaaaaaabbaaaaaa
dcaaaaalpcaabaaaaaaaaaaacgiecaaaabaaaaaabaaaaaaaagiacaaaaaaaaaaa
aeaaaaaaegaobaaaaaaaaaaadcaaaaalpcaabaaaaaaaaaaacgiecaaaabaaaaaa
bcaaaaaakgikcaaaaaaaaaaaaeaaaaaaegaobaaaaaaaaaaaaaaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaacgiecaaaabaaaaaabdaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaapgipcaaaabaaaaaabeaaaaaabaaaaaahbcaabaaa
abaaaaaaigadbaaaaaaaaaaaigadbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagaabaaa
abaaaaaadiaaaaahhccabaaaacaaaaaaogaibaaaaaaaaaaaogaibaaaaaaaaaaa
dbaaaaalpcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
ogaibaiaebaaaaaaaaaaaaaadbaaaaalpcaabaaaacaaaaaaogaibaiaebaaaaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaipcaabaaa
abaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaappcaabaaa
acaaaaaaagbfbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaea
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdbaaaaakpcaabaaaadaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaacaaaaaadbaaaaak
pcaabaaaaeaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaipcaabaaaadaaaaaaegaobaiaebaaaaaaadaaaaaaegaobaaa
aeaaaaaacgaaaaaiaanaaaaapcaabaaaaeaaaaaaegaobaaaabaaaaaaegaobaaa
adaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaajgafbaaaabaaaaaapgapbaaa
adaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaclaaaaafpcaabaaa
adaaaaaaegaobaaaaeaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaaaaaaaaa
egaobaaaadaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaabaaaaaamgaabaaa
aaaaaaaajgafbaaaadaaaaaaaaaaaaahecaabaaaaaaaaaaadkaabaaaadaaaaaa
akaabaaaadaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaaacaaaaaaegiacaaa
abaaaaaaaeaaaaaadcaaaaakjcaabaaaaaaaaaaaagiecaaaabaaaaaaafaaaaaa
agaabaaaaaaaaaaaagaebaaaabaaaaaadcaaaaakjcaabaaaaaaaaaaaagiecaaa
abaaaaaaagaaaaaakgaobaaaacaaaaaaagambaaaaaaaaaaaaaaaaaakmccabaaa
adaaaaaaagambaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
diaaaaaijcaabaaaaaaaaaaapgapbaaaacaaaaaaagiecaaaabaaaaaaafaaaaaa
dcaaaaakdcaabaaaabaaaaaaegiacaaaabaaaaaaaeaaaaaakgakbaaaaaaaaaaa
mgaabaaaaaaaaaaadcaaaaakfcaabaaaaaaaaaaaagibcaaaabaaaaaaaeaaaaaa
fgafbaaaacaaaaaaagadbaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
abaaaaaaagaaaaaaegaabaaaacaaaaaaegaabaaaabaaaaaaaaaaaaakdccabaaa
adaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dcaaaaakdcaabaaaaaaaaaaaegiacaaaabaaaaaaagaaaaaafgafbaaaaaaaaaaa
igaabaaaaaaaaaaaaaaaaaakdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedep
epfceeaaepfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakkaaaaaa
abaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaakkaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaamadaaaakkaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;

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
#line 329
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
};
#line 322
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
#line 319
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
uniform lowp vec4 _Color;
#line 339
uniform highp vec4 _TopTex_ST;
#line 368
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 340
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 343
    highp vec4 origin = (glstate_matrix_projection * (mvCenter + vec4( 0.0, 0.0, 0.0, v.vertex.w)));
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(ObjSpaceViewDir( vec4( 0.0, 0.0, 0.0, v.vertex.w)));
    #line 347
    o.viewDir = pow( viewDir, vec3( 2.0));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 351
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    #line 355
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    #line 359
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + ZY);
    #line 363
    o.texcoordXZ = (vec2( 0.5, 0.5) + XZ);
    o.texcoordXY = (vec2( 0.5, 0.5) + XY);
    o.color = v.color;
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
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
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

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
#line 329
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
};
#line 322
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
uniform sampler2D _TopTex;
uniform sampler2D _BotTex;
uniform sampler2D _LeftTex;
uniform sampler2D _RightTex;
#line 319
uniform sampler2D _FrontTex;
uniform sampler2D _BackTex;
uniform lowp vec4 _Color;
#line 339
uniform highp vec4 _TopTex_ST;
#line 368
#line 368
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 372
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 376
    mediump vec4 tex = (((xtex * xval) + (ytex * yval)) + (ztex * zval));
    mediump vec4 prev = ((_Color * i.color) * tex);
    prev.xyz *= prev.w;
    return prev;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   opengl - ALU: 10 to 10, TEX: 3 to 3
//   d3d9 - ALU: 8 to 8, TEX: 3 to 3
//   d3d11 - ALU: 6 to 6, TEX: 3 to 3, FLOW: 1 to 1
//   d3d11_9x - ALU: 6 to 6, TEX: 3 to 3, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"!!ARBfp1.0
# 10 ALU, 3 TEX
PARAM c[1] = { program.local[0] };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[2], texture[1], 2D;
TEX R2, fragment.texcoord[3], texture[2], 2D;
TEX R0, fragment.texcoord[1], texture[0], 2D;
MUL R1, fragment.texcoord[0].y, R1;
MAD R0, fragment.texcoord[0].x, R0, R1;
MAD R1, R2, fragment.texcoord[0].z, R0;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, R0;
END
# 10 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_2_0
; 8 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl v0
dcl t0.xyz
dcl t1.xy
dcl t2.xy
dcl t3.xy
texld r0, t3, s2
texld r1, t2, s1
texld r2, t1, s0
mul_pp r1, t0.y, r1
mad_pp r1, t0.x, r2, r1
mad_pp r1, r0, t0.z, r1
mul_pp r0, v0, c0
mul_pp r1, r0, r1
mov_pp r0.w, r1
mul_pp r0.xyz, r1, r1.w
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { }
ConstBuffer "$Globals" 48 // 32 used size, 3 vars
Vector 16 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 6 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedpijhkfghfmjhglcbkcdgpeohaejcbookabaaaaaacaadaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakkaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaakkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
pmabaaaaeaaaaaaahpaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaafgbfbaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaaabaaaaaaagbabaaaacaaaaaa
egaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaaabaaaaaa
kgbkbaaaacaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegbobaaa
abaaaaaaegiocaaaaaaaaaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES"
}

SubProgram "flash " {
Keywords { }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"agal_ps
[bc]
ciaaaaaaaaaaapacadaaaaoeaeaaaaaaacaaaaaaafaababb tex r0, v3, s2 <2d wrap linear point>
ciaaaaaaabaaapacacaaaaoeaeaaaaaaabaaaaaaafaababb tex r1, v2, s1 <2d wrap linear point>
ciaaaaaaacaaapacabaaaaoeaeaaaaaaaaaaaaaaafaababb tex r2, v1, s0 <2d wrap linear point>
adaaaaaaabaaapacaaaaaaffaeaaaaaaabaaaaoeacaaaaaa mul r1, v0.y, r1
adaaaaaaacaaapacaaaaaaaaaeaaaaaaacaaaaoeacaaaaaa mul r2, v0.x, r2
abaaaaaaabaaapacacaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r2, r1
adaaaaaaacaaapacaaaaaaoeacaaaaaaaaaaaakkaeaaaaaa mul r2, r0, v0.z
abaaaaaaabaaapacacaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r2, r1
adaaaaaaaaaaapacahaaaaoeaeaaaaaaaaaaaaoeabaaaaaa mul r0, v7, c0
adaaaaaaabaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r1, r0, r1
aaaaaaaaaaaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.w
adaaaaaaaaaaahacabaaaakeacaaaaaaabaaaappacaaaaaa mul r0.xyz, r1.xyzz, r1.w
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { }
ConstBuffer "$Globals" 48 // 32 used size, 3 vars
Vector 16 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 6 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedobphfogfaompfcdbmfiimgjiclkncibdabaaaaaaheaeaaaaaeaaaaaa
daaaaaaaiaabaaaaieadaaaaeaaeaaaaebgpgodjeiabaaaaeiabaaaaaaacpppp
amabaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaia
aaaacplabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaaiaadaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkaabaaaaacaaaaadiaacaabllaecaaaaadaaaacpia
aaaaoeiaaaaioekaecaaaaadabaacpiaacaaoelaabaioekaecaaaaadacaacpia
adaaoelaacaioekaafaaaaadaaaacpiaaaaaoeiaabaafflaaeaaaaaeaaaacpia
abaaoeiaabaaaalaaaaaoeiaaeaaaaaeaaaacpiaacaaoeiaabaakklaaaaaoeia
afaaaaadabaacpiaaaaaoelaaaaaoekaafaaaaadaaaacpiaaaaaoeiaabaaoeia
afaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcpmabaaaaeaaaaaaahpaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaafgbfbaaa
acaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaaabaaaaaaagbabaaa
acaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaa
abaaaaaakgbkbaaaacaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
egbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaabejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakkaaaaaa
abaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakkaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaamamaaaakkaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3"
}

}

#LINE 123
 
		}
	} 
}
}