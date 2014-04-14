Shader "CloudParticle" {
Properties {
	_TopTex ("Particle Texture", 2D) = "white" {}
	_LeftTex ("Particle Texture", 2D) = "white" {}
	_FrontTex ("Particle Texture", 2D) = "white" {}
	_DistFade ("Distance Fade Near", Range(0,1)) = 1.0
	_DistFadeVert ("Distance Fade Vertical", Range(0,1)) = 0.00004
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
//   d3d9 - ALU: 107 to 107
//   d3d11 - ALU: 70 to 70, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform float _MinLight;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform vec4 _LightColor0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec4 tmpvar_4;
  vec3 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.w = gl_Vertex.w;
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewMatrix * tmpvar_6);
  vec4 v_8;
  v_8.x = gl_ModelViewMatrix[0].z;
  v_8.y = gl_ModelViewMatrix[1].z;
  v_8.z = gl_ModelViewMatrix[2].z;
  v_8.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
  vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = gl_Vertex.w;
  vec2 tmpvar_11;
  tmpvar_11 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_12;
  tmpvar_12.z = 0.0;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = tmpvar_11.y;
  tmpvar_12.w = gl_Vertex.w;
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
  vec3 tmpvar_13;
  tmpvar_13 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = gl_Normal;
  tmpvar_4.xyz = gl_Color.xyz;
  vec3 p_15;
  p_15 = (tmpvar_13 - _WorldSpaceCameraPos);
  vec3 p_16;
  p_16 = (tmpvar_13 - _WorldSpaceCameraPos);
  tmpvar_4.w = (gl_Color.w * (clamp ((_DistFade * sqrt(dot (p_15, p_15))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_16, p_16)))), 0.0, 1.0)));
  gl_Position = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_10).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_14).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = tmpvar_2.w;
  gl_FragData[0] = color_1;
}


#endif
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
Float 17 [_DistFadeVert]
Float 18 [_MinLight]
"vs_3_0
; 107 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c19, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c20, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c19.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c19.z, c19.w
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
mad o4.xy, r0, c20.x, c20.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c20.x, c20.y
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
mov r0.w, c19.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c20.x, c20.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c14, c14
rsq r0.y, r0.y
mul r2.xyz, r0.y, c14
dp3_sat r0.w, r1, r2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.y, r0.w, c20.z
mul r0.y, r0, c15.w
rsq r0.x, r0.x
mov r0.z, c18.x
rcp r0.x, r0.x
mul_sat r0.w, r0.y, c20
mul r0.y, -r0.x, c17.x
add r1.xyz, c15, r0.z
mul_sat r0.x, r0, c16
add_sat r0.y, r0, c19
mul r0.x, r0, r0.y
mad_sat o7.xyz, r1, r0.w, c12
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
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
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
// 82 instructions, 5 temp regs, 0 temp arrays:
// ALU 62 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmmganfddhgkmppddbkoejjnkbbfjpbbhabaaaaaacmanaaaaadaaaaaa
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
fdeieefceealaaaaeaaaabaanbacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
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
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadccaaaalbcaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaaaiaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
dgcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaa
dgaaaaagbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaa
aaaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaa
acaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaea
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
diaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaa
fganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaa
fgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaa
agiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaa
aeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaa
agiecaaaadaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaap
dccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaa
aaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaa
dbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaa
boaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
cgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaa
claaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaa
aaaaaaaaegiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaa
dcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaam
hcaabaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaa
egacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
dicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
ocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaaiaaaaaa
dccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
aeaaaaaaaeaaaaaadoaaaaab"
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_17;
  tmpvar_17 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
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
  p_24 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp vec3 p_25;
  p_25 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_25, p_25)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_26 * tmpvar_27));
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_17;
  tmpvar_17 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
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
  p_24 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp vec3 p_25;
  p_25 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_25, p_25)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_26 * tmpvar_27));
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 403
uniform highp float _MinLight;
#line 426
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 470
#line 427
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 430
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 434
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
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
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 462
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    #line 466
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
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
    xlv_TEXCOORD4 = vec3(xl_retval.camPos);
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 403
uniform highp float _MinLight;
#line 426
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 470
#line 470
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 474
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 478
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
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
    xlt_i.camPos = vec3(xlv_TEXCOORD4);
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec3(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform float _MinLight;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform vec4 _LightColor0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.w = gl_Vertex.w;
  vec4 tmpvar_6;
  tmpvar_6 = (gl_ModelViewMatrix * tmpvar_5);
  vec4 v_7;
  v_7.x = gl_ModelViewMatrix[0].z;
  v_7.y = gl_ModelViewMatrix[1].z;
  v_7.z = gl_ModelViewMatrix[2].z;
  v_7.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(v_7.xyz);
  vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_9.w = gl_Vertex.w;
  vec2 tmpvar_10;
  tmpvar_10 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_11;
  tmpvar_11.z = 0.0;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = tmpvar_10.y;
  tmpvar_11.w = gl_Vertex.w;
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
  vec3 tmpvar_12;
  tmpvar_12 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = gl_Normal;
  tmpvar_4.xyz = gl_Color.xyz;
  vec3 p_14;
  p_14 = (tmpvar_12 - _WorldSpaceCameraPos);
  vec3 p_15;
  p_15 = (tmpvar_12 - _WorldSpaceCameraPos);
  tmpvar_4.w = (gl_Color.w * (clamp ((_DistFade * sqrt(dot (p_14, p_14))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_15, p_15)))), 0.0, 1.0)));
  gl_Position = (gl_ProjectionMatrix * (tmpvar_6 + gl_Vertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_8);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_6.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_6.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_6.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_9).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_13).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = tmpvar_2.w;
  gl_FragData[0] = color_1;
}


#endif
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
Float 17 [_DistFadeVert]
Float 18 [_MinLight]
"vs_3_0
; 107 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c19, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c20, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c19.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c19.z, c19.w
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
mad o4.xy, r0, c20.x, c20.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c20.x, c20.y
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
mov r0.w, c19.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c20.x, c20.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c14, c14
rsq r0.y, r0.y
mul r2.xyz, r0.y, c14
dp3_sat r0.w, r1, r2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.y, r0.w, c20.z
mul r0.y, r0, c15.w
rsq r0.x, r0.x
mov r0.z, c18.x
rcp r0.x, r0.x
mul_sat r0.w, r0.y, c20
mul r0.y, -r0.x, c17.x
add r1.xyz, c15, r0.z
mul_sat r0.x, r0, c16
add_sat r0.y, r0, c19
mul r0.x, r0, r0.y
mad_sat o7.xyz, r1, r0.w, c12
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
Float 64 [_DistFade]
Float 68 [_DistFadeVert]
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
// 82 instructions, 5 temp regs, 0 temp arrays:
// ALU 62 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedepngjplijgpifiggdkmjkicfjdacjalmabaaaaaabeanaaaaadaaaaaa
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
fiedepepfceeaaklfdeieefceealaaaaeaaaabaanbacaaaafjaaaaaeegiocaaa
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
egacbaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaadccaaaal
bcaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaaeaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpdgcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahiccabaaa
abaaaaaaakaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egbcbaaaabaaaaaadgaaaaagbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaa
dgaaaaagccaabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaa
aaaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
dbaaaaalhcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaa
abaaaaaaegacbaaaacaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaa
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
adaaaaaaafaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaa
pgapbaaaaaaaaaaafganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaa
adaaaaaafganbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdp
aceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaa
fgafbaaaacaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaa
agibcaaaadaaaaaaaeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaak
kcaabaaaaaaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaa
acaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dbaaaaahccaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaacaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaa
ngafbaaaabaaaaaaboaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
dkaabaaaaaaaaaaacgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaabaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaa
dcaaaaakdcaabaaaaaaaaaaaegiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaa
egaabaaaabaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaa
jkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaaj
icaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahbcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaapnekibdpdiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
aaaaaaaaabaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiaeaaaaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaapgipcaaa
aaaaaaaaaeaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaeaaaaaaaeaaaaaadoaaaaab"
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_16;
  tmpvar_16 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = normalize(_WorldSpaceLightPos0).xyz;
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
  p_23 = (tmpvar_16 - _WorldSpaceCameraPos);
  highp vec3 p_24;
  p_24 = (tmpvar_16 - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_23, p_23))), 0.0, 1.0);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_24, p_24)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_25 * tmpvar_26));
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_16;
  tmpvar_16 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = normalize(_WorldSpaceLightPos0).xyz;
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
  p_23 = (tmpvar_16 - _WorldSpaceCameraPos);
  highp vec3 p_24;
  p_24 = (tmpvar_16 - _WorldSpaceCameraPos);
  highp float tmpvar_25;
  tmpvar_25 = clamp ((_DistFade * sqrt(dot (p_23, p_23))), 0.0, 1.0);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_24, p_24)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_25 * tmpvar_26));
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 401
uniform highp float _MinLight;
#line 423
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 467
#line 424
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 427
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 431
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
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
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 459
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    #line 463
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
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
    xlv_TEXCOORD4 = vec3(xl_retval.camPos);
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 401
uniform highp float _MinLight;
#line 423
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 467
#line 467
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 471
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 475
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 479
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
    xlt_i.camPos = vec3(xlv_TEXCOORD4);
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform float _MinLight;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform vec4 _LightColor0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.w = gl_Vertex.w;
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewMatrix * tmpvar_6);
  vec4 v_8;
  v_8.x = gl_ModelViewMatrix[0].z;
  v_8.y = gl_ModelViewMatrix[1].z;
  v_8.z = gl_ModelViewMatrix[2].z;
  v_8.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
  vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = gl_Vertex.w;
  vec2 tmpvar_11;
  tmpvar_11 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_12;
  tmpvar_12.z = 0.0;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = tmpvar_11.y;
  tmpvar_12.w = gl_Vertex.w;
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
  vec3 tmpvar_13;
  tmpvar_13 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = gl_Normal;
  tmpvar_4.xyz = gl_Color.xyz;
  vec3 p_15;
  p_15 = (tmpvar_13 - _WorldSpaceCameraPos);
  vec3 p_16;
  p_16 = (tmpvar_13 - _WorldSpaceCameraPos);
  tmpvar_4.w = (gl_Color.w * (clamp ((_DistFade * sqrt(dot (p_15, p_15))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_16, p_16)))), 0.0, 1.0)));
  gl_Position = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_10).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_14).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = tmpvar_2.w;
  gl_FragData[0] = color_1;
}


