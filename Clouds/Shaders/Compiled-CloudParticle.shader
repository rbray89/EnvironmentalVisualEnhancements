Shader "CloudParticle" {
Properties {
	_TopTex ("Particle Texture", 2D) = "white" {}
	_LeftTex ("Particle Texture", 2D) = "white" {}
	_FrontTex ("Particle Texture", 2D) = "white" {}
	_InvFade ("Soft Particles Factor", Range(0.01,3.0)) = 1.0
	_DistFade ("Distance Fade", Range(0,1)) = 1.0
	_Color ("Color Tint", Color) = (1,1,1,1)
}

Category {
	
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	AlphaTest Greater .01
	ColorMask RGB
	Cull Off Lighting Off ZWrite Off
	BindChannels {
		Bind "Color", color
		Bind "Vertex", vertex
		Bind "TexCoord", texcoord
	}

	SubShader {
		Pass {
		
			Program "vp" {
// Vertex combos: 2
//   opengl - ALU: 87 to 94
//   d3d9 - ALU: 81 to 89
//   d3d11 - ALU: 48 to 56, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 48 to 56, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_Object2World]
Float 14 [_DistFade]
"!!ARBvp1.0
# 87 ALU
PARAM c[16] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..14],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R1.xyz, R1.x, c[3];
MOV R0.w, vertex.position;
MOV R0.xyz, c[0].x;
DP4 R3.x, R0, c[1];
DP4 R3.y, R0, c[2];
DP4 R3.w, R0, c[4];
DP4 R3.z, R0, c[3];
ADD R0, R3, vertex.position;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.zw, vertex.texcoord[0].xyxy, c[0].y;
SLT R0.x, c[0], -R1;
SLT R0.y, -R1.x, c[0].x;
ADD R2.x, R0, -R0.y;
ADD R0.xy, R0.zwzw, -c[0].z;
MUL R1.w, R0.x, R2.x;
SLT R2.y, R1.w, c[0].x;
SLT R0.w, R0, c[0].z;
SLT R0.z, c[0].x, R0.y;
ADD R0.z, R0, -R0.w;
SLT R0.w, c[0].x, R1;
ADD R0.w, R0, -R2.y;
MUL R2.z, R2.x, R0;
MUL R2.y, R1, R2.z;
MUL R0.w, R0, R2.x;
MAD R2.x, R1.z, R0.w, R2.y;
MOV R0.w, vertex.position;
MOV R2.z, R1.w;
MOV R2.yw, R0;
DP4 R3.z, R2, c[1];
DP4 R3.w, R2, c[2];
ADD R2.xy, -R3, R3.zwzw;
SLT R2.z, -R1.y, c[0].x;
SLT R1.w, c[0].x, -R1.y;
ADD R1.w, R1, -R2.z;
MUL R2.zw, R2.xyxy, c[15].x;
MUL R2.x, R0, R1.w;
ADD result.texcoord[1].xy, R2.zwzw, c[0].w;
SLT R2.z, R2.x, c[0].x;
SLT R2.y, c[0].x, R2.x;
ADD R2.y, R2, -R2.z;
MUL R2.z, R0, R1.w;
MUL R1.w, R2.y, R1;
MUL R2.y, R1.z, R2.z;
MAD R2.y, R1.x, R1.w, R2;
MOV R2.zw, R0.xyyw;
DP4 R3.z, R2, c[1];
DP4 R3.w, R2, c[2];
ADD R2.xy, -R3, R3.zwzw;
MUL R2.xy, R2, c[15].x;
SLT R2.z, R1, c[0].x;
SLT R1.w, c[0].x, R1.z;
ADD R1.w, R1, -R2.z;
MUL R0.x, R0, R1.w;
ADD result.texcoord[2].xy, R2, c[0].w;
SLT R2.x, R0, c[0];
SLT R1.w, c[0].x, R0.x;
ADD R2.y, R1.w, -R2.x;
SLT R1.w, c[0].x, -R1.z;
SLT R2.x, -R1.z, c[0];
ADD R2.x, R1.w, -R2;
MUL R1.w, R2.x, R2.y;
MUL R0.z, R0, R2.x;
MUL R0.z, R1.y, R0;
MAD R0.z, R1.x, R1.w, R0;
MOV R2.z, c[11].w;
MOV R2.x, c[9].w;
MOV R2.y, c[10].w;
ADD R2.xyz, -R2, c[13];
DP3 R2.x, R2, R2;
RSQ R1.w, R2.x;
DP4 R2.y, R0, c[2];
DP4 R2.x, R0, c[1];
ADD R0.xy, -R3, R2;
MUL R2.xy, R0, c[15].x;
RCP R1.w, R1.w;
MUL R0.z, R1.w, c[14].x;
MIN R0.z, R0, c[0];
MAX R0.x, R0.z, c[0];
ADD result.texcoord[3].xy, R2, c[0].w;
MUL result.color.w, vertex.color, R0.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R1;
END
# 87 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"vs_2_0
; 81 ALU
def c14, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c15, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r1.xyz, r1.x, c2
mov r0.w, v0
mov r0.xyz, c14.x
dp4 r3.x, r0, c0
dp4 r3.y, r0, c1
dp4 r3.w, r0, c3
dp4 r3.z, r0, c2
add r0, r3, v0
dp4 oPos.w, r0, c7
dp4 oPos.z, r0, c6
dp4 oPos.y, r0, c5
dp4 oPos.x, r0, c4
mad r0.xy, v2, c14.z, c14.w
slt r0.z, r1.x, -r1.x
slt r0.w, -r1.x, r1.x
sub r0.w, r0.z, r0
slt r1.w, r0.y, -r0.y
slt r0.z, -r0.y, r0.y
sub r0.z, r0, r1.w
mul r1.w, r0.x, r0
mul r2.z, r0.w, r0
slt r2.y, r1.w, -r1.w
slt r2.x, -r1.w, r1.w
sub r2.x, r2, r2.y
mul r2.y, r1, r2.z
mov r2.z, r1.w
mul r0.w, r2.x, r0
mad r2.x, r1.z, r0.w, r2.y
mov r0.w, v0
mov r2.yw, r0
dp4 r3.w, r2, c1
dp4 r3.z, r2, c0
add r2.zw, -r3.xyxy, r3
slt r2.x, -r1.y, r1.y
slt r1.w, r1.y, -r1.y
sub r1.w, r1, r2.x
mul r2.x, r0, r1.w
mad oT1.xy, r2.zwzw, c15.x, c15.y
slt r2.z, r2.x, -r2.x
slt r2.y, -r2.x, r2.x
sub r2.y, r2, r2.z
mul r2.z, r0, r1.w
mul r1.w, r2.y, r1
mul r2.y, r1.z, r2.z
mad r2.y, r1.x, r1.w, r2
mov r2.zw, r0.xyyw
dp4 r3.w, r2, c1
dp4 r3.z, r2, c0
add r2.xy, -r3, r3.zwzw
slt r2.z, -r1, r1
slt r1.w, r1.z, -r1.z
sub r2.w, r2.z, r1
sub r1.w, r1, r2.z
mul r0.x, r0, r2.w
mad oT2.xy, r2, c15.x, c15.y
slt r2.y, r0.x, -r0.x
slt r2.x, -r0, r0
sub r2.x, r2, r2.y
mul r2.w, r1, r2.x
mul r1.w, r0.z, r1
mov r2.z, c10.w
mov r2.x, c8.w
mov r2.y, c9.w
add r2.xyz, -r2, c12
dp3 r0.z, r2, r2
mul r2.x, r1.y, r1.w
rsq r1.w, r0.z
mad r0.z, r1.x, r2.w, r2.x
rcp r1.w, r1.w
dp4 r2.y, r0, c1
dp4 r2.x, r0, c0
mul r1.w, r1, c13.x
min r0.x, r1.w, c14.y
add r0.zw, -r3.xyxy, r2.xyxy
max r0.x, r0, c14
mad oT3.xy, r0.zwzw, c15.x, c15.y
mul oD0.w, v1, r0.x
mov oD0.xyz, v1
abs oT0.xyz, r1
"
}

SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64 // 40 used size, 5 vars
Float 36 [_DistFade]
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
// 59 instructions, 5 temp regs, 0 temp arrays:
// ALU 40 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkkflmjaiaipogcjeolodjgacoogcghcnabaaaaaakiajaaaaadaaaaaa
cmaaaaaajmaaaaaafiabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
leaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaakkaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaakkaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefceiaiaaaa
eaaaabaabcacaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafjaaaaaeegiocaaa
adaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagiaaaaacafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaahaaaaaapgbpbaaaaaaaaaaa
egbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaakhcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaaapaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaacaaaaaadiaaaaahiccabaaa
abaaaaaaakaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egbcbaaaabaaaaaadgaaaaagbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaa
dgaaaaagccaabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadgaaaaagecaabaaa
aaaaaaaackiacaaaacaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
dbaaaaalhcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaa
abaaaaaaegacbaaaacaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaacaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaa
acaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaa
boaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
cgaaaaaiaanaaaaahcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
claaaaafhcaabaaaadaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
jgafbaaaaaaaaaaaegacbaaaadaaaaaaclaaaaafkcaabaaaaaaaaaaaagaebaaa
abaaaaaadiaaaaahkcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaa
dbaaaaakmcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
fganbaaaaaaaaaaadbaaaaakdcaabaaaaeaaaaaangafbaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaia
ebaaaaaaacaaaaaaagaebaaaaeaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaa
egaabaaaabaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaa
abaaaaaadcaaaaajdcaabaaaabaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaa
egaabaaaadaaaaaadiaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaa
acaaaaaaafaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaaaeaaaaaa
pgapbaaaaaaaaaaafganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaa
acaaaaaaagaaaaaafgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaa
adaaaaaafganbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdp
aceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaa
fgafbaaaacaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaa
agibcaaaacaaaaaaaeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaak
kcaabaaaaaaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaa
acaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dbaaaaahccaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaacaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dcaaaaakdcaabaaaabaaaaaaegiacaaaacaaaaaaaeaaaaaafgafbaaaaaaaaaaa
ngafbaaaabaaaaaaboaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaacgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaabaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaa
dcaaaaakdcaabaaaaaaaaaaaegiacaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaa
egaabaaaabaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaa
jkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES


#ifdef VERTEX

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
  highp vec2 tmpvar_9;
  tmpvar_9 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_10;
  tmpvar_10.z = 0.0;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = tmpvar_9.y;
  tmpvar_10.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_10.zyw;
  XZv_2.yzw = tmpvar_10.zyw;
  XYv_1.yzw = tmpvar_10.yzw;
  ZYv_3.z = (tmpvar_9.x * sign(-(tmpvar_8.x)));
  XZv_2.x = (tmpvar_9.x * sign(-(tmpvar_8.y)));
  XYv_1.x = (tmpvar_9.x * sign(tmpvar_8.z));
  ZYv_3.x = ((sign(-(tmpvar_8.x)) * sign(ZYv_3.z)) * tmpvar_8.z);
  XZv_2.y = ((sign(-(tmpvar_8.y)) * sign(XZv_2.x)) * tmpvar_8.x);
  XYv_1.z = ((sign(-(tmpvar_8.z)) * sign(XYv_1.x)) * tmpvar_8.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_8.x)) * sign(tmpvar_9.y)) * tmpvar_8.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_8.y)) * sign(tmpvar_9.y)) * tmpvar_8.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_8.z)) * sign(tmpvar_9.y)) * tmpvar_8.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_11;
  p_11 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((_DistFade * sqrt(dot (p_11, p_11))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_12);
  gl_Position = (glstate_matrix_projection * (tmpvar_6 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_8);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_6.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_6.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_6.xy)));
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
  mediump vec4 ztex_2;
  mediump float zval_3;
  mediump vec4 ytex_4;
  mediump float yval_5;
  mediump vec4 xtex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD0.y;
  yval_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_4 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.z;
  zval_3 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_2 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_6, ytex_4, vec4(yval_5)), ztex_2, vec4(zval_3)));
  tmpvar_1 = tmpvar_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES


