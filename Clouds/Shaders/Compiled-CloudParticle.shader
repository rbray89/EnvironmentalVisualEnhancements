Shader "CloudParticle" {
Properties {
	_TopTex ("Particle Texture", 2D) = "white" {}
	_BotTex ("Particle Texture", 2D) = "white" {}
	_LeftTex ("Particle Texture", 2D) = "white" {}
	_RightTex ("Particle Texture", 2D) = "white" {}
	_FrontTex ("Particle Texture", 2D) = "white" {}
	_BackTex ("Particle Texture", 2D) = "white" {}
	_Color ("Color Tint", Color) = (1,1,1,1)
}

Category {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend One OneMinusSrcColor
	ColorMask RGB
	Cull Back Lighting Off ZWrite Off Fog { Color (0,0,0,0) }

	SubShader {
		Pass {
		
			Program "vp" {
// Vertex combos: 2
//   opengl - ALU: 22 to 22
//   d3d9 - ALU: 22 to 22
//   d3d11 - ALU: 14 to 14, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 14 to 14, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_World2Object]
Vector 14 [unity_Scale]
Vector 15 [_TopTex_ST]
"!!ARBvp1.0
# 22 ALU
PARAM c[16] = { { 0, 1 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..15] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.position;
MOV R0.w, c[0].x;
MOV R1.w, c[4];
MOV R1.z, c[3].w;
MOV R1.y, c[2].w;
MOV R1.x, c[1].w;
ADD R1, R1, R0;
MOV R0.w, c[0].y;
MOV R0.xyz, c[13];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MUL R0.xyz, R2, c[14].w;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
DP4 result.position.w, R1, c[8];
DP4 result.position.z, R1, c[7];
DP4 result.position.y, R1, c[6];
DP4 result.position.x, R1, c[5];
MUL result.texcoord[1].xyz, R0.w, R0;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
END
# 22 instructions, 3 R-regs
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
Matrix 8 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_TopTex_ST]
"vs_2_0
; 22 ALU
def c15, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xyz, v0
mov r0.w, c15.x
mov r1.w, c3
mov r1.z, c2.w
mov r1.y, c1.w
mov r1.x, c0.w
add r1, r1, r0
mov r0.w, c15.y
mov r0.xyz, c12
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mul r0.xyz, r2, c13.w
dp3 r0.w, r0, r0
rsq r0.w, r0.w
dp4 oPos.w, r1, c7
dp4 oPos.z, r1, c6
dp4 oPos.y, r1, c5
dp4 oPos.x, r1, c4
mul oT1.xyz, r0.w, r0
mov oD0, v1
mad oT0.xy, v2, c14, c14.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64 // 48 used size, 4 vars
Vector 32 [_TopTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 18 instructions, 2 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkjdnhponcmjilkhabcpflglfgoamnahkabaaaaaaaeaeaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapahaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaafdfgfpfagphdgjhegjgpgoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefcneacaaaaeaaaabaalfaaaaaafjaaaaaeegiocaaa
aaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaabfaaaaaafjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadhcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadgaaaaafhcaabaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaacaaaaaaahaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaa
abaaaaaaegbobaaaabaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadiaaaaajhcaabaaa
aaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaacaaaaaabdaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgipcaaaacaaaaaabeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec4 _TopTex_ST;
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
  highp vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.x = _glesVertex.x;
  tmpvar_1.y = _glesVertex.y;
  tmpvar_1.z = _glesVertex.z;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_projection * ((glstate_matrix_modelview0 * vec4(0.0, 0.0, 0.0, 1.0)) + tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _TopTex_ST.xy) + _TopTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((_World2Object * tmpvar_2).xyz * unity_Scale.w));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform lowp vec4 _Color;
uniform sampler2D _BackTex;
uniform sampler2D _FrontTex;
uniform sampler2D _RightTex;
uniform sampler2D _LeftTex;
uniform sampler2D _BotTex;
uniform sampler2D _TopTex;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 prev_2;
  mediump vec4 tex_3;
  mediump float zval_4;
  mediump float yval_5;
  mediump float xval_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp ((0.5 + (0.5 * xlv_TEXCOORD1.x)), 0.0, 1.0);
  xval_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LeftTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_RightTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_8, tmpvar_9, vec4(xval_6));
  highp float tmpvar_11;
  tmpvar_11 = clamp ((0.5 + (0.5 * xlv_TEXCOORD1.y)), 0.0, 1.0);
  yval_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_TopTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_BotTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_14;
  tmpvar_14 = mix (tmpvar_12, tmpvar_13, vec4(yval_5));
  highp float tmpvar_15;
  tmpvar_15 = clamp ((0.5 + (0.5 * xlv_TEXCOORD1.z)), 0.0, 1.0);
  zval_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_FrontTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_BackTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_18;
  tmpvar_18 = mix (tmpvar_16, tmpvar_17, vec4(zval_4));
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (mix (tmpvar_14, tmpvar_18, vec4(abs(xlv_TEXCOORD1.z))), tmpvar_10, vec4(abs(xlv_TEXCOORD1.x)));
  tex_3 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = ((_Color * xlv_COLOR) * tex_3);
  prev_2.w = tmpvar_20.w;
  prev_2.xyz = (tmpvar_20.xyz * tmpvar_20.w);
  tmpvar_1 = prev_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec4 _TopTex_ST;
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
  highp vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.x = _glesVertex.x;
  tmpvar_1.y = _glesVertex.y;
  tmpvar_1.z = _glesVertex.z;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_projection * ((glstate_matrix_modelview0 * vec4(0.0, 0.0, 0.0, 1.0)) + tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _TopTex_ST.xy) + _TopTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((_World2Object * tmpvar_2).xyz * unity_Scale.w));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform lowp vec4 _Color;
uniform sampler2D _BackTex;
uniform sampler2D _FrontTex;
uniform sampler2D _RightTex;
uniform sampler2D _LeftTex;
uniform sampler2D _BotTex;
uniform sampler2D _TopTex;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 prev_2;
  mediump vec4 tex_3;
  mediump float zval_4;
  mediump float yval_5;
  mediump float xval_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp ((0.5 + (0.5 * xlv_TEXCOORD1.x)), 0.0, 1.0);
  xval_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LeftTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_RightTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_8, tmpvar_9, vec4(xval_6));
  highp float tmpvar_11;
  tmpvar_11 = clamp ((0.5 + (0.5 * xlv_TEXCOORD1.y)), 0.0, 1.0);
  yval_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_TopTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_BotTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_14;
  tmpvar_14 = mix (tmpvar_12, tmpvar_13, vec4(yval_5));
  highp float tmpvar_15;
  tmpvar_15 = clamp ((0.5 + (0.5 * xlv_TEXCOORD1.z)), 0.0, 1.0);
  zval_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_FrontTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_BackTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_18;
  tmpvar_18 = mix (tmpvar_16, tmpvar_17, vec4(zval_4));
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (mix (tmpvar_14, tmpvar_18, vec4(abs(xlv_TEXCOORD1.z))), tmpvar_10, vec4(abs(xlv_TEXCOORD1.x)));
  tex_3 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = ((_Color * xlv_COLOR) * tex_3);
  prev_2.w = tmpvar_20.w;
  prev_2.xyz = (tmpvar_20.xyz * tmpvar_20.w);
  tmpvar_1 = prev_2;
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
Matrix 8 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_TopTex_ST]
"agal_vs
c15 0.0 1.0 0.0 0.0
[bc]
aaaaaaaaaaaaahacaaaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a0
aaaaaaaaaaaaaiacapaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c15.x
aaaaaaaaabaaaiacadaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.w, c3
aaaaaaaaabaaaeacacaaaappabaaaaaaaaaaaaaaaaaaaaaa mov r1.z, c2.w
aaaaaaaaabaaacacabaaaappabaaaaaaaaaaaaaaaaaaaaaa mov r1.y, c1.w
aaaaaaaaabaaabacaaaaaappabaaaaaaaaaaaaaaaaaaaaaa mov r1.x, c0.w
abaaaaaaabaaapacabaaaaoeacaaaaaaaaaaaaoeacaaaaaa add r1, r1, r0
aaaaaaaaaaaaaiacapaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c15.y
aaaaaaaaaaaaahacamaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c12
bdaaaaaaacaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r2.z, r0, c10
bdaaaaaaacaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r2.x, r0, c8
bdaaaaaaacaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r2.y, r0, c9
adaaaaaaaaaaahacacaaaakeacaaaaaaanaaaappabaaaaaa mul r0.xyz, r2.xyzz, c13.w
bcaaaaaaaaaaaiacaaaaaakeacaaaaaaaaaaaakeacaaaaaa dp3 r0.w, r0.xyzz, r0.xyzz
akaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r0.w, r0.w
bdaaaaaaaaaaaiadabaaaaoeacaaaaaaahaaaaoeabaaaaaa dp4 o0.w, r1, c7
bdaaaaaaaaaaaeadabaaaaoeacaaaaaaagaaaaoeabaaaaaa dp4 o0.z, r1, c6
bdaaaaaaaaaaacadabaaaaoeacaaaaaaafaaaaoeabaaaaaa dp4 o0.y, r1, c5
bdaaaaaaaaaaabadabaaaaoeacaaaaaaaeaaaaoeabaaaaaa dp4 o0.x, r1, c4
adaaaaaaabaaahaeaaaaaappacaaaaaaaaaaaakeacaaaaaa mul v1.xyz, r0.w, r0.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
adaaaaaaaaaaadacadaaaaoeaaaaaaaaaoaaaaoeabaaaaaa mul r0.xy, a3, c14
abaaaaaaaaaaadaeaaaaaafeacaaaaaaaoaaaaooabaaaaaa add v0.xy, r0.xyyy, c14.zwzw
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64 // 48 used size, 4 vars
Vector 32 [_TopTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 18 instructions, 2 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedjhmdlmaojedkgbealmpkaokmibiieogpabaaaaaapeafaaaaaeaaaaaa
daaaaaaabmacaaaapiaeaaaagiafaaaaebgpgodjoeabaaaaoeabaaaaaaacpopp
iaabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaacaa
abaaabaaaaaaaaaaabaaaeaaabaaacaaaaaaaaaaacaaahaaabaaadaaaaaaaaaa
acaabaaaafaaaeaaaaaaaaaaadaaaaaaaeaaajaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafanaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjaaeaaaaae
abaaadoaacaaoejaabaaoekaabaaookaabaaaaacaaaaahiaacaaoekaafaaaaad
abaaahiaaaaaffiaafaaoekaaeaaaaaeaaaaaliaaeaakekaaaaaaaiaabaakeia
aeaaaaaeaaaaahiaagaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeia
ahaaoekaafaaaaadaaaaahiaaaaaoeiaaiaappkaaiaaaaadaaaaaiiaaaaaoeia
aaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadacaaahoaaaaappiaaaaaoeia
abaaaaacaaaaadiaanaaoekaaeaaaaaeaaaaapiaaaaacejaaaaaeaiaadaaoeka
afaaaaadabaaapiaaaaaffiaakaaoekaaeaaaaaeabaaapiaajaaoekaaaaaaaia
abaaoeiaaeaaaaaeabaaapiaalaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaapia
amaaoekaaaaappiaabaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacaaaaapoaabaaoejappppaaaafdeieefc
neacaaaaeaaaabaalfaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafjaaaaae
egiocaaaadaaaaaaaeaaaaaafpaaaaadhcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacacaaaaaadgaaaaafhcaabaaaaaaaaaaaegbcbaaaaaaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaacaaaaaaahaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaacaaaaaa
ogikcaaaaaaaaaaaacaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
acaaaaaabdaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapahaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfagphdgjhe
gjgpgoaaedepemepfcaafeeffiedepepfceeaakl"
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
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
    highp vec3 viewDir;
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
#line 337
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
#line 349
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 338
v2f vert( in appdata_t v ) {
    v2f o;
    #line 341
    o.vertex = (glstate_matrix_projection * ((glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, 1.0)) + vec4( v.vertex.x, v.vertex.y, v.vertex.z, 0.0)));
    o.color = v.color;
    o.texcoord = ((v.texcoord.xy * _TopTex_ST.xy) + _TopTex_ST.zw);
    o.viewDir = normalize(ObjSpaceViewDir( vec4( 0.0, 0.0, 0.0, 1.0)));
    #line 345
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.vertex);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec2(xl_retval.texcoord);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
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
#line 329
struct v2f {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
    highp vec3 viewDir;
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
#line 337
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
#line 349
#line 349
lowp vec4 frag( in v2f i ) {
    mediump float xval = xll_saturate_f((0.5 + (0.5 * i.viewDir.x)));
    mediump vec4 xtex = mix( texture( _LeftTex, i.texcoord), texture( _RightTex, i.texcoord), vec4( xval));
    #line 353
    mediump float yval = xll_saturate_f((0.5 + (0.5 * i.viewDir.y)));
    mediump vec4 ytex = mix( texture( _TopTex, i.texcoord), texture( _BotTex, i.texcoord), vec4( yval));
    mediump float zval = xll_saturate_f((0.5 + (0.5 * i.viewDir.z)));
    mediump vec4 ztex = mix( texture( _FrontTex, i.texcoord), texture( _BackTex, i.texcoord), vec4( zval));
    #line 357
    mediump vec4 tex = mix( mix( ytex, ztex, vec4( abs(i.viewDir.z))), xtex, vec4( abs(i.viewDir.x)));
    mediump vec4 prev = ((_Color * i.color) * tex);
    prev.xyz *= prev.w;
    return prev;
}
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.vertex = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.texcoord = vec2(xlv_TEXCOORD0);
    xlt_i.viewDir = vec3(xlv_TEXCOORD1);
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
Matrix 9 [_World2Object]
Vector 14 [unity_Scale]
Vector 15 [_TopTex_ST]
"!!ARBvp1.0
# 22 ALU
PARAM c[16] = { { 0, 1 },
		state.matrix.modelview[0],
		state.matrix.projection,
		program.local[9..15] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.position;
MOV R0.w, c[0].x;
MOV R1.w, c[4];
MOV R1.z, c[3].w;
MOV R1.y, c[2].w;
MOV R1.x, c[1].w;
ADD R1, R1, R0;
MOV R0.w, c[0].y;
MOV R0.xyz, c[13];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MUL R0.xyz, R2, c[14].w;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
DP4 result.position.w, R1, c[8];
DP4 result.position.z, R1, c[7];
DP4 result.position.y, R1, c[6];
DP4 result.position.x, R1, c[5];
MUL result.texcoord[1].xyz, R0.w, R0;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
END
# 22 instructions, 3 R-regs
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
Matrix 8 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_TopTex_ST]
"vs_2_0
; 22 ALU
def c15, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xyz, v0
mov r0.w, c15.x
mov r1.w, c3
mov r1.z, c2.w
mov r1.y, c1.w
mov r1.x, c0.w
add r1, r1, r0
mov r0.w, c15.y
mov r0.xyz, c12
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mul r0.xyz, r2, c13.w
dp3 r0.w, r0, r0
rsq r0.w, r0.w
dp4 oPos.w, r1, c7
dp4 oPos.z, r1, c6
dp4 oPos.y, r1, c5
dp4 oPos.x, r1, c4
mul oT1.xyz, r0.w, r0
mov oD0, v1
mad oT0.xy, v2, c14, c14.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64 // 48 used size, 4 vars
Vector 32 [_TopTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 18 instructions, 2 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkjdnhponcmjilkhabcpflglfgoamnahkabaaaaaaaeaeaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapahaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaafdfgfpfagphdgjhegjgpgoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefcneacaaaaeaaaabaalfaaaaaafjaaaaaeegiocaaa
aaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaabfaaaaaafjaaaaaeegiocaaaadaaaaaaaeaaaaaafpaaaaadhcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadgaaaaafhcaabaaa
aaaaaaaaegbcbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaacaaaaaaahaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaa
abaaaaaaegbobaaaabaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadiaaaaajhcaabaaa
aaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaacaaaaaabdaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgipcaaaacaaaaaabeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec4 _TopTex_ST;
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
  highp vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.x = _glesVertex.x;
  tmpvar_1.y = _glesVertex.y;
  tmpvar_1.z = _glesVertex.z;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_projection * ((glstate_matrix_modelview0 * vec4(0.0, 0.0, 0.0, 1.0)) + tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _TopTex_ST.xy) + _TopTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((_World2Object * tmpvar_2).xyz * unity_Scale.w));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform lowp vec4 _Color;
uniform sampler2D _BackTex;
uniform sampler2D _FrontTex;
uniform sampler2D _RightTex;
uniform sampler2D _LeftTex;
uniform sampler2D _BotTex;
uniform sampler2D _TopTex;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 prev_2;
  mediump vec4 tex_3;
  mediump float zval_4;
  mediump float yval_5;
  mediump float xval_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp ((0.5 + (0.5 * xlv_TEXCOORD1.x)), 0.0, 1.0);
  xval_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LeftTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_RightTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_8, tmpvar_9, vec4(xval_6));
  highp float tmpvar_11;
  tmpvar_11 = clamp ((0.5 + (0.5 * xlv_TEXCOORD1.y)), 0.0, 1.0);
  yval_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_TopTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_BotTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_14;
  tmpvar_14 = mix (tmpvar_12, tmpvar_13, vec4(yval_5));
  highp float tmpvar_15;
  tmpvar_15 = clamp ((0.5 + (0.5 * xlv_TEXCOORD1.z)), 0.0, 1.0);
  zval_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_FrontTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_BackTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_18;
  tmpvar_18 = mix (tmpvar_16, tmpvar_17, vec4(zval_4));
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (mix (tmpvar_14, tmpvar_18, vec4(abs(xlv_TEXCOORD1.z))), tmpvar_10, vec4(abs(xlv_TEXCOORD1.x)));
  tex_3 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = ((_Color * xlv_COLOR) * tex_3);
  prev_2.w = tmpvar_20.w;
  prev_2.xyz = (tmpvar_20.xyz * tmpvar_20.w);
  tmpvar_1 = prev_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec4 _TopTex_ST;
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
  highp vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.x = _glesVertex.x;
  tmpvar_1.y = _glesVertex.y;
  tmpvar_1.z = _glesVertex.z;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_projection * ((glstate_matrix_modelview0 * vec4(0.0, 0.0, 0.0, 1.0)) + tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _TopTex_ST.xy) + _TopTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((_World2Object * tmpvar_2).xyz * unity_Scale.w));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform lowp vec4 _Color;