#endif
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
Float 17 [_DistFadeVert]
Float 18 [_MinLight]
"vs_3_0
; 107 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c19, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c20, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c19.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c19.z, c19.w
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
mad o4.xy, r0, c20.x, c20.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c20.x, c20.y
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
mov r0.w, c19.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c20.x, c20.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c14, c14
rsq r0.y, r0.y
mul r2.xyz, r0.y, c14
dp3_sat r0.w, r1, r2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.y, r0.w, c20.z
mul r0.y, r0, c15.w
rsq r0.x, r0.x
mov r0.z, c18.x
rcp r0.x, r0.x
mul_sat r0.w, r0.y, c20
mul r0.y, -r0.x, c17.x
add r1.xyz, c15, r0.z
mul_sat r0.x, r0, c16
add_sat r0.y, r0, c19
mul r0.x, r0, r0.y
mad_sat o7.xyz, r1, r0.w, c12
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
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
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
// 82 instructions, 5 temp regs, 0 temp arrays:
// ALU 62 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedabgkigdcndcjpjlnabgcbhlabgecejakabaaaaaacmanaaaaadaaaaaa
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
fdeieefceealaaaaeaaaabaanbacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
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
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadccaaaalbcaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaaaiaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
dgcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaa
dgaaaaagbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaa
aaaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaa
acaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaea
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
diaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaa
fganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaa
fgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaa
agiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaa
aeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaa
agiecaaaadaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaap
dccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaa
aaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaa
dbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaa
boaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
cgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaa
claaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaa
aaaaaaaaegiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaa
dcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaam
hcaabaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaa
egacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
dicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
ocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaaiaaaaaa
dccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
aeaaaaaaaeaaaaaadoaaaaab"
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_17;
  tmpvar_17 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
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
  p_24 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp vec3 p_25;
  p_25 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_25, p_25)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_26 * tmpvar_27));
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_17;
  tmpvar_17 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
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
  p_24 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp vec3 p_25;
  p_25 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_25, p_25)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_26 * tmpvar_27));
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 412
uniform highp float _MinLight;
#line 435
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 479
#line 436
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 439
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 443
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
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
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 471
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    #line 475
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
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
    xlv_TEXCOORD4 = vec3(xl_retval.camPos);
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 412
uniform highp float _MinLight;
#line 435
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 479
#line 479
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 483
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 487
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 491
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
    xlt_i.camPos = vec3(xlv_TEXCOORD4);
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform float _MinLight;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform vec4 _LightColor0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec4 tmpvar_4;
  vec3 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.w = gl_Vertex.w;
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewMatrix * tmpvar_6);
  vec4 v_8;
  v_8.x = gl_ModelViewMatrix[0].z;
  v_8.y = gl_ModelViewMatrix[1].z;
  v_8.z = gl_ModelViewMatrix[2].z;
  v_8.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
  vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = gl_Vertex.w;
  vec2 tmpvar_11;
  tmpvar_11 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_12;
  tmpvar_12.z = 0.0;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = tmpvar_11.y;
  tmpvar_12.w = gl_Vertex.w;
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
  vec3 tmpvar_13;
  tmpvar_13 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = gl_Normal;
  tmpvar_4.xyz = gl_Color.xyz;
  vec3 p_15;
  p_15 = (tmpvar_13 - _WorldSpaceCameraPos);
  vec3 p_16;
  p_16 = (tmpvar_13 - _WorldSpaceCameraPos);
  tmpvar_4.w = (gl_Color.w * (clamp ((_DistFade * sqrt(dot (p_15, p_15))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_16, p_16)))), 0.0, 1.0)));
  gl_Position = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_10).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_14).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = tmpvar_2.w;
  gl_FragData[0] = color_1;
}


#endif
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
Float 17 [_DistFadeVert]
Float 18 [_MinLight]
"vs_3_0
; 107 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c19, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c20, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c19.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c19.z, c19.w
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
mad o4.xy, r0, c20.x, c20.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c20.x, c20.y
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
mov r0.w, c19.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c20.x, c20.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c14, c14
rsq r0.y, r0.y
mul r2.xyz, r0.y, c14
dp3_sat r0.w, r1, r2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.y, r0.w, c20.z
mul r0.y, r0, c15.w
rsq r0.x, r0.x
mov r0.z, c18.x
rcp r0.x, r0.x
mul_sat r0.w, r0.y, c20
mul r0.y, -r0.x, c17.x
add r1.xyz, c15, r0.z
mul_sat r0.x, r0, c16
add_sat r0.y, r0, c19
mul r0.x, r0, r0.y
mad_sat o7.xyz, r1, r0.w, c12
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
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
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
// 82 instructions, 5 temp regs, 0 temp arrays:
// ALU 62 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmmganfddhgkmppddbkoejjnkbbfjpbbhabaaaaaacmanaaaaadaaaaaa
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
fdeieefceealaaaaeaaaabaanbacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
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
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadccaaaalbcaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaaaiaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
dgcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaa
dgaaaaagbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaa
aaaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaa
acaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaea
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
diaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaa
fganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaa
fgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaa
agiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaa
aeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaa
agiecaaaadaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaap
dccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaa
aaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaa
dbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaa
boaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
cgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaa
claaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaa
aaaaaaaaegiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaa
dcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaam
hcaabaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaa
egacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
dicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
ocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaaiaaaaaa
dccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
aeaaaaaaaeaaaaaadoaaaaab"
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_17;
  tmpvar_17 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
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
  p_24 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp vec3 p_25;
  p_25 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_25, p_25)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_26 * tmpvar_27));
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_17;
  tmpvar_17 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
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
  p_24 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp vec3 p_25;
  p_25 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_25, p_25)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_26 * tmpvar_27));
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 404
uniform highp float _MinLight;
#line 427
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 471
#line 428
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 431
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 435
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
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
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 463
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    #line 467
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
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
    xlv_TEXCOORD4 = vec3(xl_retval.camPos);
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 404
uniform highp float _MinLight;
#line 427
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 471
#line 471
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 475
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 479
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 483
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
    xlt_i.camPos = vec3(xlv_TEXCOORD4);
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec3(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec2 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform float _MinLight;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform vec4 _LightColor0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec4 tmpvar_4;
  vec2 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.w = gl_Vertex.w;
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewMatrix * tmpvar_6);
  vec4 v_8;
  v_8.x = gl_ModelViewMatrix[0].z;
  v_8.y = gl_ModelViewMatrix[1].z;
  v_8.z = gl_ModelViewMatrix[2].z;
  v_8.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
  vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = gl_Vertex.w;
  vec2 tmpvar_11;
  tmpvar_11 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_12;
  tmpvar_12.z = 0.0;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = tmpvar_11.y;
  tmpvar_12.w = gl_Vertex.w;
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
  vec3 tmpvar_13;
  tmpvar_13 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = gl_Normal;
  tmpvar_4.xyz = gl_Color.xyz;
  vec3 p_15;
  p_15 = (tmpvar_13 - _WorldSpaceCameraPos);
  vec3 p_16;
  p_16 = (tmpvar_13 - _WorldSpaceCameraPos);
  tmpvar_4.w = (gl_Color.w * (clamp ((_DistFade * sqrt(dot (p_15, p_15))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_16, p_16)))), 0.0, 1.0)));
  gl_Position = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_10).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_14).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = tmpvar_2.w;
  gl_FragData[0] = color_1;
}