#ifdef VERTEX

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
  highp vec2 tmpvar_9;
  tmpvar_9 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_10;
  tmpvar_10.z = 0.0;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = tmpvar_9.y;
  tmpvar_10.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_10.zyw;
  XZv_2.yzw = tmpvar_10.zyw;
  XYv_1.yzw = tmpvar_10.yzw;
  ZYv_3.z = (tmpvar_9.x * sign(-(tmpvar_8.x)));
  XZv_2.x = (tmpvar_9.x * sign(-(tmpvar_8.y)));
  XYv_1.x = (tmpvar_9.x * sign(tmpvar_8.z));
  ZYv_3.x = ((sign(-(tmpvar_8.x)) * sign(ZYv_3.z)) * tmpvar_8.z);
  XZv_2.y = ((sign(-(tmpvar_8.y)) * sign(XZv_2.x)) * tmpvar_8.x);
  XYv_1.z = ((sign(-(tmpvar_8.z)) * sign(XYv_1.x)) * tmpvar_8.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_8.x)) * sign(tmpvar_9.y)) * tmpvar_8.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_8.y)) * sign(tmpvar_9.y)) * tmpvar_8.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_8.z)) * sign(tmpvar_9.y)) * tmpvar_8.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_11;
  p_11 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((_DistFade * sqrt(dot (p_11, p_11))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_12);
  gl_Position = (glstate_matrix_projection * (tmpvar_6 + _glesVertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_8);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_6.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_6.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_6.xy)));
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
  mediump vec4 ztex_2;
  mediump float zval_3;
  mediump vec4 ytex_4;
  mediump float yval_5;
  mediump vec4 xtex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD0.y;
  yval_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_4 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.z;
  zval_3 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_2 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (((0.95 * _Color) * xlv_COLOR) * mix (mix (xtex_6, ytex_4, vec4(yval_5)), ztex_2, vec4(zval_3)));
  tmpvar_1 = tmpvar_12;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_Object2World]
