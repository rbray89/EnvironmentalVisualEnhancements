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
	_InvFade ("Soft Particles Factor", Range(0.01,3.0)) = .01
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
//   d3d9 - ALU: 114 to 126
//   d3d11 - ALU: 78 to 90, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
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
uniform mat4 _LightMatrix0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
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
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
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
  vec4 o_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_8 * 0.5);
  vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform vec4 _ZBufferParams;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
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
Vector 16 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [_ScreenParams]
Vector 20 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Vector 21 [_LightColor0]
Float 22 [_DistFade]
Float 23 [_DistFadeVert]
Float 24 [_MinLight]
"vs_3_0
; 121 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord6 o8
dcl_texcoord8 o9
def c25, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c26, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c25.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r3, r2, v0
dp4 r2.z, r3, c7
dp3 r0.z, c2, c2
rsq r2.w, r0.z
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
dp4 r0.z, r3, c6
mov r0.w, r2.z
mul r3.xyz, r2.w, c2
mul r4.xyz, r0.xyww, c26.y
mov o0, r0
mul r4.y, r4, c18.x
mad o9.xy, r4.z, c19.zwzw, r4
mad r4.xy, v3, c25.z, c25.w
mov r4.w, v0
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.z, r4.y, -r4.y
slt r0.y, -r4, r4
sub r2.w, r0.y, r0.z
mul r0.z, r4.x, r0.x
mul r3.w, r0.x, r2
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r3
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r2, r5
slt r4.z, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.z
mul r0.x, r4, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2.w, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r2, r5.zwzw
mad o4.xy, r0, c26.x, c26.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c17
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
mul r4.x, r4, r1.y
sub r0.w, r0, r1.x
mul r1.z, r2.w, r0.w
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
mov r0.w, c25.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c26.x, c26.y
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
dp3 r0.x, r1, r1
rsq r0.w, r0.x
dp4 r0.y, c20, c20
rsq r0.y, r0.y
mul r0.xyz, r0.y, c20
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
add r0.w, r0, c26.z
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c17
dp3 r0.x, r0, r0
mul r0.y, r0.w, c21.w
mov r0.z, c24.x
add r1.xyz, c21, r0.z
mul_sat r0.w, r0.y, c26
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c23.x
mad_sat o7.xyz, r1, r0.w, c16
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
add_sat r0.y, r0, c25
mul_sat r0.x, r0, c22
mul r0.x, r0, r0.y
mul o1.w, v1, r0.x
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.z, r0, c14
dp4 o8.y, r0, c13
dp4 o8.x, r0, c12
dp4 r0.x, v0, c2
mad o3.xy, r5, c26.x, c26.y
mov o9.w, r2.z
mov o1.xyz, v1
abs o2.xyz, r3
mov o9.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Matrix 16 [_LightMatrix0] 4
Vector 80 [_LightColor0] 4
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
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
// 100 instructions, 6 temp regs, 0 temp arrays:
// ALU 78 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedfdppellhgpnpeamipmjpgimigfjgomhnabaaaaaamiapaaaaadaaaaaa
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
ahaiaaaaakabaaaaaiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcmianaaaa
eaaaabaahcadaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagfaaaaadpccabaaa
aiaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
ahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
aaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaa
abaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadccaaaalecaabaaa
aaaaaaaabkiacaiaebaaaaaaaaaaaaaaaiaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpdgcaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahiccabaaaabaaaaaa
ckaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaa
abaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaag
ccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaa
ckiacaaaadaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaa
acaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaal
hcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaa
egacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaadaaaaaa
dbaaaaahicaabaaaabaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaai
aanaaaaahcaabaaaaeaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaaclaaaaaf
hcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaajgafbaaa
abaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaaabaaaaaaagaebaaaacaaaaaa
diaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaaadaaaaaadbaaaaak
mcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaa
abaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaakgaobaiaebaaaaaa
adaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaa
acaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
dcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaabaaaaaaegaabaaa
aeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaa
abaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaa
fganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaa
adaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaa
adaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaa
abaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaa
dcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
adaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaak
dcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaa
acaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaa
abaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaa
acaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaa
acaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaajecaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadicaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaa
aiaaaaaadccaaaakhccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaa
egiccaaaaeaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaaaaaaaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaagaabaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
adaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaahaaaaaa
egiccaaaaaaaaaaaaeaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaaiaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
aiaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaaiaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
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
#line 415
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
    highp vec4 projPos;
};
#line 406
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 429
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 429
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 433
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 437
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 441
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 445
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 449
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 453
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 457
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 461
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 465
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    #line 469
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 473
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
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
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
#line 415
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
    highp vec4 projPos;
};
#line 406
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 429
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
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
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 485
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 489
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 493
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
in highp vec4 xlv_TEXCOORD8;
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
    xlt_i.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
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
uniform vec4 _ProjectionParams;
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
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
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
  vec4 o_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_8 * 0.5);
  vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD8 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform vec4 _ZBufferParams;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
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
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 16 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 17 [_LightColor0]
Float 18 [_DistFade]
Float 19 [_DistFadeVert]
Float 20 [_MinLight]
"vs_3_0
; 114 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord8 o8
def c21, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c22, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c21.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r3, r2, v0
dp4 r2.z, r3, c7
dp3 r0.z, c2, c2
rsq r2.w, r0.z
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
dp4 r0.z, r3, c6
mov r0.w, r2.z
mul r3.xyz, r2.w, c2
mul r4.xyz, r0.xyww, c22.y
mov o0, r0
mul r4.y, r4, c14.x
mad o8.xy, r4.z, c15.zwzw, r4
mad r4.xy, v3, c21.z, c21.w
mov r4.w, v0
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.z, r4.y, -r4.y
slt r0.y, -r4, r4
sub r2.w, r0.y, r0.z
mul r0.z, r4.x, r0.x
mul r3.w, r0.x, r2
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r3
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r2, r5
slt r4.z, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.z
mul r0.x, r4, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2.w, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r2, r5.zwzw
mad o4.xy, r0, c22.x, c22.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
mul r4.x, r4, r1.y
sub r0.w, r0, r1.x
mul r1.z, r2.w, r0.w
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
mov r0.w, c21.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c22.x, c22.y
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
dp3 r0.x, r1, r1
rsq r0.w, r0.x
dp4 r0.y, c16, c16
rsq r0.y, r0.y
mul r0.xyz, r0.y, c16
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
add r0.w, r0, c22.z
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
mul r0.y, r0.w, c17.w
rsq r0.x, r0.x
mov r0.z, c20.x
mul_sat r0.w, r0.y, c22
rcp r0.x, r0.x
mul r0.y, -r0.x, c19.x
add r1.xyz, c17, r0.z
add_sat r0.y, r0, c21
mul_sat r0.x, r0, c18
mul r0.x, r0, r0.y
mul o1.w, v1, r0.x
dp4 r0.x, v0, c2
mad o3.xy, r5, c22.x, c22.y
mad_sat o7.xyz, r1, r0.w, c12
mov o8.w, r2.z
mov o1.xyz, v1
abs o2.xyz, r3
mov o8.z, -r0.x
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
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
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
// 92 instructions, 6 temp regs, 0 temp arrays:
// ALU 70 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedngokojaegnbonoidgnoajoojhkghpeapabaaaaaaheaoaaaaadaaaaaa
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
adaaaaaaagaaaaaaahaiaaaapcaaaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcimamaaaaeaaaabaacdadaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
giaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaahaaaaaa
pgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaaaaaaaaaa
egaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaak
hcaabaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
apaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
ckaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaadccaaaalecaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaaaeaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
dgcaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahiccabaaaabaaaaaackaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaa
dgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaagccaabaaa
abaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaa
adaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaa
egacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaalhcaabaaa
adaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
adaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaea
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
diaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaaafaaaaaa
dcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaaabaaaaaa
fganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaagaaaaaa
fgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaa
agiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaadaaaaaa
aeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaa
agiecaaaadaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaap
dccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaa
dbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaah
ecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaa
acaaaaaaegiacaaaadaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaa
boaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaa
cgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaa
claaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaadaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaa
dcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaam
hcaabaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaajecaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabacaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aknhcdlmdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaapnekibdp
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaa
dicaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaaj
hcaabaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaa
dccaaaakhccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaegiccaaa
aeaaaaaaaeaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaahaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
ahaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
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
    highp vec4 projPos;
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 426
#line 471
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 426
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 430
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 434
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 438
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 442
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 446
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 450
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 454
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 458
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 462
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    #line 466
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out mediump vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
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
    highp vec4 projPos;
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 426
#line 471
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
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
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    #line 487
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    return color;
}
in lowp vec4 xlv_COLOR;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in mediump vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD8;
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
    xlt_i.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
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
uniform mat4 _LightMatrix0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
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
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
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
  vec4 o_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_8 * 0.5);
  vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform vec4 _ZBufferParams;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
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
Vector 16 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [_ScreenParams]
Vector 20 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Vector 21 [_LightColor0]
Float 22 [_DistFade]
Float 23 [_DistFadeVert]
Float 24 [_MinLight]
"vs_3_0
; 122 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord6 o8
dcl_texcoord8 o9
def c25, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c26, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c25.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r3, r2, v0
dp4 r2.z, r3, c7
dp3 r0.z, c2, c2
rsq r2.w, r0.z
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
dp4 r0.z, r3, c6
mov r0.w, r2.z
mul r3.xyz, r2.w, c2
mul r4.xyz, r0.xyww, c26.y
mov o0, r0
mul r4.y, r4, c18.x
mad o9.xy, r4.z, c19.zwzw, r4
mad r4.xy, v3, c25.z, c25.w
mov r4.w, v0
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.z, r4.y, -r4.y
slt r0.y, -r4, r4
sub r2.w, r0.y, r0.z
mul r0.z, r4.x, r0.x
mul r3.w, r0.x, r2
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r3
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r2, r5
slt r4.z, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.z
mul r0.x, r4, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2.w, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r2, r5.zwzw
mad o4.xy, r0, c26.x, c26.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c17
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
mul r4.x, r4, r1.y
sub r0.w, r0, r1.x
mul r1.z, r2.w, r0.w
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
mov r0.w, c25.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c26.x, c26.y
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
dp3 r0.x, r1, r1
rsq r0.w, r0.x
dp4 r0.y, c20, c20
rsq r0.y, r0.y
mul r0.xyz, r0.y, c20
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
add r0.w, r0, c26.z
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c17
dp3 r0.x, r0, r0
mul r0.y, r0.w, c21.w
mov r0.z, c24.x
add r1.xyz, c21, r0.z
mul_sat r0.w, r0.y, c26
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c23.x
mad_sat o7.xyz, r1, r0.w, c16
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
add_sat r0.y, r0, c25
mul_sat r0.x, r0, c22
mul r0.x, r0, r0.y
mul o1.w, v1, r0.x
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.w, r0, c15
dp4 o8.z, r0, c14
dp4 o8.y, r0, c13
dp4 o8.x, r0, c12
dp4 r0.x, v0, c2
mad o3.xy, r5, c26.x, c26.y
mov o9.w, r2.z
mov o1.xyz, v1
abs o2.xyz, r3
mov o9.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Matrix 16 [_LightMatrix0] 4
Vector 80 [_LightColor0] 4
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
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
// 100 instructions, 6 temp regs, 0 temp arrays:
// ALU 78 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmnjogjdajkpeempjhjcgmebohgimnkfoabaaaaaamiapaaaaadaaaaaa
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
apaaaaaaakabaaaaaiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcmianaaaa
eaaaabaahcadaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagfaaaaadpccabaaa
aiaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
ahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
aaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaa
abaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadccaaaalecaabaaa
aaaaaaaabkiacaiaebaaaaaaaaaaaaaaaiaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpdgcaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahiccabaaaabaaaaaa
ckaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaa
abaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaag
ccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaa
ckiacaaaadaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaa
acaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaal
hcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaa
egacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaadaaaaaa
dbaaaaahicaabaaaabaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaai
aanaaaaahcaabaaaaeaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaaclaaaaaf
hcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaajgafbaaa
abaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaaabaaaaaaagaebaaaacaaaaaa
diaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaaadaaaaaadbaaaaak
mcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaa
abaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaakgaobaiaebaaaaaa
adaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaa
acaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
dcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaabaaaaaaegaabaaa
aeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaa
abaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaa
fganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaa
adaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaa
adaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaa
abaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaa
dcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
adaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaak
dcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaa
acaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaa
abaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaa
acaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaa
acaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaajecaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadicaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaa
aiaaaaaadccaaaakhccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaa
egiccaaaaeaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaaegiocaaaaaaaaaaa
acaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaaagaabaaa
abaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaa
adaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaahaaaaaa
egiocaaaaaaaaaaaaeaaaaaapgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaaiaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
aiaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaaiaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
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
#line 424
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
    highp vec4 projPos;
};
#line 415
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 438
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 438
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 442
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 446
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 450
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 454
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 458
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 462
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 466
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 470
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 474
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    #line 478
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 482
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
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
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
#line 424
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
    highp vec4 projPos;
};
#line 415
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 438
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 484
lowp vec4 frag( in v2f i ) {
    #line 486
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 490
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 494
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 498
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 502
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
in highp vec4 xlv_TEXCOORD8;
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
    xlt_i.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
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
uniform mat4 _LightMatrix0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
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
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
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
  vec4 o_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_8 * 0.5);
  vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform vec4 _ZBufferParams;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
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
Vector 16 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [_ScreenParams]
Vector 20 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Vector 21 [_LightColor0]
Float 22 [_DistFade]
Float 23 [_DistFadeVert]
Float 24 [_MinLight]
"vs_3_0
; 121 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord6 o8
dcl_texcoord8 o9
def c25, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c26, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c25.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r3, r2, v0
dp4 r2.z, r3, c7
dp3 r0.z, c2, c2
rsq r2.w, r0.z
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
dp4 r0.z, r3, c6
mov r0.w, r2.z
mul r3.xyz, r2.w, c2
mul r4.xyz, r0.xyww, c26.y
mov o0, r0
mul r4.y, r4, c18.x
mad o9.xy, r4.z, c19.zwzw, r4
mad r4.xy, v3, c25.z, c25.w
mov r4.w, v0
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.z, r4.y, -r4.y
slt r0.y, -r4, r4
sub r2.w, r0.y, r0.z
mul r0.z, r4.x, r0.x
mul r3.w, r0.x, r2
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r3
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r2, r5
slt r4.z, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.z
mul r0.x, r4, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2.w, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r2, r5.zwzw
mad o4.xy, r0, c26.x, c26.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c17
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
mul r4.x, r4, r1.y
sub r0.w, r0, r1.x
mul r1.z, r2.w, r0.w
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
mov r0.w, c25.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c26.x, c26.y
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
dp3 r0.x, r1, r1
rsq r0.w, r0.x
dp4 r0.y, c20, c20
rsq r0.y, r0.y
mul r0.xyz, r0.y, c20
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
add r0.w, r0, c26.z
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c17
dp3 r0.x, r0, r0
mul r0.y, r0.w, c21.w
mov r0.z, c24.x
add r1.xyz, c21, r0.z
mul_sat r0.w, r0.y, c26
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c23.x
mad_sat o7.xyz, r1, r0.w, c16
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
add_sat r0.y, r0, c25
mul_sat r0.x, r0, c22
mul r0.x, r0, r0.y
mul o1.w, v1, r0.x
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.z, r0, c14
dp4 o8.y, r0, c13
dp4 o8.x, r0, c12
dp4 r0.x, v0, c2
mad o3.xy, r5, c26.x, c26.y
mov o9.w, r2.z
mov o1.xyz, v1
abs o2.xyz, r3
mov o9.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Matrix 16 [_LightMatrix0] 4
Vector 80 [_LightColor0] 4
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
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
// 100 instructions, 6 temp regs, 0 temp arrays:
// ALU 78 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedfdppellhgpnpeamipmjpgimigfjgomhnabaaaaaamiapaaaaadaaaaaa
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
ahaiaaaaakabaaaaaiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcmianaaaa
eaaaabaahcadaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagfaaaaadpccabaaa
aiaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
ahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
aaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaa
abaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadccaaaalecaabaaa
aaaaaaaabkiacaiaebaaaaaaaaaaaaaaaiaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpdgcaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahiccabaaaabaaaaaa
ckaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaa
abaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaag
ccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaa
ckiacaaaadaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaa
acaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaal
hcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaa
egacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaadaaaaaa
dbaaaaahicaabaaaabaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaai
aanaaaaahcaabaaaaeaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaaclaaaaaf
hcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaajgafbaaa
abaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaaabaaaaaaagaebaaaacaaaaaa
diaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaaadaaaaaadbaaaaak
mcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaa
abaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaakgaobaiaebaaaaaa
adaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaa
acaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
dcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaabaaaaaaegaabaaa
aeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaa
abaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaa
fganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaa
adaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaa
adaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaa
abaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaa
dcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
adaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaak
dcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaa
acaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaa
abaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaa
acaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaa
acaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaajecaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
pnekibdpdiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadicaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaa
aiaaaaaadccaaaakhccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaa
egiccaaaaeaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaaaaaaaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaagaabaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
adaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaahaaaaaa
egiccaaaaaaaaaaaaeaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaaiaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
aiaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaaiaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
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
#line 416
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
    highp vec4 projPos;
};
#line 407
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 430
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 430
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 434
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 438
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 442
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 446
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 450
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 454
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 458
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 462
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 466
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    #line 470
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 474
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
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
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
#line 416
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
    highp vec4 projPos;
};
#line 407
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 430
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
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
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 486
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 490
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 494
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
in highp vec4 xlv_TEXCOORD8;
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
    xlt_i.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
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
uniform mat4 _LightMatrix0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
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
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
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
  vec4 o_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_8 * 0.5);
  vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD8 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform vec4 _ZBufferParams;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
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
Vector 16 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [_ScreenParams]
Vector 20 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Vector 21 [_LightColor0]
Float 22 [_DistFade]
Float 23 [_DistFadeVert]
Float 24 [_MinLight]
"vs_3_0
; 120 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord6 o8
dcl_texcoord8 o9
def c25, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c26, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c25.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r3, r2, v0
dp4 r2.z, r3, c7
dp3 r0.z, c2, c2
rsq r2.w, r0.z
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
dp4 r0.z, r3, c6
mov r0.w, r2.z
mul r3.xyz, r2.w, c2
mul r4.xyz, r0.xyww, c26.y
mov o0, r0
mul r4.y, r4, c18.x
mad o9.xy, r4.z, c19.zwzw, r4
mad r4.xy, v3, c25.z, c25.w
mov r4.w, v0
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.z, r4.y, -r4.y
slt r0.y, -r4, r4
sub r2.w, r0.y, r0.z
mul r0.z, r4.x, r0.x
mul r3.w, r0.x, r2
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r3
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r2, r5
slt r4.z, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.z
mul r0.x, r4, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2.w, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r2, r5.zwzw
mad o4.xy, r0, c26.x, c26.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c17
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
mul r4.x, r4, r1.y
sub r0.w, r0, r1.x
mul r1.z, r2.w, r0.w
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
mov r0.w, c25.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c26.x, c26.y
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
dp3 r0.x, r1, r1
rsq r0.w, r0.x
dp4 r0.y, c20, c20
rsq r0.y, r0.y
mul r0.xyz, r0.y, c20
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
add r0.w, r0, c26.z
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c17
dp3 r0.x, r0, r0
mul r0.y, r0.w, c21.w
mov r0.z, c24.x
add r1.xyz, c21, r0.z
mul_sat r0.w, r0.y, c26
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c23.x
mad_sat o7.xyz, r1, r0.w, c16
add_sat r0.y, r0, c25
mul_sat r0.x, r0, c22
mul r0.x, r0, r0.y
mul o1.w, v1, r0.x
dp4 r0.x, v0, c8
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.y, v0, c9
dp4 o8.y, r0, c13
dp4 o8.x, r0, c12
dp4 r0.x, v0, c2
mad o3.xy, r5, c26.x, c26.y
mov o9.w, r2.z
mov o1.xyz, v1
abs o2.xyz, r3
mov o9.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Matrix 16 [_LightMatrix0] 4
Vector 80 [_LightColor0] 4
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
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
// 100 instructions, 6 temp regs, 0 temp arrays:
// ALU 78 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedddgcbjfpcpbkkobamlilbbbmhhjpngbmabaaaaaamiapaaaaadaaaaaa
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
agaaaaaaaaaaaaaaadaaaaaaaeaaaaaaamadaaaaakabaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaakabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaaakabaaaaaiaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcmianaaaa
eaaaabaahcadaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadmccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaa
ahaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
ahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
aaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaa
abaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadccaaaalecaabaaa
aaaaaaaabkiacaiaebaaaaaaaaaaaaaaaiaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpdgcaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahiccabaaaabaaaaaa
ckaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaa
abaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaag
ccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaa
ckiacaaaadaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaa
acaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaal
hcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaa
egacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaadaaaaaa
dbaaaaahicaabaaaabaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaai
ecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaacgaaaaai
aanaaaaahcaabaaaaeaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaaclaaaaaf
hcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaajgafbaaa
abaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaaabaaaaaaagaebaaaacaaaaaa
diaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaaadaaaaaadbaaaaak
mcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaa
abaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaakgaobaiaebaaaaaa
adaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaa
acaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
dcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaabaaaaaaegaabaaa
aeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaa
abaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaa
fganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaa
adaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaa
adaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaa
abaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaa
dcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
adaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaak
dcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaa
acaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaa
abaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaa
acaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaa
acaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaidcaabaaa
acaaaaaafgafbaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaaaaaaaaaabaaaaaaagaabaaaabaaaaaaegaabaaaacaaaaaa
dcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaadaaaaaakgakbaaaabaaaaaa
egaabaaaabaaaaaadcaaaaakmccabaaaaeaaaaaaagiecaaaaaaaaaaaaeaaaaaa
pgapbaaaabaaaaaaagaebaaaabaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaia
ebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaabbaaaaajecaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
bacaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaa
aaaaaaaaafaaaaaapgipcaaaaaaaaaaaaiaaaaaadccaaaakhccabaaaagaaaaaa
egacbaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaaficcabaaaahaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaa
ahaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaahaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
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
#line 415
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
    highp vec4 projPos;
};
#line 406
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 429
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 429
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 433
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 437
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 441
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 445
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 449
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 453
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 457
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 461
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 465
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    #line 469
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    #line 473
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
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
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
#line 415
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
    highp vec4 projPos;
};
#line 406
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 429
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
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
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 485
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 489
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 493
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
in highp vec4 xlv_TEXCOORD8;
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
    xlt_i.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
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
uniform mat4 _LightMatrix0;