#endif
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
Float 17 [_DistFadeVert]
Float 18 [_MinLight]
"vs_3_0
; 107 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c19, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c20, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c19.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c19.z, c19.w
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
mad o4.xy, r0, c20.x, c20.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c20.x, c20.y
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
mov r0.w, c19.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c20.x, c20.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c14, c14
rsq r0.y, r0.y
mul r2.xyz, r0.y, c14
dp3_sat r0.w, r1, r2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.y, r0.w, c20.z
mul r0.y, r0, c15.w
rsq r0.x, r0.x
mov r0.z, c18.x
rcp r0.x, r0.x
mul_sat r0.w, r0.y, c20
mul r0.y, -r0.x, c17.x
add r1.xyz, c15, r0.z
mul_sat r0.x, r0, c16
add_sat r0.y, r0, c19
mul r0.x, r0, r0.y
mad_sat o7.xyz, r1, r0.w, c12
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
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
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
// 82 instructions, 5 temp regs, 0 temp arrays:
// ALU 62 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedejelhmfnajgidpnjpgbeimmodfcnjnelabaaaaaacmanaaaaadaaaaaa
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
fdeieefceealaaaaeaaaabaanbacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
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
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadccaaaalbcaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaaaiaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
dgcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaa
dgaaaaagbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaa
aaaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaa
acaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaea
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
diaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaa
fganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaa
fgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaa
agiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaa
aeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaa
agiecaaaadaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaap
dccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaa
aaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaa
dbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaa
boaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
cgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaa
claaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaa
aaaaaaaaegiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaa
dcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaam
hcaabaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaa
egacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
dicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
ocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaaiaaaaaa
dccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
aeaaaaaaaeaaaaaadoaaaaab"
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_17;
  tmpvar_17 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
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
  p_24 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp vec3 p_25;
  p_25 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_25, p_25)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_26 * tmpvar_27));
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_17;
  tmpvar_17 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
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
  p_24 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp vec3 p_25;
  p_25 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_25, p_25)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_26 * tmpvar_27));
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 403
uniform highp float _MinLight;
#line 426
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 470
#line 427
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 430
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 434
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
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
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 462
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    #line 466
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
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
    xlv_TEXCOORD4 = vec3(xl_retval.camPos);
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 403
uniform highp float _MinLight;
#line 426
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 470
#line 470
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 474
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 478
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
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
    xlt_i.camPos = vec3(xlv_TEXCOORD4);
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._LightCoord = vec2(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform float _MinLight;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform vec4 _LightColor0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = gl_Vertex.w;
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ModelViewMatrix * tmpvar_7);
  vec4 v_9;
  v_9.x = gl_ModelViewMatrix[0].z;
  v_9.y = gl_ModelViewMatrix[1].z;
  v_9.z = gl_ModelViewMatrix[2].z;
  v_9.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = gl_Vertex.w;
  vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = gl_Vertex.w;
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
  vec3 tmpvar_14;
  tmpvar_14 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = gl_Normal;
  tmpvar_4.xyz = gl_Color.xyz;
  vec3 p_16;
  p_16 = (tmpvar_14 - _WorldSpaceCameraPos);
  vec3 p_17;
  p_17 = (tmpvar_14 - _WorldSpaceCameraPos);
  tmpvar_4.w = (gl_Color.w * (clamp ((_DistFade * sqrt(dot (p_16, p_16))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_17, p_17)))), 0.0, 1.0)));
  gl_Position = (gl_ProjectionMatrix * (tmpvar_8 + gl_Vertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = tmpvar_2.w;
  gl_FragData[0] = color_1;
}


#endif
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
Float 17 [_DistFadeVert]
Float 18 [_MinLight]
"vs_3_0
; 107 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c19, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c20, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c19.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c19.z, c19.w
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
mad o4.xy, r0, c20.x, c20.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c20.x, c20.y
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
mov r0.w, c19.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c20.x, c20.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c14, c14
rsq r0.y, r0.y
mul r2.xyz, r0.y, c14
dp3_sat r0.w, r1, r2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.y, r0.w, c20.z
mul r0.y, r0, c15.w
rsq r0.x, r0.x
mov r0.z, c18.x
rcp r0.x, r0.x
mul_sat r0.w, r0.y, c20
mul r0.y, -r0.x, c17.x
add r1.xyz, c15, r0.z
mul_sat r0.x, r0, c16
add_sat r0.y, r0, c19
mul r0.x, r0, r0.y
mad_sat o7.xyz, r1, r0.w, c12
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
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
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
// 82 instructions, 5 temp regs, 0 temp arrays:
// ALU 62 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednmgaknaglhngnjibnncegcpeahapkbonabaaaaaaeeanaaaaadaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefceealaaaa
eaaaabaanbacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
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
aaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaadccaaaalbcaabaaaaaaaaaaabkiacaiaebaaaaaa
aaaaaaaaaiaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaaegacbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaap
dcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaaabaaaaaa
bkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaaegacbaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaaadaaaaaa
claaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaaaaaaaaaa
fganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaakdcaabaaa
aeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaaaeaaaaaa
cgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaaabaaaaaa
egaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaaikcaabaaa
abaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaa
abaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaaabaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaacaaaaaa
fganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaa
abaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaaadaaaaaa
ngafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
adaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaaiccaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaaiaanaaaaa
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
adaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaapdccabaaa
aeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaa
egiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajocaabaaaaaaaaaaa
agijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaaiaaaaaadccaaaakhccabaaa
agaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaa
doaaaaab"
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_20;
  tmpvar_20 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (normalize((_Object2World * tmpvar_19).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_23)), 0.0, 1.0);
  tmpvar_8 = tmpvar_24;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_25;
  p_25 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp vec3 p_26;
  p_26 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DistFade * sqrt(dot (p_25, p_25))), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_26, p_26)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_27 * tmpvar_28));
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_20;
  tmpvar_20 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (normalize((_Object2World * tmpvar_19).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_23)), 0.0, 1.0);
  tmpvar_8 = tmpvar_24;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_25;
  p_25 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp vec3 p_26;
  p_26 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DistFade * sqrt(dot (p_25, p_25))), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_26, p_26)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_27 * tmpvar_28));
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 418
uniform highp float _MinLight;
#line 442
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 486
#line 443
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 446
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 450
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
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
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 478
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    #line 482
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
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
    xlv_TEXCOORD4 = vec3(xl_retval.camPos);
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 418
uniform highp float _MinLight;
#line 442
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 486
#line 486
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 490
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 494
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
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
    xlt_i.camPos = vec3(xlv_TEXCOORD4);
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
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform float _MinLight;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform vec4 _LightColor0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = gl_Vertex.w;
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ModelViewMatrix * tmpvar_7);
  vec4 v_9;
  v_9.x = gl_ModelViewMatrix[0].z;
  v_9.y = gl_ModelViewMatrix[1].z;
  v_9.z = gl_ModelViewMatrix[2].z;
  v_9.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = gl_Vertex.w;
  vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = gl_Vertex.w;
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
  vec3 tmpvar_14;
  tmpvar_14 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = gl_Normal;
  tmpvar_4.xyz = gl_Color.xyz;
  vec3 p_16;
  p_16 = (tmpvar_14 - _WorldSpaceCameraPos);
  vec3 p_17;
  p_17 = (tmpvar_14 - _WorldSpaceCameraPos);
  tmpvar_4.w = (gl_Color.w * (clamp ((_DistFade * sqrt(dot (p_16, p_16))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_17, p_17)))), 0.0, 1.0)));
  gl_Position = (gl_ProjectionMatrix * (tmpvar_8 + gl_Vertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = tmpvar_2.w;
  gl_FragData[0] = color_1;
}


#endif
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
Float 17 [_DistFadeVert]
Float 18 [_MinLight]
"vs_3_0
; 107 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c19, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c20, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c19.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c19.z, c19.w
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
mad o4.xy, r0, c20.x, c20.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c20.x, c20.y
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
mov r0.w, c19.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c20.x, c20.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c14, c14
rsq r0.y, r0.y
mul r2.xyz, r0.y, c14
dp3_sat r0.w, r1, r2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.y, r0.w, c20.z
mul r0.y, r0, c15.w
rsq r0.x, r0.x
mov r0.z, c18.x
rcp r0.x, r0.x
mul_sat r0.w, r0.y, c20
mul r0.y, -r0.x, c17.x
add r1.xyz, c15, r0.z
mul_sat r0.x, r0, c16
add_sat r0.y, r0, c19
mul r0.x, r0, r0.y
mad_sat o7.xyz, r1, r0.w, c12
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
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
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
// 82 instructions, 5 temp regs, 0 temp arrays:
// ALU 62 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednmgaknaglhngnjibnncegcpeahapkbonabaaaaaaeeanaaaaadaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefceealaaaa
eaaaabaanbacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
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
aaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaadccaaaalbcaabaaaaaaaaaaabkiacaiaebaaaaaa
aaaaaaaaaiaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaaegacbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaap
dcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaaabaaaaaa
bkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaaegacbaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaaadaaaaaa
claaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaaaaaaaaaa
fganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaakdcaabaaa
aeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaaaeaaaaaa
cgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaaabaaaaaa
egaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaaikcaabaaa
abaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaa
abaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaaabaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaacaaaaaa
fganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaa
abaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaaadaaaaaa
ngafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
adaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaaiccaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaaiaanaaaaa
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
adaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaapdccabaaa
aeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaa
egiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajocaabaaaaaaaaaaa
agijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaaiaaaaaadccaaaakhccabaaa
agaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaa
doaaaaab"
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_20;
  tmpvar_20 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (normalize((_Object2World * tmpvar_19).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_23)), 0.0, 1.0);
  tmpvar_8 = tmpvar_24;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_25;
  p_25 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp vec3 p_26;
  p_26 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DistFade * sqrt(dot (p_25, p_25))), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_26, p_26)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_27 * tmpvar_28));
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 419
uniform highp float _MinLight;
#line 443
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 487
#line 444
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 447
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 451
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
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
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 479
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    #line 483
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
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
    xlv_TEXCOORD4 = vec3(xl_retval.camPos);
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 419
uniform highp float _MinLight;
#line 443
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 487
#line 487
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 491
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 495
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 499
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
    xlt_i.camPos = vec3(xlv_TEXCOORD4);
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
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform float _MinLight;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform vec4 _LightColor0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.w = gl_Vertex.w;
  vec4 tmpvar_7;
  tmpvar_7 = (gl_ModelViewMatrix * tmpvar_6);
  vec4 v_8;
  v_8.x = gl_ModelViewMatrix[0].z;
  v_8.y = gl_ModelViewMatrix[1].z;
  v_8.z = gl_ModelViewMatrix[2].z;
  v_8.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(v_8.xyz);
  vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = gl_Vertex.w;
  vec2 tmpvar_11;
  tmpvar_11 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_12;
  tmpvar_12.z = 0.0;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = tmpvar_11.y;
  tmpvar_12.w = gl_Vertex.w;
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
  vec3 tmpvar_13;
  tmpvar_13 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = gl_Normal;
  tmpvar_4.xyz = gl_Color.xyz;
  vec3 p_15;
  p_15 = (tmpvar_13 - _WorldSpaceCameraPos);
  vec3 p_16;
  p_16 = (tmpvar_13 - _WorldSpaceCameraPos);
  tmpvar_4.w = (gl_Color.w * (clamp ((_DistFade * sqrt(dot (p_15, p_15))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_16, p_16)))), 0.0, 1.0)));
  gl_Position = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_9);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_10).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_14).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = tmpvar_2.w;
  gl_FragData[0] = color_1;
}