Float 13 [_DistFade]
"agal_vs
c14 0.0 1.0 2.0 -1.0
c15 0.6 0.5 0.0 0.0
[bc]
aaaaaaaaaeaaapacacaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r4, c2
aaaaaaaaaaaaapacacaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c2
bcaaaaaaabaaabacaeaaaakeacaaaaaaaaaaaakeacaaaaaa dp3 r1.x, r4.xyzz, r0.xyzz
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r1.xyz, r1.x, c2
aaaaaaaaaaaaaiacaaaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.w, a0
aaaaaaaaaaaaahacaoaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c14.x
bdaaaaaaadaaabacaaaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r3.x, r0, c0
bdaaaaaaadaaacacaaaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r3.y, r0, c1
bdaaaaaaadaaaiacaaaaaaoeacaaaaaaadaaaaoeabaaaaaa dp4 r3.w, r0, c3
bdaaaaaaadaaaeacaaaaaaoeacaaaaaaacaaaaoeabaaaaaa dp4 r3.z, r0, c2
abaaaaaaaaaaapacadaaaaoeacaaaaaaaaaaaaoeaaaaaaaa add r0, r3, a0
bdaaaaaaaaaaaiadaaaaaaoeacaaaaaaahaaaaoeabaaaaaa dp4 o0.w, r0, c7
bdaaaaaaaaaaaeadaaaaaaoeacaaaaaaagaaaaoeabaaaaaa dp4 o0.z, r0, c6
bdaaaaaaaaaaacadaaaaaaoeacaaaaaaafaaaaoeabaaaaaa dp4 o0.y, r0, c5
bdaaaaaaaaaaabadaaaaaaoeacaaaaaaaeaaaaoeabaaaaaa dp4 o0.x, r0, c4
adaaaaaaaaaaadacadaaaaoeaaaaaaaaaoaaaakkabaaaaaa mul r0.xy, a3, c14.z
abaaaaaaaaaaadacaaaaaafeacaaaaaaaoaaaappabaaaaaa add r0.xy, r0.xyyy, c14.w
bfaaaaaaacaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2.x, r1.x
ckaaaaaaaaaaaeacabaaaaaaacaaaaaaacaaaaaaacaaaaaa slt r0.z, r1.x, r2.x
bfaaaaaaaeaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r1.x
ckaaaaaaaaaaaiacaeaaaaaaacaaaaaaabaaaaaaacaaaaaa slt r0.w, r4.x, r1.x
acaaaaaaaaaaaiacaaaaaakkacaaaaaaaaaaaappacaaaaaa sub r0.w, r0.z, r0.w
bfaaaaaaaeaaacacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r4.y, r0.y
ckaaaaaaabaaaiacaaaaaaffacaaaaaaaeaaaaffacaaaaaa slt r1.w, r0.y, r4.y
bfaaaaaaaeaaacacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r4.y, r0.y
ckaaaaaaaaaaaeacaeaaaaffacaaaaaaaaaaaaffacaaaaaa slt r0.z, r4.y, r0.y
acaaaaaaaaaaaeacaaaaaakkacaaaaaaabaaaappacaaaaaa sub r0.z, r0.z, r1.w
adaaaaaaabaaaiacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r1.w, r0.x, r0.w
adaaaaaaacaaaeacaaaaaappacaaaaaaaaaaaakkacaaaaaa mul r2.z, r0.w, r0.z
bfaaaaaaaeaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa neg r4.w, r1.w
ckaaaaaaacaaacacabaaaappacaaaaaaaeaaaappacaaaaaa slt r2.y, r1.w, r4.w
bfaaaaaaaeaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa neg r4.w, r1.w
ckaaaaaaacaaabacaeaaaappacaaaaaaabaaaappacaaaaaa slt r2.x, r4.w, r1.w
acaaaaaaacaaabacacaaaaaaacaaaaaaacaaaaffacaaaaaa sub r2.x, r2.x, r2.y
adaaaaaaacaaacacabaaaaffacaaaaaaacaaaakkacaaaaaa mul r2.y, r1.y, r2.z
aaaaaaaaacaaaeacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r2.z, r1.w
adaaaaaaaaaaaiacacaaaaaaacaaaaaaaaaaaappacaaaaaa mul r0.w, r2.x, r0.w
adaaaaaaaeaaabacabaaaakkacaaaaaaaaaaaappacaaaaaa mul r4.x, r1.z, r0.w
abaaaaaaacaaabacaeaaaaaaacaaaaaaacaaaaffacaaaaaa add r2.x, r4.x, r2.y
aaaaaaaaaaaaaiacaaaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.w, a0
aaaaaaaaacaaakacaaaaaaphacaaaaaaaaaaaaaaaaaaaaaa mov r2.yw, r0.wyww
bdaaaaaaadaaaiacacaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r3.w, r2, c1
bdaaaaaaadaaaeacacaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r3.z, r2, c0
bfaaaaaaaeaaadacadaaaafeacaaaaaaaaaaaaaaaaaaaaaa neg r4.xy, r3.xyyy
abaaaaaaacaaamacaeaaaaefacaaaaaaadaaaaopacaaaaaa add r2.zw, r4.yyxy, r3.wwzw
bfaaaaaaaeaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r4.y, r1.y
ckaaaaaaacaaabacaeaaaaffacaaaaaaabaaaaffacaaaaaa slt r2.x, r4.y, r1.y
bfaaaaaaaeaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r4.y, r1.y
ckaaaaaaabaaaiacabaaaaffacaaaaaaaeaaaaffacaaaaaa slt r1.w, r1.y, r4.y
acaaaaaaabaaaiacabaaaappacaaaaaaacaaaaaaacaaaaaa sub r1.w, r1.w, r2.x
adaaaaaaacaaabacaaaaaaaaacaaaaaaabaaaappacaaaaaa mul r2.x, r0.x, r1.w
adaaaaaaaeaaadacacaaaapoacaaaaaaapaaaaaaabaaaaaa mul r4.xy, r2.zwww, c15.x
abaaaaaaabaaadaeaeaaaafeacaaaaaaapaaaaffabaaaaaa add v1.xy, r4.xyyy, c15.y
bfaaaaaaaeaaabacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r2.x
ckaaaaaaacaaaeacacaaaaaaacaaaaaaaeaaaaaaacaaaaaa slt r2.z, r2.x, r4.x
bfaaaaaaaeaaabacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r2.x
ckaaaaaaacaaacacaeaaaaaaacaaaaaaacaaaaaaacaaaaaa slt r2.y, r4.x, r2.x
acaaaaaaacaaacacacaaaaffacaaaaaaacaaaakkacaaaaaa sub r2.y, r2.y, r2.z
adaaaaaaacaaaeacaaaaaakkacaaaaaaabaaaappacaaaaaa mul r2.z, r0.z, r1.w
adaaaaaaabaaaiacacaaaaffacaaaaaaabaaaappacaaaaaa mul r1.w, r2.y, r1.w
adaaaaaaacaaacacabaaaakkacaaaaaaacaaaakkacaaaaaa mul r2.y, r1.z, r2.z
adaaaaaaaeaaacacabaaaaaaacaaaaaaabaaaappacaaaaaa mul r4.y, r1.x, r1.w
abaaaaaaacaaacacaeaaaaffacaaaaaaacaaaaffacaaaaaa add r2.y, r4.y, r2.y
aaaaaaaaacaaamacaaaaaanpacaaaaaaaaaaaaaaaaaaaaaa mov r2.zw, r0.wwyw
bdaaaaaaadaaaiacacaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r3.w, r2, c1
bdaaaaaaadaaaeacacaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r3.z, r2, c0
bfaaaaaaacaaadacadaaaafeacaaaaaaaaaaaaaaaaaaaaaa neg r2.xy, r3.xyyy
abaaaaaaacaaadacacaaaafeacaaaaaaadaaaapoacaaaaaa add r2.xy, r2.xyyy, r3.zwww
bfaaaaaaacaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa neg r2.z, r1.z
ckaaaaaaacaaaeacacaaaakkacaaaaaaabaaaakkacaaaaaa slt r2.z, r2.z, r1.z
bfaaaaaaaeaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa neg r4.z, r1.z
ckaaaaaaabaaaiacabaaaakkacaaaaaaaeaaaakkacaaaaaa slt r1.w, r1.z, r4.z
acaaaaaaacaaaiacacaaaakkacaaaaaaabaaaappacaaaaaa sub r2.w, r2.z, r1.w
acaaaaaaabaaaiacabaaaappacaaaaaaacaaaakkacaaaaaa sub r1.w, r1.w, r2.z
adaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaappacaaaaaa mul r0.x, r0.x, r2.w
adaaaaaaaeaaadacacaaaafeacaaaaaaapaaaaaaabaaaaaa mul r4.xy, r2.xyyy, c15.x
abaaaaaaacaaadaeaeaaaafeacaaaaaaapaaaaffabaaaaaa add v2.xy, r4.xyyy, c15.y
bfaaaaaaaeaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r0.x
ckaaaaaaacaaacacaaaaaaaaacaaaaaaaeaaaaaaacaaaaaa slt r2.y, r0.x, r4.x
bfaaaaaaacaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2.x, r0.x
ckaaaaaaacaaabacacaaaaaaacaaaaaaaaaaaaaaacaaaaaa slt r2.x, r2.x, r0.x
acaaaaaaacaaabacacaaaaaaacaaaaaaacaaaaffacaaaaaa sub r2.x, r2.x, r2.y
adaaaaaaacaaaiacabaaaappacaaaaaaacaaaaaaacaaaaaa mul r2.w, r1.w, r2.x
adaaaaaaabaaaiacaaaaaakkacaaaaaaabaaaappacaaaaaa mul r1.w, r0.z, r1.w
aaaaaaaaacaaaeacakaaaappabaaaaaaaaaaaaaaaaaaaaaa mov r2.z, c10.w
aaaaaaaaacaaabacaiaaaappabaaaaaaaaaaaaaaaaaaaaaa mov r2.x, c8.w
aaaaaaaaacaaacacajaaaappabaaaaaaaaaaaaaaaaaaaaaa mov r2.y, c9.w
bfaaaaaaacaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r2.xyz, r2.xyzz
abaaaaaaacaaahacacaaaakeacaaaaaaamaaaaoeabaaaaaa add r2.xyz, r2.xyzz, c12
bcaaaaaaaaaaaeacacaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r0.z, r2.xyzz, r2.xyzz
adaaaaaaacaaabacabaaaaffacaaaaaaabaaaappacaaaaaa mul r2.x, r1.y, r1.w
akaaaaaaabaaaiacaaaaaakkacaaaaaaaaaaaaaaaaaaaaaa rsq r1.w, r0.z
adaaaaaaaaaaaeacabaaaaaaacaaaaaaacaaaappacaaaaaa mul r0.z, r1.x, r2.w
abaaaaaaaaaaaeacaaaaaakkacaaaaaaacaaaaaaacaaaaaa add r0.z, r0.z, r2.x
afaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rcp r1.w, r1.w
bdaaaaaaacaaacacaaaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r2.y, r0, c1
bdaaaaaaacaaabacaaaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r2.x, r0, c0
adaaaaaaabaaaiacabaaaappacaaaaaaanaaaaaaabaaaaaa mul r1.w, r1.w, c13.x
agaaaaaaaaaaabacabaaaappacaaaaaaaoaaaaffabaaaaaa min r0.x, r1.w, c14.y
bfaaaaaaaeaaadacadaaaafeacaaaaaaaaaaaaaaaaaaaaaa neg r4.xy, r3.xyyy
abaaaaaaaaaaamacaeaaaaefacaaaaaaacaaaaefacaaaaaa add r0.zw, r4.yyxy, r2.yyxy
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaaoaaaaoeabaaaaaa max r0.x, r0.x, c14
adaaaaaaaeaaadacaaaaaapoacaaaaaaapaaaaaaabaaaaaa mul r4.xy, r0.zwww, c15.x
abaaaaaaadaaadaeaeaaaafeacaaaaaaapaaaaffabaaaaaa add v3.xy, r4.xyyy, c15.y
adaaaaaaahaaaiaeacaaaaoeaaaaaaaaaaaaaaaaacaaaaaa mul v7.w, a2, r0.x
aaaaaaaaahaaahaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7.xyz, a2
beaaaaaaaaaaahaeabaaaakeacaaaaaaaaaaaaaaaaaaaaaa abs v0.xyz, r1.xyzz
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
aaaaaaaaacaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, c0
aaaaaaaaadaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.zw, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64 // 40 used size, 5 vars
Float 36 [_DistFade]
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
// 59 instructions, 5 temp regs, 0 temp arrays:
// ALU 40 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedoplbggbbgndfdocpfcjmjpecmlelgfniabaaaaaaaaaoaaaaaeaaaaaa
daaaaaaaieaeaaaaneamaaaaeeanaaaaebgpgodjemaeaaaaemaeaaaaaaacpopp
oiadaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaacaa
abaaabaaaaaaaaaaabaaaeaaabaaacaaaaaaaaaaacaaaeaaaeaaadaaaaaaaaaa
acaaapaaabaaahaaaaaaaaaaadaaaaaaaeaaaiaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafamaaapkaaaaaaaeaaaaaialpjkjjbjdpaaaaaadpfbaaaaafanaaapka
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjaabaaaaacaaaaabiaadaakkka
abaaaaacaaaaaciaaeaakkkaabaaaaacaaaaaeiaafaakkkaceaaaaacabaaahia
aaaaoeiacdaaaaacabaaahoaabaaoeiaamaaaaadaaaaahiaabaaoeiaabaaoeib
amaaaaadacaaahiaabaaoeibabaaoeiaacaaaaadaaaaaliaaaaakeiaacaakeib
acaaaaadaaaaaeiaaaaakkibacaakkiaaeaaaaaeacaaadiaacaaoejaamaaaaka
amaaffkaamaaaaadabaaaiiaacaaffibacaaffiaamaaaaadacaaaeiaacaaffia
acaaffibacaaaaadabaaaiiaabaappiaacaakkibafaaaaadadaaahiaaaaapeia
abaappiaafaaaaadadaaahiaabaanjiaadaaoeiaafaaaaadabaaakiaaaaagaia
acaaaaiaamaaaaadacaaamiaabaaneibabaaneiaamaaaaadaeaaadiaabaaonia
abaaonibacaaaaadacaaamiaacaaoeiaaeaaeeibafaaaaadaaaaadiaaaaaoeia
acaaooiaaeaaaaaeaaaaadiaaaaaoeiaabaaociaadaaoeiaafaaaaadacaaamia
acaaffiaaeaaeekaaeaaaaaeadaaadiaadaaoekaaaaaaaiaacaaooiaafaaaaad
aaaaadiaaaaaffiaaeaaobkaaeaaaaaeaaaaadiaadaaobkaabaappiaaaaaoeia
aeaaaaaeabaaagiaafaanakaabaaffiaadaanaiaaeaaaaaeacaaadoaabaaojia
amaakkkaamaappkaaeaaaaaeaaaaadiaafaaobkaacaaffiaaaaaoeiaafaaaaad
aaaaaeiaaaaakkiaacaaaaiaaeaaaaaeacaaamoaaaaaeeiaamaakkkaamaappka
aeaaaaaeaaaaadiaadaaoekaaaaakkiaacaaooiaamaaaaadabaaaciaaaaakkib
aaaakkiaamaaaaadaaaaaeiaaaaakkiaaaaakkibacaaaaadaaaaaeiaaaaakkib
abaaffiaafaaaaadaaaaaeiaaaaakkiaaaaappiaaeaaaaaeaaaaaeiaaaaakkia
abaaaaiaadaakkiaaeaaaaaeaaaaadiaafaaoekaaaaakkiaaaaaoeiaaeaaaaae
adaaadoaaaaaoeiaamaakkkaamaappkaabaaaaacaaaaahiaahaaoekaacaaaaad
aaaaahiaaaaaoeiaacaaoekbaiaaaaadaaaaabiaaaaaoeiaaaaaoeiaahaaaaac
aaaaabiaaaaaaaiaagaaaaacaaaaabiaaaaaaaiaafaaaaadaaaaabiaaaaaaaia
abaaffkaalaaaaadaaaaabiaaaaaaaiaanaaaakaakaaaaadaaaaabiaaaaaaaia
amaaffkbafaaaaadaaaaaioaaaaaaaiaabaappjaaeaaaaaeaaaaapiaagaaoeka
aaaappjaaaaaoejaafaaaaadabaaapiaaaaaffiaajaaoekaaeaaaaaeabaaapia
aiaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapiaakaaoekaaaaakkiaabaaoeia
aeaaaaaeaaaaapiaalaaoekaaaaappiaabaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaahoaabaaoeja
ppppaaaafdeieefceiaiaaaaeaaaabaabcacaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaa
aeaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
ahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
acaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaadkbabaaaabaaaaaa
dgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaackiacaaaacaaaaaa
afaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaa
dbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaaegacbaiaebaaaaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaapdcaabaaa
acaaaaaaegbabaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaa
abeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaa
acaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaaadaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaaegacbaaaadaaaaaa
diaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaaadaaaaaaclaaaaaf
kcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaaaaaaaaaafganbaaa
aaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaakdcaabaaaaeaaaaaa
ngafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
mcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaaaeaaaaaacgaaaaai
aanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaaacaaaaaaclaaaaaf
dcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaaabaaaaaaegaabaaa
abaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaaikcaabaaaabaaaaaa
fgafbaaaabaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaakkcaabaaaabaaaaaa
agiecaaaacaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaaabaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaaacaaaaaafganbaaa
abaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
diaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaaacaaaaaaafaaaaaa
dcaaaaakgcaabaaaacaaaaaaagibcaaaacaaaaaaaeaaaaaaagaabaaaabaaaaaa
fgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaaacaaaaaaagaaaaaa
fgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaaadaaaaaangafbaaa
aaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahecaabaaaaaaaaaaa
abeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaacaaaaaa
aeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaaiccaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaaiaanaaaaaccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaacaaaaaa
agaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaapdccabaaaaeaaaaaa
egaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
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
Keywords { "SOFTPARTICLES_OFF" }
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
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
};
#line 324
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
uniform highp float _InvFade;
#line 323
uniform highp float _DistFade;
#line 341
uniform highp vec4 _TopTex_ST;
#line 374
uniform sampler2D _CameraDepthTexture;
#line 342
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 345
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 349
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 353
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 357
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 361
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 365
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 369
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
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
#line 331
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
};
#line 324
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
uniform highp float _InvFade;
#line 323
uniform highp float _DistFade;
#line 341
uniform highp vec4 _TopTex_ST;
#line 374
uniform sampler2D _CameraDepthTexture;
#line 375
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    #line 378
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    #line 382
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
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

