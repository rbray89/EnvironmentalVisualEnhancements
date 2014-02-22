Shader "CloudParticle" {
Properties {
	_TopTex ("Particle Texture", 2D) = "white" {}
	_LeftTex ("Particle Texture", 2D) = "white" {}
	_FrontTex ("Particle Texture", 2D) = "white" {}
	_InvFade ("Soft Particles Factor", Range(0.01,3.0)) = 1.0
	_Color ("Color Tint", Color) = (1,1,1,1)
}

Category {
	
	Lighting On
	ZWrite Off
	Cull Off
	AlphaTest Greater .01
	Blend SrcAlpha OneMinusSrcAlpha
	Tags { 
	"Queue"="Transparent" 
	"IgnoreProjector"="True" 
	"RenderType"="Transparent" 
	}

	SubShader {
		Pass {
		
			Program "vp" {
// Vertex combos: 2
//   opengl - ALU: 77 to 85
//   d3d9 - ALU: 71 to 79
//   d3d11 - ALU: 43 to 51, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 43 to 51, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
"!!ARBvp1.0
# 77 ALU
PARAM c[10] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		{ 0.60000002 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R1.x, c[3], c[3];
RSQ R1.x, R1.x;
MUL R2.xyz, R1.x, c[3];
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
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R3.zw, R0.xyxy, -c[0].z;
SLT R0.x, c[0], R3.w;
SLT R0.y, R0, c[0].z;
ADD R2.w, R0.x, -R0.y;
SLT R0.w, -R2.x, c[0].x;
SLT R0.z, c[0].x, -R2.x;
ADD R0.z, R0, -R0.w;
MUL R0.x, R3.z, R0.z;
MUL R1.x, R0.z, R2.w;
MOV R1.z, R0.x;
SLT R0.w, R0.x, c[0].x;
SLT R0.y, c[0].x, R0.x;
ADD R0.y, R0, -R0.w;
MUL R0.y, R0, R0.z;
MUL R0.w, R2.y, R1.x;
MAD R1.x, R2.z, R0.y, R0.w;
MOV R0.y, R3.w;
MOV R0.w, vertex.position;
MOV R1.yw, R0;
DP4 R0.x, R1, c[1];
DP4 R0.z, R1, c[2];
ADD R1.xy, -R3, R0.xzzw;
MUL R1.xy, R1, c[9].x;
SLT R0.z, R2, c[0].x;
SLT R0.x, c[0], R2.z;
ADD R0.x, R0, -R0.z;
MUL R0.x, R3.z, R0;
ADD result.texcoord[1].xy, R1, c[0].w;
SLT R1.x, R0, c[0];
SLT R0.z, c[0].x, R0.x;
ADD R1.y, R0.z, -R1.x;
SLT R0.z, c[0].x, -R2;
SLT R1.x, -R2.z, c[0];
ADD R1.x, R0.z, -R1;
MUL R0.z, R1.x, R1.y;
MUL R1.z, R2.w, R1.x;
MUL R1.z, R2.y, R1;
MAD R0.z, R2.x, R0, R1;
SLT R1.x, c[0], -R2.y;
SLT R1.y, -R2, c[0].x;
ADD R1.y, R1.x, -R1;
MUL R1.x, R3.z, R1.y;
SLT R1.w, R1.x, c[0].x;
SLT R1.z, c[0].x, R1.x;
ADD R1.z, R1, -R1.w;
MUL R1.w, R2, R1.y;
MUL R1.y, R1.z, R1;
MUL R2.w, R2.z, R1;
MOV R1.zw, R0.xyyw;
MAD R1.y, R2.x, R1, R2.w;
DP4 R3.z, R1, c[1];
DP4 R3.w, R1, c[2];
DP4 R1.z, R0, c[1];
DP4 R1.w, R0, c[2];
ADD R1.xy, -R3, R3.zwzw;
ADD R0.xy, -R3, R1.zwzw;
MUL R0.zw, R1.xyxy, c[9].x;
MUL R0.xy, R0, c[9].x;
ADD result.texcoord[2].xy, R0.zwzw, c[0].w;
ADD result.texcoord[3].xy, R0, c[0].w;
MOV result.color, vertex.color;
ABS result.texcoord[0].xyz, R2;
END
# 77 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
"vs_2_0
; 71 ALU
def c8, 0.00000000, 2.00000000, -1.00000000, 0
def c9, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r2.xyz, r1.x, c2
mov r0.w, v0
mov r0.xyz, c8.x
dp4 r3.x, r0, c0
dp4 r3.y, r0, c1
dp4 r3.w, r0, c3
dp4 r3.z, r0, c2
add r0, r3, v0
mad r3.zw, v2.xyxy, c8.y, c8.z
dp4 oPos.w, r0, c7
dp4 oPos.z, r0, c6
dp4 oPos.y, r0, c5
dp4 oPos.x, r0, c4
slt r0.z, r3.w, -r3.w
slt r0.x, r2, -r2
slt r0.y, -r2.x, r2.x
sub r0.y, r0.x, r0
slt r0.x, -r3.w, r3.w
sub r2.w, r0.x, r0.z
mul r0.x, r3.z, r0.y
mul r1.x, r0.y, r2.w
mov r1.z, r0.x
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r2.y, r1.x
mul r0.y, r0.z, r0
mad r1.x, r2.z, r0.y, r0.w
mov r0.y, r3.w
mov r0.w, v0
mov r1.yw, r0
dp4 r0.z, r1, c1
dp4 r0.x, r1, c0
add r1.xy, -r3, r0.xzzw
mad oT1.xy, r1, c9.x, c9.y
slt r1.z, r2, -r2
slt r1.w, -r2.z, r2.z
sub r3.w, r1, r1.z
mul r0.x, r3.z, r3.w
slt r1.x, r0, -r0
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r1.x
sub r1.x, r1.z, r1.w
mul r1.z, r2.w, r1.x
mul r0.z, r1.x, r0
mul r1.z, r2.y, r1
mad r0.z, r2.x, r0, r1
slt r1.x, r2.y, -r2.y
slt r1.y, -r2, r2
sub r1.y, r1.x, r1
mul r1.x, r3.z, r1.y
slt r1.w, r1.x, -r1.x
slt r1.z, -r1.x, r1.x
sub r1.z, r1, r1.w
mul r1.w, r2, r1.y
mul r1.y, r1.z, r1
mul r2.w, r2.z, r1
mov r1.zw, r0.xyyw
mad r1.y, r2.x, r1, r2.w
dp4 r3.z, r1, c0
dp4 r3.w, r1, c1
add r1.xy, -r3, r3.zwzw
dp4 r1.z, r0, c0
dp4 r1.w, r0, c1
add r0.xy, -r3, r1.zwzw
mad oT2.xy, r1, c9.x, c9.y
mad oT3.xy, r0, c9.x, c9.y
mov oD0, v1
abs oT0.xyz, r2
"
}

SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336 // 128 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "UnityPerDraw" 0
BindCB "UnityPerFrame" 1
// 54 instructions, 5 temp regs, 0 temp arrays:
// ALU 35 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedfdgnhenifnjfhhaeelekdienachpijkpabaaaaaapeaiaaaaadaaaaaa
cmaaaaaajmaaaaaafiabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
leaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaakkaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaakkaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcjeahaaaa
eaaaabaaofabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagiaaaaacafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaapgbpbaaaaaaaaaaa
egbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaabaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
abaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
dgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaadgaaaaagbcaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaackiacaaaaaaaaaaa
afaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaaaaaaaaaagaaaaaabaaaaaah
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
fgafbaaaabaaaaaaagiecaaaaaaaaaaaafaaaaaadcaaaaakkcaabaaaabaaaaaa
agiecaaaaaaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaaabaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaaaaaaaaaagaaaaaafgafbaaaacaaaaaafganbaaa
abaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
diaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaaaaaaaaaaafaaaaaa
dcaaaaakgcaabaaaacaaaaaaagibcaaaaaaaaaaaaeaaaaaaagaabaaaabaaaaaa
fgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaaaaaaaaaaagaaaaaa
fgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaaadaaaaaangafbaaa
aaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahecaabaaaaaaaaaaa
abeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaa
aeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaaiccaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaaiaanaaaaaccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaa
agaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaapdccabaaaaeaaaaaa
egaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadoaaaaab"
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
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 glstate_matrix_modelview0;
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
  vec4 v_6;
  v_6.x = glstate_matrix_modelview0[0].z;
  v_6.y = glstate_matrix_modelview0[1].z;
  v_6.z = glstate_matrix_modelview0[2].z;
  v_6.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(v_6.xyz);
  highp vec2 tmpvar_8;
  tmpvar_8 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_9;
  tmpvar_9.z = 0.0;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = tmpvar_8.y;
  tmpvar_9.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_9.zyw;
  XZv_2.yzw = tmpvar_9.zyw;
  XYv_1.yzw = tmpvar_9.yzw;
  ZYv_3.z = (tmpvar_8.x * sign(-(tmpvar_7.x)));
  XZv_2.x = (tmpvar_8.x * sign(-(tmpvar_7.y)));
  XYv_1.x = (tmpvar_8.x * sign(tmpvar_7.z));
  ZYv_3.x = ((sign(-(tmpvar_7.x)) * sign(ZYv_3.z)) * tmpvar_7.z);
  XZv_2.y = ((sign(-(tmpvar_7.y)) * sign(XZv_2.x)) * tmpvar_7.x);
  XYv_1.z = ((sign(-(tmpvar_7.z)) * sign(XYv_1.x)) * tmpvar_7.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_7.x)) * sign(tmpvar_8.y)) * tmpvar_7.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_7.y)) * sign(tmpvar_8.y)) * tmpvar_7.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_7.z)) * sign(tmpvar_8.y)) * tmpvar_7.y));
  gl_Position = (glstate_matrix_projection * (tmpvar_5 + _glesVertex));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = abs(tmpvar_7);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_5.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_5.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_5.xy)));
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
  tmpvar_12 = ((_Color * xlv_COLOR) * mix (mix (xtex_6, ytex_4, vec4(yval_5)), ztex_2, vec4(zval_3)));
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
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 glstate_matrix_modelview0;
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
  vec4 v_6;
  v_6.x = glstate_matrix_modelview0[0].z;
  v_6.y = glstate_matrix_modelview0[1].z;
  v_6.z = glstate_matrix_modelview0[2].z;
  v_6.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(v_6.xyz);
  highp vec2 tmpvar_8;
  tmpvar_8 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_9;
  tmpvar_9.z = 0.0;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = tmpvar_8.y;
  tmpvar_9.w = _glesVertex.w;
  ZYv_3.xyw = tmpvar_9.zyw;
  XZv_2.yzw = tmpvar_9.zyw;
  XYv_1.yzw = tmpvar_9.yzw;
  ZYv_3.z = (tmpvar_8.x * sign(-(tmpvar_7.x)));
  XZv_2.x = (tmpvar_8.x * sign(-(tmpvar_7.y)));
  XYv_1.x = (tmpvar_8.x * sign(tmpvar_7.z));
  ZYv_3.x = ((sign(-(tmpvar_7.x)) * sign(ZYv_3.z)) * tmpvar_7.z);
  XZv_2.y = ((sign(-(tmpvar_7.y)) * sign(XZv_2.x)) * tmpvar_7.x);
  XYv_1.z = ((sign(-(tmpvar_7.z)) * sign(XYv_1.x)) * tmpvar_7.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_7.x)) * sign(tmpvar_8.y)) * tmpvar_7.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_7.y)) * sign(tmpvar_8.y)) * tmpvar_7.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_7.z)) * sign(tmpvar_8.y)) * tmpvar_7.y));
  gl_Position = (glstate_matrix_projection * (tmpvar_5 + _glesVertex));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = abs(tmpvar_7);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_5.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_5.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_5.xy)));
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
  tmpvar_12 = ((_Color * xlv_COLOR) * mix (mix (xtex_6, ytex_4, vec4(yval_5)), ztex_2, vec4(zval_3)));
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
"agal_vs
c8 0.0 2.0 -1.0 0.0
c9 0.6 0.5 0.0 0.0
[bc]
aaaaaaaaaeaaapacacaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r4, c2
aaaaaaaaaaaaapacacaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c2
bcaaaaaaabaaabacaeaaaakeacaaaaaaaaaaaakeacaaaaaa dp3 r1.x, r4.xyzz, r0.xyzz
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaacaaahacabaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r2.xyz, r1.x, c2
aaaaaaaaaaaaaiacaaaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.w, a0
aaaaaaaaaaaaahacaiaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c8.x
bdaaaaaaadaaabacaaaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r3.x, r0, c0
bdaaaaaaadaaacacaaaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r3.y, r0, c1
bdaaaaaaadaaaiacaaaaaaoeacaaaaaaadaaaaoeabaaaaaa dp4 r3.w, r0, c3
bdaaaaaaadaaaeacaaaaaaoeacaaaaaaacaaaaoeabaaaaaa dp4 r3.z, r0, c2
abaaaaaaaaaaapacadaaaaoeacaaaaaaaaaaaaoeaaaaaaaa add r0, r3, a0
adaaaaaaadaaamacadaaaaeeaaaaaaaaaiaaaaffabaaaaaa mul r3.zw, a3.xyxy, c8.y
abaaaaaaadaaamacadaaaaopacaaaaaaaiaaaakkabaaaaaa add r3.zw, r3.wwzw, c8.z
bdaaaaaaaaaaaiadaaaaaaoeacaaaaaaahaaaaoeabaaaaaa dp4 o0.w, r0, c7
bdaaaaaaaaaaaeadaaaaaaoeacaaaaaaagaaaaoeabaaaaaa dp4 o0.z, r0, c6
bdaaaaaaaaaaacadaaaaaaoeacaaaaaaafaaaaoeabaaaaaa dp4 o0.y, r0, c5
bdaaaaaaaaaaabadaaaaaaoeacaaaaaaaeaaaaoeabaaaaaa dp4 o0.x, r0, c4
bfaaaaaaaeaaaiacadaaaappacaaaaaaaaaaaaaaaaaaaaaa neg r4.w, r3.w
ckaaaaaaaaaaaeacadaaaappacaaaaaaaeaaaappacaaaaaa slt r0.z, r3.w, r4.w
bfaaaaaaaaaaabacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r0.x, r2.x
ckaaaaaaaaaaabacacaaaaaaacaaaaaaaaaaaaaaacaaaaaa slt r0.x, r2.x, r0.x
bfaaaaaaaeaaabacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r2.x
ckaaaaaaaaaaacacaeaaaaaaacaaaaaaacaaaaaaacaaaaaa slt r0.y, r4.x, r2.x
acaaaaaaaaaaacacaaaaaaaaacaaaaaaaaaaaaffacaaaaaa sub r0.y, r0.x, r0.y
bfaaaaaaaeaaaiacadaaaappacaaaaaaaaaaaaaaaaaaaaaa neg r4.w, r3.w
ckaaaaaaaaaaabacaeaaaappacaaaaaaadaaaappacaaaaaa slt r0.x, r4.w, r3.w
acaaaaaaacaaaiacaaaaaaaaacaaaaaaaaaaaakkacaaaaaa sub r2.w, r0.x, r0.z
adaaaaaaaaaaabacadaaaakkacaaaaaaaaaaaaffacaaaaaa mul r0.x, r3.z, r0.y
adaaaaaaabaaabacaaaaaaffacaaaaaaacaaaappacaaaaaa mul r1.x, r0.y, r2.w
aaaaaaaaabaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.z, r0.x
bfaaaaaaaeaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r0.x
ckaaaaaaaaaaaiacaaaaaaaaacaaaaaaaeaaaaaaacaaaaaa slt r0.w, r0.x, r4.x
bfaaaaaaaeaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r0.x
ckaaaaaaaaaaaeacaeaaaaaaacaaaaaaaaaaaaaaacaaaaaa slt r0.z, r4.x, r0.x
acaaaaaaaaaaaeacaaaaaakkacaaaaaaaaaaaappacaaaaaa sub r0.z, r0.z, r0.w
adaaaaaaaaaaaiacacaaaaffacaaaaaaabaaaaaaacaaaaaa mul r0.w, r2.y, r1.x
adaaaaaaaaaaacacaaaaaakkacaaaaaaaaaaaaffacaaaaaa mul r0.y, r0.z, r0.y
adaaaaaaabaaabacacaaaakkacaaaaaaaaaaaaffacaaaaaa mul r1.x, r2.z, r0.y
abaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaappacaaaaaa add r1.x, r1.x, r0.w
aaaaaaaaaaaaacacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r3.w
aaaaaaaaaaaaaiacaaaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.w, a0
aaaaaaaaabaaakacaaaaaaphacaaaaaaaaaaaaaaaaaaaaaa mov r1.yw, r0.wyww
bdaaaaaaaaaaaeacabaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r0.z, r1, c1
bdaaaaaaaaaaabacabaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r0.x, r1, c0
bfaaaaaaabaaadacadaaaafeacaaaaaaaaaaaaaaaaaaaaaa neg r1.xy, r3.xyyy
abaaaaaaabaaadacabaaaafeacaaaaaaaaaaaakiacaaaaaa add r1.xy, r1.xyyy, r0.xzzz
adaaaaaaaeaaadacabaaaafeacaaaaaaajaaaaaaabaaaaaa mul r4.xy, r1.xyyy, c9.x
abaaaaaaabaaadaeaeaaaafeacaaaaaaajaaaaffabaaaaaa add v1.xy, r4.xyyy, c9.y
bfaaaaaaabaaaeacacaaaakkacaaaaaaaaaaaaaaaaaaaaaa neg r1.z, r2.z
ckaaaaaaabaaaeacacaaaakkacaaaaaaabaaaakkacaaaaaa slt r1.z, r2.z, r1.z
bfaaaaaaaeaaaeacacaaaakkacaaaaaaaaaaaaaaaaaaaaaa neg r4.z, r2.z
ckaaaaaaabaaaiacaeaaaakkacaaaaaaacaaaakkacaaaaaa slt r1.w, r4.z, r2.z
acaaaaaaadaaaiacabaaaappacaaaaaaabaaaakkacaaaaaa sub r3.w, r1.w, r1.z
adaaaaaaaaaaabacadaaaakkacaaaaaaadaaaappacaaaaaa mul r0.x, r3.z, r3.w
bfaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.x, r0.x
ckaaaaaaabaaabacaaaaaaaaacaaaaaaabaaaaaaacaaaaaa slt r1.x, r0.x, r1.x
bfaaaaaaaeaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r0.x
ckaaaaaaaaaaaeacaeaaaaaaacaaaaaaaaaaaaaaacaaaaaa slt r0.z, r4.x, r0.x
acaaaaaaaaaaaeacaaaaaakkacaaaaaaabaaaaaaacaaaaaa sub r0.z, r0.z, r1.x
acaaaaaaabaaabacabaaaakkacaaaaaaabaaaappacaaaaaa sub r1.x, r1.z, r1.w
adaaaaaaabaaaeacacaaaappacaaaaaaabaaaaaaacaaaaaa mul r1.z, r2.w, r1.x
adaaaaaaaaaaaeacabaaaaaaacaaaaaaaaaaaakkacaaaaaa mul r0.z, r1.x, r0.z
adaaaaaaabaaaeacacaaaaffacaaaaaaabaaaakkacaaaaaa mul r1.z, r2.y, r1.z
adaaaaaaaaaaaeacacaaaaaaacaaaaaaaaaaaakkacaaaaaa mul r0.z, r2.x, r0.z
abaaaaaaaaaaaeacaaaaaakkacaaaaaaabaaaakkacaaaaaa add r0.z, r0.z, r1.z
bfaaaaaaaeaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r4.y, r2.y
ckaaaaaaabaaabacacaaaaffacaaaaaaaeaaaaffacaaaaaa slt r1.x, r2.y, r4.y
bfaaaaaaabaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r1.y, r2.y
ckaaaaaaabaaacacabaaaaffacaaaaaaacaaaaffacaaaaaa slt r1.y, r1.y, r2.y
acaaaaaaabaaacacabaaaaaaacaaaaaaabaaaaffacaaaaaa sub r1.y, r1.x, r1.y
adaaaaaaabaaabacadaaaakkacaaaaaaabaaaaffacaaaaaa mul r1.x, r3.z, r1.y
bfaaaaaaaeaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r1.x
ckaaaaaaabaaaiacabaaaaaaacaaaaaaaeaaaaaaacaaaaaa slt r1.w, r1.x, r4.x
bfaaaaaaaeaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.x, r1.x
ckaaaaaaabaaaeacaeaaaaaaacaaaaaaabaaaaaaacaaaaaa slt r1.z, r4.x, r1.x
acaaaaaaabaaaeacabaaaakkacaaaaaaabaaaappacaaaaaa sub r1.z, r1.z, r1.w
adaaaaaaabaaaiacacaaaappacaaaaaaabaaaaffacaaaaaa mul r1.w, r2.w, r1.y
adaaaaaaabaaacacabaaaakkacaaaaaaabaaaaffacaaaaaa mul r1.y, r1.z, r1.y
adaaaaaaacaaaiacacaaaakkacaaaaaaabaaaappacaaaaaa mul r2.w, r2.z, r1.w
aaaaaaaaabaaamacaaaaaanpacaaaaaaaaaaaaaaaaaaaaaa mov r1.zw, r0.wwyw
adaaaaaaabaaacacacaaaaaaacaaaaaaabaaaaffacaaaaaa mul r1.y, r2.x, r1.y
abaaaaaaabaaacacabaaaaffacaaaaaaacaaaappacaaaaaa add r1.y, r1.y, r2.w
bdaaaaaaadaaaeacabaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r3.z, r1, c0
bdaaaaaaadaaaiacabaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r3.w, r1, c1
bfaaaaaaabaaadacadaaaafeacaaaaaaaaaaaaaaaaaaaaaa neg r1.xy, r3.xyyy
abaaaaaaabaaadacabaaaafeacaaaaaaadaaaapoacaaaaaa add r1.xy, r1.xyyy, r3.zwww
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r1.z, r0, c0
bdaaaaaaabaaaiacaaaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r1.w, r0, c1
bfaaaaaaaaaaadacadaaaafeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xy, r3.xyyy
abaaaaaaaaaaadacaaaaaafeacaaaaaaabaaaapoacaaaaaa add r0.xy, r0.xyyy, r1.zwww
adaaaaaaaeaaadacabaaaafeacaaaaaaajaaaaaaabaaaaaa mul r4.xy, r1.xyyy, c9.x
abaaaaaaacaaadaeaeaaaafeacaaaaaaajaaaaffabaaaaaa add v2.xy, r4.xyyy, c9.y
adaaaaaaaeaaadacaaaaaafeacaaaaaaajaaaaaaabaaaaaa mul r4.xy, r0.xyyy, c9.x
abaaaaaaadaaadaeaeaaaafeacaaaaaaajaaaaffabaaaaaa add v3.xy, r4.xyyy, c9.y
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
beaaaaaaaaaaahaeacaaaakeacaaaaaaaaaaaaaaaaaaaaaa abs v0.xyz, r2.xyzz
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
ConstBuffer "UnityPerDraw" 336 // 128 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "UnityPerDraw" 0
BindCB "UnityPerFrame" 1
// 54 instructions, 5 temp regs, 0 temp arrays:
// ALU 35 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedlobojmalmgfmbemblcdfneepmmkkfbgaabaaaaaaimamaaaaaeaaaaaa
daaaaaaameadaaaagaalaaaanaalaaaaebgpgodjimadaaaaimadaaaaaaacpopp
emadaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaaeaa
aeaaabaaaaaaaaaaabaaaaaaaeaaafaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ajaaapkaaaaaaaeaaaaaialpjkjjbjdpaaaaaadpbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjaabaaaaacaaaaabia
abaakkkaabaaaaacaaaaaciaacaakkkaabaaaaacaaaaaeiaadaakkkaceaaaaac
abaaahiaaaaaoeiacdaaaaacabaaahoaabaaoeiaamaaaaadaaaaahiaabaaoeia
abaaoeibamaaaaadacaaahiaabaaoeibabaaoeiaacaaaaadaaaaaliaaaaakeia
acaakeibacaaaaadaaaaaeiaaaaakkibacaakkiaaeaaaaaeacaaadiaacaaoeja
ajaaaakaajaaffkaamaaaaadabaaaiiaacaaffibacaaffiaamaaaaadacaaaeia
acaaffiaacaaffibacaaaaadabaaaiiaabaappiaacaakkibafaaaaadadaaahia
aaaapeiaabaappiaafaaaaadadaaahiaabaanjiaadaaoeiaafaaaaadabaaakia
aaaagaiaacaaaaiaamaaaaadacaaamiaabaaneibabaaneiaamaaaaadaeaaadia
abaaoniaabaaonibacaaaaadacaaamiaacaaoeiaaeaaeeibafaaaaadaaaaadia
aaaaoeiaacaaooiaaeaaaaaeaaaaadiaaaaaoeiaabaaociaadaaoeiaafaaaaad
acaaamiaacaaffiaacaaeekaaeaaaaaeadaaadiaabaaoekaaaaaaaiaacaaooia
afaaaaadaaaaadiaaaaaffiaacaaobkaaeaaaaaeaaaaadiaabaaobkaabaappia
aaaaoeiaaeaaaaaeabaaagiaadaanakaabaaffiaadaanaiaaeaaaaaeacaaadoa
abaaojiaajaakkkaajaappkaaeaaaaaeaaaaadiaadaaobkaacaaffiaaaaaoeia
afaaaaadaaaaaeiaaaaakkiaacaaaaiaaeaaaaaeacaaamoaaaaaeeiaajaakkka
ajaappkaaeaaaaaeaaaaadiaabaaoekaaaaakkiaacaaooiaamaaaaadabaaacia
aaaakkibaaaakkiaamaaaaadaaaaaeiaaaaakkiaaaaakkibacaaaaadaaaaaeia
aaaakkibabaaffiaafaaaaadaaaaaeiaaaaakkiaaaaappiaaeaaaaaeaaaaaeia
aaaakkiaabaaaaiaadaakkiaaeaaaaaeaaaaadiaadaaoekaaaaakkiaaaaaoeia
aeaaaaaeadaaadoaaaaaoeiaajaakkkaajaappkaaeaaaaaeaaaaapiaaeaaoeka
aaaappjaaaaaoejaafaaaaadabaaapiaaaaaffiaagaaoekaaeaaaaaeabaaapia
afaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapiaahaaoekaaaaakkiaabaaoeia
aeaaaaaeaaaaapiaaiaaoekaaaaappiaabaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaapoaabaaoeja
ppppaaaafdeieefcjeahaaaaeaaaabaaofabaaaafjaaaaaeegiocaaaaaaaaaaa
aiaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaa
aeaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
ahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaabaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaabaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaa
dgaaaaagbcaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaadgaaaaagccaabaaa
aaaaaaaackiacaaaaaaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaa
aaaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaa
acaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
dbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaah
icaabaaaabaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaa
hcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaa
adaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaa
egacbaaaadaaaaaaclaaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaah
kcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaa
dbaaaaakdcaabaaaaeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaa
agaebaaaaeaaaaaacgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaacaaaaaaclaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaaj
dcaabaaaabaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaa
diaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaaaaaaaaaafaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaaaaaaaaaaeaaaaaapgapbaaaaaaaaaaa
fganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaaaaaaaaaagaaaaaa
fgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaa
agiecaaaaaaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaaaaaaaaa
aeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaa
agiecaaaaaaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaap
dccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaa
aaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaa
dbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaaaaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaa
boaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
cgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaa
claaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaa
aaaaaaaaegiacaaaaaaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaa
dcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoleaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaakkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
kkaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaakkaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaakl"
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
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
};
#line 323
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
#line 340
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 372
#line 341
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 344
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 348
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 352
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 356
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 360
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 364
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 368
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
#line 330
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
};
#line 323
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
#line 340
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 372
#line 372
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 376
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 380
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = ((_Color * i.color) * tex);
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
Vector 9 [_ProjectionParams]
"!!ARBvp1.0
# 85 ALU
PARAM c[11] = { { 0, 2, 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9],
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
ADD R1, R3, vertex.position;
DP4 R2.w, R1, c[8];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
MOV R0.w, R2;
MUL R2.xyz, R0.xyww, c[0].w;
MUL R2.y, R2, c[9].x;
DP3 R0.z, c[3], c[3];
ADD result.texcoord[4].xy, R2, R2.z;
RSQ R2.x, R0.z;
MUL R2.xyz, R2.x, c[3];
DP4 R0.z, R1, c[7];
MOV result.position, R0;
MUL R0.xy, vertex.texcoord[0], c[0].y;
ADD R3.zw, R0.xyxy, -c[0].z;
SLT R0.x, c[0], R3.w;
SLT R0.y, R0, c[0].z;
ADD R4.x, R0, -R0.y;
SLT R0.w, -R2.x, c[0].x;
SLT R0.z, c[0].x, -R2.x;
ADD R0.z, R0, -R0.w;
MUL R0.x, R3.z, R0.z;
MOV R1.z, R0.x;
MUL R1.x, R0.z, R4;
SLT R0.w, R0.x, c[0].x;
SLT R0.y, c[0].x, R0.x;
ADD R0.y, R0, -R0.w;
MUL R0.y, R0, R0.z;
MUL R0.w, R2.y, R1.x;
MAD R1.x, R2.z, R0.y, R0.w;
MOV R0.y, R3.w;
MOV R0.w, vertex.position;
MOV R1.yw, R0;
DP4 R0.x, R1, c[1];
DP4 R0.z, R1, c[2];
ADD R1.xy, -R3, R0.xzzw;
MUL R1.xy, R1, c[10].x;
SLT R0.z, R2, c[0].x;
SLT R0.x, c[0], R2.z;
ADD R0.x, R0, -R0.z;
MUL R0.x, R3.z, R0;
ADD result.texcoord[1].xy, R1, c[0].w;
SLT R1.x, R0, c[0];
SLT R0.z, c[0].x, R0.x;
ADD R1.y, R0.z, -R1.x;
SLT R0.z, c[0].x, -R2;
SLT R1.x, -R2.z, c[0];
ADD R1.x, R0.z, -R1;
MUL R0.z, R1.x, R1.y;
MUL R1.z, R4.x, R1.x;
MUL R1.z, R2.y, R1;
MAD R0.z, R2.x, R0, R1;
SLT R1.x, c[0], -R2.y;
SLT R1.y, -R2, c[0].x;
ADD R1.y, R1.x, -R1;
MUL R1.x, R3.z, R1.y;
SLT R1.w, R1.x, c[0].x;
SLT R1.z, c[0].x, R1.x;
ADD R1.z, R1, -R1.w;
MUL R1.w, R4.x, R1.y;
MUL R3.z, R2, R1.w;
MUL R1.y, R1.z, R1;
MOV R1.zw, R0.xyyw;
MAD R1.y, R2.x, R1, R3.z;
DP4 R3.z, R1, c[1];
DP4 R3.w, R1, c[2];
DP4 R1.z, R0, c[1];
DP4 R1.w, R0, c[2];
ADD R1.xy, -R3, R3.zwzw;
ADD R0.xy, -R3, R1.zwzw;
MUL R0.xy, R0, c[10].x;
MUL R0.zw, R1.xyxy, c[10].x;
ADD result.texcoord[3].xy, R0, c[0].w;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[2].xy, R0.zwzw, c[0].w;
MOV result.texcoord[4].w, R2;
MOV result.color, vertex.color;
ABS result.texcoord[0].xyz, R2;
MOV result.texcoord[4].z, -R0.x;
END
# 85 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_2_0
; 79 ALU
def c10, 0.00000000, 2.00000000, -1.00000000, 0.50000000
def c11, 0.60000002, 0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xyz, c10.x
mov r0.w, v0
dp4 r3.x, r0, c0
dp4 r3.y, r0, c1
dp4 r3.w, r0, c3
dp4 r3.z, r0, c2
add r1, r3, v0
dp4 r2.w, r1, c7
mad r3.zw, v2.xyxy, c10.y, c10.z
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mov r0.w, r2
mul r2.xyz, r0.xyww, c10.w
mul r2.y, r2, c8.x
mad oT4.xy, r2.z, c9.zwzw, r2
dp3 r0.z, c2, c2
rsq r2.x, r0.z
mul r2.xyz, r2.x, c2
dp4 r0.z, r1, c6
mov oPos, r0
slt r0.z, r3.w, -r3.w
slt r0.x, r2, -r2
slt r0.y, -r2.x, r2.x
sub r0.y, r0.x, r0
slt r0.x, -r3.w, r3.w
sub r4.x, r0, r0.z
mul r0.x, r3.z, r0.y
mov r1.z, r0.x
mul r1.x, r0.y, r4
slt r0.w, r0.x, -r0.x
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r0.w
mul r0.w, r2.y, r1.x
mul r0.y, r0.z, r0
mad r1.x, r2.z, r0.y, r0.w
mov r0.y, r3.w
mov r0.w, v0
mov r1.yw, r0
dp4 r0.z, r1, c1
dp4 r0.x, r1, c0
add r1.xy, -r3, r0.xzzw
mad oT1.xy, r1, c11.x, c11.y
slt r1.z, r2, -r2
slt r1.w, -r2.z, r2.z
sub r3.w, r1, r1.z
mul r0.x, r3.z, r3.w
slt r1.x, r0, -r0
slt r0.z, -r0.x, r0.x
sub r0.z, r0, r1.x
sub r1.x, r1.z, r1.w
mul r1.z, r4.x, r1.x
mul r0.z, r1.x, r0
mul r1.z, r2.y, r1
mad r0.z, r2.x, r0, r1
slt r1.x, r2.y, -r2.y
slt r1.y, -r2, r2
sub r1.y, r1.x, r1
mul r1.x, r3.z, r1.y
slt r1.w, r1.x, -r1.x
slt r1.z, -r1.x, r1.x
sub r1.z, r1, r1.w
mul r1.w, r4.x, r1.y
mul r3.z, r2, r1.w
mul r1.y, r1.z, r1
mov r1.zw, r0.xyyw
mad r1.y, r2.x, r1, r3.z
dp4 r3.z, r1, c0
dp4 r3.w, r1, c1
add r1.xy, -r3, r3.zwzw
dp4 r1.z, r0, c0
dp4 r1.w, r0, c1
add r0.xy, -r3, r1.zwzw
mad oT3.xy, r0, c11.x, c11.y
dp4 r0.x, v0, c2
mad oT2.xy, r1, c11.x, c11.y
mov oT4.w, r2
mov oD0, v1
abs oT0.xyz, r2
mov oT4.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 128 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
BindCB "UnityPerFrame" 2
// 64 instructions, 6 temp regs, 0 temp arrays:
// ALU 43 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmnbbppgomkenjpcfdbegcmhelecinkhfabaaaaaageakaaaaadaaaaaa
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
edepemepfcaafeeffiedepepfceeaaklfdeieefcomaiaaaaeaaaabaadlacaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaadgaaaaag
bcaabaaaabaaaaaackiacaaaabaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaa
ckiacaaaabaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaabaaaaaa
agaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaalhcaabaaaadaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaapdcaabaaaadaaaaaaegbabaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaadaaaaaadbaaaaahicaabaaa
abaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaa
aeaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaaclaaaaafhcaabaaaaeaaaaaa
egacbaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaajgafbaaaabaaaaaaegacbaaa
aeaaaaaaclaaaaafkcaabaaaabaaaaaaagaebaaaacaaaaaadiaaaaahkcaabaaa
abaaaaaafganbaaaabaaaaaaagaabaaaadaaaaaadbaaaaakmcaabaaaadaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaabaaaaaadbaaaaak
dcaabaaaafaaaaaangafbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaimcaabaaaadaaaaaakgaobaiaebaaaaaaadaaaaaaagaebaaa
afaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaaacaaaaaaogakbaaa
adaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadcaaaaajdcaabaaa
acaaaaaaegaabaaaacaaaaaacgakbaaaabaaaaaaegaabaaaaeaaaaaadiaaaaai
kcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaabaaaaaaafaaaaaadcaaaaak
kcaabaaaacaaaaaaagiecaaaabaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaa
acaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaabaaaaaaagaaaaaafgafbaaa
adaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaa
abaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaabaaaaaaaeaaaaaa
agaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaah
ccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaa
abaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaa
egiacaaaabaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaai
ecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaai
aanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaabaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaaficcabaaaafaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaa
aaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
abaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaadkbabaaaaaaaaaaa
akaabaaaaaaaaaaadgaaaaageccabaaaafaaaaaaakaabaiaebaaaaaaaaaaaaaa
doaaaaab"
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
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.w = _glesVertex.w;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_modelview0 * tmpvar_5);
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_6 + _glesVertex));
  vec4 v_8;
  v_8.x = glstate_matrix_modelview0[0].z;
  v_8.y = glstate_matrix_modelview0[1].z;
  v_8.z = glstate_matrix_modelview0[2].z;
  v_8.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
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
  ZYv_3.z = (tmpvar_10.x * sign(-(tmpvar_9.x)));
  XZv_2.x = (tmpvar_10.x * sign(-(tmpvar_9.y)));
  XYv_1.x = (tmpvar_10.x * sign(tmpvar_9.z));
  ZYv_3.x = ((sign(-(tmpvar_9.x)) * sign(ZYv_3.z)) * tmpvar_9.z);
  XZv_2.y = ((sign(-(tmpvar_9.y)) * sign(XZv_2.x)) * tmpvar_9.x);
  XYv_1.z = ((sign(-(tmpvar_9.z)) * sign(XYv_1.x)) * tmpvar_9.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_9.x)) * sign(tmpvar_10.y)) * tmpvar_9.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_9.y)) * sign(tmpvar_10.y)) * tmpvar_9.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_9.z)) * sign(tmpvar_10.y)) * tmpvar_9.y));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_7.zw;
  tmpvar_4.xyw = o_12.xyw;
  tmpvar_4.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_6.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_6.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_6.xy)));
  xlv_TEXCOORD4 = tmpvar_4;
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
  tmpvar_16 = ((_Color * tmpvar_2) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
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
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 XYv_1;
  highp vec4 XZv_2;
  highp vec4 ZYv_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.w = _glesVertex.w;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_modelview0 * tmpvar_5);
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_projection * (tmpvar_6 + _glesVertex));
  vec4 v_8;
  v_8.x = glstate_matrix_modelview0[0].z;
  v_8.y = glstate_matrix_modelview0[1].z;
  v_8.z = glstate_matrix_modelview0[2].z;
  v_8.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
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
  ZYv_3.z = (tmpvar_10.x * sign(-(tmpvar_9.x)));
  XZv_2.x = (tmpvar_10.x * sign(-(tmpvar_9.y)));
  XYv_1.x = (tmpvar_10.x * sign(tmpvar_9.z));
  ZYv_3.x = ((sign(-(tmpvar_9.x)) * sign(ZYv_3.z)) * tmpvar_9.z);
  XZv_2.y = ((sign(-(tmpvar_9.y)) * sign(XZv_2.x)) * tmpvar_9.x);
  XYv_1.z = ((sign(-(tmpvar_9.z)) * sign(XYv_1.x)) * tmpvar_9.x);
  ZYv_3.x = (ZYv_3.x + ((sign(-(tmpvar_9.x)) * sign(tmpvar_10.y)) * tmpvar_9.y));
  XZv_2.y = (XZv_2.y + ((sign(-(tmpvar_9.y)) * sign(tmpvar_10.y)) * tmpvar_9.z));
  XYv_1.z = (XYv_1.z + ((sign(-(tmpvar_9.z)) * sign(tmpvar_10.y)) * tmpvar_9.y));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_7.zw;
  tmpvar_4.xyw = o_12.xyw;
  tmpvar_4.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_7;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_3).xy - tmpvar_6.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_2).xy - tmpvar_6.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_1).xy - tmpvar_6.xy)));
  xlv_TEXCOORD4 = tmpvar_4;
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
  tmpvar_16 = ((_Color * tmpvar_2) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
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
Vector 8 [_ProjectionParams]
Vector 9 [unity_NPOTScale]
"agal_vs
c10 0.0 2.0 -1.0 0.5
c11 0.6 0.5 0.0 0.0
[bc]
aaaaaaaaaaaaahacakaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c10.x
aaaaaaaaaaaaaiacaaaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.w, a0
bdaaaaaaadaaabacaaaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r3.x, r0, c0
bdaaaaaaadaaacacaaaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r3.y, r0, c1
bdaaaaaaadaaaiacaaaaaaoeacaaaaaaadaaaaoeabaaaaaa dp4 r3.w, r0, c3
bdaaaaaaadaaaeacaaaaaaoeacaaaaaaacaaaaoeabaaaaaa dp4 r3.z, r0, c2
abaaaaaaabaaapacadaaaaoeacaaaaaaaaaaaaoeaaaaaaaa add r1, r3, a0
bdaaaaaaacaaaiacabaaaaoeacaaaaaaahaaaaoeabaaaaaa dp4 r2.w, r1, c7
adaaaaaaadaaamacadaaaaeeaaaaaaaaakaaaaffabaaaaaa mul r3.zw, a3.xyxy, c10.y
abaaaaaaadaaamacadaaaaopacaaaaaaakaaaakkabaaaaaa add r3.zw, r3.wwzw, c10.z
bdaaaaaaaaaaabacabaaaaoeacaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, r1, c4
bdaaaaaaaaaaacacabaaaaoeacaaaaaaafaaaaoeabaaaaaa dp4 r0.y, r1, c5
aaaaaaaaaaaaaiacacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r2.w
adaaaaaaacaaahacaaaaaapeacaaaaaaakaaaappabaaaaaa mul r2.xyz, r0.xyww, c10.w
adaaaaaaacaaacacacaaaaffacaaaaaaaiaaaaaaabaaaaaa mul r2.y, r2.y, c8.x
abaaaaaaacaaadacacaaaafeacaaaaaaacaaaakkacaaaaaa add r2.xy, r2.xyyy, r2.z
aaaaaaaaafaaapacacaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r5, c2
aaaaaaaaaeaaapacacaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r4, c2
bcaaaaaaaaaaaeacafaaaakeacaaaaaaaeaaaakeacaaaaaa dp3 r0.z, r5.xyzz, r4.xyzz
adaaaaaaaeaaadaeacaaaafeacaaaaaaajaaaaoeabaaaaaa mul v4.xy, r2.xyyy, c9
akaaaaaaacaaabacaaaaaakkacaaaaaaaaaaaaaaaaaaaaaa rsq r2.x, r0.z
adaaaaaaacaaahacacaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r2.xyz, r2.x, c2
bdaaaaaaaaaaaeacabaaaaoeacaaaaaaagaaaaoeabaaaaaa dp4 r0.z, r1, c6
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
bfaaaaaaaeaaaiacadaaaappacaaaaaaaaaaaaaaaaaaaaaa neg r4.w, r3.w
ckaaaaaaaaaaaeacadaaaappacaaaaaaaeaaaappacaaaaaa slt r0.z, r3.w, r4.w
bfaaaaaaaaaaabacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r0.x, r2.x
ckaaaaaaaaaaabacacaaaaaaacaaaaaaaaaaaaaaacaaaaaa slt r0.x, r2.x, r0.x
bfaaaaaaaeaaacacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.y, r2.x
ckaaaaaaaaaaacacaeaaaaffacaaaaaaacaaaaaaacaaaaaa slt r0.y, r4.y, r2.x
acaaaaaaaaaaacacaaaaaaaaacaaaaaaaaaaaaffacaaaaaa sub r0.y, r0.x, r0.y
bfaaaaaaafaaaiacadaaaappacaaaaaaaaaaaaaaaaaaaaaa neg r5.w, r3.w
ckaaaaaaaaaaabacafaaaappacaaaaaaadaaaappacaaaaaa slt r0.x, r5.w, r3.w
acaaaaaaaeaaabacaaaaaaaaacaaaaaaaaaaaakkacaaaaaa sub r4.x, r0.x, r0.z
adaaaaaaaaaaabacadaaaakkacaaaaaaaaaaaaffacaaaaaa mul r0.x, r3.z, r0.y
aaaaaaaaabaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.z, r0.x
adaaaaaaabaaabacaaaaaaffacaaaaaaaeaaaaaaacaaaaaa mul r1.x, r0.y, r4.x
bfaaaaaaafaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r5.x, r0.x
ckaaaaaaaaaaaiacaaaaaaaaacaaaaaaafaaaaaaacaaaaaa slt r0.w, r0.x, r5.x
bfaaaaaaafaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r5.x, r0.x
ckaaaaaaaaaaaeacafaaaaaaacaaaaaaaaaaaaaaacaaaaaa slt r0.z, r5.x, r0.x
acaaaaaaaaaaaeacaaaaaakkacaaaaaaaaaaaappacaaaaaa sub r0.z, r0.z, r0.w
adaaaaaaaaaaaiacacaaaaffacaaaaaaabaaaaaaacaaaaaa mul r0.w, r2.y, r1.x
adaaaaaaaaaaacacaaaaaakkacaaaaaaaaaaaaffacaaaaaa mul r0.y, r0.z, r0.y
adaaaaaaabaaabacacaaaakkacaaaaaaaaaaaaffacaaaaaa mul r1.x, r2.z, r0.y
abaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaappacaaaaaa add r1.x, r1.x, r0.w
aaaaaaaaaaaaacacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r3.w
aaaaaaaaaaaaaiacaaaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.w, a0
aaaaaaaaabaaakacaaaaaaphacaaaaaaaaaaaaaaaaaaaaaa mov r1.yw, r0.wyww
bdaaaaaaaaaaaeacabaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r0.z, r1, c1
bdaaaaaaaaaaabacabaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r0.x, r1, c0
bfaaaaaaabaaadacadaaaafeacaaaaaaaaaaaaaaaaaaaaaa neg r1.xy, r3.xyyy
abaaaaaaabaaadacabaaaafeacaaaaaaaaaaaakiacaaaaaa add r1.xy, r1.xyyy, r0.xzzz
adaaaaaaafaaadacabaaaafeacaaaaaaalaaaaaaabaaaaaa mul r5.xy, r1.xyyy, c11.x
abaaaaaaabaaadaeafaaaafeacaaaaaaalaaaaffabaaaaaa add v1.xy, r5.xyyy, c11.y
bfaaaaaaabaaaeacacaaaakkacaaaaaaaaaaaaaaaaaaaaaa neg r1.z, r2.z
ckaaaaaaabaaaeacacaaaakkacaaaaaaabaaaakkacaaaaaa slt r1.z, r2.z, r1.z
bfaaaaaaafaaaeacacaaaakkacaaaaaaaaaaaaaaaaaaaaaa neg r5.z, r2.z
ckaaaaaaabaaaiacafaaaakkacaaaaaaacaaaakkacaaaaaa slt r1.w, r5.z, r2.z
acaaaaaaadaaaiacabaaaappacaaaaaaabaaaakkacaaaaaa sub r3.w, r1.w, r1.z
adaaaaaaaaaaabacadaaaakkacaaaaaaadaaaappacaaaaaa mul r0.x, r3.z, r3.w
bfaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.x, r0.x
ckaaaaaaabaaabacaaaaaaaaacaaaaaaabaaaaaaacaaaaaa slt r1.x, r0.x, r1.x
bfaaaaaaafaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r5.x, r0.x
ckaaaaaaaaaaaeacafaaaaaaacaaaaaaaaaaaaaaacaaaaaa slt r0.z, r5.x, r0.x
acaaaaaaaaaaaeacaaaaaakkacaaaaaaabaaaaaaacaaaaaa sub r0.z, r0.z, r1.x
acaaaaaaabaaabacabaaaakkacaaaaaaabaaaappacaaaaaa sub r1.x, r1.z, r1.w
adaaaaaaabaaaeacaeaaaaaaacaaaaaaabaaaaaaacaaaaaa mul r1.z, r4.x, r1.x
adaaaaaaaaaaaeacabaaaaaaacaaaaaaaaaaaakkacaaaaaa mul r0.z, r1.x, r0.z
adaaaaaaabaaaeacacaaaaffacaaaaaaabaaaakkacaaaaaa mul r1.z, r2.y, r1.z
adaaaaaaaaaaaeacacaaaaaaacaaaaaaaaaaaakkacaaaaaa mul r0.z, r2.x, r0.z
abaaaaaaaaaaaeacaaaaaakkacaaaaaaabaaaakkacaaaaaa add r0.z, r0.z, r1.z
bfaaaaaaafaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r5.y, r2.y
ckaaaaaaabaaabacacaaaaffacaaaaaaafaaaaffacaaaaaa slt r1.x, r2.y, r5.y
bfaaaaaaabaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r1.y, r2.y
ckaaaaaaabaaacacabaaaaffacaaaaaaacaaaaffacaaaaaa slt r1.y, r1.y, r2.y
acaaaaaaabaaacacabaaaaaaacaaaaaaabaaaaffacaaaaaa sub r1.y, r1.x, r1.y
adaaaaaaabaaabacadaaaakkacaaaaaaabaaaaffacaaaaaa mul r1.x, r3.z, r1.y
bfaaaaaaafaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r5.x, r1.x
ckaaaaaaabaaaiacabaaaaaaacaaaaaaafaaaaaaacaaaaaa slt r1.w, r1.x, r5.x
bfaaaaaaafaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r5.x, r1.x
ckaaaaaaabaaaeacafaaaaaaacaaaaaaabaaaaaaacaaaaaa slt r1.z, r5.x, r1.x
acaaaaaaabaaaeacabaaaakkacaaaaaaabaaaappacaaaaaa sub r1.z, r1.z, r1.w
adaaaaaaabaaaiacaeaaaaaaacaaaaaaabaaaaffacaaaaaa mul r1.w, r4.x, r1.y
adaaaaaaadaaaeacacaaaakkacaaaaaaabaaaappacaaaaaa mul r3.z, r2.z, r1.w
adaaaaaaabaaacacabaaaakkacaaaaaaabaaaaffacaaaaaa mul r1.y, r1.z, r1.y
aaaaaaaaabaaamacaaaaaanpacaaaaaaaaaaaaaaaaaaaaaa mov r1.zw, r0.wwyw
adaaaaaaabaaacacacaaaaaaacaaaaaaabaaaaffacaaaaaa mul r1.y, r2.x, r1.y
abaaaaaaabaaacacabaaaaffacaaaaaaadaaaakkacaaaaaa add r1.y, r1.y, r3.z
bdaaaaaaadaaaeacabaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r3.z, r1, c0
bdaaaaaaadaaaiacabaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r3.w, r1, c1
bfaaaaaaabaaadacadaaaafeacaaaaaaaaaaaaaaaaaaaaaa neg r1.xy, r3.xyyy
abaaaaaaabaaadacabaaaafeacaaaaaaadaaaapoacaaaaaa add r1.xy, r1.xyyy, r3.zwww
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 r1.z, r0, c0
bdaaaaaaabaaaiacaaaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 r1.w, r0, c1
bfaaaaaaaaaaadacadaaaafeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xy, r3.xyyy
abaaaaaaaaaaadacaaaaaafeacaaaaaaabaaaapoacaaaaaa add r0.xy, r0.xyyy, r1.zwww
adaaaaaaafaaadacaaaaaafeacaaaaaaalaaaaaaabaaaaaa mul r5.xy, r0.xyyy, c11.x
abaaaaaaadaaadaeafaaaafeacaaaaaaalaaaaffabaaaaaa add v3.xy, r5.xyyy, c11.y
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.x, a0, c2
adaaaaaaafaaadacabaaaafeacaaaaaaalaaaaaaabaaaaaa mul r5.xy, r1.xyyy, c11.x
abaaaaaaacaaadaeafaaaafeacaaaaaaalaaaaffabaaaaaa add v2.xy, r5.xyyy, c11.y
aaaaaaaaaeaaaiaeacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v4.w, r2.w
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
beaaaaaaaaaaahaeacaaaakeacaaaaaaaaaaaaaaaaaaaaaa abs v0.xyz, r2.xyzz
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
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 128 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
BindCB "UnityPerFrame" 2
// 64 instructions, 6 temp regs, 0 temp arrays:
// ALU 43 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedhndnjcnfpeaofnpoimbhlkmgpaokhdmhabaaaaaakmaoaaaaaeaaaaaa
daaaaaaaheaeaaaagianaaaanianaaaaebgpgodjdmaeaaaadmaeaaaaaaacpopp
paadaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaafaa
abaaabaaaaaaaaaaabaaaeaaaeaaacaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafakaaapkaaaaaaaeaaaaaialpjkjjbjdpaaaaaadp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaabaaaaacaaaaabiaacaakkkaabaaaaacaaaaaciaadaakkkaabaaaaac
aaaaaeiaaeaakkkaceaaaaacabaaahiaaaaaoeiacdaaaaacabaaahoaabaaoeia
amaaaaadaaaaahiaabaaoeiaabaaoeibamaaaaadacaaahiaabaaoeibabaaoeia
acaaaaadaaaaaliaaaaakeiaacaakeibacaaaaadaaaaaeiaaaaakkibacaakkia
aeaaaaaeacaaadiaacaaoejaakaaaakaakaaffkaamaaaaadabaaaiiaacaaffib
acaaffiaamaaaaadacaaaeiaacaaffiaacaaffibacaaaaadabaaaiiaabaappia
acaakkibafaaaaadadaaahiaaaaapeiaabaappiaafaaaaadadaaahiaabaanjia
adaaoeiaafaaaaadabaaakiaaaaagaiaacaaaaiaamaaaaadacaaamiaabaaneib
abaaneiaamaaaaadaeaaadiaabaaoniaabaaonibacaaaaadacaaamiaacaaoeia
aeaaeeibafaaaaadaaaaadiaaaaaoeiaacaaooiaaeaaaaaeaaaaadiaaaaaoeia
abaaociaadaaoeiaafaaaaadacaaamiaacaaffiaadaaeekaaeaaaaaeadaaadia
acaaoekaaaaaaaiaacaaooiaafaaaaadaaaaadiaaaaaffiaadaaobkaaeaaaaae
aaaaadiaacaaobkaabaappiaaaaaoeiaaeaaaaaeabaaagiaaeaanakaabaaffia
adaanaiaaeaaaaaeacaaadoaabaaojiaakaakkkaakaappkaaeaaaaaeaaaaadia
aeaaobkaacaaffiaaaaaoeiaafaaaaadaaaaaeiaaaaakkiaacaaaaiaaeaaaaae
acaaamoaaaaaeeiaakaakkkaakaappkaaeaaaaaeaaaaadiaacaaoekaaaaakkia
acaaooiaamaaaaadabaaaciaaaaakkibaaaakkiaamaaaaadaaaaaeiaaaaakkia
aaaakkibacaaaaadaaaaaeiaaaaakkibabaaffiaafaaaaadaaaaaeiaaaaakkia
aaaappiaaeaaaaaeaaaaaeiaaaaakkiaabaaaaiaadaakkiaaeaaaaaeaaaaadia
aeaaoekaaaaakkiaaaaaoeiaaeaaaaaeadaaadoaaaaaoeiaakaakkkaakaappka
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoejaafaaaaadabaaapiaaaaaffia
ahaaoekaaeaaaaaeabaaapiaagaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapia
aiaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappiaabaaoeia
afaaaaadabaaabiaaaaaffiaabaaaakaafaaaaadabaaaiiaabaaaaiaakaappka
afaaaaadabaaafiaaaaapeiaakaappkaacaaaaadaeaaadoaabaakkiaabaaomia
afaaaaadabaaabiaaaaaffjaadaakkkaaeaaaaaeabaaabiaacaakkkaaaaaaaja
abaaaaiaaeaaaaaeabaaabiaaeaakkkaaaaakkjaabaaaaiaaeaaaaaeabaaabia
afaakkkaaaaappjaabaaaaiaabaaaaacaeaaaeoaabaaaaibaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaeaaaioa
aaaappiaabaaaaacaaaaapoaabaaoejappppaaaafdeieefcomaiaaaaeaaaabaa
dlacaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaa
dgaaaaagbcaabaaaabaaaaaackiacaaaabaaaaaaaeaaaaaadgaaaaagccaabaaa
abaaaaaackiacaaaabaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaa
abaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
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
diaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaabaaaaaaafaaaaaa
dcaaaaakkcaabaaaacaaaaaaagiecaaaabaaaaaaaeaaaaaapgapbaaaabaaaaaa
fganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaabaaaaaaagaaaaaa
fgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaa
agiecaaaabaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaabaaaaaa
aeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaa
agiecaaaabaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaap
dccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaa
dbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaah
ecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaa
acaaaaaaegiacaaaabaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaa
boaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaa
cgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
claaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaa
dcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaafaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
afaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaafaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
faepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheommaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaamcaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaamcaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadamaaaamcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaa
mcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaamcaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaakl"
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
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 323
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
#line 341
uniform highp vec4 _TopTex_ST;
#line 374
uniform sampler2D _CameraDepthTexture;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
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
    o.projPos = ComputeScreenPos( o.pos);
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
#line 330
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec4 projPos;
};
#line 323
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
#line 341
uniform highp vec4 _TopTex_ST;
#line 374
uniform sampler2D _CameraDepthTexture;
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
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
    highp float sceneZ = LinearEyeDepth( textureProj( _CameraDepthTexture, i.projPos).x);
    highp float partZ = i.projPos.z;
    #line 386
    highp float fade = xll_saturate_f((_InvFade * (sceneZ - partZ)));
    i.color.w *= fade;
    mediump vec4 prev = ((_Color * i.color) * tex);
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
//   opengl - ALU: 9 to 16, TEX: 3 to 4
//   d3d9 - ALU: 7 to 13, TEX: 3 to 4
//   d3d11 - ALU: 6 to 12, TEX: 3 to 4, FLOW: 1 to 1
//   d3d11_9x - ALU: 6 to 12, TEX: 3 to 4, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "SOFTPARTICLES_OFF" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 9 ALU, 3 TEX
PARAM c[1] = { program.local[0] };
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
MUL result.color, R0, R1;
END
# 9 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_OFF" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_2_0
; 7 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
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
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_OFF" }
ConstBuffer "$Globals" 64 // 32 used size, 4 vars
Vector 16 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 10 instructions, 2 temp regs, 0 temp arrays:
// ALU 6 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedgiajoahkkfodfelagcmjinbddpoigmhkabaaaaaabeadaaaaadaaaaaa
cmaaaaaaoiaaaaaabmabaaaaejfdeheoleaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaakkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakkaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaakkaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
paabaaaaeaaaaaaahmaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaad
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
egbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadiaaaaahpccabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
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
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_OFF" }
ConstBuffer "$Globals" 64 // 32 used size, 4 vars
Vector 16 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 10 instructions, 2 temp regs, 0 temp arrays:
// ALU 6 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedpbiklihgfohcggidmbmpblacdeoeomipabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaagaabaaaafiadaaaabeaeaaaaebgpgodjciabaaaaciabaaaaaaacpppp
omaaaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaia
aaaacplabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaaiaadaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkaabaaaaacaaaaadiaacaabllaecaaaaadaaaacpia
aaaaoeiaaaaioekaecaaaaadabaacpiaacaaoelaabaioekaecaaaaadacaacpia
adaaoelaacaioekabcaaaaaeadaacpiaabaafflaaaaaoeiaabaaoeiabcaaaaae
aaaacpiaabaakklaacaaoeiaadaaoeiaafaaaaadabaacpiaaaaaoelaaaaaoeka
afaaaaadaaaacpiaaaaaoeiaabaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcpaabaaaaeaaaaaaahmaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaiaebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaafgbfbaaaacaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
aeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaa
kgbkbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadiaaaaahpccabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheoleaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakkaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahagaaaakkaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadadaaaakkaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaa
kkaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
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
# 16 ALU, 4 TEX
PARAM c[3] = { program.local[0..2] };
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
MUL result.color, R0, R1;
END
# 16 instructions, 4 R-regs
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
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
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
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_ON" }
ConstBuffer "$Globals" 64 // 36 used size, 4 vars
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
// 18 instructions, 3 temp regs, 0 temp arrays:
// ALU 12 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfolindhpflpngnkeoddccdgcfchcogolabaaaaaagiaeaaaaadaaaaaa
cmaaaaaaaaabaaaadeabaaaaejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaamcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaamcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaamcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaamcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaamcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefccmadaaaaeaaaaaaa
mlaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaa
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
egaobaaaabaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaadoaaaaab"
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
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_ON" }
ConstBuffer "$Globals" 64 // 36 used size, 4 vars
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
// 18 instructions, 3 temp regs, 0 temp arrays:
// ALU 12 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedkipkcmgcggffngnfmmebphmmhdnlcglfabaaaaaaemagaaaaaeaaaaaa
daaaaaaabaacaaaaeeafaaaabiagaaaaebgpgodjniabaaaaniabaaaaaaacpppp
imabaaaaemaaaaaaacaadeaaaaaaemaaaaaaemaaaeaaceaaaaaaemaaabaaaaaa
aaababaaacacacaaadadadaaaaaaabaaacaaaaaaaaaaaaaaabaaahaaabaaacaa
aaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachla
bpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaadlabpaaaaacaaaaaaia
aeaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaagaaaaacaaaaaiiaaeaappla
afaaaaadaaaaadiaaaaappiaaeaaoelaabaaaaacabaaadiaacaabllaecaaaaad
aaaaapiaaaaaoeiaadaioekaecaaaaadabaacpiaabaaoeiaaaaioekaecaaaaad
acaacpiaacaaoelaabaioekaecaaaaadadaacpiaadaaoelaacaioekaaeaaaaae
aaaaabiaacaakkkaaaaaaaiaacaappkaagaaaaacaaaaabiaaaaaaaiaacaaaaad
aaaaabiaaaaaaaiaaeaakklbafaaaaadaaaabbiaaaaaaaiaabaaaakaafaaaaad
aaaaciiaaaaaaaiaaaaapplaabaaaaacaaaachiaaaaaoelaafaaaaadaaaacpia
aaaaoeiaaaaaoekabcaaaaaeaeaacpiaabaafflaabaaoeiaacaaoeiabcaaaaae
abaacpiaabaakklaadaaoeiaaeaaoeiaafaaaaadaaaacpiaaaaaoeiaabaaoeia
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefccmadaaaaeaaaaaaamlaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
gcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaafaaaaaa
pgbpbaaaafaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackbabaiaebaaaaaaafaaaaaa
dicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaacaaaaaa
diaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaf
hcaabaaaaaaaaaaaegbcbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegiocaaaaaaaaaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
doaaaaabejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaamcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahagaaaamcaaaaaa
abaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaamcaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaamamaaaamcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
adadaaaamcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES3"
}

}

#LINE 145
 
		}
	} 
}
}