#endif
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
Float 17 [_DistFadeVert]
Float 18 [_MinLight]
"vs_3_0
; 107 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c19, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c20, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c19.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c19.z, c19.w
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
mad o4.xy, r0, c20.x, c20.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c20.x, c20.y
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
mov r0.w, c19.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c20.x, c20.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c14, c14
rsq r0.y, r0.y
mul r2.xyz, r0.y, c14
dp3_sat r0.w, r1, r2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.y, r0.w, c20.z
mul r0.y, r0, c15.w
rsq r0.x, r0.x
mov r0.z, c18.x
rcp r0.x, r0.x
mul_sat r0.w, r0.y, c20
mul r0.y, -r0.x, c17.x
add r1.xyz, c15, r0.z
mul_sat r0.x, r0, c16
add_sat r0.y, r0, c19
mul r0.x, r0, r0.y
mad_sat o7.xyz, r1, r0.w, c12
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
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
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
// 82 instructions, 5 temp regs, 0 temp arrays:
// ALU 62 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedabgkigdcndcjpjlnabgcbhlabgecejakabaaaaaacmanaaaaadaaaaaa
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
fdeieefceealaaaaeaaaabaanbacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
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
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadccaaaalbcaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaaaiaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
dgcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaa
dgaaaaagbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaa
aaaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaibaaaaaaaaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaa
acaaaaaadcaaaaapdcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaea
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
diaaaaaikcaabaaaabaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaa
fganbaaaabaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaa
fgafbaaaacaaaaaafganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaa
agiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaa
aeaaaaaaagaabaaaabaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaa
agiecaaaadaaaaaaagaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaap
dccabaaaadaaaaaangafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaa
aaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaa
dbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaadaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaa
boaaaaaiccaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
cgaaaaaiaanaaaaaccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaa
claaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaa
aaaaaaaaegiacaaaadaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaa
dcaaaaapdccabaaaaeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaam
hcaabaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaa
egacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
dicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
ocaabaaaaaaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaaiaaaaaa
dccaaaakhccabaaaagaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
aeaaaaaaaeaaaaaadoaaaaab"
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_17;
  tmpvar_17 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
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
  p_24 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp vec3 p_25;
  p_25 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_25, p_25)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_26 * tmpvar_27));
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_17;
  tmpvar_17 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0).xyz;
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
  p_24 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp vec3 p_25;
  p_25 = (tmpvar_17 - _WorldSpaceCameraPos);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((_DistFade * sqrt(dot (p_24, p_24))), 0.0, 1.0);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_25, p_25)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_26 * tmpvar_27));
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 409
uniform highp float _MinLight;
#line 432
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 476
#line 433
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 436
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 440
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
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
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 468
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    #line 472
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
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
    xlv_TEXCOORD4 = vec3(xl_retval.camPos);
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 409
uniform highp float _MinLight;
#line 432
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 476
#line 476
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 480
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 484
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 488
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
    xlt_i.camPos = vec3(xlv_TEXCOORD4);
    xlt_i.baseLight = vec3(xlv_TEXCOORD5);
    xlt_i._ShadowCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