SubProgram "opengl " {
Keywords { "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Matrix 9 [_Object2World]
Float 15 [_DistFade]
"!!ARBvp1.0
# 94 ALU
PARAM c[17] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..15],
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.xyz, c[0].x;
MOV R0.w, vertex.position;
DP4 R3.x, R0, c[1];
DP4 R3.y, R0, c[2];
DP4 R3.w, R0, c[4];
DP4 R3.z, R0, c[3];
ADD R2, R3, vertex.position;
DP4 R1.w, R2, c[8];
DP4 R0.x, R2, c[5];
DP4 R0.y, R2, c[6];
MOV R0.w, R1;
MUL R1.xyz, R0.xyww, c[0].w;
MUL R1.y, R1, c[14].x;
DP3 R0.z, c[3], c[3];
ADD result.texcoord[4].xy, R1, R1.z;
RSQ R1.x, R0.z;
MUL R1.xyz, R1.x, c[3];
DP4 R0.z, R2, c[7];
MOV result.position, R0;
MUL R0.zw, vertex.texcoord[0].xyxy, c[0].y;
SLT R0.x, c[0], -R1;
SLT R0.y, -R1.x, c[0].x;
ADD R2.x, R0, -R0.y;
ADD R0.xy, R0.zwzw, -c[0].z;
MUL R2.z, R0.x, R2.x;
SLT R2.y, R2.z, c[0].x;
SLT R0.w, R0, c[0].z;
SLT R0.z, c[0].x, R0.y;
ADD R0.z, R0, -R0.w;
SLT R0.w, c[0].x, R2.z;
ADD R0.w, R0, -R2.y;
MUL R2.w, R2.x, R0.z;
MUL R0.w, R0, R2.x;
MUL R2.y, R1, R2.w;
MAD R2.x, R1.z, R0.w, R2.y;
MOV R0.w, vertex.position;
MOV R2.yw, R0;
DP4 R3.w, R2, c[2];
DP4 R3.z, R2, c[1];
ADD R2.zw, -R3.xyxy, R3;
MUL R3.zw, R2, c[16].x;
SLT R2.x, c[0], -R1.y;
SLT R2.y, -R1, c[0].x;
ADD R2.y, R2.x, -R2;
MUL R2.x, R0, R2.y;
SLT R2.w, R2.x, c[0].x;
SLT R2.z, c[0].x, R2.x;
ADD R2.z, R2, -R2.w;
MUL R2.w, R0.z, R2.y;
MUL R4.x, R1.z, R2.w;
MUL R2.y, R2.z, R2;
MOV R2.zw, R0.xyyw;
MAD R2.y, R1.x, R2, R4.x;
DP4 R4.x, R2, c[1];
DP4 R4.y, R2, c[2];
ADD R2.xy, -R3, R4;
MUL R2.xy, R2, c[16].x;
ADD result.texcoord[2].xy, R2, c[0].w;
SLT R2.w, R1.z, c[0].x;
SLT R2.z, c[0].x, R1;
ADD R2.z, R2, -R2.w;
MUL R0.x, R0, R2.z;
SLT R2.z, R0.x, c[0].x;
SLT R2.y, -R1.z, c[0].x;
SLT R2.x, c[0], -R1.z;
ADD R2.x, R2, -R2.y;
SLT R2.y, c[0].x, R0.x;
ADD R2.y, R2, -R2.z;
MUL R2.z, R0, R2.x;
MUL R0.z, R2.x, R2.y;
MUL R2.w, R1.y, R2.z;
MAD R0.z, R1.x, R0, R2.w;
MOV R2.z, c[11].w;
MOV R2.x, c[9].w;
MOV R2.y, c[10].w;
ADD R2.xyz, -R2, c[13];
DP3 R2.x, R2, R2;
RSQ R2.z, R2.x;
DP4 R2.y, R0, c[2];
DP4 R2.x, R0, c[1];
ADD R0.xy, -R3, R2;
MUL R2.xy, R0, c[16].x;
RCP R0.z, R2.z;
MUL R0.z, R0, c[15].x;
MIN R0.x, R0.z, c[0].z;
MAX R0.x, R0, c[0];
MUL result.color.w, vertex.color, R0.x;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[1].xy, R3.zwzw, c[0].w;
ADD result.texcoord[3].xy, R2, c[0].w;
MOV result.texcoord[4].w, R1;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R1;
MOV result.texcoord[4].z, -R0.x;
END
# 94 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_Object2World]
Float 15 [_DistFade]
"vs_2_0
; 89 ALU
def c16, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c17, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xyz, c16.x
mov r0.w, v0
dp4 r2.x, r0, c0
dp4 r2.y, r0, c1
dp4 r2.w, r0, c3
dp4 r2.z, r0, c2
add r3, r2, v0
dp4 r1.w, r3, c7
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
mov r0.w, r1
mul r1.xyz, r0.xyww, c17.y
mul r1.y, r1, c13.x
mad oT4.xy, r1.z, c14.zwzw, r1
dp3 r0.z, c2, c2
rsq r1.x, r0.z
mul r1.xyz, r1.x, c2
dp4 r0.z, r3, c6
mov oPos, r0
mad r0.xy, v2, c16.z, c16.w
slt r2.z, -r0.y, r0.y
slt r0.z, -r1.x, r1.x
slt r0.w, r1.x, -r1.x
sub r0.w, r0, r0.z
slt r0.z, r0.y, -r0.y
sub r0.z, r2, r0
mul r2.z, r0.x, r0.w
mul r2.w, r0, r0.z
mov r3.z, r2
slt r3.y, -r2.z, r2.z
slt r3.x, r2.z, -r2.z
sub r3.x, r3.y, r3
mul r0.w, r3.x, r0
mul r2.w, r1.y, r2
mad r3.x, r1.z, r0.w, r2.w
mov r0.w, v0
mov r3.yw, r0
dp4 r2.w, r3, c1
dp4 r2.z, r3, c0
add r2.zw, -r2.xyxy, r2
mov r3.zw, r0.xyyw
slt r3.x, -r1.y, r1.y
slt r3.y, r1, -r1
sub r3.y, r3, r3.x
mul r3.x, r0, r3.y
mad oT1.xy, r2.zwzw, c17.x, c17.y
slt r2.z, r3.x, -r3.x
slt r2.w, -r3.x, r3.x
sub r2.w, r2, r2.z
mul r2.z, r0, r3.y
mul r2.w, r2, r3.y
mul r2.z, r1, r2
mad r3.y, r1.x, r2.w, r2.z
dp4 r2.w, r3, c1
dp4 r2.z, r3, c0
add r2.zw, -r2.xyxy, r2
slt r3.y, r1.z, -r1.z
slt r3.x, -r1.z, r1.z
sub r3.z, r3.x, r3.y
mul r0.x, r0, r3.z
mad oT2.xy, r2.zwzw, c17.x, c17.y
slt r2.w, -r0.x, r0.x
slt r2.z, r0.x, -r0.x
sub r2.z, r2.w, r2
sub r2.w, r3.y, r3.x
mul r0.z, r0, r2.w
mul r2.z, r2.w, r2
mul r0.z, r1.y, r0
mad r0.z, r1.x, r2, r0
mov r3.z, c10.w
mov r3.x, c8.w
mov r3.y, c9.w
add r3.xyz, -r3, c12
dp3 r2.w, r3, r3
rsq r2.z, r2.w
rcp r3.x, r2.z
dp4 r2.w, r0, c1
dp4 r2.z, r0, c0
add r0.xy, -r2, r2.zwzw
mul r0.z, r3.x, c15.x
min r0.z, r0, c16.y
mad oT3.xy, r0, c17.x, c17.y
max r0.x, r0.z, c16
mul oD0.w, v1, r0.x
dp4 r0.x, v0, c2
mov oT4.w, r1
mov oD0.xyz, v1
abs oT0.xyz, r1
mov oT4.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64 // 40 used size, 5 vars
Float 36 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 69 instructions, 6 temp regs, 0 temp arrays:
// ALU 48 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedgkjkiclbpllpmdfpggmlcbpomknpjffeabaaaaaaaialaaaaadaaaaaa
cmaaaaaajmaaaaaahaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
mmaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaamcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaamcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaamcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaamcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaamcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcjaajaaaaeaaaabaageacaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaabaaaaaaafjaaaaaeegiocaaaadaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaa
adaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaac
agaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaahaaaaaapgbpbaaa
aaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaa
abaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaakhcaabaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaa
aaaaaaaabkiacaaaaaaaaaaaacaaaaaadiaaaaahiccabaaaabaaaaaackaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaa
dgaaaaagbcaabaaaabaaaaaackiacaaaacaaaaaaaeaaaaaadgaaaaagccaabaaa
abaaaaaackiacaaaacaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaa
acaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaalhcaabaaa
adaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
adaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
dbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaadaaaaaadbaaaaah
icaabaaaabaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaa
hcaabaaaaeaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaaclaaaaafhcaabaaa
aeaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaajgafbaaaabaaaaaa
egacbaaaaeaaaaaaclaaaaafkcaabaaaabaaaaaaagaebaaaacaaaaaadiaaaaah
kcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaaadaaaaaadbaaaaakmcaabaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaabaaaaaa
dbaaaaakdcaabaaaafaaaaaangafbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaakgaobaiaebaaaaaaadaaaaaa
agaebaaaafaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaaacaaaaaa
ogakbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadcaaaaaj
dcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaabaaaaaaegaabaaaaeaaaaaa
diaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaacaaaaaaafaaaaaa
dcaaaaakkcaabaaaacaaaaaaagiecaaaacaaaaaaaeaaaaaapgapbaaaabaaaaaa
fganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaacaaaaaaagaaaaaa
fgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaa
agiecaaaacaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaacaaaaaa
aeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaa
agiecaaaacaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaap
dccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaa
dbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaah
ecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaa
acaaaaaaegiacaaaacaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaa
boaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaa
cgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
claaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaacaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaa
dcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaafaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
afaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaafaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_7 + _glesVertex));
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
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
  ZYv_3.z = (tmpvar_11.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_11.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_11.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_11.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_11.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_11.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_13;
  p_13 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((_DistFade * sqrt(dot (p_13, p_13))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_14);
  highp vec4 o_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_15.xyw;
  tmpvar_5.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  mediump vec4 ztex_3;
  mediump float zval_4;
  mediump vec4 ytex_5;
  mediump float yval_6;
  mediump vec4 xtex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD0.y;
  yval_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD0.z;
  zval_4 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4);
  highp float z_14;
  z_14 = tmpvar_13.x;
  highp float tmpvar_15;
  tmpvar_15 = (xlv_COLOR.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * z_14) + _ZBufferParams.w))) - xlv_TEXCOORD4.z)), 0.0, 1.0));
  tmpvar_2.w = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * tmpvar_2) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  tmpvar_1 = tmpvar_16;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _DistFade;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_projection * (tmpvar_7 + _glesVertex));
  vec4 v_9;
  v_9.x = glstate_matrix_modelview0[0].z;
  v_9.y = glstate_matrix_modelview0[1].z;
  v_9.z = glstate_matrix_modelview0[2].z;
  v_9.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
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
  ZYv_3.z = (tmpvar_11.x * sign(-(tmpvar_10.x)));
  XZv_2.x = (tmpvar_11.x * sign(-(tmpvar_10.y)));
  XYv_1.x = (tmpvar_11.x * sign(tmpvar_10.z));
  ZYv_3.x = ((sign(-(tmpvar_10.x)) * sign(ZYv_3.z)) * tmpvar_10.z);
  XZv_2.y = ((sign(-(tmpvar_10.y)) * sign(XZv_2.x)) * tmpvar_10.x);
  XYv_1.z = ((sign(-(tmpvar_10.z)) * sign(XYv_1.x)) * tmpvar_10.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_10.x)) * sign(tmpvar_11.y)) * tmpvar_10.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_10.y)) * sign(tmpvar_11.y)) * tmpvar_10.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_10.z)) * sign(tmpvar_11.y)) * tmpvar_10.y));
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec3 p_13;
  p_13 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((_DistFade * sqrt(dot (p_13, p_13))), 0.0, 1.0);
  tmpvar_4.w = (_glesColor.w * tmpvar_14);
  highp vec4 o_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_15.xyw;
  tmpvar_5.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
