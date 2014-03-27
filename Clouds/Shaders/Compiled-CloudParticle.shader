Shader "CloudParticle" {
Properties {
	_TopTex ("Particle Texture", 2D) = "white" {}
	_LeftTex ("Particle Texture", 2D) = "white" {}
	_FrontTex ("Particle Texture", 2D) = "white" {}
	_InvFade ("Soft Particles Factor", Range(0.01,3.0)) = 1.0
	_DistFade ("Distance Fade", Range(0,1)) = 1.0
	_LightScatter ("Light Scatter", Range(0,1)) = 0.55 
	_MinLight ("Minimum Light", Range(0,1)) = .5
	_Color ("Color Tint", Color) = (1,1,1,1)
}

Category {
	
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Mode Global}
	AlphaTest Greater 0
	ColorMask RGB
	Cull Off Lighting On ZWrite Off
	
	SubShader {
		Pass {
			
			Lighting On
			Tags { "LightMode"="ForwardBase"}
			
			Program "vp" {
// Vertex combos: 15
//   opengl - ALU: 118 to 119
//   d3d9 - ALU: 104 to 105
//   d3d11 - ALU: 69 to 69, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 6 [_WorldSpaceCameraPos]
Vector 7 [_WorldSpaceLightPos0]
Matrix 9 [_Object2World]
Vector 8 [_LightColor0]
Float 17 [_DistFade]
Float 18 [_MinLight]
"3.0-!!ARBvp1.0
# 118 ALU
PARAM c[21] = { { 0, 1, 2, 0.60000002 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..12],
		state.matrix.projection,
		program.local[17..18],
		{ 0.5, 0.98000002, 0.010002136 },
		{ 4.0394478, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R2.x, c[4], c[4];
RSQ R2.x, R2.x;
MUL R3.xyz, R2.x, c[4];
MOV R1.xyz, c[0].x;
MOV R1.w, vertex.position;
DP4 R4.x, R1, c[2];
DP4 R4.y, R1, c[3];
DP4 R4.w, R1, c[5];
DP4 R4.z, R1, c[4];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[16];
DP4 result.position.z, R0, c[15];
DP4 result.position.y, R0, c[14];
DP4 result.position.x, R0, c[13];
MUL R0.zw, vertex.texcoord[0].xyxy, c[0].z;
SLT R0.x, c[0], -R3;
SLT R0.y, -R3.x, c[0].x;
ADD R2.x, R0, -R0.y;
ADD R0.xy, R0.zwzw, -c[0].y;
MUL R2.z, R0.x, R2.x;
SLT R2.y, R2.z, c[0].x;
SLT R0.w, R0, c[0].y;
SLT R0.z, c[0].x, R0.y;
ADD R0.z, R0, -R0.w;
SLT R0.w, c[0].x, R2.z;
ADD R0.w, R0, -R2.y;
MUL R2.w, R2.x, R0.z;
MUL R0.w, R0, R2.x;
MUL R2.y, R3, R2.w;
MAD R2.x, R3.z, R0.w, R2.y;
MOV R0.w, vertex.position;
MOV R2.yw, R0;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
SLT R2.w, -R3.y, c[0].x;
SLT R2.z, c[0].x, -R3.y;
ADD R3.w, R2.z, -R2;
MUL R2.zw, R2.xyxy, c[0].w;
MUL R2.x, R0, R3.w;
ADD result.texcoord[1].xy, R2.zwzw, c[19].x;
SLT R2.z, R2.x, c[0].x;
SLT R2.y, c[0].x, R2.x;
ADD R2.y, R2, -R2.z;
MUL R2.z, R0, R3.w;
MUL R2.y, R2, R3.w;
MUL R3.w, R3.z, R2.z;
MOV R2.zw, R0.xyyw;
MAD R2.y, R3.x, R2, R3.w;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
MUL R2.xy, R2, c[0].w;
SLT R2.w, R3.z, c[0].x;
SLT R2.z, c[0].x, R3;
ADD R3.w, R2.z, -R2;
MUL R0.x, R0, R3.w;
SLT R2.w, -R3.z, c[0].x;
SLT R2.z, c[0].x, -R3;
ADD R2.z, R2, -R2.w;
MUL R3.w, R0.z, R2.z;
SLT R2.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R2.w;
MUL R2.w, R3.y, R3;
MUL R0.z, R2, R0;
MAD R0.z, R3.x, R0, R2.w;
DP4 R2.z, R0, c[2];
DP4 R2.w, R0, c[3];
ADD R0.xy, -R4, R2.zwzw;
MUL R4.xy, R0, c[0].w;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
ADD result.texcoord[2].xy, R2, c[19].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
DP3 R0.y, R2, R2;
RSQ R0.y, R0.y;
DP4 R0.x, c[7], c[7];
MUL R2.xyz, R0.y, R2;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, c[7];
MUL R0.xyz, R0, R2;
DP3 R0.w, R0, c[19].y;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MIN R1.x, R0.w, c[0].y;
ADD R0.xyz, -R0, c[6];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL result.texcoord[4].xyz, R0.w, R0;
MAX R1.x, R1, c[0];
ADD R1.x, R1, -c[19].z;
MUL R0.w, R1.x, c[8];
MOV R1.xyz, c[8];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[6];
DP3 R0.x, R0, R0;
MUL R0.w, R0, c[20].x;
MIN R0.y, R0.w, c[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[17];
MIN R0.x, R0, c[0].y;
MAX R0.x, R0, c[0];
MAX R0.y, R0, c[0].x;
ADD R1.xyz, R1, c[18].x;
MAD R1.xyz, R1, R0.y, c[1];
MIN R1.xyz, R1, c[0].y;
ADD result.texcoord[3].xy, R4, c[19].x;
MAX result.texcoord[5].xyz, R1, c[0].x;
MUL result.color.w, vertex.color, R0.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 118 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 15 [_LightColor0]
Float 16 [_DistFade]
Float 17 [_MinLight]
"vs_3_0
; 104 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c18, 0.00000000, 2.00000000, -1.00000000, 0.98000002
def c19, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mad r1.xy, v3, c18.y, c18.z
mov r2.xyz, c18.x
mov r2.w, v0
dp4 r5.x, r2, c0
dp4 r5.y, r2, c1
dp4 r5.w, r2, c3
dp4 r5.z, r2, c2
add r0, r5, v0
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r1.y, -r1.y
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r1, r1
sub r1.z, r0.y, r0
mul r0.z, r1.x, r0.x
mul r1.w, r0.x, r1.z
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r1.w, v0
mov r0.yw, r1
dp4 r4.y, r0, c1
slt r4.x, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.x
dp4 r4.x, r0, c0
mul r0.x, r1, r3.w
add r4.xy, -r5, r4
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r5, r4.zwzw
mad o4.xy, r0, c19.x, c19.y
slt r0.y, -r3.z, r3.z
slt r0.x, r3.z, -r3.z
sub r0.z, r0.y, r0.x
mul r1.x, r1, r0.z
sub r0.x, r0, r0.y
mul r0.w, r1.z, r0.x
slt r0.z, r1.x, -r1.x
slt r0.y, -r1.x, r1.x
sub r0.y, r0, r0.z
mul r0.z, r3.y, r0.w
mul r0.x, r0, r0.y
mad r1.z, r3.x, r0.x, r0
mov r0.xyz, v2
mov r0.w, c18.x
mad o3.xy, r4, c19.x, c19.y
dp4 r4.z, r0, c10
dp4 r4.x, r0, c8
dp4 r4.y, r0, c9
dp3 r0.z, r4, r4
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r5, r0
dp4 r1.w, c14, c14
dp4 r1.z, r2, c10
dp4 r1.x, r2, c8
dp4 r1.y, r2, c9
add r1.xyz, -r1, c13
dp3 r0.w, r1, r1
rsq r0.w, r0.w
rsq r1.w, r1.w
mul o6.xyz, r0.w, r1
rsq r0.z, r0.z
mad o5.xy, r0, c19.x, c19.y
mul r0.xyz, r0.z, r4
mul r2.xyz, r1.w, c14
mul r0.xyz, r2, r0
dp3_sat r0.w, r0, c18.w
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.w, r0, c19.z
mul r0.y, r0.w, c15.w
mul_sat r0.z, r0.y, c19.w
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r0.y, c17.x
mul_sat r0.x, r0, c16
add r1.xyz, c15, r0.y
mad_sat o7.xyz, r1, r0.z, c12
mul o1.w, v1, r0.x
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Vector 80 [_LightColor0] 4
Float 132 [_DistFade]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 80 instructions, 5 temp regs, 0 temp arrays:
// ALU 61 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedlciegmadoaeidnhhnnnigknampjkojhoabaaaaaapiamaaaaadaaaaaa
cmaaaaaanmaaaaaaoaabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
pmaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaapcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaapcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaapcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaapcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaapcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaapcaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaapcaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcbaalaaaaeaaaabaameacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacafaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
apaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaahiccabaaaabaaaaaa
akaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaa
abaaaaaadgaaaaagbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaag
ccaabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaacaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaa
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
adaaaaaadiaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaa
aaaaaaaafganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaa
fganbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaa
acaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaa
adaaaaaaaeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaa
aaaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaa
dcaaaaapdccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaah
ccaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
acaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaa
dbaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaa
abaaaaaaboaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
aaaaaaaacgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
acaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaaeiobhkdpeiobhkdpeiobhkdpaaaaaaaabacaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaa
pgipcaaaaaaaaaaaaiaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11 = (glstate_matrix_modelview0 * tmpvar_10);
  vec4 v_12;
  v_12.x = glstate_matrix_modelview0[0].z;
  v_12.y = glstate_matrix_modelview0[1].z;
  v_12.z = glstate_matrix_modelview0[2].z;
  v_12.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(v_12.xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = _glesVertex.w;
  highp vec2 tmpvar_15;
  tmpvar_15 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_16;
  tmpvar_16.z = 0.0;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_15.y;
  tmpvar_16.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_16.zyw;
  XZv_5.yzw = tmpvar_16.zyw;
  XYv_4.yzw = tmpvar_16.yzw;
  ZYv_6.z = (tmpvar_15.x * sign(-(tmpvar_13.x)));
  XZv_5.x = (tmpvar_15.x * sign(-(tmpvar_13.y)));
  XYv_4.x = (tmpvar_15.x * sign(tmpvar_13.z));
  ZYv_6.x = ((sign(-(tmpvar_13.x)) * sign(ZYv_6.z)) * tmpvar_13.z);
  XZv_5.y = ((sign(-(tmpvar_13.y)) * sign(XZv_5.x)) * tmpvar_13.x);
  XYv_4.z = ((sign(-(tmpvar_13.z)) * sign(XYv_4.x)) * tmpvar_13.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_13.x)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_13.y)) * sign(tmpvar_15.y)) * tmpvar_13.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_13.z)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (dot (normalize((_Object2World * tmpvar_17).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_22;
  tmpvar_22 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_21)), 0.0, 1.0);
  tmpvar_8 = tmpvar_22;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_23;
  p_23 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_24;
  tmpvar_24 = clamp ((_DistFade * sqrt(dot (p_23, p_23))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_24);
  gl_Position = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_13);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_14).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11 = (glstate_matrix_modelview0 * tmpvar_10);
  vec4 v_12;
  v_12.x = glstate_matrix_modelview0[0].z;
  v_12.y = glstate_matrix_modelview0[1].z;
  v_12.z = glstate_matrix_modelview0[2].z;
  v_12.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(v_12.xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = _glesVertex.w;
  highp vec2 tmpvar_15;
  tmpvar_15 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_16;
  tmpvar_16.z = 0.0;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_15.y;
  tmpvar_16.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_16.zyw;
  XZv_5.yzw = tmpvar_16.zyw;
  XYv_4.yzw = tmpvar_16.yzw;
  ZYv_6.z = (tmpvar_15.x * sign(-(tmpvar_13.x)));
  XZv_5.x = (tmpvar_15.x * sign(-(tmpvar_13.y)));
  XYv_4.x = (tmpvar_15.x * sign(tmpvar_13.z));
  ZYv_6.x = ((sign(-(tmpvar_13.x)) * sign(ZYv_6.z)) * tmpvar_13.z);
  XZv_5.y = ((sign(-(tmpvar_13.y)) * sign(XZv_5.x)) * tmpvar_13.x);
  XYv_4.z = ((sign(-(tmpvar_13.z)) * sign(XYv_4.x)) * tmpvar_13.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_13.x)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_13.y)) * sign(tmpvar_15.y)) * tmpvar_13.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_13.z)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (dot (normalize((_Object2World * tmpvar_17).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_22;
  tmpvar_22 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_21)), 0.0, 1.0);
  tmpvar_8 = tmpvar_22;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_23;
  p_23 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_24;
  tmpvar_24 = clamp ((_DistFade * sqrt(dot (p_23, p_23))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_24);
  gl_Position = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_13);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_14).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
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
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 413
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec3 _LightCoord;
};
#line 404
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 403
uniform highp float _MinLight;
#line 426
uniform highp vec4 _TopTex_ST;
#line 467
uniform sampler2D _CameraDepthTexture;
#line 427
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 430
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 434
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 438
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 442
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 446
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 450
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 454
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 458
    mediump vec3 lightDirection = vec3( (0.98 * normalize(_WorldSpaceLightPos0)));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 462
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out mediump vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval.baseLight);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
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
#line 317
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
    mediump vec3 baseLight;
    highp vec3 _LightCoord;
};
#line 404
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 403
uniform highp float _MinLight;
#line 426
uniform highp vec4 _TopTex_ST;
#line 467
uniform sampler2D _CameraDepthTexture;
#line 468
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    #line 471
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    #line 475
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    #line 479
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in mediump vec3 xlv_TEXCOORD5;
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
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec3(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 6 [_WorldSpaceCameraPos]
Vector 7 [_WorldSpaceLightPos0]
Matrix 9 [_Object2World]
Vector 8 [_LightColor0]
Float 17 [_DistFade]
Float 18 [_MinLight]
"3.0-!!ARBvp1.0
# 119 ALU
PARAM c[21] = { { 0, 1, 2, 0.60000002 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..12],
		state.matrix.projection,
		program.local[17..18],
		{ 0.5, 0.97998047, 0.010002136 },
		{ 4.0394478, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[4], c[4];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[4];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
MOV R1.w, vertex.position;
DP4 R4.x, R2, c[2];
DP4 R4.y, R2, c[3];
DP4 R4.w, R2, c[5];
DP4 R4.z, R2, c[4];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[16];
DP4 result.position.z, R0, c[15];
DP4 result.position.y, R0, c[14];
DP4 result.position.x, R0, c[13];
MUL R0.xy, vertex.texcoord[0], c[0].z;
ADD R4.zw, R0.xyxy, -c[0].y;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0];
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
DP4 R1.x, R0, c[2];
DP4 R1.z, R0, c[3];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[0].w;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[19].x;
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
DP4 R4.z, R0, c[2];
DP4 R4.w, R0, c[3];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[0].w;
DP4 R0.z, R1, c[2];
DP4 R0.w, R1, c[3];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[0].w;
ADD result.texcoord[3].xy, R0.zwzw, c[19].x;
ADD result.texcoord[2].xy, R0, c[19].x;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
DP4 R1.z, R0, c[11];
DP4 R1.y, R0, c[10];
DP4 R1.x, R0, c[9];
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
DP4 R1.w, c[7], c[7];
RSQ R0.x, R1.w;
MUL R0.xyz, R0.x, c[7];
MUL R0.xyz, R0, c[19].y;
MUL R1.xyz, R0.w, R1;
DP3 R0.w, R1, R0;
MIN R1.x, R0.w, c[0].y;
MAX R1.x, R1, c[0];
ADD R1.x, R1, -c[19].z;
DP4 R0.z, R2, c[11];
DP4 R0.x, R2, c[9];
DP4 R0.y, R2, c[10];
ADD R0.xyz, -R0, c[6];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL result.texcoord[4].xyz, R0.w, R0;
MUL R0.w, R1.x, c[8];
MOV R1.xyz, c[8];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[6];
DP3 R0.x, R0, R0;
MUL R0.w, R0, c[20].x;
MIN R0.y, R0.w, c[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[17];
MIN R0.x, R0, c[0].y;
MAX R0.x, R0, c[0];
MAX R0.y, R0, c[0].x;
ADD R1.xyz, R1, c[18].x;
MAD R1.xyz, R1, R0.y, c[1];
MIN R1.xyz, R1, c[0].y;
MAX result.texcoord[5].xyz, R1, c[0].x;
MUL result.color.w, vertex.color, R0.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 119 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 15 [_LightColor0]
Float 16 [_DistFade]
Float 17 [_MinLight]
"vs_3_0
; 105 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c18, 0.00000000, 2.00000000, -1.00000000, 0.97998047
def c19, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c18.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c18.y, c18.z
mov r4.y, r2.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
mov r4.w, v0
slt r0.z, r2.w, -r2.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r2.w, r2.w
sub r3.w, r0.y, r0.z
mul r0.z, r2, r0.x
mul r4.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r4.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
slt r4.x, -r3.y, r3.y
slt r2.w, r3.y, -r3.y
sub r2.w, r2, r4.x
mul r0.x, r2.z, r2.w
add r4.xz, -r2.xyyw, r5.xyyw
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r3.w, r2.w
mul r0.y, r0, r2.w
mul r2.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r2.w
dp4 r5.x, r0, c0
dp4 r5.y, r0, c1
add r0.xy, -r2, r5
mad o4.xy, r0, c19.x, c19.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c19.x, c19.y
mul r4.x, r2.z, r1.y
mul r1.z, r3.w, r0.w
slt r1.y, r4.x, -r4.x
slt r1.x, -r4, r4
sub r1.x, r1, r1.y
mul r0.w, r0, r1.x
mul r1.y, r3, r1.z
mad r4.z, r3.x, r0.w, r1.y
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o6.xyz, r0.w, r0
mov r0.xyz, v2
mov r0.w, c18.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c19.x, c19.y
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
dp3 r0.w, r1, r1
rsq r0.w, r0.w
dp4 r1.w, c14, c14
rsq r0.x, r1.w
mul r0.xyz, r0.x, c14
mul r0.xyz, r0, c18.w
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.w, r0, c19.z
mul r0.y, r0.w, c15.w
mul_sat r0.z, r0.y, c19.w
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r0.y, c17.x
mul_sat r0.x, r0, c16
add r1.xyz, c15, r0.y
mad_sat o7.xyz, r1, r0.z, c12
mul o1.w, v1, r0.x
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 96 // 80 used size, 9 vars
Vector 16 [_LightColor0] 4
Float 68 [_DistFade]
Float 76 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 80 instructions, 5 temp regs, 0 temp arrays:
// ALU 61 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedlenkcfgjbgedfanjfldojnejfdjgnkbgabaaaaaaoaamaaaaadaaaaaa
cmaaaaaanmaaaaaamiabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
oeaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaankaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaankaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaankaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaankaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaankaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaankaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefcbaalaaaaeaaaabaameacaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafjaaaaaeegiocaaa
aeaaaaaaafaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
afaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaa
aaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaeaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaa
abaaaaaaaaaaaaakhcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaaapaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadicaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaadiaaaaah
iccabaaaabaaaaaaakaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaa
abaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaadgaaaaagccaabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaag
ecaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaadbaaaaalhcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaa
aeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
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
agiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaa
aeaaaaaapgapbaaaaaaaaaaafganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaa
agiecaaaadaaaaaaagaaaaaafgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaap
mccabaaaadaaaaaafganbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdp
jkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaa
abaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaa
acaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaa
dcaaaaakkcaabaaaaaaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaaaaaaaaa
fgajbaaaacaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaa
jkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaai
ccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaacaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaa
bkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaaeaaaaaafgafbaaa
aaaaaaaangafbaaaabaaaaaaboaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaadkaabaaaaaaaaaaacgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaabaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
adaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaadaaaaaaagaaaaaaagaabaaa
aaaaaaaaegaabaaaabaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaa
aceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
acaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
bbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaaaceaaaaaeiobhkdpeiobhkdpeiobhkdpaaaaaaaa
bacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaadicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajocaabaaaaaaaaaaaagijcaaa
aaaaaaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaadccaaaakhccabaaaagaaaaaa
jgahbaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_9.w = _glesVertex.w;
  highp vec4 tmpvar_10;
  tmpvar_10 = (glstate_matrix_modelview0 * tmpvar_9);
  vec4 v_11;
  v_11.x = glstate_matrix_modelview0[0].z;
  v_11.y = glstate_matrix_modelview0[1].z;
  v_11.z = glstate_matrix_modelview0[2].z;
  v_11.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_12;
  tmpvar_12 = normalize(v_11.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = _glesVertex.w;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_15;
  tmpvar_15.z = 0.0;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = tmpvar_14.y;
  tmpvar_15.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_15.zyw;
  XZv_5.yzw = tmpvar_15.zyw;
  XYv_4.yzw = tmpvar_15.yzw;
  ZYv_6.z = (tmpvar_14.x * sign(-(tmpvar_12.x)));
  XZv_5.x = (tmpvar_14.x * sign(-(tmpvar_12.y)));
  XYv_4.x = (tmpvar_14.x * sign(tmpvar_12.z));
  ZYv_6.x = ((sign(-(tmpvar_12.x)) * sign(ZYv_6.z)) * tmpvar_12.z);
  XZv_5.y = ((sign(-(tmpvar_12.y)) * sign(XZv_5.x)) * tmpvar_12.x);
  XYv_4.z = ((sign(-(tmpvar_12.z)) * sign(XYv_4.x)) * tmpvar_12.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_12.x)) * sign(tmpvar_14.y)) * tmpvar_12.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_12.y)) * sign(tmpvar_14.y)) * tmpvar_12.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_12.z)) * sign(tmpvar_14.y)) * tmpvar_12.y));
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_17;
  tmpvar_17 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = clamp (dot (normalize((_Object2World * tmpvar_16).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_21;
  tmpvar_21 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_20)), 0.0, 1.0);
  tmpvar_8 = tmpvar_21;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_22;
  p_22 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_23;
  tmpvar_23 = clamp ((_DistFade * sqrt(dot (p_22, p_22))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_23);
  gl_Position = (glstate_matrix_projection * (tmpvar_10 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_12);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_10.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_10.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_10.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_13).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_9.w = _glesVertex.w;
  highp vec4 tmpvar_10;
  tmpvar_10 = (glstate_matrix_modelview0 * tmpvar_9);
  vec4 v_11;
  v_11.x = glstate_matrix_modelview0[0].z;
  v_11.y = glstate_matrix_modelview0[1].z;
  v_11.z = glstate_matrix_modelview0[2].z;
  v_11.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_12;
  tmpvar_12 = normalize(v_11.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_13.w = _glesVertex.w;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_15;
  tmpvar_15.z = 0.0;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = tmpvar_14.y;
  tmpvar_15.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_15.zyw;
  XZv_5.yzw = tmpvar_15.zyw;
  XYv_4.yzw = tmpvar_15.yzw;
  ZYv_6.z = (tmpvar_14.x * sign(-(tmpvar_12.x)));
  XZv_5.x = (tmpvar_14.x * sign(-(tmpvar_12.y)));
  XYv_4.x = (tmpvar_14.x * sign(tmpvar_12.z));
  ZYv_6.x = ((sign(-(tmpvar_12.x)) * sign(ZYv_6.z)) * tmpvar_12.z);
  XZv_5.y = ((sign(-(tmpvar_12.y)) * sign(XZv_5.x)) * tmpvar_12.x);
  XYv_4.z = ((sign(-(tmpvar_12.z)) * sign(XYv_4.x)) * tmpvar_12.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_12.x)) * sign(tmpvar_14.y)) * tmpvar_12.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_12.y)) * sign(tmpvar_14.y)) * tmpvar_12.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_12.z)) * sign(tmpvar_14.y)) * tmpvar_12.y));
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_17;
  tmpvar_17 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = clamp (dot (normalize((_Object2World * tmpvar_16).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_21;
  tmpvar_21 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_20)), 0.0, 1.0);
  tmpvar_8 = tmpvar_21;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_22;
  p_22 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_23;
  tmpvar_23 = clamp ((_DistFade * sqrt(dot (p_22, p_22))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_23);
  gl_Position = (glstate_matrix_projection * (tmpvar_10 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_12);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_10.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_10.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_10.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_13).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
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
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 411
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
};
#line 402
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 401
uniform highp float _MinLight;
#line 423
uniform highp vec4 _TopTex_ST;
#line 464
uniform sampler2D _CameraDepthTexture;
#line 424
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 427
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 431
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 435
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 439
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 443
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 447
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 451
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 455
    mediump vec3 lightDirection = vec3( (0.98 * normalize(_WorldSpaceLightPos0)));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 459
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out mediump vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval.baseLight);
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 411
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
};
#line 402
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 401
uniform highp float _MinLight;
#line 423
uniform highp vec4 _TopTex_ST;
#line 464
uniform sampler2D _CameraDepthTexture;
#line 465
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    #line 468
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    #line 472
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    #line 476
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in mediump vec3 xlv_TEXCOORD5;
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
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 6 [_WorldSpaceCameraPos]
Vector 7 [_WorldSpaceLightPos0]
Matrix 9 [_Object2World]
Vector 8 [_LightColor0]
Float 17 [_DistFade]
Float 18 [_MinLight]
"3.0-!!ARBvp1.0
# 118 ALU
PARAM c[21] = { { 0, 1, 2, 0.60000002 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..12],
		state.matrix.projection,
		program.local[17..18],
		{ 0.5, 0.98000002, 0.010002136 },
		{ 4.0394478, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R2.x, c[4], c[4];
RSQ R2.x, R2.x;
MUL R3.xyz, R2.x, c[4];
MOV R1.xyz, c[0].x;
MOV R1.w, vertex.position;
DP4 R4.x, R1, c[2];
DP4 R4.y, R1, c[3];
DP4 R4.w, R1, c[5];
DP4 R4.z, R1, c[4];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[16];
DP4 result.position.z, R0, c[15];
DP4 result.position.y, R0, c[14];
DP4 result.position.x, R0, c[13];
MUL R0.zw, vertex.texcoord[0].xyxy, c[0].z;
SLT R0.x, c[0], -R3;
SLT R0.y, -R3.x, c[0].x;
ADD R2.x, R0, -R0.y;
ADD R0.xy, R0.zwzw, -c[0].y;
MUL R2.z, R0.x, R2.x;
SLT R2.y, R2.z, c[0].x;
SLT R0.w, R0, c[0].y;
SLT R0.z, c[0].x, R0.y;
ADD R0.z, R0, -R0.w;
SLT R0.w, c[0].x, R2.z;
ADD R0.w, R0, -R2.y;
MUL R2.w, R2.x, R0.z;
MUL R0.w, R0, R2.x;
MUL R2.y, R3, R2.w;
MAD R2.x, R3.z, R0.w, R2.y;
MOV R0.w, vertex.position;
MOV R2.yw, R0;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
SLT R2.w, -R3.y, c[0].x;
SLT R2.z, c[0].x, -R3.y;
ADD R3.w, R2.z, -R2;
MUL R2.zw, R2.xyxy, c[0].w;
MUL R2.x, R0, R3.w;
ADD result.texcoord[1].xy, R2.zwzw, c[19].x;
SLT R2.z, R2.x, c[0].x;
SLT R2.y, c[0].x, R2.x;
ADD R2.y, R2, -R2.z;
MUL R2.z, R0, R3.w;
MUL R2.y, R2, R3.w;
MUL R3.w, R3.z, R2.z;
MOV R2.zw, R0.xyyw;
MAD R2.y, R3.x, R2, R3.w;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
MUL R2.xy, R2, c[0].w;
SLT R2.w, R3.z, c[0].x;
SLT R2.z, c[0].x, R3;
ADD R3.w, R2.z, -R2;
MUL R0.x, R0, R3.w;
SLT R2.w, -R3.z, c[0].x;
SLT R2.z, c[0].x, -R3;
ADD R2.z, R2, -R2.w;
MUL R3.w, R0.z, R2.z;
SLT R2.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R2.w;
MUL R2.w, R3.y, R3;
MUL R0.z, R2, R0;
MAD R0.z, R3.x, R0, R2.w;
DP4 R2.z, R0, c[2];
DP4 R2.w, R0, c[3];
ADD R0.xy, -R4, R2.zwzw;
MUL R4.xy, R0, c[0].w;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
ADD result.texcoord[2].xy, R2, c[19].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
DP3 R0.y, R2, R2;
RSQ R0.y, R0.y;
DP4 R0.x, c[7], c[7];
MUL R2.xyz, R0.y, R2;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, c[7];
MUL R0.xyz, R0, R2;
DP3 R0.w, R0, c[19].y;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MIN R1.x, R0.w, c[0].y;
ADD R0.xyz, -R0, c[6];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL result.texcoord[4].xyz, R0.w, R0;
MAX R1.x, R1, c[0];
ADD R1.x, R1, -c[19].z;
MUL R0.w, R1.x, c[8];
MOV R1.xyz, c[8];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[6];
DP3 R0.x, R0, R0;
MUL R0.w, R0, c[20].x;
MIN R0.y, R0.w, c[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[17];
MIN R0.x, R0, c[0].y;
MAX R0.x, R0, c[0];
MAX R0.y, R0, c[0].x;
ADD R1.xyz, R1, c[18].x;
MAD R1.xyz, R1, R0.y, c[1];
MIN R1.xyz, R1, c[0].y;
ADD result.texcoord[3].xy, R4, c[19].x;
MAX result.texcoord[5].xyz, R1, c[0].x;
MUL result.color.w, vertex.color, R0.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 118 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 15 [_LightColor0]
Float 16 [_DistFade]
Float 17 [_MinLight]
"vs_3_0
; 104 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c18, 0.00000000, 2.00000000, -1.00000000, 0.98000002
def c19, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mad r1.xy, v3, c18.y, c18.z
mov r2.xyz, c18.x
mov r2.w, v0
dp4 r5.x, r2, c0
dp4 r5.y, r2, c1
dp4 r5.w, r2, c3
dp4 r5.z, r2, c2
add r0, r5, v0
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r1.y, -r1.y
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r1, r1
sub r1.z, r0.y, r0
mul r0.z, r1.x, r0.x
mul r1.w, r0.x, r1.z
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r1.w, v0
mov r0.yw, r1
dp4 r4.y, r0, c1
slt r4.x, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.x
dp4 r4.x, r0, c0
mul r0.x, r1, r3.w
add r4.xy, -r5, r4
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r5, r4.zwzw
mad o4.xy, r0, c19.x, c19.y
slt r0.y, -r3.z, r3.z
slt r0.x, r3.z, -r3.z
sub r0.z, r0.y, r0.x
mul r1.x, r1, r0.z
sub r0.x, r0, r0.y
mul r0.w, r1.z, r0.x
slt r0.z, r1.x, -r1.x
slt r0.y, -r1.x, r1.x
sub r0.y, r0, r0.z
mul r0.z, r3.y, r0.w
mul r0.x, r0, r0.y
mad r1.z, r3.x, r0.x, r0
mov r0.xyz, v2
mov r0.w, c18.x
mad o3.xy, r4, c19.x, c19.y
dp4 r4.z, r0, c10
dp4 r4.x, r0, c8
dp4 r4.y, r0, c9
dp3 r0.z, r4, r4
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r5, r0
dp4 r1.w, c14, c14
dp4 r1.z, r2, c10
dp4 r1.x, r2, c8
dp4 r1.y, r2, c9
add r1.xyz, -r1, c13
dp3 r0.w, r1, r1
rsq r0.w, r0.w
rsq r1.w, r1.w
mul o6.xyz, r0.w, r1
rsq r0.z, r0.z
mad o5.xy, r0, c19.x, c19.y
mul r0.xyz, r0.z, r4
mul r2.xyz, r1.w, c14
mul r0.xyz, r2, r0
dp3_sat r0.w, r0, c18.w
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.w, r0, c19.z
mul r0.y, r0.w, c15.w
mul_sat r0.z, r0.y, c19.w
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r0.y, c17.x
mul_sat r0.x, r0, c16
add r1.xyz, c15, r0.y
mad_sat o7.xyz, r1, r0.z, c12
mul o1.w, v1, r0.x
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Vector 80 [_LightColor0] 4
Float 132 [_DistFade]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 80 instructions, 5 temp regs, 0 temp arrays:
// ALU 61 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedaedjbdgpdndpleaeoajhkjjkclpofcpcabaaaaaapiamaaaaadaaaaaa
cmaaaaaanmaaaaaaoaabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
pmaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaapcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaapcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaapcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaapcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaapcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaapcaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaapcaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcbaalaaaaeaaaabaameacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacafaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
apaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaahiccabaaaabaaaaaa
akaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaa
abaaaaaadgaaaaagbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaag
ccaabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaacaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaa
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
adaaaaaadiaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaa
aaaaaaaafganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaa
fganbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaa
acaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaa
adaaaaaaaeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaa
aaaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaa
dcaaaaapdccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaah
ccaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
acaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaa
dbaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaa
abaaaaaaboaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
aaaaaaaacgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
acaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaaeiobhkdpeiobhkdpeiobhkdpaaaaaaaabacaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaa
pgipcaaaaaaaaaaaaiaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11 = (glstate_matrix_modelview0 * tmpvar_10);
  vec4 v_12;
  v_12.x = glstate_matrix_modelview0[0].z;
  v_12.y = glstate_matrix_modelview0[1].z;
  v_12.z = glstate_matrix_modelview0[2].z;
  v_12.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(v_12.xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = _glesVertex.w;
  highp vec2 tmpvar_15;
  tmpvar_15 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_16;
  tmpvar_16.z = 0.0;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_15.y;
  tmpvar_16.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_16.zyw;
  XZv_5.yzw = tmpvar_16.zyw;
  XYv_4.yzw = tmpvar_16.yzw;
  ZYv_6.z = (tmpvar_15.x * sign(-(tmpvar_13.x)));
  XZv_5.x = (tmpvar_15.x * sign(-(tmpvar_13.y)));
  XYv_4.x = (tmpvar_15.x * sign(tmpvar_13.z));
  ZYv_6.x = ((sign(-(tmpvar_13.x)) * sign(ZYv_6.z)) * tmpvar_13.z);
  XZv_5.y = ((sign(-(tmpvar_13.y)) * sign(XZv_5.x)) * tmpvar_13.x);
  XYv_4.z = ((sign(-(tmpvar_13.z)) * sign(XYv_4.x)) * tmpvar_13.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_13.x)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_13.y)) * sign(tmpvar_15.y)) * tmpvar_13.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_13.z)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (dot (normalize((_Object2World * tmpvar_17).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_22;
  tmpvar_22 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_21)), 0.0, 1.0);
  tmpvar_8 = tmpvar_22;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_23;
  p_23 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_24;
  tmpvar_24 = clamp ((_DistFade * sqrt(dot (p_23, p_23))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_24);
  gl_Position = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_13);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_14).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11 = (glstate_matrix_modelview0 * tmpvar_10);
  vec4 v_12;
  v_12.x = glstate_matrix_modelview0[0].z;
  v_12.y = glstate_matrix_modelview0[1].z;
  v_12.z = glstate_matrix_modelview0[2].z;
  v_12.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(v_12.xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = _glesVertex.w;
  highp vec2 tmpvar_15;
  tmpvar_15 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_16;
  tmpvar_16.z = 0.0;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_15.y;
  tmpvar_16.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_16.zyw;
  XZv_5.yzw = tmpvar_16.zyw;
  XYv_4.yzw = tmpvar_16.yzw;
  ZYv_6.z = (tmpvar_15.x * sign(-(tmpvar_13.x)));
  XZv_5.x = (tmpvar_15.x * sign(-(tmpvar_13.y)));
  XYv_4.x = (tmpvar_15.x * sign(tmpvar_13.z));
  ZYv_6.x = ((sign(-(tmpvar_13.x)) * sign(ZYv_6.z)) * tmpvar_13.z);
  XZv_5.y = ((sign(-(tmpvar_13.y)) * sign(XZv_5.x)) * tmpvar_13.x);
  XYv_4.z = ((sign(-(tmpvar_13.z)) * sign(XYv_4.x)) * tmpvar_13.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_13.x)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_13.y)) * sign(tmpvar_15.y)) * tmpvar_13.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_13.z)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (dot (normalize((_Object2World * tmpvar_17).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_22;
  tmpvar_22 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_21)), 0.0, 1.0);
  tmpvar_8 = tmpvar_22;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_23;
  p_23 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_24;
  tmpvar_24 = clamp ((_DistFade * sqrt(dot (p_23, p_23))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_24);
  gl_Position = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_13);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_14).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
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
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 422
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec4 _LightCoord;
};
#line 413
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 412
uniform highp float _MinLight;
#line 435
uniform highp vec4 _TopTex_ST;
#line 476
uniform sampler2D _CameraDepthTexture;
#line 436
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 439
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 443
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 447
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 451
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 455
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 459
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 463
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 467
    mediump vec3 lightDirection = vec3( (0.98 * normalize(_WorldSpaceLightPos0)));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 471
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out mediump vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval.baseLight);
    xlv_TEXCOORD6 = vec4(xl_retval._LightCoord);
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
#line 326
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 422
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec4 _LightCoord;
};
#line 413
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 412
uniform highp float _MinLight;
#line 435
uniform highp vec4 _TopTex_ST;
#line 476
uniform sampler2D _CameraDepthTexture;
#line 477
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    #line 480
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    #line 484
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    #line 488
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in mediump vec3 xlv_TEXCOORD5;
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
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 6 [_WorldSpaceCameraPos]
Vector 7 [_WorldSpaceLightPos0]
Matrix 9 [_Object2World]
Vector 8 [_LightColor0]
Float 17 [_DistFade]
Float 18 [_MinLight]
"3.0-!!ARBvp1.0
# 118 ALU
PARAM c[21] = { { 0, 1, 2, 0.60000002 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..12],
		state.matrix.projection,
		program.local[17..18],
		{ 0.5, 0.98000002, 0.010002136 },
		{ 4.0394478, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R2.x, c[4], c[4];
RSQ R2.x, R2.x;
MUL R3.xyz, R2.x, c[4];
MOV R1.xyz, c[0].x;
MOV R1.w, vertex.position;
DP4 R4.x, R1, c[2];
DP4 R4.y, R1, c[3];
DP4 R4.w, R1, c[5];
DP4 R4.z, R1, c[4];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[16];
DP4 result.position.z, R0, c[15];
DP4 result.position.y, R0, c[14];
DP4 result.position.x, R0, c[13];
MUL R0.zw, vertex.texcoord[0].xyxy, c[0].z;
SLT R0.x, c[0], -R3;
SLT R0.y, -R3.x, c[0].x;
ADD R2.x, R0, -R0.y;
ADD R0.xy, R0.zwzw, -c[0].y;
MUL R2.z, R0.x, R2.x;
SLT R2.y, R2.z, c[0].x;
SLT R0.w, R0, c[0].y;
SLT R0.z, c[0].x, R0.y;
ADD R0.z, R0, -R0.w;
SLT R0.w, c[0].x, R2.z;
ADD R0.w, R0, -R2.y;
MUL R2.w, R2.x, R0.z;
MUL R0.w, R0, R2.x;
MUL R2.y, R3, R2.w;
MAD R2.x, R3.z, R0.w, R2.y;
MOV R0.w, vertex.position;
MOV R2.yw, R0;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
SLT R2.w, -R3.y, c[0].x;
SLT R2.z, c[0].x, -R3.y;
ADD R3.w, R2.z, -R2;
MUL R2.zw, R2.xyxy, c[0].w;
MUL R2.x, R0, R3.w;
ADD result.texcoord[1].xy, R2.zwzw, c[19].x;
SLT R2.z, R2.x, c[0].x;
SLT R2.y, c[0].x, R2.x;
ADD R2.y, R2, -R2.z;
MUL R2.z, R0, R3.w;
MUL R2.y, R2, R3.w;
MUL R3.w, R3.z, R2.z;
MOV R2.zw, R0.xyyw;
MAD R2.y, R3.x, R2, R3.w;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
MUL R2.xy, R2, c[0].w;
SLT R2.w, R3.z, c[0].x;
SLT R2.z, c[0].x, R3;
ADD R3.w, R2.z, -R2;
MUL R0.x, R0, R3.w;
SLT R2.w, -R3.z, c[0].x;
SLT R2.z, c[0].x, -R3;
ADD R2.z, R2, -R2.w;
MUL R3.w, R0.z, R2.z;
SLT R2.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R2.w;
MUL R2.w, R3.y, R3;
MUL R0.z, R2, R0;
MAD R0.z, R3.x, R0, R2.w;
DP4 R2.z, R0, c[2];
DP4 R2.w, R0, c[3];
ADD R0.xy, -R4, R2.zwzw;
MUL R4.xy, R0, c[0].w;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
ADD result.texcoord[2].xy, R2, c[19].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
DP3 R0.y, R2, R2;
RSQ R0.y, R0.y;
DP4 R0.x, c[7], c[7];
MUL R2.xyz, R0.y, R2;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, c[7];
MUL R0.xyz, R0, R2;
DP3 R0.w, R0, c[19].y;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MIN R1.x, R0.w, c[0].y;
ADD R0.xyz, -R0, c[6];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL result.texcoord[4].xyz, R0.w, R0;
MAX R1.x, R1, c[0];
ADD R1.x, R1, -c[19].z;
MUL R0.w, R1.x, c[8];
MOV R1.xyz, c[8];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[6];
DP3 R0.x, R0, R0;
MUL R0.w, R0, c[20].x;
MIN R0.y, R0.w, c[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[17];
MIN R0.x, R0, c[0].y;
MAX R0.x, R0, c[0];
MAX R0.y, R0, c[0].x;
ADD R1.xyz, R1, c[18].x;
MAD R1.xyz, R1, R0.y, c[1];
MIN R1.xyz, R1, c[0].y;
ADD result.texcoord[3].xy, R4, c[19].x;
MAX result.texcoord[5].xyz, R1, c[0].x;
MUL result.color.w, vertex.color, R0.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 118 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 15 [_LightColor0]
Float 16 [_DistFade]
Float 17 [_MinLight]
"vs_3_0
; 104 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c18, 0.00000000, 2.00000000, -1.00000000, 0.98000002
def c19, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mad r1.xy, v3, c18.y, c18.z
mov r2.xyz, c18.x
mov r2.w, v0
dp4 r5.x, r2, c0
dp4 r5.y, r2, c1
dp4 r5.w, r2, c3
dp4 r5.z, r2, c2
add r0, r5, v0
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r1.y, -r1.y
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r1, r1
sub r1.z, r0.y, r0
mul r0.z, r1.x, r0.x
mul r1.w, r0.x, r1.z
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r1.w, v0
mov r0.yw, r1
dp4 r4.y, r0, c1
slt r4.x, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.x
dp4 r4.x, r0, c0
mul r0.x, r1, r3.w
add r4.xy, -r5, r4
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r5, r4.zwzw
mad o4.xy, r0, c19.x, c19.y
slt r0.y, -r3.z, r3.z
slt r0.x, r3.z, -r3.z
sub r0.z, r0.y, r0.x
mul r1.x, r1, r0.z
sub r0.x, r0, r0.y
mul r0.w, r1.z, r0.x
slt r0.z, r1.x, -r1.x
slt r0.y, -r1.x, r1.x
sub r0.y, r0, r0.z
mul r0.z, r3.y, r0.w
mul r0.x, r0, r0.y
mad r1.z, r3.x, r0.x, r0
mov r0.xyz, v2
mov r0.w, c18.x
mad o3.xy, r4, c19.x, c19.y
dp4 r4.z, r0, c10
dp4 r4.x, r0, c8
dp4 r4.y, r0, c9
dp3 r0.z, r4, r4
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r5, r0
dp4 r1.w, c14, c14
dp4 r1.z, r2, c10
dp4 r1.x, r2, c8
dp4 r1.y, r2, c9
add r1.xyz, -r1, c13
dp3 r0.w, r1, r1
rsq r0.w, r0.w
rsq r1.w, r1.w
mul o6.xyz, r0.w, r1
rsq r0.z, r0.z
mad o5.xy, r0, c19.x, c19.y
mul r0.xyz, r0.z, r4
mul r2.xyz, r1.w, c14
mul r0.xyz, r2, r0
dp3_sat r0.w, r0, c18.w
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.w, r0, c19.z
mul r0.y, r0.w, c15.w
mul_sat r0.z, r0.y, c19.w
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r0.y, c17.x
mul_sat r0.x, r0, c16
add r1.xyz, c15, r0.y
mad_sat o7.xyz, r1, r0.z, c12
mul o1.w, v1, r0.x
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Vector 80 [_LightColor0] 4
Float 132 [_DistFade]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 80 instructions, 5 temp regs, 0 temp arrays:
// ALU 61 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedlciegmadoaeidnhhnnnigknampjkojhoabaaaaaapiamaaaaadaaaaaa
cmaaaaaanmaaaaaaoaabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
pmaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaapcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaapcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaapcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaapcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaapcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaapcaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaapcaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcbaalaaaaeaaaabaameacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacafaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
apaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaahiccabaaaabaaaaaa
akaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaa
abaaaaaadgaaaaagbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaag
ccaabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaacaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaa
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
adaaaaaadiaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaa
aaaaaaaafganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaa
fganbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaa
acaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaa
adaaaaaaaeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaa
aaaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaa
dcaaaaapdccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaah
ccaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
acaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaa
dbaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaa
abaaaaaaboaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
aaaaaaaacgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
acaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaaeiobhkdpeiobhkdpeiobhkdpaaaaaaaabacaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaa
pgipcaaaaaaaaaaaaiaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11 = (glstate_matrix_modelview0 * tmpvar_10);
  vec4 v_12;
  v_12.x = glstate_matrix_modelview0[0].z;
  v_12.y = glstate_matrix_modelview0[1].z;
  v_12.z = glstate_matrix_modelview0[2].z;
  v_12.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(v_12.xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = _glesVertex.w;
  highp vec2 tmpvar_15;
  tmpvar_15 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_16;
  tmpvar_16.z = 0.0;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_15.y;
  tmpvar_16.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_16.zyw;
  XZv_5.yzw = tmpvar_16.zyw;
  XYv_4.yzw = tmpvar_16.yzw;
  ZYv_6.z = (tmpvar_15.x * sign(-(tmpvar_13.x)));
  XZv_5.x = (tmpvar_15.x * sign(-(tmpvar_13.y)));
  XYv_4.x = (tmpvar_15.x * sign(tmpvar_13.z));
  ZYv_6.x = ((sign(-(tmpvar_13.x)) * sign(ZYv_6.z)) * tmpvar_13.z);
  XZv_5.y = ((sign(-(tmpvar_13.y)) * sign(XZv_5.x)) * tmpvar_13.x);
  XYv_4.z = ((sign(-(tmpvar_13.z)) * sign(XYv_4.x)) * tmpvar_13.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_13.x)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_13.y)) * sign(tmpvar_15.y)) * tmpvar_13.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_13.z)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (dot (normalize((_Object2World * tmpvar_17).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_22;
  tmpvar_22 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_21)), 0.0, 1.0);
  tmpvar_8 = tmpvar_22;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_23;
  p_23 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_24;
  tmpvar_24 = clamp ((_DistFade * sqrt(dot (p_23, p_23))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_24);
  gl_Position = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_13);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_14).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11 = (glstate_matrix_modelview0 * tmpvar_10);
  vec4 v_12;
  v_12.x = glstate_matrix_modelview0[0].z;
  v_12.y = glstate_matrix_modelview0[1].z;
  v_12.z = glstate_matrix_modelview0[2].z;
  v_12.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(v_12.xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = _glesVertex.w;
  highp vec2 tmpvar_15;
  tmpvar_15 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_16;
  tmpvar_16.z = 0.0;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_15.y;
  tmpvar_16.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_16.zyw;
  XZv_5.yzw = tmpvar_16.zyw;
  XYv_4.yzw = tmpvar_16.yzw;
  ZYv_6.z = (tmpvar_15.x * sign(-(tmpvar_13.x)));
  XZv_5.x = (tmpvar_15.x * sign(-(tmpvar_13.y)));
  XYv_4.x = (tmpvar_15.x * sign(tmpvar_13.z));
  ZYv_6.x = ((sign(-(tmpvar_13.x)) * sign(ZYv_6.z)) * tmpvar_13.z);
  XZv_5.y = ((sign(-(tmpvar_13.y)) * sign(XZv_5.x)) * tmpvar_13.x);
  XYv_4.z = ((sign(-(tmpvar_13.z)) * sign(XYv_4.x)) * tmpvar_13.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_13.x)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_13.y)) * sign(tmpvar_15.y)) * tmpvar_13.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_13.z)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (dot (normalize((_Object2World * tmpvar_17).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_22;
  tmpvar_22 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_21)), 0.0, 1.0);
  tmpvar_8 = tmpvar_22;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_23;
  p_23 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_24;
  tmpvar_24 = clamp ((_DistFade * sqrt(dot (p_23, p_23))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_24);
  gl_Position = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_13);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_14).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
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
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 414
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec3 _LightCoord;
};
#line 405
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 404
uniform highp float _MinLight;
#line 427
uniform highp vec4 _TopTex_ST;
#line 468
uniform sampler2D _CameraDepthTexture;
#line 428
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 431
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 435
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 439
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 443
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 447
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 451
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 455
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 459
    mediump vec3 lightDirection = vec3( (0.98 * normalize(_WorldSpaceLightPos0)));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 463
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out mediump vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval.baseLight);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
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
#line 318
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 414
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec3 _LightCoord;
};
#line 405
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 404
uniform highp float _MinLight;
#line 427
uniform highp vec4 _TopTex_ST;
#line 468
uniform sampler2D _CameraDepthTexture;
#line 469
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    #line 472
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    #line 476
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    #line 480
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in mediump vec3 xlv_TEXCOORD5;
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
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec3(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 6 [_WorldSpaceCameraPos]
Vector 7 [_WorldSpaceLightPos0]
Matrix 9 [_Object2World]
Vector 8 [_LightColor0]
Float 17 [_DistFade]
Float 18 [_MinLight]
"3.0-!!ARBvp1.0
# 119 ALU
PARAM c[21] = { { 0, 1, 2, 0.60000002 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..12],
		state.matrix.projection,
		program.local[17..18],
		{ 0.5, 0.97998047, 0.010002136 },
		{ 4.0394478, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[4], c[4];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[4];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
MOV R1.w, vertex.position;
DP4 R4.x, R2, c[2];
DP4 R4.y, R2, c[3];
DP4 R4.w, R2, c[5];
DP4 R4.z, R2, c[4];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[16];
DP4 result.position.z, R0, c[15];
DP4 result.position.y, R0, c[14];
DP4 result.position.x, R0, c[13];
MUL R0.xy, vertex.texcoord[0], c[0].z;
ADD R4.zw, R0.xyxy, -c[0].y;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0];
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
DP4 R1.x, R0, c[2];
DP4 R1.z, R0, c[3];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[0].w;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[19].x;
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
DP4 R4.z, R0, c[2];
DP4 R4.w, R0, c[3];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[0].w;
DP4 R0.z, R1, c[2];
DP4 R0.w, R1, c[3];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[0].w;
ADD result.texcoord[3].xy, R0.zwzw, c[19].x;
ADD result.texcoord[2].xy, R0, c[19].x;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
DP4 R1.z, R0, c[11];
DP4 R1.y, R0, c[10];
DP4 R1.x, R0, c[9];
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
DP4 R1.w, c[7], c[7];
RSQ R0.x, R1.w;
MUL R0.xyz, R0.x, c[7];
MUL R0.xyz, R0, c[19].y;
MUL R1.xyz, R0.w, R1;
DP3 R0.w, R1, R0;
MIN R1.x, R0.w, c[0].y;
MAX R1.x, R1, c[0];
ADD R1.x, R1, -c[19].z;
DP4 R0.z, R2, c[11];
DP4 R0.x, R2, c[9];
DP4 R0.y, R2, c[10];
ADD R0.xyz, -R0, c[6];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL result.texcoord[4].xyz, R0.w, R0;
MUL R0.w, R1.x, c[8];
MOV R1.xyz, c[8];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[6];
DP3 R0.x, R0, R0;
MUL R0.w, R0, c[20].x;
MIN R0.y, R0.w, c[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[17];
MIN R0.x, R0, c[0].y;
MAX R0.x, R0, c[0];
MAX R0.y, R0, c[0].x;
ADD R1.xyz, R1, c[18].x;
MAD R1.xyz, R1, R0.y, c[1];
MIN R1.xyz, R1, c[0].y;
MAX result.texcoord[5].xyz, R1, c[0].x;
MUL result.color.w, vertex.color, R0.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 119 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 15 [_LightColor0]
Float 16 [_DistFade]
Float 17 [_MinLight]
"vs_3_0
; 105 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c18, 0.00000000, 2.00000000, -1.00000000, 0.97998047
def c19, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c18.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c18.y, c18.z
mov r4.y, r2.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
mov r4.w, v0
slt r0.z, r2.w, -r2.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r2.w, r2.w
sub r3.w, r0.y, r0.z
mul r0.z, r2, r0.x
mul r4.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r4.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
slt r4.x, -r3.y, r3.y
slt r2.w, r3.y, -r3.y
sub r2.w, r2, r4.x
mul r0.x, r2.z, r2.w
add r4.xz, -r2.xyyw, r5.xyyw
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r3.w, r2.w
mul r0.y, r0, r2.w
mul r2.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r2.w
dp4 r5.x, r0, c0
dp4 r5.y, r0, c1
add r0.xy, -r2, r5
mad o4.xy, r0, c19.x, c19.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c19.x, c19.y
mul r4.x, r2.z, r1.y
mul r1.z, r3.w, r0.w
slt r1.y, r4.x, -r4.x
slt r1.x, -r4, r4
sub r1.x, r1, r1.y
mul r0.w, r0, r1.x
mul r1.y, r3, r1.z
mad r4.z, r3.x, r0.w, r1.y
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o6.xyz, r0.w, r0
mov r0.xyz, v2
mov r0.w, c18.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c19.x, c19.y
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
dp3 r0.w, r1, r1
rsq r0.w, r0.w
dp4 r1.w, c14, c14
rsq r0.x, r1.w
mul r0.xyz, r0.x, c14
mul r0.xyz, r0, c18.w
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.w, r0, c19.z
mul r0.y, r0.w, c15.w
mul_sat r0.z, r0.y, c19.w
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r0.y, c17.x
mul_sat r0.x, r0, c16
add r1.xyz, c15, r0.y
mad_sat o7.xyz, r1, r0.z, c12
mul o1.w, v1, r0.x
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Vector 80 [_LightColor0] 4
Float 132 [_DistFade]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 80 instructions, 5 temp regs, 0 temp arrays:
// ALU 61 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecediajnpgahadjkdplnjmjialdoeamichfhabaaaaaapiamaaaaadaaaaaa
cmaaaaaanmaaaaaaoaabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
pmaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaapcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaapcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaapcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaapcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaapcaaaaaa
agaaaaaaaaaaaaaaadaaaaaaaeaaaaaaamapaaaapcaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaapcaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcbaalaaaaeaaaabaameacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacafaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
apaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaahiccabaaaabaaaaaa
akaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaa
abaaaaaadgaaaaagbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaag
ccaabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaacaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaa
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
adaaaaaadiaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaa
aaaaaaaafganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaa
fganbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaa
acaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaa
adaaaaaaaeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaa
aaaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaa
dcaaaaapdccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaah
ccaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
acaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaa
dbaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaa
abaaaaaaboaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
aaaaaaaacgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
acaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaaeiobhkdpeiobhkdpeiobhkdpaaaaaaaabacaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaa
pgipcaaaaaaaaaaaaiaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11 = (glstate_matrix_modelview0 * tmpvar_10);
  vec4 v_12;
  v_12.x = glstate_matrix_modelview0[0].z;
  v_12.y = glstate_matrix_modelview0[1].z;
  v_12.z = glstate_matrix_modelview0[2].z;
  v_12.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(v_12.xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = _glesVertex.w;
  highp vec2 tmpvar_15;
  tmpvar_15 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_16;
  tmpvar_16.z = 0.0;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_15.y;
  tmpvar_16.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_16.zyw;
  XZv_5.yzw = tmpvar_16.zyw;
  XYv_4.yzw = tmpvar_16.yzw;
  ZYv_6.z = (tmpvar_15.x * sign(-(tmpvar_13.x)));
  XZv_5.x = (tmpvar_15.x * sign(-(tmpvar_13.y)));
  XYv_4.x = (tmpvar_15.x * sign(tmpvar_13.z));
  ZYv_6.x = ((sign(-(tmpvar_13.x)) * sign(ZYv_6.z)) * tmpvar_13.z);
  XZv_5.y = ((sign(-(tmpvar_13.y)) * sign(XZv_5.x)) * tmpvar_13.x);
  XYv_4.z = ((sign(-(tmpvar_13.z)) * sign(XYv_4.x)) * tmpvar_13.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_13.x)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_13.y)) * sign(tmpvar_15.y)) * tmpvar_13.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_13.z)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (dot (normalize((_Object2World * tmpvar_17).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_22;
  tmpvar_22 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_21)), 0.0, 1.0);
  tmpvar_8 = tmpvar_22;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_23;
  p_23 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_24;
  tmpvar_24 = clamp ((_DistFade * sqrt(dot (p_23, p_23))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_24);
  gl_Position = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_13);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_14).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11 = (glstate_matrix_modelview0 * tmpvar_10);
  vec4 v_12;
  v_12.x = glstate_matrix_modelview0[0].z;
  v_12.y = glstate_matrix_modelview0[1].z;
  v_12.z = glstate_matrix_modelview0[2].z;
  v_12.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(v_12.xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = _glesVertex.w;
  highp vec2 tmpvar_15;
  tmpvar_15 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_16;
  tmpvar_16.z = 0.0;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_15.y;
  tmpvar_16.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_16.zyw;
  XZv_5.yzw = tmpvar_16.zyw;
  XYv_4.yzw = tmpvar_16.yzw;
  ZYv_6.z = (tmpvar_15.x * sign(-(tmpvar_13.x)));
  XZv_5.x = (tmpvar_15.x * sign(-(tmpvar_13.y)));
  XYv_4.x = (tmpvar_15.x * sign(tmpvar_13.z));
  ZYv_6.x = ((sign(-(tmpvar_13.x)) * sign(ZYv_6.z)) * tmpvar_13.z);
  XZv_5.y = ((sign(-(tmpvar_13.y)) * sign(XZv_5.x)) * tmpvar_13.x);
  XYv_4.z = ((sign(-(tmpvar_13.z)) * sign(XYv_4.x)) * tmpvar_13.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_13.x)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_13.y)) * sign(tmpvar_15.y)) * tmpvar_13.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_13.z)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (dot (normalize((_Object2World * tmpvar_17).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_22;
  tmpvar_22 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_21)), 0.0, 1.0);
  tmpvar_8 = tmpvar_22;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_23;
  p_23 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_24;
  tmpvar_24 = clamp ((_DistFade * sqrt(dot (p_23, p_23))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_24);
  gl_Position = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_13);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_14).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
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
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 413
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec2 _LightCoord;
};
#line 404
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 403
uniform highp float _MinLight;
#line 426
uniform highp vec4 _TopTex_ST;
#line 467
uniform sampler2D _CameraDepthTexture;
#line 427
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 430
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 434
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 438
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 442
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 446
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 450
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 454
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 458
    mediump vec3 lightDirection = vec3( (0.98 * normalize(_WorldSpaceLightPos0)));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 462
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out mediump vec3 xlv_TEXCOORD5;
out highp vec2 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval.baseLight);
    xlv_TEXCOORD6 = vec2(xl_retval._LightCoord);
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
#line 317
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
    mediump vec3 baseLight;
    highp vec2 _LightCoord;
};
#line 404
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 403
uniform highp float _MinLight;
#line 426
uniform highp vec4 _TopTex_ST;
#line 467
uniform sampler2D _CameraDepthTexture;
#line 468
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    #line 471
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    #line 475
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    #line 479
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in mediump vec3 xlv_TEXCOORD5;
in highp vec2 xlv_TEXCOORD6;
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
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec2(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 6 [_WorldSpaceCameraPos]
Vector 7 [_WorldSpaceLightPos0]
Matrix 9 [_Object2World]
Vector 8 [_LightColor0]
Float 17 [_DistFade]
Float 18 [_MinLight]
"3.0-!!ARBvp1.0
# 118 ALU
PARAM c[21] = { { 0, 1, 2, 0.60000002 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..12],
		state.matrix.projection,
		program.local[17..18],
		{ 0.5, 0.98000002, 0.010002136 },
		{ 4.0394478, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R2.x, c[4], c[4];
RSQ R2.x, R2.x;
MUL R3.xyz, R2.x, c[4];
MOV R1.xyz, c[0].x;
MOV R1.w, vertex.position;
DP4 R4.x, R1, c[2];
DP4 R4.y, R1, c[3];
DP4 R4.w, R1, c[5];
DP4 R4.z, R1, c[4];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[16];
DP4 result.position.z, R0, c[15];
DP4 result.position.y, R0, c[14];
DP4 result.position.x, R0, c[13];
MUL R0.zw, vertex.texcoord[0].xyxy, c[0].z;
SLT R0.x, c[0], -R3;
SLT R0.y, -R3.x, c[0].x;
ADD R2.x, R0, -R0.y;
ADD R0.xy, R0.zwzw, -c[0].y;
MUL R2.z, R0.x, R2.x;
SLT R2.y, R2.z, c[0].x;
SLT R0.w, R0, c[0].y;
SLT R0.z, c[0].x, R0.y;
ADD R0.z, R0, -R0.w;
SLT R0.w, c[0].x, R2.z;
ADD R0.w, R0, -R2.y;
MUL R2.w, R2.x, R0.z;
MUL R0.w, R0, R2.x;
MUL R2.y, R3, R2.w;
MAD R2.x, R3.z, R0.w, R2.y;
MOV R0.w, vertex.position;
MOV R2.yw, R0;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
SLT R2.w, -R3.y, c[0].x;
SLT R2.z, c[0].x, -R3.y;
ADD R3.w, R2.z, -R2;
MUL R2.zw, R2.xyxy, c[0].w;
MUL R2.x, R0, R3.w;
ADD result.texcoord[1].xy, R2.zwzw, c[19].x;
SLT R2.z, R2.x, c[0].x;
SLT R2.y, c[0].x, R2.x;
ADD R2.y, R2, -R2.z;
MUL R2.z, R0, R3.w;
MUL R2.y, R2, R3.w;
MUL R3.w, R3.z, R2.z;
MOV R2.zw, R0.xyyw;
MAD R2.y, R3.x, R2, R3.w;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
MUL R2.xy, R2, c[0].w;
SLT R2.w, R3.z, c[0].x;
SLT R2.z, c[0].x, R3;
ADD R3.w, R2.z, -R2;
MUL R0.x, R0, R3.w;
SLT R2.w, -R3.z, c[0].x;
SLT R2.z, c[0].x, -R3;
ADD R2.z, R2, -R2.w;
MUL R3.w, R0.z, R2.z;
SLT R2.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R2.w;
MUL R2.w, R3.y, R3;
MUL R0.z, R2, R0;
MAD R0.z, R3.x, R0, R2.w;
DP4 R2.z, R0, c[2];
DP4 R2.w, R0, c[3];
ADD R0.xy, -R4, R2.zwzw;
MUL R4.xy, R0, c[0].w;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
ADD result.texcoord[2].xy, R2, c[19].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
DP3 R0.y, R2, R2;
RSQ R0.y, R0.y;
DP4 R0.x, c[7], c[7];
MUL R2.xyz, R0.y, R2;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, c[7];
MUL R0.xyz, R0, R2;
DP3 R0.w, R0, c[19].y;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MIN R1.x, R0.w, c[0].y;
ADD R0.xyz, -R0, c[6];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL result.texcoord[4].xyz, R0.w, R0;
MAX R1.x, R1, c[0];
ADD R1.x, R1, -c[19].z;
MUL R0.w, R1.x, c[8];
MOV R1.xyz, c[8];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[6];
DP3 R0.x, R0, R0;
MUL R0.w, R0, c[20].x;
MIN R0.y, R0.w, c[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[17];
MIN R0.x, R0, c[0].y;
MAX R0.x, R0, c[0];
MAX R0.y, R0, c[0].x;
ADD R1.xyz, R1, c[18].x;
MAD R1.xyz, R1, R0.y, c[1];
MIN R1.xyz, R1, c[0].y;
ADD result.texcoord[3].xy, R4, c[19].x;
MAX result.texcoord[5].xyz, R1, c[0].x;
MUL result.color.w, vertex.color, R0.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 118 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 15 [_LightColor0]
Float 16 [_DistFade]
Float 17 [_MinLight]
"vs_3_0
; 104 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c18, 0.00000000, 2.00000000, -1.00000000, 0.98000002
def c19, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mad r1.xy, v3, c18.y, c18.z
mov r2.xyz, c18.x
mov r2.w, v0
dp4 r5.x, r2, c0
dp4 r5.y, r2, c1
dp4 r5.w, r2, c3
dp4 r5.z, r2, c2
add r0, r5, v0
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r1.y, -r1.y
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r1, r1
sub r1.z, r0.y, r0
mul r0.z, r1.x, r0.x
mul r1.w, r0.x, r1.z
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r1.w, v0
mov r0.yw, r1
dp4 r4.y, r0, c1
slt r4.x, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.x
dp4 r4.x, r0, c0
mul r0.x, r1, r3.w
add r4.xy, -r5, r4
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r5, r4.zwzw
mad o4.xy, r0, c19.x, c19.y
slt r0.y, -r3.z, r3.z
slt r0.x, r3.z, -r3.z
sub r0.z, r0.y, r0.x
mul r1.x, r1, r0.z
sub r0.x, r0, r0.y
mul r0.w, r1.z, r0.x
slt r0.z, r1.x, -r1.x
slt r0.y, -r1.x, r1.x
sub r0.y, r0, r0.z
mul r0.z, r3.y, r0.w
mul r0.x, r0, r0.y
mad r1.z, r3.x, r0.x, r0
mov r0.xyz, v2
mov r0.w, c18.x
mad o3.xy, r4, c19.x, c19.y
dp4 r4.z, r0, c10
dp4 r4.x, r0, c8
dp4 r4.y, r0, c9
dp3 r0.z, r4, r4
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r5, r0
dp4 r1.w, c14, c14
dp4 r1.z, r2, c10
dp4 r1.x, r2, c8
dp4 r1.y, r2, c9
add r1.xyz, -r1, c13
dp3 r0.w, r1, r1
rsq r0.w, r0.w
rsq r1.w, r1.w
mul o6.xyz, r0.w, r1
rsq r0.z, r0.z
mad o5.xy, r0, c19.x, c19.y
mul r0.xyz, r0.z, r4
mul r2.xyz, r1.w, c14
mul r0.xyz, r2, r0
dp3_sat r0.w, r0, c18.w
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.w, r0, c19.z
mul r0.y, r0.w, c15.w
mul_sat r0.z, r0.y, c19.w
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r0.y, c17.x
mul_sat r0.x, r0, c16
add r1.xyz, c15, r0.y
mad_sat o7.xyz, r1, r0.z, c12
mul o1.w, v1, r0.x
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Vector 80 [_LightColor0] 4
Float 132 [_DistFade]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 80 instructions, 5 temp regs, 0 temp arrays:
// ALU 61 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednlkfobgeengdjnjdhemppmnmfjgjhklcabaaaaaabaanaaaaadaaaaaa
cmaaaaaanmaaaaaapiabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
beabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaakabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaakabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaakabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaakabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaakabaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaakabaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaakabaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apapaaaaakabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcbaalaaaa
eaaaabaameacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaeaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
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
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
eiobhkdpeiobhkdpeiobhkdpaaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaa
aiaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_modelview0 * tmpvar_11);
  vec4 v_13;
  v_13.x = glstate_matrix_modelview0[0].z;
  v_13.y = glstate_matrix_modelview0[1].z;
  v_13.z = glstate_matrix_modelview0[2].z;
  v_13.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(v_13.xyz);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = _glesVertex.w;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.z = 0.0;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = tmpvar_16.y;
  tmpvar_17.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_17.zyw;
  XZv_5.yzw = tmpvar_17.zyw;
  XYv_4.yzw = tmpvar_17.yzw;
  ZYv_6.z = (tmpvar_16.x * sign(-(tmpvar_14.x)));
  XZv_5.x = (tmpvar_16.x * sign(-(tmpvar_14.y)));
  XYv_4.x = (tmpvar_16.x * sign(tmpvar_14.z));
  ZYv_6.x = ((sign(-(tmpvar_14.x)) * sign(ZYv_6.z)) * tmpvar_14.z);
  XZv_5.y = ((sign(-(tmpvar_14.y)) * sign(XZv_5.x)) * tmpvar_14.x);
  XYv_4.z = ((sign(-(tmpvar_14.z)) * sign(XYv_4.x)) * tmpvar_14.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_14.x)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_14.y)) * sign(tmpvar_16.y)) * tmpvar_14.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_14.z)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (normalize((_Object2World * tmpvar_18).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_22)), 0.0, 1.0);
  tmpvar_8 = tmpvar_23;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_24;
  p_24 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_25);
  gl_Position = (glstate_matrix_projection * (tmpvar_12 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_12.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_12.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_12.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_modelview0 * tmpvar_11);
  vec4 v_13;
  v_13.x = glstate_matrix_modelview0[0].z;
  v_13.y = glstate_matrix_modelview0[1].z;
  v_13.z = glstate_matrix_modelview0[2].z;
  v_13.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(v_13.xyz);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = _glesVertex.w;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.z = 0.0;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = tmpvar_16.y;
  tmpvar_17.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_17.zyw;
  XZv_5.yzw = tmpvar_17.zyw;
  XYv_4.yzw = tmpvar_17.yzw;
  ZYv_6.z = (tmpvar_16.x * sign(-(tmpvar_14.x)));
  XZv_5.x = (tmpvar_16.x * sign(-(tmpvar_14.y)));
  XYv_4.x = (tmpvar_16.x * sign(tmpvar_14.z));
  ZYv_6.x = ((sign(-(tmpvar_14.x)) * sign(ZYv_6.z)) * tmpvar_14.z);
  XZv_5.y = ((sign(-(tmpvar_14.y)) * sign(XZv_5.x)) * tmpvar_14.x);
  XYv_4.z = ((sign(-(tmpvar_14.z)) * sign(XYv_4.x)) * tmpvar_14.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_14.x)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_14.y)) * sign(tmpvar_16.y)) * tmpvar_14.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_14.z)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (normalize((_Object2World * tmpvar_18).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_22)), 0.0, 1.0);
  tmpvar_8 = tmpvar_23;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_24;
  p_24 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_25);
  gl_Position = (glstate_matrix_projection * (tmpvar_12 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_12.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_12.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_12.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
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
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 428
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 419
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 418
uniform highp float _MinLight;
#line 442
uniform highp vec4 _TopTex_ST;
#line 483
uniform sampler2D _CameraDepthTexture;
#line 443
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 446
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 450
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 454
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 458
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 462
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 466
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 470
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 474
    mediump vec3 lightDirection = vec3( (0.98 * normalize(_WorldSpaceLightPos0)));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 478
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out mediump vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval.baseLight);
    xlv_TEXCOORD6 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
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
#line 332
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
    mediump vec3 baseLight;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 419
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 418
uniform highp float _MinLight;
#line 442
uniform highp vec4 _TopTex_ST;
#line 483
uniform sampler2D _CameraDepthTexture;
#line 484
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    #line 487
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    #line 491
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    #line 495
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in mediump vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
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
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec4(xlv_TEXCOORD6);
    xlt_i._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 6 [_WorldSpaceCameraPos]
Vector 7 [_WorldSpaceLightPos0]
Matrix 9 [_Object2World]
Vector 8 [_LightColor0]
Float 17 [_DistFade]
Float 18 [_MinLight]
"3.0-!!ARBvp1.0
# 118 ALU
PARAM c[21] = { { 0, 1, 2, 0.60000002 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..12],
		state.matrix.projection,
		program.local[17..18],
		{ 0.5, 0.98000002, 0.010002136 },
		{ 4.0394478, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R2.x, c[4], c[4];
RSQ R2.x, R2.x;
MUL R3.xyz, R2.x, c[4];
MOV R1.xyz, c[0].x;
MOV R1.w, vertex.position;
DP4 R4.x, R1, c[2];
DP4 R4.y, R1, c[3];
DP4 R4.w, R1, c[5];
DP4 R4.z, R1, c[4];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[16];
DP4 result.position.z, R0, c[15];
DP4 result.position.y, R0, c[14];
DP4 result.position.x, R0, c[13];
MUL R0.zw, vertex.texcoord[0].xyxy, c[0].z;
SLT R0.x, c[0], -R3;
SLT R0.y, -R3.x, c[0].x;
ADD R2.x, R0, -R0.y;
ADD R0.xy, R0.zwzw, -c[0].y;
MUL R2.z, R0.x, R2.x;
SLT R2.y, R2.z, c[0].x;
SLT R0.w, R0, c[0].y;
SLT R0.z, c[0].x, R0.y;
ADD R0.z, R0, -R0.w;
SLT R0.w, c[0].x, R2.z;
ADD R0.w, R0, -R2.y;
MUL R2.w, R2.x, R0.z;
MUL R0.w, R0, R2.x;
MUL R2.y, R3, R2.w;
MAD R2.x, R3.z, R0.w, R2.y;
MOV R0.w, vertex.position;
MOV R2.yw, R0;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
SLT R2.w, -R3.y, c[0].x;
SLT R2.z, c[0].x, -R3.y;
ADD R3.w, R2.z, -R2;
MUL R2.zw, R2.xyxy, c[0].w;
MUL R2.x, R0, R3.w;
ADD result.texcoord[1].xy, R2.zwzw, c[19].x;
SLT R2.z, R2.x, c[0].x;
SLT R2.y, c[0].x, R2.x;
ADD R2.y, R2, -R2.z;
MUL R2.z, R0, R3.w;
MUL R2.y, R2, R3.w;
MUL R3.w, R3.z, R2.z;
MOV R2.zw, R0.xyyw;
MAD R2.y, R3.x, R2, R3.w;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
MUL R2.xy, R2, c[0].w;
SLT R2.w, R3.z, c[0].x;
SLT R2.z, c[0].x, R3;
ADD R3.w, R2.z, -R2;
MUL R0.x, R0, R3.w;
SLT R2.w, -R3.z, c[0].x;
SLT R2.z, c[0].x, -R3;
ADD R2.z, R2, -R2.w;
MUL R3.w, R0.z, R2.z;
SLT R2.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R2.w;
MUL R2.w, R3.y, R3;
MUL R0.z, R2, R0;
MAD R0.z, R3.x, R0, R2.w;
DP4 R2.z, R0, c[2];
DP4 R2.w, R0, c[3];
ADD R0.xy, -R4, R2.zwzw;
MUL R4.xy, R0, c[0].w;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
ADD result.texcoord[2].xy, R2, c[19].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
DP3 R0.y, R2, R2;
RSQ R0.y, R0.y;
DP4 R0.x, c[7], c[7];
MUL R2.xyz, R0.y, R2;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, c[7];
MUL R0.xyz, R0, R2;
DP3 R0.w, R0, c[19].y;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MIN R1.x, R0.w, c[0].y;
ADD R0.xyz, -R0, c[6];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL result.texcoord[4].xyz, R0.w, R0;
MAX R1.x, R1, c[0];
ADD R1.x, R1, -c[19].z;
MUL R0.w, R1.x, c[8];
MOV R1.xyz, c[8];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[6];
DP3 R0.x, R0, R0;
MUL R0.w, R0, c[20].x;
MIN R0.y, R0.w, c[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[17];
MIN R0.x, R0, c[0].y;
MAX R0.x, R0, c[0];
MAX R0.y, R0, c[0].x;
ADD R1.xyz, R1, c[18].x;
MAD R1.xyz, R1, R0.y, c[1];
MIN R1.xyz, R1, c[0].y;
ADD result.texcoord[3].xy, R4, c[19].x;
MAX result.texcoord[5].xyz, R1, c[0].x;
MUL result.color.w, vertex.color, R0.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 118 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 15 [_LightColor0]
Float 16 [_DistFade]
Float 17 [_MinLight]
"vs_3_0
; 104 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c18, 0.00000000, 2.00000000, -1.00000000, 0.98000002
def c19, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mad r1.xy, v3, c18.y, c18.z
mov r2.xyz, c18.x
mov r2.w, v0
dp4 r5.x, r2, c0
dp4 r5.y, r2, c1
dp4 r5.w, r2, c3
dp4 r5.z, r2, c2
add r0, r5, v0
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r1.y, -r1.y
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r1, r1
sub r1.z, r0.y, r0
mul r0.z, r1.x, r0.x
mul r1.w, r0.x, r1.z
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r1.w, v0
mov r0.yw, r1
dp4 r4.y, r0, c1
slt r4.x, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.x
dp4 r4.x, r0, c0
mul r0.x, r1, r3.w
add r4.xy, -r5, r4
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r5, r4.zwzw
mad o4.xy, r0, c19.x, c19.y
slt r0.y, -r3.z, r3.z
slt r0.x, r3.z, -r3.z
sub r0.z, r0.y, r0.x
mul r1.x, r1, r0.z
sub r0.x, r0, r0.y
mul r0.w, r1.z, r0.x
slt r0.z, r1.x, -r1.x
slt r0.y, -r1.x, r1.x
sub r0.y, r0, r0.z
mul r0.z, r3.y, r0.w
mul r0.x, r0, r0.y
mad r1.z, r3.x, r0.x, r0
mov r0.xyz, v2
mov r0.w, c18.x
mad o3.xy, r4, c19.x, c19.y
dp4 r4.z, r0, c10
dp4 r4.x, r0, c8
dp4 r4.y, r0, c9
dp3 r0.z, r4, r4
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r5, r0
dp4 r1.w, c14, c14
dp4 r1.z, r2, c10
dp4 r1.x, r2, c8
dp4 r1.y, r2, c9
add r1.xyz, -r1, c13
dp3 r0.w, r1, r1
rsq r0.w, r0.w
rsq r1.w, r1.w
mul o6.xyz, r0.w, r1
rsq r0.z, r0.z
mad o5.xy, r0, c19.x, c19.y
mul r0.xyz, r0.z, r4
mul r2.xyz, r1.w, c14
mul r0.xyz, r2, r0
dp3_sat r0.w, r0, c18.w
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.w, r0, c19.z
mul r0.y, r0.w, c15.w
mul_sat r0.z, r0.y, c19.w
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r0.y, c17.x
mul_sat r0.x, r0, c16
add r1.xyz, c15, r0.y
mad_sat o7.xyz, r1, r0.z, c12
mul o1.w, v1, r0.x
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Vector 80 [_LightColor0] 4
Float 132 [_DistFade]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 80 instructions, 5 temp regs, 0 temp arrays:
// ALU 61 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednlkfobgeengdjnjdhemppmnmfjgjhklcabaaaaaabaanaaaaadaaaaaa
cmaaaaaanmaaaaaapiabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
beabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaakabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaakabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaakabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaakabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaakabaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaakabaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaakabaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apapaaaaakabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcbaalaaaa
eaaaabaameacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaeaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
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
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
eiobhkdpeiobhkdpeiobhkdpaaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaa
aiaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_modelview0 * tmpvar_11);
  vec4 v_13;
  v_13.x = glstate_matrix_modelview0[0].z;
  v_13.y = glstate_matrix_modelview0[1].z;
  v_13.z = glstate_matrix_modelview0[2].z;
  v_13.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(v_13.xyz);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = _glesVertex.w;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.z = 0.0;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = tmpvar_16.y;
  tmpvar_17.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_17.zyw;
  XZv_5.yzw = tmpvar_17.zyw;
  XYv_4.yzw = tmpvar_17.yzw;
  ZYv_6.z = (tmpvar_16.x * sign(-(tmpvar_14.x)));
  XZv_5.x = (tmpvar_16.x * sign(-(tmpvar_14.y)));
  XYv_4.x = (tmpvar_16.x * sign(tmpvar_14.z));
  ZYv_6.x = ((sign(-(tmpvar_14.x)) * sign(ZYv_6.z)) * tmpvar_14.z);
  XZv_5.y = ((sign(-(tmpvar_14.y)) * sign(XZv_5.x)) * tmpvar_14.x);
  XYv_4.z = ((sign(-(tmpvar_14.z)) * sign(XYv_4.x)) * tmpvar_14.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_14.x)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_14.y)) * sign(tmpvar_16.y)) * tmpvar_14.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_14.z)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (normalize((_Object2World * tmpvar_18).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_22)), 0.0, 1.0);
  tmpvar_8 = tmpvar_23;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_24;
  p_24 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_25);
  gl_Position = (glstate_matrix_projection * (tmpvar_12 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_12.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_12.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_12.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
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
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 429
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 420
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 419
uniform highp float _MinLight;
#line 443
uniform highp vec4 _TopTex_ST;
#line 484
uniform sampler2D _CameraDepthTexture;
#line 444
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 447
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 451
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 455
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 459
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 463
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 467
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 471
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 475
    mediump vec3 lightDirection = vec3( (0.98 * normalize(_WorldSpaceLightPos0)));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 479
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out mediump vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval.baseLight);
    xlv_TEXCOORD6 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
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
#line 333
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 429
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 420
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 419
uniform highp float _MinLight;
#line 443
uniform highp vec4 _TopTex_ST;
#line 484
uniform sampler2D _CameraDepthTexture;
#line 485
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    #line 488
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    #line 492
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    #line 496
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in mediump vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
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
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec4(xlv_TEXCOORD6);
    xlt_i._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 6 [_WorldSpaceCameraPos]
Vector 7 [_WorldSpaceLightPos0]
Matrix 9 [_Object2World]
Vector 8 [_LightColor0]
Float 17 [_DistFade]
Float 18 [_MinLight]
"3.0-!!ARBvp1.0
# 119 ALU
PARAM c[21] = { { 0, 1, 2, 0.60000002 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..12],
		state.matrix.projection,
		program.local[17..18],
		{ 0.5, 0.97998047, 0.010002136 },
		{ 4.0394478, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[4], c[4];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[4];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
MOV R1.w, vertex.position;
DP4 R4.x, R2, c[2];
DP4 R4.y, R2, c[3];
DP4 R4.w, R2, c[5];
DP4 R4.z, R2, c[4];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[16];
DP4 result.position.z, R0, c[15];
DP4 result.position.y, R0, c[14];
DP4 result.position.x, R0, c[13];
MUL R0.xy, vertex.texcoord[0], c[0].z;
ADD R4.zw, R0.xyxy, -c[0].y;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0];
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
DP4 R1.x, R0, c[2];
DP4 R1.z, R0, c[3];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[0].w;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[19].x;
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
DP4 R4.z, R0, c[2];
DP4 R4.w, R0, c[3];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[0].w;
DP4 R0.z, R1, c[2];
DP4 R0.w, R1, c[3];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[0].w;
ADD result.texcoord[3].xy, R0.zwzw, c[19].x;
ADD result.texcoord[2].xy, R0, c[19].x;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
DP4 R1.z, R0, c[11];
DP4 R1.y, R0, c[10];
DP4 R1.x, R0, c[9];
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
DP4 R1.w, c[7], c[7];
RSQ R0.x, R1.w;
MUL R0.xyz, R0.x, c[7];
MUL R0.xyz, R0, c[19].y;
MUL R1.xyz, R0.w, R1;
DP3 R0.w, R1, R0;
MIN R1.x, R0.w, c[0].y;
MAX R1.x, R1, c[0];
ADD R1.x, R1, -c[19].z;
DP4 R0.z, R2, c[11];
DP4 R0.x, R2, c[9];
DP4 R0.y, R2, c[10];
ADD R0.xyz, -R0, c[6];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL result.texcoord[4].xyz, R0.w, R0;
MUL R0.w, R1.x, c[8];
MOV R1.xyz, c[8];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[6];
DP3 R0.x, R0, R0;
MUL R0.w, R0, c[20].x;
MIN R0.y, R0.w, c[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[17];
MIN R0.x, R0, c[0].y;
MAX R0.x, R0, c[0];
MAX R0.y, R0, c[0].x;
ADD R1.xyz, R1, c[18].x;
MAD R1.xyz, R1, R0.y, c[1];
MIN R1.xyz, R1, c[0].y;
MAX result.texcoord[5].xyz, R1, c[0].x;
MUL result.color.w, vertex.color, R0.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 119 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 15 [_LightColor0]
Float 16 [_DistFade]
Float 17 [_MinLight]
"vs_3_0
; 105 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c18, 0.00000000, 2.00000000, -1.00000000, 0.97998047
def c19, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c18.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c18.y, c18.z
mov r4.y, r2.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
mov r4.w, v0
slt r0.z, r2.w, -r2.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r2.w, r2.w
sub r3.w, r0.y, r0.z
mul r0.z, r2, r0.x
mul r4.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r4.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
slt r4.x, -r3.y, r3.y
slt r2.w, r3.y, -r3.y
sub r2.w, r2, r4.x
mul r0.x, r2.z, r2.w
add r4.xz, -r2.xyyw, r5.xyyw
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r3.w, r2.w
mul r0.y, r0, r2.w
mul r2.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r2.w
dp4 r5.x, r0, c0
dp4 r5.y, r0, c1
add r0.xy, -r2, r5
mad o4.xy, r0, c19.x, c19.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c19.x, c19.y
mul r4.x, r2.z, r1.y
mul r1.z, r3.w, r0.w
slt r1.y, r4.x, -r4.x
slt r1.x, -r4, r4
sub r1.x, r1, r1.y
mul r0.w, r0, r1.x
mul r1.y, r3, r1.z
mad r4.z, r3.x, r0.w, r1.y
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o6.xyz, r0.w, r0
mov r0.xyz, v2
mov r0.w, c18.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c19.x, c19.y
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
dp3 r0.w, r1, r1
rsq r0.w, r0.w
dp4 r1.w, c14, c14
rsq r0.x, r1.w
mul r0.xyz, r0.x, c14
mul r0.xyz, r0, c18.w
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.w, r0, c19.z
mul r0.y, r0.w, c15.w
mul_sat r0.z, r0.y, c19.w
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r0.y, c17.x
mul_sat r0.x, r0, c16
add r1.xyz, c15, r0.y
mad_sat o7.xyz, r1, r0.z, c12
mul o1.w, v1, r0.x
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Vector 80 [_LightColor0] 4
Float 132 [_DistFade]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 80 instructions, 5 temp regs, 0 temp arrays:
// ALU 61 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedaedjbdgpdndpleaeoajhkjjkclpofcpcabaaaaaapiamaaaaadaaaaaa
cmaaaaaanmaaaaaaoaabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
pmaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaapcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaapcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaapcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaapcaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaapcaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaapcaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaapcaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcbaalaaaaeaaaabaameacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacafaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
apaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaahiccabaaaabaaaaaa
akaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaa
abaaaaaadgaaaaagbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaag
ccaabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaacaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaa
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
adaaaaaadiaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaa
aaaaaaaafganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaa
fganbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaa
acaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaa
adaaaaaaaeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaa
aaaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaa
dcaaaaapdccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaah
ccaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
acaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaa
dbaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaa
abaaaaaaboaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
aaaaaaaacgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
abaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
acaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaaeiobhkdpeiobhkdpeiobhkdpaaaaaaaabacaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiaeaaaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaa
pgipcaaaaaaaaaaaaiaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11 = (glstate_matrix_modelview0 * tmpvar_10);
  vec4 v_12;
  v_12.x = glstate_matrix_modelview0[0].z;
  v_12.y = glstate_matrix_modelview0[1].z;
  v_12.z = glstate_matrix_modelview0[2].z;
  v_12.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(v_12.xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = _glesVertex.w;
  highp vec2 tmpvar_15;
  tmpvar_15 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_16;
  tmpvar_16.z = 0.0;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_15.y;
  tmpvar_16.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_16.zyw;
  XZv_5.yzw = tmpvar_16.zyw;
  XYv_4.yzw = tmpvar_16.yzw;
  ZYv_6.z = (tmpvar_15.x * sign(-(tmpvar_13.x)));
  XZv_5.x = (tmpvar_15.x * sign(-(tmpvar_13.y)));
  XYv_4.x = (tmpvar_15.x * sign(tmpvar_13.z));
  ZYv_6.x = ((sign(-(tmpvar_13.x)) * sign(ZYv_6.z)) * tmpvar_13.z);
  XZv_5.y = ((sign(-(tmpvar_13.y)) * sign(XZv_5.x)) * tmpvar_13.x);
  XYv_4.z = ((sign(-(tmpvar_13.z)) * sign(XYv_4.x)) * tmpvar_13.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_13.x)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_13.y)) * sign(tmpvar_15.y)) * tmpvar_13.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_13.z)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (dot (normalize((_Object2World * tmpvar_17).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_22;
  tmpvar_22 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_21)), 0.0, 1.0);
  tmpvar_8 = tmpvar_22;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_23;
  p_23 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_24;
  tmpvar_24 = clamp ((_DistFade * sqrt(dot (p_23, p_23))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_24);
  gl_Position = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_13);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_14).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11 = (glstate_matrix_modelview0 * tmpvar_10);
  vec4 v_12;
  v_12.x = glstate_matrix_modelview0[0].z;
  v_12.y = glstate_matrix_modelview0[1].z;
  v_12.z = glstate_matrix_modelview0[2].z;
  v_12.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(v_12.xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = _glesVertex.w;
  highp vec2 tmpvar_15;
  tmpvar_15 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_16;
  tmpvar_16.z = 0.0;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_15.y;
  tmpvar_16.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_16.zyw;
  XZv_5.yzw = tmpvar_16.zyw;
  XYv_4.yzw = tmpvar_16.yzw;
  ZYv_6.z = (tmpvar_15.x * sign(-(tmpvar_13.x)));
  XZv_5.x = (tmpvar_15.x * sign(-(tmpvar_13.y)));
  XYv_4.x = (tmpvar_15.x * sign(tmpvar_13.z));
  ZYv_6.x = ((sign(-(tmpvar_13.x)) * sign(ZYv_6.z)) * tmpvar_13.z);
  XZv_5.y = ((sign(-(tmpvar_13.y)) * sign(XZv_5.x)) * tmpvar_13.x);
  XYv_4.z = ((sign(-(tmpvar_13.z)) * sign(XYv_4.x)) * tmpvar_13.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_13.x)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_13.y)) * sign(tmpvar_15.y)) * tmpvar_13.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_13.z)) * sign(tmpvar_15.y)) * tmpvar_13.y));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (dot (normalize((_Object2World * tmpvar_17).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_22;
  tmpvar_22 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_21)), 0.0, 1.0);
  tmpvar_8 = tmpvar_22;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_23;
  p_23 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_24;
  tmpvar_24 = clamp ((_DistFade * sqrt(dot (p_23, p_23))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_24);
  gl_Position = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_13);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_14).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
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
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 419
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec4 _ShadowCoord;
};
#line 410
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 409
uniform highp float _MinLight;
#line 432
uniform highp vec4 _TopTex_ST;
#line 473
uniform sampler2D _CameraDepthTexture;
#line 433
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 436
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 440
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 444
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 448
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 452
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 456
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 460
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 464
    mediump vec3 lightDirection = vec3( (0.98 * normalize(_WorldSpaceLightPos0)));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 468
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out mediump vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval.baseLight);
    xlv_TEXCOORD6 = vec4(xl_retval._ShadowCoord);
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
#line 323
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 419
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec4 _ShadowCoord;
};
#line 410
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 409
uniform highp float _MinLight;
#line 432
uniform highp vec4 _TopTex_ST;
#line 473
uniform sampler2D _CameraDepthTexture;
#line 474
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    #line 477
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    #line 481
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    #line 485
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in mediump vec3 xlv_TEXCOORD5;
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
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._ShadowCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 6 [_WorldSpaceCameraPos]
Vector 7 [_WorldSpaceLightPos0]
Matrix 9 [_Object2World]
Vector 8 [_LightColor0]
Float 17 [_DistFade]
Float 18 [_MinLight]
"3.0-!!ARBvp1.0
# 119 ALU
PARAM c[21] = { { 0, 1, 2, 0.60000002 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..12],
		state.matrix.projection,
		program.local[17..18],
		{ 0.5, 0.97998047, 0.010002136 },
		{ 4.0394478, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R1.x, c[4], c[4];
RSQ R1.x, R1.x;
MUL R3.xyz, R1.x, c[4];
MOV R2.w, vertex.position;
MOV R2.xyz, c[0].x;
MOV R1.w, vertex.position;
DP4 R4.x, R2, c[2];
DP4 R4.y, R2, c[3];
DP4 R4.w, R2, c[5];
DP4 R4.z, R2, c[4];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[16];
DP4 result.position.z, R0, c[15];
DP4 result.position.y, R0, c[14];
DP4 result.position.x, R0, c[13];
MUL R0.xy, vertex.texcoord[0], c[0].z;
ADD R4.zw, R0.xyxy, -c[0].y;
MOV R1.y, R4.w;
SLT R0.x, c[0], R4.w;
SLT R0.y, R0, c[0];
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
DP4 R1.x, R0, c[2];
DP4 R1.z, R0, c[3];
ADD R0.xy, -R4, R1.xzzw;
MUL R0.xy, R0, c[0].w;
SLT R0.w, R3.z, c[0].x;
SLT R0.z, c[0].x, R3;
ADD R0.z, R0, -R0.w;
MUL R1.x, R4.z, R0.z;
ADD result.texcoord[1].xy, R0, c[19].x;
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
DP4 R4.z, R0, c[2];
DP4 R4.w, R0, c[3];
ADD R0.xy, -R4, R4.zwzw;
MUL R0.xy, R0, c[0].w;
DP4 R0.z, R1, c[2];
DP4 R0.w, R1, c[3];
ADD R0.zw, -R4.xyxy, R0;
MUL R0.zw, R0, c[0].w;
ADD result.texcoord[3].xy, R0.zwzw, c[19].x;
ADD result.texcoord[2].xy, R0, c[19].x;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
DP4 R1.z, R0, c[11];
DP4 R1.y, R0, c[10];
DP4 R1.x, R0, c[9];
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
DP4 R1.w, c[7], c[7];
RSQ R0.x, R1.w;
MUL R0.xyz, R0.x, c[7];
MUL R0.xyz, R0, c[19].y;
MUL R1.xyz, R0.w, R1;
DP3 R0.w, R1, R0;
MIN R1.x, R0.w, c[0].y;
MAX R1.x, R1, c[0];
ADD R1.x, R1, -c[19].z;
DP4 R0.z, R2, c[11];
DP4 R0.x, R2, c[9];
DP4 R0.y, R2, c[10];
ADD R0.xyz, -R0, c[6];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL result.texcoord[4].xyz, R0.w, R0;
MUL R0.w, R1.x, c[8];
MOV R1.xyz, c[8];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[6];
DP3 R0.x, R0, R0;
MUL R0.w, R0, c[20].x;
MIN R0.y, R0.w, c[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[17];
MIN R0.x, R0, c[0].y;
MAX R0.x, R0, c[0];
MAX R0.y, R0, c[0].x;
ADD R1.xyz, R1, c[18].x;
MAD R1.xyz, R1, R0.y, c[1];
MIN R1.xyz, R1, c[0].y;
MAX result.texcoord[5].xyz, R1, c[0].x;
MUL result.color.w, vertex.color, R0.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 119 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 15 [_LightColor0]
Float 16 [_DistFade]
Float 17 [_MinLight]
"vs_3_0
; 105 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c18, 0.00000000, 2.00000000, -1.00000000, 0.97998047
def c19, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c18.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c18.y, c18.z
mov r4.y, r2.w
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
mov r4.w, v0
slt r0.z, r2.w, -r2.w
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r2.w, r2.w
sub r3.w, r0.y, r0.z
mul r0.z, r2, r0.x
mul r4.x, r0, r3.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r4.x
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
slt r4.x, -r3.y, r3.y
slt r2.w, r3.y, -r3.y
sub r2.w, r2, r4.x
mul r0.x, r2.z, r2.w
add r4.xz, -r2.xyyw, r5.xyyw
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r3.w, r2.w
mul r0.y, r0, r2.w
mul r2.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r2.w
dp4 r5.x, r0, c0
dp4 r5.y, r0, c1
add r0.xy, -r2, r5
mad o4.xy, r0, c19.x, c19.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c19.x, c19.y
mul r4.x, r2.z, r1.y
mul r1.z, r3.w, r0.w
slt r1.y, r4.x, -r4.x
slt r1.x, -r4, r4
sub r1.x, r1, r1.y
mul r0.w, r0, r1.x
mul r1.y, r3, r1.z
mad r4.z, r3.x, r0.w, r1.y
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o6.xyz, r0.w, r0
mov r0.xyz, v2
mov r0.w, c18.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c19.x, c19.y
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
dp3 r0.w, r1, r1
rsq r0.w, r0.w
dp4 r1.w, c14, c14
rsq r0.x, r1.w
mul r0.xyz, r0.x, c14
mul r0.xyz, r0, c18.w
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.w, r0, c19.z
mul r0.y, r0.w, c15.w
mul_sat r0.z, r0.y, c19.w
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r0.y, c17.x
mul_sat r0.x, r0, c16
add r1.xyz, c15, r0.y
mad_sat o7.xyz, r1, r0.z, c12
mul o1.w, v1, r0.x
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 224 // 208 used size, 11 vars
Vector 144 [_LightColor0] 4
Float 196 [_DistFade]
Float 204 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 80 instructions, 5 temp regs, 0 temp arrays:
// ALU 61 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedflkdkjfcaikgkajofddoecojppjcegpgabaaaaaabaanaaaaadaaaaaa
cmaaaaaanmaaaaaapiabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
beabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaakabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaakabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaakabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaakabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaakabaaaa
agaaaaaaaaaaaaaaadaaaaaaaeaaaaaaamapaaaaakabaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaakabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaaakabaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcbaalaaaa
eaaaabaameacaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaeaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaamaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
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
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
eiobhkdpeiobhkdpeiobhkdpaaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
ajaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaajaaaaaapgipcaaaaaaaaaaa
amaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_modelview0 * tmpvar_11);
  vec4 v_13;
  v_13.x = glstate_matrix_modelview0[0].z;
  v_13.y = glstate_matrix_modelview0[1].z;
  v_13.z = glstate_matrix_modelview0[2].z;
  v_13.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(v_13.xyz);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = _glesVertex.w;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.z = 0.0;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = tmpvar_16.y;
  tmpvar_17.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_17.zyw;
  XZv_5.yzw = tmpvar_17.zyw;
  XYv_4.yzw = tmpvar_17.yzw;
  ZYv_6.z = (tmpvar_16.x * sign(-(tmpvar_14.x)));
  XZv_5.x = (tmpvar_16.x * sign(-(tmpvar_14.y)));
  XYv_4.x = (tmpvar_16.x * sign(tmpvar_14.z));
  ZYv_6.x = ((sign(-(tmpvar_14.x)) * sign(ZYv_6.z)) * tmpvar_14.z);
  XZv_5.y = ((sign(-(tmpvar_14.y)) * sign(XZv_5.x)) * tmpvar_14.x);
  XYv_4.z = ((sign(-(tmpvar_14.z)) * sign(XYv_4.x)) * tmpvar_14.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_14.x)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_14.y)) * sign(tmpvar_16.y)) * tmpvar_14.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_14.z)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (normalize((_Object2World * tmpvar_18).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_22)), 0.0, 1.0);
  tmpvar_8 = tmpvar_23;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_24;
  p_24 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_25);
  gl_Position = (glstate_matrix_projection * (tmpvar_12 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_12.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_12.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_12.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying highp vec2 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec2 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_modelview0 * tmpvar_11);
  vec4 v_13;
  v_13.x = glstate_matrix_modelview0[0].z;
  v_13.y = glstate_matrix_modelview0[1].z;
  v_13.z = glstate_matrix_modelview0[2].z;
  v_13.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(v_13.xyz);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = _glesVertex.w;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.z = 0.0;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = tmpvar_16.y;
  tmpvar_17.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_17.zyw;
  XZv_5.yzw = tmpvar_17.zyw;
  XYv_4.yzw = tmpvar_17.yzw;
  ZYv_6.z = (tmpvar_16.x * sign(-(tmpvar_14.x)));
  XZv_5.x = (tmpvar_16.x * sign(-(tmpvar_14.y)));
  XYv_4.x = (tmpvar_16.x * sign(tmpvar_14.z));
  ZYv_6.x = ((sign(-(tmpvar_14.x)) * sign(ZYv_6.z)) * tmpvar_14.z);
  XZv_5.y = ((sign(-(tmpvar_14.y)) * sign(XZv_5.x)) * tmpvar_14.x);
  XYv_4.z = ((sign(-(tmpvar_14.z)) * sign(XYv_4.x)) * tmpvar_14.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_14.x)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_14.y)) * sign(tmpvar_16.y)) * tmpvar_14.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_14.z)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (normalize((_Object2World * tmpvar_18).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_22)), 0.0, 1.0);
  tmpvar_8 = tmpvar_23;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_24;
  p_24 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_25);
  gl_Position = (glstate_matrix_projection * (tmpvar_12 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_12.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_12.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_12.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
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
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 421
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec2 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 412
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 411
uniform highp float _MinLight;
#line 435
uniform highp vec4 _TopTex_ST;
#line 476
uniform sampler2D _CameraDepthTexture;
#line 436
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 439
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 443
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 447
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 451
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 455
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 459
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 463
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 467
    mediump vec3 lightDirection = vec3( (0.98 * normalize(_WorldSpaceLightPos0)));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 471
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out mediump vec3 xlv_TEXCOORD5;
out highp vec2 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval.baseLight);
    xlv_TEXCOORD6 = vec2(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
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
#line 325
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
    mediump vec3 baseLight;
    highp vec2 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 412
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 411
uniform highp float _MinLight;
#line 435
uniform highp vec4 _TopTex_ST;
#line 476
uniform sampler2D _CameraDepthTexture;
#line 477
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    #line 480
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    #line 484
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    #line 488
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in mediump vec3 xlv_TEXCOORD5;
in highp vec2 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
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
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec2(xlv_TEXCOORD6);
    xlt_i._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 6 [_WorldSpaceCameraPos]
Vector 7 [_WorldSpaceLightPos0]
Matrix 9 [_Object2World]
Vector 8 [_LightColor0]
Float 17 [_DistFade]
Float 18 [_MinLight]
"3.0-!!ARBvp1.0
# 118 ALU
PARAM c[21] = { { 0, 1, 2, 0.60000002 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..12],
		state.matrix.projection,
		program.local[17..18],
		{ 0.5, 0.98000002, 0.010002136 },
		{ 4.0394478, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R2.x, c[4], c[4];
RSQ R2.x, R2.x;
MUL R3.xyz, R2.x, c[4];
MOV R1.xyz, c[0].x;
MOV R1.w, vertex.position;
DP4 R4.x, R1, c[2];
DP4 R4.y, R1, c[3];
DP4 R4.w, R1, c[5];
DP4 R4.z, R1, c[4];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[16];
DP4 result.position.z, R0, c[15];
DP4 result.position.y, R0, c[14];
DP4 result.position.x, R0, c[13];
MUL R0.zw, vertex.texcoord[0].xyxy, c[0].z;
SLT R0.x, c[0], -R3;
SLT R0.y, -R3.x, c[0].x;
ADD R2.x, R0, -R0.y;
ADD R0.xy, R0.zwzw, -c[0].y;
MUL R2.z, R0.x, R2.x;
SLT R2.y, R2.z, c[0].x;
SLT R0.w, R0, c[0].y;
SLT R0.z, c[0].x, R0.y;
ADD R0.z, R0, -R0.w;
SLT R0.w, c[0].x, R2.z;
ADD R0.w, R0, -R2.y;
MUL R2.w, R2.x, R0.z;
MUL R0.w, R0, R2.x;
MUL R2.y, R3, R2.w;
MAD R2.x, R3.z, R0.w, R2.y;
MOV R0.w, vertex.position;
MOV R2.yw, R0;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
SLT R2.w, -R3.y, c[0].x;
SLT R2.z, c[0].x, -R3.y;
ADD R3.w, R2.z, -R2;
MUL R2.zw, R2.xyxy, c[0].w;
MUL R2.x, R0, R3.w;
ADD result.texcoord[1].xy, R2.zwzw, c[19].x;
SLT R2.z, R2.x, c[0].x;
SLT R2.y, c[0].x, R2.x;
ADD R2.y, R2, -R2.z;
MUL R2.z, R0, R3.w;
MUL R2.y, R2, R3.w;
MUL R3.w, R3.z, R2.z;
MOV R2.zw, R0.xyyw;
MAD R2.y, R3.x, R2, R3.w;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
MUL R2.xy, R2, c[0].w;
SLT R2.w, R3.z, c[0].x;
SLT R2.z, c[0].x, R3;
ADD R3.w, R2.z, -R2;
MUL R0.x, R0, R3.w;
SLT R2.w, -R3.z, c[0].x;
SLT R2.z, c[0].x, -R3;
ADD R2.z, R2, -R2.w;
MUL R3.w, R0.z, R2.z;
SLT R2.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R2.w;
MUL R2.w, R3.y, R3;
MUL R0.z, R2, R0;
MAD R0.z, R3.x, R0, R2.w;
DP4 R2.z, R0, c[2];
DP4 R2.w, R0, c[3];
ADD R0.xy, -R4, R2.zwzw;
MUL R4.xy, R0, c[0].w;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
ADD result.texcoord[2].xy, R2, c[19].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
DP3 R0.y, R2, R2;
RSQ R0.y, R0.y;
DP4 R0.x, c[7], c[7];
MUL R2.xyz, R0.y, R2;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, c[7];
MUL R0.xyz, R0, R2;
DP3 R0.w, R0, c[19].y;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MIN R1.x, R0.w, c[0].y;
ADD R0.xyz, -R0, c[6];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL result.texcoord[4].xyz, R0.w, R0;
MAX R1.x, R1, c[0];
ADD R1.x, R1, -c[19].z;
MUL R0.w, R1.x, c[8];
MOV R1.xyz, c[8];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[6];
DP3 R0.x, R0, R0;
MUL R0.w, R0, c[20].x;
MIN R0.y, R0.w, c[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[17];
MIN R0.x, R0, c[0].y;
MAX R0.x, R0, c[0];
MAX R0.y, R0, c[0].x;
ADD R1.xyz, R1, c[18].x;
MAD R1.xyz, R1, R0.y, c[1];
MIN R1.xyz, R1, c[0].y;
ADD result.texcoord[3].xy, R4, c[19].x;
MAX result.texcoord[5].xyz, R1, c[0].x;
MUL result.color.w, vertex.color, R0.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 118 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 15 [_LightColor0]
Float 16 [_DistFade]
Float 17 [_MinLight]
"vs_3_0
; 104 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c18, 0.00000000, 2.00000000, -1.00000000, 0.98000002
def c19, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mad r1.xy, v3, c18.y, c18.z
mov r2.xyz, c18.x
mov r2.w, v0
dp4 r5.x, r2, c0
dp4 r5.y, r2, c1
dp4 r5.w, r2, c3
dp4 r5.z, r2, c2
add r0, r5, v0
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r1.y, -r1.y
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r1, r1
sub r1.z, r0.y, r0
mul r0.z, r1.x, r0.x
mul r1.w, r0.x, r1.z
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r1.w, v0
mov r0.yw, r1
dp4 r4.y, r0, c1
slt r4.x, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.x
dp4 r4.x, r0, c0
mul r0.x, r1, r3.w
add r4.xy, -r5, r4
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r5, r4.zwzw
mad o4.xy, r0, c19.x, c19.y
slt r0.y, -r3.z, r3.z
slt r0.x, r3.z, -r3.z
sub r0.z, r0.y, r0.x
mul r1.x, r1, r0.z
sub r0.x, r0, r0.y
mul r0.w, r1.z, r0.x
slt r0.z, r1.x, -r1.x
slt r0.y, -r1.x, r1.x
sub r0.y, r0, r0.z
mul r0.z, r3.y, r0.w
mul r0.x, r0, r0.y
mad r1.z, r3.x, r0.x, r0
mov r0.xyz, v2
mov r0.w, c18.x
mad o3.xy, r4, c19.x, c19.y
dp4 r4.z, r0, c10
dp4 r4.x, r0, c8
dp4 r4.y, r0, c9
dp3 r0.z, r4, r4
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r5, r0
dp4 r1.w, c14, c14
dp4 r1.z, r2, c10
dp4 r1.x, r2, c8
dp4 r1.y, r2, c9
add r1.xyz, -r1, c13
dp3 r0.w, r1, r1
rsq r0.w, r0.w
rsq r1.w, r1.w
mul o6.xyz, r0.w, r1
rsq r0.z, r0.z
mad o5.xy, r0, c19.x, c19.y
mul r0.xyz, r0.z, r4
mul r2.xyz, r1.w, c14
mul r0.xyz, r2, r0
dp3_sat r0.w, r0, c18.w
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.w, r0, c19.z
mul r0.y, r0.w, c15.w
mul_sat r0.z, r0.y, c19.w
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r0.y, c17.x
mul_sat r0.x, r0, c16
add r1.xyz, c15, r0.y
mad_sat o7.xyz, r1, r0.z, c12
mul o1.w, v1, r0.x
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Vector 80 [_LightColor0] 4
Float 132 [_DistFade]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 80 instructions, 5 temp regs, 0 temp arrays:
// ALU 61 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedobpjjkiikjcokmafnfaainmnjmgcekaaabaaaaaabaanaaaaadaaaaaa
cmaaaaaanmaaaaaapiabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
beabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaakabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaakabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaakabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaakabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaakabaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaakabaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaakabaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahapaaaaakabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaahapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcbaalaaaa
eaaaabaameacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaeaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
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
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
eiobhkdpeiobhkdpeiobhkdpaaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaa
aiaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_modelview0 * tmpvar_11);
  vec4 v_13;
  v_13.x = glstate_matrix_modelview0[0].z;
  v_13.y = glstate_matrix_modelview0[1].z;
  v_13.z = glstate_matrix_modelview0[2].z;
  v_13.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(v_13.xyz);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = _glesVertex.w;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.z = 0.0;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = tmpvar_16.y;
  tmpvar_17.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_17.zyw;
  XZv_5.yzw = tmpvar_17.zyw;
  XYv_4.yzw = tmpvar_17.yzw;
  ZYv_6.z = (tmpvar_16.x * sign(-(tmpvar_14.x)));
  XZv_5.x = (tmpvar_16.x * sign(-(tmpvar_14.y)));
  XYv_4.x = (tmpvar_16.x * sign(tmpvar_14.z));
  ZYv_6.x = ((sign(-(tmpvar_14.x)) * sign(ZYv_6.z)) * tmpvar_14.z);
  XZv_5.y = ((sign(-(tmpvar_14.y)) * sign(XZv_5.x)) * tmpvar_14.x);
  XYv_4.z = ((sign(-(tmpvar_14.z)) * sign(XYv_4.x)) * tmpvar_14.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_14.x)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_14.y)) * sign(tmpvar_16.y)) * tmpvar_14.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_14.z)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (normalize((_Object2World * tmpvar_18).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_22)), 0.0, 1.0);
  tmpvar_8 = tmpvar_23;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_24;
  p_24 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_25);
  gl_Position = (glstate_matrix_projection * (tmpvar_12 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_12.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_12.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_12.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_modelview0 * tmpvar_11);
  vec4 v_13;
  v_13.x = glstate_matrix_modelview0[0].z;
  v_13.y = glstate_matrix_modelview0[1].z;
  v_13.z = glstate_matrix_modelview0[2].z;
  v_13.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(v_13.xyz);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = _glesVertex.w;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.z = 0.0;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = tmpvar_16.y;
  tmpvar_17.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_17.zyw;
  XZv_5.yzw = tmpvar_17.zyw;
  XYv_4.yzw = tmpvar_17.yzw;
  ZYv_6.z = (tmpvar_16.x * sign(-(tmpvar_14.x)));
  XZv_5.x = (tmpvar_16.x * sign(-(tmpvar_14.y)));
  XYv_4.x = (tmpvar_16.x * sign(tmpvar_14.z));
  ZYv_6.x = ((sign(-(tmpvar_14.x)) * sign(ZYv_6.z)) * tmpvar_14.z);
  XZv_5.y = ((sign(-(tmpvar_14.y)) * sign(XZv_5.x)) * tmpvar_14.x);
  XYv_4.z = ((sign(-(tmpvar_14.z)) * sign(XYv_4.x)) * tmpvar_14.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_14.x)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_14.y)) * sign(tmpvar_16.y)) * tmpvar_14.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_14.z)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (normalize((_Object2World * tmpvar_18).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_22)), 0.0, 1.0);
  tmpvar_8 = tmpvar_23;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_24;
  p_24 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_25);
  gl_Position = (glstate_matrix_projection * (tmpvar_12 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_12.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_12.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_12.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
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
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 426
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 417
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 416
uniform highp float _MinLight;
#line 440
uniform highp vec4 _TopTex_ST;
#line 481
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
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 472
    mediump vec3 lightDirection = vec3( (0.98 * normalize(_WorldSpaceLightPos0)));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 476
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out mediump vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval.baseLight);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec3(xl_retval._ShadowCoord);
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
    mediump vec3 baseLight;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 417
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 416
uniform highp float _MinLight;
#line 440
uniform highp vec4 _TopTex_ST;
#line 481
uniform sampler2D _CameraDepthTexture;
#line 482
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    #line 485
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    #line 489
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    #line 493
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in mediump vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
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
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec3(xlv_TEXCOORD6);
    xlt_i._ShadowCoord = vec3(xlv_TEXCOORD7);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 6 [_WorldSpaceCameraPos]
Vector 7 [_WorldSpaceLightPos0]
Matrix 9 [_Object2World]
Vector 8 [_LightColor0]
Float 17 [_DistFade]
Float 18 [_MinLight]
"3.0-!!ARBvp1.0
# 118 ALU
PARAM c[21] = { { 0, 1, 2, 0.60000002 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..12],
		state.matrix.projection,
		program.local[17..18],
		{ 0.5, 0.98000002, 0.010002136 },
		{ 4.0394478, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R2.x, c[4], c[4];
RSQ R2.x, R2.x;
MUL R3.xyz, R2.x, c[4];
MOV R1.xyz, c[0].x;
MOV R1.w, vertex.position;
DP4 R4.x, R1, c[2];
DP4 R4.y, R1, c[3];
DP4 R4.w, R1, c[5];
DP4 R4.z, R1, c[4];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[16];
DP4 result.position.z, R0, c[15];
DP4 result.position.y, R0, c[14];
DP4 result.position.x, R0, c[13];
MUL R0.zw, vertex.texcoord[0].xyxy, c[0].z;
SLT R0.x, c[0], -R3;
SLT R0.y, -R3.x, c[0].x;
ADD R2.x, R0, -R0.y;
ADD R0.xy, R0.zwzw, -c[0].y;
MUL R2.z, R0.x, R2.x;
SLT R2.y, R2.z, c[0].x;
SLT R0.w, R0, c[0].y;
SLT R0.z, c[0].x, R0.y;
ADD R0.z, R0, -R0.w;
SLT R0.w, c[0].x, R2.z;
ADD R0.w, R0, -R2.y;
MUL R2.w, R2.x, R0.z;
MUL R0.w, R0, R2.x;
MUL R2.y, R3, R2.w;
MAD R2.x, R3.z, R0.w, R2.y;
MOV R0.w, vertex.position;
MOV R2.yw, R0;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
SLT R2.w, -R3.y, c[0].x;
SLT R2.z, c[0].x, -R3.y;
ADD R3.w, R2.z, -R2;
MUL R2.zw, R2.xyxy, c[0].w;
MUL R2.x, R0, R3.w;
ADD result.texcoord[1].xy, R2.zwzw, c[19].x;
SLT R2.z, R2.x, c[0].x;
SLT R2.y, c[0].x, R2.x;
ADD R2.y, R2, -R2.z;
MUL R2.z, R0, R3.w;
MUL R2.y, R2, R3.w;
MUL R3.w, R3.z, R2.z;
MOV R2.zw, R0.xyyw;
MAD R2.y, R3.x, R2, R3.w;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
MUL R2.xy, R2, c[0].w;
SLT R2.w, R3.z, c[0].x;
SLT R2.z, c[0].x, R3;
ADD R3.w, R2.z, -R2;
MUL R0.x, R0, R3.w;
SLT R2.w, -R3.z, c[0].x;
SLT R2.z, c[0].x, -R3;
ADD R2.z, R2, -R2.w;
MUL R3.w, R0.z, R2.z;
SLT R2.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R2.w;
MUL R2.w, R3.y, R3;
MUL R0.z, R2, R0;
MAD R0.z, R3.x, R0, R2.w;
DP4 R2.z, R0, c[2];
DP4 R2.w, R0, c[3];
ADD R0.xy, -R4, R2.zwzw;
MUL R4.xy, R0, c[0].w;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
ADD result.texcoord[2].xy, R2, c[19].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
DP3 R0.y, R2, R2;
RSQ R0.y, R0.y;
DP4 R0.x, c[7], c[7];
MUL R2.xyz, R0.y, R2;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, c[7];
MUL R0.xyz, R0, R2;
DP3 R0.w, R0, c[19].y;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MIN R1.x, R0.w, c[0].y;
ADD R0.xyz, -R0, c[6];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL result.texcoord[4].xyz, R0.w, R0;
MAX R1.x, R1, c[0];
ADD R1.x, R1, -c[19].z;
MUL R0.w, R1.x, c[8];
MOV R1.xyz, c[8];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[6];
DP3 R0.x, R0, R0;
MUL R0.w, R0, c[20].x;
MIN R0.y, R0.w, c[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[17];
MIN R0.x, R0, c[0].y;
MAX R0.x, R0, c[0];
MAX R0.y, R0, c[0].x;
ADD R1.xyz, R1, c[18].x;
MAD R1.xyz, R1, R0.y, c[1];
MIN R1.xyz, R1, c[0].y;
ADD result.texcoord[3].xy, R4, c[19].x;
MAX result.texcoord[5].xyz, R1, c[0].x;
MUL result.color.w, vertex.color, R0.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 118 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 15 [_LightColor0]
Float 16 [_DistFade]
Float 17 [_MinLight]
"vs_3_0
; 104 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c18, 0.00000000, 2.00000000, -1.00000000, 0.98000002
def c19, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mad r1.xy, v3, c18.y, c18.z
mov r2.xyz, c18.x
mov r2.w, v0
dp4 r5.x, r2, c0
dp4 r5.y, r2, c1
dp4 r5.w, r2, c3
dp4 r5.z, r2, c2
add r0, r5, v0
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r1.y, -r1.y
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r1, r1
sub r1.z, r0.y, r0
mul r0.z, r1.x, r0.x
mul r1.w, r0.x, r1.z
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r1.w, v0
mov r0.yw, r1
dp4 r4.y, r0, c1
slt r4.x, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.x
dp4 r4.x, r0, c0
mul r0.x, r1, r3.w
add r4.xy, -r5, r4
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r5, r4.zwzw
mad o4.xy, r0, c19.x, c19.y
slt r0.y, -r3.z, r3.z
slt r0.x, r3.z, -r3.z
sub r0.z, r0.y, r0.x
mul r1.x, r1, r0.z
sub r0.x, r0, r0.y
mul r0.w, r1.z, r0.x
slt r0.z, r1.x, -r1.x
slt r0.y, -r1.x, r1.x
sub r0.y, r0, r0.z
mul r0.z, r3.y, r0.w
mul r0.x, r0, r0.y
mad r1.z, r3.x, r0.x, r0
mov r0.xyz, v2
mov r0.w, c18.x
mad o3.xy, r4, c19.x, c19.y
dp4 r4.z, r0, c10
dp4 r4.x, r0, c8
dp4 r4.y, r0, c9
dp3 r0.z, r4, r4
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r5, r0
dp4 r1.w, c14, c14
dp4 r1.z, r2, c10
dp4 r1.x, r2, c8
dp4 r1.y, r2, c9
add r1.xyz, -r1, c13
dp3 r0.w, r1, r1
rsq r0.w, r0.w
rsq r1.w, r1.w
mul o6.xyz, r0.w, r1
rsq r0.z, r0.z
mad o5.xy, r0, c19.x, c19.y
mul r0.xyz, r0.z, r4
mul r2.xyz, r1.w, c14
mul r0.xyz, r2, r0
dp3_sat r0.w, r0, c18.w
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.w, r0, c19.z
mul r0.y, r0.w, c15.w
mul_sat r0.z, r0.y, c19.w
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r0.y, c17.x
mul_sat r0.x, r0, c16
add r1.xyz, c15, r0.y
mad_sat o7.xyz, r1, r0.z, c12
mul o1.w, v1, r0.x
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Vector 80 [_LightColor0] 4
Float 132 [_DistFade]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 80 instructions, 5 temp regs, 0 temp arrays:
// ALU 61 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedobpjjkiikjcokmafnfaainmnjmgcekaaabaaaaaabaanaaaaadaaaaaa
cmaaaaaanmaaaaaapiabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
beabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaakabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaakabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaakabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaakabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaakabaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaakabaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaakabaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahapaaaaakabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaahapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcbaalaaaa
eaaaabaameacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaeaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
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
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
eiobhkdpeiobhkdpeiobhkdpaaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaa
aiaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_modelview0 * tmpvar_11);
  vec4 v_13;
  v_13.x = glstate_matrix_modelview0[0].z;
  v_13.y = glstate_matrix_modelview0[1].z;
  v_13.z = glstate_matrix_modelview0[2].z;
  v_13.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(v_13.xyz);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = _glesVertex.w;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.z = 0.0;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = tmpvar_16.y;
  tmpvar_17.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_17.zyw;
  XZv_5.yzw = tmpvar_17.zyw;
  XYv_4.yzw = tmpvar_17.yzw;
  ZYv_6.z = (tmpvar_16.x * sign(-(tmpvar_14.x)));
  XZv_5.x = (tmpvar_16.x * sign(-(tmpvar_14.y)));
  XYv_4.x = (tmpvar_16.x * sign(tmpvar_14.z));
  ZYv_6.x = ((sign(-(tmpvar_14.x)) * sign(ZYv_6.z)) * tmpvar_14.z);
  XZv_5.y = ((sign(-(tmpvar_14.y)) * sign(XZv_5.x)) * tmpvar_14.x);
  XYv_4.z = ((sign(-(tmpvar_14.z)) * sign(XYv_4.x)) * tmpvar_14.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_14.x)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_14.y)) * sign(tmpvar_16.y)) * tmpvar_14.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_14.z)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (normalize((_Object2World * tmpvar_18).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_22)), 0.0, 1.0);
  tmpvar_8 = tmpvar_23;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_24;
  p_24 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_25);
  gl_Position = (glstate_matrix_projection * (tmpvar_12 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_12.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_12.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_12.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_modelview0 * tmpvar_11);
  vec4 v_13;
  v_13.x = glstate_matrix_modelview0[0].z;
  v_13.y = glstate_matrix_modelview0[1].z;
  v_13.z = glstate_matrix_modelview0[2].z;
  v_13.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(v_13.xyz);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = _glesVertex.w;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.z = 0.0;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = tmpvar_16.y;
  tmpvar_17.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_17.zyw;
  XZv_5.yzw = tmpvar_17.zyw;
  XYv_4.yzw = tmpvar_17.yzw;
  ZYv_6.z = (tmpvar_16.x * sign(-(tmpvar_14.x)));
  XZv_5.x = (tmpvar_16.x * sign(-(tmpvar_14.y)));
  XYv_4.x = (tmpvar_16.x * sign(tmpvar_14.z));
  ZYv_6.x = ((sign(-(tmpvar_14.x)) * sign(ZYv_6.z)) * tmpvar_14.z);
  XZv_5.y = ((sign(-(tmpvar_14.y)) * sign(XZv_5.x)) * tmpvar_14.x);
  XYv_4.z = ((sign(-(tmpvar_14.z)) * sign(XYv_4.x)) * tmpvar_14.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_14.x)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_14.y)) * sign(tmpvar_16.y)) * tmpvar_14.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_14.z)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (normalize((_Object2World * tmpvar_18).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_22)), 0.0, 1.0);
  tmpvar_8 = tmpvar_23;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_24;
  p_24 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_25);
  gl_Position = (glstate_matrix_projection * (tmpvar_12 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_12.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_12.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_12.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
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
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 427
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 418
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 417
uniform highp float _MinLight;
#line 441
uniform highp vec4 _TopTex_ST;
#line 482
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
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 473
    mediump vec3 lightDirection = vec3( (0.98 * normalize(_WorldSpaceLightPos0)));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 477
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out mediump vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval.baseLight);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec3(xl_retval._ShadowCoord);
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
    mediump vec3 baseLight;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 418
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 417
uniform highp float _MinLight;
#line 441
uniform highp vec4 _TopTex_ST;
#line 482
uniform sampler2D _CameraDepthTexture;
#line 483
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    #line 486
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    #line 490
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    #line 494
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in mediump vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
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
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec3(xlv_TEXCOORD6);
    xlt_i._ShadowCoord = vec3(xlv_TEXCOORD7);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 6 [_WorldSpaceCameraPos]
Vector 7 [_WorldSpaceLightPos0]
Matrix 9 [_Object2World]
Vector 8 [_LightColor0]
Float 17 [_DistFade]
Float 18 [_MinLight]
"3.0-!!ARBvp1.0
# 118 ALU
PARAM c[21] = { { 0, 1, 2, 0.60000002 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..12],
		state.matrix.projection,
		program.local[17..18],
		{ 0.5, 0.98000002, 0.010002136 },
		{ 4.0394478, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R2.x, c[4], c[4];
RSQ R2.x, R2.x;
MUL R3.xyz, R2.x, c[4];
MOV R1.xyz, c[0].x;
MOV R1.w, vertex.position;
DP4 R4.x, R1, c[2];
DP4 R4.y, R1, c[3];
DP4 R4.w, R1, c[5];
DP4 R4.z, R1, c[4];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[16];
DP4 result.position.z, R0, c[15];
DP4 result.position.y, R0, c[14];
DP4 result.position.x, R0, c[13];
MUL R0.zw, vertex.texcoord[0].xyxy, c[0].z;
SLT R0.x, c[0], -R3;
SLT R0.y, -R3.x, c[0].x;
ADD R2.x, R0, -R0.y;
ADD R0.xy, R0.zwzw, -c[0].y;
MUL R2.z, R0.x, R2.x;
SLT R2.y, R2.z, c[0].x;
SLT R0.w, R0, c[0].y;
SLT R0.z, c[0].x, R0.y;
ADD R0.z, R0, -R0.w;
SLT R0.w, c[0].x, R2.z;
ADD R0.w, R0, -R2.y;
MUL R2.w, R2.x, R0.z;
MUL R0.w, R0, R2.x;
MUL R2.y, R3, R2.w;
MAD R2.x, R3.z, R0.w, R2.y;
MOV R0.w, vertex.position;
MOV R2.yw, R0;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
SLT R2.w, -R3.y, c[0].x;
SLT R2.z, c[0].x, -R3.y;
ADD R3.w, R2.z, -R2;
MUL R2.zw, R2.xyxy, c[0].w;
MUL R2.x, R0, R3.w;
ADD result.texcoord[1].xy, R2.zwzw, c[19].x;
SLT R2.z, R2.x, c[0].x;
SLT R2.y, c[0].x, R2.x;
ADD R2.y, R2, -R2.z;
MUL R2.z, R0, R3.w;
MUL R2.y, R2, R3.w;
MUL R3.w, R3.z, R2.z;
MOV R2.zw, R0.xyyw;
MAD R2.y, R3.x, R2, R3.w;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
MUL R2.xy, R2, c[0].w;
SLT R2.w, R3.z, c[0].x;
SLT R2.z, c[0].x, R3;
ADD R3.w, R2.z, -R2;
MUL R0.x, R0, R3.w;
SLT R2.w, -R3.z, c[0].x;
SLT R2.z, c[0].x, -R3;
ADD R2.z, R2, -R2.w;
MUL R3.w, R0.z, R2.z;
SLT R2.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R2.w;
MUL R2.w, R3.y, R3;
MUL R0.z, R2, R0;
MAD R0.z, R3.x, R0, R2.w;
DP4 R2.z, R0, c[2];
DP4 R2.w, R0, c[3];
ADD R0.xy, -R4, R2.zwzw;
MUL R4.xy, R0, c[0].w;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
ADD result.texcoord[2].xy, R2, c[19].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
DP3 R0.y, R2, R2;
RSQ R0.y, R0.y;
DP4 R0.x, c[7], c[7];
MUL R2.xyz, R0.y, R2;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, c[7];
MUL R0.xyz, R0, R2;
DP3 R0.w, R0, c[19].y;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MIN R1.x, R0.w, c[0].y;
ADD R0.xyz, -R0, c[6];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL result.texcoord[4].xyz, R0.w, R0;
MAX R1.x, R1, c[0];
ADD R1.x, R1, -c[19].z;
MUL R0.w, R1.x, c[8];
MOV R1.xyz, c[8];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[6];
DP3 R0.x, R0, R0;
MUL R0.w, R0, c[20].x;
MIN R0.y, R0.w, c[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[17];
MIN R0.x, R0, c[0].y;
MAX R0.x, R0, c[0];
MAX R0.y, R0, c[0].x;
ADD R1.xyz, R1, c[18].x;
MAD R1.xyz, R1, R0.y, c[1];
MIN R1.xyz, R1, c[0].y;
ADD result.texcoord[3].xy, R4, c[19].x;
MAX result.texcoord[5].xyz, R1, c[0].x;
MUL result.color.w, vertex.color, R0.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 118 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 15 [_LightColor0]
Float 16 [_DistFade]
Float 17 [_MinLight]
"vs_3_0
; 104 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c18, 0.00000000, 2.00000000, -1.00000000, 0.98000002
def c19, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mad r1.xy, v3, c18.y, c18.z
mov r2.xyz, c18.x
mov r2.w, v0
dp4 r5.x, r2, c0
dp4 r5.y, r2, c1
dp4 r5.w, r2, c3
dp4 r5.z, r2, c2
add r0, r5, v0
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r1.y, -r1.y
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r1, r1
sub r1.z, r0.y, r0
mul r0.z, r1.x, r0.x
mul r1.w, r0.x, r1.z
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r1.w, v0
mov r0.yw, r1
dp4 r4.y, r0, c1
slt r4.x, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.x
dp4 r4.x, r0, c0
mul r0.x, r1, r3.w
add r4.xy, -r5, r4
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r5, r4.zwzw
mad o4.xy, r0, c19.x, c19.y
slt r0.y, -r3.z, r3.z
slt r0.x, r3.z, -r3.z
sub r0.z, r0.y, r0.x
mul r1.x, r1, r0.z
sub r0.x, r0, r0.y
mul r0.w, r1.z, r0.x
slt r0.z, r1.x, -r1.x
slt r0.y, -r1.x, r1.x
sub r0.y, r0, r0.z
mul r0.z, r3.y, r0.w
mul r0.x, r0, r0.y
mad r1.z, r3.x, r0.x, r0
mov r0.xyz, v2
mov r0.w, c18.x
mad o3.xy, r4, c19.x, c19.y
dp4 r4.z, r0, c10
dp4 r4.x, r0, c8
dp4 r4.y, r0, c9
dp3 r0.z, r4, r4
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r5, r0
dp4 r1.w, c14, c14
dp4 r1.z, r2, c10
dp4 r1.x, r2, c8
dp4 r1.y, r2, c9
add r1.xyz, -r1, c13
dp3 r0.w, r1, r1
rsq r0.w, r0.w
rsq r1.w, r1.w
mul o6.xyz, r0.w, r1
rsq r0.z, r0.z
mad o5.xy, r0, c19.x, c19.y
mul r0.xyz, r0.z, r4
mul r2.xyz, r1.w, c14
mul r0.xyz, r2, r0
dp3_sat r0.w, r0, c18.w
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.w, r0, c19.z
mul r0.y, r0.w, c15.w
mul_sat r0.z, r0.y, c19.w
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r0.y, c17.x
mul_sat r0.x, r0, c16
add r1.xyz, c15, r0.y
mad_sat o7.xyz, r1, r0.z, c12
mul o1.w, v1, r0.x
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 224 // 208 used size, 11 vars
Vector 144 [_LightColor0] 4
Float 196 [_DistFade]
Float 204 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 80 instructions, 5 temp regs, 0 temp arrays:
// ALU 61 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmgikbbmpphclokekjneoblfjjapggemlabaaaaaabaanaaaaadaaaaaa
cmaaaaaanmaaaaaapiabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
beabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaakabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaakabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaakabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaakabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaakabaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaakabaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaakabaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apapaaaaakabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcbaalaaaa
eaaaabaameacaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaeaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaamaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
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
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
eiobhkdpeiobhkdpeiobhkdpaaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
ajaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaajaaaaaapgipcaaaaaaaaaaa
amaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_modelview0 * tmpvar_11);
  vec4 v_13;
  v_13.x = glstate_matrix_modelview0[0].z;
  v_13.y = glstate_matrix_modelview0[1].z;
  v_13.z = glstate_matrix_modelview0[2].z;
  v_13.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(v_13.xyz);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = _glesVertex.w;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.z = 0.0;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = tmpvar_16.y;
  tmpvar_17.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_17.zyw;
  XZv_5.yzw = tmpvar_17.zyw;
  XYv_4.yzw = tmpvar_17.yzw;
  ZYv_6.z = (tmpvar_16.x * sign(-(tmpvar_14.x)));
  XZv_5.x = (tmpvar_16.x * sign(-(tmpvar_14.y)));
  XYv_4.x = (tmpvar_16.x * sign(tmpvar_14.z));
  ZYv_6.x = ((sign(-(tmpvar_14.x)) * sign(ZYv_6.z)) * tmpvar_14.z);
  XZv_5.y = ((sign(-(tmpvar_14.y)) * sign(XZv_5.x)) * tmpvar_14.x);
  XYv_4.z = ((sign(-(tmpvar_14.z)) * sign(XYv_4.x)) * tmpvar_14.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_14.x)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_14.y)) * sign(tmpvar_16.y)) * tmpvar_14.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_14.z)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (normalize((_Object2World * tmpvar_18).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_22)), 0.0, 1.0);
  tmpvar_8 = tmpvar_23;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_24;
  p_24 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_25);
  gl_Position = (glstate_matrix_projection * (tmpvar_12 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_12.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_12.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_12.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_modelview0 * tmpvar_11);
  vec4 v_13;
  v_13.x = glstate_matrix_modelview0[0].z;
  v_13.y = glstate_matrix_modelview0[1].z;
  v_13.z = glstate_matrix_modelview0[2].z;
  v_13.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(v_13.xyz);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = _glesVertex.w;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.z = 0.0;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = tmpvar_16.y;
  tmpvar_17.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_17.zyw;
  XZv_5.yzw = tmpvar_17.zyw;
  XYv_4.yzw = tmpvar_17.yzw;
  ZYv_6.z = (tmpvar_16.x * sign(-(tmpvar_14.x)));
  XZv_5.x = (tmpvar_16.x * sign(-(tmpvar_14.y)));
  XYv_4.x = (tmpvar_16.x * sign(tmpvar_14.z));
  ZYv_6.x = ((sign(-(tmpvar_14.x)) * sign(ZYv_6.z)) * tmpvar_14.z);
  XZv_5.y = ((sign(-(tmpvar_14.y)) * sign(XZv_5.x)) * tmpvar_14.x);
  XYv_4.z = ((sign(-(tmpvar_14.z)) * sign(XYv_4.x)) * tmpvar_14.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_14.x)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_14.y)) * sign(tmpvar_16.y)) * tmpvar_14.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_14.z)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (normalize((_Object2World * tmpvar_18).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_22)), 0.0, 1.0);
  tmpvar_8 = tmpvar_23;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_24;
  p_24 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_25);
  gl_Position = (glstate_matrix_projection * (tmpvar_12 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_12.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_12.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_12.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
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
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 436
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 427
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 426
uniform highp float _MinLight;
#line 450
uniform highp vec4 _TopTex_ST;
#line 491
uniform sampler2D _CameraDepthTexture;
#line 451
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 454
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 458
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 462
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 466
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 470
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 474
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 478
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 482
    mediump vec3 lightDirection = vec3( (0.98 * normalize(_WorldSpaceLightPos0)));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 486
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out mediump vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval.baseLight);
    xlv_TEXCOORD6 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
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
#line 340
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 436
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 427
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 426
uniform highp float _MinLight;
#line 450
uniform highp vec4 _TopTex_ST;
#line 491
uniform sampler2D _CameraDepthTexture;
#line 492
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    #line 495
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    #line 499
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    #line 503
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in mediump vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
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
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec4(xlv_TEXCOORD6);
    xlt_i._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 6 [_WorldSpaceCameraPos]
Vector 7 [_WorldSpaceLightPos0]
Matrix 9 [_Object2World]
Vector 8 [_LightColor0]
Float 17 [_DistFade]
Float 18 [_MinLight]
"3.0-!!ARBvp1.0
# 118 ALU
PARAM c[21] = { { 0, 1, 2, 0.60000002 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..12],
		state.matrix.projection,
		program.local[17..18],
		{ 0.5, 0.98000002, 0.010002136 },
		{ 4.0394478, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R2.x, c[4], c[4];
RSQ R2.x, R2.x;
MUL R3.xyz, R2.x, c[4];
MOV R1.xyz, c[0].x;
MOV R1.w, vertex.position;
DP4 R4.x, R1, c[2];
DP4 R4.y, R1, c[3];
DP4 R4.w, R1, c[5];
DP4 R4.z, R1, c[4];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[16];
DP4 result.position.z, R0, c[15];
DP4 result.position.y, R0, c[14];
DP4 result.position.x, R0, c[13];
MUL R0.zw, vertex.texcoord[0].xyxy, c[0].z;
SLT R0.x, c[0], -R3;
SLT R0.y, -R3.x, c[0].x;
ADD R2.x, R0, -R0.y;
ADD R0.xy, R0.zwzw, -c[0].y;
MUL R2.z, R0.x, R2.x;
SLT R2.y, R2.z, c[0].x;
SLT R0.w, R0, c[0].y;
SLT R0.z, c[0].x, R0.y;
ADD R0.z, R0, -R0.w;
SLT R0.w, c[0].x, R2.z;
ADD R0.w, R0, -R2.y;
MUL R2.w, R2.x, R0.z;
MUL R0.w, R0, R2.x;
MUL R2.y, R3, R2.w;
MAD R2.x, R3.z, R0.w, R2.y;
MOV R0.w, vertex.position;
MOV R2.yw, R0;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
SLT R2.w, -R3.y, c[0].x;
SLT R2.z, c[0].x, -R3.y;
ADD R3.w, R2.z, -R2;
MUL R2.zw, R2.xyxy, c[0].w;
MUL R2.x, R0, R3.w;
ADD result.texcoord[1].xy, R2.zwzw, c[19].x;
SLT R2.z, R2.x, c[0].x;
SLT R2.y, c[0].x, R2.x;
ADD R2.y, R2, -R2.z;
MUL R2.z, R0, R3.w;
MUL R2.y, R2, R3.w;
MUL R3.w, R3.z, R2.z;
MOV R2.zw, R0.xyyw;
MAD R2.y, R3.x, R2, R3.w;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
MUL R2.xy, R2, c[0].w;
SLT R2.w, R3.z, c[0].x;
SLT R2.z, c[0].x, R3;
ADD R3.w, R2.z, -R2;
MUL R0.x, R0, R3.w;
SLT R2.w, -R3.z, c[0].x;
SLT R2.z, c[0].x, -R3;
ADD R2.z, R2, -R2.w;
MUL R3.w, R0.z, R2.z;
SLT R2.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R2.w;
MUL R2.w, R3.y, R3;
MUL R0.z, R2, R0;
MAD R0.z, R3.x, R0, R2.w;
DP4 R2.z, R0, c[2];
DP4 R2.w, R0, c[3];
ADD R0.xy, -R4, R2.zwzw;
MUL R4.xy, R0, c[0].w;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
ADD result.texcoord[2].xy, R2, c[19].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
DP3 R0.y, R2, R2;
RSQ R0.y, R0.y;
DP4 R0.x, c[7], c[7];
MUL R2.xyz, R0.y, R2;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, c[7];
MUL R0.xyz, R0, R2;
DP3 R0.w, R0, c[19].y;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MIN R1.x, R0.w, c[0].y;
ADD R0.xyz, -R0, c[6];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL result.texcoord[4].xyz, R0.w, R0;
MAX R1.x, R1, c[0];
ADD R1.x, R1, -c[19].z;
MUL R0.w, R1.x, c[8];
MOV R1.xyz, c[8];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[6];
DP3 R0.x, R0, R0;
MUL R0.w, R0, c[20].x;
MIN R0.y, R0.w, c[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[17];
MIN R0.x, R0, c[0].y;
MAX R0.x, R0, c[0];
MAX R0.y, R0, c[0].x;
ADD R1.xyz, R1, c[18].x;
MAD R1.xyz, R1, R0.y, c[1];
MIN R1.xyz, R1, c[0].y;
ADD result.texcoord[3].xy, R4, c[19].x;
MAX result.texcoord[5].xyz, R1, c[0].x;
MUL result.color.w, vertex.color, R0.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 118 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 15 [_LightColor0]
Float 16 [_DistFade]
Float 17 [_MinLight]
"vs_3_0
; 104 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c18, 0.00000000, 2.00000000, -1.00000000, 0.98000002
def c19, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mad r1.xy, v3, c18.y, c18.z
mov r2.xyz, c18.x
mov r2.w, v0
dp4 r5.x, r2, c0
dp4 r5.y, r2, c1
dp4 r5.w, r2, c3
dp4 r5.z, r2, c2
add r0, r5, v0
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r1.y, -r1.y
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r1, r1
sub r1.z, r0.y, r0
mul r0.z, r1.x, r0.x
mul r1.w, r0.x, r1.z
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r1.w, v0
mov r0.yw, r1
dp4 r4.y, r0, c1
slt r4.x, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.x
dp4 r4.x, r0, c0
mul r0.x, r1, r3.w
add r4.xy, -r5, r4
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r5, r4.zwzw
mad o4.xy, r0, c19.x, c19.y
slt r0.y, -r3.z, r3.z
slt r0.x, r3.z, -r3.z
sub r0.z, r0.y, r0.x
mul r1.x, r1, r0.z
sub r0.x, r0, r0.y
mul r0.w, r1.z, r0.x
slt r0.z, r1.x, -r1.x
slt r0.y, -r1.x, r1.x
sub r0.y, r0, r0.z
mul r0.z, r3.y, r0.w
mul r0.x, r0, r0.y
mad r1.z, r3.x, r0.x, r0
mov r0.xyz, v2
mov r0.w, c18.x
mad o3.xy, r4, c19.x, c19.y
dp4 r4.z, r0, c10
dp4 r4.x, r0, c8
dp4 r4.y, r0, c9
dp3 r0.z, r4, r4
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r5, r0
dp4 r1.w, c14, c14
dp4 r1.z, r2, c10
dp4 r1.x, r2, c8
dp4 r1.y, r2, c9
add r1.xyz, -r1, c13
dp3 r0.w, r1, r1
rsq r0.w, r0.w
rsq r1.w, r1.w
mul o6.xyz, r0.w, r1
rsq r0.z, r0.z
mad o5.xy, r0, c19.x, c19.y
mul r0.xyz, r0.z, r4
mul r2.xyz, r1.w, c14
mul r0.xyz, r2, r0
dp3_sat r0.w, r0, c18.w
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.w, r0, c19.z
mul r0.y, r0.w, c15.w
mul_sat r0.z, r0.y, c19.w
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r0.y, c17.x
mul_sat r0.x, r0, c16
add r1.xyz, c15, r0.y
mad_sat o7.xyz, r1, r0.z, c12
mul o1.w, v1, r0.x
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 224 // 208 used size, 11 vars
Vector 144 [_LightColor0] 4
Float 196 [_DistFade]
Float 204 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 80 instructions, 5 temp regs, 0 temp arrays:
// ALU 61 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmgikbbmpphclokekjneoblfjjapggemlabaaaaaabaanaaaaadaaaaaa
cmaaaaaanmaaaaaapiabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
beabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaakabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaakabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaakabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaakabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaakabaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaakabaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaakabaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apapaaaaakabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcbaalaaaa
eaaaabaameacaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaeaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaamaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
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
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
eiobhkdpeiobhkdpeiobhkdpaaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
ajaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaajaaaaaapgipcaaaaaaaaaaa
amaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_modelview0 * tmpvar_11);
  vec4 v_13;
  v_13.x = glstate_matrix_modelview0[0].z;
  v_13.y = glstate_matrix_modelview0[1].z;
  v_13.z = glstate_matrix_modelview0[2].z;
  v_13.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(v_13.xyz);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = _glesVertex.w;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.z = 0.0;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = tmpvar_16.y;
  tmpvar_17.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_17.zyw;
  XZv_5.yzw = tmpvar_17.zyw;
  XYv_4.yzw = tmpvar_17.yzw;
  ZYv_6.z = (tmpvar_16.x * sign(-(tmpvar_14.x)));
  XZv_5.x = (tmpvar_16.x * sign(-(tmpvar_14.y)));
  XYv_4.x = (tmpvar_16.x * sign(tmpvar_14.z));
  ZYv_6.x = ((sign(-(tmpvar_14.x)) * sign(ZYv_6.z)) * tmpvar_14.z);
  XZv_5.y = ((sign(-(tmpvar_14.y)) * sign(XZv_5.x)) * tmpvar_14.x);
  XYv_4.z = ((sign(-(tmpvar_14.z)) * sign(XYv_4.x)) * tmpvar_14.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_14.x)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_14.y)) * sign(tmpvar_16.y)) * tmpvar_14.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_14.z)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (normalize((_Object2World * tmpvar_18).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_22)), 0.0, 1.0);
  tmpvar_8 = tmpvar_23;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_24;
  p_24 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_25);
  gl_Position = (glstate_matrix_projection * (tmpvar_12 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_12.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_12.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_12.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
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
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 436
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 427
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 426
uniform highp float _MinLight;
#line 450
uniform highp vec4 _TopTex_ST;
#line 491
uniform sampler2D _CameraDepthTexture;
#line 451
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 454
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 458
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 462
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 466
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 470
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 474
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 478
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 482
    mediump vec3 lightDirection = vec3( (0.98 * normalize(_WorldSpaceLightPos0)));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 486
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out mediump vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval.baseLight);
    xlv_TEXCOORD6 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
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
#line 340
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 436
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
};
#line 427
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 426
uniform highp float _MinLight;
#line 450
uniform highp vec4 _TopTex_ST;
#line 491
uniform sampler2D _CameraDepthTexture;
#line 492
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    #line 495
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    #line 499
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    #line 503
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in mediump vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
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
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec4(xlv_TEXCOORD6);
    xlt_i._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 6 [_WorldSpaceCameraPos]