uniform sampler2D _BackTex;
uniform sampler2D _FrontTex;
uniform sampler2D _RightTex;
uniform sampler2D _LeftTex;
uniform sampler2D _BotTex;
uniform sampler2D _TopTex;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 prev_2;
  mediump vec4 tex_3;
  mediump float zval_4;
  mediump float yval_5;
  mediump float xval_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp ((0.5 + (0.5 * xlv_TEXCOORD1.x)), 0.0, 1.0);
  xval_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LeftTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_RightTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_10;
  tmpvar_10 = mix (tmpvar_8, tmpvar_9, vec4(xval_6));
  highp float tmpvar_11;
  tmpvar_11 = clamp ((0.5 + (0.5 * xlv_TEXCOORD1.y)), 0.0, 1.0);
  yval_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_TopTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_BotTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_14;
  tmpvar_14 = mix (tmpvar_12, tmpvar_13, vec4(yval_5));
  highp float tmpvar_15;
  tmpvar_15 = clamp ((0.5 + (0.5 * xlv_TEXCOORD1.z)), 0.0, 1.0);
  zval_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_FrontTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_BackTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_18;
  tmpvar_18 = mix (tmpvar_16, tmpvar_17, vec4(zval_4));
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (mix (tmpvar_14, tmpvar_18, vec4(abs(xlv_TEXCOORD1.z))), tmpvar_10, vec4(abs(xlv_TEXCOORD1.x)));
  tex_3 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = ((_Color * xlv_COLOR) * tex_3);
  prev_2.w = tmpvar_20.w;
  prev_2.xyz = (tmpvar_20.xyz * tmpvar_20.w);
  tmpvar_1 = prev_2;
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
Matrix 8 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_TopTex_ST]
"agal_vs
c15 0.0 1.0 0.0 0.0
[bc]
aaaaaaaaaaaaahacaaaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a0
aaaaaaaaaaaaaiacapaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c15.x
aaaaaaaaabaaaiacadaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.w, c3
aaaaaaaaabaaaeacacaaaappabaaaaaaaaaaaaaaaaaaaaaa mov r1.z, c2.w
aaaaaaaaabaaacacabaaaappabaaaaaaaaaaaaaaaaaaaaaa mov r1.y, c1.w
aaaaaaaaabaaabacaaaaaappabaaaaaaaaaaaaaaaaaaaaaa mov r1.x, c0.w
abaaaaaaabaaapacabaaaaoeacaaaaaaaaaaaaoeacaaaaaa add r1, r1, r0
aaaaaaaaaaaaaiacapaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c15.y
aaaaaaaaaaaaahacamaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c12
bdaaaaaaacaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r2.z, r0, c10
bdaaaaaaacaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r2.x, r0, c8
bdaaaaaaacaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r2.y, r0, c9
adaaaaaaaaaaahacacaaaakeacaaaaaaanaaaappabaaaaaa mul r0.xyz, r2.xyzz, c13.w
bcaaaaaaaaaaaiacaaaaaakeacaaaaaaaaaaaakeacaaaaaa dp3 r0.w, r0.xyzz, r0.xyzz
akaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r0.w, r0.w
bdaaaaaaaaaaaiadabaaaaoeacaaaaaaahaaaaoeabaaaaaa dp4 o0.w, r1, c7
bdaaaaaaaaaaaeadabaaaaoeacaaaaaaagaaaaoeabaaaaaa dp4 o0.z, r1, c6
bdaaaaaaaaaaacadabaaaaoeacaaaaaaafaaaaoeabaaaaaa dp4 o0.y, r1, c5
bdaaaaaaaaaaabadabaaaaoeacaaaaaaaeaaaaoeabaaaaaa dp4 o0.x, r1, c4
adaaaaaaabaaahaeaaaaaappacaaaaaaaaaaaakeacaaaaaa mul v1.xyz, r0.w, r0.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
adaaaaaaaaaaadacadaaaaoeaaaaaaaaaoaaaaoeabaaaaaa mul r0.xy, a3, c14
abaaaaaaaaaaadaeaaaaaafeacaaaaaaaoaaaaooabaaaaaa add v0.xy, r0.xyyy, c14.zwzw
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64 // 48 used size, 4 vars
Vector 32 [_TopTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
ConstBuffer "UnityPerFrame" 208 // 64 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
BindCB "UnityPerFrame" 3
// 18 instructions, 2 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedjhmdlmaojedkgbealmpkaokmibiieogpabaaaaaapeafaaaaaeaaaaaa
daaaaaaabmacaaaapiaeaaaagiafaaaaebgpgodjoeabaaaaoeabaaaaaaacpopp
iaabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaacaa
abaaabaaaaaaaaaaabaaaeaaabaaacaaaaaaaaaaacaaahaaabaaadaaaaaaaaaa
acaabaaaafaaaeaaaaaaaaaaadaaaaaaaeaaajaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafanaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjaaeaaaaae
abaaadoaacaaoejaabaaoekaabaaookaabaaaaacaaaaahiaacaaoekaafaaaaad
abaaahiaaaaaffiaafaaoekaaeaaaaaeaaaaaliaaeaakekaaaaaaaiaabaakeia
aeaaaaaeaaaaahiaagaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeia
ahaaoekaafaaaaadaaaaahiaaaaaoeiaaiaappkaaiaaaaadaaaaaiiaaaaaoeia
aaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadacaaahoaaaaappiaaaaaoeia
abaaaaacaaaaadiaanaaoekaaeaaaaaeaaaaapiaaaaacejaaaaaeaiaadaaoeka
afaaaaadabaaapiaaaaaffiaakaaoekaaeaaaaaeabaaapiaajaaoekaaaaaaaia
abaaoeiaaeaaaaaeabaaapiaalaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaapia
amaaoekaaaaappiaabaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacaaaaapoaabaaoejappppaaaafdeieefc
neacaaaaeaaaabaalfaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafjaaaaae
egiocaaaadaaaaaaaeaaaaaafpaaaaadhcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacacaaaaaadgaaaaafhcaabaaaaaaaaaaaegbcbaaaaaaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaacaaaaaaahaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaacaaaaaa
ogikcaaaaaaaaaaaacaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
acaaaaaabdaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
adaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapahaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfagphdgjhe
gjgpgoaaedepemepfcaafeeffiedepepfceeaakl"
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
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
    highp vec3 viewDir;
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
#line 337
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
#line 349
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 338
v2f vert( in appdata_t v ) {
    v2f o;
    #line 341
    o.vertex = (glstate_matrix_projection * ((glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, 1.0)) + vec4( v.vertex.x, v.vertex.y, v.vertex.z, 0.0)));
    o.color = v.color;
    o.texcoord = ((v.texcoord.xy * _TopTex_ST.xy) + _TopTex_ST.zw);
    o.viewDir = normalize(ObjSpaceViewDir( vec4( 0.0, 0.0, 0.0, 1.0)));
    #line 345
    return o;
}
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.vertex);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec2(xl_retval.texcoord);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
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
#line 329
struct v2f {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec2 texcoord;
    highp vec3 viewDir;
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
#line 337
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
#line 349
#line 349
lowp vec4 frag( in v2f i ) {
    mediump float xval = xll_saturate_f((0.5 + (0.5 * i.viewDir.x)));
    mediump vec4 xtex = mix( texture( _LeftTex, i.texcoord), texture( _RightTex, i.texcoord), vec4( xval));
    #line 353
    mediump float yval = xll_saturate_f((0.5 + (0.5 * i.viewDir.y)));
    mediump vec4 ytex = mix( texture( _TopTex, i.texcoord), texture( _BotTex, i.texcoord), vec4( yval));
    mediump float zval = xll_saturate_f((0.5 + (0.5 * i.viewDir.z)));
    mediump vec4 ztex = mix( texture( _FrontTex, i.texcoord), texture( _BackTex, i.texcoord), vec4( zval));
    #line 357
    mediump vec4 tex = mix( mix( ytex, ztex, vec4( abs(i.viewDir.z))), xtex, vec4( abs(i.viewDir.x)));
    mediump vec4 prev = ((_Color * i.color) * tex);
    prev.xyz *= prev.w;
    return prev;
}
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.vertex = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xlt_i.texcoord = vec2(xlv_TEXCOORD0);
    xlt_i.viewDir = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 2
//   opengl - ALU: 25 to 25, TEX: 6 to 6
//   d3d9 - ALU: 20 to 20, TEX: 6 to 6
//   d3d11 - ALU: 14 to 14, TEX: 6 to 6, FLOW: 1 to 1
//   d3d11_9x - ALU: 14 to 14, TEX: 6 to 6, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "SOFTPARTICLES_OFF" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_RightTex] 2D
SetTexture 2 [_TopTex] 2D
SetTexture 3 [_BotTex] 2D
SetTexture 4 [_FrontTex] 2D
SetTexture 5 [_BackTex] 2D
"!!ARBfp1.0
# 25 ALU, 6 TEX
PARAM c[2] = { program.local[0],
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[1], 2D;
TEX R3, fragment.texcoord[0], texture[4], 2D;
TEX R2, fragment.texcoord[0], texture[5], 2D;
TEX R5, fragment.texcoord[0], texture[2], 2D;
TEX R4, fragment.texcoord[0], texture[3], 2D;
ADD R4, R4, -R5;
MAD_SAT R6.x, fragment.texcoord[1].y, c[1], c[1];
MAD R4, R6.x, R4, R5;
ADD R2, R2, -R3;
MAD_SAT R5.x, fragment.texcoord[1].z, c[1], c[1];
MAD R2, R5.x, R2, R3;
ADD R0, R0, -R1;
ABS R3.x, fragment.texcoord[1].z;
ADD R2, R2, -R4;
MAD R2, R3.x, R2, R4;
MAD_SAT R3.x, fragment.texcoord[1], c[1], c[1];
MAD R0, R3.x, R0, R1;
ADD R1, R0, -R2;
ABS R0.x, fragment.texcoord[1];
MAD R1, R0.x, R1, R2;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, R0;
END
# 25 instructions, 7 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_OFF" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_RightTex] 2D
SetTexture 2 [_TopTex] 2D
SetTexture 3 [_BotTex] 2D
SetTexture 4 [_FrontTex] 2D
SetTexture 5 [_BackTex] 2D
"ps_2_0
; 20 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c1, 0.50000000, 0, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyz
texld r5, t0, s1
texld r4, t0, s0
texld r3, t0, s5
texld r2, t0, s4
texld r1, t0, s2
texld r0, t0, s3
add r6, r0, -r1
mad_sat r0.x, t1.y, c1, c1
mad r1, r0.x, r6, r1
add r3, r3, -r2
mad_sat r0.x, t1.z, c1, c1
mad r0, r0.x, r3, r2
add_pp r2, r0, -r1
abs r0.x, t1.z
mad_pp r1, r0.x, r2, r1
add r2, r5, -r4
mad_sat r0.x, t1, c1, c1
mad r0, r0.x, r2, r4
add_pp r2, r0, -r1
abs r0.x, t1
mad_pp r1, r0.x, r2, r1
mul_pp r0, v0, c0
mul_pp r1, r0, r1
mov_pp r0.w, r1
mul_pp r0.xyz, r1, r1.w
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_OFF" }
ConstBuffer "$Globals" 64 // 32 used size, 4 vars
Vector 16 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 2
SetTexture 1 [_RightTex] 2D 3
SetTexture 2 [_TopTex] 2D 0
SetTexture 3 [_BotTex] 2D 1
SetTexture 4 [_FrontTex] 2D 4
SetTexture 5 [_BackTex] 2D 5
// 22 instructions, 4 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 6 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedpdkopdpjlhafljblhbehajkfoffclffaabaaaaaammaeaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
gphdgjhegjgpgoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcniadaaaaeaaaaaaapgaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaad
aagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaafaaaaaaaagabaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadccaaaaphcaabaaaacaaaaaa
egbcbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaajpcaabaaaaaaaaaaakgakbaaa
acaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaaj
pcaabaaaabaaaaaafgafbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
aaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaakgbkbaiaibaaaaaaadaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaa
acaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
agbabaiaibaaaaaaadaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
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
SetTexture 1 [_RightTex] 2D
SetTexture 2 [_TopTex] 2D
SetTexture 3 [_BotTex] 2D
SetTexture 4 [_FrontTex] 2D
SetTexture 5 [_BackTex] 2D
"agal_ps
c1 0.5 0.0 0.0 0.0
[bc]
ciaaaaaaafaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r5, v0, s1 <2d wrap linear point>
ciaaaaaaaeaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r4, v0, s0 <2d wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaafaaaaaaafaababb tex r3, v0, s5 <2d wrap linear point>
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaaeaaaaaaafaababb tex r2, v0, s4 <2d wrap linear point>
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaacaaaaaaafaababb tex r1, v0, s2 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaadaaaaaaafaababb tex r0, v0, s3 <2d wrap linear point>
acaaaaaaagaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa sub r6, r0, r1
adaaaaaaaaaaabacabaaaaffaeaaaaaaabaaaaoeabaaaaaa mul r0.x, v1.y, c1
abaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaaoeabaaaaaa add r0.x, r0.x, c1
bgaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r0.x, r0.x
adaaaaaaagaaapacaaaaaaaaacaaaaaaagaaaaoeacaaaaaa mul r6, r0.x, r6
abaaaaaaabaaapacagaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r6, r1
acaaaaaaadaaapacadaaaaoeacaaaaaaacaaaaoeacaaaaaa sub r3, r3, r2
adaaaaaaaaaaabacabaaaakkaeaaaaaaabaaaaoeabaaaaaa mul r0.x, v1.z, c1
abaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaaoeabaaaaaa add r0.x, r0.x, c1
bgaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r0.x, r0.x
adaaaaaaaaaaapacaaaaaaaaacaaaaaaadaaaaoeacaaaaaa mul r0, r0.x, r3
abaaaaaaaaaaapacaaaaaaoeacaaaaaaacaaaaoeacaaaaaa add r0, r0, r2
acaaaaaaacaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa sub r2, r0, r1
beaaaaaaaaaaabacabaaaakkaeaaaaaaaaaaaaaaaaaaaaaa abs r0.x, v1.z
adaaaaaaadaaapacaaaaaaaaacaaaaaaacaaaaoeacaaaaaa mul r3, r0.x, r2
abaaaaaaabaaapacadaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r3, r1
acaaaaaaacaaapacafaaaaoeacaaaaaaaeaaaaoeacaaaaaa sub r2, r5, r4
adaaaaaaaaaaabacabaaaaoeaeaaaaaaabaaaaoeabaaaaaa mul r0.x, v1, c1
abaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaaoeabaaaaaa add r0.x, r0.x, c1
bgaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r0.x, r0.x
adaaaaaaaaaaapacaaaaaaaaacaaaaaaacaaaaoeacaaaaaa mul r0, r0.x, r2
abaaaaaaaaaaapacaaaaaaoeacaaaaaaaeaaaaoeacaaaaaa add r0, r0, r4
acaaaaaaacaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa sub r2, r0, r1
beaaaaaaaaaaabacabaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa abs r0.x, v1
adaaaaaaacaaapacaaaaaaaaacaaaaaaacaaaaoeacaaaaaa mul r2, r0.x, r2
abaaaaaaabaaapacacaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r2, r1
adaaaaaaaaaaapacahaaaaoeaeaaaaaaaaaaaaoeabaaaaaa mul r0, v7, c0
adaaaaaaabaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r1, r0, r1
aaaaaaaaaaaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.w
adaaaaaaaaaaahacabaaaakeacaaaaaaabaaaappacaaaaaa mul r0.xyz, r1.xyzz, r1.w
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_OFF" }
ConstBuffer "$Globals" 64 // 32 used size, 4 vars
Vector 16 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 2
SetTexture 1 [_RightTex] 2D 3
SetTexture 2 [_TopTex] 2D 0
SetTexture 3 [_BotTex] 2D 1
SetTexture 4 [_FrontTex] 2D 4
SetTexture 5 [_BackTex] 2D 5
// 22 instructions, 4 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 6 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefieceddjciaipndmjekhjnbebdfellponmaakbabaaaaaaaaahaaaaaeaaaaaa
daaaaaaagaacaaaaeaagaaaammagaaaaebgpgodjciacaaaaciacaaaaaaacpppp
oaabaaaaeiaaaaaaabaadmaaaaaaeiaaaaaaeiaaagaaceaaaaaaeiaaacaaaaaa
adababaaaaacacaaabadadaaaeaeaeaaafafafaaaaaaabaaabaaaaaaaaaaaaaa
aaacppppfbaaaaafabaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaaahla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkabpaaaaac
aaaaaajaafaiapkaaeaaaaaeaaaadiiaacaafflaabaaaakaabaaaakaecaaaaad
abaaapiaabaaoelaaaaioekaecaaaaadacaaapiaabaaoelaabaioekaecaaaaad
adaaapiaabaaoelaaeaioekaecaaaaadaeaaapiaabaaoelaafaioekaecaaaaad
afaaapiaabaaoelaacaioekaecaaaaadagaaapiaabaaoelaadaioekabcaaaaae
ahaacpiaaaaappiaacaaoeiaabaaoeiaaeaaaaaeaaaadbiaacaakklaabaaaaka
abaaaakabcaaaaaeabaacpiaaaaaaaiaaeaaoeiaadaaoeiacdaaaaacaaaaabia
acaakklabcaaaaaeacaaapiaaaaaaaiaabaaoeiaahaaoeiaaeaaaaaeaaaadbia
acaaaalaabaaaakaabaaaakabcaaaaaeabaacpiaaaaaaaiaagaaoeiaafaaoeia
cdaaaaacaaaaabiaacaaaalabcaaaaaeadaacpiaaaaaaaiaabaaoeiaacaaoeia
afaaaaadaaaacpiaaaaaoelaaaaaoekaafaaaaadaaaacpiaadaaoeiaaaaaoeia
afaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcniadaaaaeaaaaaaapgaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
afaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaia
ebaaaaaaabaaaaaadccaaaaphcaabaaaacaaaaaaegbcbaaaadaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaadcaaaaajpcaabaaaaaaaaaaakgakbaaaacaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
adaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaajpcaabaaaabaaaaaafgafbaaa
acaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
kgbkbaiaibaaaaaaadaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaagbabaiaibaaaaaaadaaaaaa
egaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegbobaaa
abaaaaaaegiocaaaaaaaaaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
ejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfagphdgjhegjgpgoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}

SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "SOFTPARTICLES_ON" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_RightTex] 2D
SetTexture 2 [_TopTex] 2D
SetTexture 3 [_BotTex] 2D
SetTexture 4 [_FrontTex] 2D
SetTexture 5 [_BackTex] 2D
"!!ARBfp1.0
# 25 ALU, 6 TEX
PARAM c[2] = { program.local[0],
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[1], 2D;
TEX R3, fragment.texcoord[0], texture[4], 2D;
TEX R2, fragment.texcoord[0], texture[5], 2D;
TEX R5, fragment.texcoord[0], texture[2], 2D;
TEX R4, fragment.texcoord[0], texture[3], 2D;
ADD R4, R4, -R5;
MAD_SAT R6.x, fragment.texcoord[1].y, c[1], c[1];
MAD R4, R6.x, R4, R5;
ADD R2, R2, -R3;
MAD_SAT R5.x, fragment.texcoord[1].z, c[1], c[1];
MAD R2, R5.x, R2, R3;
ADD R0, R0, -R1;
ABS R3.x, fragment.texcoord[1].z;
ADD R2, R2, -R4;
MAD R2, R3.x, R2, R4;
MAD_SAT R3.x, fragment.texcoord[1], c[1], c[1];
MAD R0, R3.x, R0, R1;
ADD R1, R0, -R2;
ABS R0.x, fragment.texcoord[1];
MAD R1, R0.x, R1, R2;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, R0;
END
# 25 instructions, 7 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_ON" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_RightTex] 2D
SetTexture 2 [_TopTex] 2D
SetTexture 3 [_BotTex] 2D
SetTexture 4 [_FrontTex] 2D
SetTexture 5 [_BackTex] 2D
"ps_2_0
; 20 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c1, 0.50000000, 0, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyz
texld r5, t0, s1
texld r4, t0, s0
texld r3, t0, s5
texld r2, t0, s4
texld r1, t0, s2
texld r0, t0, s3
add r6, r0, -r1
mad_sat r0.x, t1.y, c1, c1
mad r1, r0.x, r6, r1
add r3, r3, -r2
mad_sat r0.x, t1.z, c1, c1
mad r0, r0.x, r3, r2
add_pp r2, r0, -r1
abs r0.x, t1.z
mad_pp r1, r0.x, r2, r1
add r2, r5, -r4
mad_sat r0.x, t1, c1, c1
mad r0, r0.x, r2, r4
add_pp r2, r0, -r1
abs r0.x, t1
mad_pp r1, r0.x, r2, r1
mul_pp r0, v0, c0
mul_pp r1, r0, r1
mov_pp r0.w, r1
mul_pp r0.xyz, r1, r1.w
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_ON" }
ConstBuffer "$Globals" 64 // 32 used size, 4 vars
Vector 16 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 2
SetTexture 1 [_RightTex] 2D 3
SetTexture 2 [_TopTex] 2D 0
SetTexture 3 [_BotTex] 2D 1
SetTexture 4 [_FrontTex] 2D 4
SetTexture 5 [_BackTex] 2D 5
// 22 instructions, 4 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 6 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedpdkopdpjlhafljblhbehajkfoffclffaabaaaaaammaeaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
gphdgjhegjgpgoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcniadaaaaeaaaaaaapgaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaad
aagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaafaaaaaaaagabaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadccaaaaphcaabaaaacaaaaaa
egbcbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaajpcaabaaaaaaaaaaakgakbaaa
acaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaaj
pcaabaaaabaaaaaafgafbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
aaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaakgbkbaiaibaaaaaaadaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaa
acaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaa
egaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
agbabaiaibaaaaaaadaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
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
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_RightTex] 2D
SetTexture 2 [_TopTex] 2D
SetTexture 3 [_BotTex] 2D
SetTexture 4 [_FrontTex] 2D
SetTexture 5 [_BackTex] 2D
"agal_ps
c1 0.5 0.0 0.0 0.0
[bc]
ciaaaaaaafaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r5, v0, s1 <2d wrap linear point>
ciaaaaaaaeaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r4, v0, s0 <2d wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaafaaaaaaafaababb tex r3, v0, s5 <2d wrap linear point>
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaaeaaaaaaafaababb tex r2, v0, s4 <2d wrap linear point>
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaacaaaaaaafaababb tex r1, v0, s2 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaadaaaaaaafaababb tex r0, v0, s3 <2d wrap linear point>
acaaaaaaagaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa sub r6, r0, r1
adaaaaaaaaaaabacabaaaaffaeaaaaaaabaaaaoeabaaaaaa mul r0.x, v1.y, c1
abaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaaoeabaaaaaa add r0.x, r0.x, c1
bgaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r0.x, r0.x
adaaaaaaagaaapacaaaaaaaaacaaaaaaagaaaaoeacaaaaaa mul r6, r0.x, r6
abaaaaaaabaaapacagaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r6, r1
acaaaaaaadaaapacadaaaaoeacaaaaaaacaaaaoeacaaaaaa sub r3, r3, r2
adaaaaaaaaaaabacabaaaakkaeaaaaaaabaaaaoeabaaaaaa mul r0.x, v1.z, c1
abaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaaoeabaaaaaa add r0.x, r0.x, c1
bgaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r0.x, r0.x
adaaaaaaaaaaapacaaaaaaaaacaaaaaaadaaaaoeacaaaaaa mul r0, r0.x, r3
abaaaaaaaaaaapacaaaaaaoeacaaaaaaacaaaaoeacaaaaaa add r0, r0, r2
acaaaaaaacaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa sub r2, r0, r1
beaaaaaaaaaaabacabaaaakkaeaaaaaaaaaaaaaaaaaaaaaa abs r0.x, v1.z
adaaaaaaadaaapacaaaaaaaaacaaaaaaacaaaaoeacaaaaaa mul r3, r0.x, r2
abaaaaaaabaaapacadaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r3, r1
acaaaaaaacaaapacafaaaaoeacaaaaaaaeaaaaoeacaaaaaa sub r2, r5, r4
adaaaaaaaaaaabacabaaaaoeaeaaaaaaabaaaaoeabaaaaaa mul r0.x, v1, c1
abaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaaoeabaaaaaa add r0.x, r0.x, c1
bgaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r0.x, r0.x
adaaaaaaaaaaapacaaaaaaaaacaaaaaaacaaaaoeacaaaaaa mul r0, r0.x, r2
abaaaaaaaaaaapacaaaaaaoeacaaaaaaaeaaaaoeacaaaaaa add r0, r0, r4
acaaaaaaacaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa sub r2, r0, r1
beaaaaaaaaaaabacabaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa abs r0.x, v1
adaaaaaaacaaapacaaaaaaaaacaaaaaaacaaaaoeacaaaaaa mul r2, r0.x, r2
abaaaaaaabaaapacacaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r2, r1
adaaaaaaaaaaapacahaaaaoeaeaaaaaaaaaaaaoeabaaaaaa mul r0, v7, c0
adaaaaaaabaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r1, r0, r1
aaaaaaaaaaaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.w
adaaaaaaaaaaahacabaaaakeacaaaaaaabaaaappacaaaaaa mul r0.xyz, r1.xyzz, r1.w
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_ON" }
ConstBuffer "$Globals" 64 // 32 used size, 4 vars
Vector 16 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 2
SetTexture 1 [_RightTex] 2D 3
SetTexture 2 [_TopTex] 2D 0
SetTexture 3 [_BotTex] 2D 1
SetTexture 4 [_FrontTex] 2D 4
SetTexture 5 [_BackTex] 2D 5
// 22 instructions, 4 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 6 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefieceddjciaipndmjekhjnbebdfellponmaakbabaaaaaaaaahaaaaaeaaaaaa
daaaaaaagaacaaaaeaagaaaammagaaaaebgpgodjciacaaaaciacaaaaaaacpppp
oaabaaaaeiaaaaaaabaadmaaaaaaeiaaaaaaeiaaagaaceaaaaaaeiaaacaaaaaa
adababaaaaacacaaabadadaaaeaeaeaaafafafaaaaaaabaaabaaaaaaaaaaaaaa
aaacppppfbaaaaafabaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaaahla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkabpaaaaac
aaaaaajaafaiapkaaeaaaaaeaaaadiiaacaafflaabaaaakaabaaaakaecaaaaad
abaaapiaabaaoelaaaaioekaecaaaaadacaaapiaabaaoelaabaioekaecaaaaad
adaaapiaabaaoelaaeaioekaecaaaaadaeaaapiaabaaoelaafaioekaecaaaaad
afaaapiaabaaoelaacaioekaecaaaaadagaaapiaabaaoelaadaioekabcaaaaae
ahaacpiaaaaappiaacaaoeiaabaaoeiaaeaaaaaeaaaadbiaacaakklaabaaaaka
abaaaakabcaaaaaeabaacpiaaaaaaaiaaeaaoeiaadaaoeiacdaaaaacaaaaabia
acaakklabcaaaaaeacaaapiaaaaaaaiaabaaoeiaahaaoeiaaeaaaaaeaaaadbia
acaaaalaabaaaakaabaaaakabcaaaaaeabaacpiaaaaaaaiaagaaoeiaafaaoeia
cdaaaaacaaaaabiaacaaaalabcaaaaaeadaacpiaaaaaaaiaabaaoeiaacaaoeia
afaaaaadaaaacpiaaaaaoelaaaaaoekaafaaaaadaaaacpiaadaaoeiaaaaaoeia
afaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcniadaaaaeaaaaaaapgaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaafaaaaaaaagabaaa
afaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaia
ebaaaaaaabaaaaaadccaaaaphcaabaaaacaaaaaaegbcbaaaadaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaadcaaaaajpcaabaaaaaaaaaaakgakbaaaacaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
adaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaajpcaabaaaabaaaaaafgafbaaa
acaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
kgbkbaiaibaaaaaaadaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaagbabaiaibaaaaaaadaaaaaa
egaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegbobaaa
abaaaaaaegiocaaaaaaaaaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
ejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfagphdgjhegjgpgoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}

SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES3"
}

}

#LINE 83
 
		}
	} 
}
}