uniform lowp vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  mediump vec4 ztex_3;
  mediump float zval_4;
  mediump vec4 ytex_5;
  mediump float yval_6;
  mediump vec4 xtex_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD0.y;
  yval_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD0.z;
  zval_4 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4);
  highp float z_14;
  z_14 = tmpvar_13.x;
  highp float tmpvar_15;
  tmpvar_15 = (xlv_COLOR.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * z_14) + _ZBufferParams.w))) - xlv_TEXCOORD4.z)), 0.0, 1.0));
  tmpvar_2.w = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (((0.95 * _Color) * tmpvar_2) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  tmpvar_1 = tmpvar_16;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Matrix 8 [_Object2World]
Vector 14 [unity_NPOTScale]
Float 15 [_DistFade]
"agal_vs
c16 0.0 1.0 2.0 -1.0
c17 0.6 0.5 0.0 0.0
[bc]
aaaaaaaaaaaaahacbaaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c16.x
aaaaaaaaaaaaaiacaaaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.w, a0
bdaaaaaaacaaabacaaaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r2.x, r0, c0
bdaaaaaaacaaacacaaaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r2.y, r0, c1
bdaaaaaaacaaaiacaaaaaaoeacaaaaaaadaaaaoeabaaaaaa dp4 r2.w, r0, c3
bdaaaaaaacaaaeacaaaaaaoeacaaaaaaacaaaaoeabaaaaaa dp4 r2.z, r0, c2
abaaaaaaadaaapacacaaaaoeacaaaaaaaaaaaaoeaaaaaaaa add r3, r2, a0
bdaaaaaaabaaaiacadaaaaoeacaaaaaaahaaaaoeabaaaaaa dp4 r1.w, r3, c7
bdaaaaaaaaaaabacadaaaaoeacaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, r3, c4
bdaaaaaaaaaaacacadaaaaoeacaaaaaaafaaaaoeabaaaaaa dp4 r0.y, r3, c5
aaaaaaaaaaaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.w
adaaaaaaabaaahacaaaaaapeacaaaaaabbaaaaffabaaaaaa mul r1.xyz, r0.xyww, c17.y
adaaaaaaabaaacacabaaaaffacaaaaaaanaaaaaaabaaaaaa mul r1.y, r1.y, c13.x
abaaaaaaabaaadacabaaaafeacaaaaaaabaaaakkacaaaaaa add r1.xy, r1.xyyy, r1.z
aaaaaaaaaeaaapacacaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r4, c2
aaaaaaaaafaaapacacaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r5, c2
bcaaaaaaaaaaaeacaeaaaakeacaaaaaaafaaaakeacaaaaaa dp3 r0.z, r4.xyzz, r5.xyzz
adaaaaaaaeaaadaeabaaaafeacaaaaaaaoaaaaoeabaaaaaa mul v4.xy, r1.xyyy, c14
akaaaaaaabaaabacaaaaaakkacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r0.z
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r1.xyz, r1.x, c2
bdaaaaaaaaaaaeacadaaaaoeacaaaaaaagaaaaoeabaaaaaa dp4 r0.z, r3, c6
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
adaaaaaaaaaaadacadaaaaoeaaaaaaaabaaaaakkabaaaaaa mul r0.xy, a3, c16.z
abaaaaaaaaaaadacaaaaaafeacaaaaaabaaaaappabaaaaaa add r0.xy, r0.xyyy, c16.w
bfaaaaaaaeaaacacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r4.y, r0.y
ckaaaaaaacaaaeacaeaaaaffacaaaaaaaaaaaaffacaaaaaa slt r2.z, r4.y, r0.y
bfaaaaaaaeaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r1.x
ckaaaaaaaaaaaeacaeaaaaaaacaaaaaaabaaaaaaacaaaaaa slt r0.z, r4.x, r1.x
bfaaaaaaaeaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r1.x
ckaaaaaaaaaaaiacabaaaaaaacaaaaaaaeaaaaaaacaaaaaa slt r0.w, r1.x, r4.x
acaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaakkacaaaaaa sub r0.w, r0.w, r0.z
bfaaaaaaaeaaacacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r4.y, r0.y
ckaaaaaaaaaaaeacaaaaaaffacaaaaaaaeaaaaffacaaaaaa slt r0.z, r0.y, r4.y
acaaaaaaaaaaaeacacaaaakkacaaaaaaaaaaaakkacaaaaaa sub r0.z, r2.z, r0.z
adaaaaaaacaaaeacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r2.z, r0.x, r0.w
adaaaaaaacaaaiacaaaaaappacaaaaaaaaaaaakkacaaaaaa mul r2.w, r0.w, r0.z
aaaaaaaaadaaaeacacaaaakkacaaaaaaaaaaaaaaaaaaaaaa mov r3.z, r2.z
bfaaaaaaaeaaaeacacaaaakkacaaaaaaaaaaaaaaaaaaaaaa neg r4.z, r2.z
ckaaaaaaadaaacacaeaaaakkacaaaaaaacaaaakkacaaaaaa slt r3.y, r4.z, r2.z
bfaaaaaaaeaaaeacacaaaakkacaaaaaaaaaaaaaaaaaaaaaa neg r4.z, r2.z
ckaaaaaaadaaabacacaaaakkacaaaaaaaeaaaakkacaaaaaa slt r3.x, r2.z, r4.z
acaaaaaaadaaabacadaaaaffacaaaaaaadaaaaaaacaaaaaa sub r3.x, r3.y, r3.x
adaaaaaaaaaaaiacadaaaaaaacaaaaaaaaaaaappacaaaaaa mul r0.w, r3.x, r0.w
adaaaaaaacaaaiacabaaaaffacaaaaaaacaaaappacaaaaaa mul r2.w, r1.y, r2.w
adaaaaaaadaaabacabaaaakkacaaaaaaaaaaaappacaaaaaa mul r3.x, r1.z, r0.w
abaaaaaaadaaabacadaaaaaaacaaaaaaacaaaappacaaaaaa add r3.x, r3.x, r2.w
aaaaaaaaaaaaaiacaaaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.w, a0
aaaaaaaaadaaakacaaaaaaphacaaaaaaaaaaaaaaaaaaaaaa mov r3.yw, r0.wyww
bdaaaaaaacaaaiacadaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r2.w, r3, c1
bdaaaaaaacaaaeacadaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r2.z, r3, c0
bfaaaaaaaeaaadacacaaaafeacaaaaaaaaaaaaaaaaaaaaaa neg r4.xy, r2.xyyy
abaaaaaaacaaamacaeaaaaefacaaaaaaacaaaaopacaaaaaa add r2.zw, r4.yyxy, r2.wwzw
aaaaaaaaadaaamacaaaaaanpacaaaaaaaaaaaaaaaaaaaaaa mov r3.zw, r0.wwyw
bfaaaaaaaeaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r4.y, r1.y
ckaaaaaaadaaabacaeaaaaffacaaaaaaabaaaaffacaaaaaa slt r3.x, r4.y, r1.y
bfaaaaaaadaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r3.y, r1.y
ckaaaaaaadaaacacabaaaaffacaaaaaaadaaaaffacaaaaaa slt r3.y, r1.y, r3.y
acaaaaaaadaaacacadaaaaffacaaaaaaadaaaaaaacaaaaaa sub r3.y, r3.y, r3.x
adaaaaaaadaaabacaaaaaaaaacaaaaaaadaaaaffacaaaaaa mul r3.x, r0.x, r3.y
adaaaaaaaeaaadacacaaaapoacaaaaaabbaaaaaaabaaaaaa mul r4.xy, r2.zwww, c17.x
abaaaaaaabaaadaeaeaaaafeacaaaaaabbaaaaffabaaaaaa add v1.xy, r4.xyyy, c17.y
bfaaaaaaaeaaabacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r3.x
ckaaaaaaacaaaeacadaaaaaaacaaaaaaaeaaaaaaacaaaaaa slt r2.z, r3.x, r4.x
bfaaaaaaaeaaabacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r3.x
ckaaaaaaacaaaiacaeaaaaaaacaaaaaaadaaaaaaacaaaaaa slt r2.w, r4.x, r3.x
acaaaaaaacaaaiacacaaaappacaaaaaaacaaaakkacaaaaaa sub r2.w, r2.w, r2.z
adaaaaaaacaaaeacaaaaaakkacaaaaaaadaaaaffacaaaaaa mul r2.z, r0.z, r3.y
adaaaaaaacaaaiacacaaaappacaaaaaaadaaaaffacaaaaaa mul r2.w, r2.w, r3.y
adaaaaaaacaaaeacabaaaakkacaaaaaaacaaaakkacaaaaaa mul r2.z, r1.z, r2.z
adaaaaaaadaaacacabaaaaaaacaaaaaaacaaaappacaaaaaa mul r3.y, r1.x, r2.w
abaaaaaaadaaacacadaaaaffacaaaaaaacaaaakkacaaaaaa add r3.y, r3.y, r2.z
bdaaaaaaacaaaiacadaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r2.w, r3, c1
bdaaaaaaacaaaeacadaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r2.z, r3, c0
bfaaaaaaaeaaadacacaaaafeacaaaaaaaaaaaaaaaaaaaaaa neg r4.xy, r2.xyyy
abaaaaaaacaaamacaeaaaaefacaaaaaaacaaaaopacaaaaaa add r2.zw, r4.yyxy, r2.wwzw
bfaaaaaaaeaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa neg r4.z, r1.z
ckaaaaaaadaaacacabaaaakkacaaaaaaaeaaaakkacaaaaaa slt r3.y, r1.z, r4.z
bfaaaaaaaeaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa neg r4.z, r1.z
ckaaaaaaadaaabacaeaaaakkacaaaaaaabaaaakkacaaaaaa slt r3.x, r4.z, r1.z
acaaaaaaadaaaeacadaaaaaaacaaaaaaadaaaaffacaaaaaa sub r3.z, r3.x, r3.y
adaaaaaaaaaaabacaaaaaaaaacaaaaaaadaaaakkacaaaaaa mul r0.x, r0.x, r3.z
adaaaaaaaeaaadacacaaaapoacaaaaaabbaaaaaaabaaaaaa mul r4.xy, r2.zwww, c17.x
abaaaaaaacaaadaeaeaaaafeacaaaaaabbaaaaffabaaaaaa add v2.xy, r4.xyyy, c17.y
bfaaaaaaaeaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r0.x
ckaaaaaaacaaaiacaeaaaaaaacaaaaaaaaaaaaaaacaaaaaa slt r2.w, r4.x, r0.x
bfaaaaaaaeaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r0.x
ckaaaaaaacaaaeacaaaaaaaaacaaaaaaaeaaaaaaacaaaaaa slt r2.z, r0.x, r4.x
acaaaaaaacaaaeacacaaaappacaaaaaaacaaaakkacaaaaaa sub r2.z, r2.w, r2.z
acaaaaaaacaaaiacadaaaaffacaaaaaaadaaaaaaacaaaaaa sub r2.w, r3.y, r3.x
adaaaaaaaaaaaeacaaaaaakkacaaaaaaacaaaappacaaaaaa mul r0.z, r0.z, r2.w
adaaaaaaacaaaeacacaaaappacaaaaaaacaaaakkacaaaaaa mul r2.z, r2.w, r2.z
adaaaaaaaaaaaeacabaaaaffacaaaaaaaaaaaakkacaaaaaa mul r0.z, r1.y, r0.z
adaaaaaaaeaaaeacabaaaaaaacaaaaaaacaaaakkacaaaaaa mul r4.z, r1.x, r2.z
abaaaaaaaaaaaeacaeaaaakkacaaaaaaaaaaaakkacaaaaaa add r0.z, r4.z, r0.z
aaaaaaaaadaaaeacakaaaappabaaaaaaaaaaaaaaaaaaaaaa mov r3.z, c10.w
aaaaaaaaadaaabacaiaaaappabaaaaaaaaaaaaaaaaaaaaaa mov r3.x, c8.w
aaaaaaaaadaaacacajaaaappabaaaaaaaaaaaaaaaaaaaaaa mov r3.y, c9.w
bfaaaaaaadaaahacadaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r3.xyz, r3.xyzz
abaaaaaaadaaahacadaaaakeacaaaaaaamaaaaoeabaaaaaa add r3.xyz, r3.xyzz, c12
bcaaaaaaacaaaiacadaaaakeacaaaaaaadaaaakeacaaaaaa dp3 r2.w, r3.xyzz, r3.xyzz
akaaaaaaacaaaeacacaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r2.z, r2.w
afaaaaaaadaaabacacaaaakkacaaaaaaaaaaaaaaaaaaaaaa rcp r3.x, r2.z
bdaaaaaaacaaaiacaaaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r2.w, r0, c1
bdaaaaaaacaaaeacaaaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r2.z, r0, c0
bfaaaaaaaaaaadacacaaaafeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xy, r2.xyyy
abaaaaaaaaaaadacaaaaaafeacaaaaaaacaaaapoacaaaaaa add r0.xy, r0.xyyy, r2.zwww
adaaaaaaaaaaaeacadaaaaaaacaaaaaaapaaaaaaabaaaaaa mul r0.z, r3.x, c15.x
agaaaaaaaaaaaeacaaaaaakkacaaaaaabaaaaaffabaaaaaa min r0.z, r0.z, c16.y
adaaaaaaaeaaadacaaaaaafeacaaaaaabbaaaaaaabaaaaaa mul r4.xy, r0.xyyy, c17.x
abaaaaaaadaaadaeaeaaaafeacaaaaaabbaaaaffabaaaaaa add v3.xy, r4.xyyy, c17.y
ahaaaaaaaaaaabacaaaaaakkacaaaaaabaaaaaoeabaaaaaa max r0.x, r0.z, c16
adaaaaaaahaaaiaeacaaaaoeaaaaaaaaaaaaaaaaacaaaaaa mul v7.w, a2, r0.x
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.x, a0, c2
aaaaaaaaaeaaaiaeabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v4.w, r1.w
aaaaaaaaahaaahaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7.xyz, a2
beaaaaaaaaaaahaeabaaaakeacaaaaaaaaaaaaaaaaaaaaaa abs v0.xyz, r1.xyzz
bfaaaaaaaeaaaeaeaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg v4.z, r0.x
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
aaaaaaaaacaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, c0
aaaaaaaaadaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.zw, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64 // 40 used size, 5 vars
Float 36 [_DistFade]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 69 instructions, 6 temp regs, 0 temp arrays:
// ALU 48 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedankeancljiaomeoheeajhpngkfbggbkfabaaaaaaaebaaaaaaeaaaaaa
daaaaaaaciafaaaamaaoaaaadaapaaaaebgpgodjpaaeaaaapaaeaaaaaaacpopp
imaeaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaacaa
abaaabaaaaaaaaaaabaaaeaaacaaacaaaaaaaaaaacaaaeaaaeaaaeaaaaaaaaaa
acaaapaaabaaaiaaaaaaaaaaadaaaaaaaeaaajaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafanaaapkaaaaaaaeaaaaaialpjkjjbjdpaaaaaadpfbaaaaafaoaaapka
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjaabaaaaacaaaaabiaaeaakkka
abaaaaacaaaaaciaafaakkkaabaaaaacaaaaaeiaagaakkkaceaaaaacabaaahia
aaaaoeiacdaaaaacabaaahoaabaaoeiaamaaaaadaaaaahiaabaaoeiaabaaoeib
amaaaaadacaaahiaabaaoeibabaaoeiaacaaaaadaaaaaliaaaaakeiaacaakeib
acaaaaadaaaaaeiaaaaakkibacaakkiaaeaaaaaeacaaadiaacaaoejaanaaaaka
anaaffkaamaaaaadabaaaiiaacaaffibacaaffiaamaaaaadacaaaeiaacaaffia
acaaffibacaaaaadabaaaiiaabaappiaacaakkibafaaaaadadaaahiaaaaapeia
abaappiaafaaaaadadaaahiaabaanjiaadaaoeiaafaaaaadabaaakiaaaaagaia
acaaaaiaamaaaaadacaaamiaabaaneibabaaneiaamaaaaadaeaaadiaabaaonia
abaaonibacaaaaadacaaamiaacaaoeiaaeaaeeibafaaaaadaaaaadiaaaaaoeia
acaaooiaaeaaaaaeaaaaadiaaaaaoeiaabaaociaadaaoeiaafaaaaadacaaamia
acaaffiaafaaeekaaeaaaaaeadaaadiaaeaaoekaaaaaaaiaacaaooiaafaaaaad
aaaaadiaaaaaffiaafaaobkaaeaaaaaeaaaaadiaaeaaobkaabaappiaaaaaoeia
aeaaaaaeabaaagiaagaanakaabaaffiaadaanaiaaeaaaaaeacaaadoaabaaojia
anaakkkaanaappkaaeaaaaaeaaaaadiaagaaobkaacaaffiaaaaaoeiaafaaaaad
aaaaaeiaaaaakkiaacaaaaiaaeaaaaaeacaaamoaaaaaeeiaanaakkkaanaappka
aeaaaaaeaaaaadiaaeaaoekaaaaakkiaacaaooiaamaaaaadabaaaciaaaaakkib
aaaakkiaamaaaaadaaaaaeiaaaaakkiaaaaakkibacaaaaadaaaaaeiaaaaakkib
abaaffiaafaaaaadaaaaaeiaaaaakkiaaaaappiaaeaaaaaeaaaaaeiaaaaakkia
abaaaaiaadaakkiaaeaaaaaeaaaaadiaagaaoekaaaaakkiaaaaaoeiaaeaaaaae
adaaadoaaaaaoeiaanaakkkaanaappkaabaaaaacaaaaahiaaiaaoekaacaaaaad
aaaaahiaaaaaoeiaacaaoekbaiaaaaadaaaaabiaaaaaoeiaaaaaoeiaahaaaaac
aaaaabiaaaaaaaiaagaaaaacaaaaabiaaaaaaaiaafaaaaadaaaaabiaaaaaaaia
abaaffkaalaaaaadaaaaabiaaaaaaaiaaoaaaakaakaaaaadaaaaabiaaaaaaaia
anaaffkbafaaaaadaaaaaioaaaaaaaiaabaappjaaeaaaaaeaaaaapiaahaaoeka
aaaappjaaaaaoejaafaaaaadabaaapiaaaaaffiaakaaoekaaeaaaaaeabaaapia
ajaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapiaalaaoekaaaaakkiaabaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaappiaabaaoeiaafaaaaadabaaabiaaaaaffia
adaaaakaafaaaaadabaaaiiaabaaaaiaanaappkaafaaaaadabaaafiaaaaapeia
anaappkaacaaaaadaeaaadoaabaakkiaabaaomiaafaaaaadabaaabiaaaaaffja
afaakkkaaeaaaaaeabaaabiaaeaakkkaaaaaaajaabaaaaiaaeaaaaaeabaaabia
agaakkkaaaaakkjaabaaaaiaaeaaaaaeabaaabiaahaakkkaaaaappjaabaaaaia
abaaaaacaeaaaeoaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacaeaaaioaaaaappiaabaaaaacaaaaahoa
abaaoejappppaaaafdeieefcjaajaaaaeaaaabaageacaaaafjaaaaaeegiocaaa
aaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaabaaaaaaafjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacagaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaaapaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadicaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaa
aaaaaaaaacaaaaaadiaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaa
abaaaaaackiacaaaacaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaa
acaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaacaaaaaaagaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
abaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaalhcaabaaaadaaaaaaegacbaia
ebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
hcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaap
dcaabaaaadaaaaaaegbabaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaadaaaaaadbaaaaahicaabaaaabaaaaaa
bkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaaaeaaaaaa
kgakbaaaaaaaaaaaegacbaaaacaaaaaaclaaaaafhcaabaaaaeaaaaaaegacbaaa
aeaaaaaadiaaaaahhcaabaaaaeaaaaaajgafbaaaabaaaaaaegacbaaaaeaaaaaa
claaaaafkcaabaaaabaaaaaaagaebaaaacaaaaaadiaaaaahkcaabaaaabaaaaaa
fganbaaaabaaaaaaagaabaaaadaaaaaadbaaaaakmcaabaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaabaaaaaadbaaaaakdcaabaaa
afaaaaaangafbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaimcaabaaaadaaaaaakgaobaiaebaaaaaaadaaaaaaagaebaaaafaaaaaa
cgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaaacaaaaaaogakbaaaadaaaaaa
claaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadcaaaaajdcaabaaaacaaaaaa
egaabaaaacaaaaaacgakbaaaabaaaaaaegaabaaaaeaaaaaadiaaaaaikcaabaaa
acaaaaaafgafbaaaacaaaaaaagiecaaaacaaaaaaafaaaaaadcaaaaakkcaabaaa
acaaaaaaagiecaaaacaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaa
dcaaaaakkcaabaaaacaaaaaaagiecaaaacaaaaaaagaaaaaafgafbaaaadaaaaaa
fganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaaacaaaaaa
afaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaacaaaaaaaeaaaaaaagaabaaa
acaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaacaaaaaa
agaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaa
ngafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaa
abaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaa
acaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaa
aaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaa
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
acaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaa
aeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaafaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaafaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheommaaaaaaahaaaaaaaiaaaaaa
laaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaamcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaamcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
mcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaamcaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaadamaaaamcaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
}

SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
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
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 324
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
uniform highp float _InvFade;
#line 323
uniform highp float _DistFade;
#line 342
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 378
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 343
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 346
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 350
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 354
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 358
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 362
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 366
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 370
    o.color = v.color;
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    o.projPos = ComputeScreenPos( o.pos);
    #line 374
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
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
    xlv_TEXCOORD4 = vec4(xl_retval.projPos);
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
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 324
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
uniform highp float _InvFade;
#line 323
uniform highp float _DistFade;
#line 342
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 378
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 378
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 382
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 386
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    highp float sceneZ = LinearEyeDepth( textureProj( _CameraDepthTexture, i.projPos).x);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (sceneZ - partZ)));
    #line 390
    i.color.w *= fade;
    mediump vec4 prev = (((0.95 * _Color) * i.color) * tex);
    return prev;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.viewDir = vec3(xlv_TEXCOORD0);
    xlt_i.texcoordZY = vec2(xlv_TEXCOORD1);
    xlt_i.texcoordXZ = vec2(xlv_TEXCOORD2);
    xlt_i.texcoordXY = vec2(xlv_TEXCOORD3);
    xlt_i.projPos = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 2
//   opengl - ALU: 10 to 17, TEX: 3 to 4
//   d3d9 - ALU: 8 to 14, TEX: 3 to 4
//   d3d11 - ALU: 7 to 13, TEX: 3 to 4, FLOW: 1 to 1
//   d3d11_9x - ALU: 7 to 13, TEX: 3 to 4, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "SOFTPARTICLES_OFF" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.95019531 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R2, fragment.texcoord[1], texture[0], 2D;
TEX R1, fragment.texcoord[2], texture[1], 2D;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R1, R1, -R2;
MAD R1, fragment.texcoord[0].y, R1, R2;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL result.color, R0, c[1].x;
END
# 10 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_OFF" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_2_0
; 8 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.95019531, 0, 0, 0
dcl v0
dcl t0.xyz
dcl t1.xy
dcl t2.xy
dcl t3.xy
texld r2, t3, s2
texld r0, t1, s0
texld r1, t2, s1
add_pp r1, r1, -r0
mad_pp r0, t0.y, r1, r0
add_pp r1, r2, -r0
mad_pp r1, t0.z, r1, r0
mul_pp r0, v0, c0
mul_pp r0, r0, r1
mul_pp r0, r0, c1.x
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_OFF" }
ConstBuffer "$Globals" 64 // 32 used size, 5 vars
Vector 16 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedeomphjlflljhcdgappkaigcnjmnnniapabaaaaaadmadaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaakkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakkaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaakkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
biacaaaaeaaaaaaaigaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
gcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaia
ebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaafgbfbaaaacaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaia
ebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaakgbkbaaa
acaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
egbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaakpccabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaddddhddpddddhddpddddhddpddddhddpdoaaaaab"
}