Vector 7 [_WorldSpaceLightPos0]
Matrix 9 [_Object2World]
Vector 8 [_LightColor0]
Float 17 [_DistFade]
Float 18 [_MinLight]
"3.0-!!ARBvp1.0
# 118 ALU
PARAM c[21] = { { 0, 1, 2, 0.60000002 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..12],
		state.matrix.projection,
		program.local[17..18],
		{ 0.5, 0.98000002, 0.010002136 },
		{ 4.0394478, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R2.x, c[4], c[4];
RSQ R2.x, R2.x;
MUL R3.xyz, R2.x, c[4];
MOV R1.xyz, c[0].x;
MOV R1.w, vertex.position;
DP4 R4.x, R1, c[2];
DP4 R4.y, R1, c[3];
DP4 R4.w, R1, c[5];
DP4 R4.z, R1, c[4];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[16];
DP4 result.position.z, R0, c[15];
DP4 result.position.y, R0, c[14];
DP4 result.position.x, R0, c[13];
MUL R0.zw, vertex.texcoord[0].xyxy, c[0].z;
SLT R0.x, c[0], -R3;
SLT R0.y, -R3.x, c[0].x;
ADD R2.x, R0, -R0.y;
ADD R0.xy, R0.zwzw, -c[0].y;
MUL R2.z, R0.x, R2.x;
SLT R2.y, R2.z, c[0].x;
SLT R0.w, R0, c[0].y;
SLT R0.z, c[0].x, R0.y;
ADD R0.z, R0, -R0.w;
SLT R0.w, c[0].x, R2.z;
ADD R0.w, R0, -R2.y;
MUL R2.w, R2.x, R0.z;
MUL R0.w, R0, R2.x;
MUL R2.y, R3, R2.w;
MAD R2.x, R3.z, R0.w, R2.y;
MOV R0.w, vertex.position;
MOV R2.yw, R0;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
SLT R2.w, -R3.y, c[0].x;
SLT R2.z, c[0].x, -R3.y;
ADD R3.w, R2.z, -R2;
MUL R2.zw, R2.xyxy, c[0].w;
MUL R2.x, R0, R3.w;
ADD result.texcoord[1].xy, R2.zwzw, c[19].x;
SLT R2.z, R2.x, c[0].x;
SLT R2.y, c[0].x, R2.x;
ADD R2.y, R2, -R2.z;
MUL R2.z, R0, R3.w;
MUL R2.y, R2, R3.w;
MUL R3.w, R3.z, R2.z;
MOV R2.zw, R0.xyyw;
MAD R2.y, R3.x, R2, R3.w;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
MUL R2.xy, R2, c[0].w;
SLT R2.w, R3.z, c[0].x;
SLT R2.z, c[0].x, R3;
ADD R3.w, R2.z, -R2;
MUL R0.x, R0, R3.w;
SLT R2.w, -R3.z, c[0].x;
SLT R2.z, c[0].x, -R3;
ADD R2.z, R2, -R2.w;
MUL R3.w, R0.z, R2.z;
SLT R2.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R2.w;
MUL R2.w, R3.y, R3;
MUL R0.z, R2, R0;
MAD R0.z, R3.x, R0, R2.w;
DP4 R2.z, R0, c[2];
DP4 R2.w, R0, c[3];
ADD R0.xy, -R4, R2.zwzw;
MUL R4.xy, R0, c[0].w;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
ADD result.texcoord[2].xy, R2, c[19].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
DP3 R0.y, R2, R2;
RSQ R0.y, R0.y;
DP4 R0.x, c[7], c[7];
MUL R2.xyz, R0.y, R2;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, c[7];
MUL R0.xyz, R0, R2;
DP3 R0.w, R0, c[19].y;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MIN R1.x, R0.w, c[0].y;
ADD R0.xyz, -R0, c[6];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL result.texcoord[4].xyz, R0.w, R0;
MAX R1.x, R1, c[0];
ADD R1.x, R1, -c[19].z;
MUL R0.w, R1.x, c[8];
MOV R1.xyz, c[8];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[6];
DP3 R0.x, R0, R0;
MUL R0.w, R0, c[20].x;
MIN R0.y, R0.w, c[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[17];
MIN R0.x, R0, c[0].y;
MAX R0.x, R0, c[0];
MAX R0.y, R0, c[0].x;
ADD R1.xyz, R1, c[18].x;
MAD R1.xyz, R1, R0.y, c[1];
MIN R1.xyz, R1, c[0].y;
ADD result.texcoord[3].xy, R4, c[19].x;
MAX result.texcoord[5].xyz, R1, c[0].x;
MUL result.color.w, vertex.color, R0.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 118 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 15 [_LightColor0]
Float 16 [_DistFade]
Float 17 [_MinLight]
"vs_3_0
; 104 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c18, 0.00000000, 2.00000000, -1.00000000, 0.98000002
def c19, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mad r1.xy, v3, c18.y, c18.z
mov r2.xyz, c18.x
mov r2.w, v0
dp4 r5.x, r2, c0
dp4 r5.y, r2, c1
dp4 r5.w, r2, c3
dp4 r5.z, r2, c2
add r0, r5, v0
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r1.y, -r1.y
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r1, r1
sub r1.z, r0.y, r0
mul r0.z, r1.x, r0.x
mul r1.w, r0.x, r1.z
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r1.w, v0
mov r0.yw, r1
dp4 r4.y, r0, c1
slt r4.x, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.x
dp4 r4.x, r0, c0
mul r0.x, r1, r3.w
add r4.xy, -r5, r4
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r5, r4.zwzw
mad o4.xy, r0, c19.x, c19.y
slt r0.y, -r3.z, r3.z
slt r0.x, r3.z, -r3.z
sub r0.z, r0.y, r0.x
mul r1.x, r1, r0.z
sub r0.x, r0, r0.y
mul r0.w, r1.z, r0.x
slt r0.z, r1.x, -r1.x
slt r0.y, -r1.x, r1.x
sub r0.y, r0, r0.z
mul r0.z, r3.y, r0.w
mul r0.x, r0, r0.y
mad r1.z, r3.x, r0.x, r0
mov r0.xyz, v2
mov r0.w, c18.x
mad o3.xy, r4, c19.x, c19.y
dp4 r4.z, r0, c10
dp4 r4.x, r0, c8
dp4 r4.y, r0, c9
dp3 r0.z, r4, r4
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r5, r0
dp4 r1.w, c14, c14
dp4 r1.z, r2, c10
dp4 r1.x, r2, c8
dp4 r1.y, r2, c9
add r1.xyz, -r1, c13
dp3 r0.w, r1, r1
rsq r0.w, r0.w
rsq r1.w, r1.w
mul o6.xyz, r0.w, r1
rsq r0.z, r0.z
mad o5.xy, r0, c19.x, c19.y
mul r0.xyz, r0.z, r4
mul r2.xyz, r1.w, c14
mul r0.xyz, r2, r0
dp3_sat r0.w, r0, c18.w
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.w, r0, c19.z
mul r0.y, r0.w, c15.w
mul_sat r0.z, r0.y, c19.w
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r0.y, c17.x
mul_sat r0.x, r0, c16
add r1.xyz, c15, r0.y
mad_sat o7.xyz, r1, r0.z, c12
mul o1.w, v1, r0.x
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Vector 80 [_LightColor0] 4
Float 132 [_DistFade]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 80 instructions, 5 temp regs, 0 temp arrays:
// ALU 61 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedobpjjkiikjcokmafnfaainmnjmgcekaaabaaaaaabaanaaaaadaaaaaa
cmaaaaaanmaaaaaapiabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
beabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaakabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaakabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaakabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaakabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaakabaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaakabaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaakabaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahapaaaaakabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaahapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcbaalaaaa
eaaaabaameacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaeaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
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
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
eiobhkdpeiobhkdpeiobhkdpaaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaa
aiaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_modelview0 * tmpvar_11);
  vec4 v_13;
  v_13.x = glstate_matrix_modelview0[0].z;
  v_13.y = glstate_matrix_modelview0[1].z;
  v_13.z = glstate_matrix_modelview0[2].z;
  v_13.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(v_13.xyz);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = _glesVertex.w;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.z = 0.0;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = tmpvar_16.y;
  tmpvar_17.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_17.zyw;
  XZv_5.yzw = tmpvar_17.zyw;
  XYv_4.yzw = tmpvar_17.yzw;
  ZYv_6.z = (tmpvar_16.x * sign(-(tmpvar_14.x)));
  XZv_5.x = (tmpvar_16.x * sign(-(tmpvar_14.y)));
  XYv_4.x = (tmpvar_16.x * sign(tmpvar_14.z));
  ZYv_6.x = ((sign(-(tmpvar_14.x)) * sign(ZYv_6.z)) * tmpvar_14.z);
  XZv_5.y = ((sign(-(tmpvar_14.y)) * sign(XZv_5.x)) * tmpvar_14.x);
  XYv_4.z = ((sign(-(tmpvar_14.z)) * sign(XYv_4.x)) * tmpvar_14.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_14.x)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_14.y)) * sign(tmpvar_16.y)) * tmpvar_14.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_14.z)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (normalize((_Object2World * tmpvar_18).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_22)), 0.0, 1.0);
  tmpvar_8 = tmpvar_23;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_24;
  p_24 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_25);
  gl_Position = (glstate_matrix_projection * (tmpvar_12 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_12.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_12.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_12.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_modelview0 * tmpvar_11);
  vec4 v_13;
  v_13.x = glstate_matrix_modelview0[0].z;
  v_13.y = glstate_matrix_modelview0[1].z;
  v_13.z = glstate_matrix_modelview0[2].z;
  v_13.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(v_13.xyz);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = _glesVertex.w;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.z = 0.0;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = tmpvar_16.y;
  tmpvar_17.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_17.zyw;
  XZv_5.yzw = tmpvar_17.zyw;
  XYv_4.yzw = tmpvar_17.yzw;
  ZYv_6.z = (tmpvar_16.x * sign(-(tmpvar_14.x)));
  XZv_5.x = (tmpvar_16.x * sign(-(tmpvar_14.y)));
  XYv_4.x = (tmpvar_16.x * sign(tmpvar_14.z));
  ZYv_6.x = ((sign(-(tmpvar_14.x)) * sign(ZYv_6.z)) * tmpvar_14.z);
  XZv_5.y = ((sign(-(tmpvar_14.y)) * sign(XZv_5.x)) * tmpvar_14.x);
  XYv_4.z = ((sign(-(tmpvar_14.z)) * sign(XYv_4.x)) * tmpvar_14.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_14.x)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_14.y)) * sign(tmpvar_16.y)) * tmpvar_14.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_14.z)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (normalize((_Object2World * tmpvar_18).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_22)), 0.0, 1.0);
  tmpvar_8 = tmpvar_23;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_24;
  p_24 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_25);
  gl_Position = (glstate_matrix_projection * (tmpvar_12 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_12.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_12.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_12.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
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
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 432
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 423
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 422
uniform highp float _MinLight;
#line 446
uniform highp vec4 _TopTex_ST;
#line 487
uniform sampler2D _CameraDepthTexture;
#line 447
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 450
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 454
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 458
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 462
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 466
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 470
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 474
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 478
    mediump vec3 lightDirection = vec3( (0.98 * normalize(_WorldSpaceLightPos0)));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 482
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out mediump vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval.baseLight);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec3(xl_retval._ShadowCoord);
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
#line 336
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
    mediump vec3 baseLight;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 423
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 422
uniform highp float _MinLight;
#line 446
uniform highp vec4 _TopTex_ST;
#line 487
uniform sampler2D _CameraDepthTexture;
#line 488
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    #line 491
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    #line 495
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    #line 499
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in mediump vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
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
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec3(xlv_TEXCOORD6);
    xlt_i._ShadowCoord = vec3(xlv_TEXCOORD7);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 6 [_WorldSpaceCameraPos]
Vector 7 [_WorldSpaceLightPos0]
Matrix 9 [_Object2World]
Vector 8 [_LightColor0]
Float 17 [_DistFade]
Float 18 [_MinLight]
"3.0-!!ARBvp1.0
# 118 ALU
PARAM c[21] = { { 0, 1, 2, 0.60000002 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..12],
		state.matrix.projection,
		program.local[17..18],
		{ 0.5, 0.98000002, 0.010002136 },
		{ 4.0394478, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R2.x, c[4], c[4];
RSQ R2.x, R2.x;
MUL R3.xyz, R2.x, c[4];
MOV R1.xyz, c[0].x;
MOV R1.w, vertex.position;
DP4 R4.x, R1, c[2];
DP4 R4.y, R1, c[3];
DP4 R4.w, R1, c[5];
DP4 R4.z, R1, c[4];
ADD R0, R4, vertex.position;
DP4 result.position.w, R0, c[16];
DP4 result.position.z, R0, c[15];
DP4 result.position.y, R0, c[14];
DP4 result.position.x, R0, c[13];
MUL R0.zw, vertex.texcoord[0].xyxy, c[0].z;
SLT R0.x, c[0], -R3;
SLT R0.y, -R3.x, c[0].x;
ADD R2.x, R0, -R0.y;
ADD R0.xy, R0.zwzw, -c[0].y;
MUL R2.z, R0.x, R2.x;
SLT R2.y, R2.z, c[0].x;
SLT R0.w, R0, c[0].y;
SLT R0.z, c[0].x, R0.y;
ADD R0.z, R0, -R0.w;
SLT R0.w, c[0].x, R2.z;
ADD R0.w, R0, -R2.y;
MUL R2.w, R2.x, R0.z;
MUL R0.w, R0, R2.x;
MUL R2.y, R3, R2.w;
MAD R2.x, R3.z, R0.w, R2.y;
MOV R0.w, vertex.position;
MOV R2.yw, R0;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
SLT R2.w, -R3.y, c[0].x;
SLT R2.z, c[0].x, -R3.y;
ADD R3.w, R2.z, -R2;
MUL R2.zw, R2.xyxy, c[0].w;
MUL R2.x, R0, R3.w;
ADD result.texcoord[1].xy, R2.zwzw, c[19].x;
SLT R2.z, R2.x, c[0].x;
SLT R2.y, c[0].x, R2.x;
ADD R2.y, R2, -R2.z;
MUL R2.z, R0, R3.w;
MUL R2.y, R2, R3.w;
MUL R3.w, R3.z, R2.z;
MOV R2.zw, R0.xyyw;
MAD R2.y, R3.x, R2, R3.w;
DP4 R4.z, R2, c[2];
DP4 R4.w, R2, c[3];
ADD R2.xy, -R4, R4.zwzw;
MUL R2.xy, R2, c[0].w;
SLT R2.w, R3.z, c[0].x;
SLT R2.z, c[0].x, R3;
ADD R3.w, R2.z, -R2;
MUL R0.x, R0, R3.w;
SLT R2.w, -R3.z, c[0].x;
SLT R2.z, c[0].x, -R3;
ADD R2.z, R2, -R2.w;
MUL R3.w, R0.z, R2.z;
SLT R2.w, R0.x, c[0].x;
SLT R0.z, c[0].x, R0.x;
ADD R0.z, R0, -R2.w;
MUL R2.w, R3.y, R3;
MUL R0.z, R2, R0;
MAD R0.z, R3.x, R0, R2.w;
DP4 R2.z, R0, c[2];
DP4 R2.w, R0, c[3];
ADD R0.xy, -R4, R2.zwzw;
MUL R4.xy, R0, c[0].w;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
ADD result.texcoord[2].xy, R2, c[19].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
DP3 R0.y, R2, R2;
RSQ R0.y, R0.y;
DP4 R0.x, c[7], c[7];
MUL R2.xyz, R0.y, R2;
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, c[7];
MUL R0.xyz, R0, R2;
DP3 R0.w, R0, c[19].y;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MIN R1.x, R0.w, c[0].y;
ADD R0.xyz, -R0, c[6];
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL result.texcoord[4].xyz, R0.w, R0;
MAX R1.x, R1, c[0];
ADD R1.x, R1, -c[19].z;
MUL R0.w, R1.x, c[8];
MOV R1.xyz, c[8];
MOV R0.z, c[11].w;
MOV R0.x, c[9].w;
MOV R0.y, c[10].w;
ADD R0.xyz, -R0, c[6];
DP3 R0.x, R0, R0;
MUL R0.w, R0, c[20].x;
MIN R0.y, R0.w, c[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[17];
MIN R0.x, R0, c[0].y;
MAX R0.x, R0, c[0];
MAX R0.y, R0, c[0].x;
ADD R1.xyz, R1, c[18].x;
MAD R1.xyz, R1, R0.y, c[1];
MIN R1.xyz, R1, c[0].y;
ADD result.texcoord[3].xy, R4, c[19].x;
MAX result.texcoord[5].xyz, R1, c[0].x;
MUL result.color.w, vertex.color, R0.x;
MOV result.color.xyz, vertex.color;
ABS result.texcoord[0].xyz, R3;
END
# 118 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 12 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 15 [_LightColor0]
Float 16 [_DistFade]
Float 17 [_MinLight]
"vs_3_0
; 104 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c18, 0.00000000, 2.00000000, -1.00000000, 0.98000002
def c19, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dp3 r1.x, c2, c2
rsq r1.x, r1.x
mul r3.xyz, r1.x, c2
mad r1.xy, v3, c18.y, c18.z
mov r2.xyz, c18.x
mov r2.w, v0
dp4 r5.x, r2, c0
dp4 r5.y, r2, c1
dp4 r5.w, r2, c3
dp4 r5.z, r2, c2
add r0, r5, v0
dp4 o0.w, r0, c7
dp4 o0.z, r0, c6
dp4 o0.y, r0, c5
dp4 o0.x, r0, c4
slt r0.z, r1.y, -r1.y
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.y, -r1, r1
sub r1.z, r0.y, r0
mul r0.z, r1.x, r0.x
mul r1.w, r0.x, r1.z
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r1
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r1.w, v0
mov r0.yw, r1
dp4 r4.y, r0, c1
slt r4.x, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.x
dp4 r4.x, r0, c0
mul r0.x, r1, r3.w
add r4.xy, -r5, r4
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r1, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r1.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r4.z, r0, c0
dp4 r4.w, r0, c1
add r0.xy, -r5, r4.zwzw
mad o4.xy, r0, c19.x, c19.y
slt r0.y, -r3.z, r3.z
slt r0.x, r3.z, -r3.z
sub r0.z, r0.y, r0.x
mul r1.x, r1, r0.z
sub r0.x, r0, r0.y
mul r0.w, r1.z, r0.x
slt r0.z, r1.x, -r1.x
slt r0.y, -r1.x, r1.x
sub r0.y, r0, r0.z
mul r0.z, r3.y, r0.w
mul r0.x, r0, r0.y
mad r1.z, r3.x, r0.x, r0
mov r0.xyz, v2
mov r0.w, c18.x
mad o3.xy, r4, c19.x, c19.y
dp4 r4.z, r0, c10
dp4 r4.x, r0, c8
dp4 r4.y, r0, c9
dp3 r0.z, r4, r4
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
add r0.xy, -r5, r0
dp4 r1.w, c14, c14
dp4 r1.z, r2, c10
dp4 r1.x, r2, c8
dp4 r1.y, r2, c9
add r1.xyz, -r1, c13
dp3 r0.w, r1, r1
rsq r0.w, r0.w
rsq r1.w, r1.w
mul o6.xyz, r0.w, r1
rsq r0.z, r0.z
mad o5.xy, r0, c19.x, c19.y
mul r0.xyz, r0.z, r4
mul r2.xyz, r1.w, c14
mul r0.xyz, r2, r0
dp3_sat r0.w, r0, c18.w
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.w, r0, c19.z
mul r0.y, r0.w, c15.w
mul_sat r0.z, r0.y, c19.w
rsq r0.x, r0.x
rcp r0.x, r0.x
mov r0.y, c17.x
mul_sat r0.x, r0, c16
add r1.xyz, c15, r0.y
mad_sat o7.xyz, r1, r0.z, c12
mul o1.w, v1, r0.x
mov o1.xyz, v1
abs o2.xyz, r3
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Vector 80 [_LightColor0] 4
Float 132 [_DistFade]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
BindCB "UnityPerFrame" 4
// 80 instructions, 5 temp regs, 0 temp arrays:
// ALU 61 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedobpjjkiikjcokmafnfaainmnjmgcekaaabaaaaaabaanaaaaadaaaaaa
cmaaaaaanmaaaaaapiabaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
beabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaakabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaakabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaakabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaakabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaakabaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaakabaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaakabaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahapaaaaakabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaahapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcbaalaaaa
eaaaabaameacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagiaaaaacafaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaeaaaaaa
adaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaag
bcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaia
ibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
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
kcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaa
abaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaa
acaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaa
agaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaa
adaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaa
egiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaai
ccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaai
aanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaap
dccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaa
afaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
eiobhkdpeiobhkdpeiobhkdpaaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaa
aiaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaeaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_modelview0 * tmpvar_11);
  vec4 v_13;
  v_13.x = glstate_matrix_modelview0[0].z;
  v_13.y = glstate_matrix_modelview0[1].z;
  v_13.z = glstate_matrix_modelview0[2].z;
  v_13.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(v_13.xyz);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = _glesVertex.w;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.z = 0.0;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = tmpvar_16.y;
  tmpvar_17.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_17.zyw;
  XZv_5.yzw = tmpvar_17.zyw;
  XYv_4.yzw = tmpvar_17.yzw;
  ZYv_6.z = (tmpvar_16.x * sign(-(tmpvar_14.x)));
  XZv_5.x = (tmpvar_16.x * sign(-(tmpvar_14.y)));
  XYv_4.x = (tmpvar_16.x * sign(tmpvar_14.z));
  ZYv_6.x = ((sign(-(tmpvar_14.x)) * sign(ZYv_6.z)) * tmpvar_14.z);
  XZv_5.y = ((sign(-(tmpvar_14.y)) * sign(XZv_5.x)) * tmpvar_14.x);
  XYv_4.z = ((sign(-(tmpvar_14.z)) * sign(XYv_4.x)) * tmpvar_14.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_14.x)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_14.y)) * sign(tmpvar_16.y)) * tmpvar_14.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_14.z)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (normalize((_Object2World * tmpvar_18).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_22)), 0.0, 1.0);
  tmpvar_8 = tmpvar_23;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_24;
  p_24 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_25);
  gl_Position = (glstate_matrix_projection * (tmpvar_12 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_12.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_12.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_12.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp float _MinLight;
uniform highp float _DistFade;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump float NdotL_1;
  mediump vec3 lightDirection_2;
  mediump vec3 ambientLighting_3;
  highp vec4 XYv_4;
  highp vec4 XZv_5;
  highp vec4 ZYv_6;
  lowp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = _glesVertex.w;
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_modelview0 * tmpvar_11);
  vec4 v_13;
  v_13.x = glstate_matrix_modelview0[0].z;
  v_13.y = glstate_matrix_modelview0[1].z;
  v_13.z = glstate_matrix_modelview0[2].z;
  v_13.w = glstate_matrix_modelview0[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(v_13.xyz);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_15.w = _glesVertex.w;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((2.0 * _glesMultiTexCoord0.xy) - 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.z = 0.0;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = tmpvar_16.y;
  tmpvar_17.w = _glesVertex.w;
  ZYv_6.xyw = tmpvar_17.zyw;
  XZv_5.yzw = tmpvar_17.zyw;
  XYv_4.yzw = tmpvar_17.yzw;
  ZYv_6.z = (tmpvar_16.x * sign(-(tmpvar_14.x)));
  XZv_5.x = (tmpvar_16.x * sign(-(tmpvar_14.y)));
  XYv_4.x = (tmpvar_16.x * sign(tmpvar_14.z));
  ZYv_6.x = ((sign(-(tmpvar_14.x)) * sign(ZYv_6.z)) * tmpvar_14.z);
  XZv_5.y = ((sign(-(tmpvar_14.y)) * sign(XZv_5.x)) * tmpvar_14.x);
  XYv_4.z = ((sign(-(tmpvar_14.z)) * sign(XYv_4.x)) * tmpvar_14.x);
  ZYv_6.x = (ZYv_6.x + ((sign(-(tmpvar_14.x)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  XZv_5.y = (XZv_5.y + ((sign(-(tmpvar_14.y)) * sign(tmpvar_16.y)) * tmpvar_14.z));
  XYv_4.z = (XYv_4.z + ((sign(-(tmpvar_14.z)) * sign(tmpvar_16.y)) * tmpvar_14.y));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (0.98 * normalize(_WorldSpaceLightPos0)).xyz;
  lightDirection_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (normalize((_Object2World * tmpvar_18).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_23;
  tmpvar_23 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_22)), 0.0, 1.0);
  tmpvar_8 = tmpvar_23;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_24;
  p_24 = ((_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * tmpvar_25);
  gl_Position = (glstate_matrix_projection * (tmpvar_12 + _glesVertex));
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_12.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_12.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_12.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD5;
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
  mediump vec4 color_2;
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
  mediump vec4 tmpvar_13;
  tmpvar_13 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_7, ytex_5, vec4(yval_6)), ztex_3, vec4(zval_4)));
  color_2.xyz = (tmpvar_13.xyz * xlv_TEXCOORD5);
  color_2.w = tmpvar_13.w;
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
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 433
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 424
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 423
uniform highp float _MinLight;
#line 447
uniform highp vec4 _TopTex_ST;
#line 488
uniform sampler2D _CameraDepthTexture;
#line 448
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 451
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 455
    o.projPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    #line 459
    highp vec4 XZv = texcoordOffset.xzyw;
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    #line 463
    XYv.x *= sign(viewDir.z);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    #line 467
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    #line 471
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    #line 475
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    #line 479
    mediump vec3 lightDirection = vec3( (0.98 * normalize(_WorldSpaceLightPos0)));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 483
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    o.color.w *= xll_saturate_f((_DistFade * distance( origin, _WorldSpaceCameraPos)));
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out mediump vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD1 = vec2(xl_retval.texcoordZY);
    xlv_TEXCOORD2 = vec2(xl_retval.texcoordXZ);
    xlv_TEXCOORD3 = vec2(xl_retval.texcoordXY);
    xlv_TEXCOORD4 = vec3(xl_retval.projPos);
    xlv_TEXCOORD5 = vec3(xl_retval.baseLight);
    xlv_TEXCOORD6 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD7 = vec3(xl_retval._ShadowCoord);
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
#line 337
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 433
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec3 viewDir;
    highp vec2 texcoordZY;
    highp vec2 texcoordXZ;
    highp vec2 texcoordXY;
    highp vec3 projPos;
    mediump vec3 baseLight;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
};
#line 424
struct appdata_t {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec3 normal;
    highp vec4 tangent;
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
uniform highp float _InvFade;
uniform highp float _DistFade;
uniform highp float _LightScatter;
#line 423
uniform highp float _MinLight;
#line 447
uniform highp vec4 _TopTex_ST;
#line 488
uniform sampler2D _CameraDepthTexture;
#line 489
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    #line 492
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    #line 496
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    #line 500
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in mediump vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec3 xlv_TEXCOORD7;
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
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec3(xlv_TEXCOORD6);
    xlt_i._ShadowCoord = vec3(xlv_TEXCOORD7);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 15
//   opengl - ALU: 12 to 12, TEX: 3 to 3
//   d3d9 - ALU: 9 to 9, TEX: 3 to 3
//   d3d11 - ALU: 8 to 8, TEX: 3 to 3, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.93994141 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL R0, R0, c[1].x;
MOV result.color.w, R0;
MUL result.color.xyz, R0, fragment.texcoord[5];
END
# 12 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_3_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c0
mul_pp r0, r0, r1
mul_pp r0, r0, c1.x
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
ConstBuffer "$Globals" 160 // 128 used size, 10 vars
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedodadahealddjnkgieipgncgndgmejmnhabaaaaaaneadaaaaadaaaaaa
cmaaaaaadaabaaaageabaaaaejfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaapcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaapcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaapcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaapcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaapcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaapcaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaapcaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcgiacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
mcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaaj
pcaabaaaaaaaaaaafgbfbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaajpcaabaaaaaaaaaaakgbkbaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaahaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaadgaaaaafhcaabaaaabaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaa
abaaaaaaabeaaaaanhkdhadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
nhkdhadpnhkdhadpnhkdhadpaaaaiadpdoaaaaab"
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
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.93994141 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL R0, R0, c[1].x;
MOV result.color.w, R0;
MUL result.color.xyz, R0, fragment.texcoord[5];
END
# 12 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_3_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c0
mul_pp r0, r0, r1
mul_pp r0, r0, c1.x
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
ConstBuffer "$Globals" 96 // 64 used size, 9 vars
Vector 48 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedlfgnppikdbmfaglpmgpoopohliibnnneabaaaaaalmadaaaaadaaaaaa
cmaaaaaabiabaaaaemabaaaaejfdeheooeaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaankaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaankaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaankaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaankaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaankaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaankaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcgiacaaaaeaaaaaaajkaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaa
adaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaad
hcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaiaebaaaaaa
abaaaaaadcaaaaajpcaabaaaaaaaaaaafgbfbaaaacaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaakgbkbaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegbobaaa
abaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaadgaaaaafhcaabaaaabaaaaaaegbcbaaaagaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaanhkdhadpdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaakpccabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaanhkdhadpnhkdhadpnhkdhadpaaaaiadpdoaaaaab"
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
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.93994141 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL R0, R0, c[1].x;
MOV result.color.w, R0;
MUL result.color.xyz, R0, fragment.texcoord[5];
END
# 12 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_3_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c0
mul_pp r0, r0, r1
mul_pp r0, r0, c1.x
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
ConstBuffer "$Globals" 160 // 128 used size, 10 vars
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedokbkggajkjmpenfmdhikkffancmdohkiabaaaaaaneadaaaaadaaaaaa
cmaaaaaadaabaaaageabaaaaejfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaapcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaapcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaapcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaapcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaapcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaapcaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaapcaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcgiacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
mcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaaj
pcaabaaaaaaaaaaafgbfbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaajpcaabaaaaaaaaaaakgbkbaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaahaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaadgaaaaafhcaabaaaabaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaa
abaaaaaaabeaaaaanhkdhadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
nhkdhadpnhkdhadpnhkdhadpaaaaiadpdoaaaaab"
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
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.93994141 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL R0, R0, c[1].x;
MOV result.color.w, R0;
MUL result.color.xyz, R0, fragment.texcoord[5];
END
# 12 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_3_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c0
mul_pp r0, r0, r1
mul_pp r0, r0, c1.x
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
ConstBuffer "$Globals" 160 // 128 used size, 10 vars
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedodadahealddjnkgieipgncgndgmejmnhabaaaaaaneadaaaaadaaaaaa
cmaaaaaadaabaaaageabaaaaejfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaapcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaapcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaapcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaapcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaapcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaapcaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaapcaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcgiacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
mcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaaj
pcaabaaaaaaaaaaafgbfbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaajpcaabaaaaaaaaaaakgbkbaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaahaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaadgaaaaafhcaabaaaabaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaa
abaaaaaaabeaaaaanhkdhadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
nhkdhadpnhkdhadpnhkdhadpaaaaiadpdoaaaaab"
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
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.93994141 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL R0, R0, c[1].x;
MOV result.color.w, R0;
MUL result.color.xyz, R0, fragment.texcoord[5];
END
# 12 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_3_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c0
mul_pp r0, r0, r1
mul_pp r0, r0, c1.x
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
ConstBuffer "$Globals" 160 // 128 used size, 10 vars
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedlhhlfcnialcaljjjfdhopekoifanajheabaaaaaaneadaaaaadaaaaaa
cmaaaaaadaabaaaageabaaaaejfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaapcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaapcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaapcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaapcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaapcaaaaaaagaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
amaaaaaapcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaaaaaapcaaaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcgiacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
mcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaaj
pcaabaaaaaaaaaaafgbfbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaajpcaabaaaaaaaaaaakgbkbaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaahaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaadgaaaaafhcaabaaaabaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaa
abaaaaaaabeaaaaanhkdhadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
nhkdhadpnhkdhadpnhkdhadpaaaaiadpdoaaaaab"
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
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.93994141 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL R0, R0, c[1].x;
MOV result.color.w, R0;
MUL result.color.xyz, R0, fragment.texcoord[5];
END
# 12 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_3_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c0
mul_pp r0, r0, r1
mul_pp r0, r0, c1.x
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
ConstBuffer "$Globals" 160 // 128 used size, 10 vars
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjbhipcibppfbbclkakhpgcncmenakbooabaaaaaaomadaaaaadaaaaaa
cmaaaaaaeiabaaaahmabaaaaejfdeheobeabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaakabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaakabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaakabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaakabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaakabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaakabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaakabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaakabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
giacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
gcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaj
pcaabaaaaaaaaaaakgbkbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
hcaabaaaabaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
nhkdhadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaiadpdoaaaaab"
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
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.93994141 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL R0, R0, c[1].x;
MOV result.color.w, R0;
MUL result.color.xyz, R0, fragment.texcoord[5];
END
# 12 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_3_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c0
mul_pp r0, r0, r1
mul_pp r0, r0, c1.x
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
ConstBuffer "$Globals" 160 // 128 used size, 10 vars
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjbhipcibppfbbclkakhpgcncmenakbooabaaaaaaomadaaaaadaaaaaa
cmaaaaaaeiabaaaahmabaaaaejfdeheobeabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaakabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaakabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaakabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaakabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaakabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaakabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaakabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaakabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
giacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
gcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaj
pcaabaaaaaaaaaaakgbkbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
hcaabaaaabaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
nhkdhadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaiadpdoaaaaab"
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
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.93994141 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL R0, R0, c[1].x;
MOV result.color.w, R0;
MUL result.color.xyz, R0, fragment.texcoord[5];
END
# 12 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_3_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c0
mul_pp r0, r0, r1
mul_pp r0, r0, c1.x
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 160 // 128 used size, 10 vars
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedokbkggajkjmpenfmdhikkffancmdohkiabaaaaaaneadaaaaadaaaaaa
cmaaaaaadaabaaaageabaaaaejfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaapcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaapcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaapcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaapcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaapcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaapcaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaapcaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcgiacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
mcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaaj
pcaabaaaaaaaaaaafgbfbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaajpcaabaaaaaaaaaaakgbkbaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaahaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaadgaaaaafhcaabaaaabaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaa
abaaaaaaabeaaaaanhkdhadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
nhkdhadpnhkdhadpnhkdhadpaaaaiadpdoaaaaab"
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
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.93994141 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL R0, R0, c[1].x;
MOV result.color.w, R0;
MUL result.color.xyz, R0, fragment.texcoord[5];
END
# 12 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_3_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c0
mul_pp r0, r0, r1
mul_pp r0, r0, c1.x
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 224 // 192 used size, 11 vars
Vector 176 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedemfmnnloemgadokadpocpneinoinlmgoabaaaaaaomadaaaaadaaaaaa
cmaaaaaaeiabaaaahmabaaaaejfdeheobeabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaakabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaakabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaakabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaakabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaakabaaaaagaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
amaaaaaaakabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaaaaaaakabaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaakabaaaaahaaaaaaaaaaaaaa
adaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
giacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
gcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaj
pcaabaaaaaaaaaaakgbkbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaalaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
hcaabaaaabaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
nhkdhadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaiadpdoaaaaab"
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
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.93994141 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL R0, R0, c[1].x;
MOV result.color.w, R0;
MUL result.color.xyz, R0, fragment.texcoord[5];
END
# 12 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_3_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c0
mul_pp r0, r0, r1
mul_pp r0, r0, c1.x
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
ConstBuffer "$Globals" 160 // 128 used size, 10 vars
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedbcnkhihkdaaejahcjnhieomohegekhncabaaaaaaomadaaaaadaaaaaa
cmaaaaaaeiabaaaahmabaaaaejfdeheobeabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaakabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaakabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaakabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaakabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaakabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaakabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaakabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaaakabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
giacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
gcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaj
pcaabaaaaaaaaaaakgbkbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
hcaabaaaabaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
nhkdhadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaiadpdoaaaaab"
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
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.93994141 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL R0, R0, c[1].x;
MOV result.color.w, R0;
MUL result.color.xyz, R0, fragment.texcoord[5];
END
# 12 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_3_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c0
mul_pp r0, r0, r1
mul_pp r0, r0, c1.x
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
ConstBuffer "$Globals" 160 // 128 used size, 10 vars
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedbcnkhihkdaaejahcjnhieomohegekhncabaaaaaaomadaaaaadaaaaaa
cmaaaaaaeiabaaaahmabaaaaejfdeheobeabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaakabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaakabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaakabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaakabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaakabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaakabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaakabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaaakabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
giacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
gcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaj
pcaabaaaaaaaaaaakgbkbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
hcaabaaaabaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
nhkdhadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaiadpdoaaaaab"
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
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.93994141 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL R0, R0, c[1].x;
MOV result.color.w, R0;
MUL result.color.xyz, R0, fragment.texcoord[5];
END
# 12 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_3_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c0
mul_pp r0, r0, r1
mul_pp r0, r0, c1.x
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 224 // 192 used size, 11 vars
Vector 176 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedgpcflpkjlggaodikpmbhfjbljbbdbikmabaaaaaaomadaaaaadaaaaaa
cmaaaaaaeiabaaaahmabaaaaejfdeheobeabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaakabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaakabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaakabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaakabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaakabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaakabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaakabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaakabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
giacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
gcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaj
pcaabaaaaaaaaaaakgbkbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaalaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
hcaabaaaabaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
nhkdhadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaiadpdoaaaaab"
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
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.93994141 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL R0, R0, c[1].x;
MOV result.color.w, R0;
MUL result.color.xyz, R0, fragment.texcoord[5];
END
# 12 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_3_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c0
mul_pp r0, r0, r1
mul_pp r0, r0, c1.x
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
ConstBuffer "$Globals" 224 // 192 used size, 11 vars
Vector 176 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedgpcflpkjlggaodikpmbhfjbljbbdbikmabaaaaaaomadaaaaadaaaaaa
cmaaaaaaeiabaaaahmabaaaaejfdeheobeabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaakabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaakabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaakabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaakabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaakabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaakabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaakabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaakabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
giacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
gcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaj
pcaabaaaaaaaaaaakgbkbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaalaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
hcaabaaaabaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
nhkdhadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaiadpdoaaaaab"
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
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.93994141 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL R0, R0, c[1].x;
MOV result.color.w, R0;
MUL result.color.xyz, R0, fragment.texcoord[5];
END
# 12 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_3_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c0
mul_pp r0, r0, r1
mul_pp r0, r0, c1.x
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 160 // 128 used size, 10 vars
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedbcnkhihkdaaejahcjnhieomohegekhncabaaaaaaomadaaaaadaaaaaa
cmaaaaaaeiabaaaahmabaaaaejfdeheobeabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaakabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaakabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaakabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaakabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaakabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaakabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaakabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaaakabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
giacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
gcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaj
pcaabaaaaaaaaaaakgbkbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
hcaabaaaabaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
nhkdhadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaiadpdoaaaaab"
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
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.93994141 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].y, R0, R1;
TEX R0, fragment.texcoord[3], texture[2], 2D;
ADD R0, R0, -R1;
MAD R1, fragment.texcoord[0].z, R0, R1;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL R0, R0, c[1].x;
MOV result.color.w, R0;
MUL result.color.xyz, R0, fragment.texcoord[5];
END
# 12 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_Color]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
"ps_3_0
; 9 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c0
mul_pp r0, r0, r1
mul_pp r0, r0, c1.x
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 160 // 128 used size, 10 vars
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedbcnkhihkdaaejahcjnhieomohegekhncabaaaaaaomadaaaaadaaaaaa
cmaaaaaaeiabaaaahmabaaaaejfdeheobeabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaakabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaakabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaakabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaakabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaakabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaakabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaakabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaaakabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
giacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
gcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaj
pcaabaaaaaaaaaaakgbkbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadgaaaaaf
hcaabaaaabaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
nhkdhadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaiadpdoaaaaab"
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

#LINE 165
 
		}
		
	} 
	
}
}