varying vec2 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform float _MinLight;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform vec4 _LightColor0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec4 tmpvar_4;
  vec2 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = gl_Vertex.w;
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ModelViewMatrix * tmpvar_7);
  vec4 v_9;
  v_9.x = gl_ModelViewMatrix[0].z;
  v_9.y = gl_ModelViewMatrix[1].z;
  v_9.z = gl_ModelViewMatrix[2].z;
  v_9.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = gl_Vertex.w;
  vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = gl_Vertex.w;
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
  vec3 tmpvar_14;
  tmpvar_14 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = gl_Normal;
  tmpvar_4.xyz = gl_Color.xyz;
  vec3 p_16;
  p_16 = (tmpvar_14 - _WorldSpaceCameraPos);
  vec3 p_17;
  p_17 = (tmpvar_14 - _WorldSpaceCameraPos);
  tmpvar_4.w = (gl_Color.w * (clamp ((_DistFade * sqrt(dot (p_16, p_16))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_17, p_17)))), 0.0, 1.0)));
  gl_Position = (gl_ProjectionMatrix * (tmpvar_8 + gl_Vertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = tmpvar_2.w;
  gl_FragData[0] = color_1;
}


#endif
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
Float 17 [_DistFadeVert]
Float 18 [_MinLight]
"vs_3_0
; 107 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c19, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c20, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c19.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c19.z, c19.w
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
mad o4.xy, r0, c20.x, c20.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c20.x, c20.y
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
mov r0.w, c19.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c20.x, c20.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c14, c14
rsq r0.y, r0.y
mul r2.xyz, r0.y, c14
dp3_sat r0.w, r1, r2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.y, r0.w, c20.z
mul r0.y, r0, c15.w
rsq r0.x, r0.x
mov r0.z, c18.x
rcp r0.x, r0.x
mul_sat r0.w, r0.y, c20
mul r0.y, -r0.x, c17.x
add r1.xyz, c15, r0.z
mul_sat r0.x, r0, c16
add_sat r0.y, r0, c19
mul r0.x, r0, r0.y
mad_sat o7.xyz, r1, r0.w, c12
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
Float 192 [_DistFade]
Float 196 [_DistFadeVert]
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
// 82 instructions, 5 temp regs, 0 temp arrays:
// ALU 62 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedekbgpolffdhdchfhnoklnkcaddiemileabaaaaaaeeanaaaaadaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefceealaaaa
eaaaabaanbacaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
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
aaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaamaaaaaadccaaaalbcaabaaaaaaaaaaabkiacaiaebaaaaaa
aaaaaaaaamaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaaegacbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaap
dcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaaabaaaaaa
bkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaaegacbaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaaadaaaaaa
claaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaaaaaaaaaa
fganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaakdcaabaaa
aeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaaaeaaaaaa
cgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaaabaaaaaa
egaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaaikcaabaaa
abaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaa
abaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaaabaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaacaaaaaa
fganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaa
abaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaaadaaaaaa
ngafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
adaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaaiccaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaaiaanaaaaa
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
adaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaapdccabaaa
aeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaa
egiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaadicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajocaabaaaaaaaaaaa
agijcaaaaaaaaaaaajaaaaaapgipcaaaaaaaaaaaamaaaaaadccaaaakhccabaaa
agaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaa
doaaaaab"
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_20;
  tmpvar_20 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (normalize((_Object2World * tmpvar_19).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_23)), 0.0, 1.0);
  tmpvar_8 = tmpvar_24;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_25;
  p_25 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp vec3 p_26;
  p_26 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DistFade * sqrt(dot (p_25, p_25))), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_26, p_26)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_27 * tmpvar_28));
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_20;
  tmpvar_20 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (normalize((_Object2World * tmpvar_19).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_23)), 0.0, 1.0);
  tmpvar_8 = tmpvar_24;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_25;
  p_25 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp vec3 p_26;
  p_26 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DistFade * sqrt(dot (p_25, p_25))), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_26, p_26)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_27 * tmpvar_28));
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 411
uniform highp float _MinLight;
#line 435
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 479
#line 436
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 439
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 443
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
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
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 471
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    #line 475
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
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
    xlv_TEXCOORD4 = vec3(xl_retval.camPos);
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 411
uniform highp float _MinLight;
#line 435
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 479
#line 479
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 483
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 487
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 491
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
    xlt_i.camPos = vec3(xlv_TEXCOORD4);
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
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform float _MinLight;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform vec4 _LightColor0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec4 tmpvar_4;
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = gl_Vertex.w;
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ModelViewMatrix * tmpvar_7);
  vec4 v_9;
  v_9.x = gl_ModelViewMatrix[0].z;
  v_9.y = gl_ModelViewMatrix[1].z;
  v_9.z = gl_ModelViewMatrix[2].z;
  v_9.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = gl_Vertex.w;
  vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = gl_Vertex.w;
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
  vec3 tmpvar_14;
  tmpvar_14 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = gl_Normal;
  tmpvar_4.xyz = gl_Color.xyz;
  vec3 p_16;
  p_16 = (tmpvar_14 - _WorldSpaceCameraPos);
  vec3 p_17;
  p_17 = (tmpvar_14 - _WorldSpaceCameraPos);
  tmpvar_4.w = (gl_Color.w * (clamp ((_DistFade * sqrt(dot (p_16, p_16))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_17, p_17)))), 0.0, 1.0)));
  gl_Position = (gl_ProjectionMatrix * (tmpvar_8 + gl_Vertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = tmpvar_2.w;
  gl_FragData[0] = color_1;
}


#endif
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
Float 17 [_DistFadeVert]
Float 18 [_MinLight]
"vs_3_0
; 107 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c19, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c20, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c19.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c19.z, c19.w
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
mad o4.xy, r0, c20.x, c20.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c20.x, c20.y
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
mov r0.w, c19.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c20.x, c20.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c14, c14
rsq r0.y, r0.y
mul r2.xyz, r0.y, c14
dp3_sat r0.w, r1, r2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.y, r0.w, c20.z
mul r0.y, r0, c15.w
rsq r0.x, r0.x
mov r0.z, c18.x
rcp r0.x, r0.x
mul_sat r0.w, r0.y, c20
mul r0.y, -r0.x, c17.x
add r1.xyz, c15, r0.z
mul_sat r0.x, r0, c16
add_sat r0.y, r0, c19
mul r0.x, r0, r0.y
mad_sat o7.xyz, r1, r0.w, c12
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
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
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
// 82 instructions, 5 temp regs, 0 temp arrays:
// ALU 62 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddagmpomimabcpllfpfiamagmipiinpopabaaaaaaeeanaaaaadaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefceealaaaa
eaaaabaanbacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
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
aaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaadccaaaalbcaabaaaaaaaaaaabkiacaiaebaaaaaa
aaaaaaaaaiaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaaegacbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaap
dcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaaabaaaaaa
bkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaaegacbaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaaadaaaaaa
claaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaaaaaaaaaa
fganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaakdcaabaaa
aeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaaaeaaaaaa
cgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaaabaaaaaa
egaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaaikcaabaaa
abaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaa
abaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaaabaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaacaaaaaa
fganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaa
abaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaaadaaaaaa
ngafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
adaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaaiccaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaaiaanaaaaa
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
adaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaapdccabaaa
aeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaa
egiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajocaabaaaaaaaaaaa
agijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaaiaaaaaadccaaaakhccabaaa
agaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaa
doaaaaab"
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_20;
  tmpvar_20 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (normalize((_Object2World * tmpvar_19).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_23)), 0.0, 1.0);
  tmpvar_8 = tmpvar_24;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_25;
  p_25 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp vec3 p_26;
  p_26 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DistFade * sqrt(dot (p_25, p_25))), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_26, p_26)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_27 * tmpvar_28));
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_20;
  tmpvar_20 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (normalize((_Object2World * tmpvar_19).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_23)), 0.0, 1.0);
  tmpvar_8 = tmpvar_24;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_25;
  p_25 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp vec3 p_26;
  p_26 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DistFade * sqrt(dot (p_25, p_25))), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_26, p_26)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_27 * tmpvar_28));
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 416
uniform highp float _MinLight;
#line 440
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 484
#line 441
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 444
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 448
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
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
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 476
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    #line 480
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
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
    xlv_TEXCOORD4 = vec3(xl_retval.camPos);
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 416
uniform highp float _MinLight;
#line 440
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 484
#line 484
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 488
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 492
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
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
    xlt_i.camPos = vec3(xlv_TEXCOORD4);
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
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform float _MinLight;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform vec4 _LightColor0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec4 tmpvar_4;
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = gl_Vertex.w;
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ModelViewMatrix * tmpvar_7);
  vec4 v_9;
  v_9.x = gl_ModelViewMatrix[0].z;
  v_9.y = gl_ModelViewMatrix[1].z;
  v_9.z = gl_ModelViewMatrix[2].z;
  v_9.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = gl_Vertex.w;
  vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = gl_Vertex.w;
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
  vec3 tmpvar_14;
  tmpvar_14 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = gl_Normal;
  tmpvar_4.xyz = gl_Color.xyz;
  vec3 p_16;
  p_16 = (tmpvar_14 - _WorldSpaceCameraPos);
  vec3 p_17;
  p_17 = (tmpvar_14 - _WorldSpaceCameraPos);
  tmpvar_4.w = (gl_Color.w * (clamp ((_DistFade * sqrt(dot (p_16, p_16))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_17, p_17)))), 0.0, 1.0)));
  gl_Position = (gl_ProjectionMatrix * (tmpvar_8 + gl_Vertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = tmpvar_2.w;
  gl_FragData[0] = color_1;
}


#endif
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
Float 17 [_DistFadeVert]
Float 18 [_MinLight]
"vs_3_0
; 107 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c19, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c20, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c19.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c19.z, c19.w
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
mad o4.xy, r0, c20.x, c20.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c20.x, c20.y
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
mov r0.w, c19.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c20.x, c20.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c14, c14
rsq r0.y, r0.y
mul r2.xyz, r0.y, c14
dp3_sat r0.w, r1, r2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.y, r0.w, c20.z
mul r0.y, r0, c15.w
rsq r0.x, r0.x
mov r0.z, c18.x
rcp r0.x, r0.x
mul_sat r0.w, r0.y, c20
mul r0.y, -r0.x, c17.x
add r1.xyz, c15, r0.z
mul_sat r0.x, r0, c16
add_sat r0.y, r0, c19
mul r0.x, r0, r0.y
mad_sat o7.xyz, r1, r0.w, c12
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
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
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
// 82 instructions, 5 temp regs, 0 temp arrays:
// ALU 62 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddagmpomimabcpllfpfiamagmipiinpopabaaaaaaeeanaaaaadaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefceealaaaa
eaaaabaanbacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
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
aaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaadccaaaalbcaabaaaaaaaaaaabkiacaiaebaaaaaa
aaaaaaaaaiaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaaegacbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaap
dcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaaabaaaaaa
bkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaaegacbaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaaadaaaaaa
claaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaaaaaaaaaa
fganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaakdcaabaaa
aeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaaaeaaaaaa
cgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaaabaaaaaa
egaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaaikcaabaaa
abaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaa
abaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaaabaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaacaaaaaa
fganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaa
abaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaaadaaaaaa
ngafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
adaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaaiccaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaaiaanaaaaa
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
adaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaapdccabaaa
aeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaa
egiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajocaabaaaaaaaaaaa
agijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaaiaaaaaadccaaaakhccabaaa
agaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaa
doaaaaab"
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_20;
  tmpvar_20 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (normalize((_Object2World * tmpvar_19).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_23)), 0.0, 1.0);
  tmpvar_8 = tmpvar_24;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_25;
  p_25 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp vec3 p_26;
  p_26 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DistFade * sqrt(dot (p_25, p_25))), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_26, p_26)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_27 * tmpvar_28));
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_20;
  tmpvar_20 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (normalize((_Object2World * tmpvar_19).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_23)), 0.0, 1.0);
  tmpvar_8 = tmpvar_24;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_25;
  p_25 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp vec3 p_26;
  p_26 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DistFade * sqrt(dot (p_25, p_25))), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_26, p_26)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_27 * tmpvar_28));
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 417
uniform highp float _MinLight;
#line 441
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 485
#line 442
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 445
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 449
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
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
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 477
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    #line 481
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
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
    xlv_TEXCOORD4 = vec3(xl_retval.camPos);
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 417
uniform highp float _MinLight;
#line 441
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 485
#line 485
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 489
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 493
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
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
    xlt_i.camPos = vec3(xlv_TEXCOORD4);
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
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform float _MinLight;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform vec4 _LightColor0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = gl_Vertex.w;
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ModelViewMatrix * tmpvar_7);
  vec4 v_9;
  v_9.x = gl_ModelViewMatrix[0].z;
  v_9.y = gl_ModelViewMatrix[1].z;
  v_9.z = gl_ModelViewMatrix[2].z;
  v_9.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = gl_Vertex.w;
  vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = gl_Vertex.w;
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
  vec3 tmpvar_14;
  tmpvar_14 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = gl_Normal;
  tmpvar_4.xyz = gl_Color.xyz;
  vec3 p_16;
  p_16 = (tmpvar_14 - _WorldSpaceCameraPos);
  vec3 p_17;
  p_17 = (tmpvar_14 - _WorldSpaceCameraPos);
  tmpvar_4.w = (gl_Color.w * (clamp ((_DistFade * sqrt(dot (p_16, p_16))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_17, p_17)))), 0.0, 1.0)));
  gl_Position = (gl_ProjectionMatrix * (tmpvar_8 + gl_Vertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = tmpvar_2.w;
  gl_FragData[0] = color_1;
}


#endif
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
Float 17 [_DistFadeVert]
Float 18 [_MinLight]
"vs_3_0
; 107 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c19, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c20, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c19.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c19.z, c19.w
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
mad o4.xy, r0, c20.x, c20.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c20.x, c20.y
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
mov r0.w, c19.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c20.x, c20.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c14, c14
rsq r0.y, r0.y
mul r2.xyz, r0.y, c14
dp3_sat r0.w, r1, r2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.y, r0.w, c20.z
mul r0.y, r0, c15.w
rsq r0.x, r0.x
mov r0.z, c18.x
rcp r0.x, r0.x
mul_sat r0.w, r0.y, c20
mul r0.y, -r0.x, c17.x
add r1.xyz, c15, r0.z
mul_sat r0.x, r0, c16
add_sat r0.y, r0, c19
mul r0.x, r0, r0.y
mad_sat o7.xyz, r1, r0.w, c12
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
Float 192 [_DistFade]
Float 196 [_DistFadeVert]
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
// 82 instructions, 5 temp regs, 0 temp arrays:
// ALU 62 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcphlniffalolcabchkeabangdafnclgaabaaaaaaeeanaaaaadaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefceealaaaa
eaaaabaanbacaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
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
aaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaamaaaaaadccaaaalbcaabaaaaaaaaaaabkiacaiaebaaaaaa
aaaaaaaaamaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaaegacbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaap
dcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaaabaaaaaa
bkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaaegacbaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaaadaaaaaa
claaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaaaaaaaaaa
fganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaakdcaabaaa
aeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaaaeaaaaaa
cgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaaabaaaaaa
egaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaaikcaabaaa
abaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaa
abaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaaabaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaacaaaaaa
fganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaa
abaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaaadaaaaaa
ngafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
adaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaaiccaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaaiaanaaaaa
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
adaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaapdccabaaa
aeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaa
egiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaadicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajocaabaaaaaaaaaaa
agijcaaaaaaaaaaaajaaaaaapgipcaaaaaaaaaaaamaaaaaadccaaaakhccabaaa
agaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaa
doaaaaab"
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_20;
  tmpvar_20 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (normalize((_Object2World * tmpvar_19).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_23)), 0.0, 1.0);
  tmpvar_8 = tmpvar_24;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_25;
  p_25 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp vec3 p_26;
  p_26 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DistFade * sqrt(dot (p_25, p_25))), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_26, p_26)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_27 * tmpvar_28));
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_20;
  tmpvar_20 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (normalize((_Object2World * tmpvar_19).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_23)), 0.0, 1.0);
  tmpvar_8 = tmpvar_24;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_25;
  p_25 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp vec3 p_26;
  p_26 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DistFade * sqrt(dot (p_25, p_25))), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_26, p_26)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_27 * tmpvar_28));
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 426
uniform highp float _MinLight;
#line 450
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 494
#line 451
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 454
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 458
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
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
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 486
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    #line 490
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
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
    xlv_TEXCOORD4 = vec3(xl_retval.camPos);
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 426
uniform highp float _MinLight;
#line 450
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 494
#line 494
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 498
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 502
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 506
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
    xlt_i.camPos = vec3(xlv_TEXCOORD4);
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
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform float _MinLight;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform vec4 _LightColor0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = gl_Vertex.w;
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ModelViewMatrix * tmpvar_7);
  vec4 v_9;
  v_9.x = gl_ModelViewMatrix[0].z;
  v_9.y = gl_ModelViewMatrix[1].z;
  v_9.z = gl_ModelViewMatrix[2].z;
  v_9.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = gl_Vertex.w;
  vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = gl_Vertex.w;
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
  vec3 tmpvar_14;
  tmpvar_14 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = gl_Normal;
  tmpvar_4.xyz = gl_Color.xyz;
  vec3 p_16;
  p_16 = (tmpvar_14 - _WorldSpaceCameraPos);
  vec3 p_17;
  p_17 = (tmpvar_14 - _WorldSpaceCameraPos);
  tmpvar_4.w = (gl_Color.w * (clamp ((_DistFade * sqrt(dot (p_16, p_16))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_17, p_17)))), 0.0, 1.0)));
  gl_Position = (gl_ProjectionMatrix * (tmpvar_8 + gl_Vertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = tmpvar_2.w;
  gl_FragData[0] = color_1;
}


#endif
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
Float 17 [_DistFadeVert]
Float 18 [_MinLight]
"vs_3_0
; 107 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c19, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c20, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c19.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c19.z, c19.w
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
mad o4.xy, r0, c20.x, c20.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c20.x, c20.y
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
mov r0.w, c19.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c20.x, c20.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c14, c14
rsq r0.y, r0.y
mul r2.xyz, r0.y, c14
dp3_sat r0.w, r1, r2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.y, r0.w, c20.z
mul r0.y, r0, c15.w
rsq r0.x, r0.x
mov r0.z, c18.x
rcp r0.x, r0.x
mul_sat r0.w, r0.y, c20
mul r0.y, -r0.x, c17.x
add r1.xyz, c15, r0.z
mul_sat r0.x, r0, c16
add_sat r0.y, r0, c19
mul r0.x, r0, r0.y
mad_sat o7.xyz, r1, r0.w, c12
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
Float 192 [_DistFade]
Float 196 [_DistFadeVert]
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
// 82 instructions, 5 temp regs, 0 temp arrays:
// ALU 62 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcphlniffalolcabchkeabangdafnclgaabaaaaaaeeanaaaaadaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefceealaaaa
eaaaabaanbacaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
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
aaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaamaaaaaadccaaaalbcaabaaaaaaaaaaabkiacaiaebaaaaaa
aaaaaaaaamaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaaegacbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaap
dcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaaabaaaaaa
bkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaaegacbaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaaadaaaaaa
claaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaaaaaaaaaa
fganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaakdcaabaaa
aeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaaaeaaaaaa
cgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaaabaaaaaa
egaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaaikcaabaaa
abaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaa
abaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaaabaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaacaaaaaa
fganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaa
abaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaaadaaaaaa
ngafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
adaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaaiccaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaaiaanaaaaa
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
adaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaapdccabaaa
aeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaa
egiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaadicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajocaabaaaaaaaaaaa
agijcaaaaaaaaaaaajaaaaaapgipcaaaaaaaaaaaamaaaaaadccaaaakhccabaaa
agaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaa
doaaaaab"
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_20;
  tmpvar_20 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (normalize((_Object2World * tmpvar_19).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_23)), 0.0, 1.0);
  tmpvar_8 = tmpvar_24;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_25;
  p_25 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp vec3 p_26;
  p_26 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DistFade * sqrt(dot (p_25, p_25))), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_26, p_26)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_27 * tmpvar_28));
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 426
uniform highp float _MinLight;
#line 450
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 494
#line 451
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 454
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 458
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
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
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 486
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    #line 490
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
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
    xlv_TEXCOORD4 = vec3(xl_retval.camPos);
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 426
uniform highp float _MinLight;
#line 450
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 494
#line 494
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 498
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 502
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 506
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
    xlt_i.camPos = vec3(xlv_TEXCOORD4);
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
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform float _MinLight;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform vec4 _LightColor0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec4 tmpvar_4;
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = gl_Vertex.w;
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ModelViewMatrix * tmpvar_7);
  vec4 v_9;
  v_9.x = gl_ModelViewMatrix[0].z;
  v_9.y = gl_ModelViewMatrix[1].z;
  v_9.z = gl_ModelViewMatrix[2].z;
  v_9.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = gl_Vertex.w;
  vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = gl_Vertex.w;
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
  vec3 tmpvar_14;
  tmpvar_14 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = gl_Normal;
  tmpvar_4.xyz = gl_Color.xyz;
  vec3 p_16;
  p_16 = (tmpvar_14 - _WorldSpaceCameraPos);
  vec3 p_17;
  p_17 = (tmpvar_14 - _WorldSpaceCameraPos);
  tmpvar_4.w = (gl_Color.w * (clamp ((_DistFade * sqrt(dot (p_16, p_16))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_17, p_17)))), 0.0, 1.0)));
  gl_Position = (gl_ProjectionMatrix * (tmpvar_8 + gl_Vertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = tmpvar_2.w;
  gl_FragData[0] = color_1;
}


#endif
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
Float 17 [_DistFadeVert]
Float 18 [_MinLight]
"vs_3_0
; 107 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c19, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c20, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c19.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c19.z, c19.w
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
mad o4.xy, r0, c20.x, c20.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c20.x, c20.y
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
mov r0.w, c19.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c20.x, c20.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c14, c14
rsq r0.y, r0.y
mul r2.xyz, r0.y, c14
dp3_sat r0.w, r1, r2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.y, r0.w, c20.z
mul r0.y, r0, c15.w
rsq r0.x, r0.x
mov r0.z, c18.x
rcp r0.x, r0.x
mul_sat r0.w, r0.y, c20
mul r0.y, -r0.x, c17.x
add r1.xyz, c15, r0.z
mul_sat r0.x, r0, c16
add_sat r0.y, r0, c19
mul r0.x, r0, r0.y
mad_sat o7.xyz, r1, r0.w, c12
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
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
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
// 82 instructions, 5 temp regs, 0 temp arrays:
// ALU 62 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddagmpomimabcpllfpfiamagmipiinpopabaaaaaaeeanaaaaadaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefceealaaaa
eaaaabaanbacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
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
aaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaadccaaaalbcaabaaaaaaaaaaabkiacaiaebaaaaaa
aaaaaaaaaiaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaaegacbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaap
dcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaaabaaaaaa
bkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaaegacbaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaaadaaaaaa
claaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaaaaaaaaaa
fganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaakdcaabaaa
aeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaaaeaaaaaa
cgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaaabaaaaaa
egaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaaikcaabaaa
abaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaa
abaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaaabaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaacaaaaaa
fganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaa
abaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaaadaaaaaa
ngafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
adaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaaiccaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaaiaanaaaaa
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
adaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaapdccabaaa
aeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaa
egiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajocaabaaaaaaaaaaa
agijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaaiaaaaaadccaaaakhccabaaa
agaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaa
doaaaaab"
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_20;
  tmpvar_20 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (normalize((_Object2World * tmpvar_19).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_23)), 0.0, 1.0);
  tmpvar_8 = tmpvar_24;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_25;
  p_25 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp vec3 p_26;
  p_26 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DistFade * sqrt(dot (p_25, p_25))), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_26, p_26)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_27 * tmpvar_28));
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_20;
  tmpvar_20 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (normalize((_Object2World * tmpvar_19).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_23)), 0.0, 1.0);
  tmpvar_8 = tmpvar_24;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_25;
  p_25 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp vec3 p_26;
  p_26 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DistFade * sqrt(dot (p_25, p_25))), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_26, p_26)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_27 * tmpvar_28));
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 422
uniform highp float _MinLight;
#line 446
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 490
#line 447
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 450
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 454
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
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
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 482
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    #line 486
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
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
    xlv_TEXCOORD4 = vec3(xl_retval.camPos);
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 422
uniform highp float _MinLight;
#line 446
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 490
#line 490
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 494
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 498
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
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
    xlt_i.camPos = vec3(xlv_TEXCOORD4);
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
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform float _MinLight;
uniform float _DistFadeVert;
uniform float _DistFade;
uniform vec4 _LightColor0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 XYv_1;
  vec4 XZv_2;
  vec4 ZYv_3;
  vec4 tmpvar_4;
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.w = gl_Vertex.w;
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ModelViewMatrix * tmpvar_7);
  vec4 v_9;
  v_9.x = gl_ModelViewMatrix[0].z;
  v_9.y = gl_ModelViewMatrix[1].z;
  v_9.z = gl_ModelViewMatrix[2].z;
  v_9.w = gl_ModelViewMatrix[3].z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize(v_9.xyz);
  vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_11.w = gl_Vertex.w;
  vec2 tmpvar_12;
  tmpvar_12 = ((2.0 * gl_MultiTexCoord0.xy) - 1.0);
  vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = tmpvar_12.y;
  tmpvar_13.w = gl_Vertex.w;
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
  vec3 tmpvar_14;
  tmpvar_14 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = gl_Normal;
  tmpvar_4.xyz = gl_Color.xyz;
  vec3 p_16;
  p_16 = (tmpvar_14 - _WorldSpaceCameraPos);
  vec3 p_17;
  p_17 = (tmpvar_14 - _WorldSpaceCameraPos);
  tmpvar_4.w = (gl_Color.w * (clamp ((_DistFade * sqrt(dot (p_16, p_16))), 0.0, 1.0) * clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_17, p_17)))), 0.0, 1.0)));
  gl_Position = (gl_ProjectionMatrix * (tmpvar_8 + gl_Vertex));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_8.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_8.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_8.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = tmpvar_2.w;
  gl_FragData[0] = color_1;
}