SubProgram "gles " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "SOFTPARTICLES_OFF" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"agal_ps
c1 0.950195 0.0 0.0 0.0
[bc]
ciaaaaaaacaaapacadaaaaoeaeaaaaaaacaaaaaaafaababb tex r2, v3, s2 <2d wrap linear point>
ciaaaaaaaaaaapacabaaaaoeaeaaaaaaaaaaaaaaafaababb tex r0, v1, s0 <2d wrap linear point>
ciaaaaaaabaaapacacaaaaoeaeaaaaaaabaaaaaaafaababb tex r1, v2, s1 <2d wrap linear point>
acaaaaaaabaaapacabaaaaoeacaaaaaaaaaaaaoeacaaaaaa sub r1, r1, r0
adaaaaaaadaaapacaaaaaaffaeaaaaaaabaaaaoeacaaaaaa mul r3, v0.y, r1
abaaaaaaaaaaapacadaaaaoeacaaaaaaaaaaaaoeacaaaaaa add r0, r3, r0
acaaaaaaabaaapacacaaaaoeacaaaaaaaaaaaaoeacaaaaaa sub r1, r2, r0
adaaaaaaabaaapacaaaaaakkaeaaaaaaabaaaaoeacaaaaaa mul r1, v0.z, r1
abaaaaaaabaaapacabaaaaoeacaaaaaaaaaaaaoeacaaaaaa add r1, r1, r0
adaaaaaaaaaaapacahaaaaoeaeaaaaaaaaaaaaoeabaaaaaa mul r0, v7, c0
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaaaabaaaaaa mul r0, r0, c1.x
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_OFF" }
ConstBuffer "$Globals" 64 // 32 used size, 5 vars
Vector 16 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedaaplcgeoladelibjlmbaanpnefigjclpabaaaaaajiaeaaaaaeaaaaaa
daaaaaaaiiabaaaakiadaaaageaeaaaaebgpgodjfaabaaaafaabaaaaaaacpppp
beabaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapka
ddddhddpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacplabpaaaaac
aaaaaaiaabaachlabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaadla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkaabaaaaacaaaaadiaacaabllaecaaaaadaaaacpiaaaaaoeiaaaaioeka
ecaaaaadabaacpiaacaaoelaabaioekaecaaaaadacaacpiaadaaoelaacaioeka
bcaaaaaeadaacpiaabaafflaaaaaoeiaabaaoeiabcaaaaaeaaaacpiaabaakkla
acaaoeiaadaaoeiaafaaaaadabaacpiaaaaaoelaaaaaoekaafaaaaadaaaacpia
aaaaoeiaabaaoeiaafaaaaadaaaacpiaaaaaoeiaabaaaakaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcbiacaaaaeaaaaaaaigaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaadmcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaj
pcaabaaaaaaaaaaakgbkbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaak
pccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaddddhddpddddhddpddddhddp
ddddhddpdoaaaaabejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaakkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahagaaaa
kkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakkaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaamamaaaakkaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "SOFTPARTICLES_ON" }
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 17 ALU, 4 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.95019531 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TXP R3.x, fragment.texcoord[4], texture[3], 2D;
TEX R2, fragment.texcoord[1], texture[0], 2D;
TEX R1, fragment.texcoord[2], texture[1], 2D;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R1, R1, -R2;
MAD R1, fragment.texcoord[0].y, R1, R2;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MAD R3.x, R3, c[0].z, c[0].w;
RCP R2.x, R3.x;
ADD R2.x, R2, -fragment.texcoord[4].z;
MUL_SAT R0.w, R2.x, c[2].x;
MOV R0.xyz, fragment.color.primary;
MUL R0.w, fragment.color.primary, R0;
MUL R0, R0, c[1];
MUL R0, R0, R1;
MUL result.color, R0, c[3].x;
END
# 17 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_ON" }
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_2_0
; 14 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.95019531, 0, 0, 0
dcl v0
dcl t0.xyz
dcl t1.xy
dcl t2.xy
dcl t3.xy
dcl t4
texldp r2, t4, s3
texld r0, t3, s2
texld r1, t2, s1
texld r3, t1, s0
mad r2.x, r2, c0.z, c0.w
rcp r2.x, r2.x
add_pp r1, r1, -r3
mad_pp r1, t0.y, r1, r3
add_pp r0, r0, -r1
mad_pp r0, t0.z, r0, r1
add r2.x, r2, -t4.z
mul_sat r1.x, r2, c2
mov_pp r2.xyz, v0
mul_pp r2.w, v0, r1.x
mul_pp r1, r2, c1
mul_pp r0, r1, r0
mul_pp r0, r0, c3.x
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_ON" }
ConstBuffer "$Globals" 64 // 36 used size, 5 vars
Vector 16 [_Color] 4
Float 32 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 19 instructions, 3 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecededjkdpnnakfgadbiogpjcgapcfnmljjiabaaaaaajaaeaaaaadaaaaaa
cmaaaaaaaaabaaaadeabaaaaejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaamcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaamcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaamcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaamcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaamcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfeadaaaaeaaaaaaa
nfaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
afaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackbabaiaebaaaaaa
afaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
acaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaadkbabaaaabaaaaaa
dgaaaaafhcaabaaaaaaaaaaaegbcbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaaj
pcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaa
acaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaadiaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaddddhddp
ddddhddpddddhddpddddhddpdoaaaaab"
}