uniform mat4 _Object2World;

uniform mat4 unity_World2Shadow[4];
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
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
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
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
  vec4 o_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_8 * 0.5);
  vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform vec4 _ZBufferParams;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
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
Vector 20 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_ProjectionParams]
Vector 23 [_ScreenParams]
Vector 24 [_WorldSpaceLightPos0]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_LightMatrix0]
Vector 25 [_LightColor0]
Float 26 [_DistFade]
Float 27 [_DistFadeVert]
Float 28 [_MinLight]
"vs_3_0
; 126 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord6 o8
dcl_texcoord7 o9
dcl_texcoord8 o10
def c29, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c30, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c29.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r3, r2, v0
dp4 r2.z, r3, c7
dp3 r0.z, c2, c2
rsq r2.w, r0.z
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
dp4 r0.z, r3, c6
mov r0.w, r2.z
mul r3.xyz, r2.w, c2
mul r4.xyz, r0.xyww, c30.y
mov o0, r0
mul r4.y, r4, c22.x
mad o10.xy, r4.z, c23.zwzw, r4
mad r4.xy, v3, c29.z, c29.w
mov r4.w, v0
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.z, r4.y, -r4.y
slt r0.y, -r4, r4
sub r2.w, r0.y, r0.z
mul r0.z, r4.x, r0.x
mul r3.w, r0.x, r2
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r3
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r2, r5
slt r4.z, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.z
mul r0.x, r4, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2.w, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r2, r5.zwzw
mad o4.xy, r0, c30.x, c30.y
dp4 r0.z, r1, c14
dp4 r0.x, r1, c12
dp4 r0.y, r1, c13
add r0.xyz, -r0, c21
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
mul r4.x, r4, r1.y
sub r0.w, r0, r1.x
mul r1.z, r2.w, r0.w
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
mov r0.w, c29.x
dp4 r1.z, r0, c14
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c30.x, c30.y
dp4 r1.y, r0, c13
dp4 r1.x, r0, c12
dp3 r0.x, r1, r1
rsq r0.w, r0.x
dp4 r0.y, c24, c24
rsq r0.y, r0.y
mul r0.xyz, r0.y, c24
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
add r0.w, r0, c30.z
mov r0.z, c14.w
mov r0.x, c12.w
mov r0.y, c13.w
add r0.xyz, -r0, c21
dp3 r0.x, r0, r0
mul r0.y, r0.w, c25.w
mov r0.z, c28.x
add r1.xyz, c25, r0.z
mul_sat r0.w, r0.y, c30
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c27.x
mad_sat o7.xyz, r1, r0.w, c20
dp4 r0.w, v0, c15
dp4 r0.z, v0, c14
add_sat r0.y, r0, c29
mul_sat r0.x, r0, c26
mul r0.x, r0, r0.y
mul o1.w, v1, r0.x
dp4 r0.x, v0, c12
dp4 r0.y, v0, c13
dp4 o8.w, r0, c19
dp4 o8.z, r0, c18
dp4 o8.y, r0, c17
dp4 o8.x, r0, c16
dp4 o9.w, r0, c11
dp4 o9.z, r0, c10
dp4 o9.y, r0, c9
dp4 o9.x, r0, c8
dp4 r0.x, v0, c2
mad o3.xy, r5, c30.x, c30.y
mov o10.w, r2.z
mov o1.xyz, v1
abs o2.xyz, r3
mov o10.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Matrix 16 [_LightMatrix0] 4
Vector 80 [_LightColor0] 4
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityShadows" 416 // 384 used size, 8 vars
Matrix 128 [unity_World2Shadow0] 4
Matrix 192 [unity_World2Shadow1] 4
Matrix 256 [unity_World2Shadow2] 4
Matrix 320 [unity_World2Shadow3] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityShadows" 3
BindCB "UnityPerDraw" 4
BindCB "UnityPerFrame" 5
// 104 instructions, 6 temp regs, 0 temp arrays:
// ALU 82 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedeabnihgoingnadnmdjpnihjliliccjeaabaaaaaajebaaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
cmabaaaaalaaaaaaaiaaaaaabaabaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaabmabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaccabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaccabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaccabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaccabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaccabaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaccabaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaccabaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaaccabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaaccabaaaa
aiaaaaaaaaaaaaaaadaaaaaaajaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefchmaoaaaaeaaaabaajpadaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaa
fjaaaaaeegiocaaaaeaaaaaabaaaaaaafjaaaaaeegiocaaaafaaaaaaafaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
gfaaaaadpccabaaaaiaaaaaagfaaaaadpccabaaaajaaaaaagiaaaaacagaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaahaaaaaapgbpbaaaaaaaaaaa
egbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
afaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaafaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
afaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaafaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaaeaaaaaaapaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaackaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaadccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaa
aaaaaaaaaiaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaa
abaaaaaackiacaaaaeaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaa
aeaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaaeaaaaaaagaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
abaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaalhcaabaaaadaaaaaaegacbaia
ebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
hcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaap
dcaabaaaadaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
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
acaaaaaafgafbaaaacaaaaaaagiecaaaaeaaaaaaafaaaaaadcaaaaakkcaabaaa
acaaaaaaagiecaaaaeaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaa
dcaaaaakkcaabaaaacaaaaaaagiecaaaaeaaaaaaagaaaaaafgafbaaaadaaaaaa
fganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaaaeaaaaaa
afaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaaeaaaaaaaeaaaaaaagaabaaa
acaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaaeaaaaaa
agaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaa
ngafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaa
abaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaa
aeaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaa
aaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaa
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
aeaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaa
aeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaa
egiccaiaebaaaaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
acaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aeaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaabbaaaaajecaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaa
egiccaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaaiaaaaaadccaaaakhccabaaa
agaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaafaaaaaaaeaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaaeaaaaaaanaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaa
acaaaaaafgafbaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaaabaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaadaaaaaakgakbaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpccabaaaahaaaaaaegiocaaaaaaaaaaaaeaaaaaa
pgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaa
abaaaaaaegiocaaaadaaaaaaajaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
adaaaaaaaiaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaadaaaaaaakaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpccabaaaaiaaaaaaegiocaaaadaaaaaaalaaaaaapgapbaaaabaaaaaa
egaobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaajaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaajaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaaeaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
aeaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
ajaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
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
#line 430
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
    highp vec4 projPos;
};
#line 421
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 445
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 445
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 449
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 453
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 457
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 461
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 465
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 469
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 473
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 477
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 481
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    #line 485
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 490
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
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
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
#line 430
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
    highp vec4 projPos;
};
#line 421
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 445
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 492
lowp vec4 frag( in v2f i ) {
    #line 494
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 498
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 502
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 506
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 510
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
in highp vec4 xlv_TEXCOORD8;
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
    xlt_i.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
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
uniform mat4 _LightMatrix0;


uniform mat4 _Object2World;

uniform mat4 unity_World2Shadow[4];
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
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
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
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
  vec4 o_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_8 * 0.5);
  vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform vec4 _ZBufferParams;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
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
Vector 20 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_ProjectionParams]
Vector 23 [_ScreenParams]
Vector 24 [_WorldSpaceLightPos0]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_LightMatrix0]
Vector 25 [_LightColor0]
Float 26 [_DistFade]
Float 27 [_DistFadeVert]
Float 28 [_MinLight]
"vs_3_0
; 126 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord6 o8
dcl_texcoord7 o9
dcl_texcoord8 o10
def c29, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c30, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c29.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r3, r2, v0
dp4 r2.z, r3, c7
dp3 r0.z, c2, c2
rsq r2.w, r0.z
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
dp4 r0.z, r3, c6
mov r0.w, r2.z
mul r3.xyz, r2.w, c2
mul r4.xyz, r0.xyww, c30.y
mov o0, r0
mul r4.y, r4, c22.x
mad o10.xy, r4.z, c23.zwzw, r4
mad r4.xy, v3, c29.z, c29.w
mov r4.w, v0
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.z, r4.y, -r4.y
slt r0.y, -r4, r4
sub r2.w, r0.y, r0.z
mul r0.z, r4.x, r0.x
mul r3.w, r0.x, r2
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r3
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r2, r5
slt r4.z, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.z
mul r0.x, r4, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2.w, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r2, r5.zwzw
mad o4.xy, r0, c30.x, c30.y
dp4 r0.z, r1, c14
dp4 r0.x, r1, c12
dp4 r0.y, r1, c13
add r0.xyz, -r0, c21
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
mul r4.x, r4, r1.y
sub r0.w, r0, r1.x
mul r1.z, r2.w, r0.w
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
mov r0.w, c29.x
dp4 r1.z, r0, c14
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c30.x, c30.y
dp4 r1.y, r0, c13
dp4 r1.x, r0, c12
dp3 r0.x, r1, r1
rsq r0.w, r0.x
dp4 r0.y, c24, c24
rsq r0.y, r0.y
mul r0.xyz, r0.y, c24
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
add r0.w, r0, c30.z
mov r0.z, c14.w
mov r0.x, c12.w
mov r0.y, c13.w
add r0.xyz, -r0, c21
dp3 r0.x, r0, r0
mul r0.y, r0.w, c25.w
mov r0.z, c28.x
add r1.xyz, c25, r0.z
mul_sat r0.w, r0.y, c30
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c27.x
mad_sat o7.xyz, r1, r0.w, c20
dp4 r0.w, v0, c15
dp4 r0.z, v0, c14
add_sat r0.y, r0, c29
mul_sat r0.x, r0, c26
mul r0.x, r0, r0.y
mul o1.w, v1, r0.x
dp4 r0.x, v0, c12
dp4 r0.y, v0, c13
dp4 o8.w, r0, c19
dp4 o8.z, r0, c18
dp4 o8.y, r0, c17
dp4 o8.x, r0, c16
dp4 o9.w, r0, c11
dp4 o9.z, r0, c10
dp4 o9.y, r0, c9
dp4 o9.x, r0, c8
dp4 r0.x, v0, c2
mad o3.xy, r5, c30.x, c30.y
mov o10.w, r2.z
mov o1.xyz, v1
abs o2.xyz, r3
mov o10.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Matrix 16 [_LightMatrix0] 4
Vector 80 [_LightColor0] 4
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityShadows" 416 // 384 used size, 8 vars
Matrix 128 [unity_World2Shadow0] 4
Matrix 192 [unity_World2Shadow1] 4
Matrix 256 [unity_World2Shadow2] 4
Matrix 320 [unity_World2Shadow3] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityShadows" 3
BindCB "UnityPerDraw" 4
BindCB "UnityPerFrame" 5
// 104 instructions, 6 temp regs, 0 temp arrays:
// ALU 82 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedeabnihgoingnadnmdjpnihjliliccjeaabaaaaaajebaaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
cmabaaaaalaaaaaaaiaaaaaabaabaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaabmabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaccabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaccabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaccabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaccabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaccabaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaccabaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaccabaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaaccabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaaccabaaaa
aiaaaaaaaaaaaaaaadaaaaaaajaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefchmaoaaaaeaaaabaajpadaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaa
fjaaaaaeegiocaaaaeaaaaaabaaaaaaafjaaaaaeegiocaaaafaaaaaaafaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
gfaaaaadpccabaaaaiaaaaaagfaaaaadpccabaaaajaaaaaagiaaaaacagaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaahaaaaaapgbpbaaaaaaaaaaa
egbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
afaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaafaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
afaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaafaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaaeaaaaaaapaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaackaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaadccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaa
aaaaaaaaaiaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaa
abaaaaaackiacaaaaeaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaa
aeaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaaeaaaaaaagaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
abaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaalhcaabaaaadaaaaaaegacbaia
ebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
hcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaap
dcaabaaaadaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
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
acaaaaaafgafbaaaacaaaaaaagiecaaaaeaaaaaaafaaaaaadcaaaaakkcaabaaa
acaaaaaaagiecaaaaeaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaa
dcaaaaakkcaabaaaacaaaaaaagiecaaaaeaaaaaaagaaaaaafgafbaaaadaaaaaa
fganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaaaeaaaaaa
afaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaaeaaaaaaaeaaaaaaagaabaaa
acaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaaeaaaaaa
agaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaa
ngafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaa
abaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaa
aeaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaa
aaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaa
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
aeaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaa
aeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaa
egiccaiaebaaaaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
acaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aeaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaabbaaaaajecaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadicaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaa
egiccaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaaaiaaaaaadccaaaakhccabaaa
agaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaafaaaaaaaeaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaaeaaaaaaanaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaa
acaaaaaafgafbaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaaabaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaadaaaaaakgakbaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpccabaaaahaaaaaaegiocaaaaaaaaaaaaeaaaaaa
pgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaa
abaaaaaaegiocaaaadaaaaaaajaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
adaaaaaaaiaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaadaaaaaaakaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpccabaaaaiaaaaaaegiocaaaadaaaaaaalaaaaaapgapbaaaabaaaaaa
egaobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaajaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaajaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaaeaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
aeaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
ajaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
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
#line 431
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
    highp vec4 projPos;
};
#line 422
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 446
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 446
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 450
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 454
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 458
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 462
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 466
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 470
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 474
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 478
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 482
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    #line 486
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 491
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
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
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
#line 333
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
    highp vec3 camPos;
    mediump vec3 baseLight;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec4 projPos;
};
#line 422
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 446
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 493
lowp vec4 frag( in v2f i ) {
    #line 495
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 499
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 503
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 507
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 511
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
in highp vec4 xlv_TEXCOORD8;
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
    xlt_i.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
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
uniform vec4 _ProjectionParams;
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
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
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
  vec4 o_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_8 * 0.5);
  vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_21;
  vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_8 * 0.5);
  vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = o_21;
  xlv_TEXCOORD8 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform vec4 _ZBufferParams;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
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
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 16 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Vector 17 [_LightColor0]
Float 18 [_DistFade]
Float 19 [_DistFadeVert]
Float 20 [_MinLight]
"vs_3_0
; 116 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord6 o8
dcl_texcoord8 o9
def c21, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c22, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c21.x
mov r1.w, v0
dp4 r4.x, r1, c0
dp4 r4.y, r1, c1
dp4 r4.w, r1, c3
dp4 r4.z, r1, c2
add r2, r4, v0
dp4 r0.w, r2, c7
mov r3.w, r0
dp4 r3.z, r2, c6
dp4 r3.x, r2, c4
dp4 r3.y, r2, c5
mul r0.xyz, r3.xyww, c22.y
mov o0, r3
mov o8.zw, r3
mul r0.y, r0, c14.x
mad r0.xy, r0.z, c15.zwzw, r0
dp4 r0.z, v0, c2
mov r0.z, -r0
mad r3.xy, v3, c21.z, c21.w
mov o9, r0
mov o8.xy, r0
dp3 r0.x, c2, c2
rsq r0.x, r0.x
mul r2.xyz, r0.x, c2
mov r3.w, v0
slt r0.z, r3.y, -r3.y
slt r0.y, -r2.x, r2.x
slt r0.x, r2, -r2
sub r0.x, r0, r0.y
slt r0.y, -r3, r3
sub r2.w, r0.y, r0.z
mul r0.z, r3.x, r0.x
mul r3.z, r0.x, r2.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r2.y, r3.z
mul r0.x, r0.y, r0
mad r0.x, r2.z, r0, r0.w
mov r0.yw, r3
dp4 r4.w, r0, c1
slt r4.z, -r2.y, r2.y
slt r3.z, r2.y, -r2.y
sub r3.z, r3, r4
dp4 r4.z, r0, c0
mul r0.x, r3, r3.z
add r4.zw, -r4.xyxy, r4
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2.w, r3
mul r0.y, r0, r3.z
mul r3.z, r2, r0
mov r0.zw, r3.xyyw
mad r0.y, r2.x, r0, r3.z
dp4 r5.x, r0, c0
dp4 r5.y, r0, c1
add r0.xy, -r4, r5
mad o4.xy, r0, c22.x, c22.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c13
slt r1.x, -r2.z, r2.z
slt r0.w, r2.z, -r2.z
sub r1.y, r1.x, r0.w
mul r3.x, r3, r1.y
sub r0.w, r0, r1.x
mul r1.z, r2.w, r0.w
slt r1.y, r3.x, -r3.x
slt r1.x, -r3, r3
sub r1.x, r1, r1.y
mul r0.w, r0, r1.x
mul r1.y, r2, r1.z
mad r3.z, r2.x, r0.w, r1.y
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o6.xyz, r0.w, r0
mov r0.xyz, v2
mov r0.w, c21.x
dp4 r1.z, r0, c10
dp4 r1.x, r3, c0
dp4 r1.y, r3, c1
add r1.xy, -r4, r1
mad o5.xy, r1, c22.x, c22.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c16, c16
rsq r0.y, r0.y
mul r3.xyz, r0.y, c16
dp3_sat r0.w, r1, r3
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c13
dp3 r0.x, r0, r0
add r0.y, r0.w, c22.z
mul r0.y, r0, c17.w
rsq r0.x, r0.x
mov r0.z, c20.x
rcp r0.x, r0.x
mul_sat r0.w, r0.y, c22
mul r0.y, -r0.x, c19.x
add r1.xyz, c17, r0.z
mul_sat r0.x, r0, c18
add_sat r0.y, r0, c21
mul r0.x, r0, r0.y
mad o3.xy, r4.zwzw, c22.x, c22.y
mad_sat o7.xyz, r1, r0.w, c12
mul o1.w, v1, r0.x
mov o1.xyz, v1
abs o2.xyz, r2
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
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
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
// 94 instructions, 6 temp regs, 0 temp arrays:
// ALU 71 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedpmajigcnehhfjbjcgnlmcnhcokcheclaabaaaaaamiaoaaaaadaaaaaa
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
apaaaaaaakabaaaaaiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklfdeieefcmiamaaaa
eaaaabaadcadaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagfaaaaadpccabaaa
aiaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
ahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
aaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaaapaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaadccaaaalbcaabaaa
abaaaaaabkiacaiaebaaaaaaaaaaaaaaaiaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaiadpdgcaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahiccabaaaabaaaaaa
akaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaa
abaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaadgaaaaag
ccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaa
ckiacaaaadaaaaaaagaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaa
acaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaal
hcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaa
egacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaadbaaaaahicaabaaaabaaaaaaabeaaaaaaaaaaaaabkaabaaaadaaaaaa
dbaaaaahicaabaaaacaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaaaaboaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaacgaaaaai
aanaaaaahcaabaaaaeaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaclaaaaaf
hcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaajgafbaaa
abaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaaabaaaaaaagaebaaaacaaaaaa
diaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaaadaaaaaadbaaaaak
mcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafganbaaa
abaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaakgaobaiaebaaaaaa
adaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaaegaabaaa
acaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
dcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaabaaaaaaegaabaaa
aeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaaadaaaaaa
afaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaaeaaaaaapgapbaaa
abaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaa
agaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaa
fganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaa
adaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaa
adaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaa
abaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaa
dcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaah
ccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaahecaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaaabaaaaaa
bkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaaclaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
adaaaaaadbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaabkaabaaaabaaaaaa
dbaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaak
dcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaafgafbaaaabaaaaaangafbaaa
acaaaaaaboaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaadkaabaaa
abaaaaaacgaaaaaiaanaaaaaccaabaaaabaaaaaabkaabaaaabaaaaaackaabaaa
acaaaaaaclaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaaagaabaaaabaaaaaaegaabaaa
acaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhccabaaaafaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaabbaaaaajicaabaaa
abaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaa
abaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaknhcdlmdiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
pnekibdpdiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
afaaaaaadicaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiaea
aaaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaaafaaaaaapgipcaaaaaaaaaaa
aiaaaaaadccaaaakhccabaaaagaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaa
egiccaaaaeaaaaaaaeaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadgaaaaafpccabaaaahaaaaaaegaobaaaaaaaaaaa
dgaaaaaflccabaaaaiaaaaaaegambaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaaiaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 unity_World2Shadow[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_32;
  highp vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_34;
  tmpvar_34.x = tmpvar_33.x;
  tmpvar_34.y = (tmpvar_33.y * _ProjectionParams.x);
  o_32.xy = (tmpvar_34 + tmpvar_33.w);
  o_32.zw = tmpvar_12.zw;
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = o_32;
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
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
    highp vec4 _ShadowCoord;
    highp vec4 projPos;
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 435
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 435
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 439
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 443
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 447
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 451
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 455
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 459
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 463
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 467
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 471
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    #line 475
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 479
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
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
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
    highp vec4 _ShadowCoord;
    highp vec4 projPos;
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 435
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 481
lowp vec4 frag( in v2f i ) {
    #line 483
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 487
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 491
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 495
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 499
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
in highp vec4 xlv_TEXCOORD8;
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
    xlt_i.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
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
uniform mat4 _LightMatrix0;


uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
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
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
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
  vec4 o_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_8 * 0.5);
  vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  vec4 o_21;
  vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_8 * 0.5);
  vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD7 = o_21;
  xlv_TEXCOORD8 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform vec4 _ZBufferParams;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
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
Vector 16 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [_ScreenParams]
Vector 20 [_WorldSpaceLightPos0]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Vector 21 [_LightColor0]
Float 22 [_DistFade]
Float 23 [_DistFadeVert]
Float 24 [_MinLight]
"vs_3_0
; 122 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord6 o8
dcl_texcoord7 o9
dcl_texcoord8 o10
def c25, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c26, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c25.x
mov r1.w, v0
dp4 r4.x, r1, c0
dp4 r4.y, r1, c1
dp4 r4.w, r1, c3
dp4 r4.z, r1, c2
add r2, r4, v0
dp4 r0.w, r2, c7
mov r3.w, r0
dp4 r3.z, r2, c6
dp4 r3.x, r2, c4
dp4 r3.y, r2, c5
mul r0.xyz, r3.xyww, c26.y
mov o0, r3
mov o9.zw, r3
mul r0.y, r0, c18.x
mad r0.xy, r0.z, c19.zwzw, r0
dp4 r0.z, v0, c2
mov r0.z, -r0
mad r3.xy, v3, c25.z, c25.w
mov o10, r0
mov o9.xy, r0
dp3 r0.x, c2, c2
rsq r0.x, r0.x
mul r2.xyz, r0.x, c2
mov r3.w, v0
slt r0.z, r3.y, -r3.y
slt r0.y, -r2.x, r2.x
slt r0.x, r2, -r2
sub r0.x, r0, r0.y
slt r0.y, -r3, r3
sub r2.w, r0.y, r0.z
mul r0.z, r3.x, r0.x
mul r3.z, r0.x, r2.w
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r2.y, r3.z
mul r0.x, r0.y, r0
mad r0.x, r2.z, r0, r0.w
mov r0.yw, r3
dp4 r4.w, r0, c1
slt r4.z, -r2.y, r2.y
slt r3.z, r2.y, -r2.y
sub r3.z, r3, r4
dp4 r4.z, r0, c0
mul r0.x, r3, r3.z
add r4.zw, -r4.xyxy, r4
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2.w, r3
mul r0.y, r0, r3.z
mul r3.z, r2, r0
mov r0.zw, r3.xyyw
mad r0.y, r2.x, r0, r3.z
dp4 r5.x, r0, c0
dp4 r5.y, r0, c1
add r0.xy, -r4, r5
mad o4.xy, r0, c26.x, c26.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c17
slt r1.x, -r2.z, r2.z
slt r0.w, r2.z, -r2.z
sub r1.y, r1.x, r0.w
mul r3.x, r3, r1.y
sub r0.w, r0, r1.x
mul r1.z, r2.w, r0.w
slt r1.y, r3.x, -r3.x
slt r1.x, -r3, r3
sub r1.x, r1, r1.y
mul r0.w, r0, r1.x
mul r1.y, r2, r1.z
mad r3.z, r2.x, r0.w, r1.y
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o6.xyz, r0.w, r0
mov r0.xyz, v2
mov r0.w, c25.x
dp4 r1.z, r0, c10
dp4 r1.x, r3, c0
dp4 r1.y, r3, c1
add r1.xy, -r4, r1
mad o5.xy, r1, c26.x, c26.y
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
dp4 r0.y, c20, c20
rsq r0.y, r0.y
mul r3.xyz, r0.y, c20
dp3_sat r0.w, r1, r3
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c17
dp3 r0.x, r0, r0
add r0.y, r0.w, c26.z
mul r0.y, r0, c21.w
mov r0.z, c24.x
add r1.xyz, c21, r0.z
mul_sat r0.w, r0.y, c26
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c23.x
mad_sat o7.xyz, r1, r0.w, c16
add_sat r0.y, r0, c25
mul_sat r0.x, r0, c22
mul r0.x, r0, r0.y
mul o1.w, v1, r0.x
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mad o3.xy, r4.zwzw, c26.x, c26.y
dp4 o8.y, r0, c13
dp4 o8.x, r0, c12
mov o1.xyz, v1
abs o2.xyz, r2
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 224 // 208 used size, 11 vars
Matrix 80 [_LightMatrix0] 4
Vector 144 [_LightColor0] 4
Float 192 [_DistFade]
Float 196 [_DistFadeVert]
Float 204 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
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
// 102 instructions, 6 temp regs, 0 temp arrays:
// ALU 79 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmjbkofbkppkkipifeejmhbhdecfgmdmdabaaaaaabmbaaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
cmabaaaaalaaaaaaaiaaaaaabaabaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaabmabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaccabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaccabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaccabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaccabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaccabaaaa
agaaaaaaaaaaaaaaadaaaaaaaeaaaaaaamadaaaaccabaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaccabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaaccabaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaccabaaaa
aiaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcaeaoaaaaeaaaabaaibadaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagfaaaaadmccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagfaaaaad
pccabaaaaiaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaaaaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaaapaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaadccaaaal
bcaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaiadpdgcaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahiccabaaa
abaaaaaaakaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egbcbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaa
dgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaa
abaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
dbaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaa
acaaaaaaegacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaadbaaaaahicaabaaaabaaaaaaabeaaaaaaaaaaaaabkaabaaa
adaaaaaadbaaaaahicaabaaaacaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaaaa
boaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaa
cgaaaaaiaanaaaaahcaabaaaaeaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
claaaaafhcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaa
jgafbaaaabaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaaabaaaaaaagaebaaa
acaaaaaadiaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaaadaaaaaa
dbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
fganbaaaabaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaakgaobaia
ebaaaaaaadaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaa
egaabaaaacaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaa
acaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaabaaaaaa
egaabaaaaeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaaeaaaaaa
pgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaa
adaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdp
aceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaa
fgafbaaaadaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaa
agibcaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaa
adaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiccaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaaclaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
akaabaaaadaaaaaadbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaabkaabaaa
abaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaakdcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaafgafbaaaabaaaaaa
ngafbaaaacaaaaaaboaaaaaiccaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaa
dkaabaaaabaaaaaacgaaaaaiaanaaaaaccaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaacaaaaaaclaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaa
dcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaaagaabaaaabaaaaaa
egaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaa
jkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaai
dcaabaaaacaaaaaafgafbaaaabaaaaaaegiacaaaaaaaaaaaagaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaaaaaaaaaafaaaaaaagaabaaaabaaaaaaegaabaaa
acaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaahaaaaaakgakbaaa
abaaaaaaegaabaaaabaaaaaadcaaaaakmccabaaaaeaaaaaaagiecaaaaaaaaaaa
aiaaaaaapgapbaaaabaaaaaaagaebaaaabaaaaaadcaaaaamhcaabaaaabaaaaaa
egiccaiaebaaaaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaaafaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaabbaaaaajicaabaaaabaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaabaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
aaaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaapnekibdpdiaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaajaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiaeaaaaaaaajocaabaaaabaaaaaa
agijcaaaaaaaaaaaajaaaaaapgipcaaaaaaaaaaaamaaaaaadccaaaakhccabaaa
agaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaaegiccaaaaeaaaaaaaeaaaaaa
diaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaaaaaaaaahdcaabaaaaaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
dgaaaaafpccabaaaahaaaaaaegaobaaaaaaaaaaadgaaaaaflccabaaaaiaaaaaa
egambaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
dgaaaaageccabaaaaiaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_World2Shadow[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  highp vec4 o_32;
  highp vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_34;
  tmpvar_34.x = tmpvar_33.x;
  tmpvar_34.y = (tmpvar_33.y * _ProjectionParams.x);
  o_32.xy = (tmpvar_34 + tmpvar_33.w);
  o_32.zw = tmpvar_12.zw;
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD7 = o_32;
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
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
#line 423
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
    highp vec4 projPos;
};
#line 414
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 438
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 438
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 442
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 446
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 450
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 454
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 458
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 462
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 466
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 470
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 474
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    #line 478
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 483
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
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
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
#line 423
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
    highp vec4 projPos;
};
#line 414
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 438
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 485
lowp vec4 frag( in v2f i ) {
    #line 487
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 491
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 495
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 499
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 503
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
in highp vec4 xlv_TEXCOORD8;
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
    xlt_i.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
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
uniform mat4 _LightMatrix0;


uniform mat4 _Object2World;

uniform vec4 _LightPositionRange;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
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
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
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
  vec4 o_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_8 * 0.5);
  vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform vec4 _ZBufferParams;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
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
Vector 16 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [_ScreenParams]
Vector 20 [_WorldSpaceLightPos0]
Vector 21 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Vector 22 [_LightColor0]
Float 23 [_DistFade]
Float 24 [_DistFadeVert]
Float 25 [_MinLight]
"vs_3_0
; 122 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord6 o8
dcl_texcoord7 o9
dcl_texcoord8 o10
def c26, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c27, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c26.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r3, r2, v0
dp4 r2.z, r3, c7
dp3 r0.z, c2, c2
rsq r2.w, r0.z
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
dp4 r0.z, r3, c6
mov r0.w, r2.z
mul r3.xyz, r2.w, c2
mul r4.xyz, r0.xyww, c27.y
mov o0, r0
mul r4.y, r4, c18.x
mad o10.xy, r4.z, c19.zwzw, r4
mad r4.xy, v3, c26.z, c26.w
mov r4.w, v0
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.z, r4.y, -r4.y
slt r0.y, -r4, r4
sub r2.w, r0.y, r0.z
mul r0.z, r4.x, r0.x
mul r3.w, r0.x, r2
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r3
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r2, r5
slt r4.z, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.z
mul r0.x, r4, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2.w, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r2, r5.zwzw
mad o4.xy, r0, c27.x, c27.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c17
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
mul r4.x, r4, r1.y
sub r0.w, r0, r1.x
mul r1.z, r2.w, r0.w
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
mov r0.w, c26.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c27.x, c27.y
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
dp3 r0.x, r1, r1
rsq r0.w, r0.x
dp4 r0.y, c20, c20
rsq r0.y, r0.y
mul r0.xyz, r0.y, c20
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
add r0.w, r0, c27.z
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c17
dp3 r0.x, r0, r0
mul r0.y, r0.w, c22.w
mov r0.z, c25.x
add r1.xyz, c22, r0.z
mul_sat r0.w, r0.y, c27
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c24.x
mad_sat o7.xyz, r1, r0.w, c16
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
add_sat r0.y, r0, c26
mul_sat r0.x, r0, c23
mul r0.x, r0, r0.y
mul o1.w, v1, r0.x
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.z, r0, c14
dp4 o8.y, r0, c13
dp4 o8.x, r0, c12
dp4 r0.w, v0, c2
mad o3.xy, r5, c27.x, c27.y
mov o10.w, r2.z
mov o1.xyz, v1
abs o2.xyz, r3
add o9.xyz, r0, -c21
mov o10.z, -r0.w
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Matrix 16 [_LightMatrix0] 4
Vector 80 [_LightColor0] 4
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 32 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
Vector 16 [_LightPositionRange] 4
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
// 102 instructions, 6 temp regs, 0 temp arrays:
// ALU 80 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedblconmfkmddjgjdbdekibcfehkkafpclabaaaaaadibaaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
cmabaaaaalaaaaaaaiaaaaaabaabaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaabmabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaccabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaccabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaccabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaccabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaccabaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaccabaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaccabaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaaccabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaahaiaaaaccabaaaa
aiaaaaaaaaaaaaaaadaaaaaaajaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaaoaaaaeaaaabaaiiadaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadhccabaaaahaaaaaagfaaaaadhccabaaaaiaaaaaagfaaaaad
pccabaaaajaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaaaaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadccaaaal
ecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaaiaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpdgcaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahiccabaaa
abaaaaaackaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egbcbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaa
dgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaa
abaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
dbaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaa
acaaaaaaegacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaa
adaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
cgaaaaaiaanaaaaahcaabaaaaeaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaa
claaaaafhcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaa
jgafbaaaabaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaaabaaaaaaagaebaaa
acaaaaaadiaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaaadaaaaaa
dbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
fganbaaaabaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaakgaobaia
ebaaaaaaadaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaa
egaabaaaacaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaa
acaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaabaaaaaa
egaabaaaaeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaaeaaaaaa
pgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaa
adaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdp
aceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaa
fgafbaaaadaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaa
agibcaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaa
adaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaadaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaa
aaaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dcaaaaakdcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaakgakbaaaaaaaaaaa
ngafbaaaacaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaa
ckaabaaaabaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaacaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaa
dcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaakgakbaaaaaaaaaaa
egaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaa
jkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaaj
ecaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaa
kgakbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaknhcdlmdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaapnekibdpdiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaa
aaaaaaaaafaaaaaadicaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaapgipcaaa
aaaaaaaaaiaaaaaadccaaaakhccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaa
aaaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaaaiaaaaaaegacbaaa
abaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaacaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaabaaaaaaagaabaaaacaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaakgakbaaaacaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaaaaaaaaaaaeaaaaaapgapbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaajaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaajaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaajaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
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
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec4 projPos;
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 443
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 443
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 447
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 451
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 455
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 459
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 463
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 467
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 471
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 475
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 479
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    #line 483
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    #line 488
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
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
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
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec4 projPos;
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 443
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 490
lowp vec4 frag( in v2f i ) {
    #line 492
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 496
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 500
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 504
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 508
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
in highp vec4 xlv_TEXCOORD8;
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
    xlt_i.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
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
uniform mat4 _LightMatrix0;


uniform mat4 _Object2World;

uniform vec4 _LightPositionRange;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
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
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
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
  vec4 o_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_8 * 0.5);
  vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform vec4 _ZBufferParams;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
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
Vector 16 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [_ScreenParams]
Vector 20 [_WorldSpaceLightPos0]
Vector 21 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Vector 22 [_LightColor0]
Float 23 [_DistFade]
Float 24 [_DistFadeVert]
Float 25 [_MinLight]
"vs_3_0
; 122 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord6 o8
dcl_texcoord7 o9
dcl_texcoord8 o10
def c26, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c27, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c26.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r3, r2, v0
dp4 r2.z, r3, c7
dp3 r0.z, c2, c2
rsq r2.w, r0.z
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
dp4 r0.z, r3, c6
mov r0.w, r2.z
mul r3.xyz, r2.w, c2
mul r4.xyz, r0.xyww, c27.y
mov o0, r0
mul r4.y, r4, c18.x
mad o10.xy, r4.z, c19.zwzw, r4
mad r4.xy, v3, c26.z, c26.w
mov r4.w, v0
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.z, r4.y, -r4.y
slt r0.y, -r4, r4
sub r2.w, r0.y, r0.z
mul r0.z, r4.x, r0.x
mul r3.w, r0.x, r2
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r3
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r2, r5
slt r4.z, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.z
mul r0.x, r4, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2.w, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r2, r5.zwzw
mad o4.xy, r0, c27.x, c27.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c17
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
mul r4.x, r4, r1.y
sub r0.w, r0, r1.x
mul r1.z, r2.w, r0.w
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
mov r0.w, c26.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c27.x, c27.y
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
dp3 r0.x, r1, r1
rsq r0.w, r0.x
dp4 r0.y, c20, c20
rsq r0.y, r0.y
mul r0.xyz, r0.y, c20
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
add r0.w, r0, c27.z
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c17
dp3 r0.x, r0, r0
mul r0.y, r0.w, c22.w
mov r0.z, c25.x
add r1.xyz, c22, r0.z
mul_sat r0.w, r0.y, c27
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c24.x
mad_sat o7.xyz, r1, r0.w, c16
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
add_sat r0.y, r0, c26
mul_sat r0.x, r0, c23
mul r0.x, r0, r0.y
mul o1.w, v1, r0.x
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.z, r0, c14
dp4 o8.y, r0, c13
dp4 o8.x, r0, c12
dp4 r0.w, v0, c2
mad o3.xy, r5, c27.x, c27.y
mov o10.w, r2.z
mov o1.xyz, v1
abs o2.xyz, r3
add o9.xyz, r0, -c21
mov o10.z, -r0.w
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Matrix 16 [_LightMatrix0] 4
Vector 80 [_LightColor0] 4
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 32 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
Vector 16 [_LightPositionRange] 4
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
// 102 instructions, 6 temp regs, 0 temp arrays:
// ALU 80 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedblconmfkmddjgjdbdekibcfehkkafpclabaaaaaadibaaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
cmabaaaaalaaaaaaaiaaaaaabaabaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaabmabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaccabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaccabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaccabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaccabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaccabaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaccabaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaccabaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaaccabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaahaiaaaaccabaaaa
aiaaaaaaaaaaaaaaadaaaaaaajaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaaoaaaaeaaaabaaiiadaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadhccabaaaahaaaaaagfaaaaadhccabaaaaiaaaaaagfaaaaad
pccabaaaajaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaaaaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadccaaaal
ecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaaiaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpdgcaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahiccabaaa
abaaaaaackaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egbcbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaa
dgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaa
abaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
dbaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaa
acaaaaaaegacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaa
adaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
cgaaaaaiaanaaaaahcaabaaaaeaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaa
claaaaafhcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaa
jgafbaaaabaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaaabaaaaaaagaebaaa
acaaaaaadiaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaaadaaaaaa
dbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
fganbaaaabaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaakgaobaia
ebaaaaaaadaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaa
egaabaaaacaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaa
acaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaabaaaaaa
egaabaaaaeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaaeaaaaaa
pgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaa
adaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdp
aceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaa
fgafbaaaadaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaa
agibcaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaa
adaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaadaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaa
aaaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dcaaaaakdcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaakgakbaaaaaaaaaaa
ngafbaaaacaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaa
ckaabaaaabaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaacaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaa
dcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaakgakbaaaaaaaaaaa
egaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaa
jkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaaj
ecaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaa
kgakbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaknhcdlmdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaapnekibdpdiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaa
aaaaaaaaafaaaaaadicaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaapgipcaaa
aaaaaaaaaiaaaaaadccaaaakhccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaa
aaaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaaaiaaaaaaegacbaaa
abaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaacaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaabaaaaaaagaabaaaacaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaakgakbaaaacaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaaaaaaaaaaaeaaaaaapgapbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaajaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaajaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaajaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
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
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec4 projPos;
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 444
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 444
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 448
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 452
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 456
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 460
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 464
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 468
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 472
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 476
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 480
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    #line 484
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    #line 489
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
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
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
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec4 projPos;
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 444
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 491
lowp vec4 frag( in v2f i ) {
    #line 493
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 497
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 501
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 505
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 509
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
in highp vec4 xlv_TEXCOORD8;
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
    xlt_i.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
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
uniform mat4 _LightMatrix0;


uniform mat4 _Object2World;

uniform mat4 unity_World2Shadow[4];
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
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
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
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
  vec4 o_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_8 * 0.5);
  vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform vec4 _ZBufferParams;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
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
Vector 20 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_ProjectionParams]
Vector 23 [_ScreenParams]
Vector 24 [_WorldSpaceLightPos0]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_LightMatrix0]
Vector 25 [_LightColor0]
Float 26 [_DistFade]
Float 27 [_DistFadeVert]
Float 28 [_MinLight]
"vs_3_0
; 126 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord6 o8
dcl_texcoord7 o9
dcl_texcoord8 o10
def c29, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c30, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c29.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r3, r2, v0
dp4 r2.z, r3, c7
dp3 r0.z, c2, c2
rsq r2.w, r0.z
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
dp4 r0.z, r3, c6
mov r0.w, r2.z
mul r3.xyz, r2.w, c2
mul r4.xyz, r0.xyww, c30.y
mov o0, r0
mul r4.y, r4, c22.x
mad o10.xy, r4.z, c23.zwzw, r4
mad r4.xy, v3, c29.z, c29.w
mov r4.w, v0
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.z, r4.y, -r4.y
slt r0.y, -r4, r4
sub r2.w, r0.y, r0.z
mul r0.z, r4.x, r0.x
mul r3.w, r0.x, r2
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r3
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r2, r5
slt r4.z, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.z
mul r0.x, r4, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2.w, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r2, r5.zwzw
mad o4.xy, r0, c30.x, c30.y
dp4 r0.z, r1, c14
dp4 r0.x, r1, c12
dp4 r0.y, r1, c13
add r0.xyz, -r0, c21
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
mul r4.x, r4, r1.y
sub r0.w, r0, r1.x
mul r1.z, r2.w, r0.w
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
mov r0.w, c29.x
dp4 r1.z, r0, c14
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c30.x, c30.y
dp4 r1.y, r0, c13
dp4 r1.x, r0, c12
dp3 r0.x, r1, r1
rsq r0.w, r0.x
dp4 r0.y, c24, c24
rsq r0.y, r0.y
mul r0.xyz, r0.y, c24
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
add r0.w, r0, c30.z
mov r0.z, c14.w
mov r0.x, c12.w
mov r0.y, c13.w
add r0.xyz, -r0, c21
dp3 r0.x, r0, r0
mul r0.y, r0.w, c25.w
mov r0.z, c28.x
add r1.xyz, c25, r0.z
mul_sat r0.w, r0.y, c30
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c27.x
mad_sat o7.xyz, r1, r0.w, c20
dp4 r0.w, v0, c15
dp4 r0.z, v0, c14
add_sat r0.y, r0, c29
mul_sat r0.x, r0, c26
mul r0.x, r0, r0.y
mul o1.w, v1, r0.x
dp4 r0.x, v0, c12
dp4 r0.y, v0, c13
dp4 o8.w, r0, c19
dp4 o8.z, r0, c18
dp4 o8.y, r0, c17
dp4 o8.x, r0, c16
dp4 o9.w, r0, c11
dp4 o9.z, r0, c10
dp4 o9.y, r0, c9
dp4 o9.x, r0, c8
dp4 r0.x, v0, c2
mad o3.xy, r5, c30.x, c30.y
mov o10.w, r2.z
mov o1.xyz, v1
abs o2.xyz, r3
mov o10.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 224 // 208 used size, 11 vars
Matrix 80 [_LightMatrix0] 4
Vector 144 [_LightColor0] 4
Float 192 [_DistFade]
Float 196 [_DistFadeVert]
Float 204 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityShadows" 416 // 384 used size, 8 vars
Matrix 128 [unity_World2Shadow0] 4
Matrix 192 [unity_World2Shadow1] 4
Matrix 256 [unity_World2Shadow2] 4
Matrix 320 [unity_World2Shadow3] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityShadows" 3
BindCB "UnityPerDraw" 4
BindCB "UnityPerFrame" 5
// 104 instructions, 6 temp regs, 0 temp arrays:
// ALU 82 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmdioemjnngegpbenememnoaedeajdoeeabaaaaaajebaaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
cmabaaaaalaaaaaaaiaaaaaabaabaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaabmabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaccabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaccabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaccabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaccabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaccabaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaccabaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaccabaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaaccabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaaccabaaaa
aiaaaaaaaaaaaaaaadaaaaaaajaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefchmaoaaaaeaaaabaajpadaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaa
fjaaaaaeegiocaaaaeaaaaaabaaaaaaafjaaaaaeegiocaaaafaaaaaaafaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
gfaaaaadpccabaaaaiaaaaaagfaaaaadpccabaaaajaaaaaagiaaaaacagaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaahaaaaaapgbpbaaaaaaaaaaa
egbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
afaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaafaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
afaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaafaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaaeaaaaaaapaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaackaabaaaaaaaaaaa
akiacaaaaaaaaaaaamaaaaaadccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaa
aaaaaaaaamaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaa
abaaaaaackiacaaaaeaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaa
aeaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaaeaaaaaaagaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
abaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaalhcaabaaaadaaaaaaegacbaia
ebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
hcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaap
dcaabaaaadaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
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
acaaaaaafgafbaaaacaaaaaaagiecaaaaeaaaaaaafaaaaaadcaaaaakkcaabaaa
acaaaaaaagiecaaaaeaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaa
dcaaaaakkcaabaaaacaaaaaaagiecaaaaeaaaaaaagaaaaaafgafbaaaadaaaaaa
fganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaaaeaaaaaa
afaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaaeaaaaaaaeaaaaaaagaabaaa
acaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaaeaaaaaa
agaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaa
ngafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaa
abaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaa
aeaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaa
aaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaa
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
aeaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaa
aeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaa
egiccaiaebaaaaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
acaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aeaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaabbaaaaajecaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaadicaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaa
egiccaaaaaaaaaaaajaaaaaapgipcaaaaaaaaaaaamaaaaaadccaaaakhccabaaa
agaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaafaaaaaaaeaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaaeaaaaaaanaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaa
acaaaaaafgafbaaaabaaaaaaegiocaaaaaaaaaaaagaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaaafaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaahaaaaaakgakbaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpccabaaaahaaaaaaegiocaaaaaaaaaaaaiaaaaaa
pgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaa
abaaaaaaegiocaaaadaaaaaaajaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
adaaaaaaaiaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaadaaaaaaakaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpccabaaaaiaaaaaaegiocaaaadaaaaaaalaaaaaapgapbaaaabaaaaaa
egaobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaajaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaajaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaaeaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
aeaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
ajaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
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
#line 438
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
    highp vec4 projPos;
};
#line 429
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 453
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 453
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 457
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 461
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 465
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 469
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 473
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 477
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 481
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 485
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 489
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    #line 493
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 498
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
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
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
#line 340
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 438
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
    highp vec4 projPos;
};
#line 429
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 453
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 500
lowp vec4 frag( in v2f i ) {
    #line 502
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 506
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 510
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 514
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 518
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
in highp vec4 xlv_TEXCOORD8;
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
    xlt_i.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
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
uniform mat4 _LightMatrix0;


uniform mat4 _Object2World;

uniform mat4 unity_World2Shadow[4];
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
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
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
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
  vec4 o_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_8 * 0.5);
  vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD8 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform vec4 _ZBufferParams;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
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
Vector 20 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_ProjectionParams]
Vector 23 [_ScreenParams]
Vector 24 [_WorldSpaceLightPos0]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [_Object2World]
Matrix 16 [_LightMatrix0]
Vector 25 [_LightColor0]
Float 26 [_DistFade]
Float 27 [_DistFadeVert]
Float 28 [_MinLight]
"vs_3_0
; 126 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord6 o8
dcl_texcoord7 o9
dcl_texcoord8 o10
def c29, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c30, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c29.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r3, r2, v0
dp4 r2.z, r3, c7
dp3 r0.z, c2, c2
rsq r2.w, r0.z
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
dp4 r0.z, r3, c6
mov r0.w, r2.z
mul r3.xyz, r2.w, c2
mul r4.xyz, r0.xyww, c30.y
mov o0, r0
mul r4.y, r4, c22.x
mad o10.xy, r4.z, c23.zwzw, r4
mad r4.xy, v3, c29.z, c29.w
mov r4.w, v0
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.z, r4.y, -r4.y
slt r0.y, -r4, r4
sub r2.w, r0.y, r0.z
mul r0.z, r4.x, r0.x
mul r3.w, r0.x, r2
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r3
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r2, r5
slt r4.z, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.z
mul r0.x, r4, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2.w, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r2, r5.zwzw
mad o4.xy, r0, c30.x, c30.y
dp4 r0.z, r1, c14
dp4 r0.x, r1, c12
dp4 r0.y, r1, c13
add r0.xyz, -r0, c21
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
mul r4.x, r4, r1.y
sub r0.w, r0, r1.x
mul r1.z, r2.w, r0.w
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
mov r0.w, c29.x
dp4 r1.z, r0, c14
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c30.x, c30.y
dp4 r1.y, r0, c13
dp4 r1.x, r0, c12
dp3 r0.x, r1, r1
rsq r0.w, r0.x
dp4 r0.y, c24, c24
rsq r0.y, r0.y
mul r0.xyz, r0.y, c24
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
add r0.w, r0, c30.z
mov r0.z, c14.w
mov r0.x, c12.w
mov r0.y, c13.w
add r0.xyz, -r0, c21
dp3 r0.x, r0, r0
mul r0.y, r0.w, c25.w
mov r0.z, c28.x
add r1.xyz, c25, r0.z
mul_sat r0.w, r0.y, c30
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c27.x
mad_sat o7.xyz, r1, r0.w, c20
dp4 r0.w, v0, c15
dp4 r0.z, v0, c14
add_sat r0.y, r0, c29
mul_sat r0.x, r0, c26
mul r0.x, r0, r0.y
mul o1.w, v1, r0.x
dp4 r0.x, v0, c12
dp4 r0.y, v0, c13
dp4 o8.w, r0, c19
dp4 o8.z, r0, c18
dp4 o8.y, r0, c17
dp4 o8.x, r0, c16
dp4 o9.w, r0, c11
dp4 o9.z, r0, c10
dp4 o9.y, r0, c9
dp4 o9.x, r0, c8
dp4 r0.x, v0, c2
mad o3.xy, r5, c30.x, c30.y
mov o10.w, r2.z
mov o1.xyz, v1
abs o2.xyz, r3
mov o10.z, -r0.x
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 224 // 208 used size, 11 vars
Matrix 80 [_LightMatrix0] 4
Vector 144 [_LightColor0] 4
Float 192 [_DistFade]
Float 196 [_DistFadeVert]
Float 204 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityShadows" 416 // 384 used size, 8 vars
Matrix 128 [unity_World2Shadow0] 4
Matrix 192 [unity_World2Shadow1] 4
Matrix 256 [unity_World2Shadow2] 4
Matrix 320 [unity_World2Shadow3] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Matrix 0 [glstate_matrix_projection] 4
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityShadows" 3
BindCB "UnityPerDraw" 4
BindCB "UnityPerFrame" 5
// 104 instructions, 6 temp regs, 0 temp arrays:
// ALU 82 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmdioemjnngegpbenememnoaedeajdoeeabaaaaaajebaaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
cmabaaaaalaaaaaaaiaaaaaabaabaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaabmabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaccabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaccabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaccabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaccabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaccabaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaccabaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaccabaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaaccabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaaccabaaaa
aiaaaaaaaaaaaaaaadaaaaaaajaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefchmaoaaaaeaaaabaajpadaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaamaaaaaa
fjaaaaaeegiocaaaaeaaaaaabaaaaaaafjaaaaaeegiocaaaafaaaaaaafaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
gfaaaaadpccabaaaaiaaaaaagfaaaaadpccabaaaajaaaaaagiaaaaacagaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaahaaaaaapgbpbaaaaaaaaaaa
egbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
afaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaafaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
afaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaafaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaaegiccaaaaeaaaaaaapaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaackaabaaaaaaaaaaa
akiacaaaaaaaaaaaamaaaaaadccaaaalecaabaaaaaaaaaaabkiacaiaebaaaaaa
aaaaaaaaamaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadgaaaaagbcaabaaa
abaaaaaackiacaaaaeaaaaaaaeaaaaaadgaaaaagccaabaaaabaaaaaackiacaaa
aeaaaaaaafaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaaeaaaaaaagaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaghccabaaaacaaaaaaegacbaiaibaaaaaa
abaaaaaadbaaaaalhcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadbaaaaalhcaabaaaadaaaaaaegacbaia
ebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
hcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaadaaaaaadcaaaaap
dcaabaaaadaaaaaaegbabaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
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
acaaaaaafgafbaaaacaaaaaaagiecaaaaeaaaaaaafaaaaaadcaaaaakkcaabaaa
acaaaaaaagiecaaaaeaaaaaaaeaaaaaapgapbaaaabaaaaaafganbaaaacaaaaaa
dcaaaaakkcaabaaaacaaaaaaagiecaaaaeaaaaaaagaaaaaafgafbaaaadaaaaaa
fganbaaaacaaaaaadcaaaaapmccabaaaadaaaaaafganbaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaajkjjbjdpjkjjbjdpaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpdiaaaaaikcaabaaaacaaaaaafgafbaaaadaaaaaaagiecaaaaeaaaaaa
afaaaaaadcaaaaakgcaabaaaadaaaaaaagibcaaaaeaaaaaaaeaaaaaaagaabaaa
acaaaaaafgahbaaaacaaaaaadcaaaaakkcaabaaaabaaaaaaagiecaaaaeaaaaaa
agaaaaaafgafbaaaabaaaaaafgajbaaaadaaaaaadcaaaaapdccabaaaadaaaaaa
ngafbaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaabaaaaaadbaaaaahccaabaaaabaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaabaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadbaaaaahccaabaaa
abaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaakdcaabaaaacaaaaaaegiacaaa
aeaaaaaaaeaaaaaakgakbaaaaaaaaaaangafbaaaacaaaaaaboaaaaaiecaabaaa
aaaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaacgaaaaaiaanaaaaa
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaaclaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaackaabaaaaeaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
aeaaaaaaagaaaaaakgakbaaaaaaaaaaaegaabaaaacaaaaaadcaaaaapdccabaaa
aeaaaaaaegaabaaaabaaaaaaaceaaaaajkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaa
egiccaiaebaaaaaaaeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhccabaaaafaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
acaaaaaaegiccaaaaeaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aeaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaeaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaabbaaaaajecaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabacaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaapnekibdpdiaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaadicaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaajhcaabaaaabaaaaaa
egiccaaaaaaaaaaaajaaaaaapgipcaaaaaaaaaaaamaaaaaadccaaaakhccabaaa
agaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaafaaaaaaaeaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaaeaaaaaaanaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aeaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaa
acaaaaaafgafbaaaabaaaaaaegiocaaaaaaaaaaaagaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaaafaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaahaaaaaakgakbaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpccabaaaahaaaaaaegiocaaaaaaaaaaaaiaaaaaa
pgapbaaaabaaaaaaegaobaaaacaaaaaadiaaaaaipcaabaaaacaaaaaafgafbaaa
abaaaaaaegiocaaaadaaaaaaajaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
adaaaaaaaiaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaadaaaaaaakaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpccabaaaaiaaaaaaegiocaaaadaaaaaaalaaaaaapgapbaaaabaaaaaa
egaobaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaajaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaajaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaaeaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaaeaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
aeaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
ajaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
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
#line 438
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
    highp vec4 projPos;
};
#line 429
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 453
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 453
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 457
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 461
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 465
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 469
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 473
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 477
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 481
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 485
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 489
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    #line 493
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 498
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
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
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
#line 340
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 438
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
    highp vec4 projPos;
};
#line 429
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 453
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 500
lowp vec4 frag( in v2f i ) {
    #line 502
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 506
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 510
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 514
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 518
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
in highp vec4 xlv_TEXCOORD8;
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
    xlt_i.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
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
uniform mat4 _LightMatrix0;


uniform mat4 _Object2World;

uniform vec4 _LightPositionRange;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
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
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
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
  vec4 o_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_8 * 0.5);
  vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform vec4 _ZBufferParams;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
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
Vector 16 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [_ScreenParams]
Vector 20 [_WorldSpaceLightPos0]
Vector 21 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Vector 22 [_LightColor0]
Float 23 [_DistFade]
Float 24 [_DistFadeVert]
Float 25 [_MinLight]
"vs_3_0
; 122 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord6 o8
dcl_texcoord7 o9
dcl_texcoord8 o10
def c26, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c27, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c26.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r3, r2, v0
dp4 r2.z, r3, c7
dp3 r0.z, c2, c2
rsq r2.w, r0.z
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
dp4 r0.z, r3, c6
mov r0.w, r2.z
mul r3.xyz, r2.w, c2
mul r4.xyz, r0.xyww, c27.y
mov o0, r0
mul r4.y, r4, c18.x
mad o10.xy, r4.z, c19.zwzw, r4
mad r4.xy, v3, c26.z, c26.w
mov r4.w, v0
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.z, r4.y, -r4.y
slt r0.y, -r4, r4
sub r2.w, r0.y, r0.z
mul r0.z, r4.x, r0.x
mul r3.w, r0.x, r2
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r3
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r2, r5
slt r4.z, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.z
mul r0.x, r4, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2.w, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r2, r5.zwzw
mad o4.xy, r0, c27.x, c27.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c17
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
mul r4.x, r4, r1.y
sub r0.w, r0, r1.x
mul r1.z, r2.w, r0.w
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
mov r0.w, c26.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c27.x, c27.y
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
dp3 r0.x, r1, r1
rsq r0.w, r0.x
dp4 r0.y, c20, c20
rsq r0.y, r0.y
mul r0.xyz, r0.y, c20
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
add r0.w, r0, c27.z
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c17
dp3 r0.x, r0, r0
mul r0.y, r0.w, c22.w
mov r0.z, c25.x
add r1.xyz, c22, r0.z
mul_sat r0.w, r0.y, c27
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c24.x
mad_sat o7.xyz, r1, r0.w, c16
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
add_sat r0.y, r0, c26
mul_sat r0.x, r0, c23
mul r0.x, r0, r0.y
mul o1.w, v1, r0.x
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.z, r0, c14
dp4 o8.y, r0, c13
dp4 o8.x, r0, c12
dp4 r0.w, v0, c2
mad o3.xy, r5, c27.x, c27.y
mov o10.w, r2.z
mov o1.xyz, v1
abs o2.xyz, r3
add o9.xyz, r0, -c21
mov o10.z, -r0.w
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Matrix 16 [_LightMatrix0] 4
Vector 80 [_LightColor0] 4
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 32 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
Vector 16 [_LightPositionRange] 4
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
// 102 instructions, 6 temp regs, 0 temp arrays:
// ALU 80 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedblconmfkmddjgjdbdekibcfehkkafpclabaaaaaadibaaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
cmabaaaaalaaaaaaaiaaaaaabaabaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaabmabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaccabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaccabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaccabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaccabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaccabaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaccabaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaccabaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaaccabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaahaiaaaaccabaaaa
aiaaaaaaaaaaaaaaadaaaaaaajaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaaoaaaaeaaaabaaiiadaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadhccabaaaahaaaaaagfaaaaadhccabaaaaiaaaaaagfaaaaad
pccabaaaajaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaaaaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadccaaaal
ecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaaiaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpdgcaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahiccabaaa
abaaaaaackaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egbcbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaa
dgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaa
abaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
dbaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaa
acaaaaaaegacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaa
adaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
cgaaaaaiaanaaaaahcaabaaaaeaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaa
claaaaafhcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaa
jgafbaaaabaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaaabaaaaaaagaebaaa
acaaaaaadiaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaaadaaaaaa
dbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
fganbaaaabaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaakgaobaia
ebaaaaaaadaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaa
egaabaaaacaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaa
acaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaabaaaaaa
egaabaaaaeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaaeaaaaaa
pgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaa
adaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdp
aceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaa
fgafbaaaadaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaa
agibcaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaa
adaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaadaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaa
aaaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dcaaaaakdcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaakgakbaaaaaaaaaaa
ngafbaaaacaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaa
ckaabaaaabaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaacaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaa
dcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaakgakbaaaaaaaaaaa
egaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaa
jkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaaj
ecaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaa
kgakbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaknhcdlmdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaapnekibdpdiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaa
aaaaaaaaafaaaaaadicaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaapgipcaaa
aaaaaaaaaiaaaaaadccaaaakhccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaa
aaaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaaaiaaaaaaegacbaaa
abaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaacaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaabaaaaaaagaabaaaacaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaakgakbaaaacaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaaaaaaaaaaaeaaaaaapgapbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaajaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaajaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaajaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
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
#line 434
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
    highp vec4 projPos;
};
#line 425
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 449
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 449
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 453
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 457
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 461
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 465
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 469
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 473
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 477
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 481
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 485
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    #line 489
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    #line 494
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
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
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
#line 336
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 434
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
    highp vec4 projPos;
};
#line 425
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 449
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 496
lowp vec4 frag( in v2f i ) {
    #line 498
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 502
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 506
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 510
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 514
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
in highp vec4 xlv_TEXCOORD8;
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
    xlt_i.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD8;
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
uniform mat4 _LightMatrix0;


uniform mat4 _Object2World;

uniform vec4 _LightPositionRange;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
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
  vec4 tmpvar_8;
  tmpvar_8 = (gl_ProjectionMatrix * (tmpvar_7 + gl_Vertex));
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
  vec4 o_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_8 * 0.5);
  vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_8.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = abs(tmpvar_10);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * ZYv_3).xy - tmpvar_7.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XZv_2).xy - tmpvar_7.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((gl_ModelViewMatrix * XYv_1).xy - tmpvar_7.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_11).xyz));
  xlv_TEXCOORD5 = clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((clamp (dot (normalize((_Object2World * tmpvar_15).xyz), normalize(_WorldSpaceLightPos0).xyz), 0.0, 1.0) - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0);
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD8;
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec2 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_COLOR;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
uniform vec4 _Color;
uniform sampler2D _FrontTex;
uniform sampler2D _LeftTex;
uniform sampler2D _TopTex;
uniform vec4 _ZBufferParams;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (texture2D (_LeftTex, xlv_TEXCOORD1), texture2D (_TopTex, xlv_TEXCOORD2), xlv_TEXCOORD0.yyyy), texture2D (_FrontTex, xlv_TEXCOORD3), xlv_TEXCOORD0.zzzz));
  color_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD5);
  color_1.w = (tmpvar_2.w * clamp ((_InvFade * ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x) + _ZBufferParams.w))) - xlv_TEXCOORD8.z)), 0.0, 1.0));
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
Vector 16 [glstate_lightmodel_ambient]
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [_ScreenParams]
Vector 20 [_WorldSpaceLightPos0]
Vector 21 [_LightPositionRange]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
Vector 22 [_LightColor0]
Float 23 [_DistFade]
Float 24 [_DistFadeVert]
Float 25 [_MinLight]
"vs_3_0
; 122 ALU
dcl_position o0
dcl_color0 o1
dcl_texcoord0 o2
dcl_texcoord1 o3
dcl_texcoord2 o4
dcl_texcoord3 o5
dcl_texcoord4 o6
dcl_texcoord5 o7
dcl_texcoord6 o8
dcl_texcoord7 o9
dcl_texcoord8 o10
def c26, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c27, 0.60000002, 0.50000000, -0.01000214, 4.03944778
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, c26.x
mov r1.w, v0
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
add r3, r2, v0
dp4 r2.z, r3, c7
dp3 r0.z, c2, c2
rsq r2.w, r0.z
dp4 r0.x, r3, c4
dp4 r0.y, r3, c5
dp4 r0.z, r3, c6
mov r0.w, r2.z
mul r3.xyz, r2.w, c2
mul r4.xyz, r0.xyww, c27.y
mov o0, r0
mul r4.y, r4, c18.x
mad o10.xy, r4.z, c19.zwzw, r4
mad r4.xy, v3, c26.z, c26.w
mov r4.w, v0
slt r0.y, -r3.x, r3.x
slt r0.x, r3, -r3
sub r0.x, r0, r0.y
slt r0.z, r4.y, -r4.y
slt r0.y, -r4, r4
sub r2.w, r0.y, r0.z
mul r0.z, r4.x, r0.x
mul r3.w, r0.x, r2
slt r0.w, r0.z, -r0.z
slt r0.y, -r0.z, r0.z
sub r0.y, r0, r0.w
mul r0.w, r3.y, r3
mul r0.x, r0.y, r0
mad r0.x, r3.z, r0, r0.w
mov r0.yw, r4
dp4 r5.y, r0, c1
dp4 r5.x, r0, c0
add r5.xy, -r2, r5
slt r4.z, -r3.y, r3.y
slt r3.w, r3.y, -r3.y
sub r3.w, r3, r4.z
mul r0.x, r4, r3.w
slt r0.z, r0.x, -r0.x
slt r0.y, -r0.x, r0.x
sub r0.y, r0, r0.z
mul r0.z, r2.w, r3.w
mul r0.y, r0, r3.w
mul r3.w, r3.z, r0.z
mov r0.zw, r4.xyyw
mad r0.y, r3.x, r0, r3.w
dp4 r5.z, r0, c0
dp4 r5.w, r0, c1
add r0.xy, -r2, r5.zwzw
mad o4.xy, r0, c27.x, c27.y
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, -r0, c17
slt r1.x, -r3.z, r3.z
slt r0.w, r3.z, -r3.z
sub r1.y, r1.x, r0.w
mul r4.x, r4, r1.y
sub r0.w, r0, r1.x
mul r1.z, r2.w, r0.w
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
mov r0.w, c26.x
dp4 r1.z, r0, c10
dp4 r1.x, r4, c0
dp4 r1.y, r4, c1
add r1.xy, -r2, r1
mad o5.xy, r1, c27.x, c27.y
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
dp3 r0.x, r1, r1
rsq r0.w, r0.x
dp4 r0.y, c20, c20
rsq r0.y, r0.y
mul r0.xyz, r0.y, c20
mul r1.xyz, r0.w, r1
dp3_sat r0.w, r1, r0
add r0.w, r0, c27.z
mov r0.z, c10.w
mov r0.x, c8.w
mov r0.y, c9.w
add r0.xyz, -r0, c17
dp3 r0.x, r0, r0
mul r0.y, r0.w, c22.w
mov r0.z, c25.x
add r1.xyz, c22, r0.z
mul_sat r0.w, r0.y, c27
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, -r0.x, c24.x
mad_sat o7.xyz, r1, r0.w, c16
dp4 r0.w, v0, c11
dp4 r0.z, v0, c10
add_sat r0.y, r0, c26
mul_sat r0.x, r0, c23
mul r0.x, r0, r0.y
mul o1.w, v1, r0.x
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 o8.z, r0, c14
dp4 o8.y, r0, c13
dp4 o8.x, r0, c12
dp4 r0.w, v0, c2
mad o3.xy, r5, c27.x, c27.y
mov o10.w, r2.z
mov o1.xyz, v1
abs o2.xyz, r3
add o9.xyz, r0, -c21
mov o10.z, -r0.w
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160 // 144 used size, 10 vars
Matrix 16 [_LightMatrix0] 4
Vector 80 [_LightColor0] 4
Float 128 [_DistFade]
Float 132 [_DistFadeVert]
Float 140 [_MinLight]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 32 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
Vector 16 [_LightPositionRange] 4
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
// 102 instructions, 6 temp regs, 0 temp arrays:
// ALU 80 float, 8 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedblconmfkmddjgjdbdekibcfehkkafpclabaaaaaadibaaaaaadaaaaaa
cmaaaaaanmaaaaaabaacaaaaejfdeheokiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaijaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaipaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaajgaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajoaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafaepfdejfeejepeoaaedepem
epfcaaeoepfcenebemaafeebeoehefeofeaafeeffiedepepfceeaaklepfdeheo
cmabaaaaalaaaaaaaiaaaaaabaabaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaabmabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaccabaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaccabaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaaccabaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amadaaaaccabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaaccabaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaccabaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaccabaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaaccabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaahaiaaaaccabaaaa
aiaaaaaaaaaaaaaaadaaaaaaajaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaaoaaaaeaaaabaaiiadaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaa
fjaaaaaeegiocaaaaeaaaaaaafaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaa
agaaaaaagfaaaaadhccabaaaahaaaaaagfaaaaadhccabaaaaiaaaaaagfaaaaad
pccabaaaajaaaaaagiaaaaacagaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaahaaaaaapgbpbaaaaaaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaaeaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaeaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaeaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaeaaaaaaadaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaaaaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaaapaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadccaaaal
ecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaaiaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpdgcaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahiccabaaa
abaaaaaackaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egbcbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaaaeaaaaaa
dgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaaafaaaaaadgaaaaagecaabaaa
abaaaaaackiacaaaadaaaaaaagaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaag
hccabaaaacaaaaaaegacbaiaibaaaaaaabaaaaaadbaaaaalhcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
dbaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaa
acaaaaaaegacbaaaadaaaaaadcaaaaapdcaabaaaadaaaaaaegbabaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaa
adaaaaaadbaaaaahicaabaaaabaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaaaa
boaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
cgaaaaaiaanaaaaahcaabaaaaeaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaa
claaaaafhcaabaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaa
jgafbaaaabaaaaaaegacbaaaaeaaaaaaclaaaaafkcaabaaaabaaaaaaagaebaaa
acaaaaaadiaaaaahkcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaaadaaaaaa
dbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
fganbaaaabaaaaaadbaaaaakdcaabaaaafaaaaaangafbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaadaaaaaakgaobaia
ebaaaaaaadaaaaaaagaebaaaafaaaaaacgaaaaaiaanaaaaadcaabaaaacaaaaaa
egaabaaaacaaaaaaogakbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaa
acaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaacaaaaaacgakbaaaabaaaaaa
egaabaaaaeaaaaaadiaaaaaikcaabaaaacaaaaaafgafbaaaacaaaaaaagiecaaa
adaaaaaaafaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaaadaaaaaaaeaaaaaa
pgapbaaaabaaaaaafganbaaaacaaaaaadcaaaaakkcaabaaaacaaaaaaagiecaaa
adaaaaaaagaaaaaafgafbaaaadaaaaaafganbaaaacaaaaaadcaaaaapmccabaaa
adaaaaaafganbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaajkjjbjdpjkjjbjdp
aceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaaikcaabaaaacaaaaaa
fgafbaaaadaaaaaaagiecaaaadaaaaaaafaaaaaadcaaaaakgcaabaaaadaaaaaa
agibcaaaadaaaaaaaeaaaaaaagaabaaaacaaaaaafgahbaaaacaaaaaadcaaaaak
kcaabaaaabaaaaaaagiecaaaadaaaaaaagaaaaaafgafbaaaabaaaaaafgajbaaa
adaaaaaadcaaaaapdccabaaaadaaaaaangafbaaaabaaaaaaaceaaaaajkjjbjdp
jkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaadbaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaaclaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaadaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaa
aaaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dcaaaaakdcaabaaaacaaaaaaegiacaaaadaaaaaaaeaaaaaakgakbaaaaaaaaaaa
ngafbaaaacaaaaaaboaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaa
ckaabaaaabaaaaaacgaaaaaiaanaaaaaecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaacaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaeaaaaaa
dcaaaaakdcaabaaaabaaaaaaegiacaaaadaaaaaaagaaaaaakgakbaaaaaaaaaaa
egaabaaaacaaaaaadcaaaaapdccabaaaaeaaaaaaegaabaaaabaaaaaaaceaaaaa
jkjjbjdpjkjjbjdpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhccabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaabbaaaaaj
ecaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaa
kgakbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabacaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaknhcdlmdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaapnekibdpdiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaadkiacaaa
aaaaaaaaafaaaaaadicaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiaeaaaaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaafaaaaaapgipcaaa
aaaaaaaaaiaaaaaadccaaaakhccabaaaagaaaaaaegacbaaaabaaaaaakgakbaaa
aaaaaaaaegiccaaaaeaaaaaaaeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaaaiaaaaaaegacbaaa
abaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaacaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaabaaaaaaagaabaaaacaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaakgakbaaaacaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaaaaaaaaaaaeaaaaaapgapbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaajaaaaaa
dkaabaaaaaaaaaaaaaaaaaahdccabaaaajaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
eccabaaaajaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD8;
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
uniform highp mat4 _LightMatrix0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
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
  highp vec4 tmpvar_12;
  tmpvar_12 = (glstate_matrix_projection * (tmpvar_11 + _glesVertex));
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
  highp vec4 o_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_30.x;
  tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
  o_29.xy = (tmpvar_31 + tmpvar_30.w);
  o_29.zw = tmpvar_12.zw;
  tmpvar_9.xyw = o_29.xyw;
  tmpvar_9.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_12;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD0 = abs(tmpvar_14);
  xlv_TEXCOORD1 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * ZYv_6).xy - tmpvar_11.xy)));
  xlv_TEXCOORD2 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XZv_5).xy - tmpvar_11.xy)));
  xlv_TEXCOORD3 = (vec2(0.5, 0.5) + (0.6 * ((glstate_matrix_modelview0 * XYv_4).xy - tmpvar_11.xy)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - (_Object2World * tmpvar_15).xyz));
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD7 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD8 = tmpvar_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD8;
varying mediump vec3 xlv_TEXCOORD5;
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
  highp float depth_2;
  mediump vec4 color_3;
  mediump vec4 ztex_4;
  mediump float zval_5;
  mediump vec4 ytex_6;
  mediump float yval_7;
  mediump vec4 xtex_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LeftTex, xlv_TEXCOORD1);
  xtex_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  yval_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_TopTex, xlv_TEXCOORD2);
  ytex_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD0.z;
  zval_5 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_FrontTex, xlv_TEXCOORD3);
  ztex_4 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (((0.94 * _Color) * xlv_COLOR) * mix (mix (xtex_8, ytex_6, vec4(yval_7)), ztex_4, vec4(zval_5)));
  color_3.xyz = (tmpvar_14.xyz * xlv_TEXCOORD5);
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD8).x;
  depth_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (1.0/(((_ZBufferParams.z * depth_2) + _ZBufferParams.w)));
  depth_2 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_14.w * clamp ((_InvFade * (tmpvar_16 - xlv_TEXCOORD8.z)), 0.0, 1.0));
  color_3.w = tmpvar_17;
  tmpvar_1 = color_3;
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
#line 435
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
    highp vec4 projPos;
};
#line 426
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 450
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 450
v2f vert( in appdata_t v ) {
    highp vec4 mvCenter = (glstate_matrix_modelview0 * vec4( 0.0, 0.0, 0.0, v.vertex.w));
    v2f o;
    #line 454
    o.pos = (glstate_matrix_projection * (mvCenter + vec4( v.vertex.x, v.vertex.y, v.vertex.z, v.vertex.w)));
    highp vec3 viewDir = normalize(xll_matrixindex_mf4x4_i (glstate_matrix_modelview0, 2).xyz);
    o.viewDir = abs(viewDir);
    o.camPos = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vec4( 0.0, 0.0, 0.0, v.vertex.w)).xyz));
    #line 458
    highp vec2 texcoodOffsetxy = ((2.0 * v.texcoord) - 1.0);
    highp vec4 texcoordOffset = vec4( texcoodOffsetxy.x, texcoodOffsetxy.y, 0.0, v.vertex.w);
    highp vec4 ZYv = texcoordOffset.zyxw;
    highp vec4 XZv = texcoordOffset.xzyw;
    #line 462
    highp vec4 XYv = texcoordOffset.xyzw;
    ZYv.z *= sign((-viewDir.x));
    XZv.x *= sign((-viewDir.y));
    XYv.x *= sign(viewDir.z);
    #line 466
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.z)) * viewDir.z);
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.x)) * viewDir.x);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.x)) * viewDir.x);
    ZYv.x += ((sign((-viewDir.x)) * sign(ZYv.y)) * viewDir.y);
    #line 470
    XZv.y += ((sign((-viewDir.y)) * sign(XZv.z)) * viewDir.z);
    XYv.z += ((sign((-viewDir.z)) * sign(XYv.y)) * viewDir.y);
    highp vec2 ZY = ((glstate_matrix_modelview0 * ZYv).xy - mvCenter.xy);
    highp vec2 XZ = ((glstate_matrix_modelview0 * XZv).xy - mvCenter.xy);
    #line 474
    highp vec2 XY = ((glstate_matrix_modelview0 * XYv).xy - mvCenter.xy);
    o.texcoordZY = (vec2( 0.5, 0.5) + (0.6 * ZY));
    o.texcoordXZ = (vec2( 0.5, 0.5) + (0.6 * XZ));
    o.texcoordXY = (vec2( 0.5, 0.5) + (0.6 * XY));
    #line 478
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp vec3 worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 482
    mediump float NdotL = xll_saturate_f(dot( worldNormal, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    mediump float lightIntensity = xll_saturate_f(((_LightColor0.w * diff) * 4.0));
    o.baseLight = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 486
    o.color = v.color;
    highp float dist = (_DistFade * distance( origin, _WorldSpaceCameraPos));
    highp float distVert = (1.0 - (_DistFadeVert * distance( origin, _WorldSpaceCameraPos)));
    o.color.w *= (xll_saturate_f(dist) * xll_saturate_f(distVert));
    #line 490
    o.projPos = ComputeScreenPos( o.pos);
    o.projPos.z = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    #line 495
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
out highp vec4 xlv_TEXCOORD8;
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
    xlv_TEXCOORD8 = vec4(xl_retval.projPos);
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
#line 337
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
    highp vec3 camPos;
    mediump vec3 baseLight;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec4 projPos;
};
#line 426
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
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
#line 450
#line 280
highp float LinearEyeDepth( in highp float z ) {
    #line 282
    return (1.0 / ((_ZBufferParams.z * z) + _ZBufferParams.w));
}
#line 497
lowp vec4 frag( in v2f i ) {
    #line 499
    mediump float xval = i.viewDir.x;
    mediump vec4 xtex = texture( _LeftTex, i.texcoordZY);
    mediump float yval = i.viewDir.y;
    mediump vec4 ytex = texture( _TopTex, i.texcoordXZ);
    #line 503
    mediump float zval = i.viewDir.z;
    mediump vec4 ztex = texture( _FrontTex, i.texcoordXY);
    mediump vec4 tex = mix( mix( xtex, ytex, vec4( yval)), ztex, vec4( zval));
    mediump vec4 prev = (((0.94 * _Color) * i.color) * tex);
    #line 507
    mediump vec4 color;
    color.xyz = (prev.xyz * i.baseLight);
    color.w = prev.w;
    highp float depth = textureProj( _CameraDepthTexture, i.projPos).x;
    #line 511
    depth = LinearEyeDepth( depth);
    highp float partZ = i.projPos.z;
    highp float fade = xll_saturate_f((_InvFade * (depth - partZ)));
    color.w *= fade;
    #line 515
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
in highp vec4 xlv_TEXCOORD8;
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
    xlt_i.projPos = vec4(xlv_TEXCOORD8);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 15
//   d3d9 - ALU: 13 to 13, TEX: 4 to 4
//   d3d11 - ALU: 14 to 14, TEX: 4 to 4, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
texldp r2.x, v6, s3
mad r2.x, r2, c0.z, c0.w
rcp r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c1
mul_pp r0, r0, r1
mul_pp r0, r0, c3.x
add r2.x, r2, -v6.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
ConstBuffer "$Globals" 160 // 148 used size, 10 vars
Vector 112 [_Color] 4
Float 144 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 21 instructions, 3 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedbnoehmialcfiahdilbajpbneodkafgdhabaaaaaabeafaaaaadaaaaaa
cmaaaaaaeiabaaaahmabaaaaejfdeheobeabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaakabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaakabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaakabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaakabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaakabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaakabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaakabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaaakabaaaaaiaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
jaadaaaaeaaaaaaaoeaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaae
egiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaadmcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaa
agaaaaaagcbaaaadpcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaaiaaaaaapgbpbaaaaiaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
aaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaackbabaiaebaaaaaaaiaaaaaadicaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadgaaaaafhcaabaaaacaaaaaaegbcbaaaagaaaaaadgaaaaaf
icaabaaaacaaaaaaabeaaaaanhkdhadpdiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaabaaaaaadiaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaa
nhkdhadpnhkdhadpnhkdhadpaaaaaaaadoaaaaab"
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
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
texldp r2.x, v6, s3
mad r2.x, r2, c0.z, c0.w
rcp r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c1
mul_pp r0, r0, r1
mul_pp r0, r0, c3.x
add r2.x, r2, -v6.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
ConstBuffer "$Globals" 96 // 84 used size, 9 vars
Vector 48 [_Color] 4
Float 80 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 21 instructions, 3 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfcconhhcefjfmkpllkekcdiapajjkcpiabaaaaaapmaeaaaaadaaaaaa
cmaaaaaadaabaaaageabaaaaejfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaapcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaapcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaapcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaapcaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaapcaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaapcaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaapcaaaaaa
aiaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcjaadaaaaeaaaaaaaoeaaaaaafjaaaaaeegiocaaaaaaaaaaa
agaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
adaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadgcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaa
gcbaaaadhcbabaaaagaaaaaagcbaaaadpcbabaaaahaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaahaaaaaa
pgbpbaaaahaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackbabaiaebaaaaaaahaaaaaa
dicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaia
ebaaaaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaia
ebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaa
egbobaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadgaaaaafhcaabaaaacaaaaaaegbcbaaa
agaaaaaadgaaaaaficaabaaaacaaaaaaabeaaaaanhkdhadpdiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaahiccabaaaaaaaaaaa
akaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaakhccabaaaaaaaaaaaegacbaaa
abaaaaaaaceaaaaanhkdhadpnhkdhadpnhkdhadpaaaaaaaadoaaaaab"
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
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
texldp r2.x, v6, s3
mad r2.x, r2, c0.z, c0.w
rcp r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c1
mul_pp r0, r0, r1
mul_pp r0, r0, c3.x
add r2.x, r2, -v6.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
ConstBuffer "$Globals" 160 // 148 used size, 10 vars
Vector 112 [_Color] 4
Float 144 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 21 instructions, 3 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedncgoagcnjjbihmkokejmbkeefolflidjabaaaaaabeafaaaaadaaaaaa
cmaaaaaaeiabaaaahmabaaaaejfdeheobeabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaakabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaakabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaakabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaakabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaakabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaakabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaakabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaakabaaaaaiaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
jaadaaaaeaaaaaaaoeaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaae
egiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaadmcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaa
agaaaaaagcbaaaadpcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaaiaaaaaapgbpbaaaaiaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
aaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaackbabaiaebaaaaaaaiaaaaaadicaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadgaaaaafhcaabaaaacaaaaaaegbcbaaaagaaaaaadgaaaaaf
icaabaaaacaaaaaaabeaaaaanhkdhadpdiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaabaaaaaadiaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaa
nhkdhadpnhkdhadpnhkdhadpaaaaaaaadoaaaaab"
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
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
texldp r2.x, v6, s3
mad r2.x, r2, c0.z, c0.w
rcp r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c1
mul_pp r0, r0, r1
mul_pp r0, r0, c3.x
add r2.x, r2, -v6.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
ConstBuffer "$Globals" 160 // 148 used size, 10 vars
Vector 112 [_Color] 4
Float 144 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 21 instructions, 3 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedbnoehmialcfiahdilbajpbneodkafgdhabaaaaaabeafaaaaadaaaaaa
cmaaaaaaeiabaaaahmabaaaaejfdeheobeabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaakabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaakabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaakabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaakabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaakabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaakabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaakabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaaakabaaaaaiaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
jaadaaaaeaaaaaaaoeaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaae
egiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaadmcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaa
agaaaaaagcbaaaadpcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaaiaaaaaapgbpbaaaaiaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
aaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaackbabaiaebaaaaaaaiaaaaaadicaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadgaaaaafhcaabaaaacaaaaaaegbcbaaaagaaaaaadgaaaaaf
icaabaaaacaaaaaaabeaaaaanhkdhadpdiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaabaaaaaadiaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaa
nhkdhadpnhkdhadpnhkdhadpaaaaaaaadoaaaaab"
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
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
texldp r2.x, v6, s3
mad r2.x, r2, c0.z, c0.w
rcp r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c1
mul_pp r0, r0, r1
mul_pp r0, r0, c3.x
add r2.x, r2, -v6.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
ConstBuffer "$Globals" 160 // 148 used size, 10 vars
Vector 112 [_Color] 4
Float 144 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 21 instructions, 3 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjfckbkncanpajeomfmjlgnaohhbhnaimabaaaaaabeafaaaaadaaaaaa
cmaaaaaaeiabaaaahmabaaaaejfdeheobeabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaakabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaakabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaakabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaakabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaakabaaaaagaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
amaaaaaaakabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaaaaaaakabaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaakabaaaaaiaaaaaaaaaaaaaa
adaaaaaaahaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
jaadaaaaeaaaaaaaoeaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaae
egiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaadmcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaa
agaaaaaagcbaaaadpcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaahaaaaaapgbpbaaaahaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
aaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaackbabaiaebaaaaaaahaaaaaadicaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadgaaaaafhcaabaaaacaaaaaaegbcbaaaagaaaaaadgaaaaaf
icaabaaaacaaaaaaabeaaaaanhkdhadpdiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaabaaaaaadiaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaa
nhkdhadpnhkdhadpnhkdhadpaaaaaaaadoaaaaab"
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
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
texldp r2.x, v6, s3
mad r2.x, r2, c0.z, c0.w
rcp r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c1
mul_pp r0, r0, r1
mul_pp r0, r0, c3.x
add r2.x, r2, -v6.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
ConstBuffer "$Globals" 160 // 148 used size, 10 vars
Vector 112 [_Color] 4
Float 144 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 21 instructions, 3 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedmggheheimdmlakfbeobpfkdinckpggmnabaaaaaacmafaaaaadaaaaaa
cmaaaaaagaabaaaajeabaaaaejfdeheocmabaaaaalaaaaaaaiaaaaaabaabaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaabmabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaccabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaccabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaccabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaccabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaccabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaccabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaccabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaccabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapaaaaaaccabaaaaaiaaaaaaaaaaaaaaadaaaaaaajaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaadaaaaeaaaaaaa
oeaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaad
pcbabaaaajaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaajaaaaaapgbpbaaaajaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaiaebaaaaaaajaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
ahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
dgaaaaafhcaabaaaacaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaacaaaaaa
abeaaaaanhkdhadpdiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaaaaadoaaaaab"
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
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
texldp r2.x, v6, s3
mad r2.x, r2, c0.z, c0.w
rcp r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c1
mul_pp r0, r0, r1
mul_pp r0, r0, c3.x
add r2.x, r2, -v6.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
ConstBuffer "$Globals" 160 // 148 used size, 10 vars
Vector 112 [_Color] 4
Float 144 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 21 instructions, 3 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedmggheheimdmlakfbeobpfkdinckpggmnabaaaaaacmafaaaaadaaaaaa
cmaaaaaagaabaaaajeabaaaaejfdeheocmabaaaaalaaaaaaaiaaaaaabaabaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaabmabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaccabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaccabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaccabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaccabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaccabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaccabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaccabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaccabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapaaaaaaccabaaaaaiaaaaaaaaaaaaaaadaaaaaaajaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaadaaaaeaaaaaaa
oeaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaad
pcbabaaaajaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaajaaaaaapgbpbaaaajaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaiaebaaaaaaajaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
ahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
dgaaaaafhcaabaaaacaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaacaaaaaa
abeaaaaanhkdhadpdiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaaaaadoaaaaab"
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
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
texldp r2.x, v6, s3
mad r2.x, r2, c0.z, c0.w
rcp r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c1
mul_pp r0, r0, r1
mul_pp r0, r0, c3.x
add r2.x, r2, -v6.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 160 // 148 used size, 10 vars
Vector 112 [_Color] 4
Float 144 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 21 instructions, 3 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedncgoagcnjjbihmkokejmbkeefolflidjabaaaaaabeafaaaaadaaaaaa
cmaaaaaaeiabaaaahmabaaaaejfdeheobeabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaakabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaakabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaakabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaakabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaakabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaakabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaakabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaakabaaaaaiaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefc
jaadaaaaeaaaaaaaoeaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaae
egiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaadmcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaa
agaaaaaagcbaaaadpcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaaiaaaaaapgbpbaaaaiaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
aaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaackbabaiaebaaaaaaaiaaaaaadicaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadgaaaaafhcaabaaaacaaaaaaegbcbaaaagaaaaaadgaaaaaf
icaabaaaacaaaaaaabeaaaaanhkdhadpdiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaabaaaaaadiaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaa
nhkdhadpnhkdhadpnhkdhadpaaaaaaaadoaaaaab"
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
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
texldp r2.x, v6, s3
mad r2.x, r2, c0.z, c0.w
rcp r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c1
mul_pp r0, r0, r1
mul_pp r0, r0, c3.x
add r2.x, r2, -v6.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 224 // 212 used size, 11 vars
Vector 176 [_Color] 4
Float 208 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 21 instructions, 3 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedagfllgikhcffepeeabpdjanleamjpinbabaaaaaacmafaaaaadaaaaaa
cmaaaaaagaabaaaajeabaaaaejfdeheocmabaaaaalaaaaaaaiaaaaaabaabaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaabmabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaccabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaccabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaccabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaccabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaccabaaaaagaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
amaaaaaaccabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaaaaaaccabaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaccabaaaaahaaaaaaaaaaaaaa
adaaaaaaahaaaaaaapaaaaaaccabaaaaaiaaaaaaaaaaaaaaadaaaaaaaiaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaadaaaaeaaaaaaa
oeaaaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaad
pcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaaiaaaaaapgbpbaaaaiaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaiaebaaaaaaaiaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaanaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
alaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
dgaaaaafhcaabaaaacaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaacaaaaaa
abeaaaaanhkdhadpdiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaaaaadoaaaaab"
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
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
texldp r2.x, v6, s3
mad r2.x, r2, c0.z, c0.w
rcp r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c1
mul_pp r0, r0, r1
mul_pp r0, r0, c3.x
add r2.x, r2, -v6.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
ConstBuffer "$Globals" 160 // 148 used size, 10 vars
Vector 112 [_Color] 4
Float 144 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 21 instructions, 3 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddpblkcdpmabhmjigppabddijjcomhggcabaaaaaacmafaaaaadaaaaaa
cmaaaaaagaabaaaajeabaaaaejfdeheocmabaaaaalaaaaaaaiaaaaaabaabaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaabmabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaccabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaccabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaccabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaccabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaccabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaccabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaccabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaaccabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaahaaaaaaccabaaaaaiaaaaaaaaaaaaaaadaaaaaaajaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaadaaaaeaaaaaaa
oeaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaad
pcbabaaaajaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaajaaaaaapgbpbaaaajaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaiaebaaaaaaajaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
ahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
dgaaaaafhcaabaaaacaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaacaaaaaa
abeaaaaanhkdhadpdiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaaaaadoaaaaab"
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
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
texldp r2.x, v6, s3
mad r2.x, r2, c0.z, c0.w
rcp r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c1
mul_pp r0, r0, r1
mul_pp r0, r0, c3.x
add r2.x, r2, -v6.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
ConstBuffer "$Globals" 160 // 148 used size, 10 vars
Vector 112 [_Color] 4
Float 144 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 21 instructions, 3 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddpblkcdpmabhmjigppabddijjcomhggcabaaaaaacmafaaaaadaaaaaa
cmaaaaaagaabaaaajeabaaaaejfdeheocmabaaaaalaaaaaaaiaaaaaabaabaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaabmabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaccabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaccabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaccabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaccabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaccabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaccabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaccabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaaccabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaahaaaaaaccabaaaaaiaaaaaaaaaaaaaaadaaaaaaajaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaadaaaaeaaaaaaa
oeaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaad
pcbabaaaajaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaajaaaaaapgbpbaaaajaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaiaebaaaaaaajaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
ahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
dgaaaaafhcaabaaaacaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaacaaaaaa
abeaaaaanhkdhadpdiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaaaaadoaaaaab"
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
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
texldp r2.x, v6, s3
mad r2.x, r2, c0.z, c0.w
rcp r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c1
mul_pp r0, r0, r1
mul_pp r0, r0, c3.x
add r2.x, r2, -v6.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 224 // 212 used size, 11 vars
Vector 176 [_Color] 4
Float 208 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 21 instructions, 3 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecednmlbkgocjbiljiiimdkhepmibkpekheeabaaaaaacmafaaaaadaaaaaa
cmaaaaaagaabaaaajeabaaaaejfdeheocmabaaaaalaaaaaaaiaaaaaabaabaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaabmabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaccabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaccabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaccabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaccabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaccabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaccabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaccabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaccabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapaaaaaaccabaaaaaiaaaaaaaaaaaaaaadaaaaaaajaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaadaaaaeaaaaaaa
oeaaaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaad
pcbabaaaajaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaajaaaaaapgbpbaaaajaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaiaebaaaaaaajaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaanaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
alaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
dgaaaaafhcaabaaaacaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaacaaaaaa
abeaaaaanhkdhadpdiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaaaaadoaaaaab"
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
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
texldp r2.x, v6, s3
mad r2.x, r2, c0.z, c0.w
rcp r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c1
mul_pp r0, r0, r1
mul_pp r0, r0, c3.x
add r2.x, r2, -v6.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
ConstBuffer "$Globals" 224 // 212 used size, 11 vars
Vector 176 [_Color] 4
Float 208 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 21 instructions, 3 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecednmlbkgocjbiljiiimdkhepmibkpekheeabaaaaaacmafaaaaadaaaaaa
cmaaaaaagaabaaaajeabaaaaejfdeheocmabaaaaalaaaaaaaiaaaaaabaabaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaabmabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaccabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaccabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaccabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaccabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaccabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaccabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaccabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaccabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaapaaaaaaccabaaaaaiaaaaaaaaaaaaaaadaaaaaaajaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaadaaaaeaaaaaaa
oeaaaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaad
pcbabaaaajaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaajaaaaaapgbpbaaaajaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaiaebaaaaaaajaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaanaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
alaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
dgaaaaafhcaabaaaacaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaacaaaaaa
abeaaaaanhkdhadpdiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaaaaadoaaaaab"
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
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
texldp r2.x, v6, s3
mad r2.x, r2, c0.z, c0.w
rcp r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c1
mul_pp r0, r0, r1
mul_pp r0, r0, c3.x
add r2.x, r2, -v6.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 160 // 148 used size, 10 vars
Vector 112 [_Color] 4
Float 144 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 21 instructions, 3 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddpblkcdpmabhmjigppabddijjcomhggcabaaaaaacmafaaaaadaaaaaa
cmaaaaaagaabaaaajeabaaaaejfdeheocmabaaaaalaaaaaaaiaaaaaabaabaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaabmabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaccabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaccabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaccabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaccabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaccabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaccabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaccabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaaccabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaahaaaaaaccabaaaaaiaaaaaaaaaaaaaaadaaaaaaajaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaadaaaaeaaaaaaa
oeaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaad
pcbabaaaajaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaajaaaaaapgbpbaaaajaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaiaebaaaaaaajaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
ahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
dgaaaaafhcaabaaaacaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaacaaaaaa
abeaaaaanhkdhadpdiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaaaaadoaaaaab"
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
Vector 0 [_ZBufferParams]
Vector 1 [_Color]
Float 2 [_InvFade]
SetTexture 0 [_LeftTex] 2D
SetTexture 1 [_TopTex] 2D
SetTexture 2 [_FrontTex] 2D
SetTexture 3 [_CameraDepthTexture] 2D
"ps_3_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.93994141, 0, 0, 0
dcl_color0 v0
dcl_texcoord0 v1.xyz
dcl_texcoord1 v2.xy
dcl_texcoord2 v3.xy
dcl_texcoord3 v4.xy
dcl_texcoord5 v5.xyz
dcl_texcoord8 v6
texldp r2.x, v6, s3
mad r2.x, r2, c0.z, c0.w
rcp r2.x, r2.x
texld r1, v2, s0
texld r0, v3, s1
add_pp r0, r0, -r1
mad_pp r1, v1.y, r0, r1
texld r0, v4, s2
add_pp r0, r0, -r1
mad_pp r1, v1.z, r0, r1
mul_pp r0, v0, c1
mul_pp r0, r0, r1
mul_pp r0, r0, c3.x
add r2.x, r2, -v6.z
mul_sat r1.x, r2, c2
mul_pp oC0.w, r0, r1.x
mul_pp oC0.xyz, r0, v5
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
ConstBuffer "$Globals" 160 // 148 used size, 10 vars
Vector 112 [_Color] 4
Float 144 [_InvFade]
ConstBuffer "UnityPerCamera" 128 // 128 used size, 8 vars
Vector 112 [_ZBufferParams] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_LeftTex] 2D 1
SetTexture 1 [_TopTex] 2D 0
SetTexture 2 [_FrontTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
// 21 instructions, 3 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddpblkcdpmabhmjigppabddijjcomhggcabaaaaaacmafaaaaadaaaaaa
cmaaaaaagaabaaaajeabaaaaejfdeheocmabaaaaalaaaaaaaiaaaaaabaabaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaabmabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaccabaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahagaaaaccabaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaccabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaccabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaaccabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaccabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaaccabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaaccabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaahaaaaaaccabaaaaaiaaaaaaaaaaaaaaadaaaaaaajaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaadaaaaeaaaaaaa
oeaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadgcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaad
pcbabaaaajaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaajaaaaaapgbpbaaaajaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaiaebaaaaaaajaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaakgbkbaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaaipcaabaaaacaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaa
ahaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
dgaaaaafhcaabaaaacaaaaaaegbcbaaaagaaaaaadgaaaaaficaabaaaacaaaaaa
abeaaaaanhkdhadpdiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaanhkdhadpnhkdhadp
nhkdhadpaaaaaaaadoaaaaab"
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

#LINE 181
 
		}
		
	} 
	
}
}