#endif
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
Float 17 [_DistFadeVert]
Float 18 [_MinLight]
"vs_3_0
; 107 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
def c19, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c20, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c19.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r0, r2, v0
dp3 r2.z, c2, c2
rsq r2.z, r2.z
mul r3.xyz, r2.z, c2
mad r2.zw, v3.xyxy, c19.z, c19.w
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
mad o4.xy, r0, c20.x, c20.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
sub r0.w, r0, r1.x
mad o3.xy, r4.xzzw, c20.x, c20.y
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
mov r0.w, c19.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c20.x, c20.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c14, c14
rsq r0.y, r0.y
mul r2.xyz, r0.y, c14
dp3_sat r0.w, r1, r2
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.y, r0.w, c20.z
mul r0.y, r0, c15.w
rsq r0.x, r0.x
mov r0.z, c18.x
rcp r0.x, r0.x
mul_sat r0.w, r0.y, c20
mul r0.y, -r0.x, c17.x
add r1.xyz, c15, r0.z
mul_sat r0.x, r0, c16
add_sat r0.y, r0, c19
mul r0.x, r0, r0.y
mad_sat o7.xyz, r1, r0.w, c12
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
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
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
// 82 instructions, 5 temp regs, 0 temp arrays:
// ALU 62 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddagmpomimabcpllfpfiamagmipiinpopabaaaaaaeeanaaaaadaaaaaa
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
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefceealaaaa
eaaaabaanbacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
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
aaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaadccaaaalbcaabaaaaaaaaaaabkiacaiaebaaaaaa
aaaaaaaaaiaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
aaaaaaaadbaaaaalhcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaadbaaaaalhcaabaaaacaaaaaaegacbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaap
dcaabaaaacaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaadbaaaaahicaabaaaabaaaaaa
bkaabaaaacaaaaaaabeaaaaaaaaaaaaaboaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaaiaanaaaaahcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaclaaaaafhcaabaaaadaaaaaaegacbaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaajgafbaaaaaaaaaaaegacbaaaadaaaaaa
claaaaafkcaabaaaaaaaaaaaagaebaaaabaaaaaadiaaaaahkcaabaaaaaaaaaaa
fganbaaaaaaaaaaaagaabaaaacaaaaaadbaaaaakmcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaaaaaaaaaadbaaaaakdcaabaaa
aeaaaaaangafbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaaagaebaaaaeaaaaaa
cgaaaaaiaanaaaaadcaabaaaabaaaaaaegaabaaaabaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaaabaaaaaa
egaabaaaabaaaaaacgakbaaaaaaaaaaaegaabaaaadaaaaaadiaaaaaikcaabaaa
abaaaaaafgafbaaaabaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakkcaabaaa
abaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaaaaaaaaafganbaaaabaaaaaa
dcaaaaakkcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaacaaaaaa
fganbaaaabaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpdiaaaaaikcaabaaaabaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakgcaabaaaacaaaaaaagibcaaaadaaaaaaaeaaaaaaagaabaaa
abaaaaaafgahbaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaaaaaaaaafgajbaaaacaaaaaadcaaaaapdccabaaaadaaaaaa
ngafbaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaaboaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaaclaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
adaaaaaaaeaaaaaafgafbaaaaaaaaaaangafbaaaabaaaaaaboaaaaaiccaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaacgaaaaaiaanaaaaa
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaclaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaackaabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
adaaaaaaagaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaapdccabaaa
aeaaaaaaegaabaaaaaaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaa
egiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabbaaaaajicaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajocaabaaaaaaaaaaa
agijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaaiaaaaaadccaaaakhccabaaa
agaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaa
doaaaaab"
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_20;
  tmpvar_20 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (normalize((_Object2World * tmpvar_19).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_23)), 0.0, 1.0);
  tmpvar_8 = tmpvar_24;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_25;
  p_25 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp vec3 p_26;
  p_26 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DistFade * sqrt(dot (p_25, p_25))), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_26, p_26)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_27 * tmpvar_28));
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
uniform highp float _DistFadeVert;
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
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_20;
  tmpvar_20 = glstate_lightmodel_ambient.xyz;
  ambientLighting_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_2 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (dot (normalize((_Object2World * tmpvar_19).xyz), lightDirection_2), 0.0, 1.0);
  NdotL_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (((_LightColor0.w * ((NdotL_1 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_24;
  tmpvar_24 = clamp ((ambientLighting_3 + ((_MinLight + _LightColor0.xyz) * tmpvar_23)), 0.0, 1.0);
  tmpvar_8 = tmpvar_24;
  tmpvar_7.xyz = _glesColor.xyz;
  highp vec3 p_25;
  p_25 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp vec3 p_26;
  p_26 = (tmpvar_18 - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DistFade * sqrt(dot (p_25, p_25))), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (_DistFadeVert * sqrt(dot (p_26, p_26)))), 0.0, 1.0);
  tmpvar_7.w = (_glesColor.w * (tmpvar_27 * tmpvar_28));
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 423
uniform highp float _MinLight;
#line 447
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 491
#line 448
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    #line 451
    v2f o;
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    #line 455
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
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
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    #line 483
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    #line 487
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
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
    xlv_TEXCOORD4 = vec3(xl_retval.camPos);
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
    highp vec3 camPos;
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
uniform highp float _DistFade;
uniform highp float _DistFadeVert;
uniform highp float _LightScatter;
#line 423
uniform highp float _MinLight;
#line 447
uniform highp vec4 _TopTex_ST;
uniform sampler2D _CameraDepthTexture;
#line 491
#line 491
lowp vec4 frag( in v2f i ) {
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    #line 495
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    #line 499
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    #line 503
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
    xlt_i.camPos = vec3(xlv_TEXCOORD4);
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
//   d3d9 - ALU: 9 to 9, TEX: 3 to 3
//   d3d11 - ALU: 8 to 8, TEX: 3 to 3, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL"
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
"!!GLSL"
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
"!!GLSL"
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
"!!GLSL"
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
"!!GLSL"
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
"!!GLSL"
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
"!!GLSL"
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
"!!GLSL"
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
"!!GLSL"
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
"!!GLSL"
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
"!!GLSL"
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
"!!GLSL"
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
"!!GLSL"
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
"!!GLSL"
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
"!!GLSL"
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

#LINE 168
 
		}
		
	} 
	
}
}