SubProgram "gles " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "SOFTPARTICLES_ON" }
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"agal_ps
c3 1.0 0.003922 0.000015 0.0
c4 0.950195 0.0 0.0 0.0
[bc]
ciaaaaaaacaaapacadaaaaoeaeaaaaaaacaaaaaaafaababb tex r2, v3, s2 <2d wrap linear point>
ciaaaaaaadaaapacacaaaaoeaeaaaaaaabaaaaaaafaababb tex r3, v2, s1 <2d wrap linear point>
aeaaaaaaaaaaapacaeaaaaoeaeaaaaaaaeaaaappaeaaaaaa div r0, v4, v4.w
ciaaaaaaaaaaapacaaaaaafeacaaaaaaadaaaaaaafaababb tex r0, r0.xyyy, s3 <2d wrap linear point>
ciaaaaaaabaaapacabaaaaoeaeaaaaaaaaaaaaaaafaababb tex r1, v1, s0 <2d wrap linear point>
bdaaaaaaaaaaabacaaaaaaoeacaaaaaaadaaaaoeabaaaaaa dp4 r0.x, r0, c3
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaakkabaaaaaa mul r0.x, r0.x, c0.z
abaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaappabaaaaaa add r0.x, r0.x, c0.w
afaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r0.x, r0.x
acaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaakkaeaaaaaa sub r0.x, r0.x, v4.z
acaaaaaaadaaapacadaaaaoeacaaaaaaabaaaaoeacaaaaaa sub r3, r3, r1
adaaaaaaadaaapacaaaaaaffaeaaaaaaadaaaaoeacaaaaaa mul r3, v0.y, r3
abaaaaaaabaaapacadaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r3, r1
acaaaaaaacaaapacacaaaaoeacaaaaaaabaaaaoeacaaaaaa sub r2, r2, r1
adaaaaaaadaaapacaaaaaakkaeaaaaaaacaaaaoeacaaaaaa mul r3, v0.z, r2
abaaaaaaabaaapacadaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r3, r1
adaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r0.x, r0.x, c2
bgaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r0.x, r0.x
aaaaaaaaacaaahacahaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r2.xyz, v7
adaaaaaaacaaaiacahaaaaoeaeaaaaaaaaaaaaaaacaaaaaa mul r2.w, v7, r0.x
adaaaaaaaaaaapacacaaaaoeacaaaaaaabaaaaoeabaaaaaa mul r0, r2, c1
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
adaaaaaaaaaaapacaaaaaaoeacaaaaaaaeaaaaaaabaaaaaa mul r0, r0, c4.x
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_ON" }
ConstBuffer "$Globals" 64 // 36 used size, 5 vars
Vector 16 [_Color] 4
Float 32 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 19 instructions, 3 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedjedjgjedlpccdnhfjlgdcinhiinenbdaabaaaaaajmagaaaaaeaaaaaa
daaaaaaadiacaaaajeafaaaagiagaaaaebgpgodjaaacaaaaaaacaaaaaaacpppp
leabaaaaemaaaaaaacaadeaaaaaaemaaaaaaemaaaeaaceaaaaaaemaaabaaaaaa
aaababaaacacacaaadadadaaaaaaabaaacaaaaaaaaaaaaaaabaaahaaabaaacaa
aaaaaaaaaaacppppfbaaaaafadaaapkaddddhddpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaaiaadaaadlabpaaaaacaaaaaaiaaeaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapka
bpaaaaacaaaaaajaadaiapkaagaaaaacaaaaaiiaaeaapplaafaaaaadaaaaadia
aaaappiaaeaaoelaabaaaaacabaaadiaacaabllaecaaaaadaaaaapiaaaaaoeia
adaioekaecaaaaadabaacpiaabaaoeiaaaaioekaecaaaaadacaacpiaacaaoela
abaioekaecaaaaadadaacpiaadaaoelaacaioekaaeaaaaaeaaaaabiaacaakkka
aaaaaaiaacaappkaagaaaaacaaaaabiaaaaaaaiaacaaaaadaaaaabiaaaaaaaia
aeaakklbafaaaaadaaaabbiaaaaaaaiaabaaaakaafaaaaadaaaaciiaaaaaaaia
aaaapplaabaaaaacaaaachiaaaaaoelaafaaaaadaaaacpiaaaaaoeiaaaaaoeka
bcaaaaaeaeaacpiaabaafflaabaaoeiaacaaoeiabcaaaaaeabaacpiaabaakkla
adaaoeiaaeaaoeiaafaaaaadaaaacpiaaaaaoeiaabaaoeiaafaaaaadaaaacpia
aaaaoeiaadaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcfeadaaaa
eaaaaaaanfaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
mcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaalbcaabaaaaaaaaaaa
ckiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaa
aoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
akaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackbabaia
ebaaaaaaafaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaacaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhcaabaaaaaaaaaaaegbcbaaaabaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
ddddhddpddddhddpddddhddpddddhddpdoaaaaabejfdeheommaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaamcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahagaaaamcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adadaaaamcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaamcaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaamcaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES3"
}

}

#LINE 147
 
		}
	} 
